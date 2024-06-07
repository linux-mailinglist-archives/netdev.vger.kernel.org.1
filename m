Return-Path: <netdev+bounces-101600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D78FF8AF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7461D1C237D7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2734A937;
	Fri,  7 Jun 2024 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJBUPboy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IcYurQQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB6B666
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720603; cv=fail; b=EkgmSZMiK4L3YQYQS3uYH6CMJ3+LefXOA4fzMnNvVQsC6qitq66Aw0d+6bAHqOine/hxuJfjWXmerYH9g+h0wpEbA8OjHMuM6dcMnAx1b6GSfLxI4g9EvPIoUACg6zRtJOv55pJYPVOn6kbSWas8TdBjgzNYSJEnLZteGB0rD2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720603; c=relaxed/simple;
	bh=Pv00Ovu4cnJ9dQx1zbuiCNUvhxton00f2y2SZBquaek=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HHx9uqKDfH3F+zONkN7BynD97dC0SBH052stvCC3tBwBvuxIH7hhALcj/ex6qj5jyzewTaVrhFrqsKhnNsLzh74p3+qtrQut83XOfvFtY9JC7DSylB9BXV4/738u9bXydiIWQ0mfPwx02eszhp8laqZhwrf+8dg+0guH6dnsZOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJBUPboy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IcYurQQZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HwfeM021811
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=LVXe6SueT4SeJjWhOYL35fJwkBbEihSU3/zxLlOf92I=;
 b=PJBUPboyBfA4csXmMh9KVPf2Vs6ESYQGKrP35R34ycfZlvxb/a+lIMHzejtshKfj5NAa
 yvXYFtgCa/DS6bJFJWEbbc+8nquy5NOzy1DDYeoWJXVMW05wBYeXgQgTAC69/u7uBfj3
 l2MHppxxVi769JjhKsU4srXIVr3JW39U30OaiQXKmwvtAm9cgQdb5ZwLL+ER5tZ0MNtl
 yHa6tZ0y5AhydaAXEtVQ90MWYqKRi8TAYdDB+Ycst6pzeXh2Vn0f1yrPCxPh5AeV/6Cw
 vVjWPk/5zlwGFqEyIrkwUkeC1uhfHX7xN+3atNLqOsbuWAwjV9QlHJGEvjwqOdMZVTU5 NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjvwd2nar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456M2oM1015580
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjg0a4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFF5sam8ZirizyniBduNy17Hum+BnwZoc9kj+6qzF5zuMiLnyjxCCxn0fe1XtwOARi0kyK5wgmzGxeidlZzMNzw4hZ/tnLFtAFqaokDp9P4uk8Sb1OBQAVm57dzi6XYX3l65xQjYOEIvTEFxBlGJxERHAYJstCdJo/TBUx/E+BcRZq7UYxoD3vdDzr9lKBOI9XsTPocDZ7BtyzuLz0aR/0BX8BB7rBG49BA4qEg6e5svEMokObnJMSjqNf6hWk6JWBJlDlwwmu06kwdb6K/2Qhkt8167w2pau+m3bpvxPbWmV/n4M08UbXP5eMpN8AChQ+POvb8siykMcrKuI6My1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXe6SueT4SeJjWhOYL35fJwkBbEihSU3/zxLlOf92I=;
 b=gtC1ivpjX8K1U/XpWa9OFAlONYnkbsqDfxF+BVAd3J8Aj3jjjwvGFpd7JOmGUiPCxQrCga/pbZKyoBqZW0JiTSoUDEJA/ff/So8FUHji4Ah99cuzZgV0w1CcBXVDBfCfCoEumUhlWY+3RlA+fa/+AXPll7ZRe/TroMxPDhQkyTY8TDw/ooNN77PTzWvWay2cteMfvs/pbg9kabXzRf1J2RdNy6rmnCQC4syUwil6bV4ux/KDhT9S7dL9LxkevKlHhHaVyaMtrkdquj0qFZ2bm7aGqoWKwryOtPbgIvDv/sGN6PuGxoq2gAKPIIyg4KbchRMyN/h8sKNy0hUYeXPP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXe6SueT4SeJjWhOYL35fJwkBbEihSU3/zxLlOf92I=;
 b=IcYurQQZy1vFWrF3wqkRWssjRdaF9m9mz63g/Y3Ek6utPKzD3VxFBrvEqs56ddehG1PkyiXmMPFP1c7MtqfvOwEqrP4/U4TfNdaN8JLveW76I6lR/UBI17hKmFui3FP1O1YacVWE2Wl0oVxyPdjnexAV7M61Dhwqxr0gFtzXgtY=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 00:36:37 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:36:37 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [RFC net-next 2/3] net: rds: add option for GCOV profiling
