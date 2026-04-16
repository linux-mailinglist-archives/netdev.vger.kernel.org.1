Return-Path: <netdev+bounces-278914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CzEApJd4GkcfgAAu9opvQ
	(envelope-from <netdev+bounces-278914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:54:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888040A186
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B8983009389
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279527AC4C;
	Thu, 16 Apr 2026 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuP+c+uD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E32F8BC3;
	Thu, 16 Apr 2026 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311689; cv=fail; b=uoK/mwuVVVd65xj7f6lZR04mK1V0sGVRZB/kYjukJ+LJhcNbs9nZQHljI52kUB39XLCF9aqp2MmkaVgJ1JUWk4gC//yFpapo6tu/ZoRw5VFsUFDcMqFOE8i55M2MN+AjszC4kwBEqA/qhV7GGFZqkz9OIK6p9U0sGhxyhGQuI0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311689; c=relaxed/simple;
	bh=KCp48touOvhhGtj5zVSmtk7NdOtWp88H+43G2Rey8zs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GoOrT+FFklW+3FPgboC2lhTwmm3pM5AkUwJUQOfiUDkkINqdNCvsiwKhBk/eTs3oNahrpBQalw7rZhoRdNg9jNb4tSBpNbETyVS5eh+qU3EWywcM/EuKxunyZYPQWr02Q5ynBell1ezuwGasbYHqRpoDr7+AQK8V+goACU03hSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuP+c+uD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776311688; x=1807847688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KCp48touOvhhGtj5zVSmtk7NdOtWp88H+43G2Rey8zs=;
  b=YuP+c+uDXn17TDfu92qdUuHO0egpvUuYANTkELQUpH89YOBoRflreFFw
   nScUh8wnOkLfViilcNwN4JEjREJlCt/a8eE1IFeNVa3ax5cX1uFfIbtkt
   j85Zfzme/DCWZtrOPyF2XOZ5rq/McOd1ZPcJ5o+qQEZE/UlxL+/wQlwYG
   iBeGxBLZzHVj35Hvldz9J/3wWNl8Lmb9C9/RZfnq2lMvh2A3kQZGnmeOZ
   QvEk3tp4TpcadeqJ2zUuCvtsJNz9BlBwDxnwNIta0cGeyYoo64YRD0z4c
   C4t8ChukD6+A4pgNqXIqSXnevIHHrcmbY0swdNDjeZ7qbNWwPr/1+1fBo
   w==;
X-CSE-ConnectionGUID: 6W9uiykaR5GdMNLyDbh7LQ==
X-CSE-MsgGUID: MUvmVZ0ZT+SigTRwxDY2bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88000366"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88000366"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 20:54:48 -0700
X-CSE-ConnectionGUID: CM49DsgjQy608mUD4eMC7w==
X-CSE-MsgGUID: sGyPi4GxTU60T93MmVojQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227456665"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 20:54:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 20:54:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 20:54:47 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 20:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNLDpwbLBPVEsrf9pSjGc8BrdjkJ0T/NOB6EVn6YyoUR0lbCuU1VimU3SH5WzYk2J62YSgQTrz9dCMvv9Or7AO52OwAfsch+nF8xCubatQBz83L/wD8yLRxUgijlx2QdKZHblS6hSHlMdsx96VV44v5NOAhH40djB3oup4isBJri0djN36MaoneHtBZh8v3UqMpdupQyF274JJZxpR8zvFPoKULvnxuofOVvqyv7dLDoiSeyN1owxPwkfhOfp5QpSmm/Q9IJxpHD+sdGzOvA/i0ODYL6wwlqao4lhRaJDQXZJAC9JV1JVzSGvpTY8oR2zQggEbPDsn0SIM+3Y/L+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VboUehOG6hLjjyR6LOY5VWBmDR1aTtjjLHHt+JrSJus=;
 b=ESiJpUAT50Yk1raEmIkfJEb7v45oJe1GUTnQKHY3ISOWGn98OCz81KBchRo5WUpTIh1ykEp6/bjskUPYexaFw49BvKjYN3ee4ku8QBqTXu1inIX5HpmSKDQ6V7UeyKLAjG34ZJVINiebyJDX4giGb/Hyw3oXV/xL5isxdOX1miFa2tTkTX1nBXRBYIgtT21UYvd5DH5mLvGFArVW3jDwpjf6eXvdaoJgxBBqmvkHr/LV9avQQUmf2K4GUilDNSkxEhJ+/JAL7cCxIGzB145IA5636MtxnlTIUPiiigX4D23x/peTu1Wt8V8eA2ZAoXFCWD42f7z1aLnoxV9ypyuqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8809.namprd11.prod.outlook.com (2603:10b6:806:46a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:54:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 03:54:44 +0000
Message-ID: <b2735cbf-34ac-4ad8-b524-2aa0f57511f8@intel.com>
Date: Thu, 16 Apr 2026 05:54:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] bnge: remove unsupported backing store type
To: Vikas Gupta <vikas.gupta@broadcom.com>, <dharmender.garg@broadcom.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsrama-krishna.nemani@broadcom.com>, <bhargava.marreddy@broadcom.com>,
	<rajashekar.hudumula@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<rahul-rg.gupta@broadcom.com>
References: <20260415151621.1104956-1-vikas.gupta@broadcom.com>
 <20260415151621.1104956-3-vikas.gupta@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260415151621.1104956-3-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2cbca0-25fe-4706-bf51-08de9b6be4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R9EcRAazrhUcWDE0ozvawfx4x7vnSlClGo0lenSnj+bFjB+co17QjaaOZjdv9kZVOKTwBUmIhoPattck+djduX2vjfz1L24/olx4fwQ9bxKpKpTmPjGpSJa9mKmg9klbAJtVDWyGZj/w3v3MCc3xm61dzrW8gJkyu9ZKU2BqvBVM6Gjb8F2zjiY4CtDNuKGq+FhSFSAjIZ4tY3R5GQlvQnu+yF7NnnKlx147FEQi7X2W/2FUokQtzJobYgNoCzzG/nGIR+8iR1CjO5oK0xac56XCwwigsdhQtCnj96JrVxzVgKqknB1A1XqGlu4X0+rlWqqz4YuTRslrKRANHmt7/7HwVFh2vBCpyfWXxmh7YY2bQUzY61FwKrhTugctn+Fgb906WQBunmgqTG4F5EViMZ8vWigHlt2jvfdmZnSMx6JMb0Dn8xhOLWn6sMBZyNr+wKSSohQBEBOX2wk3e/RRV5zho1xTvEdBrhP7I9pmB+9Ezh6QQ5Pb9OAu/DZFM82X1vY8Vgf7epYPzqQwm6DP4gesZuoQ22jpg4nCCUvXU33+IfMDdowWSBFT9xz0OGfK6whyHi4FXMMt5Mncqr5b5FnXdsZPU/7pjCERinh9muXvvh5HAM9F5aLvS8yicE4srsVb+zLkeLSU28trPsAuV3q88hRjR8OPg9y4X7VYy3V89bDY9r9NzMAH7NRTNMoOgtxG9Lyr0OTQY/mR+wStgupJwH/0WO6aSJBiX7+gu0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNCcUZSdVlaTHFPall3Q1psK1NCN09OZWQ0TURGdHNaUVdFVDcyYWllcmRS?=
 =?utf-8?B?UTVSa3o3d0xqNGhVT01LY0M0OWo1c0F4NWo4NGRRVjM4ZVMvMUJiY3VTbXpK?=
 =?utf-8?B?Q3d2Q0h3YmxySFpqa2lBdmtLUnlrZG1DVC81eUM3bnQ4UGxhby80bDFHcjlm?=
 =?utf-8?B?dFdDdDE0S1MxQnhMQmlyQjlWbzlHcmdvelp0aDZpNDZTMm9sN2IrV0VEdkFH?=
 =?utf-8?B?SzFra2NLQ1JnVjNra0NLR2QzZm9RdzI4UFhnWHZQSDNkOTNVVXYxRFlhTGk5?=
 =?utf-8?B?TmMxYnQycXBBZkk2dGpsWlVPUmw5enhreTA0ZzhISWNyam5oVURxWUxYUWIx?=
 =?utf-8?B?UEVYanZQZFRhTkdrNFh6T21sSjJuWmltSTRIZE5SRU9lMmJYYnpvMDhHSE9y?=
 =?utf-8?B?ejFyNXE2eXc2WmlCOUd4YWU4N0dGcERCRmNRVjg5UWFBUzFNUlJnbmxHT0RV?=
 =?utf-8?B?RzA4a1JzQW55czZ3MUUwZ2xlVy9VNnF0dHBwVDZPUUtHenQ5RDhMcHRmbkFy?=
 =?utf-8?B?Ym5FaWxVSEhHeVZ6Y0FPNXJMaE5sMENleVZjL3RVWWlFcE54VTU1d2w3bFFi?=
 =?utf-8?B?SlY5bFZmVmNjVmwxY2Q5QVNTbXlnNkI2QVZMZ205M3U5NGFmZklaeGJ0OTVu?=
 =?utf-8?B?aCtadGlCS09uTzh4VEQwTjNPdm5aNkRXdUlULzZiV3R3ZE5rTldSRDM1S3NO?=
 =?utf-8?B?dzJTSkFNYnZYYTZzN3NucGQ5N2Y3WGFicE1GZlltQkNoMWhCZ29iMlFwNVNC?=
 =?utf-8?B?ZU5QOWVJN0kzVGYwaEUyU0xIdkU1d2MrVEEzdWU2eTlWSjMwTmIveFA1Zi9O?=
 =?utf-8?B?Y3ZTd3U1L3Q5QnZyVmxYT2VITHdDdWl0U0dsQVZTYnkzZWY3NnpFdWdlempQ?=
 =?utf-8?B?YnNBcWN6ODNSbGZHWGVQNEZWbGw4VGJMKytpWWpTb0FxTmtwVzMxaXE2UWxq?=
 =?utf-8?B?Yit2YTZPL1pNMFgrNllyckdGdmY0cE43OUpEdXJGSXJ1c255RWJpa1htV1Q3?=
 =?utf-8?B?MUJPd3pndElMdytWYXA2VGFJWFVUQjlmYUFmemVJNDlrWEtSV1UvUHNoVE1G?=
 =?utf-8?B?N2t0b1IyWklSN2xqZUJMd3lLeXB2d29vNWN2Y0h6VC9MTGFpWkVoUkp5RkNS?=
 =?utf-8?B?eHIrdlUvaUlBNmNKVlZDc0szWUhmOEtvS3pJVER3MW9xUWMwSVkvamZ3aEZt?=
 =?utf-8?B?TFNVYVVRaXE0aWxWTmZDNjVJNWhxRm50WHNNK1RScDEvMGlFU1dUUmg5YW5F?=
 =?utf-8?B?dWljeGIycFR5emZEM01zZjF4a2lIOEtQNCtSYjA3c01hS0YyVWJZZzA4THJl?=
 =?utf-8?B?eHRCdGVlajFuL0p4VjZQeDFISDUzK3AwWCtYQ3dOeVZNeUpWN2I0UklxZisw?=
 =?utf-8?B?dlN5YzJUVU01enpBRDV3SU42cEJnYkdHRTZCcm0wb1hjajFFc0lPZUo4bVpQ?=
 =?utf-8?B?ZGZPZXpaZ3Rha2xoSDFWT1FJYkU1a1huRHRNSXNxZ3FqOE03Ym03enFkdTUv?=
 =?utf-8?B?YmwzMVVpSjIzNkVMWjBNRGs2aktTMG1hSU0ySFpHdi9OVkp0VU5zMzBIcGRD?=
 =?utf-8?B?YVhXNE1pL3RPc01FdklkWG1vdTM5bnp3OGFPRXppWU9hSkRBTWVyeTh2TmdD?=
 =?utf-8?B?azVldkFnRFY0N01JT1lxZ3NNNExOQk9iTXFxdStvaDJJQWJQWU9yRkwzVEFJ?=
 =?utf-8?B?eHNuS29aUXluS1htNG9QcFZOYTFJZ0FVb3RkZ3d2U0dRL1IxRERaaG1sdkFw?=
 =?utf-8?B?em8xbUlYZHJ6S2NpeG1tYjUrUDdZdU1GSVgvTGZ5RE1Edi9ZZkpIMFBlSzc4?=
 =?utf-8?B?anVNZWFLY3BVWG5YQTlXU1lQT1dKdFZ2RWpXaVhjZGprU2tGdmNLOW9LRFhW?=
 =?utf-8?B?UUt6bjRucGZ2S0FvRGY2TlppRzFzYjk2Z2VCT0NaelBBZUJVOW5aYnY5Vzda?=
 =?utf-8?B?WmZWSXIwbkJhTkwyT056VFB6VG9iMmljdG52N1R5Ym5ieVdqb21HMjJPOGxY?=
 =?utf-8?B?K1hPdGE5OUZlcjRLcC9nMEZSQytqSXVxQTlXUVFqT1B5V2poYkFIN3NXbzJa?=
 =?utf-8?B?NU9NczBvL1NzRERWbjB3MkNwai8wK3YyZGxEVjRGZmNIWE5yOTl2WEhRSTNh?=
 =?utf-8?B?VzFZNXVnZ0UwTCtuVzRHL0ROUGtJYldvTXpVSkZKMCtrWGlkM01EMlp5ZTdr?=
 =?utf-8?B?OHJwSCtXNmtlMjRyTmJabUZqbW1BRFllbmlXcStGR2RsQ0pLdldMeis2WXFt?=
 =?utf-8?B?R2NCcFlHbXEya0M2ajRxVGVPdCsyMEpsNVNURzA1aVJRMG5GY2Y4Y3pSNGVz?=
 =?utf-8?B?Yzd3ZkVMbFQxRFd0UGh5QmFuS2luQW5ET1FMejBBSE9TcFNBOStremdUVkpo?=
 =?utf-8?Q?QP88JevMr5SgnE9Q=3D?=
X-Exchange-RoutingPolicyChecked: Id0TuQvS//TrHF4Dipg8mWMmxFvpcAaBOGEJG4l5HxLR8/xXSGAN9Mty+VAyTqGKIvRGOsPtF9olSaI9kZBK80acs8Kp5YyAV7nHj610ceqtqTDBeKMMTkvu3g8HMQOJsKpSUF2yIXNYFWgsxnGcBIr5UuDKJQ0mOYJXjTKowCu3XRUzuZb5nAKuIlTTT8HXkWyhj3b2lMXstnnWt0TShjn8OP/hBrilx5KVCHaIyR52J9M7jgDRzTM3pbGcr3veeUdMe77WCIl2Pc0Zm4gDvpqsNslyO0wRQg+vC/SAcxvGL4zBfY/It6rTJaLDlMpqMvBBBNDAHu7H+sxPtfiJfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2cbca0-25fe-4706-bf51-08de9b6be4e7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:54:43.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv6FY2N8Zonx5CPXbT+ZljgclNAQoDVmCPSntqtZyJKJZymPZshnhkU65zfDZjzPD4tyQLhVQj5VpvGybfqRil70vZD0RG49UUZl/mLkW3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8809
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278914-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3888040A186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 17:16, Vikas Gupta wrote:
> The backing store type, BNGE_CTX_MRAV, is not applicable in Thor Ultra
> devices. Remove it from the backing store configuration, as the firmware

I guess the removed code was needed for previous devices, what is the
impact for them?

> will not populate entities in this backing store type, due to which the
> driver load fails.
> 
> Fixes: 29c5b358f385 ("bng_en: Add backing store support")
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
> index 94f15e08a88c..b066ee887a09 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
> @@ -324,7 +324,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
>   	u32 l2_qps, qp1_qps, max_qps;
>   	u32 ena, entries_sp, entries;
>   	u32 srqs, max_srqs, min;
> -	u32 num_mr, num_ah;
>   	u32 extra_srqs = 0;
>   	u32 extra_qps = 0;
>   	u32 fast_qpmd_qps;
> @@ -390,21 +389,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
>   	if (!bnge_is_roce_en(bd))
>   		goto skip_rdma;
>   
> -	ctxm = &ctx->ctx_arr[BNGE_CTX_MRAV];
> -	/* 128K extra is needed to accommodate static AH context
> -	 * allocation by f/w.
> -	 */
> -	num_mr = min_t(u32, ctxm->max_entries / 2, 1024 * 256);
> -	num_ah = min_t(u32, num_mr, 1024 * 128);
> -	ctxm->split_entry_cnt = BNGE_CTX_MRAV_AV_SPLIT_ENTRY + 1;
> -	if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
> -		ctxm->mrav_av_entries = num_ah;
> -
> -	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, num_mr + num_ah, 2);
> -	if (rc)
> -		return rc;
> -	ena |= FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
> -
>   	ctxm = &ctx->ctx_arr[BNGE_CTX_TIM];
>   	rc = bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra_qps, 1);
>   	if (rc)


