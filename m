Return-Path: <netdev+bounces-181739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72654A8652F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2180444B60
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492A259C90;
	Fri, 11 Apr 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZmZA1FP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcM5EA7R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6EA23E34D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394543; cv=fail; b=hT+dGbqdVe0ZojjONj2S3p7ee3ew05ng3HNydi7USkvzztjgdmtN028uZlOfA/0XoNmdbEI1zidOEpi2Zb+MPElDZMr46F3Ay83jBvbV/jQkBx31TbicJCrmSroX4GPdx99EDDCX4m50RFZ4Zu8HTnwbZcguRvXyJwWil7tyaqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394543; c=relaxed/simple;
	bh=LWzanRIs5adUYLyXvIw6IWoQ8bYAth6Ls1LSfwAQdcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ax4ivsgjzVz3eHTT4X0JVoPf6qPohROgRMnd2r4bwbVQXa4ooBksM9ECD8UXMfTTlwf1J6skCgUlVNBY9n1HzaA9jMf/CCvePiqgwoA+MdTDKSwoCqHjYjPX5GIx7AHBb+WFsTkGy5K0BfBjjNs28yzzWa2PxBoRgdGsTItE7P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mZmZA1FP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcM5EA7R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHlMfl013213
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7q/QuA30PXU3rhLCB/kNfRZ+duSYoyaqcnc7m/VTlXo=; b=
	mZmZA1FP4gV5j3ugrIY2zhG9OpoYcAEB57eeMWloKfyTPuAf3l0ptUdtxxN9bIAT
	ua1pjT1vpt2L7G0MGbH4kM0v9ZfimVudoL1HnZiBuw2SWhxFAMeEJfHdE/rtBhsH
	isLyOlBeL0ySvxhBd2lPbmHrGacdyXdEVbUUtGYCzMmKbMF04jasVpowP0adXYqr
	zYj1mi1BntwPKjj5TIiQMmhyNMopVjPm9jkLpcmHTsc6W0X9j9me2E/f0ZeXCMhu
	rYFwUHBfquPj3iZiwu4SXEjJwM1/cpmmzqF7f8MrVkq3zJ1OHSVPT7MAze1u4NLX
	wAsByQp4IpC+m2QwbJvaQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7sfr0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGSUxp001741
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttye07ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIZTDQRO4XqWdMUpAVPsJsu7Cp4xmMWesAH5cu70NnnP2lC1B0vg/YE1/0pGEfBrxWe/GrP7MqXkCWuPYzq6BfS4IKBJB2JTCxeOcyKxXL/R6V3VOsi0XUcSxwdgtZvH8+v0oAA9o2MmOc77W+W1qDzpJjt+lLrBVJl1IBMBYpUjyQRKONZfEpunlqlV50/ib9gn1WKCMEHJZhoNCHAtHu0OezLM+Xch7rUqed6eDpWz5ZOS6QLtefuXj0IxyuLJHSyPpRYo3KfVJpG63kltkt5/YcuCkOfdSvbwiQhPNioNy5hZ0Wjl1yKf+raxsHB1mY272WpMWyI88yh4ws1EFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q/QuA30PXU3rhLCB/kNfRZ+duSYoyaqcnc7m/VTlXo=;
 b=yL20ftVcsCBMfdoo0wb1oLOfV1q9V3/9C1zBW/NSB/tkzFjKqxMar7Wx4AX6UYqnnE+3879G3EO0TIXZ2Glr8k0EPZP8zeILcsKSqnJyXua9PO2Ycp01Lmt6HRiAq2vsP0Dc9vyFVQcHSybtZ4waAJfwZONY8fZDcoKe+jBskV5HUDnZ+DnvxvPVCwuEoEE3OYWyVCEimLhrhbxy5ks4+31h5BgeD/Q0c6NUizYiiUUd22S+Y+oZLHwajXP2kOwwYTTkK0CFtspbWWyJpRMQZIkkBXZrDOeadphcBU6CAXRdmIo1FGgNysXnxp5t1ty8QFIyLhzeQKgQN/Ht7VREMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q/QuA30PXU3rhLCB/kNfRZ+duSYoyaqcnc7m/VTlXo=;
 b=zcM5EA7ReOkBPG1E4h39WQ8xTf3Yvfqvfp10O87kfSQ6t9+BlV9DMeWazV+3XEmsI77gRJ+wvGiMho3BC/HsC3Tci1zW8GIE9HvMi2RH02WsV8Br60ftWJWTQGrLozM0Ab0pjf8S2JnAQfC4Ba/0c0pNHnVY079yrgI1U4GCo+M=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.50; Fri, 11 Apr
 2025 18:02:16 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:16 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 4/8] net/rds: No shortcut out of RDS_CONN_ERROR
