Return-Path: <netdev+bounces-94243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F08BEC0E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DC0B23BDA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B716D9AF;
	Tue,  7 May 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z4OFW+rf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ttgFg5A0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88216D33C;
	Tue,  7 May 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108354; cv=fail; b=L0VbNqv93WZrH3+nJPryxEzUYD/3tzAV1DyxFgTLNkqrl8+FBXuACtqEN7tKW97wo0Qzcde3RwqbgLofeHKYcfO9bP2Xwpna0Vt8LCzwCeMbuC7VSKv89DN4RZO1dACpprR+3Klu0cKbx3WpvFXgy79+IEtBmshrrl+ooTFa1Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108354; c=relaxed/simple;
	bh=2Vtpw12Zaff9HyOsWOSXctscz8IYbSKG1xvRK0dFrw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmUCUsWdGUQ8T3AZLMxFLgagMVOyf5yg3UovszsrbSVSFDkno1BMPZ9P6FXSHUOvqUVZ+MPme4k2ftjL9vkI1ksx75qy2sk4kpe61cwDVcqwsQKowTas5ElZZtwF3nYqssaIqQOwZMFr0HLneU0m5AThnmcIayxbQiBtezBPQ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z4OFW+rf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ttgFg5A0; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715108352; x=1746644352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Vtpw12Zaff9HyOsWOSXctscz8IYbSKG1xvRK0dFrw8=;
  b=z4OFW+rfHTZ49JRiPEg5VdqJyAMVIlcL4WIiqNDRM59S0lpzv6E8wuF2
   0q+0Yc9SSiVjpnKuyh12TEjQ28L+RH67lJg20jxe8Xh3y/hIwladLM6BC
   Kdl1X4ATi4QgtDIajrAyp9iodyC4MsPNWFaCFB2l8FPFFg6GZIVPUd7Nc
   9UIfq4BW1yZxQf1SAMIrDP0ery0cm4H7Ey/cb2ks5jyqaR+NvBIJbtT+M
   EcLV+N2kpR4pWqFskefPPJQVDbRmpeCiLLZXCDjNIW5fjwHeOJIq5J3Kt
   5rCE9pcQOlHJHJM+OEm0yqV077kM0GN7ndDrxup1j7oPiMmfAaU1vfCL8
   g==;
X-CSE-ConnectionGUID: FO8qxw0ZTtWgpyWyX0z+VQ==
X-CSE-MsgGUID: qrn645pCRomVOG0AdoAm/g==
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="254850423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2024 11:59:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 11:58:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 11:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcOqFvVoa3a5RJBBq50tTYZCWWIJyoS8D043RFr+RMnEiASxw09nNfBfwnB4Qyyv1J2i75rDjVF90cmr0hdZHjWqlHWUEOC5K2g4WC/nn6EcbpyAEu3xhH39tvPhYK4rCGUhPCEokJMXm80mwbkWOtk2KaJKKU2cyJ0rFVTOhP7zw3JhBrSe2PbFfDwPQeDfncne7rbS6XmRKA+Y4YsuNUL7ZxHEu2oPUMJh/g9iCCeyDFMQazN+5QeCderUD25ULIcVV8IB4mHgp2TEKTrAEZybrr+MHAkgoWXHzHhW5dy4K4HXuYaqrmhMVWjOddn+Pat78MLDGqxbl+Vex3IKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vtpw12Zaff9HyOsWOSXctscz8IYbSKG1xvRK0dFrw8=;
 b=ftsVucZ1sS1QH4MYkQ+NCDLYnOpqmuDzcrkc8Gfzb+qSkpQUetFhBsAvI6G4SvskGazAolQKojAxuMpA2Flaggo14VpwceA2Deu05+1picCmM9/DWvbb/EKL2BjVMJFoKN00+5Mzsk7Rv3GWWXuJiZ58eS2jH3+LWM3aH10ybFTxweTn/b7DmyrE0eOorISNpRPM4yBLwRCN4Wupjob1PTS9+ypRGMe9I6ELsEMZ0oJvXTF0ruJK4CVj5Kw23DBZWehDLMI00PhcfMc+kbm3EBVGrDI9M+MUciFFd5PH55Xz509Ry69z2dNe8NrwkLLUm5HFjcpfwXq0AduGUGPaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vtpw12Zaff9HyOsWOSXctscz8IYbSKG1xvRK0dFrw8=;
 b=ttgFg5A0CC3/+XmjB3vpAT6K+1g1thf0cHILpcMrbi5iYYF0KURHSn+ac1MzuGlL/NDUHROZY0sFx9Jq18EvjiEdzu1VgtBWKWizhjxysd8I/HxKh+KkaIXpUQpbJtIEo6bpOztdL/yuIRQffKmIP/EUYE61OTi7r+5Y7BnN+OBhRFnduPsvtP5cPucbgJp2yIFApxcjRGMnCpGH6U78KyDd8NZqCHwgS5j6fCpRkJc95ZVN5HAlScAOaH5khBej0B4V8dvMAPOrs/tmjT1B1AauU8eWoSrp3MzaG9J4PVlKTSLlyfN++pJ3Reu/mDHYpxf01fyN5ddYsLzu2JzZdg==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 18:58:36 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7544.036; Tue, 7 May 2024
 18:58:36 +0000
