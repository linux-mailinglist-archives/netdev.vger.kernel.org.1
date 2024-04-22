Return-Path: <netdev+bounces-90027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B28AC8C7
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0923B1C20FB0
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8154FB8;
	Mon, 22 Apr 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/t0FiXs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wURLjb0a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E055E74
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777649; cv=fail; b=WjOWCt0JcONdzc28GfUOBPmegdAGOiRjKejK7yHx3so9NABh+YWjv6vnBg5aXM1aQ3f/u8pdDU3t6AJjtbNwXbYKOCZBg6HKNySsFTrXPIM1YYLDXPwqD/JsZ4LVBXsN5dOQ4TG9X0pWF2Sz/iHgn+kcCHFxYCGoeen8iunj7zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777649; c=relaxed/simple;
	bh=Q9bpC9nrjh09ueF3QGDpvSSlKwVLgGFcHEyDQElKJac=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pIO2NF9Q8iBpzwqISNGvxpkvopVUlEhAeVKIp9/b7wEKujCBSJKJaBc+nxqLnKCn2+Kq/TptUSxz6Kt+L9RPj+XRc0LZYR0FPT5wIR9XBGnvrnawaTC39kwJzzLsZMzYbd4OK4cDkki/ACbti5EsFckecqJGQiKHW3rby7i6PFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/t0FiXs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wURLjb0a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43M8ALFg018451;
	Mon, 22 Apr 2024 09:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=E8+fd6HMPDn4RHSl7rALf2Ia/T3pVvQZtvSNV6TUGd8=;
 b=X/t0FiXsQvjUyVfhr5hhdGmENO6mddd2j5AGzZtDOGBmBxu2GP9FYxhj+3gZvRM58UNA
 RM4dBpVEqbFNFDjYRztU7icGJKH6jvFRTvIDnZ0EhqyidRsV8J87bcRTiYay6aBnkkCv
 uOx+fjITVipN3K15CBrL34v7CE3zyICSBK+6L2bD72CW8aQ5axSxxogARp/nuMXFFgTI
 nY5S6w+rTdCfXrvHy4GW5L9PLwIgvSV3mHhW2EEk50XhL0khTlilvbsFvMAgXJmFKboJ
 Waq0o6PreXqbapkn8neUrXMwio+nw2hbkcCSzrcKqn0HvHgswnLO4xcVR/ZCeNCBYnND nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbj6ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:20:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43M8Ako0006883;
	Mon, 22 Apr 2024 09:20:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455aj5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diNtLiLNmQN3uAN+6J/6+B+CGTvSCGnKsUEDLiO47eIs/m/nwM1lCSUQ5lWMXhdoJdylek2khM4063MOdJ44jVIka1S+5GcB4CmIynA+/EddhJbx8IcmzxiGAMYNvizsQqEuBI/qfioCBHYnV2WNe5rTRnB/Tj2PCIpi7C//U4N+HtekepSD+WU87QdRi42/GP9hoeCoqLZLWz+tlZthK9TpZcFOlP+x9Le4c4WEKrHQDWhEwcVCpjkBkttEN/meqfys1CjouBW/YLiTV7dbYRdkxTwVDQHFKdPkw3UmiWNuvAsEuND5/LHIQIulRBo6ZkGncakGvFnMNcIBvOHUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8+fd6HMPDn4RHSl7rALf2Ia/T3pVvQZtvSNV6TUGd8=;
 b=a+TDBGjaXp5RtwCRJI+Hhq8JZf3sE22B79MC4z5laeM5RDjkXS5V9CWSTfcuM+psbiMy5KTdTLVu3p6Mw9WnSkoULduwYwbZLr+v8SNU4bsVHWJoUF+CR+KTIJ1ITRXr+rmPIO1xUk8aaVp6VbYLJZDb+WMfZ7L+HRb9mylCuE6imte0oz5RXv4OZQLtxOmF4fKfNjkYTWAEtpFsvQEIeivq0CZzvzCC1t72KC2kN0xd8F0UJhSRNtFqxAyis9XVbUtNF85Q0bT3G7WP8jFUzwKbwTEAKciGWAiwKb7prf13XRIycQgroMv2W3C86SEk1OBXj1geNACloUuF/fsH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8+fd6HMPDn4RHSl7rALf2Ia/T3pVvQZtvSNV6TUGd8=;
 b=wURLjb0abZXZHIRKHWjmCiXux8Ur5zQsxk5CUi/G6wiN8gDrjYCA9UhyEBw9NixoV6qq6l90JleUoIvRBTf03zFvyxXs3Aco/3DKBNau6Ajt3Gij5/Q+gfXXdIxSjhj/dVtOXhPkAv0uR5kFJlcYOmgYNpEeFLatCbAdZY2kKsA=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:20:23 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:20:23 +0000
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org,
        Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH net v2] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Mon, 22 Apr 2024 02:20:09 -0700
