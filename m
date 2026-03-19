Return-Path: <netdev+bounces-269256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PuyEy9Tu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:36:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E822C488F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 331FC3012D04
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E763321AA;
	Thu, 19 Mar 2026 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e46VrEKK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V2CSJdVR"
X-Original-To: netdev@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBC9330675;
	Thu, 19 Mar 2026 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884173; cv=fail; b=o99ypAL5/uVD4XSNkr+9/OsiLJOep7bkuw9Rf8F11WyrfcH4E6bEVvmirWJIyJqdKlfJuOVQwhj7Dsv7sg5x4GJfr9E3VuX/+qtOY/Rc+rVVHR2a4LDJIJBSeX4OEvHA9yd4c7F5dWAp/BHqNsaLv6BppYk4taj5PtKZH12Kem4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884173; c=relaxed/simple;
	bh=3BQox9q5RqFzxTmNitGTEyHXgt2Q/vv7DLbYeM94s/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJj69SKNMhpU7OMQrSrYyp8uLPEK+ijXFdfjze6Iq1TXkf64h1dtprzBU6XXgeNO5W0COQsxAGlOKL9w5SGRANi+T+yTr6jsRHOng0PAA5U49rfSPKkv75E2agcFI7Waqm6WNFTeTX1Ed07oNNrbqdy8vnQM4aWnlabgXNUkKrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e46VrEKK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=V2CSJdVR; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773884166; x=1805420166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3BQox9q5RqFzxTmNitGTEyHXgt2Q/vv7DLbYeM94s/U=;
  b=e46VrEKKazHt/XvYBrskdbofBV6LKDWppN7rsYL4NOBIhLz1EO9UQ3L5
   iI58P3SnJW6tZF+cxBsrgz2P5YVwDb3mOJCMLaFvwprY2anAC5w71i2GR
   YIKvoPEp+SoNbv9BXs2GvCAC+uCLg1ralt7vaNhkE0mTP+Ojs6TjADHUI
   frzlUer0GweZFj4IHP2+SM4JCeyp1S1OgCpVcebwba2mfirzqonp+UH32
   NJSCi7joQpcGv49ZbmQo6NUTlQV6Sz2xQt+hxruh5FM7SDgA3VYVU5pCu
   nPlfB90mfjRe1aZ9F0tjLvMTZV/w1mZP6jxeWj+31hvlx+YtWsGz38nJu
   w==;
X-CSE-ConnectionGUID: L/FVge3FTtGX9WaXNhDhHQ==
X-CSE-MsgGUID: 3ksH8o+PQUi8K4CE2O5sgg==
X-IronPort-AV: E=Sophos;i="6.23,128,1770566400"; 
   d="scan'208";a="143326784"
