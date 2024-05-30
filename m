Return-Path: <netdev+bounces-99526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E58D51F7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E21C22EAB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700802E417;
	Thu, 30 May 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b2CPtNwx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CIJi19y4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5084C8DE
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094826; cv=fail; b=ajana4kchyTa7JO7Yl/rCkw6EhiNPgo4zNqhVrEzJjwiFmmvMhDTjFYYCo/l+f/fML4CfMExY2NNt1vpUutC06Q7f32Zovba97hknMv0ShkpoZBez9+8FA8l02zZezndYlts090WIGqFx6TitwRs10Wo0jG/ErkJxw1QXPVjLXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094826; c=relaxed/simple;
	bh=5/ltXnwfGfab5RNz8BXzw7fdFHpvOAaO5yte86Mp7wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ozAjNqDFJvxfuXP6y3+GzTq3Q5Lz1kfaCmuem9WtPzD4T3GozDIM4XLo+jRUYIdCuZkR0uYz9aiOXcgUi/0GK66FIUNlrT63GQrP9Bl8Z091NmIXhK+CVQZaqSZFFOrZNJYhoOWVdobXy8s/UhRLuiUhmvv8SwarqSnfZ/tjGkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b2CPtNwx; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CIJi19y4; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717094824; x=1748630824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5/ltXnwfGfab5RNz8BXzw7fdFHpvOAaO5yte86Mp7wc=;
  b=b2CPtNwxPKaJvCIVO5KdJAI9wtCNDK9w6PQ4H/Hczc5+1Bts63xFfwVV
   bmZgnQrGzE5J/Jyg9a+UU/QV7xXT0GWiGDXs8ZXart1ZFJCbgpPPeo0gO
   xKSl7v+b3w9/R7NSUUvKYstJUbNfKyzG52NMDskyZ9YZG8qQVaVD8Fi8H
   MVh4u8WJgcJ+LN/6PxKjxZGnrK4kMApIp0P5kj12kZC0v/1XC0utI1ISN
   fyQ13GoRvyr3qo9hr4FEZ3zWae/ag6QeXF8vg/SC9zXiYfWEH7RzMOIgH
   pReE4GbbsfAFNaTAzuVH7YIpce0L+JFRrxTp2r26i9vahcW9L8ts4n1HG
   Q==;
