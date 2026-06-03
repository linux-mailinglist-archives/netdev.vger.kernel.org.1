Return-Path: <netdev+bounces-294942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ojIFJtumIGpB6QAAu9opvQ
	(envelope-from <netdev+bounces-294942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:12:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0124063B842
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:12:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Mm58JN4D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294942-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294942-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 969AC3022ABE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1782426EB7;
	Wed,  3 Jun 2026 22:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B5436367
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524534; cv=fail; b=kGKp9KM58z+0tO1ovXo09i+6Wj2UZrwQ4gS+1ML8O+5g9cdq5+EFVNBJlc8SD3sBPKO+hhRfTHdlNKPB66p3uvMgQPdsQRNyt+uMvr3ZBTBcejpJwVyoTglBB+ucFl7B3ucsIH0muLAFtTf/O/jQxPPH8e1+pKSokVVegHrN6kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524534; c=relaxed/simple;
	bh=5odzkTAZkQsi4AJUzPoMCuihgMlGlHX2K3FqD6KDyfo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txhfmiVXTgGAY9cqJueq/mL0f6cB8ivZo+0V+YmwOjF55M5e+KxEdRLOa31U9Yi6JRtE57j9IWDT/rK+6Yg4e+g2qhm/ZpBeee7yCPLPM/AxjiJQz7+FPjw6Iv9p1V61TYGCIvzUAg85IciMq5oEmc+CWkNk86VvTuYeBT2sgJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mm58JN4D; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524533; x=1812060533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5odzkTAZkQsi4AJUzPoMCuihgMlGlHX2K3FqD6KDyfo=;
  b=Mm58JN4De8fX6AZ+psA1OwrLwSkrZwBJO4gWYdOEhWl2t815Xy1hEw6+
   ZBmZ3CHS20Jxc/Ux4XLiLVtDmim5KJJAr0p8TwwR2RDx99w/gGuJiDqG2
   J9sZ/kMqsw1p7CQPgCiD0Q93u+uWaZuAM9tCBi9tjRnkjox0cd4t1EhXS
   3Q/oW45k/w4F7ShHWf60x+qI8nP5f+5GZi1JLDaJdyk8bqFy9KQto/8mR
   AKpBS97O7IpKuBzIfNgwCI3o3uZEk6lueKEY+QgTqEYj/4OOb4nz6WQPM
   83ER/1Bs6G4zZEFFYKgsA58nNGUExAU+LcjXExLoAjsmLB0LMcvaY+slE
   g==;
X-CSE-ConnectionGUID: dM+Z0VWZRSG9QIb3+gaoRg==
X-CSE-MsgGUID: LXE6fbjtQHqn4L3PHV8PVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92031988"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92031988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:53 -0700
X-CSE-ConnectionGUID: rusL4R9UTAudwglOgjBIJg==
X-CSE-MsgGUID: uGsaDAFgR7Gg/4GjnxPaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241379433"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:08:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 15:08:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 15:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfONJlvRL2EaFwO+IYCuURrND9Neva/ULrchobLIm6dE3XZ3yDZT92FJ3nKtCwrbZJLkcv+NQgmnYHZ3farisEa8ELZkUHxG/Q7sT9jrdqZS88aWee17KMv9ZMJ6lDlX242UvH5/3LsSLSlfeYTDb1jYY7ZshTGCRH+GkQwhzhrNGePQFJJRnVh+9RsD7jFnMFhk8QO54yUUBQU20UoUl0/VgjrOvc5rrUur5qSCOp1eClBqw62CtbXhZMG8ZQ9wQtzcKmr4HqXgsiOkkxZSDCfEkLqto5WKcomsanc/00HmmuWqryyBAXOUQ6Ibey+ffCkR4jCQRNonAMXGEWC/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV2GvY3Ul1FXGb4FPhf/YaHG6kF9b2L1Stsj5gSESZo=;
 b=Hi2NvkBcKyQnK8Rq/qPXIHDYjDHoLPEzu7v5RdKfVRPHVyC4ss137DUa0A1b3DOty4nTsAVuFKcvo0fTBK7HZQ2X8PoNivxD0foGTwZ2cEoJgltpiIr8WOXEQzBQmcFQGQajfnV7Ud7fZMv7yLlvNbKc+1AXOn1jnA1zIpLBplCXab4BNT1VujQVVq7fFcvAC5hZ/Znirsu7CciZiiQzn1EXgXTWmAYLkYRTbdiohJx7Cvdz8bFVFXnsO+uBGLUbYK+lIdTlt9xdIfiI7R85Jebb2vrR9aCx9/yVsbdVwnHah9F59duebR4beoRBPCrFRN/I8Tq1StNcOZsSc9z4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DSVPR11MB909287.namprd11.prod.outlook.com (2603:10b6:8:37b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 22:08:48 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 22:08:48 +0000
Message-ID: <508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
Date: Wed, 3 Jun 2026 15:08:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260603210810.2636193-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DSVPR11MB909287:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cb4761-3565-4d41-2354-08dec1bcaffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: tojhPP+QzVFqbzigWV8QwJXTVZW+ojUwaQvFz5moWZLIthZK2V7nzsyWhyoYhd1yIW4ZbS5oYOrzO2bAwXOMVQ2MMS84T0YBm31wIZ1KTJbgzAtZZ2oov2YbnTUOcpCwGVlddNyej1fbr3RiqCXosVILwh4Xj8mpHogZBuCnjRAH91HtJQITEaUO9s/K1CD2bei9ajuzuMcvKwvx/uX6duMrL1y+w6WyjdV5BOGnasgPv80noEb4vgQGoyHeNQkGb69GUJ40jT4kRLyM0OTBEwufWC2oD2dB7vDQwmrJA/Ll4if/4kBiSfeBJ1yexgspSq9QoQdq669mDp+wz4zM/4r0iwTkswL/HF7PCDp9fNvMX3pn4II8oDK/Ik6JHPsSpKbTl8JEmSVPX22rz8bCSNYRzfmnQSUn9qxKdOEvVrfIMnmC797kHnBL2aJosedoc/X3+5Ng1ghqQz5ls/9qa9s+p9pjtABT79K6sYRfWFzgFAPIPmBjArBTFn+OGnJ1rgIGrp6mTyVyW2SAn2VAyukZyGMy80aJ71XqyMvRE/x3L2KOD0HRo7ijzyf1+SesczzQKnsba0mrHl7+eSLABAaB4Gy4gSxjUZganTCwGnAYuv3XuR2ipSGPArZhiAtQtfWzKg8hvLtwxp5u2NXFWD4vadmVIqo2rm7DEBzOhkW0wgpEvNHhkrbF8RCWR7sH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5TcVN3NDhoejcwMUhXSTlad3ByQ2U1c0M5anNaWXVlbkdGRHVrdnhmcTZr?=
 =?utf-8?B?dXYvYnZTRHBiQ0xJdmN6UDBHTjZIeXduOUtVbmt6bEdNTjdiV2xHRHI0WG1w?=
 =?utf-8?B?QVJUaUVlK25VLzVpS3kyaVVhdE1qT2taK3VzY0tXL3ROcGJ2VVBHNEFQVm1q?=
 =?utf-8?B?bjN1OGdUZFhVWlBXaDFjY0pXRDF0VFdpN0c2S0FjLzFncVBEbjF3YW16Mm56?=
 =?utf-8?B?VnN3MWpydXU3TFZueWRRa2k1UFVrTHZMN1Y0UlFWL1BqTnlCZ2tUNWVHYSto?=
 =?utf-8?B?Ky9DcDVzZ0NuUTUxdG1rSWJlcjVsbTRPR0phNXh2eEFUY0dLWUo4REswTWhB?=
 =?utf-8?B?VVZrWG50SzQ0ZndwQk9aWGppWnJxQWdqekJPbzl4MTk2SzMvVjZiNmp5dnRn?=
 =?utf-8?B?WjBVS1E3YU1lMnlzSmpqTlZjUk9ySFA2cEZQbEttSVBSd0hMWkRXeTRDNlRi?=
 =?utf-8?B?RGVmRTlMNGxIRlhhYjY0bU01UzU0V1Z6SjhnQVEwM3JFcFV2eXVDTXZYd3lU?=
 =?utf-8?B?L3Q0VVZoclVRSVB2Yi9DRnhOZmZHYWRTM2hPaEZ6MDl0NEZjVFlxdlRKV1RB?=
 =?utf-8?B?enRXRVM1YVZiamZ3c3JyVHhLQWFmK1hKdHZDSXV3MUdJSWFnMXJ3YmtJeVQw?=
 =?utf-8?B?UnJiLy91QlhlWnUvTmV6VFBIRVpOWlZ5dEhENXZRSEVhZkpzaXpBVnFsRFUz?=
 =?utf-8?B?MjFBZkptam03UEd0Sm91RmJ3SVdKSEl3QW13SEVMVitKdGs2MUJCcTdNQW1C?=
 =?utf-8?B?NXlOc20zVWkwRUUxMFJybTRmRkhZVG11ejFVVGZkZWJKblozTDB0aUZKNDdG?=
 =?utf-8?B?aVVVaWR3c0lNcERORVMwRFFvUXBoMWNnSyt1TUxNcEVUS0orYnhSNDVVd0tj?=
 =?utf-8?B?MzBTL2hKb3lUQURsV1FRMU5EZXpLWEJBcmEzR2NzQUJ1Wk5tK2dVa2YxaVFs?=
 =?utf-8?B?bktTRGdSclBRa3NaTjFnci9VaUU5SkhxUXNwTWM2bHJBbStpWUovY0hJRmNO?=
 =?utf-8?B?M253S2RqNlczWS9lWTRLaGJXYUxYY00rZGFKblBrcHBYdHBlQVR2RzdmdTQw?=
 =?utf-8?B?RVUycndxRFROemhIeFdvZnlzQ2daSmhVdTRaZTZWeGFpOXR1S1N0aWFzZFAv?=
 =?utf-8?B?K051T0dLb2NOQzlDenFFWnFIbjhtTEF4dHlyTTk3eWN1K1gyTlJ6MVRFVk9T?=
 =?utf-8?B?WWEvK2VrWmxiekJqTVdON2JZeUIvS2NwU0ZrUThOYVo1NDcxK1ZBREFBZmtT?=
 =?utf-8?B?NjhDZUxEVFc0cEhnOFZ2MWp6Q2g5UnBBMHIreFpxTytLM0NGKzF2RXE2R28y?=
 =?utf-8?B?TEtpeE9ybDB3WUJqQk1TMTBSV05BZTVsSWFoTFVOeXZFWm5Cc0tFU1lEdk1h?=
 =?utf-8?B?dE0zNlhFeVBXMzgrcklvMVo2Qk1ObFpoK0FDbUxTeklvb1A3emgvMFRvRGFJ?=
 =?utf-8?B?VEdBc1pvT25kRUlmQmR3YlRBQ2hhMm9UV2V3dHZuMnRyWnBPUjlOcXVvbkNv?=
 =?utf-8?B?VmVEMnY3Vy95UytMdEkrN3dsRGxaZjZKN0Z0NWRxWFR5UkRMQlRVSnFEc3NG?=
 =?utf-8?B?RkNrTzVSMkJoaUppUzFOcTU3cnNyczUyMU9WcTZQd0t0cG5ocU9pcnA1ZDc1?=
 =?utf-8?B?M0JQMjhFM0hFTUxGRlZ4VGE4cmllc3ZTbkgzVUhLMG51YzA3U3JOaWRZZ21l?=
 =?utf-8?B?cjByTnFSVjlOZmdDcGRWemdBYWNkZk5HRzArazdScFNSeU51NDhPQzN1dkJU?=
 =?utf-8?B?TXhnYTVkdGZublNSd3BEOWZ0SW01TmsyQ0tPWWVWY3lHdkpIa29sZGJkZThl?=
 =?utf-8?B?Qm5GQlk1cUVieW40SjhPSkhnUWZCK0NPZlZDYkFaejM3WlhXYXZKbHRUano3?=
 =?utf-8?B?a2RpWExibmVHaWI2WVc5MjhrV3d0OG9IVkRJKzRnY0lsQjRNQVc3ZitGcDB3?=
 =?utf-8?B?TU5KeDJ0YUh5SDM2aVFpTCtncUNOYXVsQnI3QjhTTFFWZS9Bb0JMVk4zRzhY?=
 =?utf-8?B?VFVCbFR5bmpGNGVnQjJXbkZISWNISTBqRjcrM3FNZzhZZWtRM3NXZDRTR2E0?=
 =?utf-8?B?WWdETzhRSjU1VkF1ZnRQZE9KdnpwelZSM1FFSGxySmx4TnlOakxFMFJOcDFj?=
 =?utf-8?B?V1lWT3FCZVVhK1ZXbW9uYWRzbmRpaUdwUTgvVnZwZVVWRENlM2dXVG1jYnJX?=
 =?utf-8?B?NTVvLzRETFV1cDZwR2VIYW9tbEVzZ2REUENQL3lXc2tKemFJMXMyeW56bjQ1?=
 =?utf-8?B?MnA2RXlOM2xETGFXdlhHMXpTMncyRXVBdWpldUdtb0tWeTRnQ3lQditpUERN?=
 =?utf-8?B?NGt4ckVNbDRaMWo0c0t5TlZDbWZnQ25PVjdQL0tqc0tGT3JtMDdmbkQ2UTRt?=
 =?utf-8?Q?kfTuBbl5l1zZ05Ds=3D?=
X-Exchange-RoutingPolicyChecked: WJzqD1C07wo/6AurBa+awXDKvKG88Lx3GsLV293yKn1rh7vUo45qnSfPboluCR48AiLwCQTAhscrp/W3a2LXQv4HXwV0PmvXdwB8KdIocA59sF4Ez5yM+DtuNqleuPndnT60XR4v/+dq8RHAG2L1Jb5p8CnId3V72Ds7dhM9yaeZgNdVKrubHrxBelxe6gZ11i/fy5WscYNH73uo+imZaMImsBi7l9oq87dScYKqW13D0NsLdo590kCD2y8K/wOGTb1EhFeCLY2UJ8BiWqIe3Ues+RdaP+NXG/DSRFJHldMVwPO8Hzc9JLCZv4p1WADaalY8HAqJ7FxL6uoActiX7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cb4761-3565-4d41-2354-08dec1bcaffe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 22:08:48.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v62TyKzYyk6HMD4PcwT9KIt2n/Qejkqe/ZHzU/GyqWpmdzzJvog6a2pQ3U46oK657QPKsGwuZiN0K2aq35JPfOns/Mes69Qly30zq4vlDmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB909287
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294942-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0124063B842

On 6/3/2026 2:08 PM, Jakub Kicinski wrote:
> Turns out Python YAML defaults to a pure Python loader for YAML
> files which is a lot slower than the C loader (using libyaml).
> Try to use the C one whenever possible.
> 
> The avg time to run:
>   $ tools/net/ynl/pyynl/cli.py --family tc --no-schema
> drops from 300+ ms to 115 ms with this change (40 samples).
> 
> We could drop the load time further to 85 ms if we "compiled"
> the specs to JSON. Slightly tricky parts are that we don't
> currently install the specs at all on make install, so it's
> unclear where to put the conversion. Also JSON has questionable
> support for comments and we need an SPDX line.
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> ---
>  tools/net/ynl/pyynl/lib/nlspec.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
> index fcffeb5b7ba3..0469a0e270d0 100644
> --- a/tools/net/ynl/pyynl/lib/nlspec.py
> +++ b/tools/net/ynl/pyynl/lib/nlspec.py
> @@ -439,6 +439,11 @@ import yaml as pyyaml
>      # To be loaded dynamically as needed
>      jsonschema = None
>  
> +    try:
> +        _yaml_loader = pyyaml.CSafeLoader
> +    except AttributeError:
> +        _yaml_loader = pyyaml.SafeLoader
> +
>      def __init__(self, spec_path, schema_path=None, exclude_ops=None):
>          with open(spec_path, "r", encoding='utf-8') as stream:
>              prefix = '# SPDX-License-Identifier: '
> @@ -448,7 +453,7 @@ import yaml as pyyaml
>              self.license = first[len(prefix):]
>  
>              stream.seek(0)
> -            spec = pyyaml.safe_load(stream)
> +            spec = pyyaml.load(stream, Loader=self._yaml_loader)
>  
Hmm. I was a bit confused at first by the switch from safe_load to
load.. but we're passing Loader as _yaml_loader which will either be
CSafeLoader *or* the default SafeLoader, so we'll get the appropriate
loader equivalent to what safe_load would have done, so there's no
change. Ok

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>          self.fixed_header = None
>          self._resolution_list = []
> @@ -464,7 +469,7 @@ import yaml as pyyaml
>              schema_path = os.path.dirname(os.path.dirname(spec_path)) + f'/{self.proto}.yaml'
>          if schema_path:
>              with open(schema_path, "r", encoding='utf-8') as stream:
> -                schema = pyyaml.safe_load(stream)
> +                schema = pyyaml.load(stream, Loader=self._yaml_loader)
>  
>              if SpecFamily.jsonschema is None:
>                  SpecFamily.jsonschema = importlib.import_module("jsonschema")


