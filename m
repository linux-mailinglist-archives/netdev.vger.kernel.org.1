Return-Path: <netdev+bounces-198081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18846ADB317
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E1D18822F9
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AC3B1AB;
	Mon, 16 Jun 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuqDcrTi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC62D023;
	Mon, 16 Jun 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082842; cv=fail; b=smhtxOFFkJ+WM3Gtf6anh7p9Dg7098fS3PnuzJICgCs6txFXZIWP3duXcv1j8jSxj/XRqeSljYpVgfGJDKu8oquCn3SvSXlKJZ7qs+I4fdxTcK15nK3do/Kc6sW+VuuJ/AeYw9Wppsz5qqwNdD9grjQQCe+AaDgnlEX34alf/Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082842; c=relaxed/simple;
	bh=Ffa97LbuT9eHAnsN1tJWwcOAq+YtLI2kijrWp54DYOk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IuH5EWerAs+kO0n3pddSjn03ZU6QujOYQmPZlzngM1U1ZeSMnXZsBnsc7XmBfvvdCCOhP0DsMtq3+MJzfyaciEZYdrhkTdrI30TCIEjE+U959v2VcHKIC/tWOoDvOYtZgvG1fMCnXQRVfmsnuHnpk71r80xq0Vlz+cXAVZnHpng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuqDcrTi; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750082841; x=1781618841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ffa97LbuT9eHAnsN1tJWwcOAq+YtLI2kijrWp54DYOk=;
  b=EuqDcrTiz5YzDiolDWffaiV7HXONUNidVJxKPP542y9mYYcXuW4YJxVG
   hp4AzIV/BVkjT0+8sJ1AKzQmOVo0ugV95qID6PHD1W3jlQedLlcy077D0
   AKHRayCzmhuMbhIEfsMCFI+glcPLHCPeRfWfABx3IjDFE+3wIqkPx4Zyg
   54F2YRDejV29k+DaPkH1S4i8/wDF0ho3CwGeLJRw0Y8rql+NXv+j0yqhm
   3gWw6TSHJW1FFkll1H+GmpTnJj/SWW8VC7NJgN4ziOJhGh7+7D6wzUlOp
   kc1vJsARu9NZPazafaImcWhvr0Um7rtchYhzWXaRLtShjKQq4Jf5rRdcB
   A==;
