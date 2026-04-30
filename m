Return-Path: <netdev+bounces-282662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE0RBVzy8mnNvwEAu9opvQ
	(envelope-from <netdev+bounces-282662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:10:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABF49DE54
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6EF300EABC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F1371072;
	Thu, 30 Apr 2026 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eddZDYwi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5B34405B;
	Thu, 30 Apr 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529398; cv=fail; b=QL8kbfkn1vEnOYHNLQwJhEArVuT38OvehATfK+LER18sxzov43J007iQcqgLDKhnjpD3xIbCc/CIBuOffQRMkX0+c4ivGDOKxufxtItW1wyofAZSu5tY2C2lEHyPro81aQ+ohloGTRHupmG7UOsM6OPTuwKRKki7R+dCkjx/744=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529398; c=relaxed/simple;
	bh=3VKVcwx42K5nr+hvK5a/ZjgktBeNcxwHdSrC3NFfHiU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=M3Wb33wXXzgjlHjdXeN/j3W1UCo4sJJoXjD+ZpVl+eGft7/LEI3T/i4Oi+aCHIbRQhoCRAgl9seYYpUgDOVv7w71sG1714G1QUY/jeWdxcRFyOgBSYBVGsaKNd5kwipo7s79SlWXiAtg33Q2H5FktNI0aJULX+zQQTKKdQr/QXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eddZDYwi; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777529396; x=1809065396;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3VKVcwx42K5nr+hvK5a/ZjgktBeNcxwHdSrC3NFfHiU=;
  b=eddZDYwiO0qMvaDq9k3vYSmciEV+ublv8DIDo1XCxBlOAi5pyfqt9nRu
   eTYpD7CvcOBFHZoJYiEUz9z4klpLrwmyggOt4EArGwngSmCYsbn3u9hIY
   rx0ya36n3TYWrJiU0KG68MMs3vPrIHLfY/qXr2hAv0QH8/5m/JfWVjpPT
   wTTsefVQ/K5KWfSAiIWTLfIJ+vvc0zjmbH/cYu3ZruvFXf6tlss3yrkob
   EoY8L7l0pn3ab0c/Fe59iRyIvFSrxpZrSfGS/SkXr61J9v4EDKcyF0j4U
   ibzj9mIJAyyC3eI4fBJpUeSAHzjYdZYVnaRtkU0YIPC01yFqGQHTTQosR
   Q==;
X-CSE-ConnectionGUID: +iZGn+fwQOK5gXshmkAW3A==
X-CSE-MsgGUID: TCAf3PjyQoClXQtzwEXrNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82077474"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82077474"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:09:53 -0700
X-CSE-ConnectionGUID: IAYdI4M5RZSNC7DdVFu1Lg==
X-CSE-MsgGUID: 15/0xSFYQn+2odlVnI3BkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234372947"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:09:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 23:09:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 23:09:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 23:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeTRv4e6CSIuAOPEs1Woh438LKO9sGshhosDHTD4RU/tcYz9SIohQHtW+a5W2OKDBpN5Dbn38YnqWZqT1LSORmCpKHBDW3orpfPcogg3UIsRLCBDfz38DQcdahyKlQJOMH4EhMr5+DblwXAj+S6PNJSVpbTciZUhKDaOuNmzmyBcOlU2A/MBTgl0OllSNiyGnpBxDVYZhSDigXdLTu6/iET4u8sJjALCPPaleKpd5XKbPnae7wXYv/uu4i8dmE40utThqMZSNebUc9rvPmCks/kFhS1NX4w1HmFO5ladK/fy2z6hkSaEDW/3+gqHVtjc3rzlhPiIzrSXz/+qx9vdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQR/Xzyp2n2yPaBSlZk7EUQa/wLII1+m1YLlrZdGkQQ=;
 b=bkjmwxt4KVdg52Po1m8HiRnkfnnFHZl9wyFiarC0ZXk2aAgmhT2vwKr+v2kosk5bQ+2csMb4KdtuijuepaeowWw8/qXZ46xGJ35HO/QUORnN6GN/6zoXZNxU8N+lklA3aStWVRYmbQAbR2kNRZ/KuYU+my1PZCi6wRnTs61lyp81l2tB5yhLv48UvYN5VbyBkCedPU1CAUkHuKlNQvZ5PJtzKTAuOp4sVkksg05o54mn5OTSzMkHxAdhuxDyMffHYJXJhFSV6uMaGsFPCp6lqUl6DburlGgvN6g8x/T+GReuAbG4Dt2eZqJENqLUAuZmP2QhW3um2uyI0s1u0myaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS4PPFC60125F65.namprd11.prod.outlook.com (2603:10b6:f:fc02::4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:09:50 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 06:09:49 +0000
Date: Thu, 30 Apr 2026 14:09:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [net]  0d8647bc74:
 kunit.mctp_test_bind_lookup.mctp-route.fail
Message-ID: <202604301303.9de94634-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0045.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS4PPFC60125F65:EE_
X-MS-Office365-Filtering-Correlation-Id: 15927447-eceb-4b18-2393-08dea67f15f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ctnh7f/o+v2uE7cMXBIdy1i7lUofMO8byIkzG0ZD0vluqqxdxG4tsOhcx5RJ+PBQDKF1/pR1YJaNuIaaox9iT7Lz2/54p8rpgXv5TBqsIOAAE9TAy0NZa3CYE5W5oKZMmqoWDWi7AHHvPyLXUMVdIhAeuPg1KJ0tDlA1LYZzNK0FKTiqgmcjtcJ6VHwnoZDjkAu78xdujtcXvCI6gPPXGnEAiwAkPdh9pgEptUbWa1LHkzWI5QWxhtJ2vSrAP5jg3S45FHDp0chGLiOoo/pz/sKabWZFwLLsCTTQx2REkswt59YTzHfMUkR1cJxqeKI928bGiiaaYRg9wFcTAcEr8N8BfLV1pTFRr89DfSFitwP3Yz+MfPHFzR32/qaaFeQU6mYWpX0x9avDkWXiYhlCUkl07jtw52Gbu9GFAGK1OrChzuHX7tKBZEnRQv5bXPd72CFZMMt+O7nJ5aionGX/ViLYvILmttsLlL2Qj8fH3u4yIza2IVHx5W5IXMihx6SmC6Idtg+oXC3G0cosh9D3OoWGhtWArnQdn1yItd4hfYPuDPNhEqMYXPoWBZ9sLaB6xT0taxNb1ZZMfQrNg7vQ8PmqPrm8Snlc9FKldpLLTGq69NU5G/1BHk7wlKPDqMZybeNuephzv9oshUt91c8ba5Aj1axxPoU57xgNaptrC/MeZ5yjLfanwJ06zq3Xx0XB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uoulvlWe9+TgCc6qXYNrQjiepyL9ilGD4KLiwylkN4qJ4GE9q3iTO+XeWJuq?=
 =?us-ascii?Q?zym9BNyw/gfhuaGiIOcrSJvKecKnr/jll9adivku3sTioP0bFtIU3aOznFAS?=
 =?us-ascii?Q?Qs9n+nUto6Hgp0awmyW0RqeaBrb/UXm/gD/Z7UMOBXDDdBLYWmY5KF9S2w28?=
 =?us-ascii?Q?teXvLTaja04JT73DuwhbDgHt1tQGX2VS4hCD+9Gc25wU+h/V8TJVf1HUJIIo?=
 =?us-ascii?Q?EU0ctNgry6acbatRfVhQjHfQ4hIMdbYFeX1V9gE33rsRsNeLPwJD6SeFtPzo?=
 =?us-ascii?Q?H592rbj3rieNkOTZLcDUB1ZpouDvxr6kIWPHNyC1/2KhLTWL+SfsTUN7+Cjx?=
 =?us-ascii?Q?/kDeMaIjtgtFGtBtNt0L3JUGuxn/FN30gn+uIGLCLh+zDpHKck9asiG6AVLG?=
 =?us-ascii?Q?Yq8AisC1DiI6QxIgUJG0wX8T9byl8wtsOoW+LxlpxYD+Aa2EkdW0SvrUZYoA?=
 =?us-ascii?Q?QrxdYMLd7IUGmDnvwQY1PZInp6DwKeI+NMHdiykMOAGAVpOs+7Vdhl70ku5u?=
 =?us-ascii?Q?e3UINwlOYuUDvLxP7zqdVZ0xunsFdy1y7w/jnp1JszbRM9PrZGolYwtDnO7m?=
 =?us-ascii?Q?zx3co7hoPkKXhazm702a1qoEEdh5JXhh3LOwXais0iXEz52RkxSjOJtRyikh?=
 =?us-ascii?Q?qKbxqs1gpVYre2Pl7HNAC/FFAsLGKAWuFH6awjA4ML5PLJf8Emj69VWUEdm1?=
 =?us-ascii?Q?SHyhCpkRHM5YXV3UiIKYBjdEacTkVBlVQSXk0B+Zbx2U0VQhHCIACQ2w7gv6?=
 =?us-ascii?Q?25tW4mQb/Dx2WWVH+48N7vTdtal3+S0RfV3W0PaKmCcT2jpN/3L37d2jVBcY?=
 =?us-ascii?Q?WDkjO1FGAAu3jonvOZ37yY/EbNKByxuz5ne53wlyaBBRJXPDKYbdr2ajgpWx?=
 =?us-ascii?Q?wEwvb/8ydJu0qByedyyXUAKxEBXwgBxbKfR/n1fQhDUGkDeHw14gj1did8T1?=
 =?us-ascii?Q?ySheBUBI9MUIcPgDp9YxbavmvZN/hZ0Y0QeWfMb4Lh2aXhQbGqdFjDmItW8a?=
 =?us-ascii?Q?swmACw8PYcL/DA9yVxN80IhidtYFp0VsH57kTpvYjR0lMdqjJvYHekeVzj5H?=
 =?us-ascii?Q?3xGoYxaERouPbFKLVa2d92WExrTv6IIk99rm6E6FhmVUZRB6U3vAWnsfjrJ2?=
 =?us-ascii?Q?EPPEVhgvQe3GVYcFdxrMPpMbp0KlSYSDPABh6GKs/QqJdyUr48Eprb39fEsP?=
 =?us-ascii?Q?QUGcbyU9tpNyQ+zietgGsXoiSrBD3RvgzEont+NwoSou201nIXCPZC6OYEUa?=
 =?us-ascii?Q?zGqWnNJ+dGHhjoKvKpIQMX/FDGCXUnRwVQONZCNFVvnIZ6AWPFvdSyHoBKJk?=
 =?us-ascii?Q?zpegv68KdD2YQaz+hKbt0Mt1AqFZy/Fky9xG8mwmO4CnFsIcnKLHFBK00sZf?=
 =?us-ascii?Q?zIN6X0fh57RdK2xkzTBMqB8X1qPnENY+TW1rE97Ky5eXnbfZ+TnlFwuq9mte?=
 =?us-ascii?Q?ZHuUzmPp012bARu3FfuPexglmtb91QyReYjgFnFljhyIPp22/6JRbOXjni5j?=
 =?us-ascii?Q?FYMPcRklT2ljoMMqmmY5SwEmQZUVS9pHq5/Y5HhLq/UIPnpei0ojalUwuNSG?=
 =?us-ascii?Q?voiVo0Y9e5HSm+PFut9vlwNZFPyscZOMItRA5jye30rrxjZKVeu8iBUqttBm?=
 =?us-ascii?Q?Ln9vNPb042f/k7mnAsWwlnuSCZ4/yXDhEar1eKw05iORQHhc8qNYDK87IGXZ?=
 =?us-ascii?Q?S5DvAvUBjZBKFfWH/oBORAYPsxqPZoRVYZliZcgR9H2Pq0q154z1kk8i0cmY?=
 =?us-ascii?Q?yipdpHQm4A=3D=3D?=
X-Exchange-RoutingPolicyChecked: sQg8nEXFvUUnRPm23MBn5SO+/OtVoL2D7a3XLEBIbIqEj/bODISvI6NcUvajeUcg39zTVrnUFF7aZuT2HS2iKRcCgwNSpOK+RuJyhYE9pIJ+1T2nq4RnxohU3/Uwp8yv7ZcCTobf4jINNjR41rPHp9Ej0+rH30VR7ghAp/jQn/x4bdhl7pjQxUHrUhm7O7606NjVNaAeXFAKIX6LZRIqZpXvhWAkvWSOIeyiceHdAHnipfyj2CUUoD7Tg/bV2OBFjcMyDtDLA0Xso+ps7KPLCF6RW1huoB7RNflmsulHAQR+qDD9wRGTmgusHxN2WJ6IPoeSe2HRBoc1fC28jynf8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15927447-eceb-4b18-2393-08dea67f15f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:09:49.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXCyB475QlBa6jXVaEbb7V7MfRTYfjmNo/TTwbtU66sCfJbhBEPWMctHRTYKcMrhAk5YR+sNTcKN+RA5jq5qHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC60125F65
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7EABF49DE54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282662-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]




Hello,

kernel test robot noticed "kunit.mctp_test_bind_lookup.mctp-route.fail" on:

commit: 0d8647bc74cb50edf02e8c88977657596f20fb17 ("net: mctp: don't require a route for null-EID ingress")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      254f49634ee16a731174d2ae34bc50bd5f45e731]
[test failed on linux-next/master 7080e32d3f09d8688c4a87d81bdcc71f7f606b16]

