Return-Path: <netdev+bounces-170104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3CA47470
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624F7188869B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE71EB5F9;
	Thu, 27 Feb 2025 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQ6H3nhD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ieKA6gyk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB21EB5C8
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630411; cv=fail; b=Hgglkals1Ws2ZKCP3NeG78VniMIXu1ZDsiVNY7r1vfIbmx2MaDDwsA07pyEpnjOQyvt9uK+qvZ+1Y3dUQ1+aa8ts9FvmFIGeR8XuMAOguUXzv5mMiOxIJVRPZKgnJCfkRQbRcg6m3X2uTGEsW25vw6B4kg4Q/Q3256oN+bmAlD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630411; c=relaxed/simple;
	bh=0kbc7CKMJlm+xG8z8Yd5UhGI94Ajkcsl9/SSgptX0tM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRFRvY344yA9CYJKcMEsCaCD8nH/spHfSYp038LUpRI1rZInKu/veQ2ML6dfffsELK3EARtxJKTwSyIhZJcamIEvAsQmW3RHP69usRV7gPD9bQ5Fz2IK3p/P00VKA/WCBkhlviIkTKoFR5NHU03iVL6m0XrEJWvtsIjPNjuysGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQ6H3nhD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ieKA6gyk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1gJij021508
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iZ5NBE9I70djLF74sN+w6odIO+OfqXLNUweyhByekHQ=; b=
	fQ6H3nhDXQ4UvFdQWmwFezokgJzK8npUOKObGSKLEuoq+gPhdBdbaraddkn4ipJw
	CCEimeaWfXk9VwWxX3obJ+Mzs645tMDBeDAc/rCWvUgK5tpRdYtxj8Sb3cQXSqCr
	xRuf+sc/lfpOJuH33qs2euK1jx54w1GRXL6vuI69AMTY77yj/J3a9cXqbmLP3HXz
	lIPW89CfpyNaiTOQw6WyCbh7Ld7EyWr4i5JIulZjt8tMrbYdQiWYJhwFDFSHC/3B
	+drI0NHrIyYq1Wzs7E0C5j3PqzikaL5C49HurAojce7nC2TSYVR50tZZeKnZyeIr
	zS4nGimejOw1AQkYL4uwbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscandd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2eOKf002697
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51buaaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:26:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yV/FWf+4taAFOSjcFTyE48cH5Afpdqd5O04tZvJN8ZnjFZ+QZsHq07HParugqS90vrRRJK6SyaLNEoVVa4099cJ4Uu+zlq2kAG5kRewz56hdKmp0bSCdFkrnXZEWF9FcUNMrboC/yJMOR/RK9a7HVMjv9GrYdes3VbYdnaHbMCZzplADI+qEQYd2SxE0hM3TtIVmn96GUq1xlfpeKUmjIkz72yd4hyVmG3gCABimo7PFA0SDwTw4fB945ElpfVn6wJnkjF7lCmslEPmfIcsUQmxix0rRTeVKzTsuzLsbAWLNA5TzqvVeaL1b/2Riw2X4UPH/QLSIR+07CwSfvw10VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ5NBE9I70djLF74sN+w6odIO+OfqXLNUweyhByekHQ=;
 b=ZCBdLs9KR9y5/pzRYWEwwNntnFhD4dB162nKznyBT//k3FoXiirKuCN/IoVOtCkR5K9tNRja25+9Hw++GQwvg/krN/vSvwOeCpfTKomAj3IhEaZzy1Col1H2iV+Xsv3e/cDAMXtDJEUSDt30p7DADz8Z+nA5YSCDQsgwZDKY5hVFgU1Vj7K8ie7HcWp+XjG1I8s8La7v3jXwrLsxcWqY6ts2J0bMimOkRL0DmTTDsbWpcV3yqeoGW5eLik560iBamZRLVb1WgNycwfBpRc63ApZNst1jH5Ns5OaWxPv6B5F6bSP+LbNgcuIHA9jGjxyraBkqE9SZartM72K/Zc69hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ5NBE9I70djLF74sN+w6odIO+OfqXLNUweyhByekHQ=;
 b=ieKA6gykazwD5z1e6L0IPlNckxjmcUYhLQv2NjLzLkzDN0/L2ZY/j9OJ65EdZkm0rHGGO1dYijkZgFkJLgns2lEMPn7AuOyXQ9qHwv0ga//neL0/w2xJULl7wL74lrhvLX5n58ci4u5vdAUqGmeQni09c021rhoUW/TUVVVZzwY=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7587.namprd10.prod.outlook.com (2603:10b6:806:376::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:45 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 04:26:45 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH 3/6] net/rds: RDS/TCP does not initiate a connection
