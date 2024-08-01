Return-Path: <netdev+bounces-115041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B699944F1C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB41B25C92
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E921B3754;
	Thu,  1 Aug 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AVw/Jeot";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4u8gPR/m"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86C1B32DD;
	Thu,  1 Aug 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525779; cv=fail; b=RAaILf1/SU2XKGpfxhlxbHmAB7uoe5sh4cvdGjYVTamkMQtiJoJ8Y9Ba8cxmWw5FcoqTE3EhEycOCbKyR4rvZouJYpYhxKYLhaS3cuMvbecF9Xtp/wUrz2j1BZV/hnO2Nqep7qy3OqI0VURG66uKsslbEOnHU0ihzGVg4yPOahA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525779; c=relaxed/simple;
	bh=EX2gA2Dl1QppREpAPJxVqUeXyfCGHTIaOX+SQbvgGNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uaMXDofdRkCSTGMyV9tc+m+2LxYn4MV8etOWuMAq+zx9RufFQvDWI0kBppVwmQSWrA24mTtn6/uAeMPSKbHUYSXO1i4aUvgavB2V2CLdEuwR1SQ4CmDTVOmoTwUr5vzfobaxgvj9FEM4kRRaGG+tPz0dKEFIAbvDlOYXlVVI0M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AVw/Jeot; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4u8gPR/m; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722525777; x=1754061777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EX2gA2Dl1QppREpAPJxVqUeXyfCGHTIaOX+SQbvgGNo=;
  b=AVw/JeotomBuCoEP9mMZEFxRZK9CCIjGYtm1tAMvbx+/bGhS1jEObhbZ
   851TZK89NCZhPNIjVnbcEJQHGO7l3SuS/MCrHa7/GDtaxXRgw3zq2BQ9C
   ScerCw9n2/49Kt7Vqyvp9NIscDG9rGIq61aYZDd3Z3Xnct+HiC6ROTdSY
   kRsUeAuxyxkCcKEBlrr5FgoHMJnSAq1mO/P6h2TMFfJ3OFKFM8dvurzA1
   I90NhNUJO0LAXF9V+c742fMpId6YpR66Fh7kL7Ut/rumCOuxaF6UV4Pf4
   dhPuuu+VKxpPpL9xc84ADSg3Lis4B2YU0hc1m+tyB7oG5+CDBVoHZNBRq
   g==;
X-CSE-ConnectionGUID: 3FdPu9OrRUOli/7ZEzxLNQ==
X-CSE-MsgGUID: R4lg/y9JTOieLkLXl2i2sw==
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="29985521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 08:22:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 08:22:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Aug 2024 08:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaeP2DYpG3nk0GEQebJ/kiQ+b5KaHtzFWZD1S5b8Iai1+KqKOnB5xFUuDmoi3hRusn6Y1zfXFEKHKVRNi6PfSmMTqF//cN2MSo8cxO+xYMMmzFDjmdbRZEvt9T7qXfl0xvPVS6nLvxOEmixa6++nVyq/1FSIRCWpM2QGo8FvZxdKJHO8FC7KV5dQkc+ZnlnFubVjtB8jJzS52Ryx93H988ndP0/Ge8LTroDiuKguAYJfHc+4UFI+oCgN9qb/Rs7ATkhGS1raLN5vdUyO6Ghtntv/THEyUBM78EanXZmWxEu8TUAkx+EG0QBRt3MWyHsBdKgGk1RzQB34qNeVRye4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX2gA2Dl1QppREpAPJxVqUeXyfCGHTIaOX+SQbvgGNo=;
 b=r5O5OcDl8BHox2bpzpPgGy7nAiDds/edzGW0gwUScBMWCCKBf1CVIURjKgZE936QQ4KphAIf2hsca92s1ZywGUH+lKkrQ/zp2UUcolb1EBjj7TD5U8b60y5zSrpamMv0vF66MqhlGYF9tVjPX7I6pivZXDG///Py+ztdhZvMA2UUOQ7LM/nWYRd8csdkYb4VthzEhfwcdg7QQeRfLwABGlPZuSSWodfwD7LLJNZknk1PJY/TCmzPCJBq+nOigsydqQArxACnJqKgMNq9N4CP2Xh8xY3PqhlfZGem89NzzgHLsaGWt6SOOImPiY8TdXniXq0eBEqwDLB3y4jAWfmLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX2gA2Dl1QppREpAPJxVqUeXyfCGHTIaOX+SQbvgGNo=;
 b=4u8gPR/m0ZqpnasejTa1mQD30R/tUvxoITncUNBQUQqfSmKwzRvLRp9KnDYm83FYU0QLqIbNkDendJl9Ypnw05oTRen0zE8sM+SomuERBNWotCmQ8PWOfE1GlqKEl9wbVUsEzG2V6GkbElGsoC0l0KdV2qADV0YN88FQjMb+LueMc3q12pGTw09mBadAoEfYnRcmLRRW95L2wyTOwzFMgA6Gry1VcMY/3nkWPxQabPDoshe4djt8ag7PAsim3XkKrpu5DBCS63ER684rJpTl4a3ubaHhmT8YCz5CdQVSMC6I7cHV+yKKvkA6o0Lubs/MTXhLrppiNvcnQoHiUP4dnw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Thu, 1 Aug
 2024 15:22:35 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Thu, 1 Aug 2024
 15:22:35 +0000
