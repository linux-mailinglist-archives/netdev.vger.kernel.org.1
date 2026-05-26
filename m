Return-Path: <netdev+bounces-291915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJRTHuf3FWpxgQcAu9opvQ
	(envelope-from <netdev+bounces-291915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8195DC15D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F309301D301
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAA3B47DF;
	Tue, 26 May 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKMiM8IV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CC3B0AC6;
	Tue, 26 May 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824611; cv=fail; b=iLcFDBQWH5zcEgQRL/0mRvnPxFTeTqLxOHIpfwQhP1FvvEoTBB9UJPN/VLx2h/aSkwJpCHiAobXqBB1Wl5l4bwy9wlG6i5vtMKCKhzPgQRTGb0B89RiZ40/toG0pZBib2a8bYPMEXc6ZKu/+VjUDKDarCHIHM7ROaC67QBehhjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824611; c=relaxed/simple;
	bh=gRDKPEJcX1ul4opj+koSYNjQiu/X7cY8T9ilxMkkPgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1nlIVUMz6xTOtmSmJTSerOYdUla/jnxRT8/eQUudqfqr8UyVGNTl6mjp7aSyqOufGCDW02dJNXvzthB6gs4NdR42DT5XPtB26FF5bFIKdVBRhcWukGp3zsCwpNVakXhSK5HDgIebKvSnpeXvLuXDrhFSEN1RDbt/nrmm2JSuvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKMiM8IV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779824609; x=1811360609;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gRDKPEJcX1ul4opj+koSYNjQiu/X7cY8T9ilxMkkPgE=;
  b=QKMiM8IVW2gGvzdyfic+NbdsdCaZ4qYzL/kdvJ9ucQmbgM0bw3MdvzPC
   bfZVV8ZtXuU+rPXbJZKU2eFvQeCc0PNDtC69R2/S0q7Ww/t8HxL4hiU1T
   uSejn93pGaG126PivZWR8EopLdScDk6VK+1oFTGZ9ykr8DkIc+cBMy9wl
   2CC4x0WIzjJpeQyptp+6Gh/K37LKNu8H+AgsGPS6yDsujOFpztlU7C2CG
   OiAsB8bFIX44Aq/RSuqc+nvByHls7kFPPwzYg3VCxWRBtZzLf7ny1sr6j
   X62A3xtHu5Y56WxJW9+1Qc7TZBPJCUzdDdlwfaxKhUq2TqZO75pF839xH
   w==;
X-CSE-ConnectionGUID: byx66LDWRvqjjCWKPkaMTw==
X-CSE-MsgGUID: ua0/yHdATgi2dR99Mnsn1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90952711"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="90952711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 12:43:29 -0700
X-CSE-ConnectionGUID: EvCbFV1NQDyWQlVsE1SHjQ==
X-CSE-MsgGUID: It+aAhLgTwS9XZc1YMwuLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="243844371"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 12:43:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 12:43:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 12:43:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 12:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVnVQrnVxapsS7XmwzIKjwoiSxS0FGFSiIlmyTCo3a0Qj4rGO5gKoivdiloS7oI1uSfi3SoN/E4pMIMFkeRqFJHGBe0COLWrBP2f/PjQWG/1yDHhZerB0xK+imi93Z2EHnhmuU7VfJF4R7FcpYgzpaYd3w7o8cTe1AXKDm/2OEw8pJ7xRcFnzq9qashYrADEUmuMDbHFGPMyleVnEMocmfgFzAxbiDbULNpd08d6TXiP7DKn5eBethEBvHmNSqvDtYhm2LNI0mx9FUPiaWPIMbaw9EV0zXoLs7jBzrVWJLFMaLh7Xu9zdNNwM4t+xPpvOtbsQWeySaGlL0dogXDZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO+nwFCjQYM5mChzMR8H6BqHmPgbEwQR+jdW3GHO9Og=;
 b=sFgA+mIZbKMq3cMY9KNHxA4WAtFdZxIxWwH4nnFrR7T6DU70c1LXtbcrp2cNgMTbuws1DzesQd+rEb/MXaGADsGdbZ3xRpbprd0Bu0W9/nmnZuJx3pzdNs+FMDCYPNAeFEMxnPshMgHE6rGwV4K6JLOAEZZ3IRkO3T3ZGJ5me0cg3cQXTgd9TsaKp/ESAvuZC3HCPdq8V5nvS9kFjBXeBiajrUhq8EoF1uRdYpA+Bm2DxehxBoGpFHsgpC4dQDl6S3/16nm9YeRG8SGOLD0Lj8INbTGme+AotMVDh40d8GKIrs79H04vaQ2D/Xjkd9Eo5Ts4lFlOFfj/x7Izb8/59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM3PPFD5EE188BF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 19:43:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 19:43:23 +0000
Date: Tue, 26 May 2026 21:43:08 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Message-ID: <ahX3zCRWTD2v7kwn@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer>
 <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer>
 <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer>
 <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
 <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
 <ahChjcRmM+wEx2uq@boxer>
 <CAL+tcoBud6+nZ=Zeq-Ja+nnOcfwt71Z_QBofOS3qyrNt3Tkkvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBud6+nZ=Zeq-Ja+nnOcfwt71Z_QBofOS3qyrNt3Tkkvw@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM3PPFD5EE188BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b81517-88e0-4a2e-5730-08debb5f0c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|6133799003|4143699003|5023799004|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: zkPF+f9Imqy4sGqISDBn0TCrPmqPqDcxbqVVZuZ/eK9J9Qc9Y/rGwEWQJaAkFYNBNIapKrdVoTQCum94wOH9Vag5ygoznIPY2XxL2pHlZ6XLIJ6nalWIMEMM8VXOxBJKPO2CtSi/nNQrFYW41QNx9XAzCeEv3fqoJmZoBtd/vWTmJW5xrQXOHxq9SMrwkidM/7sp4JBzBU2cCIu6/32fvffRd6Iusqmq3UErPK/h45kx5w3X1c/8IHzQve3xZWZVgbCGmKN0f0t7yLRBf6OPjPLW/UeVj1jlNSw1YUPvivZd6IsXJLQhoWs2u73Fa5epSb03OsbRQmyVbPC9EMqi2UgM4bXe9gzeil3C3qKOd7b6teuxBV29Ejx2sd3uR023b64h941YPg1zu+pw78i2HQVVc0TbtYfZA4hmVTiHVgS9LHxjsP88oPG9GBTKauM8A4thRivI0bTHNRch/3VG0rOwVVVi0Y9zZFRzaLTYS7AoPULlFZW5N1k8v3Jv0eZRXgdXxH+BCrJuxMJayUNCJ5UHg78M8FsjsIvTNrh0KHZfbQ4P8w9bnetrkX0tbA+2lTRbHCJ5gW17eXrY45F8ezmjC7tVsnqa8stoN/jzWe4bHbVi3VGNwLX3vwzFU7AK7ufm2ksPhNOdqAf4uTv2nouEyKx4JtzgaNjr9SoPHQnitskMlSb8AsPU4qXicufY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(5023799004)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZMNUNtSTZSMk5veGhjZWlIN0RFM3JOMnF6Q2hIVXdoQjJVbnBYN0JkL0M1?=
 =?utf-8?B?NDh0QjY1ekxoUWFCWTBrSU5rZWcxTThLRkFKTW02bCtoem13V1pPYkQ0NGty?=
 =?utf-8?B?WWpKei8wdnlXMlUvMWYyUVJub0tmaDA5VUI0TkxJalRnVGFVVXF0b0VWSERB?=
 =?utf-8?B?V2wycW1PRndlU1F0VkIyNWx1RTlEVUliampFNEZNYjNXME5yb044dnhSV1Z2?=
 =?utf-8?B?ZHZBNWRVb3NLYlBvalVqNkRTQnl2bkVzb2hLeE0xSjQyVGRCMHRlOTRoWThV?=
 =?utf-8?B?QVYvSGdvSFB0N0FGZHd1YzBtcW5mR1pocDVKS2JYOVp5ODN6MTEwclIxZWZT?=
 =?utf-8?B?L1Z2QW9xUzMxZWtieG9TN1pLWU5zemR3blNsYUdvQmRqT3JudWdMcFUzclQ5?=
 =?utf-8?B?T2FCUFh5SmRBbGJTMkp4WnNGRERUMkVna2N5TDFkZkYxQysxOXRjNE52ODQ0?=
 =?utf-8?B?M3htUVE0ek1nZUxUVFZRajJwS3czbkhUVDdaZXZQQ25iRzJxV0w4QkN1cGpV?=
 =?utf-8?B?SWREYVduLzZaRHR2dDRKNkYrclBqRnNDb0pvUXlieHZpTEswdmkrdXNpSHRF?=
 =?utf-8?B?dVRDeWVvNWh2R1dQNks4YkFyZ0gyaW05b1gyOE5tWFE4N0ZNazIxRTZsYkZR?=
 =?utf-8?B?N1pZOWgxRVphZFY3bHFyTDREanZNMjhVbkJPaGlybmF2UVdia3lpcXlQRFJL?=
 =?utf-8?B?UXVYYU5jMUdwMGx1L1p1bU5GYUMzazN3djRXdmQ0OVVOQldQM25aaFZwVldn?=
 =?utf-8?B?VTNIRzhtY2FnbHpLbVE1cVAvckZpSkR2djZsb1hoaXpkT2drU1lHUFBGQjV5?=
 =?utf-8?B?VWNhS1RDeUJXaWRRcENSb0N4MHRxdUd0Z2dHSTVHbXJFc1E4NlF5eERiMGN4?=
 =?utf-8?B?czZudVhTVXBYNnhNY2U3MXo5OTNTUk9aTXFySUlXLzdmL0N5QVhrQlRyUmFv?=
 =?utf-8?B?S0pTOHQ5R0JNTnBZS2NwUllMZnpFNEJ0M2FGMFlVaTZDemZKR0kwTGpRa2pq?=
 =?utf-8?B?MEs0aVZUZjlVeGtRUS90Q2RyanZjN3dZcTQvWVQ3Nm8wN3BKTEloNlpxbHdI?=
 =?utf-8?B?c3BZNjNUMUpwLzgraWprT0hZR3dMd3BOOExXa1QxRXhocXRmc3pmeTZuZzdE?=
 =?utf-8?B?TWk5aGY0S1BMQSs4eFZTeUdITEhrWEtNSDZCVWVPQ3hJWDlwRE5sUEFqcHky?=
 =?utf-8?B?clN5K1JBV21EMzhXTlJZQU9BR2oxbTNFa09zMnd0Y2ZjdWdjOUI2WERKNG1s?=
 =?utf-8?B?bFpzY0U2RnYxM3p3Q0E3UG8zc2lMZWVmTE9OVFpaNXlLcFdJa0I3U3U5SDRK?=
 =?utf-8?B?K1FHUnVzNnhCNGNiNHVacXlHd3B3cXpRQUI2SVdmOU56U2xsVk1XZXhIelpZ?=
 =?utf-8?B?VU4reXpDVUxaNXdrVjZUamlrNEVwdFM0WWc4V3IvbjNOcTN5Nnd4Z0N2Y3ZK?=
 =?utf-8?B?MEtRbGk3U2E3L1VGT01UbW5hUGdqN3VwWU5XOWlrTHRxMSt0SGozQ3JKdmJZ?=
 =?utf-8?B?UVpPWmhRZ0VDbFh3d0RkVTBCQmNNbStEcVBQU2NTSWE1d05KYmZOZlBGSnIw?=
 =?utf-8?B?dVJBZVZiT1E4c2lWV2VZWHFnUlRCSDBCUTNtR2FIRGpDbVJLNEJaclJFT2li?=
 =?utf-8?B?V2NLTkdDRitjTG93dkxKVVVra096N2lmM3lsMzBtVWYwWnp6Tit4VVVoUmRP?=
 =?utf-8?B?YWhqL1N3RnRNeTB4YkJyTzVIWXJSc29PWU5BRVNBTTlBN2VRNUlHbHlRMHlp?=
 =?utf-8?B?NXJwSUVxSW5qV1YrTWlmcWZZN0JBWDJXM2RPTUNDVy9oUy9vOFU3bVRSSGdk?=
 =?utf-8?B?clAxRWF6VVFnQ25aOCtHZU55MmZSTjlsbWYxRU15OGNrQlREUTJtUmgwVGZX?=
 =?utf-8?B?Si9ndmtleTRNWlNxam5XdjFZKzhkUGdBRms5TDFJSTJmSGpLV09RNHZLMWNS?=
 =?utf-8?B?SWRBamwzTXk2NnR0cWMxdS9rdFpMU1ZaaEIrcjZVUTJ1MU00ay9FeTErZDZr?=
 =?utf-8?B?Y2x6K010VlYrZmZMM08zSldCTXZjQnlBSkUzTk5TclZRUzZ1cUtsV3BNblJh?=
 =?utf-8?B?RFJkOSt6RkZReFRwUjJtaC94c2wrckdrV0ZoOGhMSUpsNHM4NGlYaGFaTWlM?=
 =?utf-8?B?YmxpUS9DRzRxNTlVRHoyRHJTWk5xUW9lZXZwYXNZQmN6eWE3V1FEYWVIZkdT?=
 =?utf-8?B?NWRRVFNyQllaYXVFWXFIK2EvZmlmWE9kNmZxbkdjSWlPY1A0SUNjNXlZODJu?=
 =?utf-8?B?NkJGdFl4SDV2dHFWbFVjQlNnWHY4Z2JxMnYvNTFnZGxFUGZLN0U0TitZODJH?=
 =?utf-8?B?M25PTm4zVFpSL1VYTTRJZSsyR2NxY0laaVhOMGFNa1lnWUNVejk2dlVlcFp0?=
 =?utf-8?Q?HFxhhUD1h7wG0Wa4=3D?=
X-Exchange-RoutingPolicyChecked: inp42z9QO+BlGd+4VoG6SZy6lEWc6cDkw/sBcYoBiKx0DWEX8VmtMvTRXU2EmRQ60+geuo5Ah4Oh5qQDTqY9/24EaAl06UEzcQ9l3+TLi3JkyHITHuJwEFijOvq5g/0RH76EEgkK0oRfxzzkFcPekQpJZsv8jvWgUp9X9Dl2mIHDSw4WHZOM7MJFkbBJOcFrY7JOPtoaN2mT7H32iZeKNSsJBKnBrUf5b8bdc0D57rsOIzwBbxdg4WFpHRvBfBkg5Gkl/l5fQ5re4L3RHOs1gNCPfrEgK9BO1eEQzAsAAr9yAQTjJXM3h4y/hD0efUQwH2MZCBxw+TxID/9hajjUvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b81517-88e0-4a2e-5730-08debb5f0c40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 19:43:23.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k17dF4AfjgIdRw+tJigWRkfXC/BKUTgl5J8QJ8BZ5juLdIYro/TYNDmB+obPoYqTI5/ZT5PjpT6Cjz0IIhmoTZsaks4Ttn8cLvQQPLfGD84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD5EE188BF
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291915-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DA8195DC15D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 07:49:00AM +0800, Jason Xing wrote:
> On Sat, May 23, 2026 at 2:34 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, May 22, 2026 at 09:48:39PM +0800, Jason Xing wrote:
> > > On Fri, May 22, 2026 at 4:55 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > >
> > > > On Thu, May 21, 2026 at 10:24 PM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > > > > On Thu, May 21, 2026 at 9:00 PM Maciej Fijalkowski
> > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > >
> > > > > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > > > > On Thu, May 21, 2026 at 8:24 PM Maciej Fijalkowski
> > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > >
> > > > > > > > > > The series is the product of previous review from sashiko[1].
> > > > > > > > > >
> > > > > > > > > > 1) META
> > > > > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > > > > >
> > > > > > > > > > 2) PUBLISH of CQ
> > > > > > > > > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > > > > > > > > >          overflow occurs.
> > > > > > > > > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > > > > > > > > >          publish its address when overflow occurs.
> > > > > > > > > > patch 4: like patch 3, but only handles the invalid descs cases.
> > > > > > > > > >
> > > > > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > V4
> > > > > > > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
> > > > > > > > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > > > > >
> > > > > > > > > > V3
> > > > > > > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
> > > > > > > > > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > > > > > > > > overflow case (Stan, sashiko)
> > > > > > > > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > > > > > > > 3. adjust the selftest to make sure it passes in either virutal or
> > > > > > > > > > physical machines, which includes add usleep to support physical machine.
> > > > > > > > > >
> > > > > > > > > > V2
> > > > > > > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> > > > > > > > > > 1. adjust selftests (Jakub)
> > > > > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > > > > >
> > > > > > > > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> > > > > > > >
> > > > > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > > > > >
> > > > > > > > I noticed there are some flaky tests which have nothing to do with the
> > > > > > > > series. Can you confirm that it's not caused because of the series?
> > > > > > >
> > > > > > > That explains the different results as i am using i40e/ice which have
> > > > > > > multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> > > > > > > Broken tests are from mbuf cases.
> > > > > >
> > > > > > That's weird. I never expected the failed tests to be about multi-buffer.
> > > > > >
> > > > > > Are they the same as the output you attached last time? Or something
> > > > > > new? Could you please share it so that I can investigate the root
> > > > > > cause?