in testcase: kunit
version: 
with following parameters:

	group: group-00



config: x86_64-rhel-9.4-kunit
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604301303.9de94634-lkp@intel.com


[  111.971253] [      T1]     KTAP version 1
[  111.975040] [      T1]     # Subtest: mctp-route
[  111.979434] [      T1]     # module: mctp
[  111.979441] [      T1]     1..23
[  111.986231] [      T1]         KTAP version 1
[  111.990365] [      T1]         # Subtest: mctp_test_fragment
[  112.001306] [      T1]         ok 1 mtu 63 len 68 -> 1 frags
[  112.021312] [      T1]         ok 2 mtu 64 len 68 -> 1 frags
[  112.041319] [      T1]         ok 3 mtu 65 len 68 -> 2 frags
[  112.060310] [      T1]         ok 4 mtu 66 len 68 -> 2 frags
[  112.076305] [      T1]         ok 5 mtu 127 len 68 -> 2 frags
[  112.092311] [      T1]         ok 6 mtu 128 len 68 -> 2 frags
[  112.108317] [      T1]         ok 7 mtu 129 len 68 -> 3 frags
[  112.124313] [      T1]         ok 8 mtu 130 len 68 -> 3 frags
[  112.129866] [      T1]     # mctp_test_fragment: pass:8 fail:0 skip:0 total:8
[  112.135390] [      T1]     ok 1 mctp_test_fragment
[  112.142787] [      T1]         KTAP version 1
[  112.151486] [      T1]         # Subtest: mctp_test_rx_input
[  112.164341] [      T1]         ok 1 {1,a,8,0}
[  112.180323] [      T1]         ok 2 {1,a,9,0}
[  112.197294] [      T1]         ok 3 {2,a,8,0}
[  112.201460] [      T1]     # mctp_test_rx_input: pass:3 fail:0 skip:0 total:3
[  112.205605] [      T1]     ok 2 mctp_test_rx_input
[  112.212515] [      T1]         KTAP version 1
[  112.221218] [      T1]         # Subtest: mctp_test_route_input_sk
[  112.233266] [      T1]         ok 1 {1,a,8,c8} type 0
[  112.249295] [      T1]         ok 2 {1,a,8,c8} type 1
[  112.265296] [      T1]         ok 3 {1,a,8,c0} type 0
[  112.281324] [      T1]         ok 4 {1,a,8,48} type 0
[  112.298312] [      T1]         ok 5 {1,a,8,8} type 0
[  112.313294] [      T1]         ok 6 {1,a,8,0} type 0
[  112.318064] [      T1]     # mctp_test_route_input_sk: pass:6 fail:0 skip:0 total:6
[  112.322819] [      T1]     ok 3 mctp_test_route_input_sk
[  112.330262] [      T1]         KTAP version 1
[  112.339484] [      T1]         # Subtest: mctp_test_route_input_sk_reasm
[  112.350322] [      T1]         ok 1 single packet
[  112.370288] [      T1]         ok 2 single packet, offset seq
[  112.386294] [      T1]         ok 3 start & end packets
[  112.402301] [      T1]         ok 4 start & end packets, offset seq
[  112.422380] [      T1]         ok 5 start & end packets, out of order
[  112.438273] [      T1]         ok 6 start, middle & end packets
[  112.454354] [      T1]         ok 7 missing seq
[  112.470298] [      T1]         ok 8 seq wrap
[  112.474634] [      T1]     # mctp_test_route_input_sk_reasm: pass:8 fail:0 skip:0 total:8
[  112.478689] [      T1]     ok 4 mctp_test_route_input_sk_reasm
[  112.486650] [      T1]         KTAP version 1
[  112.496387] [      T1]         # Subtest: mctp_test_route_input_sk_keys
[  112.507335] [      T1]         ok 1 direct match
[  112.527297] [      T1]         ok 2 flipped src/dest
[  112.543285] [      T1]         ok 3 peer addr mismatch
[  112.559275] [      T1]         ok 4 tag value mismatch
[  112.575282] [      T1]         ok 5 TO mismatch
[  112.591293] [      T1]         ok 6 broadcast response
[  112.607239] [      T1]         ok 7 any local match
[  112.612212] [      T1]     # mctp_test_route_input_sk_keys: pass:7 fail:0 skip:0 total:7
[  112.616869] [      T1]     ok 5 mctp_test_route_input_sk_keys
[  112.636288] [      T1]     ok 6 mctp_test_route_input_sk_fail_single
[  112.655293] [      T1]     ok 7 mctp_test_route_input_sk_fail_frag
[  112.679282] [      T1]     ok 8 mctp_test_route_input_multiple_nets_bind
[  112.706162] [      T1]     ok 9 mctp_test_route_input_multiple_nets_key
[  112.713544] [   T3382]     # mctp_test_route_input_null_eid: ASSERTION FAILED at net/mctp/test/route-test.c:941
                              Expected rc == 0, but
                                  rc == -22 (0xffffffffffffffea)
