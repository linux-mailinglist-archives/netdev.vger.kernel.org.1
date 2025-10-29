Return-Path: <netdev+bounces-234143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE6C1D23D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD24E375D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EF331A805;
	Wed, 29 Oct 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J38RrKC3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CC258ECC;
	Wed, 29 Oct 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768433; cv=fail; b=F0FAQujWWDeKJlcfns/rdAs1eq6G5UC3BSFh7gurCq4mins5eAipLxfU0ewqHcmyOI61VBz/zXob8mSeyJpWzg3t6z0c+H9y3XcwGtUkRlXwFoSr0UlC7brbsaWuI7X6/1uWueJFGpmeGdaksvndf0hyYFo1jAahe0YpFywXaaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768433; c=relaxed/simple;
	bh=bwWxWYtOtMP8dUnyaAqbI1p3e3xpdz4NiUlxU1HUXJo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsC+eaGlxJ07tntYACDA0p6HXCXCoSA8/UmJx6yIeCoDrQnYqscYbNK9jMYNTczM6M+0bfs1V2VXaukEmVvlPBdI3HvJusUtwl2TPYBCz2pZV7Ff4dl4HjiZrDsWbpY60V7hPu1Em6/HyNnnjHOJLav9TcuGoNrZy+R6zVyOsKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J38RrKC3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761768431; x=1793304431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=bwWxWYtOtMP8dUnyaAqbI1p3e3xpdz4NiUlxU1HUXJo=;
  b=J38RrKC3xebYMXSW4DtGOot0VJP9UsW+u0G4KHqUXNIOCd5AA3I/nthn
   49BrhwC4lEkShCFqXliJLab30hfayQNDuCMw6ADoIDdL8QlSpHEVEnaBL
   tNowx3DClxTwTwy3fqeazXf9U8P/4oIe+YDwH82ewodxdnn+jZeByXkFR
   gBH7K8ODIZZdW8gitHr5kd1R56+OUAFMmxkA+kwBZHHH4rGaXicn3xnO+
   KYYGWIh+dTvqH0Jo5u2LaMcQ7NaBy1932pCKE9U1+/VmKt6HXRC0tWMAi
   MGdn7XPZJBjK9r9DxGxGDQN8ZJ3HnuuKWR0VW6HJEeKCMVSfdfnfOiN+v
   w==;
X-CSE-ConnectionGUID: tUsJ324zTXGUThL6kfqWxw==
X-CSE-MsgGUID: AEswSp9hTVmXrkfOEHeRyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="62926669"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="62926669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:07:10 -0700
X-CSE-ConnectionGUID: XkpmzJwERJW6GhquVZqS4w==
X-CSE-MsgGUID: l3DQZX1CQbS6FvzcvGlYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="asc'?scan'208";a="222977523"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:07:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:07:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 13:07:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 13:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrG7AwwqyIICmMAgQAHHa7S+zq6bSA1dAe97MCupGmf0neEe6NSatKZY6iiqPDD54Qxcw0YosHjuTu85YKF837bBcsmyjHHT+vybxfnlSjgi2+MOaQ8MnKamIBpfPFomiY3MlNJo4wE3Oj2sedEzXhQAgM3qbVwzgARpTROJeNxhr9+cQPiBn9AhmRBZbNBnD7djSdcNk7KIsfXjEDOlODE2VrpwhQlCNECftStJ4YFxjyKWGuWVnptDoZqxEvNWkalsKdRHZh3+3hcysKk2mbsKi7nqc9IY+uMGdUURqt5I3E2SiJewYbZw8sjVxhd8ss5ACJI0x8K1sFpFMFIjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2mstesM+TRJK5mM98hN5QEjIBA5DzXoBoeSW+aoILc=;
 b=NwYKytIq5S+hRMaHlJOp4TjJ0+swWZ1LwVkHNhe1qh59qYb28HWmrl/CLLNmeyudzMcapMxaJBx22ii8L9oHHGx8RDjGv9RLLv3fgzym9ukWyqowcJhwAZ7Ulyhd/h1yu9DVqd2Xq2IDX47q/Xawsr4ASEqUZK3EIjGYOauUuLzvVekLEpqAAoNwGcoAZvrNlWBezBG2rbr5f0WFQtrD8MEdGBoWoxXSR7FJgf7orIYe5tQKQRgNyP3bTbpKXt8DQmPjVWMxVSsijnfAhrdBFkdUHlD3YJIDMqqLzCRJqOK6JBMUgpqEYgpRMAgadJufVWQjcFtAeBIaqesk8waShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 20:07:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 20:07:07 +0000
