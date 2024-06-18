Return-Path: <netdev+bounces-104579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E930F90D739
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67311B3708B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650A763E7;
	Tue, 18 Jun 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TpG7FmpJ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nif6FqSt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF173176;
	Tue, 18 Jun 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722622; cv=fail; b=AOrIPR/bNm8oq81wfJzpX+xq4x/HH2SpZ2Qd1ipuK8AI+aqieIH2NXGIXd5fYnz6P3HUiZqh98tifO4+Mal9+iwJ+CV7XUgOTOHCAhAts63BddqInfTcgEa//h00B35t9X1kmMPmksrQKcuAPJCm88izzPgu9t9iJxqLe87AJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722622; c=relaxed/simple;
	bh=CXlVB2xIW41HRqnEkp9tfrr1hL6GOishLC3uEtjkSL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GRN/1CsTag9jx5m59n/fGy3JQoTgGes22Csr/mMOSPJCf+qy5t/MA5i7Sqv2bTWnh5V5o8YlThRKe4SbNSzdkjxCBnFMEDbpgV7mS/BKTvmd/nu9EFspD0O/z5lp0tTVuQr6B1q15g1eyP+gW9mSB6Fj4ZuvxVeJ0iVA5iJ8oNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TpG7FmpJ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nif6FqSt; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718722620; x=1750258620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXlVB2xIW41HRqnEkp9tfrr1hL6GOishLC3uEtjkSL0=;
  b=TpG7FmpJuY932dTaZDHg8fDIkDat1JsZ9hn/njk8foOoU6fusFMpWQn8
   t3EQ+aXRjl3QI6fs303UeMW2xSxP70OmopH46fXLCZLjGU76nCPz8ufB+
   ACwRdb62gPOq2hlKBEomv6/R2qvCLUoVTudaA5ljTP8kNfunGPR+K+/o9
   kYtC0R0Nq7Pis1JswQbw2QzoDasJE4g7vS4+EqFjOt9MID6edlIm2y/vb
   M2uDfxwFO2MnE55sKZxK4xI5EUngK/mW2SKHI2PAqmBZbHv+zmiWfrh9q
   UMMIwqvCIMfJ9/id9rZ2sKHxi54wN2lvb7ut0oIvzqbRORAZDMRH60lw9
   Q==;
X-CSE-ConnectionGUID: l8ipxTVvQ9SNXxQQENzpdQ==
X-CSE-MsgGUID: PNwti6ocRWCTaQkwgg5TmA==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="195466114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 07:56:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 07:56:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 18 Jun 2024 07:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs06s/1bJa4yuGXB4vuj+pKKxtd/gRTj60kJ77gtsSoTD8T11FQFILNmRTJUW0SR6kWHfk5iQp8bRLn6riPIxBvdqLKWckFkgGmC3+Ra29QNmPPcIFYeHbWsalLXSbUEZLbg6DDNEp1F674dD5iJKOwWYN9trTYRYYHbgqjZPEill/FbzBlqWHAuf7Jz/r2QmbTsAxnm1Bew+6TFBJ9Y73tIBgp+Ra54IQVZ3l2gjySvS/uD3T3H1HjDd8swtFh9+X2vcgZ3TW2WXBL7HxVuPlgu4xdH3FCPZRfAqMW904DCrRnCecXc/eSiBXLIvqQLAvKK6M7iomjoiWPBZ0gxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5vTc4lzfZP3xB4cuDz805XOmWGXJjtkmvE/PoES/y0=;
 b=fX+tS2KNvucQqp8RTGvWCJhIvTEP+Km7vw5W4m/XoEcBjZTuGS9Lwb2QEI4wCVJx+XW1W/V3NS38g7dI8u2ZKW57FKCpInmmEjwYrebHVvMPo9U/4oDOHMh6y26AhiDMRoC/ry4rVANwo5Paw2oN05FXmaXY85R/FmsZ3Nzc3f7z96wcuE8LL66cDKYAkw47s4fl7d++1+avzK3ahigmq67SdOmc4CKBCE7TpLomUMgnyfOVhERT7l2d7Qdpp0Q818gCKzrLF+7uNZQAzRMXmzMkwBzR8Dzeg3FAtjKbkjL99844Hq8lSw26Ffrx2Dyd5U9Wb/ppQAXBpM4pY/R7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5vTc4lzfZP3xB4cuDz805XOmWGXJjtkmvE/PoES/y0=;
 b=nif6FqStmrtUXxKXZHO0aQE60ybkwrwsWahtSeR5iH7unSatoj0ixE0HUikrVrEpDoxd5Qx9TwCsgp4/E0BeC2ojcQLit3PGflLbcBdsbft5HWcVNJ9S4LyhJg3aNz4v4tw70/WvkJHQ9mbWmOqU3Dvemt4trQT63gfPDzUfiHW0Nbyvlgin62hqq+dTOfqovwg0ub+bYlbGZCZGRE9+QBH2Rm6vuOQpEX+KEz7mLzUjaq710PKnWH9Bl+vhiFxPTKUmYtYvFVWyv8UIY3nvaPWOBshXPBvVPNdz+tG0ENTXuKnV/eB7spA0Ph/mSaMOWDVP5uR87rU29zSwHip0tw==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 14:56:54 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 14:56:53 +0000
