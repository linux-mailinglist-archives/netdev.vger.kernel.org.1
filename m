Return-Path: <netdev+bounces-100820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EF8FC230
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D6C28555D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F260DCF;
	Wed,  5 Jun 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HOj/M14H";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="civXTEZ0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF13211
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717558340; cv=fail; b=SW7hhKvpB00rJUTMSkNbcFB9fbnk1+TBZ1KknveTZMsc/1+FpV+cbctoRttXe8K8Ie/0nbO7V6NzefH4JJ6xyOjpCvm68xn4GWx1HLyOX2v7qo8tyi4gFpJHkbCmdh/zaCJUAIEygl6lntdIYLAIBUABJJa8Q0NACiZrLDo+jzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717558340; c=relaxed/simple;
	bh=gO61XY+GTpQ1LgITtKoG/5NijDDHlclid1HeQnN87XE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyNaHMqq4mqWdrCHG3sg8ynxknOqh4a7iHDPAcCYWDQcUqu5yRibaNCyNYTScJeMOkOYjqF1zhAHDLk6Om1f5H52jouL/vYecAWoyT/vCRKVxlY43tDl3t9HCbIPzGLMXNVaOFb8QMNbIfxw78k7bV1MawqHt9XkduStJuv9p08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HOj/M14H; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=civXTEZ0; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717558339; x=1749094339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gO61XY+GTpQ1LgITtKoG/5NijDDHlclid1HeQnN87XE=;
  b=HOj/M14HoZS9LTPz++V59YuBxTJUV1WZX2TOo2BolYcxdPpoBl307RFg
   vXDzbuPxz/Tc0hPGvrYu9jCktsqZ0hyQDRktq0AOwWy9r3FlVMcTWSck2
   jOOUNyImqE1NaBFUoQCSbc+VFg+i+fUEsmLK0VPYo/K0YDEPmQrVpESI0
   S9GTSyukkjL7DwSVnlChOXxaW+PI35eEheqSj472oBswGf63BriZ5QVK5
   ItZgulfFdPegWjsjlMyX2DDcD9xGFd+C7Qx0wxkhi5RoNH9x/UMUSSMLR
   emH0eloR1zFcepsCHIjkvV5iZtcDvrNoJHXriVI9t7Savuiq5g+rDBxsL
   Q==;
X-CSE-ConnectionGUID: VkxQ7soZTYSy2Ot2x+8guw==
X-CSE-MsgGUID: Ky3TKe/bTKq1oRXVoDqH4g==
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="26990115"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 20:32:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 20:32:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 20:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpNsYWdb/rA8haqvwkCKVZHAIWatqHInPHXqc+K9qKRu6kkQmTe7wFGdmHwfpENQq6ibMogzWOvlhNmm8JUhrW4xKNnRkS0i2hIynj1KrwJ6Aqzy6pVB/AEhXJK0GDInkyBVHJ7R3UWypBQ9U4zHDlp/kyoHQvVhhrF+JIix3UrNkkfkeCDj//c12XEQTZ17qEKbASdBKejSvu2nGSL8Sr63WPGmXU7wy665gYhgzaAenQpdxwwtyCR4osz/MPkzNVBpeq+L/QfTvYOvv6omUOLEkGK3jpUpOBWPUSgKvUy5KQ2aeLkBn0dY0jDRu5ZYb9HRGR3VMtYWv5hZwZGDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO61XY+GTpQ1LgITtKoG/5NijDDHlclid1HeQnN87XE=;
 b=LFkEVDXc3o/sX7oR1+p7O8ZG0qkBhNv67P1mZGl069CsFqb8uIEODvLP+YSySeUDtXz7c2n+S6D58SxWgL+4mAREXFEqDm+lS3fyGJ4klX1COMzO2GgZ4NVTdOkvCKMBYl2wqTSAkXFL6QKpwNEL+DCzF9vnVAbKqXPfQ5aZmuGK3/1DSpSY+A23FTDwQiWNvzLceK/sWKpnNOrD4WSnmfwC+xPe7Bwtm7F1cNNyTeUE6yIA4si9M21fQO6C7gmVCyQ4nc+ONifeunGr5HxDbVIUIH6jmyp89vyccy/dE1+1y2Dn9rMEe3GpDL6n1mYWwLWawUhjEVZem0D9cke2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO61XY+GTpQ1LgITtKoG/5NijDDHlclid1HeQnN87XE=;
 b=civXTEZ0vQjFXzRiVUj03+mRLa8m3k8t5t6t1Lt43V2e4oq/mSarQTrVDukLCuFjLlj7xokMOQGSlZbGDSvmadhSz7IoIYH0lcMxSsvQQfQhkLrSkcPMCIcyNavIc0vW5MivtCyX1qxPbQ9u4hy8eprp3KzKydBvWbVmGbwlFYOK0q35CM19R/eS/WxdMtFxt7VvRTRKuMvDImMvcIoM8e7oS73jd9W2ywRtWyD2bRIxw/4ctID2nrCaisNHLRNGsEPaJfTUf0p8ajKkeX8kM1ZM5M424EQQA9ionMOc2qMPKjJTTDOJcwCPBb3GTcX7BrQAwbBcGcRac5rJc6dMZw==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by PH7PR11MB6697.namprd11.prod.outlook.com (2603:10b6:510:1ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 03:32:04 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%3]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 03:31:36 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <horms@kernel.org>, <Tristram.Ha@microchip.com>,
	<Woojung.Huh@microchip.com>, <hkallweit1@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Topic: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Index: AQHatmDvhM1pPMRFbkufEkdpo/QqJLG4hY+A
