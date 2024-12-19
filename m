Return-Path: <netdev+bounces-153410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E007E9F7DD2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B791881C83
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA031FAC29;
	Thu, 19 Dec 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFjzoCgC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0E1754B;
	Thu, 19 Dec 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621469; cv=fail; b=eov8qsVF6vPI1mou76joF0LB2km1zIU09iDori5VAgPJaMWonC6BhM0ax8eenjUaQafdYC4NLeQW+fMQbXZSxvNv4vNklnwSAu+ZtMzZgo5wGpBHv/3aQfFQ0NjYsulUfEyR47Befb4wd7tGtMvtyGBm2Da2Qwfvum5zQLwMViA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621469; c=relaxed/simple;
	bh=MBjK7LqfSSzAaLGWZJeIhco30RJkHymO4YT7pwYc5kY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ctDkHzcDJM550lp7AYI+9wZfCPuBSRh2Rq5AtRzdmcUMWGubWVK4tYSG2F6Y3jXgbDPQKUCExA52Udbb+NRyj7QjyU9zwcWYNq59C5/XflkP6p1s/KuOzyQz9hSDLGEDqizEWxgwbNhLr5pTP3NfFtH5y97CCGzwnbAqk7BpGe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFjzoCgC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734621468; x=1766157468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MBjK7LqfSSzAaLGWZJeIhco30RJkHymO4YT7pwYc5kY=;
  b=IFjzoCgCJbEQpx3tjV6O/I24UriKsBDvAMbsjxTGSc3m979GEaXlEXho
   J8tnSlmNki3qAmtRfW3lofArKhIOwqRX/mqU0yH6znU6MBebIlpWTJ0bM
   zR54CICCEpnpFCjUY+8Z/8AhJnHFcfEFflFbyRTcBf2GJoQi9Cb/CiRBB
   b4dQSvFqN4LcIZ4UG04UpBUEuFu9eBCeX3QbwpEVLQt1xNIHi60wcJ8yN
   +i8vXtcyGAcqkOy/MCG4CbaFhYxVunP+wBj4fnQbEPum0yCZWO+AWLoII
   iygsY38uv2ibXG+looZBXBHFlQvcudVmaRR7moBdwMPVHzBxrS0K1SzKi
   w==;
X-CSE-ConnectionGUID: 3BMxAOMVQvqtqaI4x1hkNA==
X-CSE-MsgGUID: iWX2c2x2Q+uN4IIoscQ/rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35349976"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35349976"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:17:26 -0800
X-CSE-ConnectionGUID: TUEqNoIJTRazstN9FTikbg==
X-CSE-MsgGUID: zb8Ua2tSQ5GbNJUUrVnvbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="129033608"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 07:17:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 07:17:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 07:17:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 07:17:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY1BcSUeOHXkzTEFv/lWpW54HubbvLq4OLaOjYLHAdVq8o0vnrkc/U4U4JszNWlOO2Jgxqtc70HOLA+k/fN8hxFolJSROz7CevvavVTRXWX6lz41rpThJuN0IAKdkrhcgIe/3bHqwqCGQLmStmXGx8KPRzdGgAhEBYHCq64TIo43V3P+ZjVCbkLBhzl+RKEbWNkSxkIsQfaG3JRVqtvR6ukWjYqoHLA07XyGQMClnn/ZvRBUndo80glZ816kjD8Tx1NjJbojuNaLUgfTp/y2cucZPuKVcx63ERd4JD0r7HAjZqg+i7AdqHNWWFRcYeEXug78xwIMwAq/dgfFaFzvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRHnZDZYo0gA1iOJO3uZ6kixIsn8LpcyanGogRX2wcE=;
 b=DFJ8Y1dchgQI6eRtWeRqhtwApyR6LNavMVUYCSyvZID2BZ/ykIu64++P+fYEWmb3hr0qLNI/LNOHRzWANa8XLrPdtG/cgkEYai1F5DM8+3XRiYKXVTk+8i4XhFxpYaCr1znjKSTT+0ezgjozKmSOef03Kv7beh1oUL0zSpkBre871LEZ4pfg9K80bC4Tg/fppCUg65i6atVj9RpzBEgslLLxjA7WjWgrR+1pXA6aTjwMssWqv55G1Sl5SvYfvt2w4W+2zc7fzPYgnvu4a5ivDEskUW3dIRkhn1i7esnEXWoaaAf2yS8Ig9AUMKUhSg6UOvvI2k35IwCC8OwqIfomPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Thu, 19 Dec
 2024 15:17:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Thu, 19 Dec 2024
 15:17:22 +0000
