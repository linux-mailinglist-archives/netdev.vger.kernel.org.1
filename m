Return-Path: <netdev+bounces-273449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNhGAMRBy2k9FAYAu9opvQ
	(envelope-from <netdev+bounces-273449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DB363BA9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042CB302BBA4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA40280CFB;
	Tue, 31 Mar 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK+9onCY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845428FC;
	Tue, 31 Mar 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928282; cv=fail; b=NiTYkY/XKxGTbJepKJVjldpZnMpWkNKU+x47VjzxswU3FX5u/vnWf7gzaHGw1kYmI4l37t5idV3OLmBp8gn70xVrZ88qVBCUA6Yow47+F0Ue/XIDxk/6fG6X3bL0a8wQ8fG0AjhmU0V+si7IY/JTcPT48p83cHXASQKxnTlTHy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928282; c=relaxed/simple;
	bh=NcH7YZid2AhscuGffS8lc1FI3DWlDfcu0SvhxbAEm4A=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=EuBcFMD89femxEl+kQqQklgqQYoPg13nfKVbRtl7NtVWPjF6SJ12VcS7yQRl5wuN4NFRA4JcVneSOZsmSuKkhWqbTVkXDiM7fv7YMUjmki7e20ni0gOnK+e2Etf+SpKlcUQBPu50JX7FdygORh2w1hODZzOByUM0PeVSqlrO/4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK+9onCY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774928281; x=1806464281;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NcH7YZid2AhscuGffS8lc1FI3DWlDfcu0SvhxbAEm4A=;
  b=kK+9onCYDr4+E4nH5S0tlSnWihW8dtQNTi37KAzcq83gszBiT+nl0+LW
   7wSySlBK6/o9w2inxzdEdHWSzfe+ka4dTNAN36hdgi/iQs1bq/XDtQ8Ip
   HE1eWcI7+ak21Gb2/EAnUN44bLoy7W9Ea5n2Xqh7ZTJbtRr2DR7winoIo
   cam5m7A+RAzLEBeoXkzQQ+Pf3skDmIkpgHfk4N6Mxqd5SK/o4n1mxIa9x
   OkzwEj7JVqxxn40vmfcalYTyKPVt8QyscekCNLw2X7XrAT+4kl+MwR89o
   fy9aNWMec9utv+cEWO5e9BEtI5dTGBxsDkcYc+iIt1v8+ba0/20qUdAu7
   Q==;
X-CSE-ConnectionGUID: TB7Daw/yS6yIFQz+TkrBCA==
X-CSE-MsgGUID: 9OosKQqDSFih57/Mg1B3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75104657"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75104657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:37:59 -0700
X-CSE-ConnectionGUID: 6C+ztMxMSx6k0YOcrU+vJg==
X-CSE-MsgGUID: o36Zg5WZR36kR931VcJAYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="222936003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:37:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:37:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 20:37:58 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZEmuzFJrdtAPP2lVwYdtyWddcrtRzmu8XmhDWcXPPRKn0kdtSlLL/VqpbobvQtEZPmpW7uxGBlxp1rIKvTGQkPEUZpQtx1go8LcU+9yOyqg3i6csq45tcZyl1G4lvYdDpGCgSvXPhAebwwbLOLBZ/yExmiBSEen9caLSj57GhCCv8W43XCOerb8oTbqZ0ClJbhenRSJdafrlnBNKoiX5D80eFceVUsrh+mak2GtDjjfZSGAQFiIX2+KQ5tXvtgZLhxXTIsQT6OLi+amnjCsKMiZYtGvfZkkcDgmG7NqqglSz6kLtQ+fwEf0Vf0YYpEiR165fJUb3fwECzHB8JS0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1BAxROrzkohI8xdxZYp0LFXfkH07h5asemoPnARjBM=;
 b=Y4XHn1Emnfb1HXkVhFNiE2G3JGGrIbkvRXMcKHzT3BlNn9Ig4KTweEygnVWbQvImv07rSLK9SjomCz41IAdQt+e1lCUGYHM4ufy1/rjWs92GU1J1VIqdxYIq/RMtTEoAhuIj4NBVR5X0ft+9eyrHhgVEPb80Row1LBWiNodskSy6TXLfF0lcigBkLVyKTAt0Tk7DH4ZxIUjPJoKUBphEr/ttx3f9dHKXHQ/gY517vTPaNeLOsqTPLvaP3WkysA+K/y5/nk6WTLeyBjufegkc2q8UNAiRsMUbi322P4JDSXilYq/9oLDIY4K61kI9rtw+LXnrryb4NfezTFV8KcdV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:37:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:37:55 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Mar 2026 20:37:52 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Message-ID: <69cb4190ecc1f_1b0cc610060@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-2-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-2-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 01/11] sfc: add cxl support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: a467ec8e-8fdd-4055-c734-08de8ed6e4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2WWIvwUPpm+GVLKBt6pI+FfFsN//icH/FGhco0aiuj23ueNX7AXPPfsTlL1UEe491r24vmpK3ynJtDrJWmtSz+SbkejqhzPLLxG6H482D2EK8AvX6Vu7YYWLRbyKjr28XZiXCR+oCmwjolK/xj9ijhYHlN/uV4QZ6dmDCkGFZfCeJC7KDcPwps+AYiqRJsUY1gBNap+uvwSJbvuQ0TqPX2KvLNzpVwTUxjy6y4KEgkRHjL1lROFW5uZUPie94vvS00iKAy4XaQiU4H2anI2it+ezl0okV1okl3roaRJiE5KQsgK+u3RUWX/ebTnV46SdrY3przoYpl2K+XmOdXK55W6gBmLy6fh6ZNStZ8diKOkez/aNCn0Zcok6Kcp64nyAmv/G3NiHTPonNwEvXOS96qWIuLbMDX3CrmlfO5vKhdsk/2A53E9N9PE2ep7wi1sIheaKK0qnvbOQxVas5KnYLjPkp9A2aZaQwesi2yIlbtiH018FiPIlY31D/bOPsmO6184uhG3dzwShK4Ljds+BEQfHnTYwjieeZtfBilDmT6ul4c6qiF7J42TE3V7/EDTOGlhbxXwpLh9EjlomveuHqA3Ui9NPNL0dy+pWekIfAsvsQu/naz/3HMxYXPCxiVQKAM809FOBDdmHVnr71Tp6SihF+l0fy/AEm0bI1cMWms26rG3niGfToz6noHEV5baUvaEEc47ps7kqwUNR4UhDrvgk2PpISGWJvxoBp24LJpQx0wRXEQtNZ8cDqvUUCqew8rUgQVifpHmSCzMaV78n3XzuxfMi0BAZ1yxqUMMkGBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzgxM01wZ2VzR24rSk43SVVLb1Q5QWJ1a25SK3cwLy9VTmxxV3Q0UjMvUDhI?=
 =?utf-8?B?cFBHNkFNckJ6dDhnMEpqV3hUbnBGS3VMMDF6NDRzbGVncjZpUm1sWFBuTTZw?=
 =?utf-8?B?RFdUeW5zTHczWWFOamNiUnpMZkYyaU81M1lKSndBRElxcmh0VVdNQXM4VnJM?=
 =?utf-8?B?c1JWM1VrWlF1WCt4S0xMKytzOHlwcFk2cEdacDBBZW9XeHNlUjFGdjFCZ2Vs?=
 =?utf-8?B?YWluNktzN3ByNzVzS0pHODIzTHg3b2F3YVRnMHBjK3Z0U0dsNWI2aHNodTgr?=
 =?utf-8?B?c256L3lCUmJ3bEdISzR0UkM3YUovakt1RUdsVjVEQlpvMHBYakxFS1JHaUx1?=
 =?utf-8?B?QjFmYkg2NWI1UU5xTkM5MkxUdFhra0x0QVpEQ3dHTDlSV2FkMGEyOXdDV1NR?=
 =?utf-8?B?Z2RXN0hIREdlNnlGcU81VFdMSk1VaEticVFUdERBcVFhUFNidTd5MFZaN3l0?=
 =?utf-8?B?ZUlrZDhOZU8wSmMzTHVGd0lqa0FGOVJheFFpMkZ0WmUzYm03cmllNGVONzRl?=
 =?utf-8?B?RzA5dnAvMDdENTZLZmlrRko1alJkQW1uaWhvYU1XZ0k0NkdJWmJlOHlmaGdq?=
 =?utf-8?B?WjViQWw3THdRejFLWXdSUGdrNTN5OFB4bHRWMXF4YUR6RW1MdDdrM3pnWWZZ?=
 =?utf-8?B?RUM5T0s0RDBnT2pnTlluQ1JpZHUxcE1HaFdMcUtTb3VSWXBQQXhBR2sxbFR3?=
 =?utf-8?B?UDlMa3lQMGk2UE1BNjMzZXRwd2R1SEF3bTdrRFlWNHFzUEJtZmNNYVlBWWFp?=
 =?utf-8?B?czY5R3RiRUxQUS9RQjZIUFNFbVd1eFdMZ09sZlI0cmo1MS9USFU2U052cTR6?=
 =?utf-8?B?UXU3T0p0TDJ3cEIxNTlJK3VTOGZLYlg2V1F5cmZLZThvUkdUOWJycnBjV3F2?=
 =?utf-8?B?c01QelRiR014MC9iZFVTNEV0ZzJRMEFjaFZRUE50M1l6UjYxTXZ6bzNUNmR6?=
 =?utf-8?B?Z05nMjN2ZXVmTVBkY2R3MmZiV2l0b09nUTBsdldkUzdvb2ZBeVZLaytkZkxj?=
 =?utf-8?B?UDA5QlhBVGNoK2p5TzVjNDdFcEdqTHJUS3ZQQlFRZEFyOWRPczZzVWVqckFC?=
 =?utf-8?B?NkoxbVhPb2tES3FENnNOYWZ3MVFSK0ZvckVSSlkrOXNPTEZVUTRrbkovbVhJ?=
 =?utf-8?B?QjhIVmdRT3dKdlVHMkx1TWRGMlBpL3ExNTh3a3Blcmt2NnpsTnZpcjIzY3Fr?=
 =?utf-8?B?aEJuZFB5TmFRTldZajBWZlpGTEVpd0xVQ2hPQmFjWnkyMTJTSVQzSzFGVGhp?=
 =?utf-8?B?dFJPdFkyZkQrTjVCTHVpenBJYWkxVkRRMkt2RWJDNjJoRXIxOEsySVNNL01l?=
 =?utf-8?B?L2Jma2NCMC9hK0pmaHhxMzdFU1NqMi9xalRZWlBlUlJuWEE3b1NNaDFuRURz?=
 =?utf-8?B?T3hZbXdoRno0bEwxaGxWdTFJKzRYa2pTamd2d0dsRm5UVGdOZVRDNGZQUkEw?=
 =?utf-8?B?djJ3dTFHZERhNEtSL0s5eFFvdGVvVjRxTWV3TmZ5Lzl6cGY5UThlSjFVdzk3?=
 =?utf-8?B?M3ZZcmJMdUJoUnBWVDlqcC9yRXZOQ1dPKzFORjh2ZDBjN29QZU4zNjM4UzJa?=
 =?utf-8?B?ZEVwUVYyTlFUMlMvNU9MaEE1ZjhGNGNtYWJ5dVZ6Y254amVNYjBUSjFma0dh?=
 =?utf-8?B?aCtiSFNNQTlBelhqZHZnTFk3V05vL2dyQmlGclExR0NLeEFDV1NLUFBOWTl5?=
 =?utf-8?B?MUNNa1ZXU2x1TEFLemh1OXRmVXFBS0xLdVRlZzdib0I0TFkwRmQxWmYyazFI?=
 =?utf-8?B?WFFyWFc0WUY0MHExMVlKckg5NDZoYjZzMkRTTjRqaEVIZWhXUkRhUDBHNFg1?=
 =?utf-8?B?UHR1RTFzUnJwcHMrZkJ5SXh4Skd1NEtyOWZiVmpDUHZIMzhMTklSelM5a0NC?=
 =?utf-8?B?Q3VaTWx6YkFNNGlNVGVSUnpLMEJ3SW5VSjgwa3l5blp5YlNSalhuSTlaVzBi?=
 =?utf-8?B?YU9kanBkbTkyaTRvSytRSkQ1ZHg2c3Z6RFA3WWR6K2xqa3JrbzNoc2ZHbWk5?=
 =?utf-8?B?VGQzeHFmdmNRcDM3UEVwZG52WTRiK0xpeTdLb29MdDdqamxRZ1htUklDa3dI?=
 =?utf-8?B?b2dRYVUxQ1U0QlZwYzRVS3JKdmdwdGIzeW8zWTZxNXd4QVJBWmJJNUhadDhk?=
 =?utf-8?B?YWRWalpWTUZqQ2gvWWZ6ZGZ0WndPN29FUDFVNUVrUGF4ZFRiZXRtbDZURFlt?=
 =?utf-8?B?SkxaeWtvdDRhWTdCd2pZTmlzanpUUlI0TlVjNW9ZdEVhT1hyUHNYY0EzL2hM?=
 =?utf-8?B?MEIrekVzT3J2V04yK25heVBkaUN4TGxtNVU1M3NXM043WGtLL3ozZWVpd3BJ?=
 =?utf-8?B?ZGNUR01OTzhGTUlOc242RjB3ay9uSGRYTlZjZURaRXNVa1JvbTl5cEJqWUFq?=
 =?utf-8?Q?N8+XRrdq4F8sDJ3E=3D?=
