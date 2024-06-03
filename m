Return-Path: <netdev+bounces-100045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF48D7A68
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C77D280FF9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36EBE6F;
	Mon,  3 Jun 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0OEBuGih";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s3jGPn/q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FA2904
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385045; cv=fail; b=miP0s8+6Xrw0fVrZpeZopXtSYgkZe+19ok23ivrUneditbSTx31fuCtTyfT3k0QuFpgp0AV0DV6oL4OpYv0JRIGEqymMr7npAcfy1ASKmEXqGDDQXoUW5PAZ1tsWfbg71Ne++T8fJe9wvEnYyo9pyAvl2Tp4KhNg1EtO8D0id3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385045; c=relaxed/simple;
	bh=99swkBRei25hTJ+ECx3FX/kn1vfJh5IU7z4rms38oLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTkKFhurZJHd+JU2VdECxLJiagPMTFOKPsIXr4ytdqlfLw9ME6okh98pqpfaJEJ24Bk+6IsvfQTdxuZhQXG6GxavGQxNxcX1Jh5OVJi9d3v82PmrQmPUYqsfpe5PzBJkdSIvwIb6DD9GSw/wa0Yry0MvXwYw3CxrezE0EfoLJDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0OEBuGih; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s3jGPn/q; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717385043; x=1748921043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=99swkBRei25hTJ+ECx3FX/kn1vfJh5IU7z4rms38oLQ=;
  b=0OEBuGihBvHM6UeHOL4EexJIqhEo9t65S+aAsQU5W1cy6XjJPr3cNos/
   ifGGsNluNeI06KrkBNe2J3eigHenE6yRr6uRp5Q+h2MOlCCdbobUiUuLf
   7tLIUdpUtgjDAL69NxbymXDQU1HhpidupFoecljpazIJoIdVlBXE85MmL
   FmW0Wjkyi3YTGO+vsItA/zO26eDqYJ8WVVdhzeIEip5oEfkk3ioEiycmL
   L566Y3ggkG9CXtYdWYnTyU+dlJTVabp1DMeTuNMERuR7RKCE2Zep7Zgel
   lSYXdUZg+i19WXt3FMEanD4OnUdroWUNWPlkzay9aUerQnOOSPxjoTUDP
   g==;
X-CSE-ConnectionGUID: +5rE2tfNRR+WZ4lFD13rQA==
X-CSE-MsgGUID: GV3dCEsfRzesh4mneL+9nA==
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="257715756"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2024 20:23:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 2 Jun 2024 20:23:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 2 Jun 2024 20:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVLYfTVaQ3DMkqfzjPrIo/KSfFCtoYjq8nQzMvJBoRy0OxsLXxwpl3hTif4DvLCGYjAaKMRr2sKuobg2r7wtorTL6NQlVB4PlWXknirBigekNzztsrfr6JIsDeZlnexu9MLACKUxiDKZ9nPZwp++J2dbHOTJwPiarmDeKFPMi9XpPV20TitvoF5MJTuBdg8ZX7550cE/Xw5MRTenSuauqUWkxHz+ulCh653V7SSPXHpTnoMac3E7W/pVFL1fxP48C9CLizmcoXtZkjUWqjHrAE8i6QquuTQOjNThbA1J/V2ro2GgTFCAjtnhKa0UPaiP3GEmqta3RDxiaJOdTDy+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99swkBRei25hTJ+ECx3FX/kn1vfJh5IU7z4rms38oLQ=;
 b=UMzEL9nuByVPQqU2ipZNgp0IVppXdqQ0SzmxyYsqBUNMMSpeZELTS/krAb9jj1/MWVdSURIN8kRseGJlMaXst2I/oVndgykr7ZfvUfG/DCWwWZyKZdSf5enBJMdlof0RAOxwIqJjtEYKmc3FveOiVoaekze6+Xkn8DJzL3S8TtUwnecXDDg23ULNPa6oKNaRhr6soX6BPaCsfJ9SpAo/4yWEVmsf8wQIbmBiqNMDa7mNt0X76M56mIf2JXxzziLME9hoWo2aOGgFfvMJk7c6Agy7Qt8qEZmH38MSdoEC/J2HcROTNWixvxamn2HJ8BCcWRtUSNLh6RDRl5+MECwlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99swkBRei25hTJ+ECx3FX/kn1vfJh5IU7z4rms38oLQ=;
 b=s3jGPn/q1rf0a81PzgkpmFQL2hbS20CV3fclhC6d+F3TXvKcIL8AjUdVDmIxyIGYDSAQ638n0NjUfEq+K0ZEtpErGyrP3TIifNMvnCpYSRyUgz81y57vaxER7SToy6VzE9h8ontAHtz2MlNL/wLklFdGTU4VbUmwnYFs8pxCCyyBdhHeNOVhqXz9gIfy/wczvfxpWTvM9ID1+wm4Ua6Rd/t/53/+f3Qi+z3XlL5cGJ9GLvTJpLu/ZaFrCl8k9TIEF8DWOapmiANTLN5sWlVtHopqWlrTaz6sjM2WzW+dJYr7b6t44Xv7cuEZKEl/aAq8vIno+2Q8Jt9gVkSNJHcV9g==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by CY8PR11MB6961.namprd11.prod.outlook.com (2603:10b6:930:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 03:23:22 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::a585:a441:db24:b547%3]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 03:23:21 +0000