Date: Fri, 11 Apr 2025 11:02:03 -0700
Message-ID: <20250411180207.450312-5-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: fca8b04a-899a-4a27-1a19-08dd7922fe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ouNSXeli6Q0R1jcVhAO47KVIqLI+vZuqBuOaBA8YtbQdQM8sxfIC0hfoGAW?=
 =?us-ascii?Q?yEVjdPxBia8kVUGOiBa+++rNsPe5EE87p5IBjiNJfiQKxEexPZu33J+xEgb9?=
 =?us-ascii?Q?qx/4VFXYjuCxvYiHoInsJGbTYS9U4cBpu803BlsYpvojPcfokHRu49wOqiBk?=
 =?us-ascii?Q?gmgZbLp6nhqK7mjA7ZeHhhX4AliFhSHq6LQLRN+eV3myVTkIBgK4KBFzmjFK?=
 =?us-ascii?Q?PlEdOZ9aATPtN3TdLme5cVq6r9rSR+Qzs85AA9iurovdpC8F9IpyO8TAcQtn?=
 =?us-ascii?Q?+mm4uOmfLXsEeXKbK/fUYZv3LZyC6wF6y1R1blW1JjNbLQFXPEp/mjN4UAxr?=
 =?us-ascii?Q?2LPF+gus24LVd6WCgYUP75uPzvADtxJSQyPWmgwKnAuR15chO3pR6RyWeN+6?=
 =?us-ascii?Q?hLEDFIASHqA8FncHdWiS5zHeGQhRCrbWbKX8czEg7B5/lHIPOWGcMpz3jizw?=
 =?us-ascii?Q?X0Ilxx4gWypbahJF2vs49Sk6B3WbKY6PlWcC75M2JVXFAb9uye1IcF5fAV9j?=
 =?us-ascii?Q?rMst44dr1d4+CTZBLLN/t+t1PP9DAK2QMxC31rLWwD+LBm1dhKXwheNUXIfP?=
 =?us-ascii?Q?ahm/B3XNFU5NQLWsSMGDv0cOHeJdHnUvIDbzzszlemzsQpwYYMA6uSU03Vr/?=
 =?us-ascii?Q?k2S1oc8rkA1WK1Oi6Snnzi8AlUrk+7K0Jeb1aiMut9s0eZSZbOJ/Rwfavz6b?=
 =?us-ascii?Q?RSWiIAXUWUTZWW2X8bKLoWuVjLShAJsG82KNZXg5IpbQmU6CY4G1MUBWAc3Y?=
 =?us-ascii?Q?ZDr4TB1IMgVPnurRStqBhVs1u7xYi/8zAnVz16gXob8N+Czwmd96JiSf90B1?=
 =?us-ascii?Q?O4zIOLOi3TxA+0pGlGncokzzePWURccE93aYBJ2taxfCD9IHz4k5NUitgc7r?=
 =?us-ascii?Q?QuKi80vxwXF65UNhEvoe9EHdha2m6bGRrFJP0mJoNgGsIa3DZG8ztk7sEf0w?=
 =?us-ascii?Q?L1lclEfqOutfXwhxwB4uwIxewxBkwOLUYRw6g/qsHuYaV8GLWTNxMYmJUTWi?=
 =?us-ascii?Q?NploJ/bhAjV4OHb2s38tBAgv3LhHr9bE/ZSQvItSWcmIx/9xuvR1h2b9EaTu?=
 =?us-ascii?Q?1qMBo4kHbCXOXo6XydHhP+OhSfsMsg3wrT2AKsqg6lSlfyth8U1PKHX+MBIu?=
 =?us-ascii?Q?lk4xinJzoN+ahzjcCBNQA17HAYcAz7LaJf6yyZTWN1QRKCl1Ev5OUtAjiEgF?=
 =?us-ascii?Q?onChCni2aAqyL5uh30DuhZMldGsSMfuQ1F770m50Y5qt1fOIIM3dmPFYOMiF?=
 =?us-ascii?Q?wV0lXCr/Iah0l0K0jblcs3UfIuSMKKrMNFcx1gwm08X3eAsgXiU5OF5JaaHD?=
 =?us-ascii?Q?fMMK5YCP/1E+3Sbk72LZtkxkDmdV8V5neQiqmxuGQAakW7TyWWHOKnVnrQKh?=
 =?us-ascii?Q?7NQ1XwS5IC72OVxs2DutuM+eF44EOft9QYhaw5EuxCp8q6/h15RHaaGRVYkE?=
 =?us-ascii?Q?6946mUMEjIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CEn4KwK/9MQu+0KPOFYBclHZId+nGwpoYloHkWYPr/2IUBCN0CnSoWyvc+t/?=
 =?us-ascii?Q?vq3pRKQoUvmRcNTpt9BO1DaslS0tpQdSyo6LlE6iH+3bmTBFTnFaEJOKWFao?=
 =?us-ascii?Q?LJlCtXfSVn2+glqeMv3xBQSidEpmZoCLxOCxcoWLn3eODjh8KAk3eISUchJP?=
 =?us-ascii?Q?T6xazAuTGTNieiUjxpZUayc3XGvXgSxdYl6Fe5X9SRepEAsxOi2QnvWhcG+9?=
 =?us-ascii?Q?wNbXrjFmJgWeHYCZ9yF1T8C0czd9ntY59WwQvLPaDZbTH+dp7CR/RJqWV7JB?=
 =?us-ascii?Q?uaDWaY5hZoecKEsOr7xeRFrtR/TuGQIhjEdtBqYm20gxgv4GyY55p8PcGFnV?=
 =?us-ascii?Q?KpUZlYJWYV2QLShCL0Rbm0JKXx5WcYPrSGTJWnfNZl+uxaajaV94TRTIckTK?=
 =?us-ascii?Q?Ot3zfk4Sk5e8GsBMYTC+xBsMZ2XRcZFeWTR5zr+vdWCDUQIoQD+RPp/7Lqgn?=
 =?us-ascii?Q?9gxXmR0kd/qU+nOStf9xiOUmzP4+3kbp+PtljIZ2uaQRnvH8b257FGIGSd/8?=
 =?us-ascii?Q?/z7u29Xmkd3lbc/hWM8vkim7HRle0P5/+qRYEAOgo25CDLg7yq1nhts3jkuM?=
 =?us-ascii?Q?4RTKN2knY2yx3JTM+jC6vPKrotG3Swg/qOn7dCOnMFqCeRkoqYGiVQuH5aSo?=
 =?us-ascii?Q?oOdeQn/JG7UyZKwDGaf7U89ZYtTuoibZQp55F/stRge2aRxTJ85Srh1IOLGc?=
 =?us-ascii?Q?lyuAIG4vxKCrMis0OWDwxqvNVzlehb++jiP/f7t5bKJO/sl6Ay81fIgo5yht?=
 =?us-ascii?Q?tjE0JiDnLxAqwx3QvPUJ2TNEPPR8fuAzqVuWxtmd8quz+7E8D+a/DriSOzKX?=
 =?us-ascii?Q?JwfWpm7TIYTmSxtsmEZ16ur1Gb+F47rnOyMjmO8OtYgNEfBWrVclzPyE884P?=
 =?us-ascii?Q?GeZVCCTkQbFZ6o1xbUlapLxrRJbmBOqEJ2OqZsWAE/OKMPSBDl2apa4Wv1jk?=
 =?us-ascii?Q?7gi1Iptbp6tegY3zBwi82B4NwhQ7/vhw68f4mBO+qh2zZiW14oGnKx7cT7rF?=
 =?us-ascii?Q?GLfyx9y7pnc93SVKja6sjsRo0H0/dYfknoxvhlDLiqB6Gbndqidic3XZIkbG?=
 =?us-ascii?Q?SWuC0qXFOlCKSHpD4HtMaEVD4RxgWxZ2KRRiAMOwNF/wXTTD717gDqhooyja?=
 =?us-ascii?Q?9hqsPSrC3wvrPmN9BW9Yjp1gU5e1rqkSNdEPTI869f2oKf9iHSm3/5Qn7yMz?=
 =?us-ascii?Q?fHCfcRmFu6T8gFcxWBOy0H9d67EPLgsEfxGSYkYUedxgzQPNVXffQzaHNgfl?=
 =?us-ascii?Q?fjiH8Nyx5PTxyfkl+UmUHi0Ib6oRuz8PAnb/VnxE67lh9mbuQdfyONM8f0bg?=
 =?us-ascii?Q?DpHoZn7Qi9gcxyn5v7dEij9o2pe8q0ZrDtEw8O/3iiTw5epMOBKro4BsipN3?=
 =?us-ascii?Q?zotZJnDaxmrMaOn9olDqLAAmzmAZxa6wfiajL31Ck4632CAK9B5Kaac4I4Lf?=
 =?us-ascii?Q?Ofzf91aWqsC/HsQkRusmRWjy6Fy09OOsEgnxMwCQkPJ5g/7xkZUzqjYF5qdu?=
 =?us-ascii?Q?diI4INj0kqUAyGGcHsV7PO5bV3byW+zXo6pC1nwRgoXB485NSVCdHNW+2L6E?=
 =?us-ascii?Q?kd7E1QJDMJ00xSeaPX7sLH6ETXO7yTGT0ynil6gm850BD4alfZjSGFz3Y5/d?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WxBMs1AKlo7bq95r7Hm7aCEtlucsBYwW9VZ8iXVp7bLThe9hql+erpFGU4W5Uh0xKhck5WNnc0pmVXT+MLDlne8dNlkQbvY9/chQonxMpRHpHTeewvd2iTVDFStbrtCRUCjwQs2jLH7NtX5+cbFBGLJ7rOqe6MLkJSXEnGilY0FwLGfY9IJWE7bLLsJ2iai3JeWds9mG6TxrGLpJgsgTJEX4tP0khf4H74GEDlVdH/mHxPJFDmY2M8wf1Oie9v2467Z4mF/L1eGXH76V8whJCfzDqmRE3ePGLHWQK7Wf1LaYVwSuf5WKyNV44XQTHEXPqOGBRhSbj6EqDWu0aRJLwWBMUYkr/XMTZTqcPVLzqEThDyPdwnM4BZoBaiwmD58JTV895+KQg/Zn+aW67OrdlMgxm3WAkNMGhgcG1BdVVK737YzmBz2wnWKqIUh/1adAKMtFY3pA7bLn/PGTpHdSCQhfLQ1xPIDcoMOQqI7C/7wuShHHoD71uBkVZwUpcp1cSTwHRp0A2m1P7+iq0FL9K/MZwMzeJ4WBASolNN7aWlqK0GRb6Jyy0XYbCiHsleqMhbOo8/pz0kgHuyH9ashd/8s3KQvBaG5LUoXvxi8q8mI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8b04a-899a-4a27-1a19-08dd7922fe5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:16.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlpM7RLOADDVwerKp9BLLtNPvX+8IlAZin60b36YeXxurpjk9H7XR+PQ5lMKYxv/ZOTfJ/6bNQmGTtKSry23ECam4FqgAhiP3CfCR27P4hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: KdWN4gEaCeqK6Nv3TFy2q8RuL-SkJXmf