Message-ID: <8d0e4cc6-6fda-4a14-ae1a-0923a93fbeeb@intel.com>
Date: Thu, 19 Dec 2024 16:16:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@idosch.org" <idosch@idosch.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
 <ee42c65c-cc35-4c6b-a9d0-956d06c56f7e@intel.com>
 <PAXPR04MB8510CFF87187B095D15DBD6088052@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <48f2de4d-1695-4d8d-834d-b306b17e09a1@intel.com>
 <PAXPR04MB8510B5F144CE751D74DEE0F788062@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <PAXPR04MB8510B5F144CE751D74DEE0F788062@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e01df0-bd4e-4ba6-67b1-08dd20403c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWFsQTZCOG50YmsyU1ZIdTZXQ0c0U0krdkd5ZitVQU1yZ0hpVVdGL0MzSGU0?=
 =?utf-8?B?S0dYbUd3dGZpWi9iL0pVaFRmaWV2T1dlOWRJc3JNbFFUVGZoVDMyNU5HYmZt?=
 =?utf-8?B?dUJiQnJpVHAxVDJkQXkzZ0hTeXdpemt0dVZQUUZjeXJYSCtlWU9tT0V6SExo?=
 =?utf-8?B?bkhvSWdZRFE3Y2VON0xCZEZ0Vk9oaDcwdjBXajhNNllzdzM1YXFEM0t0OFdm?=
 =?utf-8?B?ZUtMdjk3bldUZDFaRDVSTTgzK0U5MVFrWmtnY2lNQWg5WmVWdlRiRXQzQnFh?=
 =?utf-8?B?S3BqcWR1WVN2Z0ZmMy9lZWozUFVrUkR0N1hpOHBSMXlrNExtbmFDM3hCS0Rw?=
 =?utf-8?B?ajd4OGJuVmRDTHk2ZUltaTV3SFFzWEZrQjdWNkRnU0J6dUhSZmdvYjBhS1Ix?=
 =?utf-8?B?QXJicnF6Tk5lQkwwVlVhUWQzMG1JcURHMTk0ajk1WHV6T1UwYjdsL2xZd2tG?=
 =?utf-8?B?WjVlODE4YVRCUE10eWVWOUx1YXJMVzA0bERGdlRSd1U4a09YM0doVFRmYloy?=
 =?utf-8?B?cWJQaFBENDhwZ0dhOWJUVTJoWnZiNWV6VkZmdm02d21TdHovdzN0a1REVCtm?=
 =?utf-8?B?OWV3UmZNVHNMejVyYnd1Q2Q1aXMvMFR6T2gvWU1VUXp6YThqNTRqa0k5V1FM?=
 =?utf-8?B?QXIwNDFJaXlyMS84Zk5TY3gycFluMlA2WVd3bksxUmpkcnRMMm94UnR6cDlN?=
 =?utf-8?B?d0ZJdDNqTGgxczl5SmxaOE5rTVFkeTJxLy9PdVFJT01jZXlSRTAxd3Nvck5t?=
 =?utf-8?B?WFUveW9jamNialJzb1ZKZHdobnQ0TVhCSGdHZ3hvSVdXRDloMjJBamdjdzVY?=
 =?utf-8?B?SG1FR21CdU5oSHZrZ2pPdDNmRER1Qml6eWxyTXhXSndGRnB5Q0tLY05oeklO?=
 =?utf-8?B?NG1QZ0VwWFBLSWQvSmVqb0V4S1hPWFVQSFNyYUFVaENzc01TTml5d2xyWDYw?=
 =?utf-8?B?Q0Z4UzJkWjBzdXh6RUUzRTRobGNhOGhlQjVaUTZITHZyd2NqMjBVZjdPVzQ0?=
 =?utf-8?B?Tit3RitvZjJlYnhTY2NUYTRRMU1XWktmWEkxaHh1YzZvYXpYaHpTUGNaVUVz?=
 =?utf-8?B?dFAwclNwLzBoNW5YVUhQbVNuTG9mNHF4Ulk5UXdLamFDcGZRS3Jja2VEUVRN?=
 =?utf-8?B?c052OTNGS1BXZm9CK0lIa2crNndlZG5vb2taZ1RpVUhIU1ltaUpzd05LTmRh?=
 =?utf-8?B?bmdVYzBsUzA4YUtSOVVpRUFEQThFbDM4UVFuaWZyeTlKRytaOElDRXBUT0RE?=
 =?utf-8?B?RktJcURKQVRDeG9MS0hxekZUc3daQXFvRWxhdXgyNzltekNhMnRNVnZDa085?=
 =?utf-8?B?STBBb2c4c1JEQWtwcU5wVUtBNXBOa3Nnd1NTdnRqamJadGlBN1RDcmVaclI1?=
 =?utf-8?B?Q09SVTRuZEhTaFlMWkNEc05jZjZBSjFmSzQ0bnVFQzRlbXh6eW9wZU1yNk5K?=
 =?utf-8?B?bHFQNExGaTRLSnVFTTVDY0RsTThPSHloZ2xMTGpMbUlRa0VkeHY0dzhvMlBk?=
 =?utf-8?B?ZDlBQ0lrTHEranpyM3p6b2FwWSs3MDZWVE9odFRURDcxWWVWZDh2Q1lGWUJx?=
 =?utf-8?B?cXErNCsyZzZpUEJ3QnJjMmR4elphNDladkVaL0pqbmtndlFTWTE2VC9kbUhs?=
 =?utf-8?B?a2Z5WWo5ZXRQaUVsS014Q29ISVJsMG9MZHdVdjZ4SjFWMzNMRnorUDlEaGQ2?=
 =?utf-8?B?M0srSUVtc1ltV21ycll0bVVoL01LeVpZSFRvbGxHLzNjOFpDZUIvZnk5aG5m?=
 =?utf-8?B?QXozaDBOajBtNjA1ZHZZVkJEdDhJWXhZUmUzTm5VMC9DWlFmWGVYbUtFWlNW?=
 =?utf-8?B?d25QU1pNd3N3MGVycXltSFJ5N05QVG5mZDRsMFhUK3I1SVgxRFlWZk1MS29z?=
 =?utf-8?Q?/nRJkiy1aixR8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFoeVFDZ2YxclBaYnYzM2Jidko1QWZUZmZjOVFqdTU1bmdnaUJtcEQ3M2RS?=
 =?utf-8?B?Vmp6TXkwTldtQWZyWUJnNDZGZVNLRDZHUUJRR1U2S2YvL24ydmlDcGYyL1l0?=
 =?utf-8?B?bXAyQW0vNkdOY0N0dlhsbDg2V0F1Wms2U0Z6ajVRd0dPTzRDN0pkWHhJUjNv?=
 =?utf-8?B?QVlPYkdyNXRIM0czNTRZYW56YXRBUUl1U3kza2dLMEx6K0dRcE5SeHp2VDRp?=
 =?utf-8?B?bk4vUUJsb2YyMkF2cWJEODdPdTRJcWJmVmxFM0dLTzNRUElFbUF2M0tVZ0Zy?=
 =?utf-8?B?dDY2dG1pdWtmQUdyYlBiS2pGYk1JYnlDMzZuQzlsUmg2eUpFWEZwYmsyZ25G?=
 =?utf-8?B?amZnTElEdmZzdjlMbzVmZ3lrdjA0d05ybTgvOWg4LzBJMFNlWEFJaG1VZXB5?=
 =?utf-8?B?Q0dZaC9GSjNkRElWUlJ0eGlpNW03WWtZaHZyQmdHZ0RpNUF6aTB6Tld2WXhp?=
 =?utf-8?B?SUtGNUhWdEhQS2Fuek1JTXdiYTlqZDc4Wkpic292Z3JRTzUwZCtBYnN4ODgy?=
 =?utf-8?B?Y09DSlJieTVuU3ozZUt0aWFBakJoejlDQTVER0Z5bHFKaTh2MUlUejV3bURO?=
 =?utf-8?B?QVQ4VnJKYU40RnY4NDRBWHdTdEQxZlM1cHBUeDYxMEp2MUxYZzlJenNiaGRK?=
 =?utf-8?B?M0RvM0pJWVdsNjhLVFdHc25xZWl5M25xbkc2SURwNFpPK3BSdWN4VXpucy91?=
 =?utf-8?B?dnpaYXNpeGJEcThMeVRxMEtSSXNyd01HYkV6VCt5VDV0RXkxTGRKeU5QRkM5?=
 =?utf-8?B?MVg1SEM0UGlEVWhPZmprTXNpeDBybGU5YzJVUlpOeFgvU21uRno0dnpleXBi?=
 =?utf-8?B?MzJMMk9sTmdyRXRYQzlwV2FXNWQ5cHBmNzFOK0Y2RDV4Ynh4c3hPYUJJd3V5?=
 =?utf-8?B?YnlLSjhtWHYzNG96L0t6UjA0Z1N2YXBuNitacWhJczEvaDIwWXVkeG95bVpB?=
 =?utf-8?B?YzZVRzFtRHVsV21tK3h2Lzk0MTkxaUpyakNTVXFxMjJQcXhlWm90alhKRGlJ?=
 =?utf-8?B?OWpsK3QrcHl6b05Td0RBOGozSzlRSDVJbHphcjBiYlZWVkhGb2hLdGNGMmRC?=
 =?utf-8?B?bzFkRkVWVHZDWDFvYmhvYTB2eEFVMUpMY3AxVXVVWUJQYzdOTnJLenEvUnhp?=
 =?utf-8?B?UnRzWE9mTTZYUlhvRStWejhySjdlK01TT0llNlNzV1JkeHN0WUNVbGlIc2Rn?=
 =?utf-8?B?M3BFNERJYmpCOGF1cSs2dG5UQXBteTcrT1k1dFlHVk1yejZMcXJsLzJJSWdG?=
 =?utf-8?B?RlNaTlBPVDVuUHVPNFU3WGxHdnNWRm1WWnRmSVQyaDVYdGNkcGNxalkyaWxI?=
 =?utf-8?B?NmJGVi81VS9NTHZDRk0wdWdDMk9FY09sQ2crUXlnYmg0OFVFanZ5VVZGSVg3?=
 =?utf-8?B?d1piRzAvaEk0dTd6ZyttVVZLZmp6OFA2UVdGWEtxaVM0VDFwQjFoN1o1bi9E?=
 =?utf-8?B?V0ovVjZTeG04QVZoRnJmYmR4Qzl0Smk0NldwOWplcXJuNDVjWXRpaWlDQVdl?=
 =?utf-8?B?b1dSdmplZ20wZW5Pc0FxenVNd2pXYWFKandMSGtVYkQvaXBFcEJaM0hkNW8w?=
 =?utf-8?B?ekYyZ0J6TnZHZ2JJSlpGV1ppRGVGT001TjJJQTZyazNDR0tIa1BsOERMM25i?=
 =?utf-8?B?S3BkWlVUMjVTdDdaZzFuWEY2dVJlMzdvRFFuU2FDMjB1Tkh3UnByTVRFVFhu?=
 =?utf-8?B?K2FYL0wwK0szL0NWc1EvR3lhVlFiRWRVNHdHN0FsaUY4bGpzb3FxWkFHZW9r?=
 =?utf-8?B?VjIzVHFMMDVITDBDRUZUbGZWcnVBZkl3VGV3dmt3eUtCbGJya20zenVHQ3k4?=
 =?utf-8?B?YjlIU1RIMy8wa2FnV1IrTC90a1dqbCsrSkRTK3VSdzRVUWtKU2VDZFpENk1x?=
 =?utf-8?B?TGFKMElvMXR4eG5Fem5HRjZPZDVEdWNQVFBkQy9sTGd0N2JpM3NVRSs2ZU5u?=
 =?utf-8?B?cjgyN1dPSExXbWFOK0VRcnpYY0xZVU9uV3VnMEIxL2pIY3hrekxwR0ZtdjM4?=
 =?utf-8?B?akxwTENpbDBvVTZ2c1g4eGJSOTd5d2dkNWJVVWZQcitqTkk0Wm5FUllGNnpX?=
 =?utf-8?B?UW9lYVpJb3BCQjZoS3NKVGF3MGxBdUh6TWZzVUVIREhRdGRwbXlOcWpacm8x?=
 =?utf-8?B?Q3N6eUU4ZktrYktjOUxaZkw0dERMUTArQW94bjZOYVpaT3BKL3o4K0JQRjMw?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e01df0-bd4e-4ba6-67b1-08dd20403c8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:17:22.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxQFuzzbOcxoPLb4ACL9cxQpD4gKOM5+lqNm3Ijwpvf5XFft9fR0mGxviJMCcKhcMO+lQ4HowbgiXaI1umMpvm/p82CKjlSXCqV7YKJY+rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com