From: <Woojung.Huh@microchip.com>
To: <lukma@denx.de>
CC: <dan.carpenter@linaro.org>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<Tristram.Ha@microchip.com>, <bigeasy@linutronix.de>, <horms@kernel.org>,
	<ricardo@marliere.net>, <casper.casan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Thread-Topic: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Thread-Index: AQHawYAhWaz/WFawKEC+9dCImD/657HNh9OAgAACqoCAAAPlAIAABY/wgAAFdYCAAAMckA==
Date: Tue, 18 Jun 2024 14:56:53 +0000
Message-ID: <BL0PR11MB291365D9989339952A0DE533E7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240618130433.1111485-1-lukma@denx.de>
	<339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
	<24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
	<1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
	<BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <20240618164545.14817f7e@wsk>
In-Reply-To: <20240618164545.14817f7e@wsk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CH3PR11MB7675:EE_
x-ms-office365-filtering-correlation-id: b812bd6e-802a-4e17-3a02-08dc8fa6e46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?oLLxkZGEl8HDlfLbUFE1S8QyfpIPjZffVjAhfmuwHJpxXFldQMNnWQC9Laqk?=
 =?us-ascii?Q?DUuFpioZuy8PuB9gWIuFHXv8kWxpDJ55tfIUzJj8HQ3qO0fvBodhs6CjmVVu?=
 =?us-ascii?Q?bomMtJsGVCIL1zlnTG+MQv+F6eGQu+p8b+9/lprWPqYXl7dNYfA8NT0fD/We?=
 =?us-ascii?Q?LnLdE4mhtCGseHodT0gKaIlNOteozFFxG0k775Fu47sxS1YvY/9t95Mz9iRG?=
 =?us-ascii?Q?tB6Fm5UygasdCncwpK3wDaSiEuxC5qo9qxeCJyz8tKvsgWQGIPs/vD2RJ12f?=
 =?us-ascii?Q?KHfHjpLSM2Eh9KQIgwyd6lPG4eWiOPdGBYbZRh03t6tOPsx8IyXRICb+95pC?=
 =?us-ascii?Q?WKAqdNvvtzh0ULZR7nIixqCEZ3skfcowr4XAGl+CWZ5OhryDYet5/SCJ2d3n?=
 =?us-ascii?Q?zaZR95GUwcLknT6my2cFz38tHHvr98Wd4mvwjaLILeOg8dJdfQpQWpLfLF8m?=
 =?us-ascii?Q?vYLxyB4D0n8I5Tik64iXUF7OSymGCGFe7uC3EOmBiCm/VrXoXiJ3pDR1dtej?=
 =?us-ascii?Q?GO8MyT9PfBUdNjrgCCFg4qMnpobk+eYl7caQtT/klpxOaw91KhoNrftGUIyo?=
 =?us-ascii?Q?2AIvQ2Q2a2fSVVuaTHQRQY72fe8ojFrOs0/z+wHPAjVg5uyocvdz0fnDbFgE?=
 =?us-ascii?Q?WgbXuQ6WfrbkQdf/QGBILEPJmJMJs+WXKzhHeYt1Om0D9DsuasUFNTSFHjIO?=
 =?us-ascii?Q?JRIrBFwZmDVXc6wenBpSXSJwMt9anFX99F2QGCxwH7F8ogrl7tvBmw/axnBy?=
 =?us-ascii?Q?BOyFf6o/qZdsFJINYf/YJALp/4bgp5KpIbfOrtmL7AAhP75eLRTcM49sXAhy?=
 =?us-ascii?Q?kS6ue+2k9bSPqEuQmKh7vOm8UMMtaLytLbSdq/UR2NfSiVO3r3c2F1vfWoOK?=
 =?us-ascii?Q?hJM5QKdo8YXw9p3B5z3bw1ZO6PyLT4P7FdTJdiWHFBQrq742Bgma99rhGk2P?=
 =?us-ascii?Q?nJKD8OG7Mw+FCp0BF6D07imr7nJOPBtHMmLkI+0s4fF/y/OOt0RiVJe+m1Jz?=
 =?us-ascii?Q?f9lcRvvOtYL3wCvRnGFTQAWilo1ImRsQqJ3I5JgIGpGpkyMuL6M6v4+p763I?=
 =?us-ascii?Q?QtjRAn0HAugaaZXJ2J//bAJxDKBWY0esxjiiCCRARxxLJ4d6nnQHRrlbO+Qu?=
 =?us-ascii?Q?GI5KLCPlJfBnWUMDjbbAXRJij6MbNjIXUGnU5MsBvp5Xjmt0h8JyqQ31bQU2?=
 =?us-ascii?Q?6xTUEYQaTXlkAtSW+AHugQPPAmXfM7Pk3Rc5r3qzCwAIzkFZxm08KLTsyzvc?=
 =?us-ascii?Q?qHatPxE1lYM2AWUu2oxUQjsyFgn1167zREskl5zXfQbL498emQY7j8wP6vtJ?=
 =?us-ascii?Q?CPxW+dVwUQXrmZweQ/azirRrPNFlv9gneqLWkgngaaWzwZrJNbnI6k4IivbM?=
 =?us-ascii?Q?LcUprxU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vR3NwLGk7396p1Ar4BUOHAD/ZGdstJIRfecPXANpFJW27pX+Em34KoeYvzR1?=
 =?us-ascii?Q?6ceu4PZcZ1cf0nRQxDycOXk3b7DyjtEXUyF+y7cVJLmuEsf5Ja/boR+ifs10?=
 =?us-ascii?Q?8wPGKoue/FiGyLx3RufcwN+UsllkxouLfvj8RfzUBv9SoMrlP3QKQNPU6lXu?=
 =?us-ascii?Q?pJZ8lCAS2rqvVteLKZcc/eioXxI0vjExiJR1PFo83eRcnofWHpngdsowjYfo?=
 =?us-ascii?Q?zkoK4y0nF7S0wYd5Z/KTYAfJcOmGGYY2g3EDvYYAVY1KXhbY0ebOD5/zLN1W?=
 =?us-ascii?Q?qCCw0Z8j7zU0C06qY/8tT0jcXz7q39t4rowA0QFbRDoNeAEX29lt/jW1Gl2W?=
 =?us-ascii?Q?HSGJIWB/DCH6D7wkoju8HDfNGYBdc4WgCntHUUnVJAC/U5cLNhvSLXXL4aj/?=
 =?us-ascii?Q?CEfDxtxCj/o6+ZqHHAAk0UIhu/NrG2J1Hh8w33O8s0xf1155k2mdabc9RZ0K?=
 =?us-ascii?Q?3Dyw7q11aTP0kKerMZaqEVuVLkkMv/wGTY4scVZnxFudQOGhYaTyKw2MlW+r?=
 =?us-ascii?Q?xxIPYAbw2sPlA75RGYvvRn7WCOX2xM2khU9Ay7Z7IIcm5tZKyKvz4R3OgSXY?=
 =?us-ascii?Q?EoJ6J6XhCQvaD7dtgCYcx1BX7KdIwLtCx4n9aVYwFcAMw2kbKFMzr7LE5HSH?=
 =?us-ascii?Q?FK3xCJC6f9Zsgc0Fw/XGDLm5AXdHlk+HerryZpPxtB5TKStfguqWFbOPhQTR?=
 =?us-ascii?Q?MJ8p0oMF6SWO40tP1j/L0w0LPIV6fs4C6ZeMNlhjHlMlZG3XF5BP2y94kE45?=
 =?us-ascii?Q?K08sXyUUShrHB6t7a/mc9iXPtg3auyt0yJlO7pdIrPBYsJjjLG5McVQXQWbs?=
 =?us-ascii?Q?Dw90LtyQ6El95FS7wxiZsoSoY3UE/wDIFx62lBAzfNfkJAbqHgAgsvK7NzVj?=
 =?us-ascii?Q?ViKHm9l9Z+ZMtt1hPIoryR4GGC8KTiMyXyiccrQ+Qo2wNF5waEsUhB1/5joF?=
 =?us-ascii?Q?qqxcFOBzoJ2md8iM/TLvVDFemCusb+QLdC5GIipGfpckvJDwnhCSHDidqy8S?=
 =?us-ascii?Q?pIaFtfe7CYCByyp4GxA2lVqyC6EaMBZTqZ2sLyC5ZBd6EPrvvFdP7/cGgX0p?=
 =?us-ascii?Q?ZgRQiqOE7mzQ4wHY6cJioVME28Sy9D9tYwktXTcO7VKrYX5iiDCWEaTJtUUy?=
 =?us-ascii?Q?Oo2E2CxlwIHIfj6EJOAIeE2rwJsxFoc/TfZ9iHfifILQCGfFDQeyJSxJvSuu?=
 =?us-ascii?Q?s5f9rJRWFkxIzxlpRNAH45uYfthQMUYeCMsaCz20fI26Mh6WvlLg8YqOeuS6?=
 =?us-ascii?Q?byKOW1TizA5RipWNYo7zRSU97LdXP8LBzWNmfiet/hIAyEGMx0xFwuoGVRO3?=
 =?us-ascii?Q?5bmqmk91M55NZ7Os12sf9XhtPGurd4dNrJ55DIj3eLqyBDoWqc6PCddzXAzo?=
 =?us-ascii?Q?lQfq7YLITByQwaZbUQ7F3cuhCkGuIVcogrNYIARQcwJ9hUFdKJLwHzoZP8i5?=
 =?us-ascii?Q?jQB2QilyJUpnccZ3s6kHmpvcvhxcmCzDpizUoObRH+6cvihkVdu888WNvktR?=
 =?us-ascii?Q?BS7aAu91r8kTi2UK1Ev+ha+If4iXFM6HywzRcmyGK175WnM8BMvIU0I5wqkA?=
 =?us-ascii?Q?24QGLkQHHp+SHw873ELtpIXbfCNcNFsKyeEmRf8W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b812bd6e-802a-4e17-3a02-08dc8fa6e46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 14:56:53.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muCUzhDAIKQZ2PcbTJDyxVf6qXE7jit01uNqW2RWZvhbswvl/pWNv6IY4a1O0KAPMKzDFXB0B/GtZBCQrPXZH/keF7/WAfZT7eqvi1lGPyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675

