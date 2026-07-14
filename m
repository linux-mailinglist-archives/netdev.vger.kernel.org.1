Return-Path: <netdev+bounces-307474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySDMN8M7VmrO1wAAu9opvQ
	(envelope-from <netdev+bounces-307474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B57553E8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:38:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fO8HdNMd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 489283300491
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3B344DB9;
	Tue, 14 Jul 2026 13:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C12FD7C3
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:29:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035795; cv=fail; b=axh087qgDFFxlJjZD+F0GM2xBvfqDHB0J34eYsesegSZ6aepGCRKG7QHg1jSDRsI4V2i1GzemN8jjs8F6iZlav3E46S3KV25w47xYJtWylH9N078Mu1x43qSICC+c/3GurmxcIKhIvKC6DQGYD6PPcFuJ+yAk2ZZNm5jYZU2VCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035795; c=relaxed/simple;
	bh=LlkKERdHd9ccDw1tgbW88k0CVwaCDroT7AKGzDfMFlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LKtSldnKxS4czW3wgtusBJZFYuiAFoZ3oX632yMhaVNnNnWvaj9IZZ0KJ635YBDohPtjhukhPGLkRIq/EZnd9/hqWXH+JVf/sIEnMxyYy41dHPZmfkYHuOE4vKBMIajAU9dyjzJJ/LPBWIOG3pTW7cVgWGht5okbm83bTatAtTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO8HdNMd; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784035792; x=1815571792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LlkKERdHd9ccDw1tgbW88k0CVwaCDroT7AKGzDfMFlU=;
  b=fO8HdNMdeoE/UWQo5q5qKp/OnYztxIn4Idu8fCQPn2F8Hs2R+xqly1Rj
   z3/WJkzMSoTN7V87ioy44esQA1XRDFS43S259sLYuM9MUeOhMkgwC2A+c
   5c28ZL8bSGVIcKEYesIyICB4ZNfXNBF1HzVAGb7NfM727iEXcTFkO3Fhq
   MUybAUGfaF4P3yDLhf9m/qxtMoyRcpLUr7yA+Z7YeW7g5CqAUy2xXlC5Q
   /E33dZ7vOXFbw5hkkDpSG3vSRmU1T+NOt3MGmhsnVn7yS3qfxyJGFq4Fh
   Kg12dBvi+nil1S9DxpZWYf3R6QEwh/NNUP2B1ln1appEAq8z8vEhO+eNZ
   g==;
X-CSE-ConnectionGUID: 6ornlhmzSomDf+IZBFcASw==
X-CSE-MsgGUID: 48XV7S/gSsWaD+ZWNU+HrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84620481"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84620481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 06:29:52 -0700
X-CSE-ConnectionGUID: sdRPARFDTaeICaIkykjATA==
X-CSE-MsgGUID: aZeAA4XJSXSINPdz9h/RmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="294060288"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 06:29:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 06:29:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 06:29:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 06:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlRlyT07OKI6UI0G/rjAQY1C3H85VV80BMc6yODOoYlnS0rVy8QVIc75VS2Vv6Y1VDFCF7mL1WUYQIsF13+drCvaGfS5x0W6bUsWMY008ian0eRANnUnlsX8Xs7GR8910U2sOhXefwspGC855pA8QWbqO3W+JGY67r2GKHpY8d1JOSy3wZjrrToq8/vAnAolrZjvzZ8yK0GZXIrk6QERhVD2OsbGubDIH4+gKrZtZ36kdyXSbkW54SxIlrwtgfscvykGYKQ6etoxfHT4yCf9/YnV+j1Tljuf+Uj0CbGaHV0V1TyzasyUx8bHNqIJJAC6QvEA+fn/pb1ET1hD7wKxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlkKERdHd9ccDw1tgbW88k0CVwaCDroT7AKGzDfMFlU=;
 b=spkbH3V+PuIG36zLRmydVx0gxsWdBwlECz/MaQrqbhMnIf+QIZmXZZGKFMPJClMTkcuMMtUgb1c7XCYKcNA7Od3kxiWT4NL5fd0pKQ3t0/mvexv6PvP0D+Z+i04FqzB/F4z6RwiVcfUQYKJjh6z0MD2id4FragWZRRUvQnnreclKIz4EHNY6mwBeSMccfxTUoQS6oErJqs47z4nu49sydL9xBt7Ho9CDS8OHUYHyg0rHPHBscUwDyav9MeNATTAwHbft/2TJCQHqdpa+sq/HIv2ENSNlBoavMEI7ACmGNqC36IAo0aoGb1gPPAIM0GG+0qjNiUUqf8Q/Rvs78n5Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Tue, 14 Jul
 2026 13:29:46 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 13:29:46 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, David Laight
	<david.laight.linux@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: Michal Kubecek <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Das, Shubham" <shubham.das@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>, "Brandeburg,
 Jesse" <jbrandeburg@cloudflare.com>
Subject: RE: Ethtool is missing C2C link modes
Thread-Topic: Ethtool is missing C2C link modes
Thread-Index: Ad0QtH9BbirxMb3HQge7zku6IKXccwACn/MAAA/6EgAABI/OgAB9dWZA
Date: Tue, 14 Jul 2026 13:29:46 +0000
Message-ID: <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
In-Reply-To: <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|DS7PR11MB6269:EE_
x-ms-office365-filtering-correlation-id: 2ddad438-e699-478d-0deb-08dee1abf8d9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|5023799004|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: qyPKx7wb+Dr+v85orZW0liZSD+SP7F4V/E8UwcyPYo3DpX8vkkFjiiLL15NR7ZtbksFx32mn5gMe0UViBdMmiQoFnP4W2BKXYkxm3oy9yC+OlPDhmGCs+0e7By6psS/HYPqGc6xE6K1EBFi8wbsXfeLBsNZskv1nMpPBjviwwCq3M5WGYw8G8UmyySAyevyfpojyKUl6XhfuIV7k8K8qKH408tMc3xvz2tHQhZTeny8CHOQiZvVUi6lt2NAdAlRBKTYnoX+FC9bx0LrIKQyUY7jm6/bVLtc79yYgg0EA7194QUM4QFwrR43QLFNN2tgPA2fYqG3FIah5CkbkwPTYApnq1tAZ0nJT3kZqULTHhbJRPH1dZ3WnrkgsEHKOLLIx5oRhOG/q+YQBxPMhmxQ5f68BvPlMgh60Rp3H/Van5ocELuYuir4YFGzH0wlnfWY3yXux5PYev3Y5jGLMrERcxaAHE1wMabYVwFjRmspE6/z3bCs4mK84v4lS0ggDkMHMsSgA/KG8bS97iHXClrjg0Gu5f77IQ/FToW2u7f5S3HdQG7f3r4bYytBhW1yC297E3ME/GFK/FsPC6lDO7NqCT2XCwhumF6tcWZ7AwYRQHNXuX0QjALv5Jliquswui0C2GQ+r38Ie6XT4SUHZ29pOHskl5EckbYmPt6JCndTMpcs3JVnxCyNnLLrMHel9P+uRwjrABoSMC+4mxN2Pb0WvtfdbykZ7bi0LplWochyKU8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlCMlVJdnRteTZGalljRzJoYnpmWXBNTUp1M21WSzVFMUdOVUVUM0Y3M29r?=
 =?utf-8?B?dDNNOWxnSVZIeklMWTdOUm5VTGxsV0h1NU1tNGRENTZPWmUwaXlmaGJiM21E?=
 =?utf-8?B?TldoS3lTb1Nxb2IwY2hvNmcrbFRmN1Uxd0tSMktua2szUUlxWFg0VXJRNWE5?=
 =?utf-8?B?dTFjSFBsYlRWZ3V5Y0FLVE1YT2wrZWl4Z21WWHFqMTRlMC9ycFM5dkFaYVdk?=
 =?utf-8?B?VEZKR1JES0VVTUg3UVduZFFNYmszWlpRU25GVXVVb0M0OFplMEQ1MVp0UDcw?=
 =?utf-8?B?MjE1YmViaGhVVkRBcTgzS3R6eHYwdlJ5V1RIMFVQSS9qUnhCaW9Eb1FvSHhl?=
 =?utf-8?B?YWwyOEthSWtuNXd6NzJNS3VzQnNnSDBDdUZrNnY0Umo1Qk9EdDNXZ21SS2U2?=
 =?utf-8?B?MCtGcEVmTCtKWkhxc0YyZTFnYnNJU01TbGlVNFRMY004emlic2c4UWx1MXNB?=
 =?utf-8?B?LzBKcDlqRTdzd3I1V2k3K0tCZUtQU2gvUUZhVTk3eWhRdUY4UzM3eHlOalRG?=
 =?utf-8?B?a1RTK0RNTTYzMUpYTm1iTWZadGtMNE1QTDFuaStaMW1ZcWl3ZkRFd0RuRkxQ?=
 =?utf-8?B?YTg1SjFmMEFqQ3FYaDJJVVZ5aUdCWHg4b2NuZWw3cUg2UEgrOG1FbkdzWi9K?=
 =?utf-8?B?QXBleThPNU9MS2N5MHMvMU15TWhuTEIxcWFlczFEcXAzQ2dBUXlVRDU3Qi9K?=
 =?utf-8?B?QUowRFgwbThrM2R3SjdCb1V2c0hJdVo0MXpESGt1di9qOXBvSGFwdDd1M3lR?=
 =?utf-8?B?N0xxZ1diSkRtZnRZcldFb1JSTHgvaGNhYUNsTFJiSCtvc1VnMXhZRjQ0eVNN?=
 =?utf-8?B?SDlqRS81aUp0ZGpKMlBmai84VHUxaHdHVEhYcTNyUlFhakJQTkNzRllOWENa?=
 =?utf-8?B?SG8wcHhoeWpQa1loN2lWWmdDa3lDanJTY0dzNFpaVGRubjVvOFM3K2c5Z2tv?=
 =?utf-8?B?eXp5U25ad0Q2R05GUVROZlZEcGhmTERBSkJkT3RIN1Y0WXE4dzk2TGlvQXVR?=
 =?utf-8?B?YWNBQzdFdXA3ZkJreWRyVk5seUFKMlJDdnhZOGFtWWZxeXkrOXlxOFRZUUhE?=
 =?utf-8?B?QmtFZURFdzQwbzJTcmJuRFFkWUZzaUNmcG9ML3V0eS9GTnhMWTVtS0FsZ094?=
 =?utf-8?B?V3hTQm9pS3ozUW1wcmFHQzFpVS9FeWN1L0lNbVNCdW92WTR4YVJxK0llQTZh?=
 =?utf-8?B?aVdlazFleTVFc0NoMW14ZkxvZFRBMHpVNzZ6RnVZVnFDazllRHRHR0JWL2Q4?=
 =?utf-8?B?TTV0ZzAvZ0NxeHpVU0cyOUcrRmN3SVFOb2toR1YxaWVzWGIyenhzRHRCbWxQ?=
 =?utf-8?B?aVhGNFBDTm50YmVpRGV3Q05ZZWtCTVVCMllpMHN5bW1VRUxlZUk4aXRYZnF1?=
 =?utf-8?B?TUVibFAyNG1Cb1AzMXdKTG5pbmJKRlUxUlRjeklCWG9UUnAvbDdUSHBVM1JG?=
 =?utf-8?B?MVlYOVlmRWEyOTlEOTRTdEE0Ti9WOTRZK1ViRTM2dmUxOHV1NzgyZGhsSTRX?=
 =?utf-8?B?aURMWjNwaWtUVDJiRnJEeFdZTzRmRU1TMGhWYjZBKzQ2eXd6TWVyVE9wWjJr?=
 =?utf-8?B?Zm1SRWxTeDBLVzI4RFBqb3M1b2pmamMxcHQ2c3Y5Wit2azhLQ3YzZWgySDNT?=
 =?utf-8?B?L2tra3Z2YnZHcVJsK0tybDBMY3NZOXlJL0VEblRGSS9IM2pMVnZMMWw3QS9r?=
 =?utf-8?B?V050UHBqSzRka20zL0YxUE9QS0d0YlNVZ3ZNbnJ4aGNJZ2h6cXk3QTZBZ2ZD?=
 =?utf-8?B?MEFma0FCTURwc0xCN0xiaGtETDZGb1Rnb2VoZnVDRDJ6aGxHYU5PTzRHSEhj?=
 =?utf-8?B?b2dQVnpVZHd5VU5BTDlTc1JhTUFQYlJMdnlMTWowNjFjUGJja2VmdkplQmNY?=
 =?utf-8?B?ZEVPSC9XaWRSbHRQSi9MUFVkRWNzV0hTaklNaWpEMmtkMFlIOFZ6MG5uNzE4?=
 =?utf-8?B?Z3pIYnpqOEZQS3ZrV0NyU05IRzZSSWRkVE5uK0U5OGJVMmRTL3l4WmZwdDg0?=
 =?utf-8?B?SHVtZGhaeDIxazhxdENXL2NkdzZCOHkyOWNicXVVTy94TVdyR3NuNklOcGRr?=
 =?utf-8?B?WldDU09QbERxQlcwdVFhSFY2YitVN1l3SDJqUE5YM1YwcE1kY1A3dE9Hc0J3?=
 =?utf-8?B?ZDZTZzJLYjNJS3ZaRTJ1VEppTDVsTVBiaEgrTmhyYyt0d2ZiZ3ZPQjltNmlP?=
 =?utf-8?B?eUowdUR5cFBYZHNZQlNndVlobmhTWWlUajRRckZQMjhnbUx1ZE9ocFdUOWRi?=
 =?utf-8?B?SXladmJsZ2pTRCtZTnN0elB5b3MzQUZwbEphdG1kakY0K2ZWdlRjT1E0azlt?=
 =?utf-8?B?Tm00bi9QMmNPM2NZRVEyWmxSMHlDazlyUnB0V1ZFOEtGK01DQUF2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VTV+WW2UPOf3xzZziloFJex+RHZFBIzCintZyfsDmUAKMx6ofzEn7dNy5sihw8zmDuZ0fp+7AmG9gc3bEOgfUoM0my2az24nPibYzH8JgZqNaBvodULgclG0iSLyQG/5nLF2yWJWLKdBMrlKHPZxzakU9KOde6UE+7qtwbz2e/r5lkcnRMvzSaDWAcrtetfaZ1C0bvHvnZuICHzrWPduevPxzC6vmM4ErkesvQYPwcdR03zAFLXsbBwbY1mrmNuxsw1ulBHudOy6tUFJFtoTX/LwnGiKvo34mqmkrQh64yAFCO5+uj+ZHJp3PjstGKi6eha0Zik4OvMXowF7JbFgPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddad438-e699-478d-0deb-08dee1abf8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 13:29:46.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZr4pzMYZEBUXueKYEoUfdY4UqVGZwSIIiSJFy+cF5KnWf5qEVhawJblVd5g5pGqig2uHKu2cImDfe030pARwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307474-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:balaji.chintalapalle@intel.com,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:sridhar.samudrala@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:singhai.anjali55@gmail.com,m:jbrandeburg@cloudflare.com,m:davidlaightlinux@gmail.com,m:singhaianjali55@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,lunn.ch];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,intel.com,gmail.com,cloudflare.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2B57553E8

