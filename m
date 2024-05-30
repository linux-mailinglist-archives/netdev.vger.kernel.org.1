Return-Path: <netdev+bounces-99575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E2C8D5599
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0FC283C9E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D2B335A7;
	Thu, 30 May 2024 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YzvC/zrO";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jY0iwkpy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B121A0D;
	Thu, 30 May 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108956; cv=fail; b=ble5VeJFgdsu88t4Wo2fs7LbKFakCzu8pPxkAfMia1wYdLtFbRUfYdvwlpkgNvQtmrpTGHwkwa2nZ0Tfj6ZODuA4eQZPOU3EU/3PQMQWt9xKoinA6wssJgEmM5/5QkeUEKmwyYumbrtKFASPAFh1deOZOdG25YEWG+NxTA7b0Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108956; c=relaxed/simple;
	bh=sZmILTcJAhthgOi26VIoDiNBmRl0UNysH2D1oz+5viY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OT3EgSB88sJ9/zzGaf5In4eQmAHlrwFIaLg/xZxZ8eezB0scwgt+4Dt8y86s5Kcatv1l+mEPSxlowNwt4z6OFEOJrjw/uJPwkG50dpJQLPfa4QWj98ntEu70YcpBY84N7s34sPWKhZpHSbHhdCXvmdlNl+1GYFd/G/DuNl6XT6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YzvC/zrO; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jY0iwkpy; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717108953; x=1748644953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZmILTcJAhthgOi26VIoDiNBmRl0UNysH2D1oz+5viY=;
  b=YzvC/zrO6maWgWbXeDxTjf0ezN0H77qoiJAt9ZFGEOlKFCuo3ywBFw1O
   uSHW+wVXvcCODE7B26CEZSz/rsDEdip3XRjRUSYnrO+MxPXF++u4jIrxy
   Hn8II36Y4knN6Qx1fssYFKCDduZFywRHiWdH9quEtZGrHHoT625L8ZMX/
   1fQEJnQOO8GX2iWv3++RAgqxuG1KJTg3n+QN74GXNXlptcu9A/6mmJfcd
   d4WiOOeFWZBn0jIMkv7/SRFHAlId3Izp/CZTPUNaRwvY6+dNwToswDxil
   EHZlF/y+M5mBNYurqHlWsJ0Uyzg3shPggJ/GpvRcfulmUW0khW70iiwz9
   Q==;
X-CSE-ConnectionGUID: Quip3wVuRAWY/rmKCA0ENg==
X-CSE-MsgGUID: T9vBZtqoRp+t+oqvyILQ5w==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="257615361"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 15:42:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 15:42:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 15:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPOBW96PCjIA+VNRwP/2nx2TtEGKFVcFSwiOJZyjI+5YkuDwczkMDuGNl1+iFFJA7NGhOl/GNIkUVWQNGF8Oyf02W6Bhtf33zpOdGm4FBRWxwZAT2zAPA5m3MxCCvbZ9BQpCQwhsWD0x4zvyX9F1ghP2A+EOwpYjXgF20/Mmhx0iutYpnY1aWwRLHTyS9A/L/pwhuEiO4wLN3ZezzeYFamDXH/66HMWvFVvhTD6M6xki/IRcuI/lSfYNup16g0FLKnXH5Yk/IXbFGU1hdnlAtojVzitjwPtd3StL7+lx5XQG3yIMMmoXwLpxUVZEVYt361HfE7QF7ebLiGP/S883ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZmILTcJAhthgOi26VIoDiNBmRl0UNysH2D1oz+5viY=;
 b=PvR/IWbrfE7tX8ihTKf8tkbblrMZ3i+TSXAZwYeI/bzFsLcJ4r0PnpJIzP0QgRk5ZfYzg6l2OEBDaSovue4/fpMrT6/uejGFRlsrf7+2At1uPBvdPtJecxQEIM6FIIEwEP1i+98ezMIGAiIp5DVME4dnFnysZrtz+r8xnbO5KubcdoUnTy6VxW1QZQYzV5xNTM2noHW3wLnZxO78NG4jXhX61BV8sw+p7PMtcU3yD2wKfiuOGaJsogID1Ff9ZPva/kYlo8gV9/V7m0ve+Th1Uf8LM8/7fGzvgWrOwSExfVCAvznJVheFYTk+o4gGXCo7Sr1rklZ4+twHTSCnmHN3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZmILTcJAhthgOi26VIoDiNBmRl0UNysH2D1oz+5viY=;
 b=jY0iwkpyMXAL2MzzlXI4T2knW3Fn42njX/DtN7EjDM9v/a0CNie4mfdnsAtNMAoP/PaqtXYxP0jKwBYVA8c8eSgqofCM1RyElo9CVR6lRBVu+MvkEQEgMi9QvdPCAJKgWEYRgNjkwDOVhh4AF3uBeJL4DQCKQPhVdnf40W9Lh8cbEWaqDa0YxG23t0n7wSQhxFfJk7K8mhB+SAGa45xIDg3tI2yKkmyUdi6GjB8iU09lnJTDmMlfxQ8ybsutM6cHvcbk9sLDfjtEhHs6JUbcqBdQx7+p5Ce8tp2vSDhQX+uA8W0Ycha7dH4WOrUpEKy5KI5zJpJRPdkLSX78ARmPgA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 22:42:23 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 22:42:23 +0000
