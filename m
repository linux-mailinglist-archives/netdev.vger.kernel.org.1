Return-Path: <netdev+bounces-232018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F09C0021F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D921B1A646AD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06FE2FB093;
	Thu, 23 Oct 2025 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L0CP1SsT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qzuuuJ9c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA92F7453;
	Thu, 23 Oct 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210480; cv=fail; b=udtzFfcJSmO1FNOUTur5xYzymXaoBuMaBkZP45IHJfgIkwmWgp/3QX3242LX7BYtRGJPzg6r1a22sCpK7K098KqoIBiPANv8/TbM0B8nzsKh/oUQyNGsPSnR3D+DdaalRjvX3Qq5U3gMLc7a2mfR90UNCDbCsxpjN0uTJwxWJ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210480; c=relaxed/simple;
	bh=yo0YU81MQmR+2AoMgWB8qXsL7nXRVv4uDEAOCgODWgw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tS204funkQvDZ9mnTAAP8N3QmB0mcvmZIhoBVRIupq2wIsgu/FeomGTznTn+y9K0SFc3z73fKrB1OO5dzRXjDe39eF+lUs96z5g/JFYmRDAMaSUEvM41Ub8uDhqqdA32mAquxvLI32f4E384c1FI5gAzqLom1946opHDSvNsrEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L0CP1SsT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qzuuuJ9c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7uZ9k007243;
	Thu, 23 Oct 2025 09:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=6qvWjGQ68gcWKk8u
	as8M/kTAQES8HKwhjxGXGLqY4JU=; b=L0CP1SsTUU77njGD+GatOu9JYrR1VPEs
	cUjLGIFjiy50iZERDE5mJP6oVLeoGvyU1Vqb4xOoUY5kCqReW/kqAvmgDm96mReU
	/nQZn/hm+8ZbPm0fl0jAbdQOsv5+hy/VBkM7fVbnhmMUv0yzWt//MyGfeSwiC8vq
	t+c65PBFy3zlOOlkgOJ5yWSsVRy4q3P0uJHcxeASKbBoi+sBJAPNUfv3jHXaRJXj
	ggB+LKyjXCGkhTS3g2P/gDSfaWsFTU4fSrWeI6Rr6m+FjE/nRWCeLr5GG5q7AcW0
	BN6GL/mbRHp9eMnQjEvhq33KZw/XRD3OAJf7XSh0GGjOql9JWRIj1w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0t3rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 09:07:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7DC4c022380;
	Thu, 23 Oct 2025 09:07:52 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfbvb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 09:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUplD0unIeh/Tl79tKS/24/hmkl2FSMbxZyCskHSmTLr7YeyrJRDRgEopvNXyqJnnrEH2xkJHdrc90IUWIgaauzrkmU4YQyeoKi11zzAudMhBO0WQRJxsDttxshYdCYDAwRvdv4/hnrHQsFPXgd0QrVdk+Wc0AnEDTEx4kqx3wAgooYw1/wbA1M1ek2hOeIdmkP5dhZw/IR/yqC67UHFMg48AlzWVdEyn2cUF2MLmq+VbanrTztQBhg42JAPZ0qzDBqzpd9UyQWv5pnMsqWZrmLsCzrut81W/co+EQDdeIgA5vvbE8ssYy6zwmKiDipns1eIMau+mW4s8DTqk1Qbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qvWjGQ68gcWKk8uas8M/kTAQES8HKwhjxGXGLqY4JU=;
 b=RtCbsfAD6AcSGZRyOMFFGGHiYeyIwkBBY2CKjPH+SF3N2mJEupJ8EkpAF5aTMX14rvOrwWDk0SKh3pfAqL90TGfr/c61g4scgNaIr6WBoj2/f1sWxv+YaJxrfTszPXv4P45lUtPM/rH22SvVWBCURHvQo1K9PCcHiO8L5ebfethhrbiGyotSDu0EJbOTqJ2Cl/otEaNwBesSnLq6NEKp1nOuGumLHDytrntnd+MuiZvbMIJvSPPTQ/gnMaotyhkT05MgIGrJXWZf9JMC75d8s+ZNHrtjhplv7vvgm2zxWKpfqKDJyBaNPqrJ6xgs5E84ej/L2xr4oiWjbnbC/4VpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qvWjGQ68gcWKk8uas8M/kTAQES8HKwhjxGXGLqY4JU=;
 b=qzuuuJ9c4cIynavX9vzqUV3JEfqquanQJ+qmkPXHA7kqzNVfrWEGWVAQQMkSkCRo/So2+l5OGnsvQikeTUEoqq3g10OuOL+goZ8yQticvZzVDtapetDeZ2n0K+6WsEM1wxBtPfPsyQD7R3BiXEXsmHEl1OSnmeDXnPjg403PPe4=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:07:44 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:07:44 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udp: Move back definition of udpv6_encap_needed_key to ipv6 file.
