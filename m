Return-Path: <netdev+bounces-248361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD3D07491
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 07:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7EB300C6CA
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CB429A32D;
	Fri,  9 Jan 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asXBlHma"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F96254B19
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938406; cv=fail; b=Wy85CKyo4pTYA2E4g6F+wfngJ9lKv4lO9SfjITLcp/KyAsk1DHGOecKfSg3048RT4Agp+QQIGokwb9CFGJQJIeHsIYTmVbpTRBKtid9KjPJnbSBOtiPm92FbbCeHPtuAlXpUlR6ArlSTzzuSB0BAx13cTUpFlllAam0A5Y0b2as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938406; c=relaxed/simple;
	bh=KKLuavcP4tTvoJSMjWwZ80k52u3/YEMCV9SmNnrhAdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iVsMVK5vfVT8Z1Nzlr7qpTpUW8Lq9D3HEpzE4I71XOb7Jsvz8NjV2OdtL0fzeq/Oz8larLiHs9O1LwDFl3ybFTJDP7zHtu6uQZtbz/F5dNdN4vXXmQfZP6aTMQguOyvCJSfvgpXCZ4eaGuiMKCTlCY7eaPq2u6Aj2hdCqrkOruI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asXBlHma; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767938401; x=1799474401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKLuavcP4tTvoJSMjWwZ80k52u3/YEMCV9SmNnrhAdo=;
  b=asXBlHma3OWYRKfzCLI11a8fGycb96VvxMJ6lkvO4GjcxCIxSz5Aolrr
   xAyD9O0ukB4Y4jvGqunPTEtqZRCpo09v1+FrkoyIwWsC8kaY4QKa9pQfL
   vKA6C4SjTHRqZ7wagP9YcGNya9Ptb2BbaTNt2u6gojlOHnY+WpR3TyiKm
   0foPUfn6QeE30diaRuEOHmJBcxkNWsoDO+I3sttJXfcW9hFE7WrO4y+Ve
   3A0TJ2LViUhhXFIp/4xekzhe8OnH5Sc4bk4LW4Wyop72Fue0BzF1U62o6
   q/tfspHsHR/LFkeCqbS0+UUDHIDSJhx0dIfwJ6Czj4F6DlVoSPi8IdOeD
   g==;
X-CSE-ConnectionGUID: gCpH8P5rQCOdBehrr34v5A==
X-CSE-MsgGUID: PtF9tPEKRq+xSWlmomNoQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69477916"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="69477916"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 22:00:00 -0800
X-CSE-ConnectionGUID: NJ+GCaP0TT+3F9xIHGcRYQ==
X-CSE-MsgGUID: P4RF7C9LRZG8LT2hRzf+JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="203420767"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 21:59:59 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 21:59:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 21:59:59 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 21:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMljQC/O8EaoEk1gcTyLyRF5+6l0Owd58twENaj/7MAS4sgYgoz1m53MDFm65zJFKTYYfvpdaWPy2ryEPX1O8NEIpFmVppfDDvn0lToEnE41fddfJZ73EhIrLDqqLBdnuqac/JfNn+1Zo1Q1n5ScsrRFVOztn4w32fLUwLuw9Pf6+qpX6IcJnqx9/cvOZXusWDQrXgTiqSOiFbsa3ElkRq8tuR35TEQdkcP/oUBfRfriZEtIXJhuqNbMS/sGYGhmD7X1icI2noLrZdPlDw6wv/TvSVEVQ/IkYrJOwiDGWJHezDMheaY5YouWq/GpibAgbpLORqpXYPFFEztO6QQRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtM2xwty6LpE0a5a4iEChXwqyPGQvoEt49E7E/J3+JM=;
 b=qnY9zW6o0Bpf+XJUEcDtwqeOH9bngJexIOwqmBJw3L6P3JTTJ5yVmJh3Ah9zTSdtvjjsLC2sz2UJkPAfuA0XeFAhUWqAnC2rjPfSScGrqLrB3jMmsS/EZ0jwFGjKooML3qZj9KioFTcYdd5jYsaOQmbXSbUC2RD4klDawXQ2kDH4Gwi6ypvQ4H57gMBs1F+tJOMQ7vjeGuTBgUQd26SXbceRNdGy5vO4joKnBaLo4a5agJHoPy0X8tHBdAQ4EbbO0/ZUoqisuvI2bi9uYVLgMI74n4QcBjI5qVAjPJ5fhQ1tIC+kjizcFTOFndAkg19epJrJlB24CfSKsZ/1A5rPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Fri, 9 Jan 2026 05:59:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 05:59:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Kohei Enju
	<enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/3] igb: expose RSS key via
 ethtool get_rxfh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/3] igb: expose RSS key
 via ethtool get_rxfh