From: <Ronnie.Kunin@microchip.com>
To: <linux@armlinux.org.uk>
CC: <Raju.Lakkaraju@microchip.com>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <lxu@maxlinear.com>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next] net: phy: add wol config options in phy device
Thread-Topic: [PATCH net-next] net: phy: add wol config options in phy device
Thread-Index: AQHamryInbCB9BYIukGo4mVuOjWyY7GECwQAgAAS4wCAB30KgIAAGgIAgAA4RqCAAC0xAIAAC5dg
Date: Tue, 7 May 2024 18:58:36 +0000
Message-ID: <PH8PR11MB7965CDEC5618C8E752B3E53995E42@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
 <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
 <ZjoWSJNS0BbeySuQ@shell.armlinux.org.uk>
 <PH8PR11MB79658C7D202D67EEDDBD861495E42@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZjprZjKfewKRqRJL@shell.armlinux.org.uk>
In-Reply-To: <ZjprZjKfewKRqRJL@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|CO1PR11MB5028:EE_
x-ms-office365-filtering-correlation-id: 0e1ccd8e-564d-48df-c96b-08dc6ec7b34b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VllxZE9Bb0oyMDNCOUlzZlRkVWt2OEJKVHVTT25sd2Y1TFdLbk1pYkxubHNF?=
 =?utf-8?B?QnJJMjNqV0Fpc3FCbVVJQXpQMk5CODlFdTc4RXVvRG9qYUlqRU1nQ3Q5cGRR?=
 =?utf-8?B?eXpDbzhMRnc5SGE3c0hvdGx6THBicUpnZ0RJTTlwMFB3a0FseXlIVUFINzVQ?=
 =?utf-8?B?UTRNSXdjcWR3K3d6dWJRb3lCV0JOYUpoV08xcCs1MUxsYjRJV014TGlnQjlD?=
 =?utf-8?B?K1NlZTFadjJwbGZsQ29iMVpQT2JUbTVEZU83eFloNzZZR1ZPem5iN1BydEVm?=
 =?utf-8?B?aXprKzNESjJuNGtkQjBPemZ2SWI2cUtEcTFyN2xCNU8yMzdXMEtxdWFrN0t3?=
 =?utf-8?B?emVxN0t0ZzJzbDg0Nkt0UitydTlrb05aOWRHaFdzdE9DdFBLQm13UUxUaVl3?=
 =?utf-8?B?ZmI0RTdQTlNFZ29zbHZmZW9PcU9EdDZmeUhjbGJsWTdLUGpNVERsejAxbFlI?=
 =?utf-8?B?R1ZBYnBNeWxPcGZpOTZ2RVArRTZPcGZEQ1N3TExPQlF1MkpJc28vOTdZbzAv?=
 =?utf-8?B?d3NML3I2VFpDbExDSWljYi9OKzk2anZSUVN0K2dkMFdDYVdJOVJEY0wwbFFR?=
 =?utf-8?B?RlRuRHJZV0tQWjRmeG41N2tBZVBxamRxSytDaGVzYUxYa2xoVlprV1FXckg1?=
 =?utf-8?B?cGs5TFFLV0VqQTVaRnQ2TlNTOVA1Sm9zVUYvbjlMZXBYaVlNbHpBbW9yUjEx?=
 =?utf-8?B?UnlKN1V2VzVZL1hKSTZKRW5VRnpmaU1QVEZ4b3Z6L3VJSmVaZTAvM0d2ZWk5?=
 =?utf-8?B?NXBDaUlBMGNyem4zZ0FGYkRaOUxBSGJaaDdwSDUrOTQ4YkdBUWEzU1UrWGo3?=
 =?utf-8?B?bzcwQ2w2anNyRlF0enR5VURXVitRQ0ppNHhxbnQvQXUxOWc5MVRKVDFENTVX?=
 =?utf-8?B?NnVmRUY1aHUyUmtnSWdTUm4zb3JTVkR2TEZNZ0l5K1FyOFR6KzBIWDloWDU4?=
 =?utf-8?B?L2U4bnMyS1JMdTRHTjRpUUNGamR3d1prV2taUGpheHJiYm1pcjhIV05qNFo4?=
 =?utf-8?B?aEU2WWFhTWg4aElhTXExL1hCRzBxWk9SZjhQM3lHdzJqNkUyWnp0S1dOMmpQ?=
 =?utf-8?B?YzBrS25lK280NGFyZ2hYUXFaa0UvdFFMd0hhT3FNanFpcmRKY1hMQkxhT0s5?=
 =?utf-8?B?NEtTY09KeU9KNGY1NGRndmhjWXFXT2Fiem9xZnBreWcvQ3NTQzhDN1hZa3pS?=
 =?utf-8?B?bkJhYmlkQ3ZsbVhhd1BkNDhWRENoNVRuUzg5OVNRbnU5YTF5M2Y1ZTdKZHZN?=
 =?utf-8?B?MXErRllWWVdOaXFsdVRiS25WMHN0UjU4d2dWR1NWbWg0YnZHOXNHSDhZRXRk?=
 =?utf-8?B?cEFJRGFBQUFXWUo4VFJRZzN1b2FKbWg4cWN2MlB3ZFVUb3J1YVg5d3NWNFRE?=
 =?utf-8?B?VE9hOUhEUUVWeVdoM3ZETU1yV3llN3pkbmcrVHV4bW1CV254VnpOZmVuenFt?=
 =?utf-8?B?c1NTbS9DaW9OQVBhNkpQK25STHhxWWdrSERzRjFEb0JJTEUrd3I2azZNdVpu?=
 =?utf-8?B?V1N3REJIMXQwYUZDd2NhTHIwYWRTaFdWbG1jdzdicjVzMkJsZUNJYi9RQzdm?=
 =?utf-8?B?NVpnbndKWHdYbTZzTm1UM3B4NTBaN1padXZYMUpBQUh3TzFNbWtPQzhOaEdW?=
 =?utf-8?B?UzZwTG03WHpRWXN4OGtLaGtWN00ra3hqbXFZcmNjaUUzVGd0R2pYeW9ncWxx?=
 =?utf-8?B?d1g1UnZNVXFFQTVtRW92WjVDK3RmVHBQYWRKMGY1WFdaWTcvZGs0MG1nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2huVUo1Z2czRE5YbXFxblBFOWpjaUMxb2wwc1RqWHRWMmQ1d1dHbE9ITGF2?=
 =?utf-8?B?NGlCMFU2aWVNMkpKL2oxblVvWnl4TXV2eFI1alErQ2JaTUhDRHpuQ2lCbVdX?=
 =?utf-8?B?cHExd0J2OTMxRTdvTThnK3lBdnY1ak80cFZZeEVVREgxdFJzb29PVWFSYTFk?=
 =?utf-8?B?VGRNcEs5VndrcjA2czM4RVN1aU9YV1JPQlZQODByZURrVDAwOXJhRHFxT1Bs?=
 =?utf-8?B?R1hGZGFzaFZaRDBLT0JvSE9zN1BhTks5bXI3OTFBZ3I3TGhCZk5EaWFNOHdO?=
 =?utf-8?B?UnZra09rVEgzV1ZRSVRJSHhyb3MxR2ZSS1dzdk1RVDNWZG5YV2piL2xCd1NN?=
 =?utf-8?B?MUdUWS9ld2Y3WXFneUlnWE83MENEUjhaTHBvcWt3SUg3MVFic3E4dU12bzI2?=
 =?utf-8?B?NXdGZ3hTemFvamg0NHQ1aHlNSURNNTVwOFZxd3JKU1F3bVNlaTlRWWVvbFhT?=
 =?utf-8?B?ZXdYYUcrb2ErYlFhMXl1Q1VDb0dLcis0Qy8wRDl3cnVQQ1pqL0pIVkFKb1Ji?=
 =?utf-8?B?L2VRMy94VHBVK0huV2h0U1MzdlY1T0ZsenpNYysxRmh6TnhNSUFCZ0dGMFFE?=
 =?utf-8?B?NlNDU21EV1Zab1FjVFZJZWUzY21maDJtWFU4b09QdTY0QkgrRzluMHQ2VHV3?=
 =?utf-8?B?dytSKzNkUFlOVDRqWkZrK2szSTJNVndNTzZvVm1EUWd6V012LzhNUFpvSXpY?=
 =?utf-8?B?REg0T3h2Q1kzZEtZOVhSSDNIRkZ5eXFSR1IvSGk2ZWx1cWpCejQ1L0xZTWhs?=
 =?utf-8?B?TVBYeFhaQ3ZTc2ZUMGQzcUhXdGYwa0JITWZvbFM1SlRSb0pyL0NWKzFtaTJU?=
 =?utf-8?B?dURFeTNydWJxNTBYek85cVZ2ejZWMjVtNTBnS1lHTVBRWWFuYm5qMGtqV1A5?=
 =?utf-8?B?RFQ4bUJxdTFkNzJrWEhaZnl1Y2RIb3B0ck5Fd2FVZDZNNUJ2Wk1Gc1o1Kzdy?=
 =?utf-8?B?eWxpVEluZFQrQldVQmI5VzUxVzZ1ZHJUa00xM0x4VHl1cHA5YjFwY1liRjZL?=
 =?utf-8?B?WU9KNm1VVXZrQWtZdzZiRzVYQXNMclRCQ05CeVNvZEtLeEhHbmJRYzZhVm4r?=
 =?utf-8?B?bUh4VkxsZ3NYcVFrZmduK3kybE9sZWFrRjNCSTMzTkJvVitLQ2U3T0Vpa1Bl?=
 =?utf-8?B?bk82RHh3QlEySW0xWG54ZG1ueTVCVUpTZFpaM1g4a2lVK0wvZ21PcDhtWHpx?=
 =?utf-8?B?MFZmWjltMTViR045VGFqVWtQc0VkeWg1eklrblM5eGQvSE5oYzJIZ1BJaXVI?=
 =?utf-8?B?TXRPTUF0Zks3SXNhK3NqK0VRY1FMRlNXVHNGdjdRWjJ0VGtPZGdIWVQ0MFNZ?=
 =?utf-8?B?TCt3T0pTbU1NNU5qVDFYaHkxdVY0USt0SmUvazNkNTZad3lVMlpkaFpWOHRp?=
 =?utf-8?B?QTFsZ251aFlRd0M3WkFTb0lVd0wwQWt4dzU4UmdEN0ViRFhaZm1Rck1leEpV?=
 =?utf-8?B?T2hUd2VjVk9lZ1FiS01vU1F5VkFtTTVuMjBjSXUwNUhSRnRjZ3BWRnFtVUto?=
 =?utf-8?B?ODdxMVV4NkRRcmJBenFSak5LZng2RS9NMnlsbVlSQ1ZpdXpQN1lDc3VzUC9o?=
 =?utf-8?B?UVRTbmc0R2JCL3ZwQmp6ajlvemxMbGp4YUxLd0lOaEpxYTlHRnU4b3NZRnBM?=
 =?utf-8?B?M0FlRStXWEZNOHZURVZ4Mk81SU1aMkdNNllMcjEzTmxMQ01FNFloald1R0sz?=
 =?utf-8?B?OWJ0TDgvYjJtZkdKZSs2ODUwUnRINzd3SlJWdzYxb2gySVNoNEJhN2ZZbzJu?=
 =?utf-8?B?TS8wMzVvVWJCUCtNMWY2U2p4SVlSK3ZndGZOQTFiaHFMR3l0ME9ERmV3SGVs?=
 =?utf-8?B?K1M0RXhKeTViSmMxRFJ3MWFoM0FiMnB0M3Jheng3UGlTK09FYWRZdHZ0ZDlM?=
 =?utf-8?B?VEpvcDBkOXprZTBVK3JpTjBMVkRsdFE4eEhwR2VtNFhlVHlIb082K09kZGxG?=
 =?utf-8?B?R1E5UFZlRnljVnh5UVZrQ2FVcEhwWWxpS3VvdERQWHNlcVNCWGlkV3VoaW1s?=
 =?utf-8?B?WndiSU1NL0ZCUTlZbXpJMElqRTlXdHZWOHgzOS9BYjhuejFuUnRvaXdVUEUz?=
 =?utf-8?B?Tll4V0RrZ0pLOS9nMEFpb2NOd1Y3ZytyVy95OWluRFIzNVhUWUsvMExMaTRT?=
 =?utf-8?Q?c8Kwv1Z0CDlQSgGLZjQEASKtB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1ccd8e-564d-48df-c96b-08dc6ec7b34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 18:58:36.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JPwzlXjVY20DDUHBvDFXKg6PS8TFkiHa4dP9ELF3MUfZ/ueQm3dbLsRgMkR786DmZVyKSXxtQUzHTDyY7YMUx3FulPFYju5hCPsA8a2Anc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028

VGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgd3JpdGUtdXAgUnVzc2VsbCwgbXVjaCBhcHByZWNpYXRl
ZC4gDQoNClllcywgdGhlIGxhbjc0M3ggd29sIGhhbmRsaW5nIGlzIGN1cnJlbnRseSBzZXZlcmVs
eSBicm9rZW4uIFJhanUgd2FzIGluIHRoZSBwcm9jZXNzIG9mIGZpeGluZyB0aGF0ICh0aGUgcGF0
Y2ggSSBtZW50aW9uZWQgaW4gbXkgcHJldmlvdXMgZW1haWwgdGhhdCB3aWxsIGNhbGwgdGhlIHBo
eSBkcml2ZXIgZmlyc3QgdG8gZ2l2ZSBpdCBwcmlvcml0eSkgd2hlbiBoZSByYW4gaW50byBpc3N1
ZXMgd2l0aCB0aGUgbXhsLWdweSBkcml2ZXIgdGhhdCBsZWQgdG8gdGhpcyB0aHJlYWQuIA0KDQpV
bmRlcnN0b29kIHRoYXQgdGhlIG1hYyBkcml2ZXIgc2hvdWxkIGZpbHRlciBvdXQgYW55IHdvbCBv
cHRpb25zIGl0IHJlY2VpdmVkIHRocm91Z2ggLnNldF93b2wgdGhhdCB0aGUgbWFjIHN1cHBvcnRz
IGJ1dCB0aGF0IHRoZSB1bmRlcmx5aW5nIHBoeSBkb2VzIG5vdCBzdXBwb3J0IChhcyBwZXIgd2hh
dCB0aGUgcGh5IGRyaXZlciByZXBvcnRlZCBlYXJsaWVyIG92ZXIgaXRzIG93biAuZ2V0X3dvbCBp
biB0aGUgd29sLnN1cHBvcnRlZCBmaWVsZCksIHByaW9yIHRvIGNhbGxpbmcgdGhlIFBoeSdzIHNl
dF93b2wgICh0aGF0IGlzIHlldCBhbm90aGVyIGJ1ZyB0aGF0IG5lZWRzIHRvIGJlIGZpeGVkIGlu
IHRoZSBjdXJyZW50IGxhbjc0M3ggZHJpdmVyKS4gVGhhdCB3YXkgdGhlIG1hYyBkcml2ZXIgY2Fu
IHRoZW4gcHJvcGVybHkgdHJhY2sgKGFuZCBzYXZlIGlmIGl0IG5lZWRzIHRvKSB0aGUgY3VycmVu
dGx5IGVuYWJsZWQgcGh5IG9wdGlvbnMgYW5kIGl0IG93biBlbmFibGVkIHdvbCBvcHRpb25zLg0K
DQpIb3BlZnVsbHksIHdpdGggdGhlIGNsYXJpdHkgeW91IGhhdmUgcHJvdmlkZWQgb24gaG93IHRo
aXMgd2hvbGUgdGhpbmcgc2hvdWxkIGJlIGRvbmUsIFJhanUgd2lsbCBiZSBzdWJtaXR0aW5nIHBh
dGNoZXMgdG8gZml4IGJvdGggZHJpdmVycyBzb29uLg0KDQpUaGFua3MgYWdhaW4gYW5kIHJlZ2Fy
ZHMsDQpSb25uaWUNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJ1
c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkg
NywgMjAyNCAxOjU3IFBNDQo+IFRvOiBSb25uaWUgS3VuaW4gLSBDMjE3MjkgPFJvbm5pZS5LdW5p
bkBtaWNyb2NoaXAuY29tPg0KPiBDYzogUmFqdSBMYWtrYXJhanUgLSBJMzA0OTkgPFJhanUuTGFr
a2FyYWp1QG1pY3JvY2hpcC5jb20+OyBhbmRyZXdAbHVubi5jaDsNCj4gbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbHh1QG1heGxpbmVhci5jb207IGhrYWxsd2VpdDFAZ21haWwuY29tOyBkYXZlbUBk
YXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBVTkdMaW51
eERyaXZlciA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQtbmV4dF0gbmV0OiBwaHk6IGFkZCB3b2wgY29uZmlnIG9wdGlvbnMgaW4gcGh5IGRl
dmljZQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBU
dWUsIE1heSAwNywgMjAyNCBhdCAwNDoxODoyN1BNICswMDAwLCBSb25uaWUuS3VuaW5AbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4gPiA+IFNvIHlvdSB3YW50IHRoZSBNQUMgZHJpdmVyIHRvIGFjY2Vz
cyB5b3VyIG5ldyBwaHlkZXYtPndvbG9wdHMuIFdoYXQNCj4gPiA+IGlmIHRoZXJlIGlzbid0IGEg
UEhZLCBvciB0aGUgUEhZIGlzIG9uIGEgcGx1Z2dhYmxlIG1vZHVsZSAoZS5nLg0KPiA+ID4gU0ZQ
LikgTm8sIHlvdSBkb24ndCB3YW50IHRvIGhhdmUgcGh5bGliIHRyYWNraW5nIHRoaXMgZm9yIHRo
ZSBNQUMuIFRoZSBNQUMgbmVlZHMgdG8gdHJhY2sgdGhpcyBpdHNlbGYNCj4gaWYgcmVxdWlyZWQu
DQo+ID4NCj4gPiBUaGVyZSBpcyBkZWZpbml0ZSB2YWx1ZSB0byBoYXZpbmcgdGhlIHBoeSBiZSBh
YmxlIHRvIGVmZmVjdGl2ZWx5DQo+ID4gY29tbXVuaWNhdGUgd2hpY2ggc3BlY2lmaWMgd29sIGV2
ZW50cyBpdCBjdXJyZW50bHkgaGFzIGVuYWJsZWQgc28gdGhlDQo+ID4gbWFjIGRyaXZlciBjYW4g
bWFrZSBiZXR0ZXIgZGVjaXNpb25zIG9uIHdoYXQgdG8gZW5hYmxlIG9yIG5vdCBpbiB0aGUNCj4g
PiBtYWMgaGFyZHdhcmUgKHdoaWNoIG9mIGNvdXJzZSB3aWxsIGxlYWQgdG8gbW9yZSBlZmZpY2ll
bnQgcG93ZXINCj4gPiBtYW5hZ2VtZW50KS4gV2hpbGUgbm90IHJlYWxseSBuZWVkZWQgZm9yIHRo
ZSBwdXJwb3NlIG9mIGZpeGluZyB0aGlzDQo+ID4gZHJpdmVyJ3MgYnVncywgUmFqdSdzIHByb3Bv
c2VkIGFkZGl0aW9uIG9mIGEgd29sb3B0cyB0cmFja2luZyB2YXJpYWJsZQ0KPiA+IHRvIHBoeWRl
diB3YXMgYWxzbyBwcm92aWRpbmcgYSBkaXJlY3Qgd2F5IHRvIGFjY2VzcyB0aGF0IGluZm9ybWF0
aW9uLg0KPiA+IEluIHRoZSBjdXJyZW50IHBhdGNoIFJhanUgaXMgd29ya2luZyBvbiwgdGhlIGZp
cnN0IGNhbGwgdGhlIGxhbjc0M3gNCj4gPiBtYWMgZHJpdmVyIGRvZXMgaW4gaXRzIHNldF93b2wo
KSBmdW5jdGlvbiBpcyB0byBjYWxsIHRoZSBwaHkncw0KPiA+IHNldF93b2woKSBzbyB0aGF0IGl0
IGdpdmVzIHRoZSBwaHkgcHJpb3JpdHkgaW4gd29sIGhhbmRsaW5nLiBJIGd1ZXNzDQo+ID4gd2hl
biB5b3Ugc2F5IHRoYXQgcGh5bGliIGRvZXMgbm90IG5lZWQgdG8gdHJhY2sgdGhpcyBieSBhZGRp
bmcgYQ0KPiA+IHdvbG9wcyBtZW1iZXIgdG8gdGhlIHBoeWRldiBzdHJ1Y3R1cmUsIGlmIHdlIG5l
ZWQgdGhhdCBpbmZvcm1hdGlvbiB0aGUNCj4gPiBhbHRlcm5hdGl2ZSB3YXkgaXMgdG8ganVzdCBp
bW1lZGlhdGVseSBjYWxsIHRoZSBwaHkncyBnZXRfd29sKCkgYWZ0ZXINCj4gPiBzZXRfd29sKCkg
cmV0dXJucywgY29ycmVjdCA/DQo+IA0KPiBEZXBlbmRzIHdoYXQgdGhlIGRyaXZlciB3YW50cyB0
byBkby4NCj4gDQo+IEZyb20gdGhlIHN1YnNldCBvZiBkcml2ZXJzIHRoYXQgaW1wbGVtZW50IFdv
TCBhbmQgdXNlIHBoeWxpYjoNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L3NvY2lvbmV4dC9z
bmlfYXZlLmM6DQo+ICAgICAgICAgYXZlX2luaXQoKQ0KPiAgICAgICAgIGF2ZV9zdXNwZW5kKCkg
LSB0byBzYXZlIHRoZSB3b2xvcHRzIGZyb20gdGhlIFBIWQ0KPiAgICAgICAgIGF2ZV9yZXN1bWUo
KSAtIHRvIHJlc3RvcmUgdGhlbSB0byB0aGUgUEhZIC0gc28gcHJlc3VtYWJseQ0KPiAgICAgICAg
ICAgICAgICAgd29ya2luZyBhcm91bmQgYSBidWdneSBQSFkgZHJpdmVyLCBidXQgbm8gaWRlYSB3
aGljaA0KPiAgICAgICAgICAgICAgICAgUEhZIGRyaXZlciBiZWNhdXNlIGFsdGhvdWdoIGl0IHVz
ZXMgRFQsIHRoZXJlJ3Mgbm8gd2F5DQo+ICAgICAgICAgICAgICAgICB0byBrbm93IGZyb20gRFQg
d2hpY2ggUEhZcyBnZXQgdXNlZCBvbiB0aGlzIHBsYXRmb3JtLg0KPiANCj4gZHJpdmVycy9uZXQv
ZXRoZXJuZXQvdGkvY3Bzd19ldGh0b29sLmM6DQo+ICAgICAgICAgZG9lcyBub3RoaW5nIG1vcmUg
dGhhbiBmb3J3YXJkaW5nIHRoZSBzZXRfd29sKCkvZ2V0X3dvbCgpDQo+ICAgICAgICAgZXRodG9v
bCBjYWxscyB0byBwaHlsaWIuDQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGNfZXRodG9vbC5jOg0KPiAgICAgICAgIGVuZXRjX3NldF93b2woKSBtZXJlbHkg
c2V0cyB0aGUgZGV2aWNlIGZvciB3YWtldXAgYXMgYXBwcm9wcmlhdGUNCj4gICAgICAgICBiYXNl
ZCBvbiB0aGUgd29sb3B0cyBhZnRlciBwYXNzaW5nIGl0IHRvIHBoeWxpYi4NCj4gDQo+IGRyaXZl
cnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X2V0aHRvb2wuYzoNCj4gICAgICAgICBs
YW43NDN4X2V0aHRvb2xfc2V0X3dvbCgpIHRyYWNrcyB0aGUgd29sb3B0cyAqYmVmb3JlKiBwYXNz
aW5nDQo+ICAgICAgICAgdG8gcGh5bGliLCBhbmQgZW5hYmxlcyB0aGUgZGV2aWNlIGZvciB3YWtl
dXAgYXMgYXBwcm9wcmlhdGUuDQo+ICAgICAgICAgVGhlIHdob2xlOg0KPiAgICAgICAgICJyZXR1
cm4gbmV0ZGV2LT5waHlkZXYgPyBwaHlfZXRodG9vbF9zZXRfd29sKG5ldGRldi0+cGh5ZGV2LCB3
b2wpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIDogLUVORVRET1dOOyINCj4gICAgICAgICB0
aGluZyBhdCB0aGUgZW5kIGlzIGJ1Z2d5LiBZb3UncmUgdXBkYXRpbmcgdGhlIGFkYXB0ZXJzIHN0
YXRlDQo+ICAgICAgICAgYW5kIHRoZSBkZXZpY2Ugd2FrZXVwIGVuYWJsZSwgX3RoZW5fIGNoZWNr
aW5nIHdoZXRoZXIgd2UgaGF2ZSBhDQo+ICAgICAgICAgcGh5ZGV2LiBJZiB3ZSBkb24ndCBoYXZl
IGEgcGh5ZGV2LCB5b3UncmUgdGhlbiB0ZWxsaW5nIHVzZXJzcGFjZQ0KPiAgICAgICAgIHRoYXQg
dGhlIHJlcXVlc3QgdG8gY2hhbmdlIHRoZSBXb0wgc2V0dGluZ3MgZmFpbGVkIGJ1dCB5b3UndmUN
Cj4gICAgICAgICBhbHJlYWR5IGNoYW5nZWQgeW91ciBjb25maWd1cmF0aW9uIQ0KPiANCj4gICAg
ICAgICBNb3Jlb3ZlciwgbG9va2luZyBhdCBsYW43NDN4X2V0aHRvb2xfZ2V0X3dvbCgpLCB5b3Ug
c2V0DQo+ICAgICAgICAgV0FLRV9NQUdJQyB8IFdBS0VfUEhZIGlycmVzcGVjdGl2ZSBvZiB3aGF0
IHRoZSBQSFkgYWN0dWFsbHkNCj4gICAgICAgICBzdXBwb3J0cy4gVGhpcyBtYWtlcyBhIHRvdGFs
IG5vbnNlbnNlIG9mIHRoZSBwdXJwb3NlIG9mIHRoZQ0KPiAgICAgICAgIHN1cHBvcnRlZCBmbGFn
cyBoZXJlLg0KPiANCj4gICAgICAgICBJIGd1ZXNzIHRoZSBfcmVhc29uXyB5b3UgZG8gdGhpcyBp
cyBiZWNhdXNlIHRoZSBQSFkgbWF5IG5vdCBiZQ0KPiAgICAgICAgIHByZXNlbnQgKGJlY2F1c2Ug
eW91IGxvb2sgaXQgdXAgaW4gdGhlIC5uZG9fb3BlbigpIG1ldGhvZCkgYW5kDQo+ICAgICAgICAg
dGh1cyB5b3UncmUgdHJ5aW5nIHRvIHdvcmsgYXJvdW5kIHRoYXQuLi4gYnV0IHRoZW4gc2V0X3dv
bCgpDQo+ICAgICAgICAgZmFpbHMgaW4gdGhhdCBpbnN0YW5jZS4gVGhpcyBhbGwgc2VlbXMgY3Jh
enkuDQo+IA0KPiAgICAgICAgIEJyb2FkY29tIGJjbWdlbmV0IGFsc28gY29ubmVjdHMgdG8gdGhl
IFBIWSBpbiAubmRvX29wZW4oKSBhbmQNCj4gICAgICAgICBoYXMgc2FuZSBzZW1hbnRpY3MgZm9y
IC5nZXRfd29sLy5zZXRfd29sLiBJJ2Qgc3VnZ2VzdCBoYXZpbmcNCj4gICAgICAgICBhIGxvb2sg
YXQgdGhhdCBkcml2ZXIuLi4NCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2dl
bmV0L2JjbWdlbmV0X3dvbC5jOg0KPiAgICAgICAgIGJjbWdlbmV0X3NldF93b2woKSBzYXZlcyB0
aGUgdmFsdWUgb2Ygd29sb3B0cyBpbiBpdHMNCj4gICAgICAgICBwcml2YXRlIGRhdGEgc3RydWN0
dXJlIGFuZCBiY21nZW5ldF93b2xfcG93ZXJfZG93bl9jZmcoKS8NCj4gICAgICAgICBiY21nZW5l
dF93b2xfcG93ZXJfdXBfY2ZnKCkgdXNlcyB0aGlzIHRvIGRlY2lkZSB3aGF0IHRvDQo+ICAgICAg
ICAgcG93ZXIgZG93bi91cC4NCj4gDQo+IE5vdywgbGV0J3MgbG9vayBhdCB3aGF0IGV0aHRvb2wg
YWxyZWFkeSBkb2VzIGZvciB1cyB3aGVuIGF0dGVtcHRpbmcgYSBzZXRfd29sKCkgcGVyYXRpb24u
DQo+IA0KPiAxLiBJdCByZXRyaWV2ZXMgdGhlIGN1cnJlbnQgV29MIGNvbmZpZ3VyYXRpb24gZnJv
bSB0aGUgbmV0ZGV2IGludG8NCj4gICAgJ3dvbCcuDQo+IDIuIEl0IG1vZGlmaWVzIHdvbC53b2xv
cHRzIGFjY29yZGluZyB0byB0aGUgdXNlcnMgcmVxdWVzdC4NCj4gMy4gSXQgdmFsaWRhdGVzIHRo
YXQgdGhlIG9wdGlvbnMgc2V0IGluIHdvbC53b2xvcHRzIGRvIF9ub3RfIGluY2x1ZGUNCj4gICAg
YW55dGhpbmcgdGhhdCBpcyBub3QgcmVwb3J0ZWQgYXMgc3VwcG9ydGVkIChpbiBvdGhlciB3b3Jk
cywgbm8NCj4gICAgYml0cyBhcmUgc2V0IHRoYXQgYXJlbid0IGluIHdvbC5zdXBwb3J0ZWQuKSA0
LiBJdCBkZWFscyB3aXRoIHRoZSBXb0wgU2VjdXJlT27ihKIgcGFzc3dvcmQuDQo+IDUuIEl0IGNh
bGxzIHRoZSBuZXRkZXYgdG8gc2V0IHRoZSBuZXcgY29uZmlndXJhdGlvbi4NCj4gNi4gSWYgc3Vj
Y2Vzc2Z1bCwgaXQgdXBkYXRlcyB0aGUgbmV0ZGV2J3MgZmxhZyB3aGljaCBpbmRpY2F0ZXMgd2hl
dGhlcg0KPiAgICBXb0wgaXMgY3VycmVudGx5IGVuYWJsZWQgX2luIHNvbWUgZm9ybV8gZm9yIHRo
aXMgbmV0ZGV2Lg0KPiANCj4gRXJnbywgbmV0d29yayBkZXZpY2UgZHJpdmVycyBhcmUgKm5vdCog
c3VwcG9zZWQgdG8gcmVwb3J0IG1vZGVzIGluIHdvbC5zdXBwb3J0ZWQgdGhhdCB0aGV5IGRvIG5v
dA0KPiBzdXBwb3J0LCBhbmQgdGh1cyBhIG5ldHdvcmsgZHJpdmVyIGNhbiBiZSBhc3N1cmVkIHRo
YXQgd29sLndvbG9wdHMgd2lsbCBub3QgY29udGFpbiBhbnkgbW9kZXMgdGhhdCBhcmUNCj4gbm90
IHN1cHBvcnRlZC4NCj4gDQo+IFRoZXJlZm9yZSwgaWYgYSBuZXR3b3JrIGRldmljZSB3aXNoZXMg
dG8gdHJhY2sgd2hpY2ggV29MIG1vZGVzIGFyZSBjdXJyZW50bHkgZW5hYmxlZCwgaXQgY2FuIGRv
IHRoaXMNCj4gc2ltcGx5IGJ5Og0KPiANCj4gMS4gY2FsbGluZyBwaHlfZXRodG9vbF9zZXRfd29s
KCksIGFuZCBpZiB0aGF0IGNhbGwgaXMgc3VjY2Vzc2Z1bCwgdGhlbiAyLiBzYXZlIHRoZSB2YWx1
ZSBvZiB3b2wud29sb3B0cyB0bw0KPiBpdHMgb3duIHByaXZhdGUgZGF0YSBzdHJ1Y3R1cmUgdG8N
Cj4gICAgZGV0ZXJtaW5lIHdoYXQgaXQgbmVlZHMgdG8gZG8gYXQgc3VzcGVuZC9yZXN1bWUuDQo+
IA0KPiBUaGlzIHNob3VsZCBiZSBpbmRlcGVuZGVudCBvZiB3aGljaCBtb2RlcyB0aGUgUEhZIHN1
cHBvcnRzLCBiZWNhdXNlIHRoZSBldHdvcmsgZHJpdmVyIHNob3VsZCBiZQ0KPiB1c2luZyBwaHlf
ZXRodG9vbF9nZXRfd29sKCkgdG8gcmV0cmlldmUgdGhlIG1vZGVzIHdoaWNoIHRoZSBQSFkgc3Vw
cG9ydHMsIGFuZCB0aGVuIGF1Z21lbnRpbmcgdGhlDQo+IHdvbC5zdXBwb3J0ZWQgbWFzayB3aXRo
IHdoYXRldmVyIGFkZGl0aW9uYWwgbW9kZXMgdGhlIG5ldHdvcmsgZHJpdmVyIHN1cHBvcnRzIGJl
eW9uZCB0aGF0Lg0KPiANCj4gU28sIHRoZXJlIGlzIG5vIHJlYWwgbmVlZCBmb3IgYSBuZXR3b3Jr
IGRyaXZlciB0byBxdWVyeSBwaHlsaWIgZm9yIHRoZSBjdXJyZW50IGNvbmZpZ3VyYXRpb24gZXhj
ZXB0DQo+IHBvc3NpYmx5IGR1cmluZyBwcm9iZSBvciB3aGVuIGNvbm5lY3RpbmcgdG8gaXRzIFBI
WS4NCj4gDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgu
b3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEw
TWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0K