Date: Thu,  6 Jun 2024 17:36:30 -0700
Message-Id: <20240607003631.32484-3-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607003631.32484-1-allison.henderson@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 69aa7322-b01e-4cb6-70bf-08dc8689e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I9laLSJKkceYa0kQ1GTHw7jCrXXympMHSYxdcJqepL/eo5ES8LyVk9mjc439?=
 =?us-ascii?Q?Vjp+9rRtpiDxdz4NrXMhFmxxAsFNB+LTYZ5d78uq6iMUy+WBHxxoTKFEjDet?=
 =?us-ascii?Q?Sxk7qPRbfs6o+STTP3x1+YGGhHUJHplSnk7keB3vXTuf4Q9pcCI1s29Heb+c?=
 =?us-ascii?Q?e5XyTHRB+bq+Tmpj2H2XKybYahO40FulNkpDj8JyZYlnaZB7MDdRa+gS8TrY?=
 =?us-ascii?Q?djPeZggGO6kp0KuygN67fxp24gx3yXBiGff1lWzEuse8q4AHqIWYogabRCuW?=
 =?us-ascii?Q?3e0PIgMQafERFlmzsv+oXZ2XVxcZUBvK1u4KouJd3aIhsoOjTT7lxeNt6/hs?=
 =?us-ascii?Q?cJunJFd8CFGe7d3cm9HyDAkPswKczFcDX43mwyjeJcK4aGnd/90FTNWjpSOX?=
 =?us-ascii?Q?IfPd+wssimaAdIeWK2XFNMJxp1h/HPDrBJffjZoGivoLSxI1utcHt/mrSxJp?=
 =?us-ascii?Q?+avQej0aukKuD1Y4n2y3aZBwnAJRuKKGSurLJKpKz0cGleCDmj4vwZy4ArVf?=
 =?us-ascii?Q?K8MORrxmq6eyz6iOvhqzSpJnTyhWxZJP7F9LRwi4zJdk/cosbd0wr1//da1Z?=
 =?us-ascii?Q?0+0GMeRilQvH9NuEpkRiAGUP6NpcxH5S97Pjp0+XzukPLD0RQaFjHRoE1oqj?=
 =?us-ascii?Q?v09Pdqrr4zERMR/Col25O1GyjDR4W6Co5Jzvld3Jc6S8lBZy8hBHOn0MjR7f?=
 =?us-ascii?Q?yjamzptH+xmVNTH3aLNS8xf4ZnBk8MGFuUZFXakPAg3qImnoQl1siZGvYCqA?=
 =?us-ascii?Q?N8ZMcwgdEmccTlP6UjMixUybt0YlMUzNwwW2mZE5mBg8gfkvzh+G6NIJcd3G?=
 =?us-ascii?Q?OC6p65wH056MWw2QfFGhlxt6nkhZp/liAiataqw+1OQp0WOUZOOwKqYGHSZm?=
 =?us-ascii?Q?n9T78LWqS3OwTQzbRP8LM/wIlb1A4ia7sKmEcHp/a3Zut5sl4/La967q8WHS?=
 =?us-ascii?Q?Oj0GKUifA79CzE/x89Re/6flCK+1u25/Fpfn60vLjMEwHGpVpM/6c9AVFhTp?=
 =?us-ascii?Q?EQMciggbkYCIjvv7FhL0cUqDQQ+/mWQxp9t+cjsANmY2rXqFRJf84T/XM4Dj?=
 =?us-ascii?Q?H3KHF0CKF+8bawOY4+NDyRBRcp+57F3OtNSpbPEmg4OHnL/j7bm1pmEMxIOm?=
 =?us-ascii?Q?HCu1qmuQp8ZTfPvtZHzikKlr2FZ8Aqs3ZSjSzh4rF2EEtwYXZwHejXgmDDvP?=
 =?us-ascii?Q?quRoyACqLd7hQyEzKSNL9sJontlJMcDUsA407/f9Gmo1+JPtbW/d6mCqjehN?=
 =?us-ascii?Q?5Kwt8FciZHPVjcRPKAbG1/VTm8y+VpcUTNwnkS0i8acoluksNvcgy8WyZ+pY?=
 =?us-ascii?Q?m0s+w5aEw4NjA7tOYjnYiqTY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uXoKCcGHs3Au469Lf7NbQeOGnS1jUpg81Lbkcc/oyCl5uAtkpUwe30my+trt?=
 =?us-ascii?Q?HSMjGy3Okoc1DrJpB5VvKoGPCcJGLjJ0utPbXNm9QWBEnVxVFWmy9Eci/0MP?=
 =?us-ascii?Q?T9mL13c7E8PdtRzdg2nlSgMlviRVgvVsHd8z6sRgMV1XTrI+AFqCgiN2jzlT?=
 =?us-ascii?Q?phT3X+v295FkNGyeGYKOsTfhyABydSGA6bYYwc5QS8HH+QkG3mbNIp6YkzRq?=
 =?us-ascii?Q?HDJnchcxp1f461TMBZYVSjkutWl9nW0XIHM7a6thd67HpsHW5OF4KWL4bRXL?=
 =?us-ascii?Q?HLkXYOxIc06CGxCzHtmfCyzhbCCkm7/U/dlfbFzYCoU6S4y+uxV+0n0qJ46T?=
 =?us-ascii?Q?jOT65M9SuBO9MpGJq+++hZbpwB1cZK0gIYvjHNVoXWsKBCey8CRJ4a7X3Uia?=
 =?us-ascii?Q?bUlLKkQg86GFJg9aHaRAxNUEWL2356ECp1NgAZtzfrtWXpctsyBzjfK6XLHv?=
 =?us-ascii?Q?rj82xC4Sc8sFJfHGs3SsBr2CSq+F41NzSHw385/2/7BgAAH+AY6Un9LiavWl?=
 =?us-ascii?Q?/91XdVwRWfiPk9ehJyYVVM2l1EBt/rWO9O4eSlljhcRY9ADlMy9yQvPrX5mk?=
 =?us-ascii?Q?ryNIDd2WNcSHrLz6Wxkorsa3w5bXqeEUt26ikybbFR/0qzmLGTN/cNJo1K9M?=
 =?us-ascii?Q?6rcHPwDz5//VUmWzxY2eeZnMzNOwct6RR9yIS9RZ8dZd3qsq8KOtt2fGntz2?=
 =?us-ascii?Q?wkWhMyYruegHKCF7itTHCxAhEXh3LWlExxSFW1W7+XoxP9rrCFDhgpxM6vew?=
 =?us-ascii?Q?+OycbTinAyqRBZ6EHHmBmbZlVBMOOpVrr5SaVcuSAkTy7guS0qZbmMTPMaSy?=
 =?us-ascii?Q?9WkRu3HLEp6Oyu/+UYZzRPU+1VLBU8NVybcITWirT1axOx8fRV5Mdl57bMdV?=
 =?us-ascii?Q?JoTbKP7b/+3xeCTgNX/FyUyH3Ns7WkchainAF8eItnxFT91B0a8wsCTEwM0W?=
 =?us-ascii?Q?0wYvrLCRjeQIRA9wYc4q8VESJPOFXB0sxUy590F8oy53AIgZgbAs4ysx8AnH?=
 =?us-ascii?Q?rryFcvtx4yZ2Op1VUasFPtbrpD7XCG756SB5cf83vyF6ua23bLYu1mvdXHTS?=
 =?us-ascii?Q?SnuYeTZHOrtnsrM06rcKX15jMZwvrJ8EXTKrieD69L8JIcTQBsC7AJIN0GpT?=
 =?us-ascii?Q?jXT0J1uPKnPlOeqiQwrWCorgBpSwjJRQGKC3ba8nBEo9OspWG+WK+Selvz/g?=
 =?us-ascii?Q?iIGk6nwHhFlzFiHWhDSyTNqVUwSiBZjRDITOxOt8lnTUGzncRnfDznXtX6pe?=
 =?us-ascii?Q?h00d/c+pLWChcHx/bXiiYJJFSfXOhXDTGA64l/TQM4w3FleLXqn/Cs7nBJRo?=
 =?us-ascii?Q?v1/0hzZKkZWRrgfSiyYeS8qjzF9cANsR7aeLvrf8dxYmJYWmWnCRuOoYj7Sk?=
 =?us-ascii?Q?+VVvkWzt7RIcn2xoI0HfHrBOaXOimFOobKTvCAbL435NOPMkPhTvF4rMo/Cq?=
 =?us-ascii?Q?oFZ1gjkWpyw/xplkeDm4n2qMizGqNNWJqbNlMu9B6IYNU+N75Tketz2PHevL?=
 =?us-ascii?Q?PU3b5N31cUUmd3FSJYH6ZB88pLuqQwjLukiNtf2uIv0zk5nJsXDoyvNQnudC?=
 =?us-ascii?Q?iU8bB7foAiYoiJqsi2U/AtIYXCQXHN7sLeJ0oVfdPVu+4JoynwXMHZd3kU0R?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uMsaKm9jwXal49sBAs4hZyoiPo9n/enS4xAvcIl66yJV193zOcFhqf6aJA+vzptVPWIQiBOs72K85+95vQC71VFXW0TTS5QO3gUfgb8A3yUelUl2QmVSAVCPJGpR0ujFN3G7FoWzKhrf1WRddMHaqQolJGe60O+p0euTGUvYM0NIYRJ/f8bfFHGrLBeLPE9u7Dzl4OtA1eTP1lpBfsx4XFYKTsLIGZZVsw+ZQ+sWcm4lmVTFuoLox27Dg0WFC1o/CiRO/Vl414F7lTgzhe34LaD0wd7pRT0BNGh/bICSt9acMDPduFBlmRdMIa7sj09oi8YFxSKgA1YR/X1lCpUy9FcqvTzXcafzQ2/MnfW/sqRhY+sSx7PuJ0R+XrFdgRDUYzfY7aEbptTR2xqmfQFTfZmz99HzVT2/tKpROslh86NInLcH5YUAN1ijJFvgFYDH+2TSaGoa7masglYo/PSjZj9d8HpPIfNjYjG9J5nV541sqOW6+6UMncrZUbGlGJQNnjG6Zam+vNxA8NyfwS9Uxm+0hMKkF/OKrF8jYTvuo7aRdLi7KWELZqk7A8bpPLA5ztyrhjXC4chsaJB3Xsjvv4lWf8VkNDNwL5MthFbleNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa7322-b01e-4cb6-70bf-08dc8689e3ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:36:37.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfNm7adH+t3WQCWg9mR/eW2rCd/Ig4p2fcNzXwuBAMyVI5TGivmtxyMxRspfp+LY/dIWtVcnCtkoHMLYveXFGUQtAWrK67mH4Keqj51mxNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070003
