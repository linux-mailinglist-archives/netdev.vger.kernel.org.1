Return-Path: <netdev+bounces-101598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CDB8FF8AD
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A97C1C23544
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7A7E9;
	Fri,  7 Jun 2024 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oSSAq20k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nV9TM8tV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EA33C7
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720600; cv=fail; b=EMlseXGsjMaaeCFQBnhYTCzAcCNNiKHnsy6ekXmj3D1XcmRD+/19yEM3i/rZLKwZFO2vgwgntFF1vExGDFEM+8cPx4WQsnVmqr/EgNLflszHrP6gdpPmJA7I6Au6TPvwW5osfmWZptQ7ggwt8Jt7c8wUTAmdJHD3a5kAZY7g+ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720600; c=relaxed/simple;
	bh=oj+1eF8utE0UtM9tho/cAQCekwucXxUVPqNozpzHbzw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E833eA6LP9LmspvFHAVRJQc7Mlh+bFIzwOQ/63GXm2lFDcDrtVjokOSuEV8OifqZkQAurrEXm9w4Dl0uzlsDBURd30BC4tmPihmSWWgi9HeXEV/TpxuBPEqVG74RamSp9myqrnRMltcePMHXN01TB3OE2W1LONycpKD9a3pw00o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oSSAq20k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nV9TM8tV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HwsuX029566
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=HUCyBaJ0Nq+EnS9pZ4ihIv2MCSqrncG9l6iIsEY2Yh0=;
 b=oSSAq20kscypcixC4OBEApPOPzcLnh2HdItUYNg9dpIj4+TL6DM3bBSPJbA1q2wa6cfl
 FMxTZ05BP5vdw8PdjLvozjGXlmv/xF64UawyHeLAiG47YDl+2zLmhNkb0zhzFTqKcu9d
 kTwxwNSTOGSloivL9s9+jDpNRILrkUHW/4E/wqKzp+DL08e5//QaQZqURroGGx0kuYFJ
 yzNJe+9il2njHwMUl23EXkm2LvAeZYR3IoLl5h/bMeuX10wkcmJFuFkELsebt8vA/xS3
 tcbn8Ji20b+tNF6bKnXbLgNgnetDzoEYSz7Q7SliqROhS6FIKYH1qrkuAgIDTb85iFLt QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrscj98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45708Sgt020558
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj5vqfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6q9Chw79LJvEn8aP6Zydwj7QI0JaE0t5d5pROT+CE7CaIr5KZ18GVEwMHOpDaqsoXSz0c7K10t7fw9PNAtHQ4W53L/vDG+xeXQ/z0y+gTSlW5+HlXhQzv56eaqKnkxBpLY1+wCmv5QTeeeIAhiY1hYF0rYxXfycrh5qjrfXFUeJd5oEP7YZDWRXifYslfRvkRounvHmuH7OXehEHKt99TDvrpqkZt6iWAxomhrm6uE29wB7HIeFclPub3/FOddsdhyPx2LFoT3zuPVybUbAcRtfTCh3BFgADPh73eiTdMJjIzwD+zPMBa/Kl3lzwTGK5yZ/rQumpUtR/58Ku4OGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUCyBaJ0Nq+EnS9pZ4ihIv2MCSqrncG9l6iIsEY2Yh0=;
 b=TIZGIN0qS0b75bZGPdyRUmeEEm65mVQ3er1iP3Z8P5Y6FJuTgmgwWrIvwgmKV51OPjAbCL1diEcDqzZQHC3W9iEg/ODdRftd8nNADFZRvDwf+8AK/1PhkTejVhTGVveSVr8r7EVFZupNwsLFK2vEY7/wKACbDWw1OH0kVTXxzbCjrrsXSjRJkUwGqid1rq/HxB0eYoXpC9JfmARibVJ+2ydnNJcnS/wHXGIxwFjy1ULHM2xEAX3jvDZ7BZ0ChyJWZD1LLmmTN+8t19uqF7n/htEgjOLtrZv4XNXNwAimauaOoL32VWd0AivaNYiXHDHYnLnmKh1a9JV7qXbOqNQPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUCyBaJ0Nq+EnS9pZ4ihIv2MCSqrncG9l6iIsEY2Yh0=;
 b=nV9TM8tVAYinUGjPg58GQn68VZNOdKpCr8WsBX+Wlmdrv1hmFIE2Xt7H+zvARy168+/n26C2f6kRSbHC8zQZZoAeRDUVb2NOmA/AdME2OZIlizt1/h4q0QLtH9O6QxqQA+L7KnGbDSN6htVzGNUPoR11+98dHX51QvU17vNnkCw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 00:36:33 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:36:33 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [RFC net-next 0/3] selftests: rds selftest
