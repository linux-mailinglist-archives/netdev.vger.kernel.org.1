Return-Path: <netdev+bounces-256041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIsoEqxEgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32BD31B4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 362733004F00
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3B1E5B9E;
	Tue,  3 Feb 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="N6ZG3OPU"
X-Original-To: netdev@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022128.outbound.protection.outlook.com [52.101.96.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2841B4F1F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079400; cv=fail; b=tWLLGGvRlsAb+eDy85CDPxZ0krP6dTm9Zgcw5/5IYHESX4062DO6nXmqnfXeuu2NHehiwIhqXVuiW3iiO6AvYXASt27t7V1RVuSpqNcS2hGf2lIBGtbM0RK+aMN/x2qgMfamlHKkMej4Jq5Y9ZS3jmskGxWxPFWV7Y+0yQMEfoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079400; c=relaxed/simple;
	bh=nQJDUQ77qGhBxqz6NQ7ZJckzbPXDkr5fsIR14S7yIfs=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=lwJlPYHPXewZdbjlnd1db+G+haV8ZV3nqyM/XwsySr5T2yQuB2xxUrXdOxR/362kCWblQongkdIQUgJssHrYSDkPSYkTIuLnmYYj18EuuxljlxPmhRaNlkMMB22MOiuDM7gQeJ+HQi6PBVNuTB9fZmW8pUGEUekOfYVEqa5ayZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=N6ZG3OPU; arc=fail smtp.client-ip=52.101.96.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rreUh1l/s/XAGnPolOQS+mUnq/6u5vksx5itg0x7f1dppYjtx6tW+ICs5xodL1Kh19r9fPWamFt8/VvW0q3M1h4k6dGeLRpYgyAG/A5zw+cHzSTQ5/SaKkTT1EjkVzD91WMTp+fom+DHmfd6j3iQDkitB2dZ9+4nTNNpqXhURcXCr1LRLy+cQF5gGLYZnD+SeEeV0av6laD2DObKiABtGgkEiedgPQWs73ay2/kg3lPnczerFUm/0cuKqG46wKB77iSrf4YFpYVHPxTHkVfsvp9qDuyU/p7IlrOAhtjfeLWyv6kA3CmdXyOaZIztiWM51j7d3r1kwgWCkeZn+nPxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQJDUQ77qGhBxqz6NQ7ZJckzbPXDkr5fsIR14S7yIfs=;
 b=PHg/fF/Tk5Oy0J+WoGgMbRc4vZobUfoPk3f4ekej9vXbdELN/HdQfoulMem08MydbWf1bIkwDF49IIG/ALHWDeLauvTcl0zXg0oS2gXXdokSFD55C8a2BI3iJOOoMEGHDig0jXk2eCHXb58UDfYBRkYl4Ei8KRgsikNFtJ+GRpAJJUczhqotqXu2mJ88nNFLnzXo5Z7fEz4CrA0T8wxi4DH0zlS1qNLVJ5meHWCFC+Ub86tbEOdRjQqG7t+NBws3GxlbAdRZ7g75t1JpXY/IKSICJ7yW24MKD2+aVWAChrEKMIruYLwb6ZCkZnBrUOTjHeOeGW3d/uWdHVDLiOugjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJDUQ77qGhBxqz6NQ7ZJckzbPXDkr5fsIR14S7yIfs=;
 b=N6ZG3OPUw2EzZfFPsCFi44JRxs1Qnb0piTTF8U/zidLGU5gf94rtv4j43QNM9W1RfFfS6Z03tVlv6y1duF9Wx2L4NuO02d4dJmQ5fzRmfxO4hJMu/bpQNgRVM2uW9NySeMYhyNu2m88GUbCHkXsLm9xoLlxFol96Fz7P5gEne50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2993.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:43:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 00:43:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 00:43:14 +0000
Message-Id: <DG4WS03VX6EY.2J61SWXW7AIAR@garyguo.net>
To: "Eric Dumazet" <edumazet@google.com>, "Hirokazu MORIKAWA"
 <morikw2@gmail.com>
Cc: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in
 __ip6_tnl_rcv()
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <CAA2RiuSnH_2xc+-W6EnFEG00XjS-dszMq61JEvRjcGS31CBw=g@mail.gmail.com> <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
In-Reply-To: <CANn89iJxmiqryxLAXiV9z4uTaCzR7XZns32MGSLOykC2zocW_Q@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2993:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5f47c3-10ec-4f1d-afb8-08de62bd376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXR0bEcwdk5iVGRuWC8zYVpVOVpnN1BDVXVMVkdMbytydk9vNkxKdGlMQVNH?=
 =?utf-8?B?c1R1NktuY3VzRmpFcEZVNVZDdGFjaGZsNTZwVHdQVWIrOE94Q2ROZFB6eXQ5?=
 =?utf-8?B?dkpvNU1DZnhKQ2g5azVnYUdKZUNMVkNITDFJV3QrQnBrUG55KzZuUU1hZFVU?=
 =?utf-8?B?bzFjOGt2VVZSZkFYK21ta2NHSGJ0SXBMcEV1MjlqNkwxTlFCeGlOMGROOWZC?=
 =?utf-8?B?NC9wSytsY0tUWVZrZE1aN05YOWV4bEZqWXpUak5hL1NWbE1KdUZvQnlqZEtS?=
 =?utf-8?B?alhBMHpUT0gyRHpTOUtYRTY1SDdoQVdSV0ZuMENBdHdocjVFWkEzV1JXZnlm?=
 =?utf-8?B?RGR2QnBSU1FReXZ6QkQ5eXlUUm5taWsxNVluVnc2SG9hdThNM0ZFZGJMSEx1?=
 =?utf-8?B?K2RleXh4N1I3WGdyOHgvWHpodW8wMTdRRWpIZDFwWmRtcm5ydDdNbWY3aVhW?=
 =?utf-8?B?T0tQeFpYVHJrbTBQblNzRDFtZmlHNCtYS2N4aGNBbUluU2lXZXQ0blMzRzV3?=
 =?utf-8?B?ckQ1bHEwWHZQRENqenh3RnRkc3FJRHBxRXNoRFFRbXFoRGIyUHd0R0k1clFq?=
 =?utf-8?B?UFlOOVRWV1FMME5PMWltN3VxY1JEeTBLcTdsclpxTkliZXJoVUxiUkduZzdB?=
 =?utf-8?B?QjhwWDhIVXVwS0xHYlgwRzJHSW9Gc0R2T2dURUsyUjk3RU90a0NhNUZ2YjRM?=
 =?utf-8?B?eEE2bTRNZjhaSEJFTGFObEYzaEZ5akdBbmZYQkpjY1hCOGZXK28xc0hzT09i?=
 =?utf-8?B?RVVQT1pTdHZUNnFKZmxLSzBKZTZ0SEVkbUVpdyt1TTBnelJuZjY4Rm1ScjhL?=
 =?utf-8?B?ZFBvTklQb09VREFTRXlHQTV4NVluK3UrZ25WSTF2Vm5meUlsS2Z6dHE5QjNE?=
 =?utf-8?B?bzhncXdOVFJYTGRGSDVLM2EvTjNXUHZabXBxdkNweE5GZG1rcFkreUlvU2pu?=
 =?utf-8?B?UllCb0tSMHN2OW53SHBJOHRJNUZaZFVRZ2tvSXJyYzl1SFlqQnpvcDgwNjJ3?=
 =?utf-8?B?dnNGbStsbW9MT3MvSGtYS0dNb244QU1LcGZ5ZkVZcFZuZlZPaWkvd2lWOS9u?=
 =?utf-8?B?NVg0MW93VWJkV1pGT3hUaXNzdjBUeXVwR1IxOWRDLzNrZmpreURvWDBQV0R3?=
 =?utf-8?B?eTRxcGhHU2UzbHZDdUtudDViNzFNQzdKS0tpc1lCTW9BVkdpeXFQSXBBbXh0?=
 =?utf-8?B?Y0FhaEwxQ2dmWW1kaDJ3TVp0T0lmL2I0YldobE9rYmpZVDBPY0taRDVnNWV6?=
 =?utf-8?B?b3k0T1JuanNqbHVYZk5TcGFVazJxSndVT3hhbmQ5OU1hbEk5NGdPUWx3MGow?=
 =?utf-8?B?U2RLc1lOUGFGWDRydWNnWGRWWjYrRCs1aE45STdFZjlPUDU2OHRaMEVTT25v?=
 =?utf-8?B?djVZVitOS3lkMVR0ZVp6T080dzRDbjdZUjlUTzByUXhHaTFmbTBERFhvcnhC?=
 =?utf-8?B?YS9VcHF2WkdwSlgyU1FFa28xbGcxSEIyOUtSUjFmRzZTMGJ1TXlPam1kSXo3?=
 =?utf-8?B?bjNBRVFxWUpJSVRRcWRNR2dHRnF5aTBUWUZxN1lKbWh4VTU0T3VkYm5yMjd5?=
 =?utf-8?B?bjRqZVdWM09XZE53QkpvWkg3RlpwSm1KWmpjazBxSVpUN1o3eG1LZTQzNW5B?=
 =?utf-8?B?a3BTamNzc1JRazlyODE3bVhkR1dlN2N4T3ZRVnVvWlVrY0pwZ2U3QzBlTkE4?=
 =?utf-8?B?Q1RKZWJVU0lZWVhDYlpOdGtEbnVrSGdmaG9QL2ZZWGozTGNIdHVQVzUyd1Br?=
 =?utf-8?B?UWtZM0ZJK3pKakQ5Rk9UdFIyUXVDNHRvR2NOUnlyWUFEQ3dwR2Q1Y0FuSGFL?=
 =?utf-8?B?QjBuZlBlWDlyekpjUmIxOVhUN3BFTU84Z2hmcmdUdURMb2dTT0ZCdlpmUHRD?=
 =?utf-8?B?eFc3Snh3T2FNRjRMM3I0cGE5amxtNGhqSmZPTUdDTWlZSS9TRlRVeHlZYyto?=
 =?utf-8?B?S21CNHhpYUIwYmFzTnZZMmRGdjhwT01QdElCTi9kQ0RROTcwUVR1MlN4NWs1?=
 =?utf-8?B?SDgxVFJLTUJjbHU0a3dWd3ZKNDFqbDNSaVpIbUNic0pUMFUxRTFzTy91UE4w?=
 =?utf-8?B?bzNRcWhZOWlBV0JvUUhZOHF4by9RUU9KVEt1d3FhVEEyRjd4eHFCQXlHU0l3?=
 =?utf-8?Q?z7b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hSRzBJVmhrcVJkd3ptb3FUd0pQV3hOc0VrSlhpbVRER0Z1Um1CbE92YWVQ?=
 =?utf-8?B?QTJxNUZDV0JFYnpzVHk5VFhLcGxQSDBwVlpnbWFoNGpDSFVGRS93MUY2NzI1?=
 =?utf-8?B?V1NFRi9pUUZhUk13Y01PcmxrRERZMDBjNnJ4RVpVVmtPaE9ySmZTdE5BajFN?=
 =?utf-8?B?THNOc1FZMWpiZkxYQUVGbm5HYURIUmVWdmQ4dlQyZkJZMElyRWNTTGlib1RY?=
 =?utf-8?B?Z2lzY3BPUHNydjBZbXdZMi93b3c3a0RyMzU5Q2R3Zm5MbGFGdTMycjU1T3ZJ?=
 =?utf-8?B?Tmdld1Q1b1BudHFjVElMZFdRUGk3U3p3UTI0UTNWaVQ1eU94UGJNRTQzUGM0?=
 =?utf-8?B?L3FtRFhOMVJ3QnJQeEg0STU0NWd5eXNKdTRhZFNoLy9qeitSTWU2cWh4RnYr?=
 =?utf-8?B?bmRCUGFsRG9UelhESXBpVS9kSExoSlVsL2VpbnpBMUJSS09WS09zMmxTSlFq?=
 =?utf-8?B?dWRXcE1MNHZnREhoT09YM0hSZENuUVNZRkJwT0FOSzNGaERGT0ZFRTB0TEhV?=
 =?utf-8?B?cmZFSXFOS3VVUld3RWlUbkNxbDNYTFNSb09Wa0xTS3FHeWdDZ0J5YWIrYVpG?=
 =?utf-8?B?TVpLSUgvM0V2QkErZkhIb2pZQ1BYQUF0a2JmSWhjcWJaRGFEQ1B3TDN2cTN1?=
 =?utf-8?B?dy96WUlUR255NGZmZWpndEc2aURmYTQ1TFJ2UjVrbDIramI2anlGQ250a0tJ?=
 =?utf-8?B?eUNJTEhidUk2dW5zZVNvOVV4Tll6NGNtTG9PUFNuck9pUk5rZjNIRXBoYTNq?=
 =?utf-8?B?VDdUa3NCRGhPVW1BNzgzYlY2TlB6WitOVFhMRG9FNWs2TDZMUG5pajBDaDRi?=
 =?utf-8?B?bTd3djZTcjVpbExSRUsvcTZWYWIzNm9zdWN2Q052MWQ0Rmp2NmxxbS9Fak9U?=
 =?utf-8?B?S1g5M3ZOOFFySjFWbGhVbHRCVzIvVU55bVNIZ1N3SENIa0lpQUNHMjhWT0J0?=
 =?utf-8?B?RVZiTHVoQStKY3VtVk9JQXlKSGFBdzAwVmtuMUdlSFV3RWJZTm5DN3dUclp4?=
 =?utf-8?B?QTB1aDByZXFXaFZGeFgwQXlVY2dkeEdtV2szR0lscFJoNnE0bDhSa0M1cmx0?=
 =?utf-8?B?TkhaU2VhVVlkUXV0S0E5VHRVeVRHL1lYYk1FdG9OQmxJWXYzeTdCQ3JBbVkr?=
 =?utf-8?B?UkltS29YOVA4NnpJRDh6bTAxQ2Z0SUtEUDdtMm9hV0ZoWHdzOXFTMUl3Rzla?=
 =?utf-8?B?ckxNWjRlWm1rKzFNdHplMkhrWEs3YllWVmwrUm41a1k5cnNGTWxIcWhSOXJw?=
 =?utf-8?B?REpVcGNuWTd6Z3dZczFrdCtRTzlyMFNHRWFDSWdNOG1OUG1mREp0Nk5hNTZM?=
 =?utf-8?B?WmJ3aUZ1dFBIRDN4RzJ2SkhmTmN4OVJZaG9STlVRQnVoOGsvUUpYbU9FakN6?=
 =?utf-8?B?L2I1bUxMM3RkNGk3ZW44UDUrQTV2bWVJTVBEWFpwdmIrTGo4dlBXVEZmbDh3?=
 =?utf-8?B?aU9xOStVSVNPb0ExRTEvZHZYNEZJekpoRFliTE5nWFdzQ3VZa3NJUWwxcHgz?=
 =?utf-8?B?RmVqd0U1UjVqTWE5cUdEQVlHYVJkUW4yRXJkQkRjdlRBZHBDeVJuZGpvUWs0?=
 =?utf-8?B?YjZQM1F0Z0kzQVZ5K096NG4waFhacStmRkVKMWFIeUxEQjZ2c1lPaUpsdXZK?=
 =?utf-8?B?S1JHR3NLUnRtL1BPL3c2N3AweE9oUUMzNGI3RW5ueG1CYVpKOEZCak5qd3BE?=
 =?utf-8?B?c1dDVG5LK3pQVXk2dUczWms2aGxxdjFpVXNOdHpycS9BYkpoVzhEWVl5SGMz?=
 =?utf-8?B?U1R4ei9QMXhCVzJIOS83QXdLR0svanNvcHZidjhKOWJiYjllZWZNQWw2UmNO?=
 =?utf-8?B?dXBsMkNKYThRb3cyM09xNVo3UFY5R2hsRjhKOWpnSDVkaUdhd1RFci9WcmhV?=
 =?utf-8?B?TGcwcXhzMUg2ZXA1cE1SS2Y3dko5OWVlZ3AxeEZWV1NsWklIVjlCNkhMVFRl?=
 =?utf-8?B?STMvZ05KaFN6YmQrYzR6NEtqZksrYkpBOS9IbkxoeUNWR0VadSsxUDh4YlY2?=
 =?utf-8?B?ejkvMkdQR2E0NTRvdnhtNlpLNXNpK3JNdTBoSzdibGQ3SU1uVUlWRFA0NitP?=
 =?utf-8?B?dTN1VWJPRy80bk10Z2NraXIyNDZRcURYY1BFemlxeFczQmhEbkVBSXhKMG1H?=
 =?utf-8?B?Nysyb1RCSGovUFVhb3htVUxHMFR1ek41WXJBT1RybXFxb0tVaFhWeWtwa29m?=
 =?utf-8?B?WWxaazNFVW45TkNicnhiZ2FTY3A5c0JVd0F0YmVDK3dqQm1tUzFUQ3Q4MjlE?=
 =?utf-8?B?R2lkV0ZKQ3ZZTk1GSmoxOEI2YlZrY3QvZit0bmZCVEY1MDhnQ3lVcElMVW1j?=
 =?utf-8?B?UkdMaFJRbkRBNkp3cHNlbDd0Z1kvNDZxeG5QNU8zVFpuSnJqS0JOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f47c3-10ec-4f1d-afb8-08de62bd376f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:43:15.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODf1NOUARo94vX0BfB+YyTZoVQWC2BgZhouYewkU+KJOPndJJeSZTdwTnJDW6d7A7xcJ8zFIe+07cQGGpuVSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-256041-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF32BD31B4
X-Rspamd-Action: no action

On Fri Jan 30, 2026 at 12:00 PM GMT, Eric Dumazet wrote:
> On Fri, Jan 30, 2026 at 5:15=E2=80=AFAM Hirokazu MORIKAWA <morikw2@gmail.=
com> wrote:
>>
>> [REGRESSION] ip6_tunnel: IPv4 traffic broken in MAP-E/DS-Lite since
>> commit df5ffde96693
>>
>> Hi,
>> I am reporting a regression in the IPv6 tunneling stack (MAP-E and
>> DS-Lite) introduced in kernel 6.12.67.
>>
>> [Description] After upgrading the kernel from 6.12.66 to 6.12.67 in
>> the OpenWrt snapshot, IPv4 packets can no longer be sent to the
>> external network via MAP-E or DS-Lite interfaces.
>> [Environment]
>> * Hardware: FriendlyElec NanoPi R6C
>> * OS: OpenWrt snapshot
>> * Kernel version: 6.12.67 (Broken), 6.12.66 (Working)
>> * Protocol: MAP-E and DS-Lite
>> [Culprit] By bisecting/reverting individual commits, I have identified
>> that the following commit is responsible for this issue:
>> "ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()" (Link to
>> the patch: https://lore.kernel.org/netdev/20260107163109.4188620-1-eduma=
zet@google.com/)
>> Reverting this specific commit on top of kernel 6.12.67 restores
>> normal connectivity for both MAP-E and DS-Lite.
>> [Steps to reproduce]
>> 1. Set up a MAP-E or DS-Lite connection on kernel 6.12.67.
>> 2. Attempt to send IPv4 traffic (e.g., ping 8.8.8.8).
>> 3. The packets fail to reach the destination.
>
> Thanks for the report.
>
> Can you provide detailed instructions ?
>
> Apparently none of our selftests caught the issue, it would be great to a=
dd one.
>
> I have no idea what MAP-E or DS-Lite are.

Hi Eric,

I'm troubleshooting a regression on my system after 6.12.63 -> 6.12.67 upgr=
ade
and my bisecting point to this patch too.

My setup is a IP6GRE tunnel over WireGuard, and after the upgrade it can no
longer receive any packets over the GRE tunnel. Using tcpdump I can see pac=
kets
coming in from WireGuard, but they don't end up in the GRE interface. Rever=
ting
this change, everything works again.

I am not a kernel netdev expert, but to me it looks like skb_vlan_inet_prep=
are
ignores the network_header on the packet completely, which is going to be n=
on
zero if skb->data !=3D skb->head, given before calling the function,
skb_reset_network_header is invoked. And in my case where there is an outer
encapsulation layer, skb->data !=3D skb->head would actually happen.

Best,
Gary