X-Proofpoint-ORIG-GUID: 6P-L1YRAZ3UIK0fe4abhIyILjb0kQBEi
X-Proofpoint-GUID: 6P-L1YRAZ3UIK0fe4abhIyILjb0kQBEi

From: Vegard Nossum <vegard.nossum@oracle.com>

This commit basically implements what ftrace does with
CONFIG_GCOV_PROFILE_FTRACE for RDS.

We need this in order to better be able to understand what code paths
our unit tests are hitting (or not hitting).

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/Kconfig  | 9 +++++++++
 net/rds/Makefile | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 75cd696963b2..f007730aa2bb 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -26,3 +26,12 @@ config RDS_DEBUG
 	bool "RDS debugging messages"
 	depends on RDS
 	default n
+
+config GCOV_PROFILE_RDS
+	bool "Enable GCOV profiling on RDS"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on RDS for checking which functions/lines
+	  are executed.
+
+	  If unsure, say N.
diff --git a/net/rds/Makefile b/net/rds/Makefile
index 8fdc118e2927..3af1ca1d965c 100644
--- a/net/rds/Makefile
+++ b/net/rds/Makefile
@@ -15,3 +15,8 @@ rds_tcp-y :=		tcp.o tcp_connect.o tcp_listen.o tcp_recv.o \
 			tcp_send.o tcp_stats.o
 
 ccflags-$(CONFIG_RDS_DEBUG)	:=	-DRDS_DEBUG
+
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_RDS
+GCOV_PROFILE := y
+endif
-- 
2.25.1