Hi Lukasz,

Thanks for detail explanation.

> Hi Dan, Andrew, Woojung
>=20
> > Hi Dan & Andrew,
> >
> > > On Tue, Jun 18, 2024 at 03:52:23PM +0200, Andrew Lunn wrote:
> > > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > b/drivers/net/dsa/microchip/ksz_common.c
> > > > > index 2818e24e2a51..181e81af3a78 100644
> > > > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > > > @@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct
> > > > > dsa_switch *ds,
> > > int port, struct net_device *hsr,
> > > > >             return -EOPNOTSUPP;
> > > > >     }
> > > > >
> > > > > +   if (hweight8(dev->hsr_ports) > 1) {
> > > > > +           NL_SET_ERR_MSG_MOD(extack, "Cannot offload more
> > > > > than two
> > > ports (in use=3D0x%x)", dev->hsr_ports);
> > > > > +           return -EOPNOTSUPP;
> > > > > +   }
> > > >
> > > > Hi Dan
> > > >
> > > > I don't know HSR to well, but this is offloading to hardware, to
> > > > accelerate what Linux is already doing in software. It should be,
> > > > if the hardware says it cannot do it, software will continue to
> > > > do the job. So the extack message should never be seen.
> > >
> > > Ah.  Okay.  However the rest of the function prints similar messages
> > > and so probably we could remove those error messages as well.  To be
> > > honest, I just wanted something which functioned as a comment and
> > > mentioned "two ports".  Perhaps the condition would be more clear
> > > as
> > > >=3D 2 instead of > 1?
> > >
> >
> > I'm not a HSR expert and so could be a dummy question.
> >
> > I think this case (upto 2 HSR port offload) is different from other
> > offload error.
>=20
> It is not so different.
>=20
> In this case when we'd call:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 interlink lan3
> supervision 45 version 1
>=20
> lan1 and lan2 are correctly configured as ports, which can use HSR
> offloading on ksz9477.
>=20
> However, when we do already have two bits set in hsr_ports, we need to
> return (-ENOTSUPP), so the interlink port (HSR-SAN) would be used with
> SW based HSR interlink support.
>=20
> Otherwise, I do see some strange behaviour, as some HSR frames are
> visible on HSR-SAN network and vice versa causing switch to drop frames.
>=20
> Also conceptually - the interlink (i.e. HSR-SAN port) shall be only SW
> supported as it is also possible to use ksz9477 with only SW based HSR
> (i.e. port0/1 -> hsr0 with offloading, port2 -> HSR-SAN/interlink,
> port4/5 -> hsr1 with SW based HSR).

Got the point.
Didn't think separate HSR (port 0/1 & port 4/5).
Thought the case of port 0/1 (offload) + port 4/.. (SW HSR)

>=20
> > Others are checking whether offload is possible or
> > not, so SW HSR can kick in when -EOPNOTSUPP returns.
>=20
> Yes, this is exactly the case.
>=20
> > However, this
> > happens when joining 3rd (2+) port with hardware offload is enabled.
> > It is still working two ports are in HW HSR offload and next ports
> > are in SW HSR?
>=20
> As written above, it seems like the in-chip VLAN register is modified
> and some frames are passed between HSR and SAN networks, which is wrong.
>=20
> Best would be to have only two ports with HSR offloading enabled and
> then others with SW based HSR if required.
>=20
> For me the:
>=20
> NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in
> use=3D0x%x)", dev->hsr_ports);
>=20
> is fine - as it informs that no more HSR offloading is possible (and
> allows to SW based RedBox/HSR-SAN operation).
>=20

Having message looks good to me too.

Woojung