X-CSE-ConnectionGUID: ZxLnFS9hTVmdTH5mKQuNZw==
X-CSE-MsgGUID: Phxve2NuSJu9uZkLPbu5Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62498717"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62498717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 07:07:20 -0700
X-CSE-ConnectionGUID: PBuIW0BZTyiQg8MRq3O2Xg==
X-CSE-MsgGUID: NK/yeyUhTaaWVLpUaWxQIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148947129"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 07:07:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 07:07:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 07:07:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 07:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB22/3NcYzy+atYXVV1MhvYshYZSLZgEthXSqGQl1nXNCyAcH74TchD4+2tafZjB07cpYUbEKyRdjO1JW60Dlxab92+zYTuxRsSgCrDg/UL+8JNyjIHVOTFAFpaZKZg0PQLHniIqcTlrFAP5uFfx1+7RaS4HiYPIUc9hDgI7kIrkYCWMeyICrzRmWZNF7rZqzKjQtdgVlr5IbACT8TQcaNfopABLwEZ5zD/Z3UEWLSAUytM8uOIz7CvlG/+9tvPQ8aWWKyy1mDSxen2TUFFEWmVaJoM7ux8KLqqj3vB2KDvtzQQ/9uQuYHhxkZCc1sfm43wY+tVZR90MWfFAwAjzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwCimtewUlBFMBlZB8g9yW1s/kn1zvxMVbdQE5raR1Y=;
 b=NLiDtVhnCc/h84bGEFAHRdcgvAUXziNPNvIRHxBZiJBSZ7SSH8/N3yB8jDnwm94XjTVo3a0ukvH8zbfRpzr+idUlEg4PU8mKPAtBLGlndlq6u/6AA65GwLxQSUW8azCZeSli2PEQMc4zXgIqx76KwoD3GX4cGTfHKGrYGtZVsAKUc7B8+ca8S0XkdGWD2EtsiTVhBO/KSQ8UGmNZyh5nK8vMZ+RGoqajmjXieKD6KOXlXtBy5ZbOIR9Gc5XKi0NOe1pnZv1cZPfg8jM/N+7dxVAI2ciHCdJQkqQ7W4zQrrHqBVcy5tfSDlI8VEwNedd/MLPCsVi7On5Wt3+Lw4VnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM3PPF5EA507B64.namprd11.prod.outlook.com (2603:10b6:f:fc00::f25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:06:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:06:55 +0000
Message-ID: <ecadea91-7406-49ff-a931-00c425a9790a@intel.com>
Date: Mon, 16 Jun 2025 16:06:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
To: Simon Horman <horms@kernel.org>, David Thompson <davthompson@nvidia.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <asmaa@nvidia.com>,
	<u.kleine-koenig@baylibre.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250613174228.1542237-1-davthompson@nvidia.com>
 <20250616135710.GA6918@horms.kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250616135710.GA6918@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM3PPF5EA507B64:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a65e618-3772-413c-1649-08ddacdf0ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c05HS0hQK012NTRBK1N2dEtGQjhFUXlJR2lLZUsxR0Jna3F2NUhQd2s3TGFu?=
 =?utf-8?B?VzRlT1JrdWdkbUZtYzZxZHhIcE9jcWhjQUJoc3gvZDdOWmt5a21JdWRTRmt5?=
 =?utf-8?B?WnZiTjgvTWJURkZlckRhalA3c1FwOTBxYXQ4NlVwYjU2Tm92azcyVzhSM2RS?=
 =?utf-8?B?cHk3WnI5VExkUzk0VkV0M3JwOHE0RkRPRW9SV0NmMmJiRE01RmR0YzhDKzNK?=
 =?utf-8?B?cDc3bGZpZWNMVVpYQjM4ODhVZFNxYWxydW5qYkNxTlR3eEVUWDNaZ09yMUNP?=
 =?utf-8?B?Wi8vRXNIMmNuT0E1a2R4R1BMVFpOZ1BqQlcxMWtyRlI3R0RUc0JzTzlRMzZy?=
 =?utf-8?B?TlRHdDVaeERDaXVLbmJ6dVdWeU10MUp0enJ6WklLVGkxNHkzdXp0cEw4NlM4?=
 =?utf-8?B?YkRuMExLSzA3WVFVbFRnam9mQXNhK1F4T3AwRUhoRjNPUCswVjdNeUhrU3do?=
 =?utf-8?B?dU9tYWJWTDc2TmpBN2VCNitpakhBU203aUJBOUEyVTlTVUZIRlF0aUlqY0pG?=
 =?utf-8?B?UktkL1lHNENiWFM0bi9tTzR6OTh5SHVLQVhCTkpxRlpmTmpRQ09VeEpFMmpI?=
 =?utf-8?B?SU9sVzVOVUd3R21QQ0tsTElFTmM1Z2J2SkhyR0VuME9WckkwN3RYbGFHYWpu?=
 =?utf-8?B?M0syMVllUEJOQ3BWblRPa2RKQ0N3RWtPenBMR2lGQVVhUTgwZkQyQWsyRkVr?=
 =?utf-8?B?VmtLSUh4dEVzVG40NUlnUldsLzF3emNPQUJYUm9kYmdUOHJNK0RRTHM1MGF2?=
 =?utf-8?B?eUIzU0JYZ0s1dDUvZ1g3UlNKZXFxQmVTZnl0VUIyeVQzLzNnT0tGdmxxVHBS?=
 =?utf-8?B?bUVFSzhmVnpkOXA5NnlMVzZzaDhXRkZiSjVEZy9Fb0wyMGJoWGVtSUxRQ215?=
 =?utf-8?B?VmRxOVorU3YrSU9WZmtLNlZUSEpuaGVhOTY5OTJ0SWprNDFJYkVOT01nVFVN?=
 =?utf-8?B?Z3JTTHJnOWx5ZTg0MkpaOVptdHcwTzZxbWp3VDZsbC9qdUdUNEZPTGZTVTdZ?=
 =?utf-8?B?M1NnUG93MkEyS0J2SEpNZzFqa1FlN2FMZnl1N2dQTCtEa2JsOFhpeGVuV2JW?=
 =?utf-8?B?NnY2STRlSWpqL3cwMDRXT3g2Rk9DcmdHKzdMb0xSODVDSWJXNEtSSjBxK3Vt?=
 =?utf-8?B?Tm05cHB4MCtSaitHN2l2RmVaVmZ2TXJEV2MvVEUyUHJKd2dHWTlxSHd0U3BM?=
 =?utf-8?B?TVZJV3k0a0JEdm8zYzRTSEtzZHBNd0krVFVFRjQzS05QWXludnEzSGN1ZHln?=
 =?utf-8?B?NnI1cnhEZVN4cGdtKzBGZnN3K3l2REh0NlJIZDRYT3Z5ZVBQVmdCcXpvdTNn?=
 =?utf-8?B?L21aeVpESG5XeUF2cUVxS3lnNzZQNmMyZndHa3lwZm1kOVdjOTBzcGtXbUtm?=
 =?utf-8?B?aENycmg2S254Z1ZDTzZKZEtqZm9ndlFLRWxwalFLWGlYRDFBN2VTQVJTa1Zy?=
 =?utf-8?B?c04wWHJlZlhvaElFbG5IWXVLam01bnhiSG9kVDlYK1hQZ01uTGFKbytCd2Rl?=
 =?utf-8?B?dEtyYmRsM0pkNERwSWkvYkR6RkRpdisyQVhqZ0l6cGEyWFhJdzZLYjVzSnp0?=
 =?utf-8?B?WkRYNkZqdkVLRENOVkNIcFJWRGthdFE3L0xZazRqSStrQUlIRC9JTEZ0TzYr?=
 =?utf-8?B?K1htUTJzU0ZKYUN1VHUxNnF1NERVUGU4OEIzOVozbHVGTTlqNVdpUXdHWWFh?=
 =?utf-8?B?TlpCRnNsNGFBdUJNcVlPTlZFdVNJTWJDcEh5R2lCdDFvNVBtdHowY0hiSDFL?=
 =?utf-8?B?RG9zZER0NnlOeXBvTW92dHpmL2h2aW01dW04T253QTh1NUdoUkhWTGo4a2d5?=
 =?utf-8?B?bnhIT1FKNStoT2xNSm05VGhWVlBCaVhhWlA3VkpoWm1mQTI5S0I0Tk1LMWRi?=
 =?utf-8?B?TUFCM0l0cGZxUmNUQkE3R0dmc3pMb1Y3VWtvU3l3VHRZQ1pyVklUK3hBL0Nn?=
 =?utf-8?Q?cgwgu2vHpGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0MxMkZWdG1FSmZvUmtjb2lFcnBDZEpRVTZ1RmJzcU0xcEpxcEJCSng1Zkly?=
 =?utf-8?B?N1ZiNlB1RWdLWG1CNEFYWENRRHJJTlN3OEdHZkIvSGtIK21NMUdCUm9OQUFG?=
 =?utf-8?B?YjhFZEl0RkFHTERvOVVSOU54ZlUvWVdHYWxvcnhjQk51OE9pQ2lNdDZ6RUh1?=
 =?utf-8?B?VWQzQ0VoOHA4UzZveERkRjV2RjhEdjYwLy94MW5oc1hlVk43MTMyL0o4STVy?=
 =?utf-8?B?ME9HaWllYkU4akFxdmU0cWkzb2JtY0piRXpPdkJqVjV2WDB0TVFUVk5BbGlz?=
 =?utf-8?B?OUFEUkpnODZTU2ZKZ0dORzFCT082QXZZc2hoZ09vN2JSYlI4aVI5cGpTdGhV?=
 =?utf-8?B?b0NJTWpwRlQ3Nzd0bjROQ1ZnT1VLTmUrMTRwRElxM2plVW9qSUltWllzWlE5?=
 =?utf-8?B?QlovSEg5a0ZMTWRYUTFlWmpPREZ5WllBWTA1dkcvdEpiRXZFai9hUWNSWjdL?=
 =?utf-8?B?S2M1dFBRNkRFMjdSN1JxL1N3Y1hOMXlyR2RlOW9TTzJPY3IvdGFHS3lwVTlq?=
 =?utf-8?B?OHFONG5xWFJSc283SWFPYjZxcXQ0empoVXhwczFWbURzZlFDaE5GUkp4aWZQ?=
 =?utf-8?B?YW90YWhrQ2t1QTBZNG1FK0NQSU9Ld21FYnl4RFdZRlE1TDk0b1d3NWFIdFd3?=
 =?utf-8?B?elAwc1FOYXZOd3dNcmsrN2wzdnd1N1c0ZEhnaWhlY1pmTVl1SXZUelUvN3lW?=
 =?utf-8?B?bVZzYVRyUG9wVHUwV1JxUUZqZ0NrbTJDcUhiOEZuTVFvekowU1pwWVRTZE1j?=
 =?utf-8?B?bmx6M3ZJbzlXenh6ajNESVdmTzN6SzRpMTZtdjNUa0hkZWI1bW5iMUxzWDdt?=
 =?utf-8?B?MTRKb3NJTVREb0MvK2JtY1BCREVBd1V1ZWlSN3VsQmFXY2QzbEJSV25hbE51?=
 =?utf-8?B?NXhGTlBVR3h2Y2tPKzFkaFZCZUFDV2ZRa0Z0bHJHejZlTmdtVStCWDdLZzBR?=
 =?utf-8?B?azh0R25nV0c1ckl3ZGtiYlRxM1B2MWZhS2VUVUR0elZTbVJOMlJxOWtPSXc1?=
 =?utf-8?B?WGlEMWJ1eFlDWjZIT0hyNzZrTkNKR2pqT204TUhOTFlnVENTN29hQ2pzMTBT?=
 =?utf-8?B?ekc3UkNGdWMxYmU4bGxNM1kxRERCWHJUZmcvS012OXc3RldZZWpCQzk0bEtx?=
 =?utf-8?B?S0lObS9NeDFvS1JiZ0p1QVdoSDcvOVIwajhBMUVZZFhRWmNFS3BjUTBqM3Ev?=
 =?utf-8?B?UHlYbnRJZk9vVFdRRTg5N2oybkloNiszTjkwYXpUKys3TkltYTMrYVZmUkFo?=
 =?utf-8?B?RVdlKzY2VU9oMHBDcVZZTTg4OFNVUTlSS0VIUXFuOXlXRWRsbWluWEFnU0V6?=
 =?utf-8?B?NEN1WE5KZks2ZGdWNnJMTmJvbXJQdVVvV3pEUkZIYzJHMUNRYk1zL3hZOE1B?=
 =?utf-8?B?K3pxMHlCa3h3M05aNEJ4TjJQRS9renJ4aTFsQTcvRlZCRW40d0tHck1pbjBY?=
 =?utf-8?B?ckxlOVBwNjJMV29DZU1RRzZyMW9RcnNvZVQvUS9USW8xWnQxSkZmcW8yR0FM?=
 =?utf-8?B?U3llYUN6R2I4dnVNOU1wRWV2U1NSL2RVV3pHYVJ1SlhaTTRYUEdPYW1kTXN0?=
 =?utf-8?B?bUo4YmFFUEF4SjkweG5xWDU5Z05OOW8zOEQwK0Rua05NanRjQ045SllWT0Nm?=
 =?utf-8?B?QTRLdzJBS05VQjJPYWxkR1lFaFJWWUdkUm12bXN1OHk0ZE5YOFRwem1NSTVP?=
 =?utf-8?B?cmtvWE00czJYenJKS2lwQmt6Y3FLb1YyMzB5YkhocHVnb3RWM3BoQVNHdVJl?=
 =?utf-8?B?cVVXdGllczh0bFZvVmFML2JxWVlQM2cyd1VmL2U4eVo2T1hud1IxMW9LMXZp?=
 =?utf-8?B?NDd3TGg3eklMU0RjTUdMZDQ1M2g0UDB0NnNVMDFCUGI3aE12VkRPUjJURTFh?=
 =?utf-8?B?MmlVRk9abk5vTjZRVkE2Vi96TTIyaFhrNUxIRDg5TmtQTStIblVSVmZIRkha?=
 =?utf-8?B?cGkwcG8vZlVGRXh1VWJGaG1TM3JKZGFPU1RrZVBHZHM4djdVL0RPNklOYTkz?=
 =?utf-8?B?ZVF3SmVZMXBhcUtZVm1Yenk3eldPUUFkTWFyVWxaZWNyUU1zdFlvdWNFVjNB?=
 =?utf-8?B?dkJYOE1uUU1UTEVMeHlCL1Z6V1QxUGk4U25GNWFFbjIzeXYxYmpleVNJOUdj?=
 =?utf-8?B?WVV1Tk0zNlpDME5HbGJUS2czUnFnVjUyMnUza0wvZkpKVHZkSFFoL2UwSzMy?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65e618-3772-413c-1649-08ddacdf0ca5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:06:54.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y0xhftz09lQ4NmPTTP4AZesgK/93WQOtlSkx7f8QTl8gEtJYHXfTMqCfuNanpjPD+WNWBOLQThZfcdH9uZLxgzi3kpSTMdmAs5S/v+0zpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5EA507B64
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Mon, 16 Jun 2025 14:57:10 +0100

> On Fri, Jun 13, 2025 at 05:42:28PM +0000, David Thompson wrote:
>> The open() and probe() functions of the mlxbf_gige driver
>> check for errors during initialization, but do not provide
>> details regarding the errors. The mlxbf_gige driver should
>> provide error details in the kernel log, noting what step
>> of initialization failed.
>>
>> Signed-off-by: David Thompson <davthompson@nvidia.com>
> 
> Hi David,
> 
> I do have some reservations about the value of printing
> out raw err values. But I also see that the logging added
> by this patch is consistent with existing code in this driver.
> So in that context I agree this is appropriate.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

I still think it's better to encourage people to use %pe for printing
error codes. The already existing messages could be improved later,
but then at least no new places would sneak in.

Thanks,
Olek