Date: Wed, 26 Feb 2025 21:26:35 -0700
Message-ID: <20250227042638.82553-4-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227042638.82553-1-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0137.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::22) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA1PR10MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b73737f-cc27-469a-ca6f-08dd56e6f16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vxdNr+Yza19bNPeQ+/GODWw3IlFc/SkfyleeRnfU7Ggr8Y1khpjgttbrSaq?=
 =?us-ascii?Q?8XVwxXNI/1B8CYCuDNKK5EBfcZ1qvax9nSi9mD+PPeDzf0ovMsuhHsGdDmkP?=
 =?us-ascii?Q?ofev+0WIZHPFC8ukasGZyhuHRvEfyo4qHTGPGEaACR4r73z2Ov6CQq326Y6N?=
 =?us-ascii?Q?rPexMDW6G3laKGgKriBycq3CpUrPBSsa4asNffhG961emCx3zvkzomabUWru?=
 =?us-ascii?Q?PSSQgf4NGVoGUJi3iyJvb/7Hhao8C81aa3UIEdM+LIH5etWxY9H34B/i2EAX?=
 =?us-ascii?Q?Iz1JF7wGPVJXANznLukEhKO917VRrcpGKQMII4UXOuT4RIN3Q+E5Q8OU6DPO?=
 =?us-ascii?Q?Sd4qVhYJevYKXVIKheFbRu4N38Z9q5KnR9meBFzXXtQJ/7epP19JwCKj/jk9?=
 =?us-ascii?Q?6RJvrkej3/y3JvPlSQIaEpsYy6CDoW5rnZy9U9OOJnw0hBca7ACJ0K4qEp+f?=
 =?us-ascii?Q?Y5dac0DwaoYSLPrUnRkTIwduQV6cULf2weIY4BDhbEQpEdLWw4qngyqw/zBM?=
 =?us-ascii?Q?cHUpymTSnqI2YBpn82ri7/WZsVDXKKn0TmwiSu/SdjZrzgaQuJAAxiUozcc9?=
 =?us-ascii?Q?WKiZ/Pzbdkfz1ct11FBQK5PsMXhsd1+52D+XQk355p8cLuPUZvDd6rRnwerg?=
 =?us-ascii?Q?/bXXgnxWYCxE0zcoToptksI8t/v7OLFOus9fy6F5s0+pGoW0iJ7muwai5JPw?=
 =?us-ascii?Q?/hE697XU4eyk0rnnTa6bS7AQ8O33zUC8gKauwCKm7YyLOufRKuhdEA3bgqRj?=
 =?us-ascii?Q?PKpV39awuqoFAPpEtxWMXe34qPXnpsgB/KSfgjWSSOsBMVCDqTcAhcLsRE2C?=
 =?us-ascii?Q?UPHV9LnjYGZUWYzlcqahzomT+Ys/rNq1ViBffQEAd8G1gGLYMjAqJ1bMYlKg?=
 =?us-ascii?Q?HNyp0xmy9wvG5m/ZqaWIhVCU2u8OmKJ31UkxccCSb0kghUcHGSY0Wd169Hxj?=
 =?us-ascii?Q?p1KnQzCn3HM3Q7uBmOJrS1Jdr7dtG098T+v76cQu3zgMDm/hu8SoVZE3+wWI?=
 =?us-ascii?Q?TeyI4fvWU0aKWAP4E4RnZLX7pXYZsYcNBwdXaDYP1rcctD2x5dKCyiLW9MzW?=
 =?us-ascii?Q?pbID8YwvVCYUgecGL6y/nEuWdy7YdH6UNyE1a4+xCCLMMiBVNKC0jvEFrFl4?=
 =?us-ascii?Q?GEgoDFouJvd/YOmDIEaY5pxDHE7WljfpKp65+1fcLUU1C4hUUYsJfHT5gX87?=
 =?us-ascii?Q?z5cAdRND1pGfQlbCHAMaf3bg/2N9BlvbWow9o7BStLxTo9G+BApUsj7Iy8r6?=
 =?us-ascii?Q?ciufeVqurrgGnN16XYHwMUHAPzy8fh8FmUNZ3HAv0eG7+v1jtrsrNLg2hBLO?=
 =?us-ascii?Q?6YgCrCmsvnzFh1spiQVQ1WZFjdnMVvlpp4G9WGqAgl2q9X0KvR1wUkdxKT03?=
 =?us-ascii?Q?xv+Hgr45yAWTScCQRDCsbaH1R7M5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UruOV5Rvqc6OOWmuImDPoE+2w62ZEq2YfRyLtEDCSe6qbBEpGVaolK3tGAD9?=
 =?us-ascii?Q?mN7prWx1WElQPPtNmZs+FgHxl8aHa1FUxGyrCmwGjJuNQEsxxAueqXpRYivx?=
 =?us-ascii?Q?eDWTAhCEquJx773svCfrjbLKRosyt5aTFhsuWwKrc9xj/RGufCqYGC1Cb3SW?=
 =?us-ascii?Q?1UQB8VYn03/V2ZADRqb7FV8zz8c8Ks1n7lXz0TvN84e9BgY+1dZssCHgnqrn?=
 =?us-ascii?Q?clCzgcmKNDww7oFIU0RNJ2UMy5j7kGmspSs2Sowv0MJDiJv550Bf0it+jHaE?=
 =?us-ascii?Q?D0I7kXLZupSoeqMLR6HBnkOFaQO5hRVr8qO6WtmaZGzpshry5GhSzkvoQmNJ?=
 =?us-ascii?Q?xR8w7sENkxKIPGILcHE5pUfR8uFVZKiiTZmod4Djbta1icHubE8AznxsLNob?=
 =?us-ascii?Q?BW3OatOH83VDrJws+SBQ/ZZpj+lXqdDNbDsu73t7zxBAJOWL5DSgr9nkLjy0?=
 =?us-ascii?Q?uQuE0yyE6Cm4iBS01tSxZeN4iL/bXyB/GF6w63afD04WiNcNqreMbbv2W4oN?=
 =?us-ascii?Q?Bid1nyk8mM5xr8dgijF+zJR2aMDvnjIIzP1mnkf72R+mpdiZ7XRkc5UbNwDO?=
 =?us-ascii?Q?T8R/qvlBmnpBqCSXv5b3yF3nAf0stKSAgATHeEvXFpQhJgnaGtM80M5LKe3T?=
 =?us-ascii?Q?vglWdBy9pIl9qHfcO89Tb0ER1+h3bOT4rqwsG7Hpa0R/FqkxrbYUcLlKtIal?=
 =?us-ascii?Q?5+erHR78qZ+/Taz0r+pWKhzlqX7WxLNqq+Uueqr2FkQpIJqfsaeX/hMbe4Yb?=
 =?us-ascii?Q?WPUsPoFH86BpIwR57JXBimXVCOnauZuWgXfPzEbHQ64vljZOLi4jJZoJRLO/?=
 =?us-ascii?Q?aW+IJTdoyBBiGbk19IsmCX46AWMwTNooPu5yiqfl0Kd9Fv1g5HHVy/amUIFP?=
 =?us-ascii?Q?Vt5AfbpGxEb7RZiWx+JtQbZEEe6mtAC2Tojhv1z8EJwV2dIwryS6/nUzM4Yk?=
 =?us-ascii?Q?i/JmDkBfbQPHBsVpodbNBABpgchnaYQm2BtR1UwPMCR+WRH0Rou7zBaNMJrv?=
 =?us-ascii?Q?xCAMD04FN7WqiAMge20ZG2bWnPHeJ4wJ/r6t5P2uv/PblhgFoxbAJfgP38bt?=
 =?us-ascii?Q?cKhf4CJ+CqdHsVSuLysUWZbQr+nuycLhila7hOfSW4I9iqqF/vDpceEtDk1Q?=
 =?us-ascii?Q?ZXFZZKEK+qJXk9QK6mtBZLayw47NDdmVI7yLLiKSP7jV5IW9Bjt0L0tWTRAF?=
 =?us-ascii?Q?RRj856cOUL6r7EpU3GwVh3hMIaE0CWOcRmwOstDsCRfdNjhFn7OOvMKrltco?=
 =?us-ascii?Q?mhe0a1yD/1z5KWsuvjTYyq6AGfA/arnBR+da28DrCnFhmCg6Uppsx9byJwj3?=
 =?us-ascii?Q?BvdxVd3C5E8ZyJDy5PB183yJnS46PcxqRbqaZqSBG8o6h4pHt//X8mZIJ+O4?=
 =?us-ascii?Q?3KkDlQzqtQgCf0jojAm393CHImYHC6sqauM4+pbru7VmD0eUD4XNUxwWBqtl?=
 =?us-ascii?Q?U1XSvwhIsVBr8XpGLwqaizZUkN45lwfbfL5XNzdPIiRBzKFooh/vYUnicleS?=
 =?us-ascii?Q?xA3d3/t81WULNXeG4iyn7vTlJl2oCSlQ7DiV1daZC7hLByvSNkBP/BCmpF/C?=
 =?us-ascii?Q?E5P/4Csi+aKDAL4AbgDoQKc6V98j4i4CScfFHybI2EpLmssQONGPMnvmwk1B?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	STrOx3KNvri9Vhf7uQENEIbHhia63zJVJ7L+Yk/el3CdgvaA5iobhBCNd2/9Qhs8osMVk+urZd9xB0vIERu6e74pidOLR3oTOKrTvmAXK1vKh3p7Ufj5Xd7OqRKNmpVIIt3RO9+QxpEd+8VuzCHhZwrY3lPkKecfpHvODH0OvdNRnDsAGRM+6R4Gl8zuu/VuzC8OXgVF5F9K/yum+cSKXlt1FTx6ae+tYFulyIwh0fCEyoDJfHRdikcKvvzpgetxuYbjl9iVW3Wn2dXhTgnAt0J/lV3egFULeIBRFS0XpjY4DSPl4uSe5J4b7YCF3rLeMXlpQlGx7M0HgFWanCz6AeYEsRcW+HPYpd3a4mQU+qHHUcC0C7D4alRKF3RXNWhlhTuW6pJl7g/rU7YdMkihgAQaUQFbZ87UM+5F9lnTRnW8YAHScQPN0PBZd8Q5PNyA1nZZqiY4em5tVpB0EqEt6DvKG+m32bEawpjWhnC7ixBnvf+8yB4KNF011uknbEStZuDuaROZwaPGM0ZWoxBhof5BDK9seOhCP1c/V4ga0dOx40imqoX0yV4FS7xcLkshA4uFBFspBGDWVUR3Cbej8kPyDL73Gtn4QtJ3MUS1oSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b73737f-cc27-469a-ca6f-08dd56e6f16e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:45.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBb97IVLxGHsBOgK9rTLXWEd11a2eubbZVNylvEmotE02cC1LLF8VHC/C1Wrq09cZvNPzrApacrdSzMIv0pXluvxy8TcotNUFAaCx7aB6qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270031