From: <Arun.Ramadoss@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>,
	<hkallweit1@gmail.com>, <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net v4 4/5] net: dsa: microchip: use collision based back
 pressure mode
Thread-Topic: [PATCH net v4 4/5] net: dsa: microchip: use collision based back
 pressure mode
Thread-Index: AQHas2ZgRUKg8yixkU6jupD/rfBLd7G1ZHGA
Date: Mon, 3 Jun 2024 03:23:21 +0000
Message-ID: <8dcf8dd3ddccc64d2b080c17f293618a15577c96.camel@microchip.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240531142430.678198-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240531142430.678198-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|CY8PR11MB6961:EE_
x-ms-office365-filtering-correlation-id: 7fabbe4f-f063-4e27-5f8c-08dc837c8574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T21RcktLK2V0VjZYRGRDajVqT1NRamtmbmFLczRhNjRaNlN0UEdjVU04NTcy?=
 =?utf-8?B?bThuUTNJbDFOU3JCdU1pM2owV1VveS9CeUxROWhqVWxzNkptQ0I2UkRLVU5s?=
 =?utf-8?B?NHg1eHA0YjZRaENaZC9kZnpZcm9uMVh4dUpMVnJxSmEyNW5ERmFadVBmeko0?=
 =?utf-8?B?ZXpHWUEybDdzeVNVVnBwd2F0OHlicXBLaFRndlprNmEzb3BtdElxd1JLSGhG?=
 =?utf-8?B?L0RGTXlRVUdOeFZTL0JXY05RZGoxYmJDZGoyMmpLbmtMSFl2UWJlQnFkUCtw?=
 =?utf-8?B?ME9oMkxUdUU2VHE2OWxDVWc4OFVtMmduMXVGT2t0UmdOK0dQNDVUenV3bUY4?=
 =?utf-8?B?UnNzZlRrM3hjN1ZLdHJsZThJelpYSTNOeG81MzFCUTNYWHFqRUYxYkFOdGpa?=
 =?utf-8?B?ZFk3UWdVZjVHK0lZL0taRnVTVnUxMy80TFMrNW5IV2N2Uy9jTFoxMXVYZnZ6?=
 =?utf-8?B?QUJPc3V5SFdLTHlYcXJ2d1B6aFB5Y3lYSk9HckRuMFV1a2xNOVRaRS9TQ0Fo?=
 =?utf-8?B?Y0tqdlNhUVdXQXRvSEN5RE9JaGh6V3dvM3gxbHIvS1luYm1XZjM0UlZUS3Jn?=
 =?utf-8?B?ZksyU1Z3TTMzc3VORS9WeFE5U29oNDVnZGUxOHBBdnJ2NjlMOENhRWxTVENs?=
 =?utf-8?B?Y1hiWmZXQ2FJUEV6YmNkZGJ5eTl6VkhLZ0M1N3NFanVzcGlKdVo3S2RxdU55?=
 =?utf-8?B?WXE3RitHWG9pQWxVL2ViaVVId2JXUlRja1M3RUZ5dHF3S2Q4UlJYcE9ZRTJj?=
 =?utf-8?B?WTRsK3pCQ0N1WFBYK3R3ZGVoZXM5Q0I5QXBsYWpLd0txTVJ5c3QrWC9jcSs1?=
 =?utf-8?B?bjZYellqRHBVd3U4WmQ3VlhjTmt3ZjZWbFRQNkVrZ1djdURNcDV6MUZWazFP?=
 =?utf-8?B?MWFRRTdwUDlETjZiVGJkL0cyMHBRZ1B3NHo4dms3S3k5cHFUZ0d0akFpRTFx?=
 =?utf-8?B?b3lVZHlxdmZlNGdDNTBacEN6Y2lxTjJRR3QwWUFMaWFsaGJLeWl1RE1iMERa?=
 =?utf-8?B?UGdVU05VVE1sVW4rekhrUkVFcDNpMFB3dkVxakYrTERhZG56RlBnUUNzV1Ri?=
 =?utf-8?B?eS8xSHFBVHd5YWE1K2pFTHBGNmJFSmM2dDEzWlIyRFdDZzc5cEtVbjYzNUE1?=
 =?utf-8?B?MFM2MVF3T2c0Tkh3Mm5BVURZOGlCYmlGcjYxMXVNV0JyRjhaNStuNXFSUFJM?=
 =?utf-8?B?blRrcW83U1JITldVbUFjcFFhKzI4cnVPci9lQXJPVWFrWE02S3ZBMmI4Ykg1?=
 =?utf-8?B?VjA0QlRFMGVmbS9saEttZ0lXelFqOUZoZEZRNGxuQUEvM2p1UDlpYjVmOUV4?=
 =?utf-8?B?Yy9QVmI4aEVwWmd1dS9xamFaeHpMZXpaZjA0NWZjNzhpQVpMTGVYcTJva3VO?=
 =?utf-8?B?YVljY25GaEI3ekJqak9IUnBhL3lOT0E2S2VZM2d4RVd1WlgvRkx0Mkt0UHov?=
 =?utf-8?B?QTFkWGFQRUgvQ1Q1aXlNNVZSVElQQ1VQNDNBcGVEMmRFcmZRZkF4d0duOExV?=
 =?utf-8?B?Lzd5UktKNFMxSXl6cjJreWdSWERtOUdrZU93Q2NXdUtERFFIRDZobTlsTGNI?=
 =?utf-8?B?d2x4UEZFeXI1Uko4VlVmaHYyTTBqeXEzdE45d250OEFyWjdzWUFHcEJsUUc3?=
 =?utf-8?B?RXNpVERTVmp6R1ZHKzBYL09DZW1TT09JdHNDVlc0RTB4RUtXeU9LWnVrd2Za?=
 =?utf-8?B?ektpY3lzOEQvekk4OERNZjNFMjdtYmd3ODFoNzlzdllHdDh6VlVaU09scFBy?=
 =?utf-8?B?MU5BS1ZjRGZJZ3ZNaUVHY2J3cUdKdlZpeDRYcmxKVlppWlVmR2hlRjl0Nk8w?=
 =?utf-8?B?WXlpZDdPbEkya1M1eEZDUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpRVkFVZzEzWE95aWd4RjBsQ29WQmVRR1loSC9RN3AyQ0N6VUVERzlWZU5q?=
 =?utf-8?B?dHNqd3MyWEZOMDdlZHNJSmU1MDdxdW5xMnFnWkZMWnpubE91c2FqTVIrVWFx?=
 =?utf-8?B?a0oyTnhJWlpENmxoUGRwckNOY3BPU1NoektQQ0crZTlLNVVabitreGNZQVpt?=
 =?utf-8?B?TjFubDQwQWlha0VxcFhqNHFJNTdqMEkwbEVNZlhrMVVHVXJxUDFyRzNCVXlF?=
 =?utf-8?B?N1YvRHpPaW51NWRrdS9XemltR0NPM3M0V2toZlVxNUx4bGNZbWRvK3pWVXF6?=
 =?utf-8?B?T0RwamtidE5hRjdlYjJFcHNTd0pkeXFPWGE2NzNPUG9uRG5mc0psaUtXWUx2?=
 =?utf-8?B?eVdkdWJ0L2pSNDIyajNCWm1PeU8rRW91MkV6QUdINmJXL2JTd3A4aEUzUTlR?=
 =?utf-8?B?ZlpjQkZIaG1yenppd0E0ajBYYmE4QXV3YWwrYkJEancrSFJUTW9PaG1JYy80?=
 =?utf-8?B?cjFtNEhDOVEwQUI5WkxuS2l4N21NSlVYOTYzRzhpM0FCTjQ3NDJGWU5aTzBF?=
 =?utf-8?B?b1h0bDFqcnduY1p2OVQzY3AzOUREYTdKQWtSU0ZmeHlqK3g2WGRRWEpaWHEy?=
 =?utf-8?B?eTJLVzFiQUJ5NGhaUEl0em5nblo1Vm5ta0I1RzlIeDBCNUpVVGR2VWhPOVB0?=
 =?utf-8?B?aStET0JIQkRkcUtRVHJZRkl3OWpkbkJ4OVVDVllkKyt1bmFSRElONHB0TlhT?=
 =?utf-8?B?UTRheEZSU3VIWEVuWGFGbVFLbXEyNWZITjcvQXh1VVVxRXA0eUZaQVRsN3d2?=
 =?utf-8?B?UWxKOWI5Ymo2cVg3Vzkya0xLK1RsMDhUOFRYSE9GVnhseW04c1NVM0w1YjBU?=
 =?utf-8?B?NjcxdDBkRFhhZ2x6TkNrenowWXlaQ1RzeFMvUC9UN0FGUTRpSWtiUFNXWmU0?=
 =?utf-8?B?eFpqbWpDeVBwSmxteFlZeTJUM2hBSFZza3IvZi9KakhIQkYvT1ROd0lrejR2?=
 =?utf-8?B?V1RONm1IVlAxKzBJK1Z4QzRibWhla0Jpd2FjZDhqVVFZNi8rRFJTVStoQ1U5?=
 =?utf-8?B?R3lES243MnJMNDQ0NThPNG83WDVBanZkdVN1SzJWVUtsZ04wL0hiZEE0emFZ?=
 =?utf-8?B?WkkvdmNtK1QyNVZMVHZtS21pVHhjendERVpFYTlqVzZ2QnBTM3VZTGdTbWlH?=
 =?utf-8?B?ZkcyZ2RJN2FwVVFqZW1HWGRRa01EZmU4eUl5ZllMeG8xVTBUWUNzV1BMVWJJ?=
 =?utf-8?B?ZjFYb01aR3NpUXVxK1NURlNVaTdkd2tBRWRJR2YvNjJmakxDbEMwZi9mWXI3?=
 =?utf-8?B?TDdGajd3SmNjZGdxRUtLaisyQjkyZzZjWklvVFU4Q29KcUdDcjJMbSt4dVBw?=
 =?utf-8?B?Vm5USHVtdlYrUHovL2xzWjVnYTZ4Wkw4MlZhVlRVdGsvSWpUMllIaTd3a2lx?=
 =?utf-8?B?Nkl0YjZLY2tETDc3YXA0NmZXaXAyVXFUcmo1M0tETmFncm9PcHB3bnBjWGtq?=
 =?utf-8?B?aldwQ1ZiVXNEUGhlWlNHSm81TkZZRENQbzRwbVBTRHFtUFFRY2U2WVFuQjFC?=
 =?utf-8?B?WDRGMmFCL2puTmdiNlU1cVYxTWhVTzhZZVRVdzdHSzBsVUZwVzRVVGQyR24v?=
 =?utf-8?B?OVdYcjdoUFFTeTZzZzVacVUvNFRNRG9IemVwd0hvYVFoMkdYOVhPeUt0ZzJu?=
 =?utf-8?B?SlJTMUhldGhBQStBd2RhcGpUQlBXbDNycEdRRjdoNy9IMXlzWTFFRUl6d09T?=
 =?utf-8?B?ZkZZQTFnVWYvN2dhOVEvSnE2bGRXSlhvVXIrS2RtRnpzclo4SDVhYnlQeG9x?=
 =?utf-8?B?anRVdmgrQ2VSZjhKQXYzQkFEQW9rVE5WcVZ1LzFyS0hKUWJVaHJ1SGhtaGRm?=
 =?utf-8?B?UEhldWFKRkp1RVpRcUY4dDdCMWlKTGhIK2doYitMcENyeDJFZk1KTnplU0U1?=
 =?utf-8?B?OGR4MGtuNDFEK01UMGRJVExuVlhhZnlBSkFQckdWV2NzUlFmTm1hN2lZUkNv?=
 =?utf-8?B?c2huQ0NWcUt2U1RmeUVubmpmUkVkYVp0TFgvUjBWNmlDQjRucXZCOTZSYy9l?=
 =?utf-8?B?andKditCSEVmMVU1amtiWjZWdUpwWmtiY3hUQjlyUzVIbktLSGsrZVhvcGZp?=
 =?utf-8?B?N0dJMGFOVTRQWGp6UzhJdnpjTWhVUFpYWVpyKzNpZlp0UmhPZ2FXZDlXTGZX?=
 =?utf-8?B?djg3dWZoMlNjUDRkNXN3Y1l0QUJMVWlMRFZzUHpDVnFWRmxHWDlsdzJ0UW9I?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4920E7B724EC469040737E7D228E58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fabbe4f-f063-4e27-5f8c-08dc837c8574
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 03:23:21.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kiRsCj8/ADz/ceBBL2VJmbA9uNhSRn9lPjVf1MHiNEon/gQPH0a969TQ8gIcxB/2fAP/nEmglQr+0zmSzVpbRhMD6KRm1XHveG1+MybxAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6961

SGkgRW5ndWVycmFuZCwNCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNy
b2NoaXAva3N6OTQ3Ny5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o5NDc3LmMN
Cj4gaW5kZXggZjhhZDc4MzNmNWQ5Li4zNDNiOWQ3NTM4ZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OTQ3Ny5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9t
aWNyb2NoaXAva3N6OTQ3Ny5jDQo+IEBAIC0xMjk5LDYgKzEyOTksOSBAQCBpbnQga3N6OTQ3N19z
ZXR1cChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+ICAgICAgICAgLyogRW5hYmxlIFJFR19TV19N
VFVfXzIgcmVnIGJ5IHNldHRpbmcgU1dfSlVNQk9fUEFDS0VUICovDQo+ICAgICAgICAga3N6X2Nm
ZyhkZXYsIFJFR19TV19NQUNfQ1RSTF8xLCBTV19KVU1CT19QQUNLRVQsIHRydWUpOw0KPiANCj4g
KyAgICAgICAvKiBVc2UgY29sbGlzaW9uIGJhc2VkIGJhY2sgcHJlc3N1cmUgbW9kZS4gKi8NCj4g
KyAgICAgICBrc3pfY2ZnKGRldiwgUkVHX1NXX01BQ19DVFJMXzEsIFNXX0JBQ0tfUFJFU1NVUkUs
IGZhbHNlKTsNCg0Kbml0cGljazogQ29tbWVudCBzYXlzIHVzZSBjb2xsaXNpb24gYmFzZWQgYmFj
ayBwcmVzc3VyZSBtb2RlLCBidXQgaW4NCnRoZSByZWdpc3RlciB3cml0ZSB3ZSBhcmUgY2xlYXJp
bmcgaXQgKGZhbHNlKS4gRnJvbSB0aGUgZGF0YXNoZWV0LCBpdA0KbWVudGlvbnMgMSAtIENhcnJp
ZXIgYmFzZWQgYmFjayBwcmVzc3VyZSAwIC0gQ29sbGlzaW9uIGJhc2VkIGJhY2sNCnByZXNzdXJl
LiBJbnN0ZWFkIG9mIGZhbHNlLCB3ZSBjYW4gaGF2ZSBtYWNyb3MgbGlrZSBiZWxvdyBvciBzb21l
dGhpbmcNCnNpbWlsYXINCg0KI2RlZmluZSBTV19CQUNLX1BSRVNTVVJFX0NPTExJU0lPTiAwDQoN
Cj4gKw0KPiAgICAgICAgIC8qIE5vdyB3ZSBjYW4gY29uZmlndXJlIGRlZmF1bHQgTVRVIHZhbHVl
ICovDQo+ICAgICAgICAgcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKGtzel9yZWdtYXBfMTYoZGV2
KSwgUkVHX1NXX01UVV9fMiwNCj4gUkVHX1NXX01UVV9NQVNLLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWTEFOX0VUSF9GUkFNRV9MRU4gKyBFVEhfRkNTX0xFTik7DQo+IC0t
DQo+IDIuMzQuMQ0KPiANCg==