[  112.739887] [      T1]     not ok 10 mctp_test_route_input_null_eid
[  112.749280] [      T1]     ok 11 mctp_test_packet_flow
[  112.765293] [      T1]     ok 12 mctp_test_fragment_flow
[  112.781257] [      T1]     ok 13 mctp_test_route_output_key_create
[  112.787153] [   T3390] pkt1 skb len=7 data_len=0 headroom=0 headlen=7 tailroom=377
                          end-tail=377 mac=(-1,-1) mac_len=0 net=(0,-1) trans=-1
                          shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                          csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
                          hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
                          priority=0x0 mark=0x0 alloc_cpu=4 vlan_all=0x0
                          encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  112.841984] [   T3390] pkt1 dev name=mctptest1 feat=0x0000000000004000
[  112.848291] [   T3390] pkt1 skb linear:   00000000: 01 08 0a 88 00 00 00
[  112.854765] [   T3390] pkt2 skb len=7 data_len=0 headroom=7 headlen=7 tailroom=370
                          end-tail=370 mac=(-1,-1) mac_len=0 net=(7,-1) trans=-1
                          shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                          csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
                          hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
                          priority=0x0 mark=0x0 alloc_cpu=4 vlan_all=0x0
                          encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  112.903591] [   T3390] pkt2 dev name=mctptest1 feat=0x0000000000004000