Thread-Index: AQHcgF7nUFfM/XczsEmb3514cOhUArVJWY/w
Date: Fri, 9 Jan 2026 05:59:56 +0000
Message-ID: <IA3PR11MB8986F4DC5C4C33844CD461DCE582A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260108052020.84218-5-takkozu@amazon.com>
 <20260108052020.84218-7-takkozu@amazon.com>
In-Reply-To: <20260108052020.84218-7-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7902:EE_
x-ms-office365-filtering-correlation-id: 337a2b9b-d5e9-47cd-b32e-08de4f4450e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?FziGbZs10F5jNSYfpHa300REGs3bCPexYuT9GWU8t/kmdELL1D1uh0cAuHV5?=
 =?us-ascii?Q?Alz29pHj4mMH4xL59fNDkp/hkAH7UJshPaaaGmyXyRQzplp7SaRlozpH3rxl?=
 =?us-ascii?Q?IJTLH5b5TSF+iT28q6zrfYjjIjhHUcuSOF6VECygqhffaHKHOydR5kAX8YNH?=
 =?us-ascii?Q?oN47wL+08hUhUCW3QrmhZZKBgrCatZ58cZISOwdx773qIW8b4cHaD0ss8W8h?=
 =?us-ascii?Q?2UQdtriKrvvCfJvjqtL3xZI9t5Cmw2GTB7XTCA5NzgPcIXdYOW5wm3PzTide?=
 =?us-ascii?Q?7u6/UQy0XS9PDuXst2626BT0nEYMvvC5+8W0Ddc+ztERxY9FM0t85BvMiyjA?=
 =?us-ascii?Q?cpDgvUNdUg28TyuBpx78ZR8F/55grYnuBAV0Jghu01TzUkUm5i1r9caKHKZw?=
 =?us-ascii?Q?0/EFpmzQlpYobP2gZDwl69pdtmtTO2JiYUG8CaPxb5yj3TqANbH+6RPLgWM/?=
 =?us-ascii?Q?im3XwEFf1nokxZoSNsSZ3VYEM+b7RZ3t/hTVA64wxyW79Vjw3sLRSCm8VAhr?=
 =?us-ascii?Q?RwSKNXJ5vUf1SJW9IMY9/ypl+V8hV6BQQ9bNyl2fcI5I2VQ5BUabws2FnpxE?=
 =?us-ascii?Q?m2z7o1op3LWKXYD/kOFCi2hs/sfc06d4OOsr9MXXiNmakiv5xMWD63uAvmLU?=
 =?us-ascii?Q?8pCC0TdSr7YpO1X1STp8AfaKW4CtT+1rU5vriTDt9f1gG4nfSuLwEUkSULJc?=
 =?us-ascii?Q?afr+66Tv73jmIWmWMIGLgN/9tjUa8bJ2Nvws5mouPaHp/IBfSTTOktkQ6mt4?=
 =?us-ascii?Q?VG7oIM458CK3+acqNRXObl3NNMXa2aqI3GwB0YMf/zLdSPSlqvYfVukqTPM5?=
 =?us-ascii?Q?+JtATiZGU5btqjiOzw9DgBWLhfw+eYxwhUpm1wuZ9ys4NXzkn5PGBCQ9/aZx?=
 =?us-ascii?Q?IKVBpx9wjgnItB3WRh+4jK+Ofmv+C1CWypk7ZvmakcbXQRwKz+9YZ4LbGBrd?=
 =?us-ascii?Q?Ge2I1X9uLtJD5qLF/K6j4QGMYnugEUrjDL8w67zT2l8HRxsxMrrDAbjgK51x?=
 =?us-ascii?Q?8N6Lp9IDZ/D9bNQa3x69PHMsXNjaWvQpXChS2ClFaQYfzZ51Mpaua3DVshFS?=
 =?us-ascii?Q?gZ04xpsnhm3MH203XswTOgI5zrMMoDvZv7394JbqF1uuiz1Nm90wxMsRCQMy?=
 =?us-ascii?Q?BXhy0Ip3q8qOAF2WLpFspO0n/we0CDccN/JOcVFcqPsnp3kyQ5CSkq2BPPsw?=
 =?us-ascii?Q?x/TkAJW0sY7VSbgkZNowgP9otL36n2iOKSprVtpTPlq/vk2E0RB1BdsC8zDk?=
 =?us-ascii?Q?CbcyKRT20xJwJy5XKeavESfv8H9/cGA/nK7vgEQdYOiTowSqXd/jVMfYJbBX?=
 =?us-ascii?Q?Y/06XL1dxOg4M1zUqkI1GPaeysRIODoEvpQfUmwCOLKMR7lLx6p53gzM7fKd?=
 =?us-ascii?Q?sfFscgsvLLHNL4cViP5gIDG4ojxzqh/H6TGFk+g1iiy8mzsKjSCx9rAptpmO?=
 =?us-ascii?Q?CNDuOBHm+4bQHtf3lTor5blU5hGnIAGGqQOH0LLrK7I+DlBlYi4/+5R12NbR?=
 =?us-ascii?Q?ewjrx6qGHL+4sNAUHRvFdh3Y8o1LN88xA28n?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yhqKl2fNRXeITBIj+rPWeFCPA3xNW5Y0+lvOFYUsX0xo5i09dfNTWTUNTWJ2?=
 =?us-ascii?Q?oDS09wF9JDaB0YyeG5llK6RXcKULLA/5v35YF5hPiLeO0gDo6TU8hSCkFJqG?=
 =?us-ascii?Q?lHo4+g5EUNdNSKj1b0PT1E5LCLULzreyn/vIXyyLjBWQROkxtQZ4SQZ0W3PP?=
 =?us-ascii?Q?RmEKvKmchgf/Nh5fGb7TK5ClW1k5aYL6HNCa6y0/2WNQ0YxdQwnkdNvPIdH5?=
 =?us-ascii?Q?OrP/FHXFQw/e9kNoScR6uQigZ0rAovVkW3htjIakL1xWFvaXRYUHG8rKF5uZ?=
 =?us-ascii?Q?um5ZMtVZWTK1H8JUSZjRR+PGuosekrxvu9AklbSMCale15aq2eY+e/TSZgwJ?=
 =?us-ascii?Q?Eza4fT2kBibBdoJiyjbneS7pMG1VNJTWMbHniHnDa62nxJyt4rPeUzmMcqrz?=
 =?us-ascii?Q?8MZGZenNvjIVpjFssNJGmkPLKXGaeNncHa9XFSPa2tKMPvAYQ/gRrEDOZ1+z?=
 =?us-ascii?Q?7K6C7FE0FtKSPAe6sNt7ZbLnjCoWmLm1tm9q6EtCed8StpTZs7zErawS+jYq?=
 =?us-ascii?Q?XVGwCEahsSDeX7V6j6Vf0OTvPMfBjhCHyOsvGSlzl8tQBRiLUqqeqYVO7GEr?=
 =?us-ascii?Q?wG/b5qLiHl5mW636EAJnvW7+6gBzYfAwaBEZDI+G43f1n2UZucUCma8tbPzT?=
 =?us-ascii?Q?5UmyqjxpokTcvSn2/McdYQeMbTstOkvGVdmTXHp+F4YfSKXwDkwNXt+zAChJ?=
 =?us-ascii?Q?oqttcNCBsCWljq5105aqRAZ7Zcv+5j3zKopd++aNeVIWFjYyjM4VrNLWLDq4?=
 =?us-ascii?Q?roRUQ3xGossjiKMHZ9vegdLZre0s2+mviTHox6Gaan0x9DMJ/qqMZ0lOt1nr?=
 =?us-ascii?Q?qyrqwq9YU2tFZObMBAinPCAsxGpME474qPX3inB24uqW5UfEAKmLnmR85OQP?=
 =?us-ascii?Q?fiamLqEYtMGPAx7SPk5OzZp6JZ/RcG0S6UWpaI7RUrdRhoHGrVBhGPexYbhp?=
 =?us-ascii?Q?GKnEb43NvMi9SqtI5OHLBeBF6DPg2XIonyJjCSvch0TDN+mjxp6HHK/NpvZ1?=
 =?us-ascii?Q?AUvUEpUxzi//Gk1WJzTBmhNp9VlrZqb5mKTnLuXXUTvwCaZNLTmuxqHDjeob?=
 =?us-ascii?Q?YgNDNcRnVCsQtbeiFWCqlui6Xxj7JXuguCCZzMXwKc9FvIP6WGJBLuGjYftV?=
 =?us-ascii?Q?Q3OsDNBYg8PW9eYLr/mqJHB2AwA4LLhZkR31Rocj9/raiSmK9ZfPBLLQy1VI?=
 =?us-ascii?Q?WMTxylJTObf2HJBKo4o78Gh3CGquHyA4aHmJ4snfEs68H4QdvYNNRk5kD3s9?=
 =?us-ascii?Q?UIN/pTiV00H5sNht5AjVXauYN1aZt982km+r/KAP3SYV1cbZi4adeWqr+qon?=
 =?us-ascii?Q?w6Nt7c57L9fFyy469s2Qh15H3c54q+M2GNn8K+OUuohCnkEtWj7lErxc7agy?=
 =?us-ascii?Q?JxH7Ka2FW1DF6iK159KabbdXOD/xCgY1Bw0I8TQHBofMaStCX0Ra74pNR/j1?=
 =?us-ascii?Q?nPi4kXPwGTWOQ+RDKY0bzJdS90BMEgqGnynHaQvLjzv2C1CmbiNhEHTq1YaN?=
 =?us-ascii?Q?jFrE0DE7LFQn2ZamWxpNOsSf312GdSmuzNlk4vlPLHLJsYJdUq2xQsBBEnDQ?=
 =?us-ascii?Q?ASE6sBYNUZJdrGh6isO7mbNKylrQG8ODfEr94gyMavc+EEw9sHdCGuRI6NFK?=
 =?us-ascii?Q?hjx4jpj5W/i+52R5poP209Bm/q5485ffj6xPJ6qlAKItDFN3FrTk/wYagNpc?=
 =?us-ascii?Q?Rti1NE8YPfDxBWA/X8DW+5D0qvZU4490IUKHNy28aWQH87sr+DiPo17ZnWaW?=
 =?us-ascii?Q?8Jc3yb8nHQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337a2b9b-d5e9-47cd-b32e-08de4f4450e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 05:59:56.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTVKUyRNyfJUC9BEZztqDI84UBVDV7nd737vwbZSH8WCsUJ6/egVjP1edQ14DAGQq3t0UFpBJC7EedI7v/BXaT+ePLRbFy791DxD22TGwNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Takashi Kozu