From: Wei Fang <wei.fang@nxp.com>
Date: Thu, 19 Dec 2024 01:32:56 +0000

>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: 2024年12月18日 22:30
>> To: Wei Fang <wei.fang@nxp.com>
>> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
>> <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
>> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; Frank Li <frank.li@nxp.com>;
>> horms@kernel.org; idosch@idosch.org; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org; imx@lists.linux.dev
>> Subject: Re: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
>> ENETC PF
>>
>> From: Wei Fang <wei.fang@nxp.com>
>> Date: Wed, 18 Dec 2024 03:06:06 +0000
>>
>>>>> +static inline int enetc_lso_count_descs(const struct sk_buff *skb) {
>>>>> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
>>>>> +	 * for linear area data but not include LSO header, namely
>>>>> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
>>
>> [...]
>>
>>>>> +					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
>>>>> +
>>>>> +#define ENETC4_SILSOSFMR1		0x1304
>>>>> +#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
>>>>> +#define   TCP_FLAGS_FIN			BIT(0)
>>>>> +#define   TCP_FLAGS_SYN			BIT(1)
>>>>> +#define   TCP_FLAGS_RST			BIT(2)
>>>>> +#define   TCP_FLAGS_PSH			BIT(3)
>>>>> +#define   TCP_FLAGS_ACK			BIT(4)
>>>>> +#define   TCP_FLAGS_URG			BIT(5)
>>>>> +#define   TCP_FLAGS_ECE			BIT(6)
>>>>> +#define   TCP_FLAGS_CWR			BIT(7)
>>>>> +#define   TCP_FLAGS_NS			BIT(8)
>>>>
>>>> Why are you open-coding these if they're present in uapi/linux/tcp.h?
>>>
>>> Okay, I will add 'ENETC' prefix.
>>
>> You don't need to add a prefix, you need to just use the generic definitions
>> from the abovementioned file.
> 
> These are definitions of register bits, they are different from the generic
> definitions. The current macros are actually different from those in tcp.h.
> The generic format is 'TCP_FLAG_XXX', while here it is 'TCP_FLAGS_XXX'. 
> Anyway, I think it is better to add the 'ENETC' prefix to avoid people
> mistakenly thinking that these are generic definitions.

Oh I'm sorry, I thought those are copies of the generic defs :s

Yes, just add ENETC_ then.

Thanks,
Olek