Message-ID: <959d8329-bb9d-457e-a4a9-f7d60fbf83a8@intel.com>
Date: Wed, 29 Oct 2025 13:07:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net: ethernet: ti: netcp: Standardize
 knav_dma_open_channel to return NULL on error
To: Nishanth Menon <nm@ti.com>, Jakub Kicinski <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Santosh Shilimkar <ssantosh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20251029132310.3087247-1-nm@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251029132310.3087247-1-nm@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------kbNJ2hWyIe7VXIVcNzELK8rv"
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYXPR11MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e66ca8-f1b2-45f6-708b-08de1726bcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk9GSTc1NUNFVWh6ZGVZRStTY2tvd2trVndzMmpVUHZUd1F2RTdnaE9zallF?=
 =?utf-8?B?Um9xMUJOS1k5emYrNzEzSEVMKzV1RUZGREpnRnl0ZWlLdHJOTXVpR2kzWUEz?=
 =?utf-8?B?SEd0NVAreE42L1dCM2ZUS0dCeGtiWUdXWW9UeEdoenFDWDNOSzhYRjliWWw2?=
 =?utf-8?B?REJxUlhvUlc0amRUMlJVKzNQaWFZQWZJT3lWUWhPeVNWeVNxTk9zODFGTGdz?=
 =?utf-8?B?RC9qelhUM1lSVjhrajVwN3NIVWtwT1hCcmNjeERLOS9zbmNJTUgxTWoreTFW?=
 =?utf-8?B?RUp6cHUvL0c5aVoyQWRoeEJaUHFSK3IzVlpDZzdFa25odU5DN1JDMDhvZWV0?=
 =?utf-8?B?V2JUS29PK1oydnZxb0VRQXlVYkpRV2hVS25VVUJWaWpXNGthK2RSUVM1MTdR?=
 =?utf-8?B?Zk9WMG9vU3hLYnNxV1h4QlhmUDVVa3VZWWVla0tZNmJWWnpyUE5neGp5Rmhh?=
 =?utf-8?B?TUh2NitEcGdZVjJVOEJZNXdSS0xnalZPSXJtWDY4K1NBeDNqRHg2Ny8wM0Q2?=
 =?utf-8?B?SUUxNFBWek94VDVPU2ZvcWJRME52U3VBWkZZbGU5cnExVk15M2VrZTJCSlFW?=
 =?utf-8?B?L1N1d28zWVhjSU1INzF0U0tRbzM4MjF3c3FlY0VRdmRLTEdUOVhnWG8yaHJ4?=
 =?utf-8?B?L3Yvdi9yOG1wSEVLRFBMVGVpd2FsQ095Q21GbkxsTmNjbVo0MmIvd1J3WlBE?=
 =?utf-8?B?WTFUTkZPMkhRM1ZrZHk1QUsyZmxqeXF0VG0zOHdDV2k1VzlxOGM1Uk5MRHA3?=
 =?utf-8?B?SjhjeUpmbG1McXNtakUzT3Vka1QwdHVMZmo5WkptdG43YWhIbktOV2p4VEVy?=
 =?utf-8?B?M1N0N0xuUVFTZklWOG1lZGFOTjduS0R2QTlFTTBuSTkrRTZmVkliallnZExE?=
 =?utf-8?B?eUxibVdaK05nSmMxNzdMaUEvTGVYWnIycjNjSjlwemdBUzM0Q3ZQUlpWeEZT?=
 =?utf-8?B?czRPZXd0a0dZU0l4QkNZZzd2aHRjRzBZa3R6VnNlYkQ5OG5IQ2JpZENIbWM4?=
 =?utf-8?B?VHI2UStoMEYycFhxWlh3VzVaRFowdEcyVDRXbGw0bXRvTEZ3NVJoc0MxVklC?=
 =?utf-8?B?TGdKYzZnL1padTVZdDEzV1p0TnQ5TUxRV1JjTG1yQTlFZU1PWGpGOFFoZnFu?=
 =?utf-8?B?Rm1XSmhUeWdxNnlQZlI1MFRyajQ4VXRHUnIybG1UZTI2UU1LVmVFSVFOcHFv?=
 =?utf-8?B?UkowMUdUYTVJekp4L1RHNkNYNUliaGJSWSsyTGw0R3kyR0s0MDVPQk1pR1lo?=
 =?utf-8?B?QzE4L2NrQ05GY2dvQjNaci85dHpnM1l4bGN2UUVFOHNhWjE3KzBOWEFxMVJh?=
 =?utf-8?B?RkEzaFVHNTFUcXFtYXVsS0t6eTF3ZnpQSEt0Qi9Ma1VhbllSaGNhY0FpT0Ux?=
 =?utf-8?B?em1XSzZJSlovNk1HSmMrKzJmMUxxRG80RG5JMXcwakJWT1lnT1ZsbmtyOG8w?=
 =?utf-8?B?NitlMXRrbnZNWjhaVEkwUTJZeFBLWnJuVTFIbFlISm1ibTJyaThZdjBvanR4?=
 =?utf-8?B?aWYwcjNhN2hHOTc4cmZQRG5kZVBVU01lOUVhdGlTM0E0bzRXTGYxVjFudCs3?=
 =?utf-8?B?ZnFyWFRIWlBMY2hqbG5abk4yTlBOSTRnekwzSVEyR1RJWjVqYTZKODRRdFpt?=
 =?utf-8?B?WkorTEdKaGpWQklUc2hZcGV6V1VWaEdnQ093OFRCVTEzS3NnTlpzRFZCZngw?=
 =?utf-8?B?SDFINEYyb2txVXNzYzd4ZC9xSjJ5NjNLWlZ5dHJBekxMQzR0NkZOQ3NDU2Rs?=
 =?utf-8?B?V3U5eGlPbDNKaDJzQ3pOcloxTDE2dFhnRlp1SGVLVVd4RGZjNFpxeFJ1QnB0?=
 =?utf-8?B?bEdnV1lZcEwwTkZhM1Eyd2FCSG51bi9CZGVMaUdqZmkwNWdIWERJWWdiRy9q?=
 =?utf-8?B?OEsxcHk3Yk1kVXE3eFNYa2swd1NsYWdNYk9iTlNlZnJUUjdqU1h1YVJwRDdV?=
 =?utf-8?Q?z+eAJDVZQt1RyZO/oXgaqg+D+FCPK7m5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBKVmlpcUZla3U2bWtQMEJkMmpxMDhOUVI2UGx2aEZQRmpRU2NjUEpaNlZO?=
 =?utf-8?B?V2MyMjd3Sm9mWS9hTkI1WWRDSTJTcUszU0RNY2I1Z2RuZFJuMy9rVWN6ZWNY?=
 =?utf-8?B?dHV2dThxUkdndiswdGVyMGxaeDRiK2ZIcElVT1RkbUdLNTA0N2V1b1RiOWtN?=
 =?utf-8?B?bFBLQ0pvaFNETGpIaVV5UTNsY2tuKzFrOUs4WnlBbUlMOU9pSzlFRHdEZW01?=
 =?utf-8?B?TEZWbUpkZW5nM2lxOVcza0xYS2JPVnJWdDdjVHF1Tzk5aG1PTjNEaUVOTUZQ?=
 =?utf-8?B?akhkNnR3SE83VDJ5Rk5mNW1LN2k0cGo0VUNoZzFzTGR2NDFSajlYVjJ2SU1H?=
 =?utf-8?B?aHFab1l6eDNZaFJtK2MzUENNNWlWUW1xMUtIMWdvQkZ5cVdOQ3N6ejV2ZzEz?=
 =?utf-8?B?aVVJcEhvRTFUem5KYjc5S0ZqUitzUTRnMGNsaXl5ZWxGbE5NT3VSUzFnYmVa?=
 =?utf-8?B?cFFPVHloZ0pWUlkyUkpOR2pWcUV4UXR2WFplTWIrQWphamlvOGVZVE9BelRH?=
 =?utf-8?B?bHAzcW9NWmZidk5QSHMrajA5d1l4YWZnT2hNMnNWMXFJMGRUM1V1YkhnQ0po?=
 =?utf-8?B?RG5FcHQ3MDVLVTBDTzVTMkxvME1DVUNYZFY1OVcxSmxzM2FwZHlWN0xUQS9P?=
 =?utf-8?B?dklXcE5tWFIxZW5uaW5hWXRPMHdwdHFrM29HNTNYYjBYTzRHd1luNHlJbmlT?=
 =?utf-8?B?Nk4wdEQ1VlhtL0FoSkVkN01KaDNoR2F5RCs5U2g4Qy9yTlp3WTY0K2YvMmZu?=
 =?utf-8?B?d0VEN1lJbHNOMm9kRFJaZFBpcEJpL21CWGMvcmxzbDVZUGRtVTdBMDI2ajdn?=
 =?utf-8?B?dURvN3M5Tlh3SU94aGdSNVR4SFRWTWFPTmJ4YTB1MFhndi92c1dXN1plWnRx?=
 =?utf-8?B?dDRrMTdwenZ6c2JzQldvK2Y1aFFHTE03aWtNMXlzRVg3UzVvQmhLMTBtY0VN?=
 =?utf-8?B?elNBc0lsYzdYQnQ2SnpuYW43SUljelUyREw0dTBOc2RKUThCNGtJUWhUaHEz?=
 =?utf-8?B?RnJEQkdSYlBqb0lIeEpRdzdLTjhNWGZlTERocTZEdzN6cjRIRExwQXJXZzNJ?=
 =?utf-8?B?YzIxSFRDQXZVd0Z4bTgyekdINUFMeFd1aUVRZjN4bnIwclVaWmlGYk91bmpL?=
 =?utf-8?B?aEY2Q1BaelpwdzBINERQb0o4Vy9COFcvTDJOdVp5QTNSZUFwN1ErOHFNNy9J?=
 =?utf-8?B?RmdwSlowU3oydzVkZFJwR3drWEdKNGkrbFFjWlZPWjNOMGJnU2lsdWZYdnBL?=
 =?utf-8?B?VytNWEZ5T2NVWFdzNlFObG40SW1DV0JicUVLTVFHY0wyTmZ4RTBBQkNDdkV6?=
 =?utf-8?B?ekJiMVJvaU9adUVFNWFFaDN3Y3ZndVI1dGk2STBpYkhmamc0eWNrYzMyWm5N?=
 =?utf-8?B?UUdBTnl3QnliUHFRMU9KajkxaU5rOXFacEVaUTlOQ1FPTWcvOCs1aERiZDhp?=
 =?utf-8?B?aVFWK3d1NVhvT09TTzBXQUNZYmpaVkdtSW0yVTNicXM5ajZUOVBXUm44K21F?=
 =?utf-8?B?OU1CeXUzb1ZWQUtiRE5WOXM0anpPSDY4emFyZU5KOFowaUV4ekN2Q1J1MWNw?=
 =?utf-8?B?WFhiUzUvakhaUTVVZUZNaXRIbGtRbmlkOHdJU2ZMQ1dkd1Q3UDRZQldvYUtN?=
 =?utf-8?B?QWFPQUlxVUVtS0l1WjI4YVhyYkZ0VzRqdytLajVwVTh1ZTBVOUpvdS8rdlJ4?=
 =?utf-8?B?RE9RTS9DeENNYTBJUVozTGhSa3lNdDM3MlNoU0hPSnlobUJPYWtzcFFKdFp4?=
 =?utf-8?B?YlJKVWswd0hqQUwvcXdUWm1mNkhDa3FKNGJkQWJRSnJYR2xEZTRwY282K2RG?=
 =?utf-8?B?bkkwdFBsSXVMVy81V1ZxTjViL0l1ZEdwZU1jQ0pZOTBXSGJKQ1VZbldLODN6?=
 =?utf-8?B?cHIrRDZSOXl4cWlvbGNhUjRzUE5XMHpmcmhDd213bk5taW5NU1Vyb1VzRUha?=
 =?utf-8?B?OFR6SXloTm82TkFuUHc5L3RNZWVoWVZlMmJKNlBJVmxrMkVoaC82aUZhdWwr?=
 =?utf-8?B?QXdNdUttbGdodGwzUXhURTBqYktvd3Q1dDhaTndtL2d6UzF3MS93K0tiM1FC?=
 =?utf-8?B?djdxWnV1UGJtS2w5emJZbUxlbHAxcVFkUWRsSzRzdi9Na0N2M2p0aU9CWVFi?=
 =?utf-8?B?R0RESFpXV3hhWlJrb3QwME53ZzZGTmxhVTBCT052cUlUZlNRcWR6d2dteXAx?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e66ca8-f1b2-45f6-708b-08de1726bcb0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 20:07:07.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caWh84JfJHWkl03gcTWyNainmbaklC0il3ch7jxUIqz55Gi2p+nS3R08q6IfUrVQPrp7PN4y/1Q/cpK3GsMNBNHhtTMz1zuFAY9hETmtjsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com