X-Proofpoint-GUID: TP6kppX67gyF6n42LxSFtIrhiOIEyA4I
X-Proofpoint-ORIG-GUID: TP6kppX67gyF6n42LxSFtIrhiOIEyA4I

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>

Commit ("rds: Re-factor and avoid superfluous queuing of shutdown
work") changed rds_conn_path_connect_if_down() to call
rds_queue_reconnect() instead of queueing the connection request.  In
rds_queue_reconnect(), if the connection's transport is TCP and if the
local address is "bigger" than the peer's, no request is queued.
Beucause of this, no connection will be initiated to the peer.

This patch keeps the code re-factoring of that commit.  But it
initiates a connection request right away to make sure that a
connection is set up to the peer.

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/af_rds.c      |  1 +
 net/rds/connection.c  |  3 ++-
 net/rds/rds.h         |  7 +++++--
 net/rds/send.c        | 46 +++++++++++++++++++++++++++++++++----------
 net/rds/tcp_connect.c |  1 +
 net/rds/tcp_listen.c  |  1 +
 6 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..d6cba98f3d45 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -685,6 +685,7 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 	rs->rs_rx_traces = 0;
 	rs->rs_tos = 0;
 	rs->rs_conn = NULL;
+	rs->rs_conn_path = NULL;
 
 	spin_lock_bh(&rds_sock_lock);
 	list_add_tail(&rs->rs_item, &rds_sock_list);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index 73de221bd7c2..84034a3c69bd 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -147,6 +147,7 @@ static void __rds_conn_path_init(struct rds_connection *conn,
 	INIT_WORK(&cp->cp_down_w, rds_shutdown_worker);
 	mutex_init(&cp->cp_cm_lock);
 	cp->cp_flags = 0;
+	init_waitqueue_head(&cp->cp_up_waitq);
 }
 
 /*
@@ -913,7 +914,7 @@ void rds_conn_path_connect_if_down(struct rds_conn_path *cp)
 		rcu_read_unlock();
 		return;
 	}
-	if (rds_conn_path_state(cp) == RDS_CONN_DOWN)
+	if (rds_conn_path_down(cp))
 		rds_queue_reconnect(cp);
 	rcu_read_unlock();
 }
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 1fb27e1a2e46..85b47ce52266 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -134,6 +134,8 @@ struct rds_conn_path {
 	unsigned int		cp_unacked_packets;
 	unsigned int		cp_unacked_bytes;
 	unsigned int		cp_index;
+
+	wait_queue_head_t       cp_up_waitq;    /* start up waitq */
 };
 
 /* One rds_connection per RDS address pair */
