Return-Path: <netdev+bounces-288385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ID3DKhdB2qw0QIAu9opvQ
	(envelope-from <netdev+bounces-288385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:53:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C0F555AC1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C734313D179
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABA94DD6EC;
	Fri, 15 May 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZFoLrNk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253B4E3765;
	Fri, 15 May 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864415; cv=fail; b=Bz3HvAQAlWlrkp/m1J1TA2cLLdMqSjIDkNcs1HTCq79H72uL7IT9uxv7JFDglTFO34tC65x6iDLZk7r3CJS5tFC6DHFhyEVTcbfpmwhQoL1/Ei/IcBeen5dVwnZSg6WUM/gOZkY4lxzUUQ8qdjwecWBqLm1WrymlXDAn/Um7LdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864415; c=relaxed/simple;
	bh=FtJefJi1POCeUocJz5HAipuy2Nhll9nR8zcEgqwg/rQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PFIwN1AfaUixOYm+Ca2xa3mSvSf9OtQzG1GEoQboZLVl1zb0XowEBlLk/DvH15qPTiVc1I6Ykt1CUB9A/GG1hGQb49grn49gVoltUgM27xN5c/d6ZhYxj8/Qc1Gj4a3s/Tt0Bsm4NGeirBWPxlg92JAuSjceRMCRgxflJv9TzLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZFoLrNk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778864412; x=1810400412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FtJefJi1POCeUocJz5HAipuy2Nhll9nR8zcEgqwg/rQ=;
  b=WZFoLrNkXjKzAH9I9F3oEOFFILwXbK3R+DUMBATlPaPp7d5lfqmn3wk0
   2GP0LvbtaPxhoAuO0ZGitgvJG5NBV3LHlqBAc0avTTFmzg1qxx66FyfiQ
   sDHehwGHodw+Y/Km55yf2ynbkU8t8RQLkbqXJiiHEfi6VJpruaYylLSvd
   KdylvFKCYOFbLbUIneTEWFz2kW6pqiDlumFkuFWlkBvP93mYYDDJ7PA7o
   UraPpYqVy6/oapMbOT5VJ346FePq53pfeitRNv9WC0DzdHHhjWFRT6Zul
   5Ek+HONMDtLsiPuFw3QB8miyVb1vRho8p7kO6SMo3VI+PJC0kHtMjecCJ
   A==;
X-CSE-ConnectionGUID: OavG6qcDTQGVM7b08xciAg==
X-CSE-MsgGUID: 2jUSdJrSTDaaLaM2DGybcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79945191"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79945191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 10:00:11 -0700
X-CSE-ConnectionGUID: 3x93cbkETGe2DvtW5biqTA==
X-CSE-MsgGUID: ZZYNewi4Shqa1Gr3016SzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="237879735"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 10:00:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 10:00:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 10:00:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 10:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvpZyQpKO3ykLp5wYoCXMTqOp+q3yOgh0mGRsGIn9hZK1pfWRbQM4wpBtPAShfUeYQ5g3V1C1RHHBpCcRzoJYZ2p77yrL6uEN0RvtcGffTDlBgLniOvS/sniLk+3LA3BdyIHiz/IyaPlR1t7uE1m0pFs6TGpR315K8Qg+GH2cEmCvjmAo54xx99OTERRCnfR1gxz2AsqbjjQimu/0+6xKWEkKUpCjFlDY6NL4qJu0rVc7cD/LuubvlqbVujw6XLwz1C6y1AbRapfeqrmWpCCnZisM/BuWjXcnJEKoAW3q9S6+BAfv1ZZVPAUxaKOq5kDWTZ0m6yA4eY8XcFqXTQs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd/tsBG2gW2CnnRNk0BI61QZ0qLV6lUvZ6oV6Hi11q4=;
 b=G8+2G1sfAZElDi3FMeuPjPTXW69POlIY2HXV6X6xv0AnoGcGoQbfky0wjwN37IlBrKtGpkix7dFGo61eLFDxTG3sqR9gdSG1NrkR6HCKvjKlalKZnda4RZdSOnnQYt5IjDySn/C0/+bLIcekT+xD2h+N8bnTdesRIri/w44/N77JjQ/KrbOQw+z01xb7Ii7O7DnzQcyD0PtqvYBel4pDAO2bafCY4ngYvh7Ot8VLaYjB1tt8Y5tNjEkeE7gmxPSGMzLPf2m8/40JUp3FZHKuOcxsLKotiRBwH83UGSCjFfabCjReIi6D0+5Fsf/qEJ5qcV9cbYargLjTdIwFyThxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Fri, 15 May 2026 17:00:04 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 17:00:04 +0000
Date: Fri, 15 May 2026 18:59:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 0/5] xsk: fix meta and publish of cq issues
Message-ID: <agdRCYgpmVKkrQFB@boxer>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 17de5cf9-f3a7-4b87-1cf1-08deb2a36892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ZPqLT82mmBmwELNtN+1GTsJe1G59R0mLFYUpewtcQh7iR/DZTndn+q+DFHJ/uluMseFblVk8jU6bAUSHIXtqncM3kubauPqbJSTdl5uVRViUiEuezJKa9Im6bGktOOTVS5MrB0tXh7SS1fAxGoVt+fIECAuzxpvRZE9KmRcl3MGMbveytOfbWWCrevhmCml6inhNOG/WTPzMHseofRHQ/HVn9Wb8aO3v6bh1q9nC8HCUmUk8BcPUnafW5Fp2apdvcLHt8iAGR6pBrMfXsOZoUe8cN7z0SRWxVoADJvSMD1khhN/vyZkr8saotsXk7vj4Rbb9DVnVl7c+f+WL3RDGBglJa67lWNvkdJMdz1XMMfXKNImmVivRTpdUVAT1VJV85Ld5+ngepA5AOyISSeltY+iaAoJT9rWSfbQA4gdR9+iv5UnIpW+fN/6YhAoiPwp/GtBzMd3nZQT7JFl0RlSuVx9GiyAwiiv5yLF1S3nfYbWoWveKP1Vfc5Ln4xbD2mEGmuh0SGjxHZY27HnFr4I616zOY2q+plo0o5rjWWqlUK7VbUztUDOQILjiXEyzNY+KTmdtLHSCGnCcpzUiLzaiIZR65uGuEe3/uhLDDcifGTPxJQP6D3kwK/tLGE3LT1L2wu0HFPOmRUu089ZDYmHUb+4cRH0K877ZZbwTZJt6qYTZ6ERtS9+0Q4DqGzsuqGp2w3gJwGNnwoT1pYJUnZTjKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xLFX4EbOpaWJ0ZEG8X2QOCzaMT3f3pB81aOngqDopvfqYRJykv7l6esFPuQ?=
 =?us-ascii?Q?mXf1OjPmb1GM2KCfVJXcuXZxXFZ+bOpN7Vh438J/WWe/IdHqdxcT9PoqyDYY?=
 =?us-ascii?Q?H67M0k80xx4J53R8FjE7P9p9x1dv2sNeMKG0fXvzey7iiv2PL4877sYeVIka?=
 =?us-ascii?Q?pITavO+lDWJzfZhQsAfwYdNb3rzq/Vuih1z56R3ihMDR0dW4fd1LQceeCINz?=
 =?us-ascii?Q?zL1vpAGDfn2txhK12A3n16eKyZqbCEjvfj/SOm4QW3X2/EmliktaYAQIis4n?=
 =?us-ascii?Q?yoqpXx37zTJbjBj0xluziGTuDP/itr/OQcBGvrgz4OZZrYBCsmpHO4Yxm2ax?=
 =?us-ascii?Q?imkXL5uPR3w7dppkdIoWzwZaIbvBHBlqcbHCc8x3XTAzRXTktgU8gX43vrLw?=
 =?us-ascii?Q?fPqh+ACppjuzdBHr+0nBX46rf1v9WbD1KCuLeI1R4qz9qTFmbvwnI2nCxPF/?=
 =?us-ascii?Q?UUvCjMCgn/8KklEoYK8a9aiNrIuVYzLd0iuwHM8djpCNJabVdfnGSuA7cWeg?=
 =?us-ascii?Q?s5ajs5x0eCnx6edjb2prMynI6a63VCjU93bWkJNpizyoA7Bp3xctPUnQ5yxP?=
 =?us-ascii?Q?pKVAV/UB78Wc6zzMf+0QIDIqGyNxK0E/6WHPrNlB4Nx8RLKFNOWOMbwpXIRv?=
 =?us-ascii?Q?T+KwredSkmzUvq5Icg+WV1PYAptbAhe5hCTQsyfpKCb+4AZQXPcZmNTatsaG?=
 =?us-ascii?Q?8di0gB5gN9oHMjt95X3hBW7xm5ZH8jJm3CuDJy+x/agHZwXrz8FK99grtGrH?=
 =?us-ascii?Q?Y0KTApfs+0h/Rx2WblpWuV/C5mZiEny8+GaZrtpxaGS6NY+r/L85P6GW/Nuj?=
 =?us-ascii?Q?b9KSawPIgV4tp2sfBQtXe7FgO30RNJXr+shpcqfA1TyihzGlGvzD77H4oIWZ?=
 =?us-ascii?Q?lKrVS6VHCxsYVJHCpWKGi/3HKlJfWuED5tu7mDX+oaHfdZ3mp+OxSMDA4m+i?=
 =?us-ascii?Q?4Ez1SwXQwXnMM8B/YFbscEUKdf+Yyw9ZivdyAySZu8hIzpL7G7UTHD6qJ0z/?=
 =?us-ascii?Q?3zdO8OiIjsQBBLFr5YkbN0ZBmf0jh6AqxSG1EVQVJ0RjmdUVhIk/6iV3Z6t0?=
 =?us-ascii?Q?PfMIWAOCFXBSdcUouiBc+lU4yH6N4dvYdLzG0LaKyMbSpSw2RzW3oINJnsA4?=
 =?us-ascii?Q?n1uABHshbmkRDO93elHyK8Qr3qeBxxRRO713DW3UmNUwVx1BL3X9xzEeDBh2?=
 =?us-ascii?Q?GtoR0grYK3eATyfb+12ICNu5Vph46G5igr+l4Dq04zQqtH0ZvWAi95mrUjmF?=
 =?us-ascii?Q?ttAlpTh9GNse12m6jHw1yFh311VDgSs/A6cP49KNf5K4H4NO/TgYy0j7dmlY?=
 =?us-ascii?Q?jYGKDvMttDDwhMyv7ZILROYTDEtBmZemn2oE6ObW3OQLFQSYd64A6bZXvZhL?=
 =?us-ascii?Q?GmcgG569S3G3nqkMbqtbvT3RKkf3xAf6826eq7moaLOXbG+lE4fjgCGbHcr9?=
 =?us-ascii?Q?j7kPyA7lUIlp5RbihR3MYOgi6C/JpWUdfgjuP0lWrUzVMNJ83LyR2TlAdrYt?=
 =?us-ascii?Q?u7crfwziXWago2ZKnshgVpz2qY9ZUBi507gOa0iDw9jsG54ccSPCdshL1Aw/?=
 =?us-ascii?Q?4zkqXxutdYddOKgW0BS98ChdUaG+frjd8G5bdFH/KhWRzHZkcUuXyrLE3vqD?=
 =?us-ascii?Q?yBnGbkPe/EJ51KlUviRLuxCjs4zOXgKmxzdXbD0DSX8gr1y4mfrZL6cISWUy?=
 =?us-ascii?Q?mG1PBSpws4rWjr4+RozVcl6N+wMxlSpna04NGiLUi0r/7ozFW073fZf0v1XC?=
 =?us-ascii?Q?oLHKo6Hmrqw6sGioe8zhzK1l1UHlDL4=3D?=