--------------kbNJ2hWyIe7VXIVcNzELK8rv
Content-Type: multipart/mixed; boundary="------------lS4tKbndktWChwofJ0oAXlmM";
 protected-headers="v1"
Message-ID: <959d8329-bb9d-457e-a4a9-f7d60fbf83a8@intel.com>
Date: Wed, 29 Oct 2025 13:07:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] net: ethernet: ti: netcp: Standardize
 knav_dma_open_channel to return NULL on error
To: Nishanth Menon <nm@ti.com>, Jakub Kicinski <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251029132310.3087247-1-nm@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251029132310.3087247-1-nm@ti.com>

--------------lS4tKbndktWChwofJ0oAXlmM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/29/2025 6:23 AM, Nishanth Menon wrote:
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index a25ebe6cd503..e69f0946de29 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_no=
de *np, const char *name,
>   * @name:	slave channel name
>   * @config:	dma configuration parameters
>   *
> - * Returns pointer to appropriate DMA channel on success or error.
> + * Returns pointer to appropriate DMA channel on success or NULL on er=
ror.
>   */
>  void *knav_dma_open_channel(struct device *dev, const char *name,
>  					struct knav_dma_cfg *config)
> @@ -414,13 +414,13 @@ void *knav_dma_open_channel(struct device *dev, c=
onst char *name,
> =20
>  	if (!kdev) {
>  		pr_err("keystone-navigator-dma driver not registered\n");
> -		return (void *)-EINVAL;
> +		return NULL;
>  	}
> =20
>  	chan_num =3D of_channel_match_helper(dev->of_node, name, &instance);
>  	if (chan_num < 0) {
>  		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
> -		return (void *)-EINVAL;
> +		return NULL;
>  	}
> =20
>  	dev_dbg(kdev->dev, "initializing %s channel %d from DMA %s\n",
> @@ -431,7 +431,7 @@ void *knav_dma_open_channel(struct device *dev, con=
st char *name,
>  	if (config->direction !=3D DMA_MEM_TO_DEV &&
>  	    config->direction !=3D DMA_DEV_TO_MEM) {
>  		dev_err(kdev->dev, "bad direction\n");
> -		return (void *)-EINVAL;
> +		return NULL;
>  	}
> =20
>  	/* Look for correct dma instance */
> @@ -443,7 +443,7 @@ void *knav_dma_open_channel(struct device *dev, con=
st char *name,
>  	}
>  	if (!dma) {
>  		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
> -		return (void *)-EINVAL;
> +		return NULL;
>  	}
> =20
>  	/* Look for correct dma channel from dma instance */
> @@ -463,14 +463,14 @@ void *knav_dma_open_channel(struct device *dev, c=
onst char *name,
>  	if (!chan) {
>  		dev_err(kdev->dev, "channel %d is not in DMA %s\n",
>  				chan_num, instance);
> -		return (void *)-EINVAL;
> +		return NULL;
>  	}
> =20
>  	if (atomic_read(&chan->ref_count) >=3D 1) {
>  		if (!check_config(chan, config)) {
>  			dev_err(kdev->dev, "channel %d config miss-match\n",
>  				chan_num);
> -			return (void *)-EINVAL;
> +			return NULL;
>  		}
>  	}
> =20

Since we were basically always returning -EINVAL that seems reasonable
to just switch to NULL instead.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

--------------lS4tKbndktWChwofJ0oAXlmM--

--------------kbNJ2hWyIe7VXIVcNzELK8rv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQJz6gUDAAAAAAAKCRBqll0+bw8o6Dia
AQCJYRDjkwflH0Klr4r/yj/IJhgqAdBEJ/mA4B2brgS/BgD+IKMDaE1gaOSr+BBfc44MmUmbyUBr
wfJFsChrfojufA0=
=VXXf
-----END PGP SIGNATURE-----

--------------kbNJ2hWyIe7VXIVcNzELK8rv--