[...]

> > > >
> > > > Sorry, Maciej. I managed to get one server with i40e nic but still
> > > > couldn't reproduce it. Can you try the attachment (that is the
> > > > replacement for v4-0005) instead? I removed those nasty CONT test
> > > > cases...
> > >
> > > Ah, I think I eventually figured out a solution. Maciej, could you
> > > please test the 2nd patch instead?
> > >
> > > This patch reworks the CONTD test cases. Cross finger.
> >
> > Please don't rush things here, I believe we need to think a bit more here.
> > I have second thoughts about overall approach.
> >
> > My understanding wrt CQ was that it is a container that holds descriptors
> > which have been successfully transmitted. Now we want to add also leftover
> > descriptors from broken packets, which might confuse user space sides in
> > case they were relying on behavior described above.
> >
> > The intent is right of course as we don't want to lose UMEM descs, but I
> > feel like we need a separate mechanism for that rather than putting
> > invalid descs to CQ.
> 
> I don't sense anything strange here if we stick to put those
> invalid/overflowed descriptors into cq. AF_XDP is only a tunnel that
> transfers the data. That's it. A bit like how the physical link works,
> which means it possibly drops data because of congestion.
> 
> Upper protocol is used to guarantee when to (re)transmit a packet -
> the mechanism is the ACK driven in terms of TCP. TCP is absolutely
> capable of finding such an abnormal thing happening by checking the
> seq of incoming ack. My takeaway from this is we don't need to
> deliberately design new stuff to fulfill direct and immediate
> communication.

