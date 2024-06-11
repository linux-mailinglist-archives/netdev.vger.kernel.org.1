Return-Path: <netdev+bounces-102519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31339036F0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DC51C20D05
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD059171070;
	Tue, 11 Jun 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ORkhf68P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Noe1Em98"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36A1DFE8
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095634; cv=fail; b=ZR9+eyPGtlcMVOujFICa1C1IFYatamw6hHftipz3nI+EpSm/pIXtsxstyoPfEMO19XfbcPZuj21CzMSCQGhj9adpKcFceTBfk5tem6yyRx1hH+Mtm51QdFPCk+eQlIBj2q730kWZjZoQl/t5eY5mvaV5lZsYi+r3BsXDF0dOxn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095634; c=relaxed/simple;
	bh=sJ3IQEI90olazJYgOYWE/NQuaYXRuacmJ1GYs6mwXGk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FdHtzPjLU8SWKsW+ToCQf/pspErDyeOZNF3Lr1zUb5A13T+RrCplov8cDbPfH5n6jD8pYhk3jULf0LHklPGcEeDPZC504OcciTu7bA4lgIFHPE3zUDL8TKjojXZOSwby5D9qhhtiILz8WR5OnIpXo9aq33IxWiz758sBc2lI8z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ORkhf68P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Noe1Em98; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fQ5f008982;
	Tue, 11 Jun 2024 08:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=y50Ebszi049MsH
	/ZRvcdOZcY3VbJwSHYv3mQYCILwlM=; b=ORkhf68PJ9E3DXkXdKYxg/x4PWwOB7
	elOa4b1uAoN5GDB/2b5Su1HP5cFVuBmCaQAMPMqTdCphQhkKIjZK+Yvu3UUJ+zGg
	u71AsMY8OtWuWjglSaF5mkAQ6WTiEi43qFWnxCI1joA7Dau+/SoRpFQ0B/rVlNRb
	BYuWCU+A2/dlO4e8FrVbO4mhYsAC7lgKacKMuTNYENNYmR48/frZ/uUq6S34IuTr
	p9dbGlKIsxC4qdlrf776AhXZFbJcfehkQs03eOhh3lO8S+3Ts+bjD/0qpEOZv7sL
	HJ9hXGGwkf/T19SFf2yyltId5914MkIceR/YEO2DCVvEEEauj/jeojnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh194bxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 08:47:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B89srk012491;
	Tue, 11 Jun 2024 08:47:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9wh8f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 08:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrRzfzQs49m8ZvzgGWV9/oyrQ3bg8T8WDOH/FOHxR+mZjPhLFINGzFEK4E4pbOywSa1MgMB/ZkmH4+fflUihOqXgx06xBX/ZlBVXKA5pvckF32XY64uvPwujueZXjPR7xl+VlbX1ijWH7b5s87k9jtEo83/f06RkggnIz7uu9MhFoeGXmtUBQ7oQ8mPFNHqVEedfWf+HVSIbrlNrYj7xlfQJRhvjX3ZXsE+5LJkn/ujEqdO1p2X3P6onlTjqv2lWMJBezV8zpFNc32ja1lGAqZfDe5vBAZ3pXHM9sDtNA8YP1vFGJjZkw7JW+GWcd712YjZqYNI+2PyE1xczXfePoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y50Ebszi049MsH/ZRvcdOZcY3VbJwSHYv3mQYCILwlM=;
 b=TZ/uKEGPmXuamuMc7axRWIuCITMFKbAOZnc8bdtZfDLxfuwMh1jfiqskX966bkGXo/Mtkbc9oD2DDVP3mhWYghFHNDRDNqxYPvciUKpyELTjKcZYuNJAAEQOkOJJuNDfILjopUKGKU9nju0jFQZJeYEWH5l4uD7LSpcDZ82oRLHvU73JqP0+27TOPBEnU52IiLrAE+anoFjpP+jhRlKOW0LWIa2UYtan21LlhUYWJ8xrLCrQqOdd/Z3gtcRUId7NiuVzVb+mYgpyqv63XeInF4+vbbmnoW67Nxlf6vmQsldnTLkg4nzRpCv66vKNbTEnOUApm1DEuWhSU3GeU8doeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y50Ebszi049MsH/ZRvcdOZcY3VbJwSHYv3mQYCILwlM=;
 b=Noe1Em98YvnTjFxGj44WwbVZ0b4lDCpz1zN577xD4LUrKG/bG+G3XCk6Jc0+v/X6tGlS4sZA0MMFaVFOk3WNNrds5B1jz6Al06MC1FkBwhwIaPNLH25fqLFXPrXohLkd7oNoTkTmZxTKUBGGIjL4w7PN0wErEOLG7swM2Yxi5Fw=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 08:47:01 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 08:47:00 +0000
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org,
        Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH v6] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Tue, 11 Jun 2024 01:46:39 -0700