X-Exchange-RoutingPolicyChecked: PKhl0OtMxuBfeR5ETSZxjgSPcpqsbYepQSD6DyiaO6fTW2UJwenBHYESZXfMtffur5QY9aGDbWTqlLjfVbWKWpoJJ0a/qYzF+x7VWUxxRJ4KRF/bRNBpAZuxgIfTLq5HeILIN3uf+0SechBf11IyB1IPiSKKhiQtgJtJ5ZEzE5I+98+0GKhearvFBP+sMqX37LkWzFUB5F6c4/4ZxgXk7Wr/U2VGQ3VXOAo5LtrfCmXiT+h7azJKCrwVO310nmj+eFLumoYE7IMyLLzhNC+l+fOF2tmmrPfagsNbvm9xLBCdnMSIZ6vHzfzu42qC+iA4BNrXnINGm1HI6euUkoKxog==
X-MS-Exchange-CrossTenant-Network-Message-Id: a467ec8e-8fdd-4055-c734-08de8ed6e4ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:37:54.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OruekJlUuqXZVVdbwO5HlY0Aq/cQEzcfeeqaFiEpjxVRuYduzF2Ar3YcVp2C+LITScFYXB4qTCGRCxDpb+tH8yj0CBt7e0mIHQJsf5fKbwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-273449-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,huawei.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 282DB363BA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alejandro, similar to the approach taken with the CXL port error
handling series [1], I propose that additional changes to this
implementation be handled incrementally.

There may still be something that should be rebased out of the history,
but we have passed the point where fixes on top of stable commits starts
to be a better working model.

[1]: http://lore.kernel.org/69c98caef1348_178904100e0@dwillia2-mobl4.notmuch

One warning below...

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[..]
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_dev->dev.id, dvsec, struct efx_cxl,
> +					cxlds, false);
> +
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	probe_data->cxl = cxl;
> +
> +	return 0;
> +}
> +
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +}

Not a driver I maintain so feel free to disregard, but if you are going
to have an exit handler, then you also want an explicit
devm_cxl_dev_state_destroy() API.

As a reviewer I do not want to always remember that some of this
driver's resources are cleaned up in the ->remove() callback and others
are cleaned up post ->remove() by the devres core. It is either 100%
explicit release or 100% implicit release if I have my druthers.