Date: Thu, 23 Oct 2025 14:37:36 +0530
Message-ID: <20251023090736.99644-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SJ0PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ec0a7e-d118-43d0-b36a-08de1213a0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z8U4MxIWTVWqbnJXwlJ0x9k+hZaqP1dWAI5VHR12oOOtnZxy0EClsg/ggCUS?=
 =?us-ascii?Q?kercuYeVU+TBjpq1xr1iorvl70olUgPlTMvPWoL3voPm+ysz5h/rbMdjfp5N?=
 =?us-ascii?Q?VjXJaH/hADMKM/rtPGXN823fMbnCpIjbIDZBGnHbaLgyZTV5CjMlYN1oEQEm?=
 =?us-ascii?Q?xh8AKOc41+VBPue7Fc9NlXN+aLrWxqiG9pniFw2h7r1nVoRcVg0sbp/JbvDb?=
 =?us-ascii?Q?sKr87lgHjJG1d9sMVzpzfSpR3TWQLneIdAn1LIfQfWB88FwWFN5sfAJ3ZQSw?=
 =?us-ascii?Q?KiheqfRz+KJoRUnjuto2y2rNQxjvVB+PQGrpWRCTvL8Mmvy39uEZeMHK/mtT?=
 =?us-ascii?Q?ustVkmgmRn1qX1yjTUV+F+D9BIFvTBWgIGf3XkIPe8ASGX3yfueViLAZdZqg?=
 =?us-ascii?Q?MjXg2dQJGTygto4g156PQiH98SHRUUu/zfZ0n+eEa9NGvMrgvc8sgsgF3D3J?=
 =?us-ascii?Q?0t2c9381Z+BCpIpCchE5uCj6I5cl2K1ysRC2hnU2qkMNizXfNUA96Td2wCtq?=
 =?us-ascii?Q?aKkMmVaPY3miWq6exfEakw+2qlcGfDjDjLR7wqd5TUmuUBQArWLxJ/dnUFmc?=
 =?us-ascii?Q?PZKyjuWf1dMx16fKK88h25MM4tgsexS1SUacu/1l1dYu7wcJMgkIcqB70d88?=
 =?us-ascii?Q?UcNaOPPlcgxbxxNOnOLKLhivkzIP3J9zDyedmElz3bJDT03QG2QPmP5yeNwL?=
 =?us-ascii?Q?UixROle8WOG7psDd/vM5E0iZIGHIyp/ZmYC/0u7P6DqlZOxdLaF8jhmhwGmg?=
 =?us-ascii?Q?D3Wc6mbe3fl9HVWaey25Qj7rIdxW2a0vmEMjGZ7bwmLPJkYiyWwaW1yvCgS8?=
 =?us-ascii?Q?8OOKFY8dDD/isaxmTnq33GzjkO2GBBQUnFrlOqFwUZDclMl28n0JLQTz0Rxg?=
 =?us-ascii?Q?05m7TfsLPlLMF/6nrnw4OFIuY6RyNRlGhgNtBPX7eoBrqTQwUUNqc0doRWTz?=
 =?us-ascii?Q?Xc/nCq22Fg8FOmHMrKG2oj7UKEG9kcRwRwjYnbaJ/19Kek6z99CVLvV8Clto?=
 =?us-ascii?Q?scGOnjwSwuhZMJqPBQcy7LEZ1stMSDIczf4Kfnczw05qgMKcNlGBQ5lL3IiR?=
 =?us-ascii?Q?mDjyiuRnPPfCXlWqB735IpYNdqPfNO8LAmw0wPrVKUfozNBS4iP39qNf+U3k?=
 =?us-ascii?Q?Vlh2GwOvjP7vPgHm+0pNfaqEDcKhZwICWCeOsJ5fhs+2V4vOctzITgKQc7EO?=
 =?us-ascii?Q?WQwB6+LTCXrkk0XvgqNsDpE+GUKKlUwmMJ2neNm8ep1bDLxWNxTzvfn/ESH5?=
 =?us-ascii?Q?+137fDJ3aKn3xa8n6oioqx5cdYhRBkGHGRf+Ozs4/rNKhIXEHqxbgrGtEiTY?=
 =?us-ascii?Q?1smXEomqThod5k0l6APp7jQQB4q+nzIGFs/bYxoOWEodXs9IQYM9so1DVqYd?=
 =?us-ascii?Q?3Y+TkWXzn+bI4OzxxTR21sYPd3qNKJho6KzdLzepn8BM671A7VQp5rG/LmLc?=
 =?us-ascii?Q?ZX0Xxg8DBICXcfM5lAg3SRTLwWXYHJGU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2jOmCg3xfl4vokHixFoQdQ7dfglSyf7sE8VWzT/6AKS4kNfinFnQlIC8QTF?=
 =?us-ascii?Q?WvAIs462rosg4L2Bifa81DUMrGkhTjF2fNx4hEMwGwAy+2qvgi5BFxaOyQ+q?=
 =?us-ascii?Q?Ui+XT8AsDZtDgWJu4EAPUE23QwLaVfcgZRS26QR/cwWcDaGOcXUJkl9/16Bw?=
 =?us-ascii?Q?eSEAqosmNoB/0idfUmFJ3o3HF9YXGZeszU2Nqoh7urO/FQhDuEa2zDJ2LjpK?=
 =?us-ascii?Q?rEcIsoM4kGrTBqDZYfXjPN02SdZgCajjhLdq/z/9vrdpboqHunLXpruZe4b+?=
 =?us-ascii?Q?NPgnjU/OXF3eJ5CF+8Ko6nquNkZDZP+Kw1Ivedrwv85JmhI1Zq0Z4hUYCdeo?=
 =?us-ascii?Q?3R/ITxkqMegG/m4U3tX8IhjOEEV7Gpx5zVH+kdmNJ+2gma0F0tfcyMXgRXr9?=
 =?us-ascii?Q?8RUNAzCPCYrDDtihT9rCGhwlbrkbOIFsCVh17QPp08WfHfizye/TJ5Ha5Se8?=
 =?us-ascii?Q?FrKJpVhT891g8VJVaTH5CE3dmimEXJivirhtOtQ3NfgzouriGhAdXvxon5vd?=
 =?us-ascii?Q?R2nXYJiDs1A9kOLqk29VoXbjlupCvUzurfAO/cqS6t3jO1MGlBnHuiAw/Lca?=
 =?us-ascii?Q?cVr+sOX/DE/rSrRMbwSC+iv/S3aMsY4710RuTwJd457QsmI4gP16ESaJOXRB?=
 =?us-ascii?Q?phZo0sGuY77yTbuSI6u077aT1jrbnsferFRkDegWA3W7y9++P3hDVy8oalX8?=
 =?us-ascii?Q?aEgliF89/jsfw8OSZpcx0XqFiiP1wpuqLbtJqIZ49BFJi5MdMZRueU3FVEJc?=
 =?us-ascii?Q?0GWPrgdlb5Wii0aJ+awwZFVE/4MO9vkFpv+qCdFOc7o3sxr4xsYC5f4HIp/s?=
 =?us-ascii?Q?X9PyKHXj9QY3yODo8k4lSwzGoicsUR9vFJRAUw4oEaHaNCwddj7y09CREFzS?=
 =?us-ascii?Q?EYQneDAWcTq9BQBCZ3etyTYm2Kav8vMnxKoiZNvBHtg+liaG0X+46RpWdX3Q?=
 =?us-ascii?Q?ruyoEvGPiwtwTW/v/f/WEnnh48p4alN22iOLy946YYsJIJutC1l08JMvad5I?=
 =?us-ascii?Q?TbDRow0/q9kFt7O2vMS3ZukL1Qtb2G2uD6oZR8kRCAN4CAsqWFocLrKsfm0j?=
 =?us-ascii?Q?oDZn3LEDwZ0PsFnvde4zobr0zd5jPr7msjjN+ZEv7/3DBFYkzFXXzLbcrJJ9?=
 =?us-ascii?Q?arluqfHfIlpUlP/NWNsqitc3gL2WChO/QUtFvUV4xXO0xA/4Nng0BUvsAY+i?=
 =?us-ascii?Q?xlQ0lhRs4yQsg+IBNV2O910np1dAQKktv6FaBF7mdGPKQiupZQoJj2Y1f3tV?=
 =?us-ascii?Q?hGZfsfflKveV98SYzrZL3+Snap6mBWdlB3CdWPOIHYDePT0+TH3CaGtavlZ/?=
 =?us-ascii?Q?qebPF6x8Wbi6hkL0HHxP6iQUIljafNoYMpE08jfZNY5+oz3P5sPicH4t9LaW?=
 =?us-ascii?Q?Syr165s6Scg0+34BJdeJd7SqKmpuByHUkxGx46fqASdWPm+MIRDEFtxs8zZP?=
 =?us-ascii?Q?KLhQ5zefwkjlruFgZ+z1/5TG/Yuw9Vxa2fPEzVmh6fEutBQfatj0YEKQ8MOe?=
 =?us-ascii?Q?O92vnKiDVK0hr6BBe0hq6DH9shjYgeKBuQs1DzpeaLaJNxWyg+pwKuR8e6jy?=
 =?us-ascii?Q?ZvfK7x14RuhPeYyjIq4Bl9MjC6oUdZgyB5/NRp/ZRM3xxY+v5OAe9hRKV5IN?=
 =?us-ascii?Q?qfX5FR+yZXaG/5LctD1hKbaH0JD+Uck1kIeIBsAk78N9R/T8aIAHOypVyW/5?=
 =?us-ascii?Q?5F3Wog=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GaMHy/MhRzu15Imu3ENP6C1ltLLz240PjxGyrUElCrvt45ZfPHFuwiRlgzBAqnt+W2f3z4QAVVcxoovdMrMJCNhHRavxML8QmPFNH/pKxm18H2Tomy720HpWaDO1aTM9d/CfQeJ/2h4d0UznesvlutbNSjPUjl4KaUFbtiKFKLPFz0FO+DpPoONAJAtf9pHbWuNA3l77BTNLmuhZsNigyB6gDM3w7+YOHiTum+9DT9om+FEPBVK7wFfuaazd7Leahd5ZwahLnFlunm2N8QHy+go/nURen+cEXctGYNRgPkY5M3uDZcVkR/wcD/5Zd7GRENyo/b7+hx7+VMFVcwNEj5bvYAaxpImwM4s67rzoALMcBEoXxvgL7GNN5GqGEanB2rU+LRjSHidiQ4qkXQqDlmmVlhxxJFB5aTMrz7RCaM2clKFACtM8N7C11PWWY5spTJtpfOJmpkooI5PehWk4Avxvvd5YR4Kh2Lw5fza2ND4vnDcr2PKR3GyMPefXaUud9DXyvnuv40ebIOXGFdjHyCu14QFdUmxN2uG2baLXMwf33s2nwOZiBhZA8gOy9y1mFlu9MA5MolWP135/xiTgB2f8dsQ6+w/o52g4URBiLVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ec0a7e-d118-43d0-b36a-08de1213a0b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:07:44.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvjRJoe64irQC5bEnJ5WECto0wmF4L/DUERnNurv8zXxYmKGJ4PcfPycNCd9MAIEchi6XXmXDlvcGah8mn/Jnm5Rqbl4z4hL2DPiUTl16VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230081
