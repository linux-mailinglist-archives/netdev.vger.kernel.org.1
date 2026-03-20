Return-Path: <netdev+bounces-270061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABr1DoyuvWnIAQMAu9opvQ
	(envelope-from <netdev+bounces-270061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:31:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B463F2E0DAF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B053073F4E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58A31F9AD;
	Fri, 20 Mar 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0L8Q99G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD331F992
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038624; cv=fail; b=cnmF44rutN2AhYfy9WmjLh1ZjfJijRMB1NtbpiOr+mVfdOHSKWFeYqxZmk/j/tmP6MVE/5vRa7aXfdzjB6c7++0smwWB4sRgQBtxTezSIr41SOPUitXIgwipAdFjuBHAurtGi4uxfzojMDm0ITHgrnYb76xLRQ6Eow42b9ZWd+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038624; c=relaxed/simple;
	bh=yRj/KvhzVFgbKsFsY45sJxToFSwjg2H+4hw9WQt8pe8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0coIP/GrRQsj/sj7eosu4NKBS/Kf+J8w4krGpOl60cX5dOw9yn3uH2UiN0mL2yXlXvKEmfu8oFT857ERA1nkxZ7OddQC20u4VNSLNS6O69KE+UNo7HXBxNMcr+VYaWiQOHQC44Uw8671vYqibdWfxkZomF/AlS+x9BYmVySRmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0L8Q99G; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774038622; x=1805574622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yRj/KvhzVFgbKsFsY45sJxToFSwjg2H+4hw9WQt8pe8=;
  b=j0L8Q99Gu/spO2+/2PMAm4Zga6FkxGRH7U6l9iFFmxQac9saeNzj2SSY
   1NL19HTHN8FdzmVIrqJh6LpsaahiApZIYeQ/Q/XvVRWO/4RzO1ohl+C4Y
   S7yF0VJ4zbCNRzUSgcU1lwRJhuuiX0xW9Er/4RDUL1mFknSur/g31h4J/
   cjq2E0a7Gq4MFnXLyJkjpLHib8zVa4i307N3A36HEpGdvWVb/3mkU940S
   BQQ4SPq2jeR0V7WoXyn/d3bgjB1fJQLDH4kdBLAop2g2uKQBkLUVnK7j6
   qcPW4fcmQeOHWGEnUwWigmxXQAQoP9Hy6r+Y9Cf5+psijxd+4HWqr9lO9
   g==;
X-CSE-ConnectionGUID: s+yhXn9+TMGSMquU+thM6g==
X-CSE-MsgGUID: P9uFIPonQS+pr9t24tJdGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85833404"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85833404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:30:22 -0700
X-CSE-ConnectionGUID: bYmL3qeyQ3CzY3a01gOnKg==
X-CSE-MsgGUID: wNn7zYoaTXuxrrJO+zQDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227503715"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:30:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 13:30:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 13:30:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 13:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU7uhkZVo2ce09ipOVJ5SlAAap0sE+FcxeSgAAKCNXr9YgPv9iIm0mZgLdmJ4YR4VhDtW8q49Qwhfz0aJyVR7RCRRTp0zfJ931GxCfk8zrwNdHN5EvVz5sS/a9F3HwZDeAFd8yJf8qCgPKfTwipKfNwYAge4i5bxRAVamJ906dhl4R9VCWwHQD9BCncmK7W/xcUbdfDHXERHMMHpx6f9OEhj/QdcC4aONrORDSF+tVbfKfp9R1RszkbdxVUWl8oZAo2Mct0raNH2j45XkmTsbsMfitVc41+o0Swcb0m5VN8RnpZUj2iXaXiIRBEctbUGCrZLJ7yRGBvqJldCcWKUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEXeYB/fhLkkC7beJzPnxXpM7rlQCoS1IWpMOnKCf8s=;
 b=kbEcWIElaA28cotwIt/6nr9kImuMZbNmGA9v3PkRAONfKxLDJydSazQmQaZ779EJZEcQCwmEq9vmid6pFcGzCODh2O1eF2bpANwg562RMnPj5JqBQ1cnHVOLsiDqFJpvT3wh8iSz9vg4fB/G4uwpeL96JzkEOIZsKjeIH69bpk9kzf4ax8kN6Ew7EvVhlzYpAfrLQb8Ccr3VE1wmiqelf67P40Yk1KEoJjOsbxPGbmA0cp1r8oX1ywkeOjANmkTHxd5JZkvBIV+n2v7CugGM6d9yoHurbPXdUglp16vjkynfafBHRsvhunaU4zxp5L7Ij7QIUXjMfFOJmtCfmqjFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB4797.namprd11.prod.outlook.com (2603:10b6:a03:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:30:18 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:30:18 +0000
Message-ID: <02552c4b-e4ba-4750-afc9-aaa2a671f964@intel.com>
Date: Fri, 20 Mar 2026 13:30:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/2] igc: enable build_skb path
To: Kohei Enju <kohei@enjuk.jp>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <dima.ruinskiy@intel.com>, <kohei.enju@gmail.com>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org> <abzhZsk5FdB2eWeN@x1>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <abzhZsk5FdB2eWeN@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:303:b5::34) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a4f7e1-4c52-46b8-d59e-08de86bf801e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fyTWjCDLDdHowcITHKcQ6LgZjBgok2sJrisOHBjP6zI4iYbRknLxsz3aEF59mpVkUadraCo2elfGIejShzXGzY/QRuCzxQLPiS4Fhd2+Rod0OloXEi11SKpadZGFovOUFhXfAofcJTzH5N3GNvT70AMZdlC4AOBJXTNsCikWpXFeQ4vFuZJ58vRilpvsm2a/K2yS1V5Ffr8cslvGhpUtwo/YBH4/d6+kwhcYz4CQnKOHWwvBdc4Dl4xuk+06gkbxNKtEZzJ7RyT2ST8B3JT5NbaF86e2AW7gm0em0DsVOvw6TEzHpuamvFpNASRMvknpq2nOiwxgRti1Tpe1El63P2+I9T9sxaq7v2RuqS+9AN46XTHsLTq5mXdxS/vePfiV8y39vu46ccKDaa8QrLePAHukYG4OfsNoUS+CzBgOYYv/2wSjDGdn/vD8U9Au7Dbtbv0kjH0kUEFHbcvspuydM75vKPueQXB0jxPQopUT3CEzS0btjk2Yqy8OovvXvTzYkRdSxR+Mf0/jX84m2yCJdGGkjyehiiT0invyx/CdgXGTWGcJ5l+KpBYqp8DTcn61sSnkUN51eLc0cHZ5vKtvJwRbH0mTvgVDw/CDW88Hwi4EWml3NsUvMSBo4qDfNWuCGmQdsSXeZolWcffX3f477UjsCs/BC/sqEJ2rh7jvDQH8G3KqGapyAJnk6a2334lLZpJkunxKHqZTgoHcuQepJHw0bcwsnZ9MRvbBcj7ZGvN8O2ks9iDA6nw74abcg3EN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFh5blp2VDMyL1Z4eTl4aG5xQVh5RDM0WVRrS0FzV0MrQ0tCbXR5R3NRa2lU?=
 =?utf-8?B?R3EvQnlsZU0zZ2liem1JNk1BL3JuYjZPWmtiYUVTVm9VSTRCQTJTZXBJQmNZ?=
 =?utf-8?B?ZE1DZDl3L241NUlnSzFzVXdlR3NCNDE0ZFFteC9lMnpqZkRKUHovWTl4Zkhy?=
 =?utf-8?B?MmJZUUV2OUFVc2dzSEZBMnBEcmdrNFpzaTRqWVF4Z3QwMVBWMXZHbTFDQVYy?=
 =?utf-8?B?dmh3WWdXY3Jqa0w4eUY5WTlWOWliQTBISlpITy9vblBobTJMM1Zqa3Fjb2Fw?=
 =?utf-8?B?SStUdHB5VW1McmVwL3FXUXZKYnh0TmNVQVJWODZnWjlJUythTDc5WVVnUGhC?=
 =?utf-8?B?MDVwRnZoY2FiblNwbzFiMEREUjBmT3VwdDBQaUZxNHNsV29wdmJwRkdIVVZu?=
 =?utf-8?B?U2JUZlA0U2x3V3dmNkhmMHpmOEhRVkE3M0xjOUxIOHJXZndBRHdqN0svZm9q?=
 =?utf-8?B?WW8xWndnRVh6UUJhODF0ZTAyS1Y0QTV6ZXVSQWhUKzZVdm90T3lBOTcwdEpS?=
 =?utf-8?B?Y1lWMm54YWpCenZnakxPM0ZJV3Bva0trMjA2OCtaV2dETm1wcWhzVGo5ZnMz?=
 =?utf-8?B?N2hqV0FvRmtPMm1aRDFaZFhjeW9mS3hsRHpqcXBNcmNBdUY3d3JXVWdhemJz?=
 =?utf-8?B?OEpSb2ZhNlREM3prb2RqRUxlOUk2UUloK3FRaC8rOG44UFBya2gxODZQeWZm?=
 =?utf-8?B?N1RhWWlObjZHalJEUHlOS1lpTktqR1dpWWF4UFYwdE1WL1RmYmVMSkg2OTIx?=
 =?utf-8?B?UG9WcG9tZGpJVkovUS9TblNkZW9Fd3poWm1EVEdSKzVzaFpncEk1QmhTMHR6?=
 =?utf-8?B?L1dnRkdteDJpaVY0YmJIbjNicDJuSFAxQzdZZmh5b01TRnZHK0wyN1RaWnl2?=
 =?utf-8?B?NkowVG8rWUh2d2I5UmUxdjA2YmdCaDlFZlRuNktEWVdTZ3FXVzdSL1Y2UVpN?=
 =?utf-8?B?VlZNOS9yRHduUjRlTE9QMWpRYStldFN6LzNQWTc2RldldmZOdjVEYW9tQnMr?=
 =?utf-8?B?OGJNMG5IN3ZuSk9zazNHU2J4NWFsUXBEYkpGTVY5NE54YzE4a2V4MmZITjBx?=
 =?utf-8?B?T0pvLzlEdkhaeUNuRVo1a1Q1Q0o4UnV3K2RqbDlvb29xNEgzQ1pPRTA0a201?=
 =?utf-8?B?Q2lrSlMxYzRVbk02RjcxTHJVKzk3M2dEVUhwSlhIRmRNVW84RTNqd0k2RHpX?=
 =?utf-8?B?em45bnVLSk14NmUyQm15LzViNVArdDhLQm9Gd1RYS29ScGtEU0tZYytrWHd1?=
 =?utf-8?B?ZkdFMGRLa0thbVZhdThkNXJPazFOd2d1RWhKOHVrcTBTVEE5YXp6Y0tVbnlC?=
 =?utf-8?B?dDlsYTlSdEovNjN4cUNkckdObmJxLzB5YnhtRmlTdTM3a3k4UWx3MGRiWnFR?=
 =?utf-8?B?N3AzSVdqaEl2MVJnOVhCYklPaXNvaExsK0xqQmdwSUJRcjdoQlR0WU1UcGxM?=
 =?utf-8?B?bXlwQW41a2JZS2ZWSTltVzhUbEhHOWVvN0hzY0hXR3VnVFlkR2Y3Y1NVa21l?=
 =?utf-8?B?WkRER0U4Y2tZTmxxYlE0cUhWRlpZY2xUcCtTSFBMbFMvYTZsMXhxemprbGpi?=
 =?utf-8?B?eHJBNE1RajZ2bDQ1U3dHWWE5V3laY3FFcVN4akJ0c2ZVZXFwM0oxQXJQRURH?=
 =?utf-8?B?MmY5OFo1QzE1eDBpVm55OHFsMVN2Ymp2R0xkQW1HN1Jhb0hCcnZ4ZjBUbkVR?=
 =?utf-8?B?NnlHRmRwbGZ0OTFtdHNycWg1V0JhMXVneHA3d0lJVUk5Y2VUSnRKeWt3TkJ1?=
 =?utf-8?B?aEp3RTc5alFRcUREc1hXZnkvQ29KOTROV1dEM3JIRmR0YzZiZ3NCR0tJTldm?=
 =?utf-8?B?a1FxU05VaDZaMVJDa3I2d3FwS0JJSThISys3dGluakNHM3d4NnhYOEVQbFJY?=
 =?utf-8?B?cTI5OG1yNFVmQ0ZtRExGaWNEaDRUVUU0b2M4ak5sMGFFNkZGSFo0M1dYRjFY?=
 =?utf-8?B?MTJIWkFMeHF4WUpHejU5b1F0cUxMcTBOcnpDdVNpa2pJMWtHRjFPb1ZIVnNS?=
 =?utf-8?B?NU93bmlLb2E3cXplODdPYnF1bXV6c1hxcER5SG1YNkQ1Z2plQVcxMmVZbWp2?=
 =?utf-8?B?d1JpNjdQck1nM0VwVCtnTkk0R2pRSzkxUmZoZ3lESlhPOTk3S2JTR2ZHYlNZ?=
 =?utf-8?B?K3NJdHovSjBWREhpbzgvNFJOVHNoMlFHbmxLemV5MEUzMkJZd0VhVzVtMGo3?=
 =?utf-8?B?OGdPR0M1T2M1Q3BDcEtQeExQVSthU1V3dklkMXBFNEVjbVAzT3VyWDhxQUZv?=
 =?utf-8?B?YUtybXNVK0RIZURlR0htd2ErdHpsR1FVQit3MGE1clkxdmoxZTQ2K1FqODkw?=
 =?utf-8?B?aDFENTFTdnp5cFpBWFR3MlhxVDZYejRobEZzc2RwTFl5amNxSklxelk3WE11?=
 =?utf-8?Q?SqjNAT+wEMx/nBYY=3D?=
