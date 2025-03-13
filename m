Return-Path: <netdev+bounces-174769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64653A60453
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E553B267F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315101F12EB;
	Thu, 13 Mar 2025 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDuie5Hk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6E22612;
	Thu, 13 Mar 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905171; cv=fail; b=jQXAHBaqXt0+Tss1MvewEuhts9EA121q3dKgzPEJ3hjWa+KGWi9StO3VvuVU6jpcoQlnM9pB2wCIjCfIgCK6yFXCHy6ZCrk32FEH6RR1h5w5Y4Rtg6GdJ61NsbD8NKfJTFDjpwRRp92KtoAJ/rQiKgHvWfiezYgP2kLZWKNJ42g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905171; c=relaxed/simple;
	bh=rER5tfN4O37h++YsOjMHF0lxEdBoOs3Z0X5systxhnU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pebDivK2Qcc9Qem60LBFqYXuz5CHi0/YGG25g6H7K5jdGpbTQ3u2LPIz+wpu0VNIyQReVHM5Yo6OApQtc1ZXs6cyx6cGhPgGyER+CDWxtrpzSb9tSCO5bhodbX/3lvsa/51JUMOGo2sdPFU8Bkp9AXYuyGWDj5NdVFMWOCVC9Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDuie5Hk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905169; x=1773441169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rER5tfN4O37h++YsOjMHF0lxEdBoOs3Z0X5systxhnU=;
  b=ZDuie5HkRKJ/TcZ3scqscF/GS4zeyp/41LWYYhMBelQiIGefe2M4VxiC
   a5C2GA0rYJVk2BEChT69goLAKb+raIcBJPT/PVvg3lLFZIOqF8GwoUosZ
   Qjwb6OLe0DiBGs/W1QBpnhCIGDFZ0TuTYQmvtKl6wSuPFO+VTN4CabyuR
   fTJ35XSU9gCfRfMRmY0ymBhiCFrLDTlHIZun/uimhhFzyAJHYCDzDGQUl
   D0CoTpML7DqSecDp+JCEvSVvl38y9FWv30Vg/S6BfEhGD62favcMbVRnG
   ua0s25haeS5p2ND0h3EBFZvJKPLnZnpo/aeyGnE9bHj16K0y6qh/QTnY/
   g==;
X-CSE-ConnectionGUID: rnXk1lFZRkyMcvaBquo7KQ==
X-CSE-MsgGUID: m4yP1ndAS5ywiJAInoytzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42212999"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42212999"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:32:48 -0700
X-CSE-ConnectionGUID: sUWt+lQMRDa90YQplYz8+w==
X-CSE-MsgGUID: DPr9J4OuRi6H7K9UoMHcfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121597462"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:32:47 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 15:32:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:32:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E98q3PpOb+AcoA42HjQcoiOaR5KV4HDaGfgUP6HbGq3ofGBQE8wW4k/ocOncfiw8Y6F5vrHuA44oC69clNeavAKRCa+y06GxThxbykZIDc/xObu3ZFTx1IrVYCsmuNNVQXtc4cA4sdpiAFQWtEjIvmdHVXl0v3IHMHc7/hCIxFSFUyC4ihuwArYBO8PF4KguACxPRlTGNpbjU+W8kZk9z4TDKXNdp6t14qf8EP8YQV970XWyWoPKytbbCdlZiSt4+xs4BPY2BfMmcwysRUEGeDKkvteBnj8nhP60vPbqqFnfTpnywehOWl5OqDIMbgNG/LdnbPz1JOktcoh8Al2w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ouazq6gD+Nd39CN8IPjSeQuDocppLJXPFb6P0dQ+88=;
 b=aKu5MJTlaIEkjw2sHHGZcusxGz0jMqIY8114c5Milgep2jmJtjpkDQWDP2NrfwF4/l0ViQfxK+z6XKRUUff3QU+xOkGirzi7XHY/+CDgzAwS+i3HHUcJvPDxXxVJU+NzLWt6JHK0C/sneWFRBtjHAq99EulU+YfbMVpQ4AHcrqwMXFje3sb/xLMVgPPCmuQv0RlpSHi+Y8LAvEfDaxDdE7ulM9qU8h7syTF14eUmjwgOl9gbYU1vjOV6pmSdlGyZ45H5aF+5HfjKODnn59/zUnUPqj4pIqjWayWO/+G6vFm1EJrjSPDNqGVXJtZIMevB9Xa6tTuW/veWp7UHxFxHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 22:32:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:32:44 +0000