X-Proofpoint-GUID: KdWN4gEaCeqK6Nv3TFy2q8RuL-SkJXmf

From: Gerd Rausch <gerd.rausch@oracle.com>

RDS connections carry a state "rds_conn_path::cp_state"
and transitions from one state to another are conditional
upon an expected state: "rds_conn_path_transition"

There is one exception to this conditionality, which is
"RDS_CONN_ERROR" that can be enforced by "rds_conn_path_drop"
regardless of what state the condition is currently in.

But as soon as a connection enters state "RDS_CONN_ERROR",
the connection handling code expects it to go through the
shutdown-path.

The RDS/TCP multipath changes added a shortcut out of
"RDS_CONN_ERROR" straight back to "RDS_CONN_CONNECTING"
via "rds_tcp_accept_one_path" (e.g. after "rds_tcp_state_change").

A subsequent "rds_tcp_reset_callbacks" can then transition
the state to "RDS_CONN_RESETTING" with a shutdown-worker queued.

That'll trip up "rds_conn_init_shutdown", which was
never adjust to handle "RDS_CONN_RESETTING" and subsequently
drops the connection with the dreaded "DR_INV_CONN_STATE",
which leaves "RDS_SHUTDOWN_WORK_QUEUED" on forever.

So we do two things here:

a) Don't shortcut "RDS_CONN_ERROR", but take the longer
   path through the shutdown code.