X-Proofpoint-ORIG-GUID: ki5oNLVqgF_ziG4FYgcVxQz1lUII0X4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX3Ti05OQEWq1U
 c6MMhDsS/xKTTqA7/uuutY4ct95I2/WxvCUV2rLjDfrKbHIuohfX0hd4XQeoMFpAZNbsNxxA+3w
 ASHQTSp2WTuoiLeo5NcwrJQcxTy1decBNmTzjv9FmR8Fxd9/Mor3CImejCz5N8firQc6mAO0xAm
 yZHXss8Q8Z1sE/z+ISk9xhq5E30PV7CJNoAJ2pBSu4UlrTsMfey5hMH0qLXBPZfUEnTaCgbeUo1
 27/qXP9lOoX329YO1lhVESZK2D11H821+lwdrYqHwFYOpIkG5s3hX3K4ASVHVF/3uQJPqeTyoOQ
 eHi2TBF+EVfzQLY0hrAnya5J+o6dT14ljLLKZpngfLVFrce7yCiqLwLDWGZA+PfvXQqXD5hLAIy
 3+/BmC1fDH0HNXk2RCyb1BJhCNhSflcbkVqbGosORbr6agQl2bQ=
X-Proofpoint-GUID: ki5oNLVqgF_ziG4FYgcVxQz1lUII0X4O
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68f9f069 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=065indVRFY-32pYzdPMA:9 cc=ntf awl=host:13624

It makes less sense to remove define of ipv6 variable from ipv6 file
and put it in ipv4 file and declare it in ipv6 file, which was done
in 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in
a tunnel").

So let's move it back to ipv6 file. It also makes the code similar -
the key is defined right above the respective enable function.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
I'm not sure why ipv4 key is exported using EXPORT_IPV6_MOD?

 net/ipv4/udp.c | 5 -----
 net/ipv6/udp.c | 4 +++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 30dfbf73729d..44b08ede7133 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -810,11 +810,6 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
 EXPORT_IPV6_MOD(udp_encap_needed_key);
 
-#if IS_ENABLED(CONFIG_IPV6)
-DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
-EXPORT_IPV6_MOD(udpv6_encap_needed_key);
-#endif
-
 void udp_encap_enable(void)
 {
 	static_branch_inc(&udp_encap_needed_key);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 813a2ba75824..6b92d4f466d5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -596,7 +596,9 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	goto try_again;
 }
 
-DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
+EXPORT_IPV6_MOD(udpv6_encap_needed_key);
+
 void udpv6_encap_enable(void)
 {
 	static_branch_inc(&udpv6_encap_needed_key);
-- 
2.51.0


