select * from emp
where sal >= 3000;

select * from emp
where DEPTNO=10;

select empno, ename, sal from emp
where sal <= 1500;

select * from emp where ename = 'FORD';
-- 문자 데이터는 대소문자 구분

select empno, ename, sal from emp
where ename='SMITH';

select hiredate from emp;

select * from emp where hiredate <= '82/01/01';

select ceil(34.5678) from dual;

select floor(34.5678) from dual;

select TRUNC(15.79,1) from dual;

select * from emp
where mod(empno, 2) = 1;