> Sent: Thursday, January 8, 2026 6:20 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; Takashi Kozu <takkozu@amazon.com>; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/3] igb: expose RSS key
> via ethtool get_rxfh
>=20
> Implement igb_get_rxfh_key_size() and extend
> igb_get_rxfh() to return the RSS key to userspace.
>=20
> This can be tested using `ethtool -x <dev>`.
>=20
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 8695ff28a7b8..2953d079ebae 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -3285,11 +3285,13 @@ static int igb_get_rxfh(struct net_device
> *netdev,
>  	int i;
>=20
>  	rxfh->hfunc =3D ETH_RSS_HASH_TOP;
> -	if (!rxfh->indir)
> -		return 0;
> -	for (i =3D 0; i < IGB_RETA_SIZE; i++)
> -		rxfh->indir[i] =3D adapter->rss_indir_tbl[i];
>=20
> +	if (rxfh->indir)
> +		for (i =3D 0; i < IGB_RETA_SIZE; i++)
> +			rxfh->indir[i] =3D adapter->rss_indir_tbl[i];
> +
> +	if (rxfh->key)
> +		memcpy(rxfh->key, adapter->rss_key, sizeof(adapter-
> >rss_key));
>  	return 0;
>  }
>=20
> @@ -3328,6 +3330,11 @@ void igb_write_rss_indir_tbl(struct igb_adapter
> *adapter)
>  	}
>  }
>=20
> +static u32 igb_get_rxfh_key_size(struct net_device *netdev) {
> +	return IGB_RSS_KEY_SIZE;
> +}
> +
>  static int igb_set_rxfh(struct net_device *netdev,
>  			struct ethtool_rxfh_param *rxfh,
>  			struct netlink_ext_ack *extack)
> @@ -3491,6 +3498,7 @@ static const struct ethtool_ops igb_ethtool_ops
> =3D {
>  	.get_module_eeprom	=3D igb_get_module_eeprom,
>  	.get_rxfh_indir_size	=3D igb_get_rxfh_indir_size,
>  	.get_rxfh		=3D igb_get_rxfh,
> +	.get_rxfh_key_size	=3D igb_get_rxfh_key_size,
>  	.set_rxfh		=3D igb_set_rxfh,
>  	.get_rxfh_fields	=3D igb_get_rxfh_fields,
>  	.set_rxfh_fields	=3D igb_set_rxfh_fields,
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