Date: Thu,  6 Jun 2024 17:36:28 -0700
Message-Id: <20240607003631.32484-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffc46cb-ebfd-4641-7228-08dc8689e16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hWD831pTOyo9vNSthiEFlLJ/KHOufzmAJ6teDmZALQ4kwNpL27t+jqXmiho/?=
 =?us-ascii?Q?AVt7KPQKolFZs5mCzym/DPSd4OYMLpn753HimQnC1Uqf2phLsLGpJmrEaHEU?=
 =?us-ascii?Q?o0+vKAp3kcUVsAO/+eAYEaruyV1zgxX/7pgx9eGC3KJhKcEOR1WiBwPfmllb?=
 =?us-ascii?Q?uCk929AjbengG66cNkHtVL/4sh3eP71AJXsgXUUMDWiB7PE2h4dQERSYp/qr?=
 =?us-ascii?Q?4eGuNsdeOozyA/R1b9Pt2AuZQ1qnSo5Uowk/Cp2Y5ZzcelHMRr82vSs5b9ad?=
 =?us-ascii?Q?ZmzChcItQQFRlmOd28XJO/PVebCLrPba/cCYwss4qkNqi8vwi8aHgx7W9T2Q?=
 =?us-ascii?Q?EOc82gAsmR3/dfyDwi2ORqsgzgmUnGW7DCRYtbrjzUt7u035nzDtRZ1dYXqT?=
 =?us-ascii?Q?woORV+HD35CFyGmU1zGBYAPAkBiQ0P58By7Hiw3Cr4bJM7+WF8354Fr1QIv/?=
 =?us-ascii?Q?RIpm7C2crjWXcUMq8VPp1cUTrHjAt16qA8zipyJwILYUe7mMepBmViiY4k8R?=
 =?us-ascii?Q?8I8XOWXdSJoXGikPgnq88QKZ1B2l10jYQlR9n/Q/GLPtlY1B/u86VfIwGkSa?=
 =?us-ascii?Q?wtU1YC+hRh2zmngnny0JToKZ0I5fx4lO5C6ibFGbBnXasVcH1KM7PTM0QQns?=
 =?us-ascii?Q?oonTa5ui5jGiyh0T4fUKcgiN+gMLIr/p16Iv3pdie2GcDlYsbvXtGd8jTfKG?=
 =?us-ascii?Q?VQHjOTzSYrI4RIAWiVfD5Ykzuo0EsQ5Vo/yr5Kq6yV29FKd4ny40TtoT4jwt?=
 =?us-ascii?Q?mWA/NzTXkf+ug6ZFdYG8ZIZPWQe2igqCRj8Zr1xhhHpueaJf1rN8VPkPP3pY?=
 =?us-ascii?Q?X0KbydaS3SFhZsjCWnKdeI4LYJtDm/PX1B2Tc8d9J1Nbha3d2bqC6n8A9pEe?=
 =?us-ascii?Q?MjhcpUr7VWuxU99PDfafotvVs1WT1IeflSCMxd85raFw43WhhtAkIYqWACWv?=
 =?us-ascii?Q?wO3QoCdNYYOSGgofyuSTlVAgERrtc82EmeFm80R7h7VxtwD2ngcC3IbAoDmG?=
 =?us-ascii?Q?5sYsSf/HzRAqSpyzaWxtDgQPf1JOdbUswbpeFkSaBIYHDS+06Qe9DIEY/RnO?=
 =?us-ascii?Q?7avdrSNwesCVrUfIE5Gp7nn0oS0EDiCvkPLs4Tq/ZjiSZTZGcW7gEDP1WT8L?=
 =?us-ascii?Q?IE270PSTwMrU07W5gKlZVmqFazdRdnQecrC2BWPape1ZA0rnAZ8dKy12ZtjQ?=
 =?us-ascii?Q?tupSdIoH/JIzDCIB750z5Hm6bsPdOMWwkIWYS9vzeOiosXTIrlZpR9pCl/Pt?=
 =?us-ascii?Q?uPDA9N7RuwVoSlYWs7HQEgyQF01X9T4zswakocmE23sVv/mYTTG5my2yVLNs?=
 =?us-ascii?Q?DsdXF+wjzZW1FovdkM+OoU8c?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7fJrDBQvQem/AT85VAKGGf3uF4/xak8dv0qc7Uw5u+cni637zxjSlLiBDN81?=
 =?us-ascii?Q?duvzFHrMvh6eBbNL5FnY/yRjE0iPlcJ0FRDDf1AHPFj57JkxO0C7IPsRJ9re?=
 =?us-ascii?Q?JIba4sZW4CsYPHy4ACK52E9M/arfT/CQct5sbWptW6Xhxh3HR0lYTsnp+Mqr?=
 =?us-ascii?Q?wJc1ILvFP+wu32XSfVV8w8aVvVK1sX/wX11LJI/jLSVnKyzdWImEDA1bQbO+?=
 =?us-ascii?Q?hYS/6nJdkue6W7N5LDKgryfXaGVf/W/EMDrew/09APPIPKUBKm4KXjTCaU2H?=
 =?us-ascii?Q?P7GYdUv79kB9foBv0BDinYWBT/fyjAZ6dG549BmX+3jlSQB09rnYaHitrbRn?=
 =?us-ascii?Q?rbukfRGa9ux0leIq7Yepk1Y5VVJXaR4qvzZPawoUp2SE9yyNJAjJD/f4K+FR?=
 =?us-ascii?Q?PARsYOOqvyTp7rLUcbC14yqXpi9+dbxeC8n0bbTun2W+mhdu4I4EdRukaYdJ?=
 =?us-ascii?Q?giXhjAu8k4K054voiJ8/s6TalC9TLziMOOkrgFNxRaq04eumaj4BeIz3znhF?=
 =?us-ascii?Q?txtk4hmaeKgViI7k7r3TgUBYCxO8wQaSI0Ko8D76rf8gtWgbsZchvR0oqsmG?=
 =?us-ascii?Q?dRsYZ7WwAkKE4IRSU5jZqyZmlD6fZP19p2mF46nrt9VktTeVU8bFdVwqv53c?=
 =?us-ascii?Q?HHfCbBzb/U5VUU6MtKgCIV7ot8+E8Mu93tKWaY7mQDef46iwMZzeOfjfCyHE?=
 =?us-ascii?Q?YaEqS/7pV2hJHCdzkMoWpqRwRP2tOGUFwkoUnPBxhwkDnUigG9rDvgFEgrAe?=
 =?us-ascii?Q?i9ULe+Lr1FKLvEoETJWn4WTZ+DcJQxvnfeELD6+v/6Ow6HrGS0ltCHjx5vp0?=
 =?us-ascii?Q?H/Cm06sBiFDQkNBEogfboJGb15NfD6y6/K9nJ0GMOYQ8IE6fx0jJ37N+gari?=
 =?us-ascii?Q?wOctFR9MElqEcLwQLZ7wFp9oVe4fYqpCagyBN6csJHa9HRWeN1KnCoul8oUL?=
 =?us-ascii?Q?DFd+jtlNDI2voC8nk4pnjkwXd7xFXxkYlRn37/438OXcA8wO8GjF90RezKt/?=
 =?us-ascii?Q?4uk/J9vesfSJgqTXuECsyOLM59irkzqcayW2Z/DE0xcRA/2ZsCETrFMIKYhb?=
 =?us-ascii?Q?YwgufDVJv3tpJEeQVFCpgpmHneVL4ejuCQpLKFtF5cERfwFyb0Ei7bYqKZ64?=
 =?us-ascii?Q?bG3V0isAthmqzE1pQxpaCbSU2VnC5hST+y67KndjxNpePQ2F5O/JsE45pF1G?=
 =?us-ascii?Q?uWZZw/OfSBJqm6cvAqo+xigtpqmDaFX9rZ2oZpekOWSJMCtC8IMRkRRmYjsC?=
 =?us-ascii?Q?tmUUh5SSmMVK40XKuN4ETbUecRpNXQ9hPEoLbhuQoYsK9Qk4NWBcpReIg85y?=
 =?us-ascii?Q?gyP/E8IwJVADtxlYUAaOWvAwb91twaDn3Gt57eDNUDkY1ODETFXl2fP6T/lK?=
 =?us-ascii?Q?GQb2KfulTR/uNDMsH76P7qh2wBqQIQoXvc5RHQ1g2EI4isOxuDRCssyD5vYK?=
 =?us-ascii?Q?+mbLS2Jy5/LURz0dgOcNMFaQ1COIn7pVgjQjazew+ASULEyI1X91wu10jomv?=
 =?us-ascii?Q?KDYb9oCGLFsh4315R66ucHJcJJQGo450KDB1r7RalYAo51PkER1Q9PxnI6kU?=
 =?us-ascii?Q?2EJvE//RNKAQsjP7I/Ol+4GoPZpJ3kL9tU3Z4W3vj8juNdKKl3dBP0g3jJED?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XpDJxatdGUFs7RgmhjKkPqJHsG0QeYnIs2ZgkcdpVSD5brRTzTxv1u8wXNaMroFkwB6Gux5fjF6/e7oOHhX89/2CJ7r0m6RjzfGB7G2UreU5RhE2d8a/7siQ6KZ9lIP+ZCLdeoRfBgFqjgMO2eMtdsTlvkQeQlMy72J+DVkyjVAyXCxYjs1gDwyZalqdjbNO1+g2x7EtB0VIF28O7h1jk9l6Xggk5noAZw8BLEz62GwhUmWJjeq0kAmqAOGCz/GuGM2SeknCTyAWYCNjoACLNY+PdIASBDoY7PgtyWxh8yFFQZXAeJSp/Jf+eKtZP3fag6NyO3/umIP8jMW243pBwDmofAAk33BiqGKm9VY/90SR2yf10oj3bwSQ94OT5Wk+3PUuAuzHesluNN4Nd48GJnzhh2GIza7HAu/b5Z/FNLeLpm/BhwzrIJqzis2Ds/bXrhT28n89OMTAkgJeuvxLLoifcD1oXblKx6c1EjDS9F/P3IHuBNnHgKex4B3qFL/+MG1V/XAQ5RIglDj7ju7GwTKNU4gf4Is7A0SEdFvEb426qsxQL5G7dVnrHMcsO0oEB0jtLlo7Dr5JNXeG6xCiZ1XKZGPILT8tlA0rEIw6cmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffc46cb-ebfd-4641-7228-08dc8689e16d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:36:33.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VrTP/9hCTaPi0wcK97fXjj800HlHqKjyLGp59j3mK9eRcrnIu3fwxUtImvB7Ser8lrlaQv0sITHB8f0j3dQkjLuqn4A63sRwceIyGvP+Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070003