[  112.909890] [   T3390] pkt2 skb linear:   00000000: 01 08 0a 18 11 11 11
[  112.916365] [   T3390] pkt3 skb len=7 data_len=0 headroom=14 headlen=7 tailroom=363
                          end-tail=363 mac=(-1,-1) mac_len=0 net=(14,-1) trans=-1
                          shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                          csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
                          hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
                          priority=0x0 mark=0x0 alloc_cpu=4 vlan_all=0x0
                          encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  112.965431] [   T3390] pkt3 dev name=mctptest1 feat=0x0000000000004000
[  112.971758] [   T3390] pkt3 skb linear:   00000000: 01 08 0a 68 22 22 22
[  112.978231] [   T3390] pkt4 skb len=7 data_len=0 headroom=21 headlen=7 tailroom=356
                          end-tail=356 mac=(-1,-1) mac_len=0 net=(21,-1) trans=-1
                          shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                          csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
                          hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
                          priority=0x0 mark=0x0 alloc_cpu=4 vlan_all=0x0
                          encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  113.027235] [   T3390] pkt4 dev name=mctptest1 feat=0x0000000000004000
[  113.033537] [   T3390] pkt4 skb linear:   00000000: 01 08 0a 88 00 33 33
[  113.040008] [   T3390] pkt5 skb len=7 data_len=0 headroom=28 headlen=7 tailroom=349
                          end-tail=349 mac=(-1,-1) mac_len=0 net=(28,-1) trans=-1
                          shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                          csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
                          hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
                          priority=0x0 mark=0x0 alloc_cpu=4 vlan_all=0x0
                          encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[  113.089005] [   T3390] pkt5 dev name=mctptest1 feat=0x0000000000004000