From: <Arun.Ramadoss@microchip.com>
To: <vtpieter@gmail.com>, <devicetree@vger.kernel.org>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next v2 3/5] net: dsa: microchip: generalize KSZ9477
 WoL functions at ksz_common
Thread-Topic: [PATCH net-next v2 3/5] net: dsa: microchip: generalize KSZ9477
 WoL functions at ksz_common
Thread-Index: AQHa4zVILqSiFa9kLkSaczNx//vKT7ISh4uA
Date: Thu, 1 Aug 2024 15:22:35 +0000
Message-ID: <925034c0e0714fce5859d829fdb0ad6cd82f71d7.camel@microchip.com>
References: <20240731103403.407818-1-vtpieter@gmail.com>
	 <20240731103403.407818-4-vtpieter@gmail.com>
In-Reply-To: <20240731103403.407818-4-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA1PR11MB6895:EE_
x-ms-office365-filtering-correlation-id: b02a7af3-63de-473b-7699-08dcb23dc57c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUd4VHRrS25YVktwZ1pTb1hsbkFsOWhGbi80TjByUlErdUduVHN6cU92U09S?=
 =?utf-8?B?aC9QVElIYldRQ0cwK0NPbDIwS21ZOUk4MjdFUk5xRWpZemw4NEZlS01BZitz?=
 =?utf-8?B?MjZDanZpVFhxK0pzNkVaZTFPR0xTRFdnSk5pVTRtZGYzeW1wS0ZPT093TUZn?=
 =?utf-8?B?eEFGWDhHZXdOb0pwaXhoNHRkalQ5NFRvTHJraEhJLzFBQitoTFpTQ0pPd1M1?=
 =?utf-8?B?dTRPWmJLcTB5REJGU1NOV2IybFVkL3FUNUdzWUpYOW1BS2pKRFBEWSs1cWVH?=
 =?utf-8?B?MDRIR1oxR2R0TndqK2ljc1g2Z2pPL3pGMVMrcERhdkdya282ZEJJVlZKSXIw?=
 =?utf-8?B?SVVZMnFxNFVtRlVBellka1gyeGo4eTZna0h4TUZWQlNwSlJpWTQ3elhuVzRL?=
 =?utf-8?B?Wkg4eUl1ZU0wT2ZRZEl5bkJWRHp6UjEyNWlNWnNVdjhxTEk3WWNsSDdjcDRY?=
 =?utf-8?B?ZzRPUzJ5eE5ESWE5OVhXVEVqVnlha0x6OTcvZzZ3ZlNNeFNGQWNHd3E4VHZk?=
 =?utf-8?B?Ymw2M3o3Mkt5VW5nV1hMWFNqeUtra3FoL1lHZmtZVDdJVFU0YlMxVHVUUFJT?=
 =?utf-8?B?Ymp3cVJVZXRiTHBuMFhpd1k3ZllrdFVoalB3RXhwU3dpb2VveVQ5NnRiRUNS?=
 =?utf-8?B?SUd0eGRUMVpQUzZ0bWhRS3BTZmNRU0JnV0VhUXVaeVZhUFFEU3ZXaWF1SXIw?=
 =?utf-8?B?TUdmRFNSMFU4SFJITlF0Q2xGYXhjMTB5M2xDN0hyK1lpTGJXVnJnL2FqOUZ5?=
 =?utf-8?B?M3NrZTVINVRKV1l1WXZKNzMxUVJiTTlHZDJpeUFMOVJIMFVwV09PYTNaMnRu?=
 =?utf-8?B?amduQkVaRFVDRDQ0MXltbWlrZFlNRDZYUmNZMFRYYllUQSt6RDN4VmRRdTZ1?=
 =?utf-8?B?RlloNlgxYkt1VWZlVjBudXZiVElxay9TeFVWa0pPalBPT2VTRE5aK0lTQ05W?=
 =?utf-8?B?ek5RS2pFVWF6WW1NaUp4ckhKMWVScDhuWGxLYkNjSlg0ZVBJRUVWMXEwTytn?=
 =?utf-8?B?UVlwYVNqQWtEMjdSUElRYkF1SkxJR1dhU0owcWoxWmZPZjBLOUw0dzV4Qjhw?=
 =?utf-8?B?N1FZMHFGbE0yRnBOU29sT0lwdjNqTkttUGUrT2k3cklZUEV2YkM3TjhqMlds?=
 =?utf-8?B?NUdpaUd6NmFLZ0pvaVBsQ3dyZDU1TVJ2WnhaNEMvNkZYSk9hOTVQVTZaV3Q1?=
 =?utf-8?B?cktOS0U5YVgwYUNoSGJBN1dsYVlNN09keDJsNnRGQThnYTRkL3NFd2NNWmNs?=
 =?utf-8?B?UmJFRE9GSmVPRE9NVGh4bTV5Y0p4Z1ZsQ3BNZnQxVUsrcE5uczE5REp5Y04v?=
 =?utf-8?B?Z1ZCSDR2cjBmejVEbHBKM1JpaThUdnhpN05PZzRHdjZsQ1hnVy9IOGFYSkZl?=
 =?utf-8?B?Uk5heS9HSkdjSUJpLytmbDR3eitBZ2Y0NmQ2NUFWNVFqdisrNlo1VkFuSXNj?=
 =?utf-8?B?Z2pUVXVMMlBNMFVyL0pML0NNRHZFT0hsWGZINUxLRmwrSHA2WlozaGJyazhT?=
 =?utf-8?B?a2RpZURyMEtzeVYxTEs2SFUwZ002Z01keTNnYmgxN1JKeXVmNUMwV2x5QVFY?=
 =?utf-8?B?TnBOQnUvYXdTVzNOM0crVFA2NGZ5aWZxeVNUc0RtcEtGenAranN2bktXNUxr?=
 =?utf-8?B?QnhydDE5YmdsanBqdHdva0YzNlRKckkwbS9KR1RvVGY0dkxtcHF3K0g1VEps?=
 =?utf-8?B?bExROXdXRFE4WUkrUFBaelR3U2hnUWdKVFRDcTl2QnV1UmFWK2lsNGI5allp?=
 =?utf-8?B?aTEzSmtpaW1pZDRTblo4Q2lWRG4xR0ZzUFAzUnU3cEFoWnBnTVFWRmFCS3dV?=
 =?utf-8?B?V0JtcVY1UnVWVVNEV3oxdHpvTjN4elV0RGcxbU5Md1hESnpTVWtJK3ZkTmZN?=
 =?utf-8?B?anlMV283bjZOQXFVVnRyNDJUc3ZzZU9xQm0vZjR5NU9NZlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTczejU5OHJLUlFQVldyTkMzM0VRMEJBQWxKYjFGaEc2ZzZHSTQrTUR5empU?=
 =?utf-8?B?Z0tnaC9hWlZpZk1STkxSazRTTXlNQk11d2pCVVcvY1NWLzdrQlpKRnk2Z2lE?=
 =?utf-8?B?MDVZY2czN3YxY0tEempqVVJ4SkdtcmljazJsMDhnazVQME9GeThyQUprTEdD?=
 =?utf-8?B?eG9veHlxaUZFMUhWemlDOE9FNjdDWkUya2lqVnIzYjRYUzRxaWxNQWNsWENq?=
 =?utf-8?B?dXlHRzZMWlV0MGYxVjA2Y21VVmZMZ1JiTGRubTNkODFhd3hFSWZTcTR6dEIv?=
 =?utf-8?B?ZndwQUprYTMzYS92OVRVb0VGa0hadWNxLytxOVByaXgwdjJIYk9heGdtNVEy?=
 =?utf-8?B?TEljdlB1c0thNytLbzAxelhPVzhCajFESXJxZDJhZjZ5T3gzZGlOamR4SE9W?=
 =?utf-8?B?RGVZRmI4NHZkRkpNd1Z0NEt1NjROTkxvNkZReVNyTnlHSUVRbTVid21hdVdm?=
 =?utf-8?B?bHVGOHh1azNVZmZFb1ZJaEgyWjEzNUpDaHNxUGcxN3hFeGdJaTI5V2FYWFlM?=
 =?utf-8?B?RW9kb3Ztc2Zwd2lueS9QUWw4ZnlXWmx1OWRzNVFod1NON21tME5qckJ3a3RW?=
 =?utf-8?B?ckpodkdDRHdqTm1Ra2NrTEt6MGhtVkREdzNCcGJidk1GMFQzbGZqd25WYUJE?=
 =?utf-8?B?WDhRa2NFYVFtdDkzdllITUdQWG9mWWdRc2J0VmVXd2xmMjYyZzhUdGlHMWlS?=
 =?utf-8?B?Z1M2WS94aGtpZ0VzaWZXdXJZSEdpT1ZXNTJBaHQ0NGlRNWhZbHpjVHF0TmNs?=
 =?utf-8?B?SEhmNmxNblFBSzJ5Y3FzckdOWjdjU3dHY2JCRkRVRlRrZlFSbGlxdjArZHcx?=
 =?utf-8?B?cTVtaXpoUGFRSHpCd00xS1BlWWFYczI3ekhRa09RNVNVUnRNZkloUVA3azZS?=
 =?utf-8?B?ZU5tbHZzUDZsb1ZEZjZmbTBxLzRWODEzQnMzdHZkWE9ZSlNXU3VKRnE0cUFK?=
 =?utf-8?B?WnVVZWZ3dGJKNkxCbHZQcGdmeHpoRTNsckozTDJQaElYL3R6SExPeTNRampv?=
 =?utf-8?B?RXNIRTVqdDBJa3NaS1hxejBZOTU2TGs5WDdyY1JRVDY2QVo0QmZGR2JIbjF0?=
 =?utf-8?B?YWNVWS9vZ1NBaWVGVjVQR2FaSHJGWnlnQVFpWUxXV2F0M0Jsam8yeE1UTGFY?=
 =?utf-8?B?K0prZ2RCc2hXeUlpcTlOTC9GSndkVlZEakxOTUtJSWM4bzRxblY2RCsvUzFE?=
 =?utf-8?B?V3ZWeGRtRnB6T0NXd2J0eTJPQnhlRURhRzhFeVpBa21SL0dlRjVTalFJR29G?=
 =?utf-8?B?RTc5NzlhSm9neDVta3lhWk5mZDZSV0haS3EyZ0YrclFoYTRyWElTNGQ5Q2lD?=
 =?utf-8?B?bFNWZ3ZZSm8zK1NtZmlRNlZtQlZtQnBvTkRBYWYwdERZZ1RXTzFWT1Y4Ym5F?=
 =?utf-8?B?VDlET3VLbG56YjgzdGQrbHBKaVN3cDRuNjdmSGFtbFViQVhOWXE3L3dmVEtn?=
 =?utf-8?B?cWVuYTVSU2daWHpyaHZlWGJTQmNPcHNTdXFiL3Q5V1duNEpzT3gzcHg3OFlv?=
 =?utf-8?B?aXdaeWU5aC9QMkkzbjJybnpFYkdvMGd1Qmt3dVlWRDlFNWliUkszY2hOczNT?=
 =?utf-8?B?dlh1MG1KZkJrNTY3TW15b1hvYmZoSGpycVg3TTRESTdpSkFTdGpUY1FQZ20y?=
 =?utf-8?B?bUQvSmVaZ3lTTUFWMDRzOUE1NUhaWkhJTHBFSVNCM1ZSckgyRE1SZUNPcWl2?=
 =?utf-8?B?VWhMUUY0QWZaTTBzLzhwUkdXYiszTzJjNkd1T0dRMkQ2U0o0UENSMkFsVUJ5?=
 =?utf-8?B?L0lONFo2cXE2ajZrZVB6cTlQdW10TW1lWTd5L2pUd2JZanZoN1ZWWWlCa3Y0?=
 =?utf-8?B?aXQyTUxrN0hYQTYzazFkbFRqWEZ2MmpvTGROa2hjbmcrd3pQOUllSk4zRUEz?=
 =?utf-8?B?dCsxaVdWS2dlUkFEdEZMR0xPencwQXVidDV3Zi9OaHh3NGtmQkIxME5MY2Iy?=
 =?utf-8?B?VEFScmNVMThqM0RiaENWZkxzMjI4VkpNT0wrTWdtS3FBcitLWHR4cXRJVnZV?=
 =?utf-8?B?TmFWK0FZNDF4Q0Vabms2d1pncHpHZ2tITUcxeVdyQmF5bHJxL1JzMmpyektL?=
 =?utf-8?B?d2hlMXoxbUY2UkVXeUNzYlZwWXhsaHVjNWlnNjN1bWdYQXg0Yk42ZFVYbXBr?=
 =?utf-8?B?YTJnNU5Ubkt4SjBTZTdnWDJjWnZHZW5Scko3WEVubFQvV0dYajBjMzljNlIw?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5A749C1FB20A64DBEB271781A8D105E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a7af3-63de-473b-7699-08dcb23dc57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 15:22:35.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QvvJ2NP9v7YvhlQxZ8ZEqLu+bIFMhzG6308qH9ICzqCLorD6tli0mN/sQjLKuab8XOvER1FMpkdRt5p4jnJlLssEx1PrrsYZsDKhDmaIAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895