Message-Id: <20240611084639.2248934-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CY5PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c1e3f4-e592-47b8-430c-08dc89f30f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DJhw2e/7XQUtnh4I5eOK7fO97248qxfebKwZqH+qRyjb69KK88DzQXO9wb5o?=
 =?us-ascii?Q?uMtIMFYc4WHyuRIJS1Q7EeyNdGZlYv/jpCHX+sClykJxYtdueANuDT3mE9ck?=
 =?us-ascii?Q?0RLqghSyn0sPtrNGxxxZEuhdCBD81h53vZTZrhvxkHp0ecYfZMiemlCkT0o1?=
 =?us-ascii?Q?k2D893m6/162lFuokigUbz7y5KHSJT9XmgD/TB2N202Bj76+N8LYRd4qwbUl?=
 =?us-ascii?Q?kPcxDnr/wZBMaDxsJXLDuA/rUGUmFXlQGNHYAcd5OA3pswModyIOyo6oobf2?=
 =?us-ascii?Q?3R1QlakTIHGenA1MWwMsVBCZGoJtV4ZxBIIl0hvLoC4VriOtwEUE7euW+JLV?=
 =?us-ascii?Q?8ft3AWvu301qoR9c45SY2kzMpalzABW1HVuRp6yEKuKlboW0KFBDIjTkbQY0?=
 =?us-ascii?Q?DM3dRI0uBaxteKqjO7Bi3qsHQ1X2QCRtsfh/eqMsgERlBoh4yga9aoduLIHo?=
 =?us-ascii?Q?tAtLdfQesQyJfltgib2nLrvnPPJ1H3vYZKh/X6Z5Fh1ZdGplnZA3DsFiXKds?=
 =?us-ascii?Q?Mxl4l1QSYqsI3VF7mGOGX4jZNLS5AbL2fRZ2NlIwngZemj5qHId5xsSw5xdX?=
 =?us-ascii?Q?spQRXtQ6nLioaKL5Sd1+baqyC5P2qO2wBMtmnRNazSWyMMB/njD44aEJVRm+?=
 =?us-ascii?Q?MlIAXG1kSC1YC2iFTg7kcLhcWGoTwASirFZD1elPL73iYuQQq9lEYlBCCDor?=
 =?us-ascii?Q?sNFLB7lNtpgSQTvAWkMXJgfhg1fVGg0CHOXuF7C9T0gccX3fCEbOKonyIpLG?=
 =?us-ascii?Q?GKvLjiHEnyAq78N9X3zeqKz99/wg1kWxgq77VeT4Au2lHEsrQ+s7X2e3zyyD?=
 =?us-ascii?Q?gZ4M+s6b4Baeq++aPuufbkH8O5au+qj8MF1VsBiefJV9ZPiqpUG4ViakRkE3?=
 =?us-ascii?Q?7keivMznRIUIZ7yYqxfYaBe4KWTaHFic/vdt1mCJjJnQbVf2vfI+syX6SRVJ?=
 =?us-ascii?Q?SQYkYmWphm/TJkS76+VKlrkG55RieLQQI2pFYIKI9bqAQ2o++1CEsD8Pme2Y?=
 =?us-ascii?Q?0ulPSCj7eNl+oLTQ2Xs72CEx3cTI+EITxCCrx70rSzrE9wvmmmxl2Wuaxqjr?=
 =?us-ascii?Q?bqFOdG1HN/GFYZV+7TbdKiO0PnBsm7G2iajA3l3X2OQXqsFj9EYctcVJGu2o?=
 =?us-ascii?Q?wZfubP/jmMnx/4/10HZfAFEXHjO8zU46TCFoz76ZFky1KoEbAeSiF/8CSZk0?=
 =?us-ascii?Q?xOOMFvS96Of6QJJVzp3C9FIOewQ2le3gs99E/iEzeHyOWCdXJArm7aiRw6kl?=
 =?us-ascii?Q?na1mhtV8HQvdGKH+9ZoGVwJATOibzonHg8gCMRSYX0PZUMvF0ou0IPKj/7Oo?=
 =?us-ascii?Q?BJiTW6ZRmEbkqzm3LrQmyk8n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ndiVODu8M0bjIyssNMD8LYg8/Zkvgon2swHsQCyZjy1g+KX4wbqBlgF4Niy9?=
 =?us-ascii?Q?Yl4iPAgRrYsBc23ziUDs+NefZXeuEsxy/kG624MbAiYyNFsHxZgrjc0y/hzw?=
 =?us-ascii?Q?VAgkBhiKVpfQKJgtMI1Ul2PMrrWb1eiZjPxaA7znP0WWfpeRfnqptM7gIBip?=
 =?us-ascii?Q?siVBDswa4rvCJYnxQx9R6biJt7Rogp4BkwiQGKu35Y9npBm1rxUe9cabupxz?=
 =?us-ascii?Q?9b40ir1ECXXyxaAIx1+HzGei1zJR5wq2i4KOtvF3oT4SWPCmFk344x7MKypi?=
 =?us-ascii?Q?KlVnPgjbAUcCCWkMfK1NGP6kIzeTulqnzNFMEl9aLzQAYap4hW2DPt8dPFed?=
 =?us-ascii?Q?nMrKvBcuyx8nEqbEzbSkiaiPSCKEtHllM1GvApVqWnIwxcK8OTnknRQs6a/H?=
 =?us-ascii?Q?lfkD+zNIQnPVT4S3tCK6DOWi1U9AL0Y5ONAlBVaamG2cB7Qr6eWBbfpotEwH?=
 =?us-ascii?Q?U0VbQFFChIP6pWM311aZxb1F247nVRtPl6Z1tu7mguFw9M5AHAaoHijGjkF5?=
 =?us-ascii?Q?sCTjySqZ0UWf/pGCCbiVyYZX19bGogfBIhr0xJH7kjCdSNtqd5ubyA+8BebT?=
 =?us-ascii?Q?ooAUvtJgN2flwVLbeEJRGIwGSqCMaDzt5PFEZFXWZ1G3uBR3dhhIrcvYrbHo?=
 =?us-ascii?Q?OxQ+ifoKgEXqVeqK8B3iOJZZ6/IrpkXJ1VrU01/YNEI1213IUUwNS3QX/3cf?=
 =?us-ascii?Q?4c5ujOUVwsvPk3nG6W8oy9maGswNbl07gDHpFTtgxKvbXeTGTZls5TSfoy3R?=
 =?us-ascii?Q?Kpo5Yv7jH2cKruwyylJi1WbwizwWIF7PFP9yIfdlggzAWUYpfNQEewSJcVTL?=
 =?us-ascii?Q?VM0RcfBp17BujnEGuICNb+vRKGJYyCsbb64hD9j2AfVEcvVbzKe+bTBEXBU+?=
 =?us-ascii?Q?Y6Zq7fAwhybf54oUVuRM87GWYugQPxr0NVIhq7jXbTlYWccuPnYhoWn42glM?=
 =?us-ascii?Q?oDxabLarwmBQHMYISRicCVx/coCkuxtWZs4qtiQ8S7bnaxjz2FTS6ErWKQIv?=
 =?us-ascii?Q?VJ6+sBwJQR7WeOteOi1ZGtpD+mHTAgpUwMqSQv0yqZdBaOgEmguy3QWl8LtZ?=
 =?us-ascii?Q?Qb/D27O+1e8UT8F2aGIV1kJqtJyY8t2LNIyGyLV81n3ZohGJO8V8+5nmAzSJ?=
 =?us-ascii?Q?+k/X+IHFgkAO6oi3I0YHIpBV/VlETo8EWrSpQFnzuqgSnvV8/MiYzXjEMpPA?=
 =?us-ascii?Q?xlxonL9cfqa1UJwx1nZkVVAME3ezf1XDCIvGaIymxLB/ZaiNkYHjnHuMJb5R?=
 =?us-ascii?Q?79ulGKjD2T8At5wM/rYibfi8Q3qRlXZw/YISbKphDutqmuvXoGhHdT7TSSoi?=
 =?us-ascii?Q?dSRH0hTZ6fgehmUNrx6NBcwiLfj3IebZYXsZ1fyqRLKzUNwNXgiMgPxh1RNg?=
 =?us-ascii?Q?xd24XJIY4SfzlKmaTMWzfatkKOu6w51U2/WKmAFQkA9213BDEZLLkoS2yU6J?=
 =?us-ascii?Q?y1A8NzNpMBYVxFIVyEDQzb8q/9777q94GYPJRFxG6sXdfiwLCPDWAfeXnFbF?=
 =?us-ascii?Q?K++cmfqwFQXGeNiCm1jdfaDoj/UK90YHHA/lQI0c0qQ1qy0iyCSX9RiIuMNu?=
 =?us-ascii?Q?cFvV53WofFgefCUECGrX07j4e3rDhD/DVmI3aesoGA5N6AC4T8D5Twx3/MB7?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YkbSeSwWFdrDM4mZg36kvKVm6NHqPqQL2+oUN6HjKIeUMC/KVFuyDGkWo1PvrHMC/Z9yP7BDkMglKS/U+isutkLssG+x2HlhjzkCy5BgbtxVtJX/HwIK8pBqR4D0NWYnFMXzuzTHWK9f9W93sqC0a9vIyJW8oNmZQo/hzUk6koZ63DJLYxuItYi0oYZXzJ668PY/bSH4QwQ1+7IBP2wHmwU0hw+m7flhJXiJMAw0HXjsBoPCZEcNz2F3iliQsat/So44TqhM9sLHLSqRwqyjafQ7Ef0u2dNH10Qowi0zgSIulcyRgIwQ1jSGWQsAcaM1G+V1tm8y+vLZpmAXTT1M7RDu1EOjP+CLgrOtc3DUbws9JLC2KrIxKIkrbs7LSg1EjGHBBEUWyXz4OxxBsbUQFsXDhNBfogVSR/HzmdVqHrG9Lokn3e56496nUhZAtTFoPeaFxDS78msoxvs4Xwbj3p4KGN/1jXEkVSFudOGoYORunzZyQYEfsqgzf0qP5AmMS7ALIaLQWt+wAzcTpOcr86oDzj1OG1hRyONZaKzHvTP1k1fRU+bazGU41Fvh4w820JzIadJVl78cfWuBif6lO/2MCZZyl3Rll5WU7cDVixY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c1e3f4-e592-47b8-430c-08dc89f30f44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:47:00.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1UTKAjEp1NwIZWhpeLsz78PiLAThTeXUDYUUjFw/fpyYj+fxVt/ljrcgbfdOcK3BbXngNbffKWG+Kz7DchQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110065