VGhhbmsgeW91IEFuZHJldywgRGF2aWQgZm9yIGJyaW5naW5nIHVwIGFsbCB5b3VyIHF1ZXN0aW9u
cy4NCldlIGZlZWwgd2UgYXJlIHRyZW5kaW5nIHRvd2FyZHMgTWF4aW1lJ3MgaW50ZXJtZWRpYXRl
IGxpbmsgJiByZXBvcnRpbmcNCmNoYW5nZXMgYnV0IGZvciBjb21wbGV0ZW5lc3MsIHdlIHdpbGwg
c3RhcnQgYW5zd2VyaW5nIHRoZSBvcGVuIHF1ZXN0aW9ucywNCnNvIHlvdSBndXlzIGNhbiBhbHNv
IGNvbWUgdXAgdG8gc3BlZWQgYW5kIGhlbHAgbWFrZSBiZXR0ZXIgZGVzaWduIGNob2ljZXMuDQoN
ClRoZSB0eXBpY2FsIEFVSS1DMkMgbG9va3MgbGlrZSB0aGlzDQpSUyA8LU1JSS0+IFBDUyAtIFBN
QSA8LUFVSS1DMkMtPiBQTUEgLi4uIFBNQSA8LUFVSS1DMkMtPiBQTUEgLSBQTUQgPC1NREktPg0K
DQpBbmRyZXc6IElzIEMyQyB0aGF0IGRpZmZlcmVudCB0byBDUiwgS1IsIERSPw0KU2lkZGFyYWp1
OiBDaGlwLXRvLUNoaXAoQzJDKSBpcyBzaW1wbGlmaWVkIHZlcnNpb24gb2YgdGhlIGNvbXBsZXgg
S1IuDQoJSUVFRSBkZWZpbmVkIEMyQyB0byBjb25uZWN0IGNoaXBzIHRoYXQgY2Fubm90IGRvIEtS
L0NSLy4uLCBlc3BlY2lhbGx5DQoJdGhlIGNvbXBsZXggQU5MVCBzdGF0ZS1tYWNoaW5lIHRvIG5l
Z290aWF0ZSwgYWRqdXN0IGVxdWFsaXplcnMsIGV0Yy4NCg0KQW5kcmV3OiBXaHkgYnJlYWsgdGhl
IHBhdHRlcm4/IE5OYmFzZVhZIHZzIE5OLUFVSS1DMkMNClNpZGRhcmFqdTogYmFzZVIgaXMgYW4g
ZW5kLXRvLWVuZCBwaHlzaWNhbCBsYXllciB0eXBlIHRoYXQgY2xlYXJseSBkZWZpbmVzDQoJdGhl
CWludGVyZmFjZSAmIGNvbXBvbmVudHMgc3RhdGluZyBmcm9tIE1BQyBSUyhSZWNvbmNpbGlhdGlv
biBTdWJsYXllcikNCgl0aWxsIHRoZSBQTUQgKyBNREkgc2lnbmFsbGluZ3MuIEFVSSBpcyBhbiBp
bnRlcm1lZGlhdGUgZWxlY3RyaWNhbCBpbnRlcmZhY2UNCglsYXllcihzaW1wbGlmaWVkIEtSKSB0
aGF0IGNvbm5lY3RzIDIgUE1BcyAoUE1BIDw9PT0gQVVJID09PT4gUE1BKS4NCglBVUkgaXMgYSBz
cGxpdCBmdW5jdGlvbiBkZXNpZ24gYXBwcm9hY2ggd2hlcmUgc3ViZnVuY3Rpb24gaW1wbGVtZW50
YXRpb24NCglmcm9tIG11bHRpcGxlIHZlbmRvcnMgY29tZSB0b2dldGhlciB0byBleHBsb2l0IHRo
ZWlyIGRvbWFpbiBleHBlcnRpc2UNCgl0byBwcm9kdWNlIGEgYmVzdCBFdGhlcm5ldCBpbnRlcmNv
bm5lY3QuDQoNCkFuZHJldzogTGFuZSBudW1iZXJpbmcgYXQgdGhlIGVuZC10by1lbmQgYW5kIG90
aGVyIHBhdHRlcm5zLi4NClNpZGRhcmFqdTogVGhlIG5hbWVzIHdlcmUganVzdCBhIGNsZWFuIGNv
cHktcGFzdGUgZnJvbSBJRUVFIHNwZWNzIEFuZHJldy4NCglUaGF0IHdhcyB0byBnaXZlIGEgY2xl
YXIgcG9pbnRpbmdzIHRvIHNwZWNzIGFuZCBhdm9pZCBjb25mdXNpb25zIHdpdGgNCglyZW5hbWUv
cmV3b3JkaW5ncy4gWWVzLCB3aWxsIGZvbGxvdyB0aGUgY29udmVudGlvbnMgZm9yIHRoZSBldGh0
b29sDQoJcGF0Y2ggc2V0cy4NCg0KQW5kcmV3OiBJIF90aGlua18gZXRodG9vbCByZXBvcnRzIHRo
ZSBtZWRpYSwgbm90IHNvbWUgaW50ZXJtZWRpYXJ5IGZvcm1hdC4NCglJcyBFVEhUT09MX0xJTktf
TU9ERV8yNTAwMGJhc2VDMkNfRnVsbF9CSVQgYWN0dWFsbHkgbmVlZGVkPyANClNpZGRhcmFqdTog
V2UgYXJlIGhlcmUgdG8gZmluZCBvdXQgdGhhdCBBbmRyZXcgOikuDQoJSWYgd2UgYXJlIGZvbGxv
d2luZyB0aGUgc3RyaWN0IGNvbnZlbnRpb24gdGhhdCBldGh0b29sIGxpbmsgbW9kZXMNCglyZXBv
cnQgJiByZXByZXNlbnRzIHRoZSBlbmQtdG8tZW5kIGZsb3cgIk9OTFkiLCB0aGVuIHllcywgQVVJ
IGRvZXNuJ3QNCglmaXQgdGhlcmUuIFdlIGFyZSBleHBsb3JpbmcgcGh5X2ludGVyZmFjZV90IGZv
ciBpbnRlcm1lZGlhdGUgaW50ZXJmYWNlcw0KCWFuZCB3ZSBob3BlIHdlIGRvbid0IGhpdCBhbnkg
cm9hZGJsb2Nrcy4gTGV0J3Mgc2VlLg0KDQpEYXZpZDogZml4ZWQsICoqKiBtb3JlIG9mIGEgRFQg
cGFyYW1ldGVyIHRoYW4gYW4gZXRodG9vbCBvbmUuDQpTaWRkYXJhanU6IEkgZG9uJ3QgdGhpbmsg
c28gRGF2aWQsIEFVSS1DMkMgaXMgbm90IGEgZml4ZWQvb25lLXRpbWUgY29uZmlnLg0KCUFsbCB0
aGUgSFcgb2ZmbG9hZCBjaGlwcyB0aGF0IHdlIGNhbWUgYWNyb3NzIHNvIGZhciBhbmQgY29ubmVj
dHMgb3Zlcg0KCUFVSSBhcmUgbXVsdGktc3BlZWQgY2FwYWJsZSBhbmQgZGVwZW5kaW5nIG9uIHRo
ZSBNREkgbGluZSByYXRlLA0KCXRoZSBBVUkgYWxzbyBuZWVkcyByZWNvbmZpZy9ydW50aW1lCXVw
ZGF0ZSB0byBtYXRjaCB0aGUgc3BlZWQuDQoJU2F5IGlmIHRoZSBTRlAgaXMgMjVHLCBBVUkgbmVl
ZHMgdG8gYmUgc2V0IHRvIDI1Ry1BVUktQzJDIGFuZA0KCWlmIFNGUCBpcyA1MEcsIHdlIG5lZWQg
NTBHLUFVSTEtQzJDLg0KDQpEYXZpZDogUmVtZW1iZXIgdGhlIGhpc3RvcnkuLi4uLi4NClNpZGRh
cmFqdTogVGhhbmsgeW91IERhdmlkIGZvciBoaWdobGlnaHRpbmcgdGhpcy4gV2UgYXJlIGluIGFs
aWdubWVudCB3aXRoDQoJeW91IGFuZCB3ZSBhcmUgZm9sbG93aW5nIGEgc3RyaWN0IHByb2Nlc3Mg
dG8gcmV2aWV3IGFuZCBnYWluIGFzIG11Y2ggYXMNCgloaXN0b3J5IGFuZCBjb252ZW50aW9ucyBl
c3BlY2lhbGx5IHdoZW4gZGVhbGluZyB3aXRoIEV0aGVybmV0LiBXZSBhcmUNCglyZWFjaGluZyB0
byBtdWx0aXBsZSBmb2xrcyBpbnRlcm5hbGx5IGFuZCBWaWpheSBTcmluaXZhc2FuKGFsc28gQ0Mn
ZWQpDQoJaXMgb25lIHN1Y2gga2V5IGNvbnRyaWJ1dG9ycyBmb3IgdXMuDQoJRnJvbSBTVyBwb2lu
dCBvZiB2aWV3LCB3ZSBhcmUgcmVhY2hpbmcgdG8gb3VyIGludGVybmFsIExpbnV4IG1haWxpbmcN
Cgl0aHJlYWRzIGFuZCBmaW5hbGx5IGNvbWluZyBoZXJlIGZvciBmaW5hbCBndWlkYW5jZS4NCgkN
CkVyaWM6IHdoYXQgYWJvdXQgQU9DLCBBQ0MsIEFFQywgZXRjLi4/DQpTaWRkYXJhanU6IHRoYXQn
cyBuZXh0IGZvciB1cyBFcmljLiBXZSB3aWxsIGRlZmluaXRlbHkga2VlcCB0aGlzIGluIG1pbmQN
Cgllc3BlY2lhbGx5IHdoaWxlIG1vZGVsbGluZyB0aGVzZSBvZmZsb2FkZXJzLg0KDQpNYXhpbWU6
IHRoZXJlJ3Mgb25nb2luZyB3b3JrWzFdIHRvICpzdXBwb3J0IG5pY3Mgd2l0aCBtdWx0aXBsZSBj
b25uZWN0b3JzLi4NClNpZGRhcmFqdTogVGhhbmtzIE1ha3NpbS4gV2UgYXJlIGV4cGxvcmluZyBh
bmQgZXZhbHVhdGluZyB0aGlzLiBNZWFud2hpbGUsIA0KCWhvcGUgdGhlIGFib3ZlIEMyQyByZWxh
dGVkIGRldGFpbHMgaGVscHMgeW91IG1ha2UgbW9yZSBmaW5lcg0KCXJlY29tbWVuZGF0aW9uIGFu
ZCB3ZSBob3BlIHRvIGhlYXIgbW9yZS4NCg0KLSBUaGFuayB5b3UsDQpTaWRkYXJhanUgRCBIDQo=