SGkgUGlldGVyLCANCg0KDQo+IA0KPiAgdm9pZCBrc3o5NDc3X3BvcnRfc2V0dXAoc3RydWN0IGtz
el9kZXZpY2UgKmRldiwgaW50IHBvcnQsIGJvb2wNCj4gY3B1X3BvcnQpDQo+ICB7DQo+ICsgICAg
ICAgY29uc3QgdTE2ICpyZWdzID0gZGV2LT5pbmZvLT5yZWdzOw0KPiAgICAgICAgIHN0cnVjdCBk
c2Ffc3dpdGNoICpkcyA9IGRldi0+ZHM7DQo+ICAgICAgICAgdTE2IGRhdGExNjsNCj4gICAgICAg
ICB1OCBtZW1iZXI7DQo+IEBAIC0xMDUxLDEyICsxMDUyLDEyIEBAIHZvaWQga3N6OTQ3N19wb3J0
X3NldHVwKHN0cnVjdCBrc3pfZGV2aWNlDQo+ICpkZXYsIGludCBwb3J0LCBib29sIGNwdV9wb3J0
KQ0KPiAgICAgICAgIGtzejk0NzdfcG9ydF9hY2xfaW5pdChkZXYsIHBvcnQpOw0KPiANCj4gICAg
ICAgICAvKiBjbGVhciBwZW5kaW5nIHdha2UgZmxhZ3MgKi8NCj4gLSAgICAgICBrc3o5NDc3X2hh
bmRsZV93YWtlX3JlYXNvbihkZXYsIHBvcnQpOw0KPiArICAgICAgIGtzel9oYW5kbGVfd2FrZV9y
ZWFzb24oZGV2LCBwb3J0KTsNCj4gDQo+ICAgICAgICAgLyogRGlzYWJsZSBhbGwgV29MIG9wdGlv
bnMgYnkgZGVmYXVsdC4gT3RoZXJ3aXNlDQo+ICAgICAgICAgICoga3N6X3N3aXRjaF9tYWNhZGRy
X2dldC9wdXQgbG9naWMgd2lsbCBub3Qgd29yayBwcm9wZXJseS4NCj4gICAgICAgICAgKi8NCj4g
LSAgICAgICBrc3pfcHdyaXRlOChkZXYsIHBvcnQsIFJFR19QT1JUX1BNRV9DVFJMLCAwKTsNCj4g
KyAgICAgICBrc3pfcHdyaXRlOChkZXYsIHBvcnQsIHJlZ3NbUkVHX1BPUlRfUE1FX0NUUkxdLCAw
KTsNCg0KY2hlY2sgdGhlIHJldHVybiB2YWx1ZS4NCg0KPiAgfQ0KPiANCj4gIHZvaWQga3N6OTQ3
N19jb25maWdfY3B1X3BvcnQoc3RydWN0IGRzYV9zd2l0Y2ggKmRzKQ0KPiBAQCAtMTE1Myw2ICsx
MTU0LDcgQEAgaW50IGtzejk0NzdfZW5hYmxlX3N0cF9hZGRyKHN0cnVjdCBrc3pfZGV2aWNlDQo+
ICpkZXYpDQo+ICBpbnQga3N6OTQ3N19zZXR1cChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+ICB7
DQo+ICAgICAgICAgc3RydWN0IGtzel9kZXZpY2UgKmRldiA9IGRzLT5wcml2Ow0KPiArICAgICAg
IGNvbnN0IHUxNiAqcmVncyA9IGRldi0+aW5mby0+cmVnczsNCj4gICAgICAgICBpbnQgcmV0ID0g
MDsNCj4gDQo+ICAgICAgICAgZHMtPm10dV9lbmZvcmNlbWVudF9pbmdyZXNzID0gdHJ1ZTsNCj4g
QEAgLTExODMsMTEgKzExODUsMTEgQEAgaW50IGtzejk0Nzdfc2V0dXAoc3RydWN0IGRzYV9zd2l0
Y2ggKmRzKQ0KPiAgICAgICAgIC8qIGVuYWJsZSBnbG9iYWwgTUlCIGNvdW50ZXIgZnJlZXplIGZ1
bmN0aW9uICovDQo+ICAgICAgICAga3N6X2NmZyhkZXYsIFJFR19TV19NQUNfQ1RSTF82LCBTV19N
SUJfQ09VTlRFUl9GUkVFWkUsIHRydWUpOw0KPiANCj4gLSAgICAgICAvKiBNYWtlIHN1cmUgUE1F
IChXb0wpIGlzIG5vdCBlbmFibGVkLiBJZiByZXF1ZXN0ZWQsIGl0IHdpbGwNCj4gYmUNCj4gLSAg
ICAgICAgKiBlbmFibGVkIGJ5IGtzejk0Nzdfd29sX3ByZV9zaHV0ZG93bigpLiBPdGhlcndpc2Us
IHNvbWUNCj4gUE1JQ3MgZG8gbm90DQo+IC0gICAgICAgICogbGlrZSBQTUUgZXZlbnRzIGNoYW5n
ZXMgYmVmb3JlIHNodXRkb3duLg0KPiArICAgICAgIC8qIE1ha2Ugc3VyZSBQTUUgKFdvTCkgaXMg
bm90IGVuYWJsZWQuIElmIHJlcXVlc3RlZCwgaXQgd2lsbA0KPiArICAgICAgICAqIGJlIGVuYWJs
ZWQgYnkga3N6X3dvbF9wcmVfc2h1dGRvd24oKS4gT3RoZXJ3aXNlLCBzb21lDQo+IFBNSUNzDQo+
ICsgICAgICAgICogZG8gbm90IGxpa2UgUE1FIGV2ZW50cyBjaGFuZ2VzIGJlZm9yZSBzaHV0ZG93
bi4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBrc3pfd3JpdGU4KGRldiwgUkVHX1NXX1BNRV9D
VFJMLCAwKTsNCj4gKyAgICAgICBrc3pfd3JpdGU4KGRldiwgcmVnc1tSRUdfU1dfUE1FX0NUUkxd
LCAwKTsNCg0KaGVyZSBhbHNvLg0KDQo+IA0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiAN
Cj4gDQo=