X-CSE-ConnectionGUID: 8D49/XCDRWaYurLhYOWfOA==
X-CSE-MsgGUID: Wrw5zuMgRJ+7H9XGgqBO0w==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="27390697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 11:46:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 11:46:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 11:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdHUXDhaa2bkO84txRTRrRWkCZLKb39p3lVjgPVr3gVuYHwzQEVXqsBB0FP7TzvofWCN1+Xd8QYxfR8NvfWjVOKhBN/4/s9yYrKKo2GQ/YRS59aLwxQ/Dt1idL0LCwKmR6jCuKrm94sOhCFisQnLA1j46VRKclok5hrCyWXlnmnd46ToPYvWQDlkqSeQCPPZOpMj8ML/sK/oudEgSQ/9wtkbc166Y6a9g1wNZgCxK/fcBdYq97X4MRXWQe5hnj8f/88LlKWBVeZu7fuJjeRwjnu3ra0qkqil/xwOI1Bx9ig17bMd22eZ7G7tcNpu4DgC+W8ZmBL+5Gw9+skEONwN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/ltXnwfGfab5RNz8BXzw7fdFHpvOAaO5yte86Mp7wc=;
 b=XeXHYZ8OCy+RmbWQi7HC6QGvCEhNIczmiUZuAOmHGZ5zXG6eTwm65OxOnoQ6mboeCwZgVFzrHz0LOEtAmhL1Pj2jKs1x5Az52/0GZDi+UH5iLS6G10cip38TC4auYrpR/rtK/FivrN3DAn59BRNDveyWlZ07+HHWyQbYDrL33UhaBc3nAuohtSbROOJIwpU5GrvlBSCDjJOY+1fXhk4yysNzY8Brq73ooBGwXegWgUf9uwbk1VdJ0zWRp8yh6An4ZB4pRyyLb+1CCFgOuMZ1hr/hIgGGDuzAxzFDV9W59TO6EbrNbdMhPSateGrnYMPoSDBp5c7I6Xkj8wlfD914Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/ltXnwfGfab5RNz8BXzw7fdFHpvOAaO5yte86Mp7wc=;
 b=CIJi19y4IKDb1vxsYtM88FTRZh6WpmbH9sTVqYDLUnX+XtYFPY7sY3OM4hBZNbM81C9h4sWHrsMhHFW/YpgWZ6dcttFs9HqcChupkZQQdqVesvmraChsDxWVof9Q4YW6L8BLGX3TmM+EGhnUzEswqywG06hfW+W4nl6j1eJXM+6yWmTPS/AeP8Jwr9/TboTLeWvdofanVPr0w/cSwup2tXTrTQwNXpS3+2J3IVEeiMKz7kgd6ApwyWuCdNXXGrFaFXnwX88FOG5NnDo49FDozS58ejFqCa/2lPG/SqcE/T0TnAbT1vTojtnJWgCMaJbD6XA/le+ZYBMROQmlaEOKHw==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 30 May
 2024 18:46:46 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:46:46 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<embedded-discuss@lists.savoirfairelinux.net>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v3 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Thread-Topic: [PATCH v3 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Thread-Index: AQHasnu3nrg2J1V3Pkm0XynynIPDq7GwHd7g
Date: Thu, 30 May 2024 18:46:46 +0000
Message-ID: <BL0PR11MB29136CDA431444C794E3EE32E7F32@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: 716a228d-f4b7-410e-3dbc-08dc80d8db8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?gFdM28tu7RwPS0i2s4tNcXmD1EJSWFexV9Bmr7e+H3vzo+HsCwTJzMrmjvMV?=
 =?us-ascii?Q?WwIcoAE0z8JqvUfVj6QufW4bUzRWs0W/eEzzqMqWTRXnfdZ2+xgPGgskLDzS?=
 =?us-ascii?Q?+6Ht/W5Zjyn5PbHXx4aVsQmJ+Hk7HWfCAzushK2VZNVtlw+5WllUB+x6HESd?=
 =?us-ascii?Q?h2ev4xDKwL5ZGvUDncWJ3BfcW+XHg/RIsMPdavJYUjv6Uvvx5pvRmtoUmoL6?=
 =?us-ascii?Q?IgAp4bdXiPUg7m7GyNGnCiXxgYwwDAEAYh6s79jUOBDL1oonkQvGxoiFyuHy?=
 =?us-ascii?Q?vanK3gUWUv2Ou5cU6BQ696Rdw4414u+4yahRr1sXLfyoKckrkl2pk1tTE/Q3?=
 =?us-ascii?Q?OEZvcXF5G9DF1Pu6/EO5e8r4EJQcOCaeDIv74ET6FoITSnZM/cbSB8EqLZeE?=
 =?us-ascii?Q?kyyj0yu8q9LW2wYf8Ne+2KInkxOwugcYFh2Md5boLdQFgfAWaxPJy8IZihd7?=
 =?us-ascii?Q?sb1pQ2eQANk0vxOH3nNrPYlUT4ft3KSHCijhO+lJLYCK4rkwaZG27LFEgYrM?=
 =?us-ascii?Q?xuDtJe64smF2z1u4UE59Kon8sIhisY6w1bzW3ZjK0x58FKS2OcygHUYKPM8c?=
 =?us-ascii?Q?SYaRKfStqbn9elFXxD7VfyINciFXOSJ6DMHuQIsLnxo8tra0toLM8m3BJJw9?=
 =?us-ascii?Q?CIkxegldg1Y7S4YYNEp9q6qmQvXEdtc4g7EqHx5brxdkNf1I4n74XLuYJeCc?=
 =?us-ascii?Q?Aqzc3v4C/zH4Hz/HSh7wBUEQdYRNKq9MC/VQKlLoKUaUJgb2cVA2XHBiQe44?=
 =?us-ascii?Q?Vcvibgrddruf/NueMEit4WxYQD7WkErauXTbnHKxKu7LvesZD4lj99Tau7VA?=
 =?us-ascii?Q?j7+fXHIAJT1b1X70iCMJ7ZU6/3nr/gIkblAn1LA2DlEmmlorvn9n+1zLxPYN?=
 =?us-ascii?Q?p1bEiZQtGR2rjMPBwfXlhalNnZlxCffaZVNcNd3yTm4ZAwPHnjEPAqRbPVKJ?=
 =?us-ascii?Q?E32qASetn1lZFADhErQjAUCHk/CznZBaz6Zj69xOfU5+MBS5qdvi9YhZDfeT?=
 =?us-ascii?Q?D6W0QuPe8kNV3+3oO4GrlJyAAeiSFib5oi7L8QiPlWPL7LAdna589leUHYyD?=
 =?us-ascii?Q?hm7daggxKK/JvYQLUnH9wLSGeX5BrXm0af5tmOV7/eGqkzAqX9/4y6rTGjGw?=
 =?us-ascii?Q?o8luVVuHLvZwPdaAGi2XZ1goNkJWy780vg80OlcWKbILPrm+THy/GoUyRcXo?=
 =?us-ascii?Q?tavsJb7SezYlODKN2F8QeMc5Y9i6OYPD9xKcIpJSwBJqIHzyeZlvTlHh4QmP?=
 =?us-ascii?Q?se30ro95XeYZSLzOXF5ZSVtmO6UrwNqJP1e4LJY8ARCXvBxWdDoLZCeTlpxz?=
 =?us-ascii?Q?2cAkS1VCg/sBaUOGb2CPQR8JHW5Pd1qqNcHfae5f980mbQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qLp1KzP7s0CZzGHx89juLvi9FJmNprdZYql1QwOHr42YowFX9cTn9gs5wlKX?=
 =?us-ascii?Q?lXRSTCiqFVYKg2Lwm1rAdeqRceYvvTU2F2jnMUGXYYv9YsjScb4GxgLJkOzw?=
 =?us-ascii?Q?byUESamvjHAVMXY7ioUUXTp7vfZ0k23yRJ/FO6SZCZcOLUT4lxGsHwcTPDZZ?=
 =?us-ascii?Q?iRz6X1dEq8cdnclZtYSz+tje4SB5Fb1ZCg8o0fPtFJnYbWmXbUw+w7AHiB3m?=
 =?us-ascii?Q?LlUhDSX8QysYgufWAsOAmn0ojIUPEociQpvkvK21RElcDDN3k3NsM3EkufyJ?=
 =?us-ascii?Q?3kE0e3DmIk6yk+FvripB98F74/EvreRINEOzq1vLxfh73DYvQuCk292cJjje?=
 =?us-ascii?Q?/NO9+3fcLcKV+EzaCDtRkopLcZZ6dutMJWBJ1S1xLtCIa3pFAFzqMP8CO+YQ?=
 =?us-ascii?Q?gVJAPj4GARWhjIPuCmznV+XMfkgAzEotj11YDSstqqXTyv5MGHpynIsjXrmN?=
 =?us-ascii?Q?F4IuuvSM1WF532RMO86p2VyRzYr1NWLQUUME7ug69wt5e+g6EvQTutGcA8V+?=
 =?us-ascii?Q?KEH79zywLAs7vaK2DH+TDAnv+WUG6EkcqNkGmnY0YqSJRkfcOhCiHxQkW2GY?=
 =?us-ascii?Q?r9K8xAjeSZA9HxsbrDhms1JpQJlctlIywaJgvG5pW/uRZZ7DGYbNDfIN2EZK?=
 =?us-ascii?Q?vVGiG5dF2Hy7uSL4IHM0FLCn4hszEnc9x0NlkawdzVJ/rxohTb0ZxLG0t7vj?=
 =?us-ascii?Q?J4yfYa/2trcqr/HTT0dl7KdpyYiGOJG/sMq+555Nr6hkFueZkmdieMrvwpJh?=
 =?us-ascii?Q?yeyO3LAWlLk5GYLEFPCOragZGn24g9Z/YxMj0+OnseZInQxvV2PttgeLT0D7?=
 =?us-ascii?Q?YL+KcWhnB25hO3tKst0cOUD0hxCeeoNh/FUzHxYDlqRAYXYJWoKSQCD280dy?=
 =?us-ascii?Q?j097Cu4h2jJp5x8Q/oycVY03ICKTtDTlFugWYfke5074FRleyr7RGHMHwPo5?=
 =?us-ascii?Q?cOQgvTIisjAuuMJGaFKGz+ApGkrEPXzmUqFdVNsu2j/g7FuHjCLOoIgc0i9m?=
 =?us-ascii?Q?9JQ1jmjP8QhhRwI9WB0RYOyeEOkBHN4lwTu3JCq8i1YAJ4hIrhlRv415ru3H?=
 =?us-ascii?Q?pmGD/Qkne24bolUjvMe0aS3SKKi2zkssgm5QFHFN/0eTDTzRnx3qa8rASsQR?=
 =?us-ascii?Q?Yzh6nBrA1PezQtc5obIkqI+o7xKga5d4xYT3eL5Nz9rY/EF93czlE/qCayRz?=
 =?us-ascii?Q?paT1NuJ7fiq/QEDdBNMhJ+q/C1p38hoK1WaEaRNeIlqkxf6vhLkQOWeA5uUx?=
 =?us-ascii?Q?q/OJdNtuxvWWLT5/Ff7VJPjm2eGzl7jzbN5VyGegLye/yRBbYkeQzSHc75Sd?=
 =?us-ascii?Q?fO1TKGcxVADfV7lkmwQZw/l0xhI1maQAg7LpiNw5P4lRi6t8RWy80FvReQPJ?=
 =?us-ascii?Q?LRBTy0XA/hJEeZqmCIpmtSnCYjYTn30fGi8LQeQwi3dPPG/y4eWfZAlyS1n3?=
 =?us-ascii?Q?GSUh74ccwYa5oZFIHQtdyBfKLyuiGKsYvzKxHJfv9t60AYJS6AEQVULsA8KC?=
 =?us-ascii?Q?RpZpqLvvGnrW3vaR7rsa4Ur3rFWsVHBwTPPsO1qa8XuocDx9e+wUcZuU85sR?=
 =?us-ascii?Q?I7jty5nrMnqaVrIoHFEAjd1D4tbWqyhNTTLsSPJd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 716a228d-f4b7-410e-3dbc-08dc80d8db8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 18:46:46.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv5VnKMPH/AX8qH/pdEPGmCtsrS9rk5A1i1vNAH12XBrWb9G33KMStvcWFzXmStWRpt6jUwHShmzviesGLRlZ8kW3RacwozRu8hNJ+qBx40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527

Hi Enguerrand,

Thanks for the patch.
Could you please add UNGLinuxDriver@microchip.com in next revision
to be monitored by proper reviewers.
It is in MAINTAINERS list of Microchip KSZ series.

Best regards,
Woojung

> -----Original Message-----
> From: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> Sent: Thursday, May 30, 2024 6:25 AM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung =
Huh
> - C21699 <Woojung.Huh@microchip.com>; embedded-
> discuss@lists.savoirfairelinux.net
> Subject: [PATCH v3 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Back in 2022, I had posted a series of patches to support the KSZ9897
> switch's CPU PHY ports but some discussions had not been concluded with
> Microchip. I've been maintaining the patches since and I'm now
> resubmitting them with some improvements to handle new KSZ9897 errata
> sheets (also concerning the whole KSZ9477 family).
>=20
> I'm very much listening for feedback on these patches. Please let me know=
 if
> you
> have any suggestions or concerns. Thank you.
>=20
>=20