X-Exchange-RoutingPolicyChecked: EaQPHuRjZe3n7snb/bO7o/GrvLXLCwFVkoMvu8X8snPPjRrsY0V6nydKLf6NBpOY1d3s8My/k9SCECb78NAVl9VPF95kx+kx8v56sL2/ErCL9MNxeUDHh3xR2WjkawTLHZW3HY2Y841c4oso9XPPwB4oS0oD9Mu0F7sasUOJrE2HuUNe/7Wd4VOUVYPmek8G/ZiDad+jy2Z0rQCTwk82VCYYMU9X+wEuWAAMkcLC+95wXjyEMBo7OJJ0IZ7vv/2q0ELjzNflHFo+wSs25vjO2n/khrLPh7r+8y323S7FfA97rk04z+fere38oH540vxUkDBmmf3AaQS7oICvzPuAsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17de5cf9-f3a7-4b87-1cf1-08deb2a36892
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:00:03.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZogDXvBkKnymKajL9ozss1i868c/ojkxqnY1hrlGDrGrs5atjSklFCsH+5UO4P6XfCA5m2CZgH3DEnoaYc7ELr4XStI6YxJE55HjojwrFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 95C0F555AC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288385-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,tencent.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 08:30:13PM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The series is the product of previous review from sashiko[1].
> 
> 1) META
> patch 1: address TOCTOU around metadata.
> 
> 2) PUBLISH of CQ
> patch 2: make sure xsk_addr->addrs[] can be published to cq when
>          overflow occurs.
> patch 3: keep cleaning up the continuation descs (more than 17) and
>          publish its address when overflow occurs.
> patch 4: like patch 3, but only handles the invalid descs cases.
> 
> [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> 
> ---
> V2
> Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> 1. adjust selftests (Jakub)
> 2. add READ_ONCE in patch 1 (Stan)
> 
> 
> Jason Xing (5):
>   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
>   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
>   xsk: drain continuation descs after overflow in xsk_build_skb()
>   xsk: drain continuation descs on invalid descriptor in
>     __xsk_generic_xmit()
>   selftests/xsk: fix multi-buffer invalid desc tests for drain_cont
> 
>  include/net/xdp_sock.h                        |  1 +
>  net/xdp/xsk.c                                 | 48 +++++++++++++++----
>  .../selftests/bpf/prog_tests/test_xsk.c       | 45 +++++++++--------
>  3 files changed, 64 insertions(+), 30 deletions(-)

this adds regression to xskxceiver runs on real hw (ice on my side):

PREREQUISITES: [ PASS ]
1..108
ok 1 PASS: SKB SEND_RECEIVE
ok 2 PASS: SKB SEND_RECEIVE_2K_FRAME
ok 3 PASS: SKB SEND_RECEIVE_SINGLE_PKT
ok 4 PASS: SKB POLL_RX
ok 5 PASS: SKB POLL_TX
ok 6 PASS: SKB POLL_RXQ_FULL
ok 7 PASS: SKB POLL_TXQ_FULL
ok 8 PASS: SKB ALIGNED_INV_DESC
ok 9 PASS: SKB ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 10 PASS: SKB UMEM_HEADROOM
ok 11 PASS: SKB BIDIRECTIONAL
ok 12 PASS: SKB STAT_RX_DROPPED
ok 13 PASS: SKB STAT_TX_INVALID
ok 14 PASS: SKB STAT_RX_FULL
ok 15 PASS: SKB STAT_FILL_EMPTY
ok 16 PASS: SKB XDP_PROG_CLEANUP
ok 17 PASS: SKB XDP_DROP_HALF
ok 18 PASS: SKB XDP_SHARED_UMEM
ok 19 PASS: SKB XDP_METADATA_COPY
ok 20 PASS: SKB XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
ok 22 PASS: SKB TOO_MANY_FRAGS
ok 23 PASS: SKB XDP_ADJUST_TAIL_SHRINK
ok 24 PASS: SKB TX_QUEUE_CONSUMER
ok 25 PASS: SKB XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 26 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW
ok 27 # SKIP SKIP: SKB XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 28 PASS: SKB SEND_RECEIVE_9K_PACKETS
ok 29 PASS: SKB SEND_RECEIVE_UNALIGNED
ok 30 PASS: SKB UNALIGNED_INV_DESC
ok 31 PASS: SKB UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 32 PASS: SKB SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
ok 34 PASS: SKB HW_SW_MIN_RING_SIZE
ok 35 PASS: SKB HW_SW_MAX_RING_SIZE
ok 36 PASS: SKB TEARDOWN
ok 37 PASS: DRV SEND_RECEIVE
ok 38 PASS: DRV SEND_RECEIVE_2K_FRAME
ok 39 PASS: DRV SEND_RECEIVE_SINGLE_PKT
ok 40 PASS: DRV POLL_RX
ok 41 PASS: DRV POLL_TX
ok 42 PASS: DRV POLL_RXQ_FULL
ok 43 PASS: DRV POLL_TXQ_FULL
ok 44 PASS: DRV ALIGNED_INV_DESC
ok 45 PASS: DRV ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 46 PASS: DRV UMEM_HEADROOM
ok 47 PASS: DRV BIDIRECTIONAL
ok 48 PASS: DRV STAT_RX_DROPPED
ok 49 PASS: DRV STAT_TX_INVALID
ok 50 PASS: DRV STAT_RX_FULL
ok 51 PASS: DRV STAT_FILL_EMPTY
ok 52 PASS: DRV XDP_PROG_CLEANUP
ok 53 PASS: DRV XDP_DROP_HALF
ok 54 PASS: DRV XDP_SHARED_UMEM
ok 55 PASS: DRV XDP_METADATA_COPY
ok 56 PASS: DRV XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
ok 58 PASS: DRV TOO_MANY_FRAGS
ok 59 PASS: DRV XDP_ADJUST_TAIL_SHRINK
ok 60 PASS: DRV TX_QUEUE_CONSUMER
ok 61 PASS: DRV XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 62 PASS: DRV XDP_ADJUST_TAIL_GROW
ok 63 PASS: DRV XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 64 PASS: DRV SEND_RECEIVE_9K_PACKETS
ok 65 PASS: DRV SEND_RECEIVE_UNALIGNED
ok 66 PASS: DRV UNALIGNED_INV_DESC
ok 67 PASS: DRV UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 68 PASS: DRV SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
ok 70 PASS: DRV HW_SW_MIN_RING_SIZE
ok 71 PASS: DRV HW_SW_MAX_RING_SIZE
ok 72 PASS: DRV TEARDOWN
ok 73 PASS: ZC SEND_RECEIVE
ok 74 PASS: ZC SEND_RECEIVE_2K_FRAME
ok 75 PASS: ZC SEND_RECEIVE_SINGLE_PKT
ok 76 PASS: ZC POLL_RX
ok 77 PASS: ZC POLL_TX
ok 78 PASS: ZC POLL_RXQ_FULL
ok 79 PASS: ZC POLL_TXQ_FULL
ok 80 PASS: ZC ALIGNED_INV_DESC
ok 81 PASS: ZC ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 82 PASS: ZC UMEM_HEADROOM
ok 83 PASS: ZC BIDIRECTIONAL
# Can not run RX_DROPPED test for ZC mode
ok 84 # SKIP SKIP: ZC STAT_RX_DROPPED
ok 85 PASS: ZC STAT_TX_INVALID
ok 86 PASS: ZC STAT_RX_FULL
ok 87 PASS: ZC STAT_FILL_EMPTY
ok 88 PASS: ZC XDP_PROG_CLEANUP
ok 89 PASS: ZC XDP_DROP_HALF
ok 90 PASS: ZC XDP_SHARED_UMEM
ok 91 PASS: ZC XDP_METADATA_COPY
ok 92 PASS: ZC XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
---------------------------------------
not ok 94 FAIL: ZC TOO_MANY_FRAGS
ok 95 PASS: ZC XDP_ADJUST_TAIL_SHRINK
# Can not run TX_QUEUE_CONSUMER test for ZC mode
ok 96 # SKIP SKIP: ZC TX_QUEUE_CONSUMER
ok 97 PASS: ZC XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 98 PASS: ZC XDP_ADJUST_TAIL_GROW
ok 99 PASS: ZC XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 100 PASS: ZC SEND_RECEIVE_9K_PACKETS
ok 101 PASS: ZC SEND_RECEIVE_UNALIGNED
ok 102 PASS: ZC UNALIGNED_INV_DESC
ok 103 PASS: ZC UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 104 PASS: ZC SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
ok 106 PASS: ZC HW_SW_MIN_RING_SIZE
ok 107 PASS: ZC HW_SW_MAX_RING_SIZE
ok 108 PASS: ZC TEARDOWN
# 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
1..108
ok 1 PASS: SKB BUSY-POLL SEND_RECEIVE
ok 2 PASS: SKB BUSY-POLL SEND_RECEIVE_2K_FRAME
ok 3 PASS: SKB BUSY-POLL SEND_RECEIVE_SINGLE_PKT
ok 4 PASS: SKB BUSY-POLL POLL_RX
ok 5 PASS: SKB BUSY-POLL POLL_TX
ok 6 PASS: SKB BUSY-POLL POLL_RXQ_FULL
ok 7 PASS: SKB BUSY-POLL POLL_TXQ_FULL
ok 8 PASS: SKB BUSY-POLL ALIGNED_INV_DESC
ok 9 PASS: SKB BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 10 PASS: SKB BUSY-POLL UMEM_HEADROOM
ok 11 PASS: SKB BUSY-POLL BIDIRECTIONAL
ok 12 PASS: SKB BUSY-POLL STAT_RX_DROPPED
ok 13 PASS: SKB BUSY-POLL STAT_TX_INVALID
ok 14 PASS: SKB BUSY-POLL STAT_RX_FULL
ok 15 PASS: SKB BUSY-POLL STAT_FILL_EMPTY
ok 16 PASS: SKB BUSY-POLL XDP_PROG_CLEANUP
ok 17 PASS: SKB BUSY-POLL XDP_DROP_HALF
ok 18 PASS: SKB BUSY-POLL XDP_SHARED_UMEM
ok 19 PASS: SKB BUSY-POLL XDP_METADATA_COPY
ok 20 PASS: SKB BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
ok 22 PASS: SKB BUSY-POLL TOO_MANY_FRAGS
ok 23 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK
ok 24 PASS: SKB BUSY-POLL TX_QUEUE_CONSUMER
ok 25 PASS: SKB BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 26 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW
ok 27 # SKIP SKIP: SKB BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 28 PASS: SKB BUSY-POLL SEND_RECEIVE_9K_PACKETS
ok 29 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED
ok 30 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC
ok 31 PASS: SKB BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 32 PASS: SKB BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
ok 34 PASS: SKB BUSY-POLL HW_SW_MIN_RING_SIZE
ok 35 PASS: SKB BUSY-POLL HW_SW_MAX_RING_SIZE
ok 36 PASS: SKB BUSY-POLL TEARDOWN
ok 37 PASS: DRV BUSY-POLL SEND_RECEIVE
ok 38 PASS: DRV BUSY-POLL SEND_RECEIVE_2K_FRAME
ok 39 PASS: DRV BUSY-POLL SEND_RECEIVE_SINGLE_PKT
ok 40 PASS: DRV BUSY-POLL POLL_RX
ok 41 PASS: DRV BUSY-POLL POLL_TX
ok 42 PASS: DRV BUSY-POLL POLL_RXQ_FULL
ok 43 PASS: DRV BUSY-POLL POLL_TXQ_FULL
ok 44 PASS: DRV BUSY-POLL ALIGNED_INV_DESC
ok 45 PASS: DRV BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 46 PASS: DRV BUSY-POLL UMEM_HEADROOM
ok 47 PASS: DRV BUSY-POLL BIDIRECTIONAL
ok 48 PASS: DRV BUSY-POLL STAT_RX_DROPPED
ok 49 PASS: DRV BUSY-POLL STAT_TX_INVALID
ok 50 PASS: DRV BUSY-POLL STAT_RX_FULL
ok 51 PASS: DRV BUSY-POLL STAT_FILL_EMPTY
ok 52 PASS: DRV BUSY-POLL XDP_PROG_CLEANUP
ok 53 PASS: DRV BUSY-POLL XDP_DROP_HALF
ok 54 PASS: DRV BUSY-POLL XDP_SHARED_UMEM
ok 55 PASS: DRV BUSY-POLL XDP_METADATA_COPY
ok 56 PASS: DRV BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
ok 58 PASS: DRV BUSY-POLL TOO_MANY_FRAGS
ok 59 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK
ok 60 PASS: DRV BUSY-POLL TX_QUEUE_CONSUMER
ok 61 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 62 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW
ok 63 PASS: DRV BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 64 PASS: DRV BUSY-POLL SEND_RECEIVE_9K_PACKETS
ok 65 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED
ok 66 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC
ok 67 PASS: DRV BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 68 PASS: DRV BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
ok 70 PASS: DRV BUSY-POLL HW_SW_MIN_RING_SIZE
ok 71 PASS: DRV BUSY-POLL HW_SW_MAX_RING_SIZE
ok 72 PASS: DRV BUSY-POLL TEARDOWN
ok 73 PASS: ZC BUSY-POLL SEND_RECEIVE
ok 74 PASS: ZC BUSY-POLL SEND_RECEIVE_2K_FRAME
ok 75 PASS: ZC BUSY-POLL SEND_RECEIVE_SINGLE_PKT
ok 76 PASS: ZC BUSY-POLL POLL_RX
ok 77 PASS: ZC BUSY-POLL POLL_TX
ok 78 PASS: ZC BUSY-POLL POLL_RXQ_FULL
ok 79 PASS: ZC BUSY-POLL POLL_TXQ_FULL
ok 80 PASS: ZC BUSY-POLL ALIGNED_INV_DESC
ok 81 PASS: ZC BUSY-POLL ALIGNED_INV_DESC_2K_FRAME_SIZE
ok 82 PASS: ZC BUSY-POLL UMEM_HEADROOM
ok 83 PASS: ZC BUSY-POLL BIDIRECTIONAL
# Can not run RX_DROPPED test for ZC mode
ok 84 # SKIP SKIP: ZC BUSY-POLL STAT_RX_DROPPED
ok 85 PASS: ZC BUSY-POLL STAT_TX_INVALID
ok 86 PASS: ZC BUSY-POLL STAT_RX_FULL
ok 87 PASS: ZC BUSY-POLL STAT_FILL_EMPTY
ok 88 PASS: ZC BUSY-POLL XDP_PROG_CLEANUP
ok 89 PASS: ZC BUSY-POLL XDP_DROP_HALF
ok 90 PASS: ZC BUSY-POLL XDP_SHARED_UMEM
ok 91 PASS: ZC BUSY-POLL XDP_METADATA_COPY
ok 92 PASS: ZC BUSY-POLL XDP_METADATA_COPY_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
---------------------------------------
not ok 94 FAIL: ZC BUSY-POLL TOO_MANY_FRAGS
ok 95 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK
# Can not run TX_QUEUE_CONSUMER test for ZC mode
ok 96 # SKIP SKIP: ZC BUSY-POLL TX_QUEUE_CONSUMER
ok 97 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF
ok 98 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW
ok 99 PASS: ZC BUSY-POLL XDP_ADJUST_TAIL_GROW_MULTI_BUFF
ok 100 PASS: ZC BUSY-POLL SEND_RECEIVE_9K_PACKETS
ok 101 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED
ok 102 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC
ok 103 PASS: ZC BUSY-POLL UNALIGNED_INV_DESC_4001_FRAME_SIZE
ok 104 PASS: ZC BUSY-POLL SEND_RECEIVE_UNALIGNED_9K_PACKETS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
ok 106 PASS: ZC BUSY-POLL HW_SW_MIN_RING_SIZE
ok 107 PASS: ZC BUSY-POLL HW_SW_MAX_RING_SIZE
ok 108 PASS: ZC BUSY-POLL TEARDOWN
# 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:97 fail:7 xfail:0 xpass:0 skip:4 error:0
XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]

Summary:
XSK_SELFTESTS_ens785f0np0_SOFTIRQ: [ FAIL ]
XSK_SELFTESTS_ens785f0np0_BUSY_POLL: [ FAIL ]

> 
> -- 
> 2.41.3
> 

