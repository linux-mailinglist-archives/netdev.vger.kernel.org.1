Return-Path: <netdev+bounces-156411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45CA06501
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EA63A280C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535020125C;
	Wed,  8 Jan 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF6FKV1f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077801A7045
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736362949; cv=fail; b=g+24HQLpzihM7PtS5iWo1q4466qR2UcJ/3ftQFkxkM7b+4Yq1HwmfkrNzomgmnjlM2zLKAPrHP6It9vUwskeRT+Ya0on5IGLlideSJGAJ46PS84w74lI1Z6ybWPkjHG1ftWNCW1OaOY4w/iFGjkn5UJYj2wr1nX2/WEWWTwSJcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736362949; c=relaxed/simple;
	bh=x7qSLsWG3Om4t2TB+Rr8iIJs9PkUA29+SDoC+ZZc9T0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiXdbLfr0ysZzin96sHgC/JvrMtlHnpLwvp5d1Fb++tFZdEpVtuZqubJbZQRRtJJUnm5lO5Uerh9znYfAXNura6u2cVlISAx8ITtnXwtkg/b5HGdBcTWtH6WXyDEUi+/Cji9VnetbyHcky1vUV2JQ7jzqTky4j4RWBpL3Ez7MOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF6FKV1f; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736362948; x=1767898948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7qSLsWG3Om4t2TB+Rr8iIJs9PkUA29+SDoC+ZZc9T0=;
  b=UF6FKV1fD8c5tVo2P4lUtiFxEDOW/ohmXT/34CjWLoQyH1kLkJLDMppg
   pPjfdKuANnYd3RiykVX4hTOP+hUy3d9ZDbjC/33gnI3wARUjXA4F1mUQU
   O8P40sEn5alZ05uKvt7/TdpOCBZWncBgYkW8TMU2RfDdUn7oTQWer5Ihx
   kVI++1GMXpTM6hpWWElTkIBruN7mYYiEiDkFAdVKCg9Lx0dJIPEW6lpfd
   8k8DPBXufcZs78O4Iw3R0ojtn8S0U6JDsYewxR+doTHJVc5HSChNypWG6
   e288F+vdvHk+4JSA/eTYB3RiyZbR44X+kNtPe9BREPtZraDUUjcz6Q5pU
   g==;
X-CSE-ConnectionGUID: ncmd98TMS/qteN4RbK8dmg==
X-CSE-MsgGUID: JWq5u7mNTPOoGtS27CsfAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36505045"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="36505045"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 11:02:25 -0800
X-CSE-ConnectionGUID: 0GiM6ze3S5COLZ3iE/21Bw==
X-CSE-MsgGUID: g8TQpSZ7SmOwAIH2V/dvVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="108175627"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 11:02:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 11:02:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 11:02:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 11:02:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npF8O+YRD/AkDcIUa6VGWhFpIBhJ9IEIquYKvNCDovM2UpyWe0gCmBRn63NSpz5JQVsbe1IV6DqOWbWHwnARJly5KEu6hFbqXk5bdV2SSVpPuSfjiH2g4HSq0db41ibLvJ6U08CxiKvWIkQh/RlbGsoHGoEmkK2cOEdxgFLIZCFLMnvWSTJhSCzvrVd3N0E0h9kUBg2oIeg5g8VDpkdDX8ceAgONdARX9Q26y617+at2yMXAvzz3SGKOVE7HmOzO7xVcUyshlfeJYIhXFcvxjXlIWhLSGKrYkxm710xf9WwtSi6S+6kFSIaxDWC5hOHWuNkEwHoarFOThWr7CoLAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRu7ChAPVwSzQmPj+AX1r9tJc6UWOvykqT5slimHx1I=;
 b=pbgzPC/4j364+WSQwtAfu4X0xwkN3DCpdj071858fLvdXS2rmJRMAaT59VTgvuKUkyhXwXBrpFIay3XGSKZdXBBc0TaXKs/RR1WSw9UYF1adT1TNfQQH+oYSC0jrZHO8KMH/4ZiFhn3ZBEs5PNgTA1AzVt7Dd+ZEVbRamKSL15rdCuoJhEbRgIr7vlc2lV+3wMnfMSsUfF6azDLHrw1Ixh+0wFMssoqjBxGb5FgwZJg7Ld8IO2LByKQ+fjnlT19qnXiRF4ioTgkfLm56CcgJ+neizQZuxS4+97hfo+AXc38t6cDiTx92OolpBJ+X6UtzknSJRAioUOK8TqdK4SCATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 19:01:56 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 19:01:56 +0000