Date: Wed, 5 Jun 2024 03:31:36 +0000
Message-ID: <4a3070182e56ca21d9e07e083f30f82c1e886c3f.camel@microchip.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|PH7PR11MB6697:EE_
x-ms-office365-filtering-correlation-id: fafcb2e4-4cdf-4d95-7a49-08dc85100118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VExVNS9MeHJGb3N3MTVmQnMvS21vVlJTWVRiY2dKV2sxQUhJV2MwTndpWktK?=
 =?utf-8?B?TmFDbkR0ZU51Z3JGSDNnamVoUmZKQllFa29rdWNqc0VYYURYcHZsSHoybFpV?=
 =?utf-8?B?bm4vUEliVjJ4OVNuV21rVjVmWlk0U2FJbDc2bGhsby9GNUx5UWY0RVAyLyt5?=
 =?utf-8?B?R2V3akFCall2aDZIR0ovWmZFYUhpWjFnUjFhRTUrajRBZWgxTFZBemxPekl2?=
 =?utf-8?B?cDZEdkxPQ0h0bWN1NnJnd0g1dmtodlFKK3pKWWpuKzVjdEs2Q2J2bTRFeEVJ?=
 =?utf-8?B?QitVbjF3QmtxQzFwQVZ0Wm5xVUgrc0NtQXVRdlM2azY5ZSs4bVUwQmxTWWhZ?=
 =?utf-8?B?QWhVNFo5NTlDdlRHWUs4Q1R3clhYUXFrb1k3MGdqOFcwZFJvcVBEcCtqQWRT?=
 =?utf-8?B?WXZFV3FONUlZK29TS2xRalhzY3BHVkwxcUxMNDdoN0VwSndqWVB4cWdFbzlx?=
 =?utf-8?B?RFhrVGpVdU5VZmpJZUlnTkhydVArWkEvdURjV3VVZTNyZmd4NmVpdkFwRE9Q?=
 =?utf-8?B?RkNJRVl2VUlPbk00aXJ4a3NSZU5TdklGUzF6TTFuK1hIZ09aekVoQWVyZU5U?=
 =?utf-8?B?b2hLdGt5NUhuTi83WG50SDRoVkpzSDNuZ2hMTzZDN3p2ZndOcEtVYTZEYVFp?=
 =?utf-8?B?WkxIOVJMK2NsZDBEVXZFNVBKQ3NXTGZ1WXNLOE1uTEY4SjhBWHBNZ3JEYUJF?=
 =?utf-8?B?dFJnOVVONmN2cGdwV05qZGFXYzZiUmdxeFBDN2lNRkdxTk1JSUI4RXRBTlJn?=
 =?utf-8?B?T214MEFnNGJqM0NiK3pvVkpBK3hmbGpvZnNSQ1lDWjFOZk5GRXY2V0FtZUc5?=
 =?utf-8?B?RXN1L1NVMHI3bHJUaGxyV1dyZjFTMVZtV0RhUnJ2TUU2R21UdXZCd2lWdEVa?=
 =?utf-8?B?c1V0K1QrV1VHYlJWaERlRDJDN2VSd0dWVmZhbE5sQnNtOC95THVISWJoWDhi?=
 =?utf-8?B?SlFicVBianltUVh6Um9kVmxaYzcwdkZHdVVOQ2xEU3FKTWNwU0VMK1BqV1hq?=
 =?utf-8?B?Q2h2WGJjWkdZU3pOeDJoMXBpSGJqVGR5czBwSHloTWs3ZGF4VUhZQWhwanE5?=
 =?utf-8?B?akRSVzVJbHRhTTFvb3RxUFlJK1lneEdoK0NSckxaT0x1a3RNSTg3SmFNV21O?=
 =?utf-8?B?K3NQeDNING55VElBR0JXSWRoM2pwWTc5bXJ1WXRzWlBiMVlWVkRHSW52L25X?=
 =?utf-8?B?ZVFTOWNrQXpRbDIxeDNrdXRCdmZmR3o3ZkVyVlNWNlhUWCtiamh6MGxtQVZ4?=
 =?utf-8?B?UFpDNjZ2cXlnN1dWdnhUUkRsR0M0RXdOTzcyVUNCVFc3UDkvc0xRQmt5Yzky?=
 =?utf-8?B?MUcxc0dYQUh6U0UrTFhSbURJTW9DVXoxc0Mya0dDajNUREhlQnovVXkrUkVB?=
 =?utf-8?B?Wi8vVjYwek11aEt4cEZ0T1ZteWhMMTNMSW9uV0dWS2JYQytjK2pUc25zbGJQ?=
 =?utf-8?B?eU5TOS8zM2pLUFFqUUtoN3dacUNwMFpUd1pzcmo2UThERURacXdJNFFhclZV?=
 =?utf-8?B?a2FpVnFFaUROdTdTNWtsd0YrTlUyT2JiVmVKY3F3d1Rsd2wyT0E5R3dlZzV1?=
 =?utf-8?B?SzNqVFluaEVsLy9YdlB3Wlc2OUdNUVBNamFIMTRuMkNVUVZDcHdGN2FBbXdr?=
 =?utf-8?B?NEdXT2JCdU1qNE5GaHZDdlhMR2ZUZ1FpWUtJK1phOFpnNVlIbTQ0OXRGVG9h?=
 =?utf-8?B?QkhYOG54RGZFaURJOFYwY3RWVmdKS1k2VmtWZEFVVGRuQUxJN3AyK29KalVm?=
 =?utf-8?B?dUlJL0NKanJ6RVAxTHFJd0p5aVpERHpRdUdrY3c4bU9kKy9kZ0ttWERkN2dy?=
 =?utf-8?B?QWtaQnRMYzVlbzR2YVRkUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um5Rcjk4UWp6ZzI1T0FaYXk4QklDK1Vad1Y3eUNwc2t4blVKUEhQRzQrYXIw?=
 =?utf-8?B?MUhoSGRNOGY5K21BRGxpaXhZNVpOaHBLNURkc01XNTJGRHpPazBVY2dQMCtu?=
 =?utf-8?B?aFBlN3dlbHpobDd5N1JlbmowVE5GWGJTN2pDZzk3ZlZKYzBGRGFPNmVPOU9L?=
 =?utf-8?B?S2ljaG9WemF6Mm9XNmptVm90Z3hXMzBtQ2VGQ0dpemc4NGdtNGhKK2g1Y2ZG?=
 =?utf-8?B?Ty9Ld0V5N1dnaHJLaUZBYWsvTlA2SE5SZ3pwV2VjV0NQOEREQi9QdmhWUHNT?=
 =?utf-8?B?c0xIeGRQTXF3c1d2VUNPZWZQd3pXemZvNHNFNkRMakREeTBRWmFIMTN5a04v?=
 =?utf-8?B?UzBWUFQwZ21kQlJpdnM0ZkM0ZXg1WVIzeUNQNmhsbS9sZkFoYXZvaDZUMmEx?=
 =?utf-8?B?MldQZVRDRWhMdWxySkpjeGppbVBCQ1VvQi9pUCt5ZXlIMjBlRExiWG9xSGlI?=
 =?utf-8?B?aC9OdDdWRmlPWi9tU0RoZWRndGMwbGtvUDBranF0R2wyQVB1WmtWZkdIaHJM?=
 =?utf-8?B?eXRyWDlZUlRWVE8vNkZERG5aQzdaV2oxUFh2L25ZVW1aK1RzclkzWm12VlR0?=
 =?utf-8?B?Z2s1M0gyWFBFclBtbC9tNW1DSk1PNzVwQlFLZmpNa1BSM3AyWEoxaWlIeGhO?=
 =?utf-8?B?aytPZnFrTWVCOWlySXUyTEpWZ2JOSW5jcHNDOVFxQlQzTkE3UURqSlNkUHVs?=
 =?utf-8?B?ZXdUR3R4aXVGRFc0V1RDYVlNbkhhWW93Sy9xQmRmcUgzZFM1RndmcTJnc0xO?=
 =?utf-8?B?TmQxSHBvSVpKdWwwQllEWlJUZWpGUXJNSmN6b3N0elY2eVhNNGpWK2pQYVJs?=
 =?utf-8?B?UGNpZDZtSzMzUmVIaFpGM0hibEVFNlBWNWdBTmx0YVpJNFErek9FdDl5SHhE?=
 =?utf-8?B?ckU1WnZhWE9Zd3ZHTHZqNGcza0hzM0RwOGhHTitJTmx4Y0N2dzJDc3RRU3Bp?=
 =?utf-8?B?WXdPWHhIem1ZN2wxU2QxMGhnWHFwU3dYbytSVFVGM01LdnU0WHBhd2NVWlYy?=
 =?utf-8?B?VUo2Z3lhVS90djlrYkRuck4zMGpoR0t3U0NHbHVEckNuN0xmVnViN3hFM2oz?=
 =?utf-8?B?cmRmbG42bVRaYUJLK0JYN3pkVXo3dmNkajcrbkx0VUd2VDgzb09UcVFaUFp1?=
 =?utf-8?B?OThLTzVkT0VEMnR5WklFL05WSVBRQm05a2s0Tk1tTmtHWkZFd0ZnbmJGNEFE?=
 =?utf-8?B?cVR3TmFjb1UwRENMMHlITHdFUzN3c3BJMUEyZ3g2THNpeXFXeTIxWjZ6UHh0?=
 =?utf-8?B?NXV0YTNrNm1YQUxzRmg4MDdTSzFQRlpENkg0aWtGZWNQYU5qWGJ6WlQ2dDNP?=
 =?utf-8?B?MW5EYjlEOGdFNmV3QkM2N0FjaitQc21BV3ZWM0JlbGpGZktBMXJsRVh5M0oy?=
 =?utf-8?B?aXNrcStqZXZ5WGh6R09JWEEyRDBuZmZNNnZvdS9LS3hHN1prVUdjV2Rzc25u?=
 =?utf-8?B?V2xvUXJXa2JYcytxL1NINkgrVWdudG8vV0RTdXdyYTZUYjFtOUkvZzVEbFBj?=
 =?utf-8?B?c2l4YUNOa3QxYTdQNEJUYVk5TGJuTnhlQmt1Y1hDRGZTY0xYM09JRjREd0Vy?=
 =?utf-8?B?SzNMRFRzVzYzaGZnNjZPbWUzWUpkSE02Y3B1eVlnRDNkcnNWdGdQeEl3d3VP?=
 =?utf-8?B?bWlZa01TR3E5Ti90NzNLRytDY2pQNmduV1FJNWFqQXNzUEJvSHMxMXJiTzh6?=
 =?utf-8?B?dzE3WW5laktOSmpQWUwxQkppbk9HNmNyWXFoY3NiZmJ3Mk1IWU5zbFR4V0Zr?=
 =?utf-8?B?UVJJL1BuSlpFU1h4V0lkMjVTNTNHMGdkSUtBN3BUT1VKM3ptc3ZlSktZbDRC?=
 =?utf-8?B?UzY5bUs0U1NXWHhsNFlVTDZqaldJck1lUzcreGN2SjJCSStaZjRsUkM4UFdX?=
 =?utf-8?B?QmJabTVFTGJZTXpVSktsK2t3SmJSelZDV0hjOWw5dXNTMi9sakMzY3VpalBm?=
 =?utf-8?B?Ulo2b0VwaVZQbWxtWmI3K0Z5STlPWEhXdFYzdnpjYzZQWGxtL0RzazVyb1lB?=
 =?utf-8?B?LzVzelhtWlFSTWx2eU51bjRWK2NrRkwrS2JPRTkzOXpzSXVlSmUxUHZyeXRR?=
 =?utf-8?B?V1pnUmM2UkJHaHJoQnhCWWk2Z2tIZzZEVmNkTytNV3ZiZXFqWHJuTkc5cm5i?=
 =?utf-8?B?QnBVUTFLQ2taUmg1WUlFUGJiMXF5WjdPb0FlNVVGbFpjUldKVDlSditSdTFx?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B516CABEB43B464BB2907F7481D90431@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafcb2e4-4cdf-4d95-7a49-08dc85100118
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 03:31:36.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa1cPP2wW2zU6tSiWjZKwXDCNxsxTUH3sfbiHY+oSGptO3h5Li7oNSZu4ybPxmj4d1W9vxQTAZF4IaNE/EJp3r09fztr+DBixDbA0KL9ivM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6697

