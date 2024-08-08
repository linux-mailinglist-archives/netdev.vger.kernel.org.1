Return-Path: <netdev+bounces-116930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA894C1B8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BFB25763
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA871552F5;
	Thu,  8 Aug 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rx/Yg8pp";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HLtefKZk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BB1DA21
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132011; cv=fail; b=H5Qvg29A334y1uSEdM56+fRWBic6OyNrFj144Dcv6WYLjTOof5pASEucKGQ51TNcIMbsmx+6qn3zX1DcWJo84YPlmYHPA4i3a1wgcgcQ44w2BpfEdRT+W8XWsJl1wKJ0jmYsNYPK3sxmH9VtO9jN1t+QL8CYB52BNYcgtuFlNUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132011; c=relaxed/simple;
	bh=TgRbL1MzL9aUiDpj/sI7YVxa+YcSi+N9p0JHUbD0lRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zf6nFIGhVBv51TO0/E0ty7jCQL3GxL+nRIAoYBdM+aH3nHSqxGR5bNh2lhbUWdLUPbV6sFdasTxVQeBDpcqqCOvThnEI728xVHQyQ+5z9QW+scXAdnNXRyxes38nGiWTdJ2eJwNu3GdNo28lVC/+RLZK9gN5GelpIAhDUo1smWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rx/Yg8pp; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HLtefKZk; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723132008; x=1754668008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TgRbL1MzL9aUiDpj/sI7YVxa+YcSi+N9p0JHUbD0lRo=;
  b=Rx/Yg8pp5P0c+PfledQ1brfANECfodP7wR+KuzPpz/TrNcL5ELuiPoN5
   9p3GeTVTngH3RG1W8PlqXoMkEUuvYle8L/krNUHlVSgGGjOYcqaSeHlHM
   BTGhdrJHfUilZslX80ibF/PLwIOuPoR45YhkBOxasuUxAIW135gkAfyhv
   wOPUMuw4/jL8Dy+OcRUWy59RH2t31Fs3e2kRk3uoS9/Os5vIAW0t+3N0X
   MLaYCpM5mLx2mAMQpWIIkI0s99eHUuwRvt+pSMArR8e+DUOBmKchRhKtC
   Bc6o+GnHXXu/bpL81oZbF5zF7L3Dl77QzCVb5sgnjgjOBHzkXRlXhJDVG
   A==;
