Return-Path: <netdev+bounces-264459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GTpBmWiqWl5BQEAu9opvQ
	(envelope-from <netdev+bounces-264459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:33:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23421499C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB0E630DA8D2
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922CF3C2760;
	Thu,  5 Mar 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DaPp0uBS"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841D33CE88;
	Thu,  5 Mar 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723918; cv=fail; b=YP8bxv87dUptFgswRDWPDybmx5nFe4hTN4rjSwOAM59/Cbob5IHp8blgzumKdqYysrUu9a0LLo78lLjOXuGLNL2HNdfBuDJRGgHSBAD1wdslsNm69T5Ov+/w398ewyn/nSz6iua0voNMSVMFv7zd4XJBm+LqmMZ9BzWMH0KbXRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723918; c=relaxed/simple;
	bh=pc3ScU0EDodIrvIb+3T0oANW1a4M3OSDUnW6ZBunohk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5VOqVoTDOcUK0SKibIqG5cshiUmORUOzOcWPb1DVoK4+hZdnm5nm2xhkcmSjmI9mAIKI8mBpfoOA774+s+JJtBiCSts+w6Yxed7P6Mcr9m9p7Qr2kzWm+So97w4vXsWXpbpOonycO7lpF0TL4MHf/TpuLOT0y2GMubALMYydZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DaPp0uBS; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ9cf4fr4r5M8VDq2iIgSXphFuYcFLLfbK+tERxbe6cAYCjNzHJJMPpq7r3KRUveGKcfiKYoMa3yr5ZdcoxoGt/B81X7ClxXsXSi47YPALHun9s0DCJ+5XpGyMrJ93qtWjN3UIBniCYBkEVjSel590JGLNyHgt58Mf51QFUxZsWPgHY7U+qTkYpEDCiCs76s8JE6lMfylJSULOO3M/Ptk+ZG6gNrqY0XctdXExikaITF0y96L71G+gF+iIrzCgu+bw6vSZQYX61uKdyAwhECZB2dADftSBybdgsjivMBC4QC8my6OYM86/3FwZ4VTwJhLOgV99VyjJHO4hdkJ7a2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4wzpP/45eN+GF8P9ILbqb5k11Y/5669qUeSiq2cTQY=;
 b=u3EmiWLpwsVPnWqgqZL4RbkWXECGC7D0K0ak23pKw0PeDqbQI5a5LvSJABifat7PacvL5Lfw4IBrUhFu68bcy8b6ZEQvCt9CMo/HRdRmxcRuIdKKB66u1Nv0s/Og7uWwwhF8XWzgXpO1p4/lWFCo1B9ahn8pDya8ctCHVNYZzs8Svha5JaA5DgbDuqXQmpdumkcX6bOacQNwXmiRFApUivCbFkm8xhvQ9gaxyVhp2eSEkKiZu1WxS6Shs1btbmPB78kTqEqaioYKdElvJR+OVj77QZepPLn9tPncWSpOVY+VBdp2YMbzLt7lDxK5hufuhfGImGI8MieCMI/9+4GUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4wzpP/45eN+GF8P9ILbqb5k11Y/5669qUeSiq2cTQY=;
 b=DaPp0uBSIu/CzZUggTZs5Zy0bCS2WtSms4btumLf/navBGczOoD/Fnz9AMt0Kki+NDQgC5w1Eh7rxLzjbTJtEO22nzd2DZGfIHM/S5/HwhYLsbDISCKaS32Kg0ZMVbsTe+8hE57bQJfaXVaFoi3vYVtIp4QwrgB3/v1ni2Qtse58G/B+ufk3ak6Uf2h52wtUx+BboCMRLJUng/tSUN8Q3ncd+rwvtplhqvENpXcBWIGT7lq44/NT3cHBSPVJQ22eWwJOFpPSRVk78LHTwBpGwmiSM7yX/6BhGN/TiBriSbJz6ZEtPOQuVm60SkjVPXijxgFBqCjiuADYMmmW+fzwUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB10360.eurprd04.prod.outlook.com (2603:10a6:102:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 15:18:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 15:18:33 +0000
Date: Thu, 5 Mar 2026 17:18:28 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kernelxing@tencent.com>,
	Ricardo B =?utf-8?B?LiBNYXJsaeKImsKucmU=?= <rbm@suse.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [PATCH net v5 4/9] ice: change XDP RxQ frag_size from DMA write
 length to xdp.frame_sz
Message-ID: <20260305151828.2zvcp7nemmt45iqa@skbuf>
References: <20260305111253.2317394-5-larysa.zaremba@intel.com>
 <20260305111253.2317394-5-larysa.zaremba@intel.com>
 <20260305150858.3910822-1-Frank.Li@nxp.com>
 <20260305150858.3910822-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305150858.3910822-1-Frank.Li@nxp.com>
 <20260305150858.3910822-1-Frank.Li@nxp.com>
X-ClientProxiedBy: VIYP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB10360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fee2a84-e600-4eff-b07b-08de7aca76c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	EGWGZJoGxvVcWHB0P3y2+SoBzsKDI+sXc25LTQLY1CmeclMbLj6ONKlwfH43jp5aJCBHNNDApBVK7lpL2bmbTqFh7PNo/r2u1Vs7bXvH8h5HKWYWBs0Yy/ssfS4h7XAq3gz6iVhJi+PDwBrk0Nm3mWjx1+IrZQrssntX9ETlADJ9eR6SHpgL31MvVW44LpFpwh7q2MOPVbA8WO0DuVk3wFGn3JP08nj7vLoJr0yJm9Ms0Jt+m+72OZk42R+aTDkqtfzf7ig86gVG9hkNyC51RytBsP4rMs7B7bXcIZ6pHv1ZEBBQTF3QeSHNaFlAX45uW2+H+49E3zHPvgW3Jqb5Ag33dfGtn4oEVs3J+WQmcgx/BFAGGjdUinny87XiR1zRv1ncTdq034Ah7uHR5fPeepsd9pb4p8+BqaC7eVTWg74+26T/Q9lf11M5m8CVbEddn3a0zkTpMAQWhBtunQAFsCXsIjLPmdz+1NjzNwxET10GstVvG5O49xTj5Ar2KAOSf1Gxu4mG+NA5gvTm0NNDL1YDtX1EJ4WwVqIN4AB53StNiXF3ZBzOs0J4ACo8Km55bB6OaXoXqHQetHeVldBDss4dDdqTvhJrG4F6zA7Y282WFZVMJM48npmJyaotwtn1bWaPgeSwSCPmgZwRsI+SUvnRl6P1LToBdd2TSH7/+B1HTvPLQ3eMhEg20Win5m6eQqRjvk5hCznGoLY4HFZGzjWzuo719KpmHOjdZwJrEz4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3wEoZ2D7LaTSk3yu7/+LcQwpnY9o0FkbWFnhnNbH5IxhHLtIb4ezMaZv9QtT?=
 =?us-ascii?Q?xavSDRKWZ3drJ3xXOe63KpQQWhcTVXg5PTUGsPWhN5K/TOwVfmN/N1hWsX8K?=
 =?us-ascii?Q?lcw6Lhdez3Ru2wwzE1lKoujG6clJ32U2Bu13EiV+AZQskrDeRHN1k5SSYa9F?=
 =?us-ascii?Q?fWieCpg4I0fJP8qyRXe2kjDH9iDiBDnXKz02vstBMuz0Oj7NT9SNmdmhYGl9?=
 =?us-ascii?Q?tmBZHwHhBJMgIkfC4yVUyXP/HOD2Ktr5seBn0gkE4H3rxboCXVf/vSDFRoUo?=
 =?us-ascii?Q?XOSO3NQr+DKBSa1cDEge6hMRVbxVqHF/dUQRnI3PXfP1jHZVHB0ybTRhEdH3?=
 =?us-ascii?Q?OgA/nzC34sjSrCyRNrHAaUMPJn0Pwy1c/hyRYq2W52R157/KdpxmAGSJ11Oj?=
 =?us-ascii?Q?8V737z/0L9ZmovAse+Oalals005HwpdaxT6ZZzC7Kv4pq08pud13SNYjbkpA?=
 =?us-ascii?Q?cSYj+gEaVh5mpft+1kHPvduj3eP93Bh3/HFIdeUmhF4sploQDXIwbY5gGYRW?=
 =?us-ascii?Q?Y7UshZVnifcaG/Sj21b62qWb4WMvC6qH1fGAMKH4g4xs9LG4otmdohYFfaDl?=
 =?us-ascii?Q?OBbitynI7zw5/bKywsiUaRbn7s7FjqpcKwlW81NVAwjyhMNnWSdHuNiwoqCl?=
 =?us-ascii?Q?X5WDHvtde3Ro924+Zq5iI8a8nedxDFF0K/Rb9y+SRL8HpJ0Fi7Y0CH291ewl?=
 =?us-ascii?Q?skY9HILNBnsENIVdAaJx2zjGM5Vn065d7qDBIXFXY++BSuOPru/rstP/DF64?=
 =?us-ascii?Q?xDRbuC5B68Va02fiJPmI7SwWcUBB4ci6lWUIO0bmc4iw0VjSik1enBYekPlr?=
 =?us-ascii?Q?PI06u0CHe62KqDNBcPndBf8sF4BX3a2Z3cmYoVeAXODAvt+H6O2sofZDrf02?=
 =?us-ascii?Q?KeorY4u/soAW3M0zXz/gIfbpjo9p4dO6Nl+zpfSN4dCSSyWStPEV41+kZ70w?=
 =?us-ascii?Q?g+Z6Ak5SmIo0Ucc+eo9z9p66mMpq1/1Wba+Pd52JxXf6NGkY42aBszdIXKDd?=
 =?us-ascii?Q?rg7BvyCH6iyKnjVXHLXX38AbQbmMCpNs243JR06uMk6vfFxx8isB7b/onEMg?=
 =?us-ascii?Q?UFdPPckHbCLzgcdRWrBfKu5+U+Bk/l6kHQGhmrVBRVYwZK+b2L4BpvPLTcxa?=
 =?us-ascii?Q?CUQKBqyUsLjJhIDKL1r/Oh7D6gf868aGalYNnogHTsCPnevt1n0hT54qfWyw?=
 =?us-ascii?Q?+CoFaMQdhMsv2yHSuxpi8AKnZS4CtFuLSuUhK6fH98UKVZyIPmbFnRHHsf1k?=
 =?us-ascii?Q?1nZ+3Rqo2gEyO7YjGU2zEJU1LnmpoP2qhTK+D+49Ng4IliOLPQKE3UNsZjsn?=
 =?us-ascii?Q?V4bz3UTwYI5+XQv/cwrTdg/YZFV35lnzf9gjcEyz9mcRhuwe5QNffFZd4hh9?=
 =?us-ascii?Q?XkJzve9Tgw+qp/pQoc/DkJkak47Edi1Bc7wGnHS8/rl2o9eeP+l+bqufzezK?=
 =?us-ascii?Q?k8b5A78z+NGWcDVfaPwOsm6FkeJGszNO4k2lfrsgBdG+2V0ZrQnaAhe0MLqK?=
 =?us-ascii?Q?cDHFgX8sslfTHnj/+9vHFEGiaEEcIFD068/epQL9kqz08UkPRxaz9dEc5N17?=
 =?us-ascii?Q?SOX2RsAa4kgYO6qdnPI+BqWANk3duhohZTk1e7DWhrQmDq/gWA4AOdohEW2Y?=
 =?us-ascii?Q?41rDeQE6erVIC7p8YHERtA4O6QKPLX/CNon7vvI3F07mRYpDGSCvr8Qe3w0K?=
 =?us-ascii?Q?i1XIkWZeCGXCsRt/cRWU0f4H2bk7OYBiCCVrHZWj+3hAP6Nj1h0b3ZPp17im?=
 =?us-ascii?Q?/7cJ+aBIxoI/TRhAL7E24XeDtNfCr4q7up9YkYQNLxV4xNrcWzCP/MIwssVs?=
X-MS-Exchange-AntiSpam-MessageData-1: LN6Dq8IkfusKIJnE5W/PCDdkCwidRrZd6Yg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fee2a84-e600-4eff-b07b-08de7aca76c8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:18:33.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqR4ebIK4HgEiHs5uUyg9aEmrVIlIU9mAKGzpZnP4xZooNJ+Ft5mLpVZEsg0cFkZnUqQxKoAcpWR9o/MLzT5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10360
X-Rspamd-Queue-Id: 3B23421499C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,intel.com,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Frank,

On Thu, Mar 05, 2026 at 10:08:56AM -0500, Frank Li wrote:
> From: Frank Li (AI-BOT) <frank.li@nxp.com>
> 
> > 		if (ring->xsk_pool) {
> > -			rx_buf_len =
> > -				xsk_pool_get_rx_frame_size(ring->xsk_pool);
> > +			u32 frag_size =
> > +				xsk_pool_get_rx_frag_step(ring->xsk_pool);
> 
> AI: Variable declaration should be at the start of the block, not inline.
> Move `u32 frag_size;` to the top with other declarations.
> 
> Although it allow declear varible at any place now, still perfer AI's
> suggest here.
> 
> Frank

A "block" or a "compound statement" in C is the piece of code encircled
by { and }. We _do_ have them, so the "u32 frag_size" variable _is_
declared at the start of that block, as a matter of fact. There is
nothing wrong here, the variable placement is not arbitrary.

Which AI tool signalled this?