X-Exchange-RoutingPolicyChecked: G36TRC3vVz/bK76BJ6bjOKAvQX5LcEaS+nmNFyUsm5szioFhbAIXJOcjrLQ04dlOkg8VOyitwSHQNsR/WX1VrPVh+VJPu0p5XJTzK+vLHkUNMAOHPapfy6SzoALL5dcm08uqLxTNB7IeVUv8Klz0jc1bEmk2YPSjOzS44ujbvc9rScWeLf610p/io/EkqbtmvvC/n3V7luwDztd8pct9qe9vpl8wU9XBHJENedxHJMaBZJM1OWLecN2465DyHAyh8mSbDLhAuQuxGaiIgG9IR2NIzVwkO1fBmwtzR1pKizIxeLDrrtQZSP/8V0hN9+hBCoaYga3eCMNBT1iwbCtszA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a4f7e1-4c52-46b8-d59e-08de86bf801e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:30:18.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghhvjhynwTTr04QUCSWOofkABxPE7TmUh0+w4Q6XMdg1hsMVkuGpTd5pAMpGaiuPliVVVQPzB40zVM0xY2Dop90AZq4F0HhJH7fGi7e3hcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4797
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270061-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B463F2E0DAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/19/2026 11:05 PM, Kohei Enju wrote:
> On 03/19 16:11, Simon Horman wrote:
>> On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
>>> This series enables the build_skb RX path in igc, which is currently not
>>> enabled in any configuration.
>>>
>>> Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
>>> path.
>>> Patch 2/2 enables the build_skb path when XDP is inactive and other
>>> conditions are met.
>>>
>>> Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
>>>
>>> Changes:
>>>    v2:
>>>      - don't insist on reverse christmas tree, reducing net diff in the
>>>        patch 1/2 (Dima)
>>>    v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
>>>
>>> Kohei Enju (2):
>>>    igc: set RX hardware timestamps in igc_build_skb()
>>>    igc: enable build_skb on the non-XDP small-frame RX path
>>
>> For the series:
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Tony, thanks for applying this series to next-queue.
> I have a question about the process of patch submission.
> 
> Sometimes reviewers give RB tags for a whole series like this, but I
> think that those tags on the cover letter are not collected
> automatically, right?
> 
> In this case, should I add RB tags to each patch if I respin for other
> reasons, or what is the recommended way to handle this?

Hi Kohei,

If you need to respin, feel free to carry the tags over. If you don't, 
I'll bring them over.

Thanks,
Tony


