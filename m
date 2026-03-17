Return-Path: <netdev+bounces-268625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ1hDQ5iuWlsCwIAu9opvQ
	(envelope-from <netdev+bounces-268625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:15:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917AA2AB9CC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A064317F7FB
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E043E316B;
	Tue, 17 Mar 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MK3iyHhW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499D3E3C5E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756476; cv=fail; b=iaHZ1BYdMmLnzqmXcevkU7W8mlPv4M35Q9v2uvTEU0jz2XS2AZJBXBDMTJ7HfWc7O3nJXr2WtAtYFqTeBZM+DOIYoqvshiiklm+HwkIbItKIu1MiqpDraAFQqm6UBOKt/WFhfiTus4T1K1ldOBCAvgQ7PXU/BdDohLBoIu3Fycs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756476; c=relaxed/simple;
	bh=e/fSjokiqVlu/Jtfgqtnrwec3LyBN/faUAneT04I0d0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UenGr1z7/4KnYuHLtdKTJ8lG7xJl/rqF6kUyRl5wY/Gnj+d4LaGGvBJQQ/aVcN/NvXmOleEsLJxgSJiSqs6dwArrcvRokBy9aJMRCJEWLspnC4LwMbDXWHkA51yQGzVdPhBZ+Qlfr4wRRCrePwxpt2cfio0u8UbZuHBsSF0uxKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MK3iyHhW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773756475; x=1805292475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/fSjokiqVlu/Jtfgqtnrwec3LyBN/faUAneT04I0d0=;
  b=MK3iyHhWY1CGd06ONToJ18d4w2W/5piIXYES8MTAJS3jwmYW88wVXbNC
   pYIz/HMe+yxqdmjsU6bHKluyodNSjECMqRpGyuTCjWuWUcsS9dIlO0fup
   nsVKonB2Z5927bx3qCQurY52G0jfFdmdzrxu+4Rd/Q3A8seY15BpNq20O
   7lY1/x6EWii5jy0DuNpG51thiZf4aEjaFrQxDLdwIyJWzmyqG7dqrOdnK
   Nwb7IRkUCQO1i2xK4z+tWXzHL2YChqi0NYo3o+zRTG/sPwx+UMqHXlyIs
   tZi08aAORvbifO51rTpciOB4RSXz+wakXL42BgM5wJgVWRXEyBWNBftmA
   A==;
X-CSE-ConnectionGUID: CN/Vqz1FSJ6rGvpoXAK2+w==
X-CSE-MsgGUID: jilHCLDoQF+qKsueU38o1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85415277"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85415277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:07:54 -0700
X-CSE-ConnectionGUID: enm2aj+rTFGD/ivZW4oQeg==
X-CSE-MsgGUID: p0dRvZl6TXW6mMKVAVMgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="219381840"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 07:07:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 07:07:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 07:07:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 07:07:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZVD7HtjfBOUV/yMcaaUtN/9AxaHvKRYyW3yf74oYx3PDYUNkPP2DNOmVaOMmPvoEVP70oI1px6U6cBtNCvHBbmmB8kpnsjNhB0FMzM3CFBKQ1R9VdgpCv8XYs5GT5U89E7P06U4hqbwPKRSfxNYQEjt4HKMHZWRwNnfadrRfVHqKDQG/xjooXAGD/lTlYV44bDYOwAKG4Ra44TEg000XBv3ovbSqnXArcN7HTFHTRXKT7yYW3JPhXOjhiMOESarnE9J8C+t9/sjykK/HcZZhVGYPZNae0bmg6iRAdzMLcWcgUm5tp7lJyl7a6fO6JLRcADZzC6g66HKrovdoyc/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oQdP8FKlR149KfGKHkDTtnybLwz4c9RVeA6Mp3kC2c=;
 b=FL3RUW7/rlvTt9mDgviQTSiNwHOPVI7yzvve3HPgEyznrL+jyS6gMCXvPGbBD5ss6RnM341ghp40+Xhq8r7fxU4/rpTMDohbwC9D5DvIDVvj4xf+G8Ze5694fE5Ctbq6Z2dvRiiX/jHPZPFhFJ8iCu38/eaFayfsY8JtmpHyD/qxa7jdKVohNEo6UoVDh7OEyci27Iqlm7tR9IIRTDgkQB4lsvqudngKtOCaUDtWaXwZv6z0c0zUi3+uvLDMvTJ1hjYyTofwfrt4i0XOHwJfUTMYiSNDCBOCC9npAqKQ4AgZ4aAY0H1FFw8JWgipR11QGb06daJVJ4EFYCDerWeg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 14:07:51 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 14:07:50 +0000
Message-ID: <91d29df8-ebc1-4d9d-9d1f-022aafdc3e72@intel.com>
Date: Tue, 17 Mar 2026 15:11:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: add ethtool reset
 support to safe mode ops
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>
References: <20260317084459.2196606-1-aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260317084459.2196606-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe5b10b-bc8a-44c7-a8e4-08de842e9313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q1ZSlSF3h94bUf16xf3nBPz4aOfZLHgHEe8cjWxIGzIMIPIBDI6ubVIoHhwzE2mTe8CQd3JGvPksNju0t/2wtyqUSrdP/DW82cmab0WRlZSrnTfIxOTDUuzc7iuTz5qmHofNvxV1j3GBAj6rSdhnjz5jL8dG2dmsawIqlFeogE11VBm03MCQ/9+JhTeTEfFAzLQevXXkWg9SIwl41kv9mZepdCWHLj03D65v+b+sNKlRKof+vnk+kJsVpsIb+VpM0B5XkodYGpbxThOOn08UKT8bd10ZpcvCrePrOvf+VfHy2dE2DnIydz6NLrodH2objcaqet/Z4FoAE8BD8L4yX40vqIjmMXbsgq1sFgYUnCQ0fBHo1F0/cN5O92uMOxcmIo6rPaRY0SFjmHVE7k0IGNpfJr07MT0+adD+MDhMd7/36gMLy2AcIiu3vc6z5qn5vsOgAR4Tou6H4aWhyWWiG15R3OXFispSqbmy/O4tryXK3mrQPzIZ1DYrit60GX8b0XW2Q3kthQnbqlatSDg9qNPnF363frm7kysZ+D9JpOh2dlq3fzHdcnrdpjZeKyjEZh9W1elgA+CUzMYpekEF2gew4yBdL6LqCDU2KaZsSLPZx0QrYD/6q7mRnGv06IgCdCM8G+VEaU9YNhnkALi4UK0ebFyxeBz9McgiXUxSkliqp1TegRr8fCTXGO+QNBffxSrs8bzxQThh5SY4Xt1n1sU24uABjlVTcQbcrWKPaao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1BR1UrU1lZc1RFUURKNUE3V0Zad3FzNjV6U2NxcHRVNjFocFpPekl6alcw?=
 =?utf-8?B?NlRudGxoa04xYXczNTZVdGRQczRuRUNGSytKS2RtVEh4NlhaRWt6QTVkOTFu?=
 =?utf-8?B?T3BKTzNxYjgzREJ1RGR2Z2cyTFZ5OER2eDMwT3RBdGQvSmxyOFEyZS9ab3Vr?=
 =?utf-8?B?L0oyRDljMW1CaEpUTmVBeUNIRmNLZngwNUJ2aE9XSUJiM2FFamljbXAxQStQ?=
 =?utf-8?B?RVJDdE5obmFGekRjMFBnZ0tKRElydENrKzlsUjczU2ExaUlpL0VmV0JkNS9Y?=
 =?utf-8?B?V3IvMURISlZJcDBRUmhTeG5lbGpWemJnNkY4cDNRU0twYzN4WmFNZzA2U1ds?=
 =?utf-8?B?SHoyQThiQlI2R0V4a20vd3pOblE1aHBkNjcxWi8xeWJ0dmZZZDBJU0VIMTNP?=
 =?utf-8?B?YVJ4cjluRlpaMzdENWxkbE85Y1JONzVTU213bWVkSUdickFpcllvMWNJL0lN?=
 =?utf-8?B?elg0QlcydUFjcXRTa0JLQ3BkZFFHdnhqaTlJQjZHUXRGdFBxSnRDUWFQOHI5?=
 =?utf-8?B?NVNzL3Evbld3cTExc3p4NWFqWHJNVFRYYW9mWXlnc0cvSFdEbHN1SmhxcU9J?=
 =?utf-8?B?cko2WWhZRVM0eWFMWnFYK3o1TEdLMTkwUW15MFpOUDA4aGs4azcvdENJa2Ev?=
 =?utf-8?B?a0RuTEl2cmxsQ3BCL1lDdDZIcE10cFl5eDRVdlVOYU5EWkFrU2plYWRKMWI4?=
 =?utf-8?B?d25rT0I3SWtUakd2eHJ0cDBESzNPSzllTm91aUc3Q01xR1EwZzRmSmp3RTNN?=
 =?utf-8?B?Wk5FVkgzMlBBUlBNYlhrb214UjdqRW03YVY4am1TM09IY2FvS1hmZU5wZ3V4?=
 =?utf-8?B?cENFQTBUMmVaaisvalNNalJadWpJWE1CVUpKYWdNa1Q5SmRkOFJlMFFySks5?=
 =?utf-8?B?MU5BOUFJL3NpeUUrVTloc2c1Vkc3cS9tS3lnQnpoME83NDQwc3NTRGM1TVph?=
 =?utf-8?B?RDRaVXA4Ui91bk9qS1JCWFNnZXM5UWZzNWRGK1NmclJUQ3NONm5BL3RNK3pl?=
 =?utf-8?B?Ymh2RDZiT0sxSWcra2hxcDZrQm05YkRKK05mdDYxbDFlRXJqS2oxcTJUR296?=
 =?utf-8?B?S2h1UTVBNFBPb0FaVmZzMXdYK1lXRElyRDZtVnoyRnpvVDVrQlhKeHEzYUw3?=
 =?utf-8?B?SVNwWWNIdmNUSWtwOXhBMGdqY2JVUTE2NnByM1g0dE5mMHB2dE43VGxPRkVo?=
 =?utf-8?B?Ri9TK0tGbW5vNm5Zb3dWajdHc1JQV2JSeWgxNC92dFUzelRoRCtHUW9BU2cz?=
 =?utf-8?B?QlRZQmc2b0hnV0JTOUZRTEN1U3JjNmtmS0lxcGhlNTdGRzNNWXlnazJKOGQ4?=
 =?utf-8?B?OTVtQW45WXNDY1U4bW5aR2N2OE1kZEVFZ1NTZ3QrMENVTVNUd2dKRFFoVkpQ?=
 =?utf-8?B?T0c0QVBTaFhOdmVLbXdXUDUrNmdKVnhUMmU5RVFpSm40WTVVNFVLT3lmRTU0?=
 =?utf-8?B?WWlpaVBra054RWxFd2U0aFRIVldaaUFNYlVjRUNFaDkyTFNjOFUwcEt1N1JV?=
 =?utf-8?B?Sm9lUEhHRUJwWGFyNXlmYXlQZlpuM0NnM2c0bHU5aUtCVkgwZXFnRXZrVWxl?=
 =?utf-8?B?Y1VRNUM1cStxUENjTGowbVlZQVRZbHZqUjNOUk9HNGRVVFpYOXZ6MGI4SHNY?=
 =?utf-8?B?RlRxay83a3lPdjVENFV0QWExUjVjc3JsZHoxWG5rQjJMK0RUQTUxMFRzVGJr?=
 =?utf-8?B?eXZzNnViNWo0WVp2VEltenR5S3hMTWpOdzRSMWtjR1JHUGZ3WExkU3B5a1Zi?=
 =?utf-8?B?bEpsZlNZdVFCbldoUXFhVTM1aEJyK1RDMUlKaVBWcjEvZVkxdGhlRXR0WWhy?=
 =?utf-8?B?em9BMHhTN2szam5MSGNuakdxRlo0cC91Zmx3a3FGczFqeVVhcXZkK3lCSmtC?=
 =?utf-8?B?OThJZEJzQkpxM0tBTXc3ekVsQTBzYmVGTGFhMDlIYjFVWXo0cWFOUks2MXFS?=
 =?utf-8?B?TWpYSzk4WmkwWXpRM2lqL3lqbE52Vk11T1IzeFNGd29yV29FRmU4YzJRaURL?=
 =?utf-8?B?WCtRSi8zSFNkNEdIMWlrYjdmcHc5L0NSQmYxTTdmRThzRDFZRjZ5OCt3bHlV?=
 =?utf-8?B?Qk5sSWx1OS9nTEkrVG9UQktPWFZkY3NzQ2pGRjNJKy9PRk1lTnR0MGY5QW11?=
 =?utf-8?B?OFNueXN1UzZqbzJHc2hlVDBpWEJ6MjllK2szVXlaQStLbW5RQTQ3c3c1R1B3?=
 =?utf-8?B?dU1GaTJsZDA0WElmZ21LcHkwQ3Q5V3Nnb2lYdXUrYVF0ZE1QaXVKRVpnSHhN?=
 =?utf-8?B?bXZ3bi9nTkFSczFkT1g5OUhjRnp6QWlWWE0zZ3Rtdk9naVR1SkkzOUVtQU81?=
 =?utf-8?B?WlJlRHJ1QU40Z1BpV21KSzVCcnJuT2xiVy9ZeG1BMksxTWcvQ2xId3pTVllI?=
 =?utf-8?Q?PpO4BKUd7ZFoF0nc=3D?=
X-Exchange-RoutingPolicyChecked: TFZmp+2YuZ5zpC5tnjZ7EFF4//Ylp7BEVrX0k3qRT3DIPn9H9SbHUAJLG2MhfDfQ14df3GjXkSiQSnptFXQQRd6GWoqZcSFkKeUN304FuSsPywSlHJGHDSpkzyCCcAE5p7m9LV6bJ/Dx2KtTL0A+Ml9Rss7tVC+gK937bNfw2RG/CH/7ta0MA44A3+i5qFqXF4dzyNNTso29dzgoaH5kCSkujJ1sdfnLZRuSphHuCnG3iTYPrZQ/hIzkuQ+8nV59hkzLKUM7kyXZji7zJkig6fKSfGB1fjNPYL4sIvQbp/P7S8+tm6wTNdJwxAfZzNfRO6NmZKVgfxcJ1F05w1hiqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe5b10b-bc8a-44c7-a8e4-08de842e9313
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 14:07:50.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxRwUOYdZ00TCKSJrJpAa5AfbSTLpA8RmiYanrcLz+Nsu8dZ4XAve62R8H040ghr1iMe4YwlKWw2WO4f+gFJ2mGlKzxiSeIhT2QJ2K+SEZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268625-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 917AA2AB9CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 09:44, Aleksandr Loktionov wrote:
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Wire up ice_ethtool_reset() into ice_ethtool_safe_mode_ops so that the
> .reset ethtool operation is available when the driver is operating in safe
> mode, consistent with the behaviour exposed by the full ice_ethtool_ops.
> 
> Without this, a user-space call to ethtool --reset while the driver is in
> safe mode would return EOPNOTSUPP even though the underlying reset logic
> is fully implemented and works correctly.
> 
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 301947d..bf90bd5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -4917,6 +4917,7 @@ static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
>   	.set_ringparam		= ice_set_ringparam,
>   	.nway_reset		= ice_nway_reset,
>   	.get_channels		= ice_get_channels,
> +	.reset			= ice_ethtool_reset,
>   };
>   
>   /**

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

