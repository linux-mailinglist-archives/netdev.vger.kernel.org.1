Return-Path: <netdev+bounces-264451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNxaD7ydqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:14:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE24214427
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F4B730094EE
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F3139C637;
	Thu,  5 Mar 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ClPGH7og"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31F19E7F7;
	Thu,  5 Mar 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723371; cv=fail; b=QyZQ7aOi0Ux9MJdGB9Vq5SPkPlh0oYFQQl7kYSXUAxsSH227H/ThBRtQDJMeeJero+pWE/l74qlH74TM+XTzeswX7cOEd97fcsc0JTfmEa9Iytga7DGZDuDebP0LBUecYwDL8EIhNdRmXIj97Y5Ry7hoFwakOS5L5MYHPcm9LrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723371; c=relaxed/simple;
	bh=qNYkHoMe2YgkzN9JWms5w3zJ3Ggd1RU8nSRgLvaz9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6pQz9PVfsNbRVAiPwYvegmOMG0cWwofBW+eAPY9W2ICSIo3Yxlnb5K9LJSO56K/r2QHpU+E4LkEAI4EPBmJ3yZQFSgF4awB546UKhqFuQCIaNwT/+/Eloy2vhjKwidMP5bz+xhDvg5droSsMaSIBCnWbb7C5y+htZTl2tHzYPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ClPGH7og; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xky7/AV14awUan7E/CPk7lJ0MU54VmL1/talTB4eWQaGONTU55jxbnoq2IqLNdN8Y/HVGGcm30auI1EQaJN3wufPLmREJNbo0cYHz/KWBbwW2dCnUhCvwDAr+Pm2tUorQTOuZiVz+SJGVXeCulknjJsnrSv950b+u3vJCDhKvk1+CScNG10a3r4v9aw+Z0pQgrX+2xbFn7y6bEeLqU4T4Y79bkhkBYDSSWhGetK+f22YkaXoqt8TAKiyufTp2eg11RWUJpT3XjfmguQFFDyOINKl347/GjW7Kv8ApptjNrszys5ZIRfpAcIv7KgglNAy2aaVIdYxZ/rysikiYTssbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYrbe9JwLaxyBIOCausiiQ2WE9g4C2fiaIkarIPgLto=;
 b=f1CZKpDpE/lXoyu44s1iqO4Gub0+D7Eq2Dn4YOUPx1zPz8ezWBfDBsBpfJiD86MolprakyQ7uG2unro1KeGEYDX5m+t0TRO3XyoXOZel81r3xbRPcQ84nvgD5vXRZOXLdmZQ0b2Vf1eVJiGzWNUHk2s8EcvRYjfAKEt5Iad23R1wp7zDSMn2gMt8ssl0KrAUfS4rFg46ktmUTCRaLx1ebEOH+9R+jZAcwRBx8s0QoKZ5YBihKBZpcmz0BAdlwrFuTy72rnfDmJgyT9vo/IoEejYrmeMRZjOFc2GPmvVhZFJugER9oY/h3eYIrfmnVpmTfmCLcYf47RprgQM/1SAxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYrbe9JwLaxyBIOCausiiQ2WE9g4C2fiaIkarIPgLto=;
 b=ClPGH7ogqkUQpoOhBjFxScU3jcTQSUcjL9xnxu70grWqJVgHR60voAOqzOxVs0ZYFVHbvFwoDISj+klfijSiM/KZ+sfds4gW1OusvXD0cYjaeZgFDReo2pqA0qU8ffjdngYwL33yEUzvRqV6pDCA6ob4s6rrHMNklbbc9YcdD1jjsJ/OFpBV/qabCpEa5+Lsc4O6r6u0AFvznLmqIZlzUzbE8VBAZFU2ERAvY3aWwh++y6hwug1dtsGOpifc9S0PjLDhmYtgchMFPOejM1+3VkPyN1M4P5OboqbKiEMhqvxwIqnHLdi03TZfYXojAezFMaJApNV7Xc7jn9yNFvqYmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10563.eurprd04.prod.outlook.com (2603:10a6:150:221::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 15:09:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 15:09:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Frank Li <frank.li@nxp.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [PATCH net v5 4/9] ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
Date: Thu,  5 Mar 2026 10:08:56 -0500
Message-ID: <20260305150858.3910822-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305111253.2317394-5-larysa.zaremba@intel.com>
References: <20260305111253.2317394-5-larysa.zaremba@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10563:EE_
X-MS-Office365-Filtering-Correlation-Id: ba478947-745d-452c-d5f0-08de7ac93023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	fGNTZp2H4dIf8+v9ScEmN1XWDWOHlXO4+1i8SYoTVZOuZ/SkUsC6iDg2OhSpUnMv+PdC31RwBB/iSzYEDsK79qOhC9OiZvppJnyXTyTPtNi7kmFzfA3NCpGB7amhCpX1qloAGT5ax1O+9t2xxafbz0WPbAd8OhtrgV2xYwbVPdVPCObStbIC4ePlaEQpB748ZOmc5mlD/RfrdtXotkmlWPUOGOt3WfnXbLq5bHVwzUGXRnoQOwL0C4AaPBYMcH/BBQo5lCHr3Aw875UbJlAJPc8r/CHhz1O/on46GSLrXE5Dn2PotLBMQQHAkWGmbnVZ1uPkI6vEdlamPByeC88dmHgxG3QqKzuCVP4Nsyr0gVmCXh7ewrguna6xP4+bDnq98J8HyvaqDvuxB90tddnQ8WccLxi0H7EfDU8hXGjdVEj71xwFyE/4LrToTGBA3YbAKG0YQoutBmBmgxNyhm0seCleG1HAunkxINnvbHEK7wPqHf4iijq0qEVH0YgCgP/P2BBcCV0GNV8mB0VjT3jSNVAJtm0hGemGVCEgInQIoEw6W0YyyJYyb2t3eoVUGCeDNaw1rlQJqLsv6QLV37VujFCgCaLa2cd7MxAX07BllHSALdi3AnxJ4ZI7zzK12PAAJDq3BRWzuj7SXauT+JA2DJLvz8ZUsuPOWzE2ivG9EBryBC3O7QWROWVPwrHLtNFlGgrNW0N8Ia4U+ujunyHdMgT6suzGuNN2JTWQhMnqwNMWhR/Y0l2x+HV+DTNCeL7Fgx7DAWbsV5QrTJmJ9Q9eKnqQAKV5DtQL9g5EKLEPF04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIb9JUbFBMocWYasXygHlNjr9nQEPuh18VD4j8Huaio2GMmlz23YJSDBSpeD?=
 =?us-ascii?Q?M8FjTEF/s4YS8BHTCPgB0r9IS82h4HtG9rnns9kDVBJCNLFAbwYmTTGeYHnv?=
 =?us-ascii?Q?r08fwe51boAfinhljZlRRowCuoy8HzfTLMVXkohFXeVx+yXajSizlimf1csd?=
 =?us-ascii?Q?G7drVOw0F90nbYOKXcpghoKXZLiAPhio8mx9LkKaMSLU3SaKQs7V9hNvRyk9?=
 =?us-ascii?Q?QRvhOCxZ120HTuywCJ2PWM7k+KXQoK0W8JnH2JG4jTYi/ZdHNytWdZzfWsUW?=
 =?us-ascii?Q?499FxxhWmiZAlGAHA7WqZJDFRHIA2shoOLVURQp7frbErWYUXsyO1iqc0vPX?=
 =?us-ascii?Q?+tPVY9l3nETcYJklxwrqteKBiZ+N28SKPwbCyRatRltQetXSREUMIkaocn/s?=
 =?us-ascii?Q?qw706OMYhKJMwdBOdE1BsMqKTdoyyQ+aLyGcWDajkC1lcvurz26OpPLxH73s?=
 =?us-ascii?Q?Kkn5FtCUKR0yHlfVqqaBMy9iex1/8VB88K6H4zXB2ZO7xm4vcGRRLONWfmad?=
 =?us-ascii?Q?rsQCLp2vTaSwSl6czgYAlYA+dmlByuYWm7a7i71KbAU2uLgBAswIbZ04nL0P?=
 =?us-ascii?Q?2TRRea1Zcugdkft2iXedOh3B2iANH+g9F6r4jTkd99pHDFmXvuaFZxkUeP3k?=
 =?us-ascii?Q?63hZ5rJuj8C6SuIuflLDk1SRh+5nzb4hpT2auiOBvNY37YaLcAdNXOyFMpZC?=
 =?us-ascii?Q?QJ6Hkksyt6b83zen3knt/dN/F6cCXk9ZfqT+ida4zniVoWBBBL51zz2SBXRx?=
 =?us-ascii?Q?+03U/5vqPORmpbMMoW2yaXlCW5qeyP5W7y+aqh3yn/rX9G0Aer8icRTdTQVN?=
 =?us-ascii?Q?s3W5HM9P+DpmK3AIYS3fkB55urO9Ugj0pWLhbathaRID4pSN+3A3+xNvkXOa?=
 =?us-ascii?Q?k/2LAjEmiOQS0r3DydgAnqxvnq8LsqtKxf6RUQUh3ygCqMZmmSzDqRtAFeKW?=
 =?us-ascii?Q?G1HbJ8iD+xm66KqoOwMwvnuyP8jJ1Mg+cked3h533xL2qgjSkqspGgRsPG5/?=
 =?us-ascii?Q?e31C4vFwz/pcoF6jf1dVGIZXYjXYov7fyp7oECSNJiO02EeGf5qvQdEvQPjh?=
 =?us-ascii?Q?TaP3ldYajBjlv4V1TMm2FxiLvBGLyukBPAEbpIb+6gV4j9vPIE9bt+uDU6lr?=
 =?us-ascii?Q?srch9VzeN3YDAwV+a/E3WEC6UvL5O6Kz/NOdU+Igk0X++VMYzJrJMeqsR0eq?=
 =?us-ascii?Q?1eIRJv/PGSC4j4rmd2RFSJixjtIx5LYazL6HT3ZrFX+isQdM2/wk19VUzeYs?=
 =?us-ascii?Q?lQWjtgmhKWCH2qrHhsE+5iIpSeHhADRxk3DNU67+MJnKqZf26mhj/46FJCrm?=
 =?us-ascii?Q?8VMchpqx6EkQkCyAbYAzzDPM5g4eYoTj4qtyXjol4i8PHe1BO8W7ESfYGhyb?=
 =?us-ascii?Q?zJ5H393lkO52EECVzeA35vuu682WjtXEuWrAmBuUQvn2tXFdJByJS/G86xY5?=
 =?us-ascii?Q?ZVtftgXNmcSOv02uuxkcwYO6m602jkCgzFbmkEzVcbF4imqTQPX2TYVAv+1c?=
 =?us-ascii?Q?ROL3/+/Yco78GKmemRMx0yrDlBscMj5QNOWd3QtC1jGZxAT4taw2vW00Sdu5?=
 =?us-ascii?Q?bwkxVq45XTth2egOU/nQ/rAcznGFq9NRdPIBVQ9asCfwIvzC6fHVkUr7gTPa?=
 =?us-ascii?Q?uVfHk2/2NZCkzXdJUy7GYjwzRUqZH/d757TI2dWgCszA1GpNOSrEMONz+oTe?=
 =?us-ascii?Q?3Cylw0sOlub+A3v3S6vz1b9oKw3lSL8LMW9+ySAPUbYjN5+AELIlyVYY1ntb?=
 =?us-ascii?Q?Oa+AkhYdvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba478947-745d-452c-d5f0-08de7ac93023
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:09:25.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN0h1fTucAuGnrTZIXiV11M3jkSxQQ4q3OUKOcsyArllUSRgqbeFZ11BJU2r0gNcwzNiB2hpMJipiCQccZAmXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10563
X-Rspamd-Queue-Id: BEE24214427
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264451-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> 		if (ring->xsk_pool) {
> -			rx_buf_len =
> -				xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +			u32 frag_size =
> +				xsk_pool_get_rx_frag_step(ring->xsk_pool);

AI: Variable declaration should be at the start of the block, not inline.
Move `u32 frag_size;` to the top with other declarations.

Although it allow declear varible at any place now, still perfer AI's
suggest here.

Frank

> 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> 						 ring->q_index,
> 						 ring->q_vector->napi.napi_id,
> -						 rx_buf_len);
> +						 frag_size);