X-Proofpoint-ORIG-GUID: lPEdbTRaH8XALnGRlNaeqNsiBLXeFCv6
X-Proofpoint-GUID: lPEdbTRaH8XALnGRlNaeqNsiBLXeFCv6

From: Allison Henderson <allison.henderson@oracle.com>

Hi All,

This series is a new selftest that Vegard, Chuck and myself have been working on to provide some test coverage for rds.  It still has a few bugs to work out, so it's not quite ready for submission yet.  But we thought an RFC would be a good idea just to collect some feed back to see what people think.  Some things to be aware of that we are still working through:

  Occasionally we see intermittent hangs during the send and recv.
  So we still need to track down and address the cause

  We may still add a time out to handle unexpected hangs

  We've been having some trouble getting gcov to generate a report if
  the version of gcov doesn't match the version of gcc installed.  So
  we may further adapt the test to omit the coverage report if the
  required dependencies are not met

  Some distros are still not collecting meaningfull gcda data and
  generate an empty report, so we are still trying to figure out the
  cause of that

  May still add more exit codes for PASS/FAIL/BROKEN/CONFIG conditions

Questions and comments appreciated.  Thanks everyone!

Allison

Vegard Nossum (3):
  .gitignore: add .gcda files
  net: rds: add option for GCOV profiling
  selftests: rds: add testing infrastructure

 .gitignore                                 |   1 +
 MAINTAINERS                                |   1 +
 net/rds/Kconfig                            |   9 +
 net/rds/Makefile                           |   5 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  13 ++
 tools/testing/selftests/net/rds/README.txt |  15 ++
 tools/testing/selftests/net/rds/config.sh  |  33 +++
 tools/testing/selftests/net/rds/init.sh    |  49 +++++
 tools/testing/selftests/net/rds/run.sh     | 168 ++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 244 +++++++++++++++++++++
 11 files changed, 539 insertions(+)
 create mode 100644 tools/testing/selftests/net/rds/Makefile
 create mode 100644 tools/testing/selftests/net/rds/README.txt
 create mode 100755 tools/testing/selftests/net/rds/config.sh
 create mode 100755 tools/testing/selftests/net/rds/init.sh
 create mode 100755 tools/testing/selftests/net/rds/run.sh
 create mode 100644 tools/testing/selftests/net/rds/test.py

-- 
2.25.1