X-CSE-ConnectionGUID: /7NPunroTZiQLBHpSrnIrg==
X-CSE-MsgGUID: 0N1WH9bqQxGsKfSldDiwPQ==
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="33152541"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 08:46:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 08:46:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Aug 2024 08:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX+6dY+2YxAOjSPSwqKE0t39G9mTw6MzRq2WbcHCib6THfpYog9ZwB77f+dQUE/xrTFile9iLOlvUVWfrd+k5S+Fl1zcJKdlpHQhCgVnq4d660NxL4Bvxe1uYzue0yQz0IeA3Xw/P6xv3MRfmlL99A3T/hE/ztsdsGnQjdxdkyXyf47IRQoOs6BwQFy72K4zhx1Xg7EtNIh1xhAvak43oeVrqI4M3ChdeCO+tPQT2sZyVZJj+i5v+w7JVrHs2uD7pvYSG4fSMLlWu3gCK005gsU3s4FwysJ9kFnHTfxveMfD959/ivDNemEbrLMOV6xMtwUxSqVZcRWnCxCqThnVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgRbL1MzL9aUiDpj/sI7YVxa+YcSi+N9p0JHUbD0lRo=;
 b=Cb/cphKRiV/Bk0IyWsSqGFwl0ezMlPu7vh7oavz4ea00u7T6dU3vw7WbJYTtr21eYzTpX5xB2BxK0TOwrRdnaczsrivc5PpfPUVFWyDFO+riUZhzEaom3gGuY32orPDoXiDejJjJXMVtaxqdXkX7aXQZT7Fn/oWnknv/OHBo0vf33Rr5yAJ+psJE4c0TcuASFf0fWJj1UheCtOBFO9/9JEiMvU1Rw/TP8e+/ME83p5nC6qtD8O+9wYhQ56EzwqL5lGQnz50DAe+DRwMhoRoOcvgc0d6BGIqA4xs35IIEk83RugTpPENdMqPw61Y9rV/TS7KIInCYqHvvGQtCPGEoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgRbL1MzL9aUiDpj/sI7YVxa+YcSi+N9p0JHUbD0lRo=;
 b=HLtefKZkQ40NJ2nSoE2p63yJUpEO0ctJn8yVXoHTs3AJ0lTNYgmD1zrRABQVvfoT4f7Qx+36aPCBMZqsHqi5F97/nVKmgi4d35WnTJvBWYYUipCGIXfayzU1z6ZWcwY/Yr/M8IQsH950BS/Snv6nRmQBY7MGEyKUjB3isVDje8JyZ2MMe9+uHhQtGPNawBQYMQ7UdKPIx8IGt/pYcCB5RmspTGw0qch+v0BBmrkDoxk11rULmdI703ASECR2mPn8TtvHGtLR+Yd4Ko8EdlgByNm6AtwJhswj7GR+9mKtC2qlXGqeNiCE1xeGsCDT85Wm7330iUvggs4N/TSscPZoBA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Thu, 8 Aug
 2024 15:46:26 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:46:25 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <Tristram.Ha@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<hkallweit1@gmail.com>, <Woojung.Huh@microchip.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: ksz9477: split
 half-duplex monitoring function
Thread-Topic: [PATCH v2 net-next] net: dsa: microchip: ksz9477: split
 half-duplex monitoring function
