Return-Path: <netdev+bounces-284494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCxsEZkT+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:58:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059964D0C0A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77A61302DCC2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AC481257;
	Tue,  5 May 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYJ6HmM1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6248AE00
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996619; cv=fail; b=KbT8e6ncfslKAyk+C1WDokvvaNov/dc+qrmaUGWJU2ZS0YPTLrEK92IYfksWysoSf2KY27omXcBgAuAEhPwPw+05Wv5PhFR1D/7uti0nehKeAv3StRp4r8E1TwiBmQic0WOnADiHG9MP53PhO+n5iPNqMBi7NCghbwrM9JvpfQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996619; c=relaxed/simple;
	bh=OX6Uy4+Se8mdnb8UJUjqyKp1ToJcTbfIO78KBfmFeJU=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5thhkPBo/ZqKdBHTUroT+b3Ivv5RYZpo1wxUIW2ZHyW2SwFF80iJ1QV4wgKPYjCzo5xmUqMqlinEQlR+TDZpeqy0/78g7NNqI31Z7wZ2nzO7WqLF9P57GQ3kTHWv1EjliGFNxh9ZQOrvHFv8xjDeVvyHRZxkWuAdGWONdPb1EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYJ6HmM1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777996617; x=1809532617;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OX6Uy4+Se8mdnb8UJUjqyKp1ToJcTbfIO78KBfmFeJU=;
  b=BYJ6HmM1jIczy5s3L9EmLjBm3A9U6ZtWsf34y6uUjIy5ikaQcqgCjBxU
   A2ahpg5kKcL/YQRPaYZqWwJgGtB9gX5ZubuHL1UWHm9I0xWr/wbRgtzue
   FWhdPfRrJs5PZIPgJA4m27kzfi285AUa/ofzQzNvdMmbqzxHdcBhIfDIa
   SGEXMeqRfHC3qt+2YVUDqkmyzFQIj98UaU9A1Qy9GW5P0Le9MHvSJ4Ne+
   jwtLqSm0Dtgj8mCQpRjI2jQqj4+sdJYTBqunAhF+EZu2awbogFL/xw57n
   /VwznWCZeE+2EeVovRDOXVERTPpCjJa7HcIfdaHyYrYzALbIq6MuzBaRn
   g==;
X-CSE-ConnectionGUID: ox85h4ugTTuZcZvfktM6/Q==
X-CSE-MsgGUID: kVVIG7vOTE2WdpAkYflYiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78731494"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78731494"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:56:56 -0700
X-CSE-ConnectionGUID: O1JtFtNnQPqtDgtpQWyhwg==
X-CSE-MsgGUID: o9P0Q95YRJSwTQ2XrrkXnw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:56:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:56:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 08:56:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heVX3utt/XIWH438lVqyQDwoiqxkbiFMoyixieAj8PiTmgM37mSZNclcRKO0tJidX3vsM+hgBPs8xs/QEPDk1bsTXaeFi4FZId6gVLdcq8GgzLXyzyMWrKpnoEI5WPaZg7iX2kXScoYDMEJAMOxlaoOaihBlRzJPdf4LerzsKCUK5RxlqPmpib9nDuIEZiigcNDha3wXYVm0XZnJyLAAzTHzZYtavoJ7PxA7BJIG4Md05GNRcmLC4Cay0tmYYAasWH0sWZp5XMiJ3EBvJXER731ukvnqhEZ94jtXtM1iJntPG2M/AfJ6EmN3SLKqMLqX/RY+4b4qjrWtz04A7f79lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ7l42bemXU+4+ixQ3aB/z+F36HD2v6RZW/mB5ihWmU=;
 b=BtSK8306b8q63DstbqC9LnF1e2GXkmu1jnRRH3SJt8exO2XdLur4M/ThFaoCsxvH2+uyDS9BWXkqV1TJ5xdedzmqFta0ZhHJgQYmw5NW3SO1Uw3CecX8dDfBFiiYaILlLAlgwoLYTvloFVRhVDU0R0+1DLAQglwx14EyjbAdkEP4yLwoiae0z4FlEstkIBnJ0aL+fHWsaJexuO4+pwbKMrjMAwtxMALxtMYZ5CpI3zeuB+MyZVABDdAXnWAMX09yshIilufVb4n2tVu93oiEwW6+GeWSHq7wQgWoxc+4BtxJLIM1qcX3CVdb0x+6aKVfhNCkyH1ls45OdG9M8whbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:56:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 15:56:48 +0000
Message-ID: <61378b55-af99-479f-8b28-94cb2d18563c@intel.com>
Date: Tue, 5 May 2026 17:55:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: realtek: rtl8365mb: add support for
 RTL8367SB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
References: <05921e1f-693b-4322-a762-c8f03c386a78.ref@yahoo.com>
 <05921e1f-693b-4322-a762-c8f03c386a78@yahoo.com>