Received: from mail-westusazon11012027.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2026 09:35:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFz92zwST5Vd9+M2X5fIkr6uYXmpE50m7U1fp38NGhTI3DbNThHi3bYu5lfmBbMhehzoldDTTJhRhlSOHrRZS9tIM1rzC3iOnud1XOm9lcyZf87GziCCM7f0rg5CDV5DpQGZyIj8eVdaCJjOB0TShXG9vzAXb5f/qGDcH3hGSExL94bx6NxsA2Ht5ev/L776USLZ4HkPZilXG+gIf/IT/R9bVwHgvEmw15viIa8KXBDk8bL5S4QFy/LPbr13qauTaDlE/EPKOXE7PnADvsnnwtHLEJulCBhgMIcgIP5RtlI8HvVn3FGqs4bULsWK2oEmiLve19tPuMt1wWI1UDDA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BQox9q5RqFzxTmNitGTEyHXgt2Q/vv7DLbYeM94s/U=;
 b=Dp7wH/ohrxE29QIcoPN/AgUS3Vw0kOSFsnprD+WkHn1cthTU3w0wFXN/zdfSpusW49q7llRdDITTPFBsu1wYShGv/rCeyWTabs0UprZyEhVJRr+uTjjrQ8y58AGrpIbLJpyB/WZ4gsUfBJpNwHtpi2yzB5sv6YwosAWaqjb2kcUHMaiiQlQFwBBOcM68DDIg+vhFCTJ0QcDWEsw50IcW82vQVvFa6DicVPOq9VzvK8zL1o82On0RoGE1aJQMJdsXqeT5M4AS6pwVF3IjaMBLtaezzdl2Umdz++lqNmrNPEEkD8psduBY5zAxOma3BwGDTqsni54NSZbQ9Z9kVOXEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BQox9q5RqFzxTmNitGTEyHXgt2Q/vv7DLbYeM94s/U=;
 b=V2CSJdVRlIDLP+QnrjUk6Xi6vwYpmrAjbYfOVYM7t8UkjiKo6dXdhc0fprm3RdK8aNJRHzVFZZDn35GMRO8qdohuXdiIKPHnaVtYYNjhNOqpzLeFwpRKuJveXu8B8JHtlPQeEcuuHwN2fh7bw+xk/LYUyHQR4wquke6mxq7QCTk=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by DS0PR04MB9795.namprd04.prod.outlook.com (2603:10b6:8:2f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 01:35:56 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 01:35:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Topic: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Index:
 AQHcr4k7Tes8SpBSDEK9sLJLHZqM/bWseAsAgAGpkICAA9AogIAAAwWAgAAE1ACAAAKRgIAABoYAgAMfr4A=
Date: Thu, 19 Mar 2026 01:35:56 +0000
Message-ID: <49513ee4347536e7c8419e9e65b8c619a8c665bb.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
			<20260309054837.2299732-3-wilfred.opensource@gmail.com>
			<abQOGm6BqAE5eEln@krikkit>	<20260314073919.2f92b966@kernel.org>
			<9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
			<20260316180355.37d45785@kernel.org>
			<8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
		 <20260316183023.2fb38d84@kernel.org>
	 <64cb821cc09226155059807cb0bcdbc51ae8d0d6.camel@wdc.com>
In-Reply-To: <64cb821cc09226155059807cb0bcdbc51ae8d0d6.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|DS0PR04MB9795:EE_
x-ms-office365-filtering-correlation-id: 74ed39f6-6e3c-47aa-3ea6-08de8557de08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 lp+VglIKQfAfNCI2Q2AmqmMKdQKvRZBPDk3Iw+EdXBCIIUcH87YkZCedglZN+UapEt/6wJT0MDyGQEeLem5LE6npb8sSx8E5ZAN5iUkvS5cZm64PwV5B6iyB8vTmfhCfAhSkqZXB6SEb1GtgExP5u9xcrveA9XnWB9RH7d8PBfnLZYO2Jymdg30f4S2Aqy3w2fzll/tlYt5lVKSJFFnezQMhKJp+PcvBgd8GIRFNpbgESbhxmPjdJj5glIFZAClGLnkFYnnWKgf2M8p/iMNWd3WyaENia+jm5mB8GdXFjdSqCUQUuCGproNNQ8Oc7QCda1aGExt6iSJ55Pqw/c4M28fMcaOkQmA1no6MhwUsZFXvgphjgufqaViSGuoMiqR4UknGk1sSUdGyYVj3d8sKWIBuT8okwqV+3AmE8y+Pmi9PFqBVlYPr613uFWF0U6nGLiMCrr1P17RgKwLhgKs2CMhsQ4p13J+WeNYUo0UxandLOLHmF+UoUAZdOyZbpp4kqBZlqd+611pWO5UwQrGBriDDmg8Ux+E32f6XTlZCV6o5xTBkSnLxPjzpbvS98ttRz7A/v+rRc+TqD+1aruEaOJIkVwxQFMOwJI9kstLR4ZvnY0ag0KiJ8KJkF6K0cYNPDGVpk6WVRS347rH+nFB+LBDUQe468TFyETowTM7xbceJ8V5r+CeNOwQtRfugOT0lTxrw5WaH9zW0qMn/wPf45kFSS8CC8urj+h5Xrf5Faj4DHZ0rMQyNqji5VRIFWHda
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB9849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHlXVytDNnYxemhqbURHT09RTTI1Vk9jb1BZT2pxNEtDS0o0MHF5L2FscVlx?=
 =?utf-8?B?UjlHNlFpUGNxMzllSUdubEtmczdxNmhtdWNsYVBCMUJ3WXY3cXU0VTI0TUFV?=
 =?utf-8?B?dGt4S3UwNVh6VjJzRFB2cmxYYWJ4UVMrelhRZTBPSkF2aklKOGF1YzVpUGxx?=
 =?utf-8?B?aHpYelEvVzhwQ3RvUE5RWU1TRVN4MHBvY2tmcDhKRU5tbW81SzlsdGRkTXlp?=
 =?utf-8?B?ZDVrTzJhWmVmMHV1cDhrUkxXTEF3M2cyL1F4MnpsVEE3QjVUK1FZeFgwdU05?=
 =?utf-8?B?UHlNajAzVmZYQUJJY0F3VDY3akk2OGs4N0o4Nlc5YW9nODhxek1IZktmYzBR?=
 =?utf-8?B?ZWJSUmNJaUo3bCtEdWIwOXc2V1QwZkNPc0NIQStIdXMyODdMR0pRSStqSnFF?=
 =?utf-8?B?SkFOZVdLOEdhNW83dGtnaGJiQUNPNVhCaDNOZmNQd1RFWHYzQlRoZFlQbFBX?=
 =?utf-8?B?Z3huRFpEaXRIa0hFR3BMT2V6MmxaalBLYTkwYTZJcWlOUW1sMG9KTHdMcFJ0?=
 =?utf-8?B?bFQ2Y241bzRld0wwWEp3OVZqUGJMcDE5NFAyaXloUjNPb1YwL2RkVEtYTnNN?=
 =?utf-8?B?MHRCVUl3U2Y1MmFvVkdaQkNqZlRSUk14dnRXZFdubm1OUXdaVnNtSUo0eXFS?=
 =?utf-8?B?OEJTbWVEZWlWWVpSckNYMXZvM1JMWkhWc1p0MWh6dTVJR3dUVVdQOURzVDY3?=
 =?utf-8?B?Zkk1ZVNmdU5lUkVWeTFsbXprdE52R1dpaTNpUmVRdGllY21GaGJweWEzcnk5?=
 =?utf-8?B?RURVbG8vUGJadUsrV3h1a251YnZGdmVUVzdFQ0k0MnVXVnB4NWVVdktpY1VI?=
 =?utf-8?B?NnlMendMRzdnSDdZc0pyVUwwclVqRExRUTlmRXJ6ckRtdHdtWlNCeTIvUVNS?=
 =?utf-8?B?MExVMThzS05Mbi8xYnI3V2syWU5ieGEvbFpmSUYzWG9Cd0YyTTkzOW9pNGJD?=
 =?utf-8?B?YnFBNXNWRXFTamhYczBvZW4wVmE0SGg4d2laK3M5WE1yaHlyRzRhR1Z0ZWxD?=
 =?utf-8?B?TnpFNkV4U3ZWbVh3cUE4ekJyakR6aEpFUFZoVkhXdzlKSE5TVjJBSDR1d0xJ?=
 =?utf-8?B?TFhvN3RBRjZFV0YvdjNpbktMMTRaWlBtOE9rdnBSRFRZK0JXbkFvaHNja1FR?=
 =?utf-8?B?YTBDNXVMZ3c4SStzRWRGSUdua3R6UkdzeXhabHhkaERXUzlxVDlYWkJ6TjNm?=
 =?utf-8?B?TStuamR5Qlo3U3grWklBVVZxNGFUTXhmdUdSdjB6Tms4UHFNTjg4UHlyVS9O?=
 =?utf-8?B?UExhODc5VnJESG9aUFppOHRBNXBwVy8wVkJSTndYRlV1WERNcXgvM0Z1ano1?=
 =?utf-8?B?cTVWS3Q2L3FXbUJSQVo1L0dhUUNEeitBazA1VlVJZmRLdmRWdnRPbEJpY2I3?=
 =?utf-8?B?ZGoveE5pMWNTMGVRQkZxMFMwcnRaNDIwTXVOL1VBZjhLbmw2cHZBYkx5cmtC?=
 =?utf-8?B?RlBRa0pzTkNsS1JlNHlaNzNiTmtHeStIK255WmlabDVQQnhyWHBEK1VjWHlD?=
 =?utf-8?B?NitGRndWK29UejFFNDNWZzNQTG16azBER2RYOTdMYllIR2FlL0FlYU5VZFpE?=
 =?utf-8?B?OHJybEZhRWQwdkhDbG9SZnhJY0UvdCtKOE0rd1ptbzlwR2JtVHMrTEhyRjdT?=
 =?utf-8?B?N014OERwRm9HNDgxMVdKUGNJOElINnJsQmhPNUpneW5jc29qeExCejhWeXcx?=
 =?utf-8?B?YkhYVjg1djR2UlFXQ2FIUitEcVZ4SFdKM3hNMU43NnR5OE9uS1RWTy9oL1NZ?=
 =?utf-8?B?NG8yYVN1NE1MTS9uRVFzdzNUa0hMM1U2T3E3UURZQy9qSGhyQnVMb2tYRTBi?=
 =?utf-8?B?NmZQRk5JWlA5bmdBdDJ3VzFIZ1dRa01ISDBtaldQVytHTFc1NHRELzM1bjNY?=
 =?utf-8?B?QjBEdHVCZFQ2ckJlNVNIbWU3dnZycU1iWmZjdnZFOUxhK1FmNXRWWWlXajBk?=
 =?utf-8?B?UjNEWTRrTVBRWkhpUXM3bkpZb3BWVGI2MzdwZkcxdit3c3BtcXpRM250bU1a?=
 =?utf-8?B?WjJNVkd1RG1Ba3ViU3BDaHUrcTZMbk1jMU1GQ3BtdmFhM1N2RUFlWE14TGdy?=
 =?utf-8?B?TjBiRjlKZ1FTblRuaDRoY1lNbyswVFFlN1h6NHVSNzd0Q0w5TkVtMGpZSG8v?=
 =?utf-8?B?MXJTYzBjQ25nR2ZlTFJ3anN1TEVEbUs3aW5WUjVYVkNwUCsxbmFoMnphbE1n?=
 =?utf-8?B?a21PdDJpTktuNzN6NzB6RmVYa0JVT0FWSjFZTzVjaHN3ZlN0eFc3NVdndFZ6?=
 =?utf-8?B?OWh4akh0ay9zTmw3K2dYbWlGczZkNWU4bmVOSlNxLzFTaVpFNEZzMzRiaDBE?=
 =?utf-8?B?dlJIb2RIMEI4Sk9Gc2JuTlkxL0ZXamhCNjNHWXByaUMxU29sK1o3aFhIRkt3?=
 =?utf-8?Q?7b9i0+gGY4a2JDLCxOsxuHa5JLh770eQ5k5NDQ8aIqtRj?=
x-ms-exchange-antispam-messagedata-1: ZVi/Z2OifLOjLfVF7hCOVtg4lH4c+/Or4Rk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DDA70A303F6194EBD3C8ECC4E060EA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jp5EoeYJbpZSV6wqfVFejTNLtiZOg1fi8xPfGtbkMwdmMKtFZaZPTY84rnjJMO/L4vCjyDvJANRZbe8mSQy/e/8cggqVOf/PMM6ZAYrYzyj9JdaZ4p9dYpDf+i4qvU4OAwloGYafdxV5Dq+08+hd7kgMuFoMzM6tmcIGpKzeuP6ttnjpniFK5T2+qKbdiiWVQ15xrcfhf3rRCIy8iiZoFKjwR8OpyAeSRi92fCmOgxiPqzX0m+UJhEDhsDnxxtWTDncU/gYIVCT1fHPWqA0KkD6+9MJr0/ECMidctCsR/BzC3Tf+2bXTq+R8/vlj7M5bYzRQ3kIjCBacyx8kvLo88A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mf2iyC5m/mlE6TVsgBNf45O1xQWKAjkGumnawos27AaePMqbW8Y9KuBVpYEflCBc2r0T97h2W91LQ07Zd8KGrs4W6m+C0g7KfKCojBhoXxisbecpVjMtoU9IEsnoLRG7dz+n2OfncW3u/R3B7kcTw0cYzSNiB0GRlCRGEdeahcNbzcv3cwxPdiVlzzgRB9K8wlkagaZ9QQLjf5TFp3ChlQZXSmkGuyXBCBG3t4wZW99wahowtS1RMKo1eKsehTbakM6Ya3v5b70Ojrmg2a35IaAiDeRy53x0ucLOQQnl6jeOEL+a6B029nO4GXilPZBnPFIPcKFWW3Iehm4rLS2JgpeqFk6Ub2+587q9iMwFwQ81nk8D30FKq+b6QSAvTTzw776pX0vEMqMqXuZWfkINdoUMPCYd0i0AKE/dD1peXcXQMuNDpzBa+0yfDrsLGFG8j1JEVjQB03oc/kbF0gZIZt7v79C/3IPljVwlzw9AuVNmKChhved92E56q3VjW7gRi4sX2ciBXcQ2qXA7ynofOlXZDaCYdpBbEpOUYrNUgdR0Rljlw3dmm7+2vedkknShXgwrjEfis5MoZLrJyyp6/EzPyJzvEBKOpZSuDamiZz+qpW17RIsex6XscP/g7AP4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed39f6-6e3c-47aa-3ea6-08de8557de08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 01:35:56.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YKAn67+lq0XtzUTksgPGnJEV9HxyGMckJW1JnhUaHbHCly12JRICJOC34batFm2ErR4RKVkaHd2vTVX0Z0Fkp16b7zTpr3WbBK9rn+IW1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9795
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269256-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,redhat.com,linuxfoundation.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Alistair.Francis@wdc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: E0E822C488F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDAxOjUzICswMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNi0wMy0xNiBhdCAxODozMCAtMDcwMCwgSmFrdWIgS2ljaW5za2kgd3Jv
dGU6DQo+ID4gT24gVHVlLCAxNyBNYXIgMjAyNiAwMToyMToxMiArMDAwMCBXaWxmcmVkIE1hbGxh
d2Egd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjYtMDMtMTYgYXQgMTg6MDMgLTA3MDAsIEpha3Vi
IEtpY2luc2tpIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDE3IE1hciAyMDI2IDAwOjUzOjA3ICsw
MDAwIFdpbGZyZWQgTWFsbGF3YSB3cm90ZTrCoCANCj4gPiA+IMKgWy4uLl3CoCANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBGb3IgdXBjb21pbmcgV0QgaGFyZHdhcmUsIHdlIHdlcmUgcGxhbm5pbmcg
b24gaW5mb3JtaW5nIHVzZXJzDQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiB1c2UNCj4gPiA+ID4g
PiB0aGlzIGZlYXR1cmUgaWYgYW4gZXh0cmEgbGF5ZXIgb2Ygc2VjdXJpdHkgY2FuIGJlbmVmaXQg
dGhlaXINCj4gPiA+ID4gPiBwYXJ0aWN1bGFyDQo+ID4gPiA+ID4gY29uZmlndXJhdGlvbi4gQnV0
IHRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uLCBJIHRoaW5rIHRoaXMNCj4gPiA+ID4gPiBmYWxscw0K
PiA+ID4gPiA+IG1vcmUNCj4gPiA+ID4gPiBpbnRvIHRoZSAiY2hlY2tpbmcgYSBib3giLi4uDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIGhhcHB5IHRvIGRyb3AgdGhpcyBzZXJpZXMgaWYgdGhl
cmUncyBub3QgbXVjaCBhZGRlZCB2YWx1ZQ0KPiA+ID4gPiA+IGZyb20NCj4gPiA+ID4gPiBoYXZp
bmcgdGhpcyBhcyBhbiBhdmFpbGFibGUgb3B0aW9uIGZvciB1c2Vycy7CoCANCj4gPiA+ID4gDQo+
ID4gPiA+IEknbSBub3QgbXVjaCBvZiBhIHNlY3VyaXR5IHBlcnNvbiwgYW5kIG1heWJlIFNhYnJp
bmEgd2lsbA0KPiA+ID4gPiBkaXNhZ3JlZQ0KPiA+ID4gPiBidXQgSSBmZWVsIGxpa2UgaXQncyBn
b2luZyB0byBiZSBoYXJkIGZvciB1cyB0byBkZXNpZ24gdGhpcw0KPiA+ID4gPiBmZWF0dXJlDQo+
ID4gPiA+IGluIGEgc2Vuc2libGUgd2F5IGlmIHdlIGRvbid0IGtub3cgYXQgbGVhc3Qgb25lIHBv
dGVudGlhbA0KPiA+ID4gPiBhdHRhY2sNCj4gPiA+ID4gOlPCoCANCj4gPiA+IA0KPiA+ID4gVHJh
ZmZpYyBhbmFseXNpcyBpcyB0aGUgYXR0YWNrIHZlY3RvciB3ZSBhcmUgdHJ5aW5nIHRvIG1pdGln
YXRlDQo+ID4gPiBhZ2FpbnN0DQo+ID4gPiB3aXRoIHplcm8gcGFkZGluZywgd2hpY2ggVExTIGlz
IHN1c2NlcHRpYmxlIHRvIFsxXS4gSSB0aGluayB0aGUNCj4gPiA+IGhhcmQNCj4gPiA+IHBhcnQg
aXMgZGVjaWRpbmcgdGhlIHBhZGRpbmcgcG9saWN5IGFuZCBiYWxhbmNpbmcgaXQgc3VjaCB0aGF0
IHdlDQo+ID4gPiBoYXZlDQo+ID4gPiBzZW5zaWJsZSBwZXJmb3JtYW5jZS4NCj4gPiA+IA0KPiA+
ID4gVGhpcyBzZXJpZXMgYWRkcyByYW5kb20gcGFkZGluZyB0byByZWNvcmRzIHdpdGggcm9vbSwg
YSBzdHJvbmdlcg0KPiA+ID4gcG9saWN5DQo+ID4gPiBJIHRoaW5rIHdvdWxkIGJlIHRvIHBhZCBh
bGwgcmVjb3JkcyB0byBtYXggcmVjb3JkIHNpemUgbGVuZ3RoLg0KPiA+ID4gQnV0DQo+ID4gPiB0
aGF0DQo+ID4gPiBhZGRzIGEgbXVjaCBoaWdoZXIgcGVyZm9ybWFuY2Ugb3ZlcmhlYWQuIEZvciBj
b250ZXh0LCB3aGVuDQo+ID4gPiB0ZXN0aW5nDQo+ID4gPiBOVk1lDQo+ID4gPiBUQ1ArVExTIHdp
dGggNEsgd3JpdGVzIHdpdGggYSByZWNvcmQgc2l6ZSBsaW1pdCBvZiA0aywgd2UNCj4gPiA+IG9i
c2VydmVkDQo+ID4gPiBhDQo+ID4gPiA1MCUgcmVkdWN0aW9uIGluIElPUHMgb24gdGhlIGZpeGVk
IG1heCByZWNvcmQgcGFkIHBvbGljeSBhcw0KPiA+ID4gb3Bwb3NlZA0KPiA+ID4gdG8NCj4gPiA+
IHRoZSByYW5kb20gcGFkZGluZyBwb2xpY3kgZnJvbSB0aGlzIHNlcmllcy4NCj4gPiANCj4gPiBT
b3JyeSwgSSByZWFsaXplZCB3aGVuIGkgaGl0ICJzZW5kIiB0aGF0IEkgcGhyYXNlZCBteSBwcmV2
aW91cw0KPiA+IG1lc3NhZ2UNCj4gPiBwb29ybHkuIFdoZW4gSSBzYXkgInBvdGVudGlhbCIgSSBt
ZWFuIHNvbWVvbmUgYWN0dWFsbHkgcHJlc2VudGluZyBhDQo+ID4gUG9DDQo+ID4gYW5kIGEgQ1ZF
IGlzIGlzc3VlZCBmb3IgaXQuIEhhdmUgd2Ugc2VlbiBhbnkgb2YgdGhvc2U/DQoNCkluIDIwMTQg
YSBncm91cCBhdCBVQyBCZXJrZWxleSB1c2VkIEhUVFBTIHRyYWZmaWMgYW5hbHlzaXMgdG8gaWRl
bnRpZnk6DQoNCiJpbmRpdmlkdWFsIHBhZ2VzIGluIHRoZSBzYW1lIHdlYi1zaXRlIHdpdGggOTAl
IGFjY3VyYWN5LCBleHBvc2luZw0KcGVyc29uYWwgZGV0YWlscyBpbmNsdWRpbmcgbWVkaWNhbCBj
b25kaXRpb25zLCBmaW5hbmNpYWwgYW5kIGxlZ2FsDQphZmZhaXJzIGFuZCBzZXh1YWwgb3JpZW50
YXRpb24uIg0KDQpUaGV5IHVzZWQgbWFjaGluZSBsZWFybmluZyB0byBoZWxwIGFuZCB0aGF0IHdh
cyBvdmVyIDEwIHllYXJzIGFnby4gU28gSQ0Kc3VzcGVjdCBtb2Rlcm4gZGF5IG1hY2hpbmUgbGVh
cm5pbmcgd291bGQgbWFrZSB0aGlzIGV2ZW4gZWFzaWVyIHRvIGRvDQp0b2RheS4NCg0KT2J2aW91
c2x5IHRoYXQgaXMgSFRUUCB0cmFmZmljLCB3aGljaCBpcyBkaWZmZXJlbnQgdG8gdGhlIE5WTWUt
VENQDQp0cmFmZmljIHRoaXMgc2VyaWVzIGlzIHRhcmdldGluZywgYnV0IGl0IGRvZXMgc3RpbGwg
c2VlbSBsaWtlIGEgcmVhbA0KY29uY2Vybi4NCg0KVGhleSB0YWxrIGFib3V0IGEgcmFuZ2Ugb2Yg
ZGVmZW5jZXMgaW4gdGhlIHBhcGVyLCB3aXRoIHRyYWRlb2Zmcw0KYmV0d2VlbiBhbGwgb2YgdGhl
bS4gQnV0IHRoZSBsaW5lYXIgZGVmZW5jZSBzZWVtcyBsaWtlIHRoZSBvbmUgdGhhdCBpcw0KYXBw
bGljYWJsZSBoZXJlOg0KDQoibGluZWFyIGRlZmVuc2UgcGFkcyBhbGwgcGFja2V0IHNpemVzIHVw
IHRvIG11bHRpcGxlcyBvZiAxMjgiDQoNClRoZSBsaW5lYXIgZGVmZW5jZSBzZWVtcyB0byByZWR1
Y2UgdGhlIFBhbiBhdHRhY2sgZnJvbSA2MCUgdG8gYXJvdW5kDQoyNSUgYW5kIHRoZSBCb0cgYXR0
YWNrIGZyb20gOTAlIHRvIGFyb3VuZCA2MCUuDQoNCk9uIHRvcCBvZiB0aGF0IHRoZQ0KDQoiQnVy
c3QgZGVmZW5zZSBvZmZlcnMgZ3JlYXRlciBwcm90ZWN0aW9uLCBvcGVyYXRpbmcgYmV0d2VlbiB0
aGUgVENQDQpsYXllciBhbmQgYXBwbGljYXRpb24gbGF5ZXIgdG8gcGFkIGNvbnRpZ3VvdXMgYnVy
c3RzIG9mIHRyYWZmaWMgdXAgdG8gDQpwcmVkZWZpbmVkIHRocmVzaG9sZHMgdW5pcXVlbHkgZGV0
ZXJtaW5lZCBmb3IgZWFjaCB3ZWJzaXRlIg0KDQpXaGljaCB0byBtZSBzb3VuZHMgbGlrZSB0aGUg
cmFuZG9tIHBhZGRpbmcgcHJvcG9zZWQgaW4gdGhpcyBzZXJpZXMNCndvdWxkIHByb3ZpZGUgbW9y
ZSBwcm90ZWN0aW9uIHRoZW4gdGhlIGJhc2ljIGxpbmVhciBwYWRkaW5nIHVzZWQgaW4gdGhlDQpw
YXBlci4NCg0KVG8gbWUgYW5hbHlzaW5nIFRMUyB0cmFmZmljIGRvZXMgc2VlbSBsaWtlIGEgcGxh
dXNpYmxlIHRocmVhdCBhbmQNCnNvbWV0aGluZyB0aGF0IHJhbmRvbWlzZWQgcGFkZGluZyB3b3Vs
ZCBoZWxwIHdpdGguIExlYXZpbmcgaXQgdXAgdG8NCnVzZXJzcGFjZSB0byBkZWNpZGUgYmFzZWQg
b24gdGhlaXIgdGhyZWF0IG1vZGVsIHNlZW1zIGxpa2UgYSBnb29kDQphcHByb2FjaCBhcyB3ZWxs
Lg0KDQoxOiBodHRwczovL3NlY21sLmNzLmJlcmtlbGV5LmVkdS9wZXRzMjAxNC8NCg0KQWxpc3Rh
aXINCg0KPiANCj4gQWggcmlnaHQsIEkgaGF2ZW4ndCBzZWVuIGFueSBQb0MvQ1ZFcyB3aGljaCBj
b3VsZCBkaXJlY3RseSBiZQ0KPiBhZGRyZXNzZWQNCj4gYnkgemVybyBwYWRkaW5nLg0KPiANCj4g
V2lsZnJlZA0K