b) Add "RDS_CONN_RESETTING" to the expected states in
   "rds_conn_init_shutdown" so that we won't hit
   "DR_INV_CONN_STATE" and get stuck, if we ever
   hit weird state transitions like this again.

Fixes:  ("RDS: TCP: fix race windows in send-path quiescence by rds_tcp_accept_one()")

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 2 ++
 net/rds/tcp_listen.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index 17fd7f34ebbd..cfea54740219 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -388,6 +388,8 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		if (!rds_conn_path_transition(cp, RDS_CONN_UP,
 					      RDS_CONN_DISCONNECTING) &&
 		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
+					      RDS_CONN_DISCONNECTING) &&
+		    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
 					      RDS_CONN_DISCONNECTING)) {
 			rds_conn_path_error(cp,
 					    "shutdown called in state %d\n",
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..fced9e286f79 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,9 +59,6 @@ void rds_tcp_keepalive(struct socket *sock)
  * socket and force a reconneect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
- * Since reconnects are only initiated from the node with the numerically
- * smaller ip address, we recycle conns in RDS_CONN_ERROR on the passive side
- * by moving them to CONNECTING in this function.
  */
 static
 struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
@@ -86,8 +83,6 @@ struct rds_tcp_connection *rds_tcp_accept_one_path(struct rds_connection *conn)
 		struct rds_conn_path *cp = &conn->c_path[i];
 
 		if (rds_conn_path_transition(cp, RDS_CONN_DOWN,
-					     RDS_CONN_CONNECTING) ||
-		    rds_conn_path_transition(cp, RDS_CONN_ERROR,
 					     RDS_CONN_CONNECTING)) {
 			return cp->cp_transport_data;
 		}
-- 
2.43.0