From: <Tristram.Ha@microchip.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
Subject: RE: [PATCH net] net: phy: Micrel KSZ8061: fix errata solution not
 taking effect problem
Thread-Topic: [PATCH net] net: phy: Micrel KSZ8061: fix errata solution not
 taking effect problem
Thread-Index: AQHasUbPbp29hgFhoU6PYbojhxBuLbGvgxeAgADfFqA=
Date: Thu, 30 May 2024 22:42:23 +0000
Message-ID: <BYAPR11MB35587571DADF73195961A9DFECF32@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1716932254-3703-1-git-send-email-Tristram.Ha@microchip.com>
 <b52073452a085524b436762aeb3aff8feb8005d1.camel@redhat.com>
In-Reply-To: <b52073452a085524b436762aeb3aff8feb8005d1.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA1PR11MB8492:EE_
x-ms-office365-filtering-correlation-id: 02953190-6f4f-46ce-49fe-08dc80f9c5df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?S2ExL0R1U2NKbGhkckdwQ2ZuYXp5WFpCSkxzY1hLVlBLbzJGOW5uQjFiZlZJ?=
 =?utf-8?B?Z01yQWxtTjB0dkZWWUFzQWt3aG85aXFkeHl2aWRodHZOMlREL0VRUUIrZGkw?=
 =?utf-8?B?RVpYMWVGNDFvOVVHSHFxNzJyM0Z1dVRvSlpXYnFQVUN6VHdad3JkaEJoY3Bn?=
 =?utf-8?B?UExUdHlPU245REFGUk5pa2JtcFBFUXdGQmtMa0NrRjhNOEpYVUtxVVUrem9k?=
 =?utf-8?B?Z0k0YVZaYzdHS3ZmVzFqNTNDbU9kdms3NnZiQmxzdDZDVTdtaUp3UVNFRWgz?=
 =?utf-8?B?Qlk2QVFJWDhSZmVCK2wySVJKUzBqSzI2cDRVQnNUeWJHaDZlSERnY3F1alk2?=
 =?utf-8?B?K2x6bG9Wc3pMY21RbjQ4eGExSFRJbWZXU25YczhkbVBnZEpMWkVJVVM5SEc0?=
 =?utf-8?B?S21rcEtGZ0JxVCtvQWFER2JCdGRJRGpENm52ZTEzN2dUbFRRYk9VT3IrbWNV?=
 =?utf-8?B?RDg4OUw3L2NXVnZueWgyM1dDY2RlYWswRFZvaTlEMFRBZDU4UXdYaVh3dGtO?=
 =?utf-8?B?SUlSNkNwUEJGa2NUcS9YY0xlNUFoQmtLaHZXcFJ0MGhkYlJrcGlHUDU4OEQz?=
 =?utf-8?B?bUk3bDlPekVtb09QNmN3RHBRUWdQS3JlM1pTb0JSaTBnUGlCZWJIZHhuZk5O?=
 =?utf-8?B?YUl6a2V6UmRZK25yWFZqMG5nM3d1Z0V0VzdGMnBuOU5oQlBpdVc5TzE4TEww?=
 =?utf-8?B?S2JTQUhsbEF4amYwbmdVVmdWZldhWVNUaHU3MGlzY01kL3BSQWduU3RqNnFM?=
 =?utf-8?B?Y3RpclFmd2kyYVhTT0FuTGR1Ly9tRDlrUzVwcFZobU9TWkZ5OVhJOTdVNUJM?=
 =?utf-8?B?Wjlta0l0SHZGUXkwQnNtNXNRY3NSdTVaV2IwQlp1aGxNZjUzTFdDRHRaNzZj?=
 =?utf-8?B?YWMxcm9IZHNGZjQ3d01TN2xxVWhycnZOZDNhVjAzaDVzeXBJWU9oQ0hkS2Ix?=
 =?utf-8?B?SUs5VFlzb1AzNFhQSjcxTlIvWU9qbTZZVzNFZjduaHIzU21kcFcraXlzS21i?=
 =?utf-8?B?eEtVNGVhSDMybmdsQm9mQXUwY1RPRW5XOERMemYxNTFQK2duQUF3K2M3TFRx?=
 =?utf-8?B?anAvWVM5MFFjOHdIQzJPc3Z1d3hkeHoxY29yKzEvZ1IxTmZkbkJqenltMGtU?=
 =?utf-8?B?OC9hVnJNalZJVWJqa3cwZWdBUWhrazJkajJSUDFZalRNNkpwQUZJTFNvckJu?=
 =?utf-8?B?SFk0SERkMGtENHRrQ0ROVVNoZzNiQ3drWTNVbnhVVHQ2NFpQREQ4R0JpUlV0?=
 =?utf-8?B?aUQ1d1pvaWhLMnMrUFU0VTR5a2xPVVhEZm05ZFk2T3hnQ3JwclpDcjRnMm5z?=
 =?utf-8?B?ZHJJMnd1Vzl0TTZ3dGIyNURINGZYZmNVTlFNV3FhcUwzeHlra3F3V0RyY2V6?=
 =?utf-8?B?M2ExNFpEbmUxQWhHbFltdElYcWdGeU9hTTd2L1ExUWszVVFZK0wyZVdjL0h5?=
 =?utf-8?B?MGdtblZKTDhCQ2IvdzlsdEwrTGRSQXFyVGtmbEVzalVTd0w3THkwM08zR2U1?=
 =?utf-8?B?NHFOK2l3Rnl4REFJN1hUZ0xoRlY1clYxaWZtSmVjVDhvbE93Z1hicHZIZnRr?=
 =?utf-8?B?cmVERmgyQ1pBZ0dSWTBtczl6Yk1ERHUrNWlLUHloR2QxWCtZME0yTDY4ZlhO?=
 =?utf-8?B?M0MybmpXUlJiWUNnbDAwRTlxb1NBZzByMytoQ1pNZ3R1eWxGRHBjbXBScjY4?=
 =?utf-8?B?ZGZ2WmYrczBFVGlJaFBCU09FMENqUFBjS1VleTFOZGxIL0J6YlpydGw4eER2?=
 =?utf-8?B?bklxOFh3SjFzRGE3Q3RaMXlGSFp6ampzZ3pqWVRIOThzeXhIbVNXVS9meHdH?=
 =?utf-8?B?M2Z4WkpYb2FjT25jaTE3Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklOUmFFTlMrQnFidGx5K1djZXEyNlVtVVcwcWZIK3BkYzBzbXVqYzhxdnJk?=
 =?utf-8?B?cjZCSjFDeWZPWU1nM3RNZDU5WU52aHpWaXhDZ05zZHJtdCsyN2tzSFFINGhl?=
 =?utf-8?B?NWVTZ294YzNUd1F5cjNLVjViSVhxaWJuOUdVNjV0dGxYeEpiU0dRbzMzd3lJ?=
 =?utf-8?B?bzJUUXE5SHJXcW04UFYwVlFxVFh2Z1NYSzRxcWtRNUN6UEsvM3cwc3ZwZ3RV?=
 =?utf-8?B?NTcwMEQ4R05LbjRDOURNVUJxVDhtSUMxMDBrSXlURmF2bXpMeGUzbVRjK2g4?=
 =?utf-8?B?QWZFOTR0MFI3TGlpVXZxQmgxTi96UUcyMWJ0Zk5FOHhDaVM0SitUa3lIVno4?=
 =?utf-8?B?ZFBOUkRpL3JkUlRaelZhQ3A3OEhJelJEZjI2SXZzYmduZjNLcUJLSUdJLzZV?=
 =?utf-8?B?aFR6d0RveGdpelM3ZW56OGhLTE5ZZHdLUXAxWGZJOUs3TmhzTEtTaTl0QXNG?=
 =?utf-8?B?STdxbXFKSDg3MGU5REVtV0QvdHlDQXhkTjdKS3YxbTdCRHpxRzRXend1Nkdt?=
 =?utf-8?B?SC9nd2hJSlQ2Z0ViYVcxTGYyWC90RlRIVzAySENpOGd3aHQzb24waFJZcUpM?=
 =?utf-8?B?elhOSThzK0Uxc1N2MS8vcEtwZFhpQ0xpUCt4Ukk0OHkxRjF2UnE1VXVyZHBm?=
 =?utf-8?B?VDdjVEkxbEUrQmRtcGpNczNva2V0UGdtNDdYdFY2RDNTaWFIYmc2ZDJibFhv?=
 =?utf-8?B?bVdiaHAxQUdGNzlwL25iY3FiVlE2ZXVicG5pWE9MWmcwbEgvRU04MWJSczJi?=
 =?utf-8?B?SGhYOGNDSDZmeXBNSzNITzBJc2pJMjk2SEtuQWN1a2lKSDh1QXRIV3BXU3JV?=
 =?utf-8?B?bUNnMWR5a2JWQ1Y0TXJucGVnSFE3TFFKZGFkSW5OK29UOTA2S0tOLzRvZkpw?=
 =?utf-8?B?LzYrc2tJV2lJS3ZXNTBld2Q5aFRTTlhjNlQzOXJ3cU1BVkozci90Q1NvZ0cx?=
 =?utf-8?B?UlBOb0FnYUNacmtjR1puNnprWkNjSzhKNVhad0JmSjExWUttNFZ6a3Vqb1hV?=
 =?utf-8?B?NnlxMFppSHJVL3diVFA2Wkh0L3JSelVTRTBUSTRrRVlpelhGZWFnMVQ5UGhO?=
 =?utf-8?B?dUpXditqUFd0VHZLa2ExUmFuVmN0Sm4wTnVYN3FiVldLV0xoOVJBRm1DYlA3?=
 =?utf-8?B?bkJYby9wcmJpdFFkbFJENDFscjhJUVFMUFFTN0diZi8wRndLRTMrSDl1UE1W?=
 =?utf-8?B?OXRyYkdFRFhCMDJxbDgrNTJJMUJWUVVIc1cvQXQ5cnJHQ0lzNHBsYjR3WGJ1?=
 =?utf-8?B?Mm5DaXdybHZRdyszS1B5NUN6OEowdFNsUEhCbXhWZUYrV21rYVpoaFBqRDcz?=
 =?utf-8?B?QUM1L01pcE1DSDFScy9LR3k3L3FCMS9Lc0IrclRGVmtWbVJOSXloWFo4T2ky?=
 =?utf-8?B?WDBJekt2RlVpVmRqdzBLUTJ1RkVkU1kydFBwclpQR2hxeUp0L3RRMm1BQWZk?=
 =?utf-8?B?QlpIYjF0VXJrcmJkQ0d0WEE1R2NUdm95QVk3UFdXYitCOWRXU0JKOXBIdVgv?=
 =?utf-8?B?eE1XTUgrSW1CbHpGUXg5cldZd3d4TElXb1FsYU53K0ZLK1NHSkx2N1M3RjNm?=
 =?utf-8?B?RXF5KzdxNDllbmp1dXJ4ZlBSZy9QdDNqcWtJTlBobU54NUVzQ0dkVUR3Z2Vx?=
 =?utf-8?B?bHdjNXl3elp2TytOVENVZlF6QU5ibGExZmxOU0dTRFJ4OFU4clRIWi91eWVz?=
 =?utf-8?B?Ym4ybmFoQmdCc2VNS0N3MjVuYUNCQ0N5RUEzY0dHRkhDVGxXVmlJMlgvT1dl?=
 =?utf-8?B?TDdpN281cThyUlNsZ2cyTGNaS3dVclR3L21PZ2NFRFFWUmYvL0hqaDJITGtn?=
 =?utf-8?B?OU8xYm9GT3hTRkZIRHVkVmM0emw2b093V21UUG52MzQraVVlZ2V5MWU4elhq?=
 =?utf-8?B?T2pISzZ4TVdjM3pUV2JkaERCK2htQk0wL1A4NFZEbHVQa2FPK083ampuUFlN?=
 =?utf-8?B?UHpDQjFEOGsrK1RDT0JEellGNDJuTHdEUWhZa1dQYWIrWUoyMXlrMWQySTZ0?=
 =?utf-8?B?ZjlJWmRwN2dyY0hiaEtlOTFRakdDVDRkakRDaDFmZzBOVHNWdHV0NmhIU2ZK?=
 =?utf-8?B?b0ZmRkhYWktrTWZxdU9sTURjM09uaDRQeWhUcS8ySXFSWWdEV0c0TXAxWDJx?=
 =?utf-8?Q?CSFV6bbuuz5gH8+B54oTe0o0E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02953190-6f4f-46ce-49fe-08dc80f9c5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 22:42:23.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExQXGwZYn6h3yeGGQbg3uXycP4Ij3/R0YkH8F/gacQXYhsw7g76aLR95dSdjzqquG1Mklk4dmS4tjGNWwTqrPNt+lpsHe6ToqDsC/wuANnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8492

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldF0gbmV0OiBwaHk6IE1pY3JlbCBLU1o4MDYxOiBmaXgg
ZXJyYXRhIHNvbHV0aW9uIG5vdCB0YWtpbmcgZWZmZWN0DQo+IHByb2JsZW0NCj4gDQo+IE9uIFR1
ZSwgMjAyNC0wNS0yOCBhdCAxNDozNyAtMDcwMCwgVHJpc3RyYW0uSGFAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBUcmlzdHJhbSBIYSA8dHJpc3RyYW0uaGFAbWljcm9jaGlwLmNvbT4N
Cj4gPg0KPiA+IEtTWjgwNjEgbmVlZHMgdG8gd3JpdGUgdG8gYSBNTUQgcmVnaXN0ZXIgYXQgZHJp
dmVyIGluaXRpYWxpemF0aW9uIHRvIGZpeA0KPiA+IGFuIGVycmF0YS4gIFRoaXMgd29ya2VkIGlu
IDQuMTQga2VybmVsIGJ1dCBub3QgaW4gbmV3ZXIga2VybmVscy4gIFRoZQ0KPiA+IGlzc3VlIGlz
IHRoZSBtYWluIHBoeWxpYiBjb2RlIG5vIGxvbmdlciByZXNldHMgUEhZIGF0IHRoZSB2ZXJ5IGJl
Z2lubmluZy4NCj4gPiBDYWxsaW5nIHBoeSByZXN1bWluZyBjb2RlIGxhdGVyIHdpbGwgcmVzZXQg
dGhlIGNoaXAgaWYgaXQgaXMgYWxyZWFkeQ0KPiA+IHBvd2VyZWQgZG93biBhdCB0aGUgYmVnaW5u
aW5nLiAgVGhpcyB3aXBlcyBvdXQgdGhlIE1NRCByZWdpc3RlciB3cml0ZS4NCj4gPiBTb2x1dGlv
biBpcyB0byBpbXBsZW1lbnQgYSBwaHkgcmVzdW1lIGZ1bmN0aW9uIGZvciBLU1o4MDYxIHRvIHRh
a2UgY2FyZQ0KPiA+IG9mIHRoaXMgcHJvYmxlbS4NCj4gPg0KPiA+IEZpeGVzOiAyMzJiYTNhNTFj
YzIgKCJuZXQ6IHBoeTogTWljcmVsIEtTWjgwNjE6IGxpbmsgZmFpbHVyZSBhZnRlciBjYWJsZSBj
b25uZWN0IikNCj4gDQo+IEFzIHRoZSBibGFtZWQgY29tbWl0IGJlbG9uZ3MgdG8gNS4wIGFuZCB0
aGUgY2hhbmdlbG9nIGhpbnRzIGFueXRoaW5nDQo+IGFmdGVyIDQuMTQgaXMgYnJva2VuLCBpdCBs
b29rcyBsaWtlIHRoZXJlIGlzIGFuIGluY29uc2lzdGVuY3kuIFBsZWFzZQ0KPiBmaXggdGhlIGNo
YW5nZWxvZyBvciB0aGUgdGFnLg0KDQpBIGN1c3RvbWVyIHJlcG9ydGVkIHRoaXMgcHJvYmxlbSBh
bmQgc2FpZCB0aGV5IHdlcmUgdXNpbmcgNC4xNCBhbmQgY2l0ZWQNCnRoaXMgY29tbWl0LCBzbyBJ
IGFzc3VtZWQgaXQgd2FzIGFkZGVkIGluIHRoYXQga2VybmVsLiAgSW5kZWVkIDQuMTkNCmtlcm5l
bCBoYXMgdGhpcyBjb2RlLCBzbyBpdCB3YXMgcHJvYmFibHkgYmFja3BvcnRlZC4NCg0KSSB3aWxs
IHVwZGF0ZSB0aGUgY29tbWVudC4NCg0K