SGkgRW5ndWVycmFuZCwNCg0KDQo+IA0KPiAraW50IGtzejk0NzdfZXJyYXRhX21vbml0b3Ioc3Ry
dWN0IGtzel9kZXZpY2UgKmRldiwgaW50IHBvcnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIHU2NCB0eF9sYXRlX2NvbCkNCj4gK3sNCj4gKyAgICAgICB1MzIgcG1hdmJjOw0KPiArICAg
ICAgIHU4IHN0YXR1czsNCj4gKyAgICAgICB1MTYgcHFtOw0KPiArICAgICAgIGludCByZXQ7DQo+
ICsNCj4gKyAgICAgICByZXQgPSBrc3pfcHJlYWQ4KGRldiwgcG9ydCwgUkVHX1BPUlRfU1RBVFVT
XzAsICZzdGF0dXMpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KDQpCbGFuayBsaW5lIGFmdGVyIHJldHVybiByZXQgd2lsbCBpbmNyZWFzZSByZWFk
YWJpbGl0eS4NCg0KPiArICAgICAgIGlmICghKChzdGF0dXMgJiBQT1JUX0lOVEZfU1BFRURfTUFT
SykgPT0NCj4gUE9SVF9JTlRGX1NQRUVEX01BU0spICYmDQoNCldoeSB0aGlzIGNoZWNrIGlzIG5l
ZWRlZC4gSXMgaXQgdG8gY2hlY2sgcmVzZXJ2ZWQgdmFsdWUgMTFiLg0KDQoNCj4gKyAgICAgICAg
ICAgIShzdGF0dXMgJiBQT1JUX0lOVEZfRlVMTF9EVVBMRVgpKSB7DQo+ICsgICAgICAgICAgICAg
ICBkZXZfd2Fybl9vbmNlKGRldi0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiSGFsZi1kdXBsZXggZGV0ZWN0ZWQgb24gcG9ydCAlZCwNCj4gdHJhbnNtaXNzaW9uIGhhbHQg
bWF5IG9jY3VyXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0KTsNCj4g
KyAgICAgICAgICAgICAgIC8qIEVycmF0YSBEUzgwMDAwNzU0IHJlY29tbWVuZHMgbW9uaXRvcmlu
ZyBwb3RlbnRpYWwNCj4gZmF1bHRzIGluDQo+ICsgICAgICAgICAgICAgICAgKiBoYWxmLWR1cGxl
eCBtb2RlLiBUaGUgc3dpdGNoIG1pZ2h0IG5vdCBiZSBhYmxlIHRvDQo+IGNvbW11bmljYXRlIGFu
eW1vcmUNCj4gKyAgICAgICAgICAgICAgICAqIGluIHRoZXNlIHN0YXRlcy4NCj4gKyAgICAgICAg
ICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgaWYgKHR4X2xhdGVfY29sICE9IDApIHsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgLyogVHJhbnNtaXNzaW9uIGhhbHQgd2l0aCBsYXRlIGNv
bGxpc2lvbnMgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2NyaXRfcmF0ZWxpbWl0
ZWQoZGV2LT5kZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJUWCBsYXRlIGNvbGxpc2lvbnMNCj4gZGV0ZWN0ZWQsIHRyYW5zbWlzc2lvbiBtYXkgYmUg
aGFsdGVkIG9uIHBvcnQgJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHBvcnQpOw0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAg
ICAgcmV0ID0ga3N6X3ByZWFkMTYoZGV2LCBwb3J0LCBSRUdfUE9SVF9RTV9UWF9DTlRfMF9fNCwN
Cj4gJnBxbSk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICAgICAgICAgcmV0ID0ga3N6X3JlYWQzMihk
ZXYsIFJFR19QTUFWQkMsICZwbWF2YmMpOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICAgICAgICAgIGlm
ICgoRklFTERfR0VUKFBNQVZCQ19NQVNLLCBwbWF2YmMpIDw9IFBNQVZCQ19NSU4pIHx8DQo+ICsg
ICAgICAgICAgICAgICAgICAgKEZJRUxEX0dFVChQT1JUX1FNX1RYX0NOVF9NLCBwcW0pID49DQo+
IFBPUlRfUU1fVFhfQ05UX01BWCkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogVHJh
bnNtaXNzaW9uIGhhbHQgd2l0aCBIYWxmLUR1cGxleCBhbmQNCj4gVkxBTiAqLw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBkZXZfY3JpdF9yYXRlbGltaXRlZChkZXYtPmRldiwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlc291cmNlcyBvdXQgb2YN
Cj4gbGltaXRzLCB0cmFuc21pc3Npb24gbWF5IGJlIGhhbHRlZFxuIik7DQo+ICsgICAgICAgICAg
ICAgICB9DQo+ICsgICAgICAgfQ0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4g
IA0KPiANCg==