Thread-Index: AQHa6aW7r5mWP94f9EOD2QJDU2Vy1bIdgaeA
Date: Thu, 8 Aug 2024 15:46:25 +0000
Message-ID: <80730209b2e6a6288f0ce885c0ff3c04024c40a8.camel@microchip.com>
References: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: 21c59107-7a3f-416b-c87f-08dcb7c142eb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFJuTHoya1JuMDU0aEJ1V3RTTmNCaHZmWjdVTzloK3BtSlZ3SUM4b0FSZHJk?=
 =?utf-8?B?WTMvQ1VhdTlNUEpIdVhXRGRka1NXOFNVeVdKWFNBdVM3em0vSDRad1ozQXdS?=
 =?utf-8?B?V2hXOWNxZGV2SUlzMTJ3V0FtRE94YXpGVDkwSXdzcGo2TGdOUHpXMXFKZTJ0?=
 =?utf-8?B?LzJEMWtOTE1aeEl2c2xVNFJKRThhaVZOcDNwb1UzMTFrbWN4QnFGTlAvYkp0?=
 =?utf-8?B?M0NaQkQyVmV1bk1Wb2pKa0svYzBaTGltVFp2OFNSWkFpTDJMK0RMeVpSMjNr?=
 =?utf-8?B?TkpmZ29CVHRzWVllY1FQZ2ZGYnAvY2lGOEY2dnBEUWtVNmQvTmJKejBJNGtn?=
 =?utf-8?B?VjdzNk93cjZ1QUw3L1VNYjBlNWRUMm1adUhEaHhwRWhlLzIwVURCcG9rNlk3?=
 =?utf-8?B?ejFLNkx3MDNlNTVhVVpyWGR6U0xPZFp2aG0rWTgvZ09iL20ydTFPd2drYjFV?=
 =?utf-8?B?SjNOeFNJeXNKM2xQNDVIMGVCSmtQQUY4Z1NIb1JBRjErOThUbDFUNzZYWDdw?=
 =?utf-8?B?MDNZWlR5Qk9KUkpQWXBrODdLYmNsb2ZkcVExbDRPNGl1SnJsL3RGQlNkUjhr?=
 =?utf-8?B?L2czV1ZRV0FLMDMyNmVFRzBpaVFWc2hTanFUU0pQMVVuS0hiaktzanEwQjlS?=
 =?utf-8?B?dlhDUk1BZjQrU3l2QWEya3cyOXV2Rm9QK050cGVXbFNXUTNMckNIVFlaTXo4?=
 =?utf-8?B?d0Jsck8yWWhLNitLMFV6eHFGYXB6ZmJGUWRwRjNpSmtaM0k3Y09UOTVoZVFN?=
 =?utf-8?B?dWtMM29ZZ1J0bGRqaG1pRUphWHpsUWk4VHJ0ajRpMUwyZ2V6aU0wVDR2OUNW?=
 =?utf-8?B?MjI3bCtING5vZERPMXE1WG0xeVo0clVXNnlhUmN0WjBhTHkreGI3aDAyTjZK?=
 =?utf-8?B?ZzNJK0ZDclExOEtLdFJpb1V6T05vV29FQlNaMVdFU0JkS0JFcXY1N05qeldW?=
 =?utf-8?B?R3VuYkFyckxUN05scno1bHlLUVpmN3ZyVHdVWUhyNGpPSFgrTC84QTZzZCs0?=
 =?utf-8?B?OFUwTnRtN1FtOGJWS01raHorUGMxMlQ2YlB4cVV2UWVXNzhWSkdBNzhDSjhS?=
 =?utf-8?B?MGRZeGdqYU1SWVdrQ3VIVkpzMWk3SWd5cHpHaGR3b2tUelVhZmc5aHdEZkdv?=
 =?utf-8?B?WXFIUlVxZmxiT2czbnN0MWZISFRhQStFeXM3dXRaNm54Y2pXbHpvMGdubWxI?=
 =?utf-8?B?ZWZsWFJGQTJRZWRzSmk4Z3RaMnBNRm04N0NJNVRPaEQxWTdRUm9qQk5lSllk?=
 =?utf-8?B?MU5TMXpuUDVjYTlWZ2NjbVNERk5DSFlkS29mTFhONWZBVjNnZmo4VmMxLy9C?=
 =?utf-8?B?Y0U0RVVIbGtFNnZoTUxRMHgxTFlaMnlNS2luM2kzMjBLL2puRXQwWCtRWXhD?=
 =?utf-8?B?VWNrMU1taW9xWTFvVUhZTUdTWUVQeHlncjlRME9waTMxalZDZW1BOU1YNHhy?=
 =?utf-8?B?WUJOTlJJOVVTTU1Ud2VOSG43Y0VnVzE4c3FkVndOZUR5clFpNU5BUjJSUjJT?=
 =?utf-8?B?TDJudWg3aEUxTDd0aXkzVVp6YkdZcWczb1FTQTZWMTJmTTFsbjB2Wm5OL2dh?=
 =?utf-8?B?TXprc3ZLSFRpQ284dEVuTXlWRTNyMEhVZThDY2ZGelJ0SEQxTCtHdEJMUFRP?=
 =?utf-8?B?Tk01Qkh3NTArazNjelZVMzM2NVJKUjRoWk1LYWZDaEwvbW1WMFg3WUJsRXNz?=
 =?utf-8?B?NzlyS2lXZXp4dTVwU0doZENrbzloR3UrTnVISzJYL2Y3QmdyUEsrenVyaHRD?=
 =?utf-8?B?M0drdElXUG5TVVpWSFFkN0tXcjBJcnRMYnZBOGt6cDNlQ25MckdwbWFQSmhi?=
 =?utf-8?B?ZlFoMTNINWc1cDZPcmZxcWdlTEVOMUppTzBnUVh0bWpzQ2hCOERqbVhhSnBL?=
 =?utf-8?B?dkkydDE0YnpiQ1RKbEJXVVdpNVdSN28rSkkwSzVmMGxOT3c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkxHdFJSWkZSMWFmVENRS005bmphK2Faeng3cDBVTWplWEYyT21mVGtkbzJU?=
 =?utf-8?B?UWxXK2JqWGduME9kWUdodDJhWFZCcktwb0ZzcTJnYzlza0dveTdFZzRnQytl?=
 =?utf-8?B?dmtkcXhkdlcwTzBtY2gxdTV3djZmUFlCYmNnak9WbE9CNkZrT3NvM20wMGp5?=
 =?utf-8?B?aTBuOUk3dTMzb1V3U3Z6RUNPbmhtREV6RHExWjJ1WGVzVDZhUmVBODk5alJP?=
 =?utf-8?B?MWFFTHRMdUdKR1VDS2xTcTFNSnd1ZC91aVpSYXBJRTc3Y2hPNzIxQXlVU0k4?=
 =?utf-8?B?RFkyZ1Rxalk5eUdzcGFWRmYzVDFGS0lyWWRqd1FoQkVaTFNuMmFzOWFQVmx1?=
 =?utf-8?B?NkxVU3FMU2RKUWhKcXZCRkZINHkvUXRCZnhudGU5TEFvRUR1aDJZdmNBTTNs?=
 =?utf-8?B?aTdEeHkxNUN5ZzArMjI5YTJoZDA4YjZ6NWtIOHVQR2gybDdlK0Frb3puTUp3?=
 =?utf-8?B?RFpCdkRJd2VvbFBCajkxQmQ1ZDVJSEUvelFDcHdIQlg0cHd4V3ZUeStzUmh2?=
 =?utf-8?B?aGcwVU84SFZhbVphRWM2QzQwamNhU0FJeUx2YlNhaDhIUjNEQlB0TlpwOFNI?=
 =?utf-8?B?T0FHU3praHpWZDFFTEhIWmFKaUhLQTZDT0R6czhERHlxYy9MQkhTMkk5clRm?=
 =?utf-8?B?Mm1CcEptRENtM3ozclkxUkVtdmlIZENQT1BUWDdpY2RPYTBScUMvb29tV3Ev?=
 =?utf-8?B?N1dONGh1VjZyek1aSUhjakMyYVlBK2thQy9OT0tLcjEwUnBUeDliWVNzN3Z6?=
 =?utf-8?B?bHpwaGZseTFtc0RxSFNleEZHMHo0YnlQd3ZuZWxPNkJlOStFTlNFeitRa2kx?=
 =?utf-8?B?Z2I4eXRVVmZjTzg2ZmRTbjRyN1Z5c2lzY3F0Z2JBZHdiNVhpYlhGY3R4ek1v?=
 =?utf-8?B?T2t4aWVwUkpaRUo5d1hPOGVKTnJzSGxaVzZXeG5NRlJOOEpUaUZ3dDBWSW9H?=
 =?utf-8?B?bWtEWTJlaFNsbHR0OGE5QTVBajY2QUhrc0FvTHVxd2FKazhBVEdqeFk1U0Zp?=
 =?utf-8?B?NTNtVnZ4WEpSTFhseTFxWXozRDUraE9hWEFValRnWXduVVJ3bWtHRUVON1lo?=
 =?utf-8?B?aDlKbys3UDBiR0oyRGM4SVd3anNSLzNHVS91Z1pkZ1h2cVU2R1JrMGd1WVF1?=
 =?utf-8?B?ZzVQcVI1L0FHUi9xVDFrSXBQRi9oMGJOeDJUUUJLaFk0UnhyVC93WkJoREwx?=
 =?utf-8?B?ZUg3QnRNb2pMZmtTa2hjaHhhUWlFNWEyVDdiQURURzN5ckQzb1E0b2FMbWNn?=
 =?utf-8?B?RzlhSElKbzFHb0U5Kzg3MjZhNjNoUjBnL3FNaStnUUVyZFY3RXZlNnNPVkFp?=
 =?utf-8?B?WDlJbGRsWFcwMGl3c0ZTZGhpcUlNSk9UdTFqWTZRcDRZWGMxR3lnSUpKZWlC?=
 =?utf-8?B?bWpzTWVjYkg5YkxiYVBaVEprb1FHTGc5Rmt0L1AyU01QSkJxTHZhRDBseWRu?=
 =?utf-8?B?dUxpUHg0STFpRmFFamd5VW1PcU5pUFVGU2JHcTBIdFlZOUh2R3hwRUxjMUg1?=
 =?utf-8?B?clpSS1hHaExLRTcrbHRmbGFITkFTcTNWMG5WNTdFdGhqSjJOWXJBeWdPUlRH?=
 =?utf-8?B?RzJvMWJvM01YNHBSV2NEUEFjL2JzOUdlb1dsVk5LYldhMmFEUFpRb21aWWw0?=
 =?utf-8?B?ZzFHSE9OOUhzU2o4d1RtOTYrbnB5WHN5T2ZmVEY0eHh0anl6S1NmSDV1OU1Y?=
 =?utf-8?B?MFBBVFYyVitHam5GTGxxYmxNY1Irang3UmVvUldpV0cwUzhUajd2Zjk4ajVa?=
 =?utf-8?B?R1FMUGZVYk45bVlsN2pjTllqbTN5VFZkTlFsb3BzcTNtRlVNVDBSZkc5S2E1?=
 =?utf-8?B?ZzRjYUVSWVFOTk9ranQ2aDNXcGVsaWhqLzJjdk90RjM5MUMvRURjaVhpdnJJ?=
 =?utf-8?B?VFUyTHJLbkpTTEk4WENxMFZOUm02cW9kNDJxL1Rpdkp2SWVNc0dXbEpOb0R0?=
 =?utf-8?B?Y3R4MC9DQXZGYTV5S05EN0NkTUdCTkpoVEhVQ3RiMzZqeUJDMUgzQ1NpRGJh?=
 =?utf-8?B?bjRTQjlTTnZFY3lERnVYZlN6QmZyQmZXelBtSitFS1FWS01BdSsxUGJTblpE?=
 =?utf-8?B?ZGMvYjZVMlI2Ty9hUmg5QkMyS1lkZlFLd2VhSHlwSE5jekg3OExNakNNdmt2?=
 =?utf-8?B?QVNZWGVmdnk5OEw1aXRFVVpKSXEzMWdlWEVpZmQ4OUJvNkxiUWJKY0UxK1pO?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09C3A6E1093344A81788489E225AA76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c59107-7a3f-416b-c87f-08dcb7c142eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 15:46:25.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv5ecEStuDPPlGDwI6pjj7AhX2Uy7CUtXi7M+H8L6URcTDewYjfnxoHv5CeSRfS7fBWG2zdavPpFcyMnl5Dmiz9NM3ZLc/6iP5FLCJianqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204

T24gVGh1LCAyMDI0LTA4LTA4IGF0IDE1OjE0ICswMDAwLCBFbmd1ZXJyYW5kIGRlIFJpYmF1Y291
cnQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
SW4gb3JkZXIgdG8gcmVzcGVjdCB0aGUgODAgY29sdW1ucyBsaW1pdCwgc3BsaXQgdGhlIGhhbGYt
ZHVwbGV4DQo+IG1vbml0b3JpbmcgZnVuY3Rpb24gaW4gdHdvLg0KPiANCj4gVGhpcyBpcyBqdXN0
IGEgc3R5bGluZyBjaGFuZ2UsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRW5ndWVycmFuZCBkZSBSaWJhdWNvdXJ0IDwNCj4gZW5ndWVycmFuZC5kZS1yaWJhdWNv
dXJ0QHNhdm9pcmZhaXJlbGludXguY29tPg0KDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1
bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQo=