@@ -607,10 +609,11 @@ struct rds_sock {
 	struct rds_transport    *rs_transport;
 
 	/*
-	 * rds_sendmsg caches the conn it used the last time around.
-	 * This helps avoid costly lookups.
+	 * rds_sendmsg caches the conn and conn_path it used the last time
+	 * around. This helps avoid costly lookups.
 	 */
 	struct rds_connection	*rs_conn;
+	struct rds_conn_path	*rs_conn_path;
 
 	/* flag indicating we were congested or not */
 	int			rs_congested;
diff --git a/net/rds/send.c b/net/rds/send.c
index 6329cc8ec246..85ab9e32105e 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1044,15 +1044,15 @@ static int rds_cmsg_send(struct rds_sock *rs, struct rds_message *rm,
 static int rds_send_mprds_hash(struct rds_sock *rs,
 			       struct rds_connection *conn, int nonblock)
 {
+	struct rds_conn_path *cp;
 	int hash;
 
 	if (conn->c_npaths == 0)
 		hash = RDS_MPATH_HASH(rs, RDS_MPATH_WORKERS);
 	else
 		hash = RDS_MPATH_HASH(rs, conn->c_npaths);
-	if (conn->c_npaths == 0 && hash != 0) {
-		rds_send_ping(conn, 0);
-
+	cp = &conn->c_path[hash];
+	if (!conn->c_npaths && rds_conn_path_down(cp)) {
 		/* The underlying connection is not up yet.  Need to wait
 		 * until it is up to be sure that the non-zero c_path can be
 		 * used.  But if we are interrupted, we have to use the zero
@@ -1066,10 +1066,19 @@ static int rds_send_mprds_hash(struct rds_sock *rs,
 				return 0;
 			if (wait_event_interruptible(conn->c_hs_waitq,
 						     conn->c_npaths != 0))
-				hash = 0;
+				return 0;
 		}
 		if (conn->c_npaths == 1)
 			hash = 0;
+
+		/* Wait until the chosen path is up.  If it is interrupted,
+		 * just return as this is an optimization to make sure that
+		 * the message is sent.
+		 */
+		cp = &conn->c_path[hash];
+		if (rds_conn_path_down(cp))
+			wait_event_interruptible(cp->cp_up_waitq,
+						 !rds_conn_path_down(cp));
 	}
 	return hash;
 }
@@ -1290,6 +1299,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	if (rs->rs_conn && ipv6_addr_equal(&rs->rs_conn->c_faddr, &daddr) &&
 	    rs->rs_tos == rs->rs_conn->c_tos) {
 		conn = rs->rs_conn;
+		cpath = rs->rs_conn_path;
 	} else {
 		conn = rds_conn_create_outgoing(sock_net(sock->sk),
 						&rs->rs_bound_addr, &daddr,
@@ -1300,14 +1310,30 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 			ret = PTR_ERR(conn);
 			goto out;
 		}
+		if (conn->c_trans->t_mp_capable) {
+			/* c_npaths == 0 if we have not talked to this peer
+			 * before.  Initiate a connection request to the
+			 * peer right away.
+			 */
+			if (!conn->c_npaths &&
+			    rds_conn_path_down(&conn->c_path[0])) {
+				/* rds_connd_queue_reconnect_work() ensures
+				 * that only one request is queued.  And
+				 * rds_send_ping() ensures that only one ping
+				 * is outstanding.
+				 */
+				rds_cond_queue_reconnect_work(&conn->c_path[0],
+							      0);
+				rds_send_ping(conn, 0);
+			}
+			cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, 0)];
+		} else {
+			cpath = &conn->c_path[0];
+		}
 		rs->rs_conn = conn;
+		rs->rs_conn_path = cpath;
 	}
 
-	if (conn->c_trans->t_mp_capable)
-		cpath = &conn->c_path[rds_send_mprds_hash(rs, conn, nonblock)];
-	else
-		cpath = &conn->c_path[0];
-
 	rm->m_conn_path = cpath;
 
 	/* Parse any control messages the user may have included. */
@@ -1335,7 +1361,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	}
 
 	if (rds_conn_path_down(cpath))
-		rds_check_all_paths(conn);
+		rds_conn_path_connect_if_down(cpath);
 
 	ret = rds_cong_wait(conn->c_fcong, dport, nonblock, rs);
 	if (ret) {
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index a0046e99d6df..97596a3c346a 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -73,6 +73,7 @@ void rds_tcp_state_change(struct sock *sk)
 			rds_conn_path_drop(cp, false);
 		} else {
 			rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
+			wake_up(&cp->cp_up_waitq);
 		}
 		break;
 	case TCP_CLOSE_WAIT:
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..60c52322b896 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -211,6 +211,7 @@ int rds_tcp_accept_one(struct socket *sock)
 	} else {
 		rds_tcp_set_callbacks(new_sock, cp);
 		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
+		wake_up(&cp->cp_up_waitq);
 	}
 	new_sock = NULL;
 	ret = 0;
-- 
2.43.0