X-Proofpoint-GUID: I-2b3TiUuqcF7Ja4BlIFP3QlG6_f0kCQ
X-Proofpoint-ORIG-GUID: I-2b3TiUuqcF7Ja4BlIFP3QlG6_f0kCQ

Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
addresses the loop issue but does not address the issue that no data
beyond OOB byte can be read.

>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>> c1.send(b'a', MSG_OOB)
1
>>> c1.send(b'b')
1
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'b'

>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>> c2.setsockopt(SOL_SOCKET, SO_OOBINLINE, 1)
>>> c1.send(b'a', MSG_OOB)
1
>>> c1.send(b'b')
1
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'b'
>>>

Fixes: 314001f0bf92 ("af_unix: Add OOB support")

Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 80846279de9f..5e695a9a609c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2625,18 +2625,18 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
-			} else if (sock_flag(sk, SOCK_URGINLINE)) {
-				if (!(flags & MSG_PEEK)) {
+			} else if (!(flags & MSG_PEEK)) {
+				if (sock_flag(sk, SOCK_URGINLINE)) {
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
+				} else {
+					__skb_unlink(skb, &sk->sk_receive_queue);
+					WRITE_ONCE(u->oob_skb, NULL);
+					unlinked_skb = skb;
+					skb = skb_peek(&sk->sk_receive_queue);
 				}
-			} else if (flags & MSG_PEEK) {
-				skb = NULL;
-			} else {
-				__skb_unlink(skb, &sk->sk_receive_queue);
-				WRITE_ONCE(u->oob_skb, NULL);
-				unlinked_skb = skb;
-				skb = skb_peek(&sk->sk_receive_queue);
+			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			}
 		}
 
-- 
2.39.3