Content-Language: en-US
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <05921e1f-693b-4322-a762-c8f03c386a78@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000919.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::927) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7683c7-76c6-48eb-bd9d-08deaabeea3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ly5v6SLv+fxhAqafGaB+JCF41TfTP39/KHKFhonzCVJQJNg238gs2+wTeREI40NEETmvTq88LcdUE6YflFGgySh7hqu4bFPaZsTftsxxtEjiMjOHwXeDsHcTvOVpYnwFhR3Jtqrl/iLDFZTUyUdCCd3O1TxsHHoqTzfCpeuVHy0eYNUIyitTwjTYlulKpG6IeFpDW6t3gZ3H0Srt7nO4PLhZkZAHRdydrFvJBvpZcV07K3JGH73EPFKz4OUc99Up/miQuyPQx7/7iIswxw45+x2VorfmUH8RUEF5B7B/1YzCygzTBk2yjNgBhbp/Z+ABDNvGDPWnesDywcM3gwkLCsooDYQWiJ6u67SwluQVRu7B88RxdMdubqR0t2C/ATNrwCaCygWyoTQvhMSSQIa7eB1VkfxYPp0SKG0CfGjyU5ZbNbZPXCvMkSLZ7TgxN6gquP9kuHVoe6TmCr+MIB18E4rh7mFSZcN8TSRYD3DsPOGLVRQnGQ6bgQh0DRsozXGL4BPfPVxjVcNRjE3NMJiC0hhzZHDz9CfD+EPogR6pReV9ETCz+xSo2Mb7PBnTyvvHxmAJWjPl71XVicPvKXQAJflKY3kjX+MsIAJ8F5AnZzQ7CzmLdd4RHdeU07SR32RjfX66KvkXt7GFbfGQpdCBYgd1w66gSOoq8Pf2pWDihDQni9ZGNxf0cvdWz7QT7ovp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXl0c3BrRzBQa2cxamlSNlA4SC9DNXBxcFo4L0dOWlN4OVdVVGZQa214Zlo1?=
 =?utf-8?B?SElOY3pDWjA1R0RiMjd0WmhkOFg3NWRUZEMvUkdreVZLb0NGY0VCNnhTNTM4?=
 =?utf-8?B?RW1VTklDZjIzSHYxTHcxNmFvWS9vdXJrSGlIREZjV252ZEVsTmJMSDZuK1ZE?=
 =?utf-8?B?Q1NzUnRPY2VuYklWNy9GYjBidkZycDVNR3BOTG5PeFZsOXBKOVYvVVp6OGlG?=
 =?utf-8?B?UVl0OGMxTnAzTGJObWJEVkJhdElVNW9RNDRWOWZxazdLWVFKUWhtQlJmbi9l?=
 =?utf-8?B?cVoyL1l1aXFHOHAxenRaS2JBZTN0eklpcXQ1K1JYYkZyeDMxUXpXbGtPSmph?=
 =?utf-8?B?d002bUNJaXI5Vy95QVVkWGJQN055RHdXUWlBeFluVVU1QjZvYUdMbncwYTZk?=
 =?utf-8?B?UVZadkZObWZLcGxobW5nQ1FiQzMzdGg2Z0lYKzMvOFZkREpDeFlQU043blY1?=
 =?utf-8?B?a2N0V1ZXVi9RWXRvbURZQXZDbUhqd0hERXlteXpwN3daa2EvZ2pDYlVaak9U?=
 =?utf-8?B?dzI3RzgzTHJjVUpHN2prRTJuV0N3UEFqRTEwVkI3bE9VUVhaNWI2Y2NHNktK?=
 =?utf-8?B?NWVPY1hLV0drcWdUS3FNL0duT0dJQ2FWTHJQUTk0eUpLSUxaZzNsSWh5S29P?=
 =?utf-8?B?TXNkYXgzZ3BGRXF2NnU0aFFHTVlaRzQwU2MvNkFtSkNZUVYzT1VwNHZ2RnhU?=
 =?utf-8?B?Tkhsa0ZmcWRzTS84SmloYnViR1hNdU83NDFNSWNsUVI5aWtrMHRYWTFXZE5S?=
 =?utf-8?B?YWwxRzJKOVpqeTdTSHZ0ZnZwN1JJMlNaT245L3pzRFRzK1MxT21EUFZoZjN6?=
 =?utf-8?B?NkRTU1hPSjE3V0gyTkF1MStqYmpWeC9vUzRBMGs2cmJvcUNma0FuRXdWV1Ra?=
 =?utf-8?B?L295TmYrYjhNNFp6S1RmbVh5dkoxZWZVZWdJVjY5ZXIyTEJRcnowc0ZYME9n?=
 =?utf-8?B?UlZyRVFqcE9pM3JEanZqMjNuQlRZNDZoalpGVmgxYWlUY3FBRWlsd3hJU25t?=
 =?utf-8?B?SVhYS2xjS21CNzROUjY1blRzYjNmSmNyYVdjbXIxZ0F1VEppODFWUUxpUisx?=
 =?utf-8?B?cWFhMDZnSUdzVnV1UVMxZXlJOGVONzBHMDhCTnMvbzdQN2JIL01jVUhSamlN?=
 =?utf-8?B?b2lpUEs0aENiMzlmNW5mMTlXYkdlbTEzcnFLZ2V6ZGcxbDhmMWpLVjVIVTc5?=
 =?utf-8?B?S21lQUM0MDAxczJ0Q3pEbGdqNTQrU3poRFdnU2JIeDJQWHBqZEpPS1psSWd1?=
 =?utf-8?B?RzJXdUlzczFBbFVBVHNlQlRFdmVSdTZKVENZSjN3K1hBaERWQzhYTmJOZEZh?=
 =?utf-8?B?a2xhMzNha2o1SHZVZzEvdFFuNldVS2YxK3BoU1E0cy9qV2JjUWZUaGd3YlFG?=
 =?utf-8?B?R1IzZW1jWUFaWUUzTE1FaTQ5YzZjbUNWOG9pbUxDMUF6RkFFbVdqOWFlWUhQ?=
 =?utf-8?B?VE9nZks5M3VTZUZkR3dnclliOEMvNEZoejIxVXlTOFZmVCs1Y052N0ovS1oz?=
 =?utf-8?B?S3V1MHdkbmQ5T0l1SkQ5alBVVEIxSVo3SGMxYVUwUWJ4WGpmTmpKd3RIZ2Ja?=
 =?utf-8?B?SndNdHhveTZRbTdpajkrZCtZd3hBNXVFbENmTnNjYUJxbGc0Y1I1MXhuSURI?=
 =?utf-8?B?NnlqTWVKaHl3bnBDWXR2dlZOQkx1TFFHS0l1SUoxbnZDaXZmbVJFRW1KWTRu?=
 =?utf-8?B?bm1sWHBCZ1I1NVdOenZoS3VwNHFueThlZ1Y1V0I4dnNTbUdUYlhjQm9uWEN4?=
 =?utf-8?B?QUM0MWpsN1dIZUt4QmlVMmk0ZEJCWUdiQllNdjVxSHNtTGxMTzlFMWlZMnZQ?=
 =?utf-8?B?TlN2alBHQndYWERWWk8xRGJHc2NrekVCcXJBR1BpY013WFAzMWlqTk00UHFS?=
 =?utf-8?B?eEV5bjYzVUdHd1R0V3RJMlRXc0psNzJFbGgyN2dtNzBjb0NRaDRqamNRb3Vv?=
 =?utf-8?B?cGpEVC9obHJYalg4YlFyd0ZWUHFsbkhGZndTdVpEUHVNR1gyUnhSYUhLeWVL?=
 =?utf-8?B?TE5DOGZFWTlKTXFBdnVVaXNjV3JwK3p3WlFhK0wxV0Q3WjRIUUlpZzBGd1JY?=
 =?utf-8?B?VXhubFdnWHZxUFlCNXNSZHJrd1hDa09tbW8wN3FXTDg2dk83ay9kdFprVXFz?=
 =?utf-8?B?djRId25wczdHUUpOMmVFN09yZzlYek8wVkk0QlFzVkZhSjBleGFEdDBoNUpO?=
 =?utf-8?B?cnlPRC9nVlhlc1FzdWhrY0FSc0h2YzY2NjFleURFVDZwWWNmT1dJY3ZMc1Ax?=
 =?utf-8?B?dVZiSWZoOG1LZEtaQ3E0c3VIaDNIOU5wVUZhcnpBQXFiZmdNMTI3WDg1Wkpt?=
 =?utf-8?B?Rm5pMjdGQnVlT0lSUWN2aDFGU1VOUGlyQXhGZGV2WHNXczNBMStaYWpwem9T?=
 =?utf-8?Q?cq6LgeguW5/BFuXM=3D?=