AF_XDP is often used for L2/L3 forwarding, UDP, custom transports, so I
was afraid some existing solutions might be relying on CQ entries implying
successful Tx.

Generally this issue is highly unlikely yet a thing we need to address so
let's follow your approach, but for that we need to update documentation
and align ZC side so that we would not have to deviate test cases.

> 
> CQ works somehow as a notification that tells user space whether the
> kernel receives the data from the app and handles them. Without
> putting them in the CQ, the only thing for userspace to do is simply
> wait.

I don't follow the last part of the sentence but let's disregard it.
Userspace gets errno/retcode in generic xmit so it is aware of underlying
issues and then it's app job to act upon it.

> 
> With that said, IMHO, I cannot figure out why we need a separate queue
> or something like that. Of course, a new notification that handles all
> the possible/potential exceptions and contributes to the performance
> of the upper layer is worth a try :) The latter is crucial.

We discussed with Magnus it would be good to have a dedicated xsk_queue
stat for that case, such as 'oversized_descs' which would be bumped by the
amount of descs produced to CQ.

> 
> >
> > Does it make sense?
> >
> > Besides, even though we would stay with proposed changes, behavior between
> > modes should be aligned. Right now ZC seems to be broken in touched
> > regions here - when we hit the limit of frags via pool->xdp_zc_max_segs,
> > we break the loop and discard the packet, never post it to CQ and these
> > descs are lost from user space POV. Then we would continue on next call
> > and interpret the rest of too big packet as a separate one (clamped) and
> > therefore submit corrupted packet to HW.
> 
> Right, this is how the previous selftests changes pollute the
> subsequent tests after that. I think the new version of the attachment
> should pass all the tests since I put all the CONTD tests separately
> into another two functions? It's pointless to test those in the zc
> mode.