Message-Id: <20240422092009.1014444-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f5da65-e64c-4f76-4c04-08dc62ad7081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dvGW3iT8uMBMkLsRQJNuo7L+88OtWUseVRicHY5NPT96Lh9/Q5UM7kGOtGL/?=
 =?us-ascii?Q?PyXC36SLPbGea2ySELBf7yU/i/0AiglljByGEbh7l53apakTyscJ8LDm2QXb?=
 =?us-ascii?Q?y/OS8YbgdqVpNO1lBghfcE4b9i0eLFxxytyajpUBlmInZhUAADnogaLOheco?=
 =?us-ascii?Q?sNdfiE+wKQbIRVhCffIGvoDEEvMrCoyilJ/5zMCiMmK1kdsxCZE9Xxi9eC5U?=
 =?us-ascii?Q?WIGMfyMSRozGISnjyUcPckpVS30cifxRzzqLw1pQi91kZ9P0S6p2VbzrJmy/?=
 =?us-ascii?Q?8AvIwe6QqRCcKiH/1iRzronfsURKBK1nWAAt7eYSED9+ftOvTUl01hmtGSyH?=
 =?us-ascii?Q?oOWGqAAc9hjGDGKSh009uuYqi48l8YsJd2pIan1z1MmKALogCgoJAwDqkCqX?=
 =?us-ascii?Q?0n/wLuA/bIOwGi/8se/MzhsS4S/c7Zqol/x6+GIa2dYU73LzL6HdEWDCCr1J?=
 =?us-ascii?Q?hAQvy/anSt4vmgkgvnOZpVKxRkUPtWpXW0hkfwU7TUdq5fprTyJJ5QYn0ENg?=
 =?us-ascii?Q?d/vOGcKWrn887OEfhEKYIpBMzWc2QODuOXtACKdqF85HyBeKW+VqAJk18EX6?=
 =?us-ascii?Q?cIgTKmYdqOltLpMhQE0OF7iLYEwAbP5VLA60wzJrNq797N3+PGFs2T3OvdHv?=
 =?us-ascii?Q?Wa58tpSsyxhDEdtz0eaaMlNYqU7kQrm/bz0VUooZU1E0HxqPaJbSdrogWWC4?=
 =?us-ascii?Q?dzaatXlxo4pt7Du5OdwrANMCtPFKrA2T1L2MPuKlxE6CqDMPJu0/5YD5eAPa?=
 =?us-ascii?Q?KAX+yBuJ7wIDxgxh04z2pm4oKNxhIVtHRLoC+QAx7kZ78LGAvlbchDaeDyYa?=
 =?us-ascii?Q?U5pybFur40GJRauuCvN5MOFVJwcweL0/Pnsga4Qmd3YF35FUpW2UUiWLCZnL?=
 =?us-ascii?Q?mN25W1KUcU3ImIDB8VnjYRg8ylX3LRGlrNRisKMpd0ohe7r+4aIOJsGGvnSD?=
 =?us-ascii?Q?glSUOAm48q+BYb65yv/dC67dRX85MSwJA6icr5QnSxDnnp1+V7kx/sMxpkIv?=
 =?us-ascii?Q?vtavPMnnNr+BRoMkObvF7WPW7al9Jey/cBRKUGyRnH1WkwLQylv2YWco1fTE?=
 =?us-ascii?Q?tgI47SV2aMHt7VYWMlNQ9KkJouuNe88ommsNx6jJvp7yoSS9JwjEUBAyi5a3?=
 =?us-ascii?Q?CCAC75SJzQVWOtwRNQN99j+rVKs0HoctkhJQuR41jba6qvNj2gcv5O0Hc7YR?=
 =?us-ascii?Q?I+rcsO9jklw1CdgSf4lgFnVfM/YhNQ0MWyI70+Qr3uwK8EowREstDdb2bD2g?=
 =?us-ascii?Q?9QdaR+7xWa2VNgV9Mp/XFLRE3AYF/0+Q/gN8UqHNMg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MQjVBvpera/mNpqep6EyEx9DjCY30VdzoZCEKgMFifeo/OAl3v0JbQpLAlMi?=
 =?us-ascii?Q?aNKD0RIjhU8D4Y/ctZYrKtp3Bo/MLEq2rxxqIeSjKTB+M0Wm93vFCnxVbYx2?=
 =?us-ascii?Q?YR7K1R8PjSNYNBpcsLJLxxNYjVutzuxePLlVJOmycaz9A8wIKmNpV7rEJB7F?=
 =?us-ascii?Q?t5JY3ocn5njmJ3LbCySvzIyY9kGF//x7Jv2NL6E2axcGMOrFynitNpr8JT3P?=
 =?us-ascii?Q?KDGSLJHTNdxN/VSn3m4JDnccVpWAAAjTBfH+08xAMDsSt1pW4NLAEq2IB1lZ?=
 =?us-ascii?Q?ogj1SWRgmlLSvIuuWvzuxpyz9b/EQzmaEP8NBa4YrVsZrDw85I3z0XdpRoXf?=
 =?us-ascii?Q?DE7OAURN+nEqCOhu9UoW9XtMKexmjCubPJgKQBZ0rLm/bzj54KyW9zhZCwbK?=
 =?us-ascii?Q?HjU/OtlA39CgsV3+v7adU721C+Ciq59yPHVpSU3m62SuWLmjsmba4nOdWChB?=
 =?us-ascii?Q?JIJvoc4QTbvDzr4ot4urFmp6E5jTmP6lnHzZ7JC+074kitSELxLZ9EPv2EJN?=
 =?us-ascii?Q?JwQU6F/k5GS8pmbZUF8vNgPco6fWow7o12P+gePz5BtKGTU588f0e/c+/nzK?=
 =?us-ascii?Q?V0y+/iab/7gaaiz7eovBj/6uKOcFhUuKKR3/b0sz7ZY3hBhKxjrbJjDFOJLG?=
 =?us-ascii?Q?zdTjXVpb8dNZB3c6o7g8h0BwCz9wVrsDH2aWUsfSpdiXH8mrc419gC4gjfFe?=
 =?us-ascii?Q?hj3dYRXc37RNBnTI/t5S7tEkczFQ2RZk8uCMbqDp2FdjJHrawgDUhQNAXgPk?=
 =?us-ascii?Q?srpFcRupKUsJGQYh9KJFHYDHZKQfFmMDqml2jSZg2vRM61hVXyZqLm5aDLEP?=
 =?us-ascii?Q?sx83TWs9P0oMk0SKCxXavcfvRY5C+8H+vjDS66V3MNn2wvv8DVGaV+2/GbnG?=
 =?us-ascii?Q?F0nKNeZzQCPS9q7LtvLE68M66qlYWZqHutM2tuCR2urQ68XuvtNhH2pbgqOH?=
 =?us-ascii?Q?kxDx8mEufQEbgtEy4XeFySQr60+viUnfeYsBjIisanz7OqOdvMhEvfDEMcXE?=
 =?us-ascii?Q?5Lg2YZhaWgc+HYYlP2z8BUaHjYb/aHtfL3EOFsiKAEKbzYwDkmrzMouZ88y1?=
 =?us-ascii?Q?r5rmq3LHZFqTyuRwVxD2mV9GZRhpY0fao3lYiV+8nLZjAmjJrnLYXEUDG/W8?=
 =?us-ascii?Q?0SyDBNwN9w1xxChBzz69CFBYh5JomcXIzKx8E5tWJNAZW6dixHQXdblImjyn?=
 =?us-ascii?Q?lZFlopItBkpuhsnQT9n0DU3ZOrNcKUgx2BKvhiNQTC7rpKKxkYPwmGQCRKOQ?=
 =?us-ascii?Q?7PQq4o/DrqBLjRQ+8YqWIiVUvHZmEP8jKYlTn6lArx/clzT0c/vrbCmgNHeu?=
 =?us-ascii?Q?cHLvQ01194sURv83Bsr+OwV112ZH+odOSj6H0XmoSpyU/NexoCsBmHV8mGzQ?=
 =?us-ascii?Q?eyonIuGXl+EdMnFfrNSIENJ5TmN30eiKIVILogF7VowjqbwgRX9vp4a1TGSG?=
 =?us-ascii?Q?Q/Q7YH7u7T5++SEWphnZqrMJcGetibixNfKVCf2V8Twr/QDLMkHfzT6gNlmb?=
 =?us-ascii?Q?IoWYatqGnwfwvgzq0Vr4tKEfKmq3fLJx+ubHI0wmocSXWOenCsjX7J5CGd82?=
 =?us-ascii?Q?V2Fb07n5ebQPa/KNtf1YuQlZ5Pf18EM2o4B0CuZe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W6KLzKWzuqxFb3N6sgXbm9/boj9IJPmQ3UKUe8qQBScCMW66xip29Y1YJA7F/+xL0OWL6Cgz5pl6kHgRK1tdzK1RFkYhHYw0uYLaLUEsGsrsNvqlRBoR4oIOdi/0GN1ioUMRnuok3ZKBCrlSHMFcoOiGilfl2NNjvM1Pdn9SPoxxkvmaCEFuQBFKdNiMLrD/koLUJ9WeE6rbi8nelql6mm/KqyUtpRallywXv3HUP+/zVz+SSZXUItcrDtCbn8dIwmqteriE1Z6dJpWydW51uaUqGAoc30gLn63kb5+c0fQnAWoPe13/eaAWMLt4azeJtha01ds4XcoDkBILsFNm/eFwhYp6ghZVNXJafEB+mD4AkuO8BoMOBvhhT0/F072/FUqwNES11dHa8NZ6mwuX3OpR1UqXMsC7D0DVqkElsvT+YuGQm16brkiWfmD5qqUx69lFizxX49GX9BmbErKqUXe3HKM5RBnmSV7OAmOZd3mDYITxRV19S4QtC3uQnGLQGAAXzo+qON67NxcNcfrRHV7p4Db8TDYFaEJLy+QJv/8LMCnudxfrmsNwQC/mkn5X2SDTIffVTpMdTKmlS7F8a1VdsYjMNlcwgHNjwMswvro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f5da65-e64c-4f76-4c04-08dc62ad7081
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:20:23.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0C4pasgUsbeYVIG/vcV5iYLECncp0hAwnsDwTAAGtlb75jWrPL9+UbjBC14d64UGJ5K2WBGG0/9JyId0zYSpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220038
X-Proofpoint-GUID: PlpI4cHBw8pt6X-aorcI6Y9fg06QoR3j
X-Proofpoint-ORIG-GUID: PlpI4cHBw8pt6X-aorcI6Y9fg06QoR3j

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

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..3b6a6fc6262c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
+					skb_unlink(skb, &sk->sk_receive_queue);
+					WRITE_ONCE(u->oob_skb, NULL);
+					if (!WARN_ON_ONCE(skb_unref(skb)))
+						kfree_skb(skb);
+					skb = skb_peek(&sk->sk_receive_queue);
 				}
-			} else if (flags & MSG_PEEK) {
-				skb = NULL;
-			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
-				WRITE_ONCE(u->oob_skb, NULL);
-				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
-				skb = skb_peek(&sk->sk_receive_queue);
+			} else if (!sock_flag(sk, SOCK_URGINLINE))
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			}
 		}
 	}
@@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb && copied) {
+			if (!skb) {
 				unix_state_unlock(sk);
-				break;
+				if (copied || (flags & MSG_PEEK))
+					break;
+				goto redo;
 			}
 		}
 #endif
-- 
2.39.3