X-Exchange-RoutingPolicyChecked: QYhdac3xG81CyR9FH34kFaMW9T/R/nD3MbOs06z/WEpZkO9NBBRvc9pvFl8unCBAIjKHSxA7LtJsst4+c2h0lhdB0L1wTSglZqAJ0ExC8b0/AW3YXbdqnBt3l4wtkQfSH609RsHbnvrd66sVEvPZ+ejXCg1Faj5+xVqZHTtZYYV4YuZvdnQh+CRyWO82oNRQjcenih27p/fQOsnq4yfrb0riU0oCU5L86SeRTMrs8WV9sYSOQlyqDb8HBTMMjpCB87mfH0bowag5lXVgkZqo5rFKWTsRtCFnnuehow5b3M/Ze2l3t1EtdA7gdCBNMSS2H9mh/75CryM4PuyWohgY6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7683c7-76c6-48eb-bd9d-08deaabeea3b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:56:48.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAFzH2yRfhr+qAsidEwoVZMFEFAZsVPDNoKj+An2mTuWuFbtBNiGyzJ6Qyta9joJTsNxpm7T1okc5uVeYutcd5hpkCj/VTkljZfLBep3phU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 059964D0C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284494-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FREEMAIL_TO(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Date: Tue, 5 May 2026 16:17:19 +0200

> Add chip info entry for the Realtek RTL8367SB switch. This device has
> chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
> port 6 supports SGMII and HSGMII, while port 7 supports MII, TMII,
> RMII and RGMII. Use the existing 8365MB-VC jam table for initialization.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/dsa/realtek/rtl8365mb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
Thanks,
Olek