We need analogous fix on ZC, then no such quirks in tests should exist.
Test is doing the same thing regardless of underlying mode. Only the range
differ (MAX_SKB_FRAGS vs pool->xdp_zc_max_segs).

To wrap up, I see it like this, moving forward:
1. fix docs
2. add ss stat
3. wait for me with ZC fixes (I'm slow!)
4. inspect if tests will fly

Let me know your thoughts! Maybe Stan wants to chime in?
Maciej

> 
> As to the series, if no objections or any suggestions jump into the
> thread, I'll post the series within a week.
> 
> Thanks,
> Jason
> 
> >
> > I'll be looking at ZC API but i do think we need a common approach,
> > mode-agnostic.
> >
> > Thanks,
> > Maciej
> >
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > Really I don't think I have much time to spend on these tests which
> > > > makes me feel extremely annoyed... It's not easy to analyze the code
> > > > without a reproducer. The good news is that now I highly suspect that
> > > > this kind of CONT test cases pollute the whole cq which affects other
> > > > tests. Before I give up on the 0003/0004 patches, I'd like to hear
> > > > some advice from you. Thank you.
> > > >
> > > > My original intention was to push batch xmit forward but at that time
> > > > sashiko pointed out some unrelated bugs accidentally.
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Jason
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Jason
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Jason Xing (5):
> > > > > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> > > > > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > > > > > > > > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > > > > > > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > > > > > > >     __xsk_generic_xmit()
> > > > > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > > > > >
> > > > > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > > > > >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> > > > > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> > > > > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.43.7
> > > > > > > > > >
> >
> >