[  113.095305] [   T3390] pkt5 skb linear:   00000000: 01 08 0a 58 44 44 44
[  113.108303] [      T1]     ok 14 mctp_test_route_input_cloned_frag
[  113.116271] [      T1]     ok 15 mctp_test_route_extaddr_input
[  113.134273] [      T1]     ok 16 mctp_test_route_gw_lookup
[  113.154284] [      T1]     ok 17 mctp_test_route_gw_loop
[  113.159574] [      T1]         KTAP version 1
[  113.168807] [      T1]         # Subtest: mctp_test_route_gw_mtu
[  113.178270] [      T1]         ok 1 dev 68, neigh 0, gw 0, dst 0 -> 68
[  113.197261] [      T1]         ok 2 dev 100, neigh 0, gw 0, dst 0 -> 100
[  113.214153] [      T1]         ok 3 dev 100, neigh 68, gw 0, dst 0 -> 68
[  113.230283] [      T1]         ok 4 dev 100, neigh 0, gw 68, dst 0 -> 68
[  113.250280] [      T1]         ok 5 dev 100, neigh 0, gw 0, dst 68 -> 68
[  113.270351] [      T1]         ok 6 dev 100, neigh 99, gw 98, dst 68 -> 68
[  113.291295] [      T1]         ok 7 dev 99, neigh 100, gw 98, dst 68 -> 68
[  113.311265] [      T1]         ok 8 dev 98, neigh 99, gw 100, dst 68 -> 68
[  113.330322] [      T1]         ok 9 dev 68, neigh 98, gw 99, dst 100 -> 68
[  113.336994] [      T1]     # mctp_test_route_gw_mtu: pass:9 fail:0 skip:0 total:9
[  113.343643] [      T1]     ok 18 mctp_test_route_gw_mtu
[  113.351941] [      T1]     ok 19 mctp_test_route_gw_output
[  113.356955] [      T1]         KTAP version 1
[  113.366346] [      T1]         # Subtest: mctp_test_bind_lookup
[  113.379141] [      T1]         ok 1 {src 20 dst 10 ty 1 net 1 expect remote20}
[  113.395361] [      T1]         ok 2 {src 20 dst 255 ty 1 net 1 expect remote20}
[  113.415345] [      T1]         ok 3 {src 20 dst 0 ty 1 net 1 expect remote20}
[  113.435368] [      T1]         ok 4 {src 0 dst 255 ty 1 net 1 expect any}
[  113.455357] [      T1]         ok 5 {src 0 dst 11 ty 1 net 1 expect any}
[  113.475358] [      T1]         ok 6 {src 0 dst 0 ty 1 net 1 expect any}
[  113.495354] [      T1]         ok 7 {src 0 dst 10 ty 1 net 1 expect local10}
[  113.515425] [      T1]         ok 8 {src 21 dst 10 ty 1 net 1 expect local10}
[  113.536355] [      T1]         ok 9 {src 21 dst 11 ty 1 net 1 expect remote21local11}
[  113.555361] [      T1]         ok 10 {src 99 dst 99 ty 1 net 1 expect any}
[  113.575453] [      T1]         ok 11 {src 20 dst 10 ty 3 net 1 expect (null)}
[  113.595375] [      T1]         ok 12 {src 0 dst 0 ty 1 net 7 expect any}
[  113.615359] [      T1]         ok 13 {src 21 dst 10 ty 1 net 2 expect any}
[  113.635457] [      T1]         ok 14 {src 20 dst 10 ty 1 net 3 expect any}
[  113.655356] [      T1]         ok 15 {src 21 dst 10 ty 1 net 3 expect remote21net3}
[  113.675376] [      T1]         ok 16 {src 21 dst 10 ty 1 net 4 expect remote21net4}
[  113.695360] [      T1]         ok 17 {src 21 dst 10 ty 1 net 5 expect remote21net5}
[  113.715368] [      T1]         ok 18 {src 21 dst 10 ty 1 net 5 expect remote21net5}
[  113.735359] [      T1]         ok 19 {src 99 dst 10 ty 1 net 8 expect local10net8}
[  113.755368] [      T1]         ok 20 {src 99 dst 10 ty 1 net 9 expect anynet9}
[  113.775338] [      T1]         ok 21 {src 0 dst 0 ty 1 net 9 expect anynet9}
[  113.795363] [      T1]         ok 22 {src 99 dst 99 ty 1 net 9 expect anynet9}
[  113.815392] [      T1]         ok 23 {src 20 dst 10 ty 1 net 9 expect anynet9}
[  113.822410] [      T1]     # mctp_test_bind_lookup: pass:23 fail:0 skip:0 total:23
[  113.829409] [      T1]     ok 20 mctp_test_bind_lookup
[  113.847289] [      T1]     ok 21 mctp_test_route_output_direct_no_eids
[  113.863359] [      T1]     ok 22 mctp_test_route_output_gw_no_eids
[  113.879334] [      T1]     ok 23 mctp_test_route_output_extaddr_no_eids
[  113.885312] [      T1] # mctp-route: pass:22 fail:1 skip:0 total:23
[  113.891701] [      T1] # Totals: pass:79 fail:1 skip:0 total:80
[  113.897752] [      T1] not ok 34 mctp-route



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260430/202604301303.9de94634-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