Message-ID: <dd769092-5d9c-4c73-ac38-4d71492588ba@intel.com>
Date: Wed, 8 Jan 2025 11:01:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates 2025-01-06 (igb, igc, ixgbe, ixgbevf, i40e, fm10k)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
 <20250107181320.1e006718@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250107181320.1e006718@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: b4afa88d-fa11-497c-8e38-08dd3016ebd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWdteE1CNS9xZlBacDB6NFFYTzE1U2xINzZhYzhrb2hFSDVQM2VZampoWER2?=
 =?utf-8?B?VEQ3Qk13RTU1UVRkK1drQ3BheTVBc1E4cUhQd2VFc1ZwWHozMFhpWWVBaC8x?=
 =?utf-8?B?am1IT08zenpTMUxzY1BQajBtZytLMlBWakU2aCtYR3NpQW0yY3BoTVBFWFly?=
 =?utf-8?B?N1JNbmlrakdXekFhNkpoVUhYVFlXaHNxQzFYWmZ5Ynh1dXNOK2U1cmdpRjZX?=
 =?utf-8?B?TGYzWUY1K1NxMGp6MGE2cGhvQ2VaeDJSZUQva3FTQlJURUdLVWVxcGZzMUF5?=
 =?utf-8?B?b1Vtdjd4RXo1WnlPekJiMHZYczdpZ05mTFJ5Z3BHNDE4YlNlR2JMcU9vUTZZ?=
 =?utf-8?B?OUJxazJVRXlPZ0ExNk5UcFVkYnQ3MHMyaUY4ZkF1WTdRQjdlR3hXc3ZRTWpn?=
 =?utf-8?B?cmdyMXZncmtueTlUUnhwSzFsdlZnNUFKWGVJWTl4R1dJem0xY2NQRjlNekdt?=
 =?utf-8?B?TUFVb0g0S2JQUm15WUw0SDBHdnd6bFF0M3hJQWhtY2JSVTVEMnZoZ2pVcXM0?=
 =?utf-8?B?SVErKzJXUTVVRVBlYWJBRXVuQ1pCWCt3b3hLdGtUdGY3SHMraHgzQ0xvSk1Q?=
 =?utf-8?B?Z3d6MFFMWDVjWkpXdVF0Smp5ZlpBdVk2dXJVSUVueE05WWxBYTJPcEphbzkv?=
 =?utf-8?B?a1BjR3ZVbEswSkNLeWt2MEJTemw5Uno2NVd6MmRuNTltZDZyeTVGdVRRc25V?=
 =?utf-8?B?RUNWSjYxcG9pMGJqcWdYVnZJbFIrY3Joc2txK29qTzhwM0FUbkpMU2wrYUJi?=
 =?utf-8?B?ZWRBZVNJWEpEOHI4ZjFpeFgvSUVUN05rd3dmdGpwN1FpVHJsYUdRbDgydVo3?=
 =?utf-8?B?ckxDbGhJbXB5Vmw5QmhMQklqTlNtTEozUEx0ZEFuWFg4SEVWb05hT2h1d1VG?=
 =?utf-8?B?RjBBcDRkTndRdzlSbXIxV3oyQU9sMHBNQXRTdVZhSWZ6ODhGMzVqUTdmU3Jl?=
 =?utf-8?B?YmZpSWZTV1Izd3lGK1BqTEh0dE14RGljLzlKYjZBWmVNQUJwNVZKQUJ5N2M3?=
 =?utf-8?B?L2IwVWdaUmVKTGNkVlBxcU9wUHVlc0RzSzJHdkxjVm5OaFJRamI2bzc1NHZV?=
 =?utf-8?B?dlU5YktDZFdTdld4dFZHU0c5ajVIdWJuRndwSS9JcEpmZHFUZlZTWE5mb0o0?=
 =?utf-8?B?YXVhOEp3TXB1eXBxcUM0Q2lpOWNXeUZpOEY4bzFSaWt0bU5OS1dSQk1wNGJO?=
 =?utf-8?B?UXVMNWhUeGpxWC9IdU10dFV1cDJMZGZiU0toOTQ5NDFNcEtibzl2c3hOL0lj?=
 =?utf-8?B?Q3AxM01nNC80YTJjeG4xSUVvTEdqQnVnRGVHR0d2WTcyVTR2eGtlaUxiSzlL?=
 =?utf-8?B?S1YxUUtOcjdJaEdiZUxEK1ZSMTNXOXlpdjdad3VsTkxEeXJ3YVl1NitGTlJ5?=
 =?utf-8?B?S2liOFozWEdDUElsbHYxMWdGWkFkSkhudXJieVRiTk5SVzhHMVBwbVNSVEpI?=
 =?utf-8?B?UlZpNnVpRGgzOGxIUk54ZlFYL3hxdDNYNGpsZUR6cUdSV2t3Ry9kQkV6aWxR?=
 =?utf-8?B?aVlNRWx2QzdmdVFWVjl4ZGZ4UVM2V2dFVUdGQklEL2p5eUptWC96czlPTW04?=
 =?utf-8?B?S3VlcEVsTUdhRVpzTTR0eTl4N3llbmVpMGQycEgzWm1UbzduN0xyUm5JWmN1?=
 =?utf-8?B?VWpOZ3owVkxCRFBBWDA5UE5vcGUyUEo1OG1PalNIZjZUWmYxdzNuSElqK1d0?=
 =?utf-8?B?MVhhaUNKbnVTaHlrc3N6VG9DL2NrSHdzQnlJQ0U3eGlaaE1tSUhOeGdRYzJu?=
 =?utf-8?B?dm1BZ2d2ZVpkUksySWRoMmpvNU8zb3d6QzFKbE5ra3ZyK0JCeU9leFEvUE1Q?=
 =?utf-8?B?L0tYTmJLbkZGaWp4Yk1QczA0ZDBRRUhlaVNaQ0wvMUNaa2xna2Y0Z1VOQmJ5?=
 =?utf-8?Q?zmgqeUTFKlpoy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExOMEVvZDczVFN2SUVneUlYOXZwcXVyMHBXekxoY3AyaGg1aWVYT2lRY2xO?=
 =?utf-8?B?VUhpNGtmV3pXSFl2MFY0ZmRhc2oyWTFJUUZZaFFlNW95NGpyek5xOUFQNHB2?=
 =?utf-8?B?MmdYNHBVTUh5RWZ0WnUxYy9lekJ4SzVNTEtaajR1djBWUmhhWVI0cFlTWnFh?=
 =?utf-8?B?N3VCVllYTldjV0FrbHpCWGk3RnNrQXVtV3htOHB4UnkzZHFTYkN0WVlZMGh2?=
 =?utf-8?B?UU9yTDdQdHZjQUJDVzcvK2VDZ2U0d0NCWUNENGdJTDFCV0IxR0JHRDg0UjZP?=
 =?utf-8?B?NTdwb2ZHTjlSb1BxYnJhSkl6bG9xSkMwWXpvcFRPQ3ZQZ0VlTXBJVURuak5B?=
 =?utf-8?B?MjRxZk4vanRkdWQ3SllXU3BrZGRpWjUwWFZHOXEvVjdrTXN0QlhqZTFQTnhC?=
 =?utf-8?B?OEZLa051K0VsRzdLTjN0Q01zR1pMVHlEb2xSWU9FME5NczBOd0ZnUEl5K3Q3?=
 =?utf-8?B?K0h3MS9LYXg4aUFXdnhVeXFqcGVUN2VublhIcXM4MGsxUjJ5Yk1XRXlaR2xJ?=
 =?utf-8?B?QjBLRTQ3a3hoRFhMR2Q2ZVNQZWI1cmFrbVBTbERxcnlnMnU3UWJhMW44TVdO?=
 =?utf-8?B?d0tTb0lmTWo2eUJFRGNUL09pNUN3OXlmUGd1dmxZVjMwZ2RSUkdNeHFMRDR1?=
 =?utf-8?B?UDVDcUR3d3hKU0w1bUxPL0xEVHRvbEs4WmZOLzdHNnN1TktJZk00Z0VZUXVz?=
 =?utf-8?B?S3ZZSkRkRFNRcnA0UFkvMllubWxKUXNpMU12TmRLdmxKVVNuZ0tWQnZiUmVp?=
 =?utf-8?B?WU9PNUtZTUl4dnp5T0trTlByR0lNd1dXZTNMM0tpSC9EZE95cFFGQmZoanhs?=
 =?utf-8?B?OWNQdWV3Ykp4djNEOTRnL3lNblh6MTdPaGNRemZaLy9QRk5nN1Jnek53Qmcx?=
 =?utf-8?B?KzhPS3Q0cjMyNTZyNlJEaWNiZjdVb1k2cXgrUUthUDk2MmwzSDgyZEpKMXcx?=
 =?utf-8?B?ZkNmTmNrOGx0T29RU09HTWJyOU9VYjdzSWJYWFZwb3BpRWIxUkpwVjBsUitI?=
 =?utf-8?B?ak16aW9yV2pqR1h2ZStuTkFLZzQzaTh6OEg0OXJlN1YrWkR0ZUVBYlNGWDBN?=
 =?utf-8?B?Tkt5UU9uUEFkby9xaHFGd0FicjJnMWNqVnFXK240RldsK2lWVTJMekRod0I1?=
 =?utf-8?B?ajdOUC90UGo2RjhFa3NGZzNRcUJ6Mm8zSTZyNkFSczh1Y2tYS00wbXkvWEty?=
 =?utf-8?B?cFdJTjN1OC9lcGh2UU1uTDhuN05yNVJQQmZlOFRHWjF5SGQ1N2toQzZnTTNV?=
 =?utf-8?B?QVVHRFdDZmk0ODlndlFPS1BwSjR3ZXFyVVhSRTJGWFBIVlJSbWR4YzE0YVRF?=
 =?utf-8?B?NTNYYWs1a0ZwR3B0Vk1sV1RyNTg5YWtucDZjNkJNOGZNQm90TjlIamZlTGNs?=
 =?utf-8?B?aXNOdVJGM2E2TVc5YXI5YXBpbCs4T0h6MWpjS2U2c1FzSzRyNTdpOE1RSXc3?=
 =?utf-8?B?SW00QVdmV1BhWlArWE9iZlBKVzdPTHRKMzRmM3RwbDB5ckJ6QkJuMWlYaGp4?=
 =?utf-8?B?bnBQZXlxVHFWYzFpcUVjOUt0VGZ5cTNpb2FINkEvMjlkUUszTXJTbUtVNm85?=
 =?utf-8?B?aTlsUS90cGV2MnlxRzZwb2c2MVQ2MEN0elBCZm55V0NwL0V3S0ZmTlJ3cTZG?=
 =?utf-8?B?d0ZpV2U4NWhiR29aTVJjWlp5c1hUM3dEd1ZCbGd4ejBhNlNwMmU4czdvMjAv?=
 =?utf-8?B?aHBKa2RLRjFSeFVVRUdDcVN5eHROQlB2SGpZRUdVM0Y2V3VsSzRXNG9vdFNy?=
 =?utf-8?B?Q010NEt5b1lYU2s4UnBkbmpLZE9ZT3FRaG1GTzNTcE12MXhVdmtGdVcxK1Zk?=
 =?utf-8?B?VU5vTm5DTUh6VzFpYUd6TzJSaWxYaHl4bWx3MlQwbnhTZjA2MTh4TnBMWWha?=
 =?utf-8?B?ajMzdElvY3IxcjRtTWNLcHNJSyt2MjdRNXptYWhvTmo2Und6Q3FHZy9ucXc3?=
 =?utf-8?B?b01QZkFHQ25rMmtuMHNjRExxVzBFZHNqMjhST1A0K3hENFlJVDdnVzczcjlQ?=
 =?utf-8?B?ZVZTUkVqeWJRUVQ5UThKeE1Dc3REOHF0MTZhSWpOQnZWcWdITm9MaTY2S1JU?=
 =?utf-8?B?aWhJZWh2d3BhRnY3U014NUF2ZzJkUEpaMWhqekRKbDNUbjNpc2E3SDhHdjFC?=
 =?utf-8?B?eldjMFlJZkpjWE1VS0NleUpmdFFPeEY1dTJVMzVKSnBXNWtLRmtieUdaQ1Fx?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4afa88d-fa11-497c-8e38-08dd3016ebd8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 19:01:56.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIWYlucQ+hMeL6fSkmqCh4ZrC7Kea/YdpeU4e3UHWGPIOUOgMbJveu7LIObEcZIv+upFhQlCjFTPM0BtAHw56a7uOT5y9PP1ydoqQjZrLFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com



On 1/7/2025 6:13 PM, Jakub Kicinski wrote:
> On Mon,  6 Jan 2025 14:19:08 -0800 Tony Nguyen wrote:
>> Yue Haibing (4):
>>    igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
>>    igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
>>    ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
>>    ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()
> 
> I'm going to apply from the list, these don't need a fixes tag.

Thank you.

- Tony