Message-ID: <b34176d5-532a-4aca-a8e2-69c32fe996c1@intel.com>
Date: Thu, 13 Mar 2025 15:32:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] stmmac: loongson: Remove surplus loop
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Yanteng Si <si.yanteng@linux.dev>, "Huacai
 Chen" <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>, "Serge
 Semin" <fancer.lancer@gmail.com>, Philipp Stanner <pstanner@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Huacai Chen <chenhuacai@loongson.cn>, "Henry
 Chen" <chenx97@aosc.io>
References: <20250313161422.97174-2-phasta@kernel.org>
 <20250313161422.97174-3-phasta@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250313161422.97174-3-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5c10a2-1097-45f9-87b5-08dd627ef94d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEZ2VE5WUHIrVFZOM3RGNTB2UTVjREZlSUQvdk9pOXdERnJaRlRNWFowTDJx?=
 =?utf-8?B?QTJTUXFEYWplcXhLVjRkRFBTY1doNXFDbG5MZ1Blb0JMbWFtTkZPRXFDUW45?=
 =?utf-8?B?WElWQTFPeU1EYk56azVXUzJsemR4ZkJCMTNnS05LdEhsQjNQOVlJZW8zUjU0?=
 =?utf-8?B?VHlSa3N6TnFSZzJTcThKOU11a3JqRzFvc015UUhLTG1Rd2k2cFdDWXFiTmhD?=
 =?utf-8?B?cDcveStFdWFUWEV3UU5ucDBlTUlBRjRjdE0wdjFOQXoxbklhRHlVMGNKVFUz?=
 =?utf-8?B?ZDBzRzVRbDdrUmlzS1FpY0JQWWxOcXdNWHNvbGtVMThBcWlwNE5vdzBSTFls?=
 =?utf-8?B?VG11OVdId1EySHlxSThEak8yMTMrdlVndXhoTUZ2dHU0WXV2RmsxK0ladVpU?=
 =?utf-8?B?UXNCSU1FWkNlaWJhbStjUVM3eW9PVVNIdlZ6T2NjMmtybTlYUjJMUFYwQW40?=
 =?utf-8?B?MWVZQnFpbkJyeUdvT29YMThscWdqOXBHd3FKdEQrOEMrMEVpVTdNMmpYWFJj?=
 =?utf-8?B?UVJyVmloM0ZaYk1NdVBibGY1S2ZYVEcwSFdTWDNEaHJNaGJQYUxxN2VrTU16?=
 =?utf-8?B?dmxhWXB4QUtvSGhCeE9BNG5HRldKejhRdnpadmdwVG5lakdlQWZqUmJPZFl2?=
 =?utf-8?B?Q2hlNjRKd0tET2Q0TWp6SGVIUUtRdFMyWWlucU5OUUlaeFJlUTJVeWJrL1FX?=
 =?utf-8?B?cFpEWXhvdEdhR2xrSkZ5bTRnUk1uNEZNa1VnVForb01ZUnBzaGl0UU93TXZR?=
 =?utf-8?B?RXpyaDdZdlV3eXh1VTh1MklodWhMNXhnK3NueWVJWWpVTWNhV1RJTGNyNXRn?=
 =?utf-8?B?dDdOWWtlKzlVZEs4ZnE4eDZodnlxNzQxVEVJZTdKd0dUbUNYYmpBblQ2VDdz?=
 =?utf-8?B?dDhlRW9HRUtKUDlEVXloa201UGpoa0tSaDNiVTlzYXh1RXZTNlA3azBESDhx?=
 =?utf-8?B?MTJFckptcGc1UldrMEV5WU1FcncwUG02bllxOUwzQW83cW00emtiQ0o0eDVs?=
 =?utf-8?B?OXdVQXk2Qk9JN2tOQ1pyK2lDSWthWC80ZVR1bDFCNDlDVWhVd0x4Sy91UzJz?=
 =?utf-8?B?c25QMTlOeU1zcUlheWpkYlpyZFVhZTVRTTcxK0lYbW9UZkxKd09uZTVsSFh4?=
 =?utf-8?B?dXRRV0ZKV3VSWlppeFBaY0NJdXcxZ0phTjdXVFVJdnVMSVBVSlB2REZaYlNH?=
 =?utf-8?B?OVV1bUdzQklZeEN3Y3hHc2cxVnJzZHBmS2NNMUJ3N05TUmVETm82RlpZN2Zh?=
 =?utf-8?B?aXNzNXNGWFVNWjYwNktJNDFSQnpMcnFNRWFpK0J4UFFleitUSEZCZmVzdDUr?=
 =?utf-8?B?dlczQ0tWb3Y5dFFHeitBT1M0SkttbnJHeWsyWSt0d3NVMEI2N1ErdENEeVBk?=
 =?utf-8?B?OUkxQ0RYeE9kYkJJRS81bXZzUjcvQmE4WXFwS0xPTG94aW85ODRrZnlZc1Q3?=
 =?utf-8?B?c0hFR1MxUXRpV1lZTXg3ZXNUYkk5d0tQTDVVS3lGTXZkRkJWbmJEanJzRUw2?=
 =?utf-8?B?bDNsR2FoQy85VHV1dTFOcTcwbDgrVXJlQU9pM3NXSmZqRmcvU0UzSW4zamc2?=
 =?utf-8?B?SDl5YmdOa0pETmJkMk5IRldjYmdwL0NPZDV4MUs5Q20vL0RtS09ia2FQdXRq?=
 =?utf-8?B?MnQ0SmZHR25Pd2IvU3VpZ1FmQ1ZYdkhSYldBd3JIWndSaHFUQkhJMjZsbnFM?=
 =?utf-8?B?NXVtRm43UHNmOUUxVkg5anVUN3ViWk5lVlNYUk5oQUVvdWZvMkNEMHB3OEFQ?=
 =?utf-8?B?VEozUXBacm1wRFlrUHpZbUJpelh0emN2VUpXLzRwbWpRMEMyNU03c0duOTlu?=
 =?utf-8?B?eFpZNGRVWExjNU5CRk1ZbnFiejlEelFxa1NramZ1MktyM1JLK2lyQzZoL3FL?=
 =?utf-8?B?RDdNM3NqRVlMZ1dFb2d2aWpwUWNCTnRncDNWMlJndEFmalJranJvaVRmb1Fw?=
 =?utf-8?Q?ylca3Iew0/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZETll5V0VPSmc0SDJ1b051TXduRzRkajdHNWhaWmZxSFNwbkY4amY4R2xN?=
 =?utf-8?B?SExLcUtWMFh5VzlSYVBxZTRSdWpxRWl0ejVKd0xXWmZEM3NITWwwUVQ3eWhK?=
 =?utf-8?B?MGFYcnRIN1FZcCsvZzZsUmFOSE5SVDBBNnQ1cy84Vmxsa0cwZ1pFcDZmaDY2?=
 =?utf-8?B?L2lRNG9VekdVVlFwbDZkNWdLVTFUNUlEYjFKLzMzdWJDYmx6YUxuNzRNSFdt?=
 =?utf-8?B?RzRSdTJvenZDRDRxL3oxRzN0aTZRMms0VUFWblFVbDV3eEtBaUhjam5EUjF1?=
 =?utf-8?B?RmVrdzBrZm1EcUkzczhycmxzQzBMUGJuWkNVYWNvVjJlK0xIUDd4djAxVm84?=
 =?utf-8?B?K3N2UkVjaGRZSlNJcTZQeWZhdlRCNCt6NTB0dGkxNERtQy8rODF0a2NPOG40?=
 =?utf-8?B?cGxrVzg3RkN4RjlvTGcxZ1ZKbnVtRVFtakxpY0VKU2grRnBLbkNTUzhGTDRW?=
 =?utf-8?B?ZFhMK3d3aWxKbTUzck94a2M0V0FqTEw4OVV2bCtDQ1ZFMkh1TjJTMHhHL2ts?=
 =?utf-8?B?ZERqWEd5d01UQVpGSUJGQjZaRTRvS2dSZkRkV0RaRnBFRDUyTVRiazE5Q0M0?=
 =?utf-8?B?a3Q3ckVEa0VGUmRqM094Ry9vcUtoamVpM1lWWEI5Y1NYbExwK2JvRW84N1J6?=
 =?utf-8?B?RHp1WnRoMEFZcUxMbTBqbU84RTNBenkrR0g2em1XNUdBVmRiSllLemc0dlo4?=
 =?utf-8?B?WXVnOWNZYzNvN0R3VFlyN2lnWnh2bE9acDBTQXExYzYwalltOFRHM1JXZkdx?=
 =?utf-8?B?MFJjd2JDWjNXVjFJc21TN2Z0SFNuUmQ5SmVESjEzbUZLcW4yL0drc0NBbHZj?=
 =?utf-8?B?c25uNHdHb2N2QXJ3dmF5RWJHUVd0S25LcWZCS2hmcVYxUk1zNDYxOFJaU1BJ?=
 =?utf-8?B?MDRjM2p6b3dieG8wWFh0Q3B0ZEUxa1A2VWk2d1dIejhlSlpnVHVLUlF4MFhL?=
 =?utf-8?B?cU5QbjZhT09BK21Pd2JhdHpOYkN6UVJ0V1BGV2NCRWpjNSswZW1BVXBGWit6?=
 =?utf-8?B?RG1lbFJhQjdBbTBwRW1pRnRCeWN0ZXAvakdmNWp0VURVaHQxUnpyRHc1U1dw?=
 =?utf-8?B?cHYvVDdzbUFUbGhZZ09QM2xtaEJuSGFDTDlRS3hQdnpOY1NEcXl6M3NvZ0p6?=
 =?utf-8?B?TExDWFhGWVhORGNJNm9wajlxZWxCQmVYMmQ0UHNYM3J0RCtEci9kbWJEdlRC?=
 =?utf-8?B?WGVBc0liM1pJdnlxeHlrc1NwMWpXZFFmZDRxNTJ2VDBRK3RsaU5FQ1NvMXRK?=
 =?utf-8?B?aXNLU1ZOMkN1dVJkVWVyWjQ0MUdsUnlnM3hsM0srSlBOb1o2b2N6eXJTYnBL?=
 =?utf-8?B?eWNtWERHNm9wbTRMUGpzMGxrSCt0VWtKT2Nsb2o2NFkxeUpmQnYrbndHZTZJ?=
 =?utf-8?B?aHpEc2tMaE44UHRRMUs3QVJBMXk3OFZkUUkvaytuVzVvT1MzanhiVWNtSWtH?=
 =?utf-8?B?SHpySFhoa3U3QXVpVk43M3BFeHJidTZoU2NsaWNwL2FQSmZBY283NjhCd2Nu?=
 =?utf-8?B?WXczd0R0TGZjUXdMUXNmOGtCZUFRT3VsaXhjUm8rdC92a3VyYzR3TnJmVk96?=
 =?utf-8?B?S3JFNlpZNlVZdi9Oc3FDNU9BUllHWDN4bytMMFQ5ZGZ2eVVUeDQ0aVBaZkJU?=
 =?utf-8?B?bTl4QnBTanNDbTlaRHpNdFVJU0V4aWtvMEdWTzlkNzgvYk1iSzlHZWdHUHZa?=
 =?utf-8?B?d2gyVjhCczMreXdQRFJaZlpoZUJBQVQ4YVlLaG8yK2xDUTY2RytQb1BwV3RG?=
 =?utf-8?B?bU9QZlcweGNLVk5EbVVibVJCYTVNKzEvN3dUUncvSkV5L3lLT1RhY3MrWERP?=
 =?utf-8?B?ZC9kYWZFb1Q5UWhraTZKeEJMM0lrdDkzeDZIRS9LTXU3SGx3bDhnSEZRZlNj?=
 =?utf-8?B?bERzRXFsQXpNaXJWYi9nN1BWNUlFd054WFBIUkt2VXo5ckxiak8zMnEwNnVM?=
 =?utf-8?B?cHdPSitkNCtMdmFvWnpUemVwZm5lSDBVb00vY1FTYzljM3FUaHRYZEdRNHp1?=
 =?utf-8?B?bG0rSDRxQ0JEN0t0V1VicHlXc1JLUU5oS01zZHAzKzVPMVNJSkEyK09Rbm4r?=
 =?utf-8?B?c3dwOFU4QklpcGJ2S0s5ekMvTkNxK24xYUdiU3g3b3ZVZ3REckR1eTdkbFIy?=
 =?utf-8?B?UElmYW9xMFdmcmw0cm1mZVAvcHJuRzg0ZjNHRnM4YWg1T2orSHE5NHVtSGtK?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5c10a2-1097-45f9-87b5-08dd627ef94d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:32:44.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIfAjhlweH10mgzNRqNZA9MP5nzQXGy3EdnwxA450b0Ityn6D0mCLb3KMBdwpyMW57ULX37AtKkKdsnRFSEX/F9E4UgBsxzAt5btmBzEkuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com



On 3/13/2025 9:14 AM, Philipp Stanner wrote:
> loongson_dwmac_probe() contains a loop which doesn't have an effect,
> because it tries to call pcim_iomap_regions() with the same parameters
> several times. The break statement at the loop's end furthermore ensures
> that the loop only runs once anyways.
> 
> Remove the surplus loop.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Tested-by: Henry Chen <chenx97@aosc.io>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 73a6715a93e6..e2959ac5c1ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -524,7 +524,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct stmmac_pci_info *info;
>  	struct stmmac_resources res;
>  	struct loongson_data *ld;
> -	int ret, i;
> +	int ret;
>  
>  	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>  	if (!plat)
> @@ -554,14 +554,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	pci_set_master(pdev);
>  
>  	/* Get the base address of device */
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
> -		if (ret)
> -			goto err_disable_device;
> -		break;
> -	}

This nonsensical code has been here since the beginning of the Loongson
support in commit 30bba69d7db4 ("stmmac: pci: Add dwmac support for
Loongson")

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

