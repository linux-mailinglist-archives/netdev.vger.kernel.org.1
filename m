Return-Path: <netdev+bounces-104685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80C90E03F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDA31C2227A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6AE179956;
	Tue, 18 Jun 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KWIYb6ex";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VaoLbBWx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5B15EFA3;
	Tue, 18 Jun 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754942; cv=fail; b=FmpcvsXd7hdL9Zo+Qb4O0Q07k9KxgWp0B5Cml81tIh0aU8BnnyIg8hJA4OoRYYyeNHd/YdG+3R8NDNkvfGCdf4eVK3eMhBKr5zCiFatgE+mhgDvJ3tO/eNYtbDORwjeZDOGLvKG9uXpO5Sl5jC0cjKhGK2LjNRTs/2bQ9lNkztE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754942; c=relaxed/simple;
	bh=pGYfZJHUoiwWqYvcnRUvnOiujR2osZ9RjEvbNW6v8EA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nD+mVUYW5i1Z6t6YaxXfhgp2XMIdH2gsAPxs2qFq/Aw2nnTJ2UR8Nlc7HBvPEJN0EmUfrB3DBTud4wQCGE50rC+eSQ19iAYwOkTCBijDDPrAVfkYQsNAjUlr/bqRWgANIMuRjh40QAa6bBMxgywrULlM3KTqctKMvOcJ/LDSQSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KWIYb6ex; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VaoLbBWx; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718754940; x=1750290940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pGYfZJHUoiwWqYvcnRUvnOiujR2osZ9RjEvbNW6v8EA=;
  b=KWIYb6exyBGph5d9zdGZV2K3q85X4oQD/mvrpUovR9admsjaQJdmYGRk
   iI3+l5Ev858xMT6Na6+77Yauyf/sJvymGlgE9l8u9RgIm3YqNVY43ND+G
   SWWF5OMW5WsTMpAKVIQEmlhM8Qdyl0htEc3FfkZqdxmXdycn6drNmBEgu
   aa87qhroI5HyuCIvPPVTvgnIeN90w5f1pPoGwZQ8Dom4UYofv6vUUqx4a
   sXVBrMN0r4z5NFlJxA+vHn3AOIJjFJExRlFBYboBn9vWH/Naw5ZqowLJR
   K9Z8w6b5y8qoJfBRmAAZjIO/6WSNtvag+N2C3TJBKYfVbAZoNxhxT4pF/
   w==;
X-CSE-ConnectionGUID: IX432m1yQNSXN47ufoghqg==
X-CSE-MsgGUID: yVnsPM1nT+mL8rxlZYJkOw==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="28772336"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 16:55:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 16:55:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 18 Jun 2024 16:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU8JDE6S5ZRv56sNU3Zv1TKm+/KeInoDf9z5jfUmQzkVFSjBDlIgtvy9QvfyuiLWiA+7tgw/N36rWIetEsqtRISgyuirJGJxMCBpf6JYpPMDeztimveRk959FGqnOrqRxFZy3oQssfa7hLT2OB0xSzptr+mOgiswkknthEH6St4lyEXFWBGTAlsa61P+u+Ulj7FYSStonJXHUWiV4VVyj14oXdwtN/gNDjZFDMfFm5hUVRFXruHhuIKfIWCi+wL73ntDvX5df8XmF4bQqYislqtiuzufLB0toJSU+U16fZVMa0eWmGXF7zvwdne2enyApPUmdRNA2JHncmzClzzcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwZ0oRxHTFJEa4nLlMpeM7FJ0S0QlN+QCUXtlrq5vsQ=;
 b=l6zmPEGN93q0ZfsVcl3QCm82qIS3LIuKF1nSaKtD+DCAT6BG9Y558XHqyZ3k2m7/cfDjlg9RtQkVHnlvyq/mpiGlV0Bszt4+Ni00zlxmhOa5Cu73pOc3cXSs/ABvRStVBUw/3EJ192/9cFPjFdWcGTZEG5/33VzDeFHW9Eqwyslkq/fbn7eDCyMuxxHuwbn4r6E/GL0JmNhkvLMqCPFyC9w6VRAKZW9Tz7hFgEaWvlfBiQpeZEKfLvsXiw99NqrR3UVuyd8uB+CzzwT6KyduNA1+NsM3ehjP1Ccs17wvwsY+zzA8MiTmJ5Yy7/7e1g5Ab/wZQGhGZlVmgNFIOCD0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwZ0oRxHTFJEa4nLlMpeM7FJ0S0QlN+QCUXtlrq5vsQ=;
 b=VaoLbBWxaxGC7SytBBVXjj+is5UcSK9qzdQ5c/97Zs4vAZ0X/Q8SVW+BX2aaror4VbSBIy1Y4zPkpSEWXObaXwpBDyoZTuW+pDTM9XlmwrzTvJAs3SyNIvUqe0o/ZRPKEbDQYwFjb6J8sDLNSeDwNUKGd4lQ5YVojBXLkuWuqIbYp38lvRxiy+EmZ5EJAJJ+Ai3zEJUmYNPIQorv39g0lGn0X9jNLgaDLMuddyHbcapaom5heUdsmrBpKLNEvzCV7CTpJth55j3A5Ttoz50cbCI3/nHadzYJViTidXgXZpmkIl2ffW7uMEBUQGmRnqVMhtwJJ1cTIA+Wma5RSTGanQ==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 23:55:22 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 23:55:22 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Arun.Ramadoss@microchip.com>, <Woojung.Huh@microchip.com>,
	<andrew@lunn.ch>, <vivien.didelot@gmail.com>, <f.fainelli@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 net] net: dsa: microchip: fix wrong register write when
 masking interrupt
Thread-Topic: [PATCH v1 net] net: dsa: microchip: fix wrong register write
 when masking interrupt
Thread-Index: AQHasvrvlIgeBsJ0IkaYfcqo1aqlFLG0iKgAgBnDIpA=
Date: Tue, 18 Jun 2024 23:55:22 +0000
Message-ID: <BYAPR11MB3558B815C8FE0A9E28365EC4ECCE2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <1717119553-3441-1-git-send-email-Tristram.Ha@microchip.com>
 <20240602141524.iap3b6w2dxilwzjg@skbuf>
In-Reply-To: <20240602141524.iap3b6w2dxilwzjg@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|CYYPR11MB8388:EE_
x-ms-office365-filtering-correlation-id: f64a2e18-6747-4774-1a15-08dc8ff21d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?YyeapKQpe/X1iHXtZHj/BOjEFU5YEPyH+p0bCP2UJJUZsRs/+KMvXTDzGIwt?=
 =?us-ascii?Q?qQCjx2Xv3l9P05VZ804XwWZ2u9aNV9Zo5zZQYLeRgq1/3mxaTf10fOimL6aG?=
 =?us-ascii?Q?p824A8j3FyI+y9aKsmRgHWHta3HqF6mGow88krYJ/DyDvV6BHrv8UeJfmQNP?=
 =?us-ascii?Q?a1ZhMCPI1rdQDGm7ppmk/5DZUaViA3DVD4RJwwUKgZ5nOs6JI6oNiZ46TrjD?=
 =?us-ascii?Q?bXow8gXVFvXQJD4wGuQB0aMlbyxxzLcPJr8fcdGohtbg2eTgqUj6qqRGFgyI?=
 =?us-ascii?Q?Xxxxh14Ze8sObkGczNeVxy6TyTeBFz3Wp8sVNbmYurxznF9GT2+whic09xp8?=
 =?us-ascii?Q?NiS6LcxuNNuKs4hwUxFGoJVv09oIzvkuGaBs6LjREw7HHe4FlotKu5On1MSI?=
 =?us-ascii?Q?ZTDmvJ/EYQmKN9q9WIaku5MO7leMut2X8U2zyf0P+xSVo6VDg13Veb6NQx3D?=
 =?us-ascii?Q?O+ZUttpYJF7hq7GT4oDvhIe7jo89TvUwq5BLfYyDv1LjK7WRJ4ZntPzWO3Cz?=
 =?us-ascii?Q?5FQTuZluRZXQxB2MtZg21SXZaFPAEAnzfauKxZwOnQ7mx5J/RQBjZKLEE6BA?=
 =?us-ascii?Q?G91HAMDktfgM53hWxzgDV+mM6KQQgnGldQ78Z2Eib7cj4VhDv3W9tD+nNd8C?=
 =?us-ascii?Q?9lYiYSArxojwvdtVKYEkAMr1v4AyebjenDrbdZiL2R1mWzBvEii/8rRn9AwQ?=
 =?us-ascii?Q?yifltJOlwrptiyCl1XoYYxK8IMQ41yVZJDQNUrfp5TSRunDNG9uvt2fyZtiF?=
 =?us-ascii?Q?DligdvhX9QX94FdyETu2AXQfmtaZiBoTUpHpGcLjMAv5Lxb1kDsQaFwlaebY?=
 =?us-ascii?Q?DoO49E83tgUkP78QW9AGAwbPWc3bF1LJdUd6YjgoZ5nPDgD+zcjg5eaB7vyl?=
 =?us-ascii?Q?nPRXFZeHOcBVY3fm5ZK0kkCW61fxFFmeby0Vbg9/yxaRgWvL9AGIPVhaRz0H?=
 =?us-ascii?Q?wiytytH/LjROkap8hLy7Tfy7LyYe+5ZlbV2jyLTzU/vasfCGIVr+dNF99e+Y?=
 =?us-ascii?Q?rk+n/ttqSXX/YMA/02pW9dCR8E05OOjLyQ8Wnkr5vwB0VJCUHd67dxmaRzWb?=
 =?us-ascii?Q?Ii1Pz/XnbLg9yHdRKmbSj2yedzLHKSdcbKMlycSu5oo/rC9TPbF9v71Hq1RY?=
 =?us-ascii?Q?E6YBzcv0se4oKJc/p4GvTFhY51ax50DqVwbaCASLLr3cZ7KsrDZGUh4boNfi?=
 =?us-ascii?Q?LM8MRK0qdfMjkqJiJHYAiPIxed2Xezeb+ZRSJhusr+9QYpm+jU5r+q8qrgs3?=
 =?us-ascii?Q?uLJdthJqfa1GfJLVy4NglypRDNMDHQaXNJHTAzdn4eAzQRTnFrunI7DHzD9/?=
 =?us-ascii?Q?L158H87Uh8BZxbmBCsWC97rTyg9DCNkK/1RH/WJCWKnaI9MglDeKi+0IZ+tw?=
 =?us-ascii?Q?EBpxsko=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?reRCxRAXpGdRRm8UW2vEidb4/029TDCNqHpvjeDP5ny1rLOf/QUErqWEYKoh?=
 =?us-ascii?Q?Q0izTCbrDjmL1oDoqjxjAoPUXi8GY7gGkvbSMIhODdfXtOYdFshKA1+Dv+ZQ?=
 =?us-ascii?Q?Vqpp+ej8emuyG93d11e+4I2nyVwi182Di3orvliogivpaq6qZypeMCFtWOpM?=
 =?us-ascii?Q?hvgQ1KAzdXo5zDCilQ3fECmyuZ3x/YEEg7ArDXUBFHzoSGHgKsRl9Ku4v3rO?=
 =?us-ascii?Q?JDIefMOpRslxAaX0yk9canaHafm5Ohd2QbON/3UVwlqlMvn3UUAXt4X+s6r6?=
 =?us-ascii?Q?5jDttxI0bqPqOTrxtfPup2iT7WaWGHJIouKL7bulEdXYLJ0u7R5guE8FgS31?=
 =?us-ascii?Q?/RuXg+kkDqdcb2L1ku7sMaOI2nqAnaFoDMEyXh3/H26X+Cnwc1FbWZOxSVOY?=
 =?us-ascii?Q?eI+furRZBzulLWM2i4mgdYZPwMvcJNBPDe7QWCf7izdzqRAm3ETxm8cxApSQ?=
 =?us-ascii?Q?3kWTFXUrD6s1V1J3ZJ4j6CC8MBugCjGFnExd9CISVcgjqT8L+Zj7CPfCDb27?=
 =?us-ascii?Q?L9fvwqPwI2tIoXqg5+ACfAm16+WsHlhNQFRh7koC6YZfXyqpaAexVbgyk7Na?=
 =?us-ascii?Q?WjRaj++aRd4jEbb68iLBkWjKRfKymyby7D9HgdtGM2gKJyUpQPaQWlJwBAoN?=
 =?us-ascii?Q?l3creIBxhC8sw7G6/cIGOVXZ/ZavnBMkpe0I9AFhZ02GsZJEYyS6rFCeABuJ?=
 =?us-ascii?Q?HQ6T3UICfyLBWWZqV358P95KXEFssKF3Y2FKKt1zmvwJcJhBqv5o6uriOZa0?=
 =?us-ascii?Q?15+6y7WxttbYJZlBgJ+8M1/pMUnD6j5HqvSyiDfP/Mt4zGKp9TRT71svbhVw?=
 =?us-ascii?Q?W7p9SLquaeiXEKPh+JicfNm6tN7mApjKv5Fch2Q1CEopr/nmCr5km5pWQLvK?=
 =?us-ascii?Q?0Tlz9xS1DYwd7WI9hcRnsmFJRAgUxux/9sg2HLA+z5Z17D54dEooQVto9Hdk?=
 =?us-ascii?Q?PDCyEMlTuQ5r2Pm0lQji2MPklyZiRZgh/cnFRxrmTmfgXhu1yPLdqutiqhzZ?=
 =?us-ascii?Q?QnTyoL0Q8DgHPfRub7jSocrDl5obe/xexRYuigK54lkIvCB49f6GdjLJXx8c?=
 =?us-ascii?Q?gu8VI1XjEUKXmDtXj7+AIfh7hbpCtuQwvKnz5Z/joiZSnlQqVygQtqx3itGs?=
 =?us-ascii?Q?sNmSFrBnxflyJutySqwcQ+YKM9TKXKvwQy2kiuNBY7r3/60g2/YvEnKPL2td?=
 =?us-ascii?Q?nkxBsexx2TWLUXzBHGqCKNgXQHrMHgbPj+QMvJpsVMQn3oBGGgBBIto0HSPd?=
 =?us-ascii?Q?LZqG81WfqO8hWpcIATJk531SUgWnbhvP+IMWBE8ibrf/dFF2pjHxhDikkeLq?=
 =?us-ascii?Q?zC8daN3/layWzeXv/HgBrt78OeLFHwNwcygaRgjZoffc6li1Y5aMoQfdn2+z?=
 =?us-ascii?Q?0nFhnRh0Ar/ZhcPDHdY6fP5Sl5IpyXylR+cDMFNBqsVPeoVUddyKHGQOyoE0?=
 =?us-ascii?Q?nTO0YFdQVUy4ufG/VBqUk98MyrLwwCOXdlREr0PKgov4rY+lSKFJYkewckop?=
 =?us-ascii?Q?OOmeRpzQISPHpXN8BYXj73iZrREDH1FJIRZkZAvO0HhSbVjhdvR7ptgWs8RF?=
 =?us-ascii?Q?rCP4zxDQqA43njERJ81OC3Wlq0Afy1AE5Q5S5ID0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64a2e18-6747-4774-1a15-08dc8ff21d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 23:55:22.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vPesC8Sy5o/BXj0zdc8N+pIVQaJmej0l+LWLkvxCw9LVPVMGjOR9Kfe15ZqkbemcflLBCWYyzoTUQJC81aUIw6JAUte861L9+DM1Y5xZT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388

> Subject: Re: [PATCH v1 net] net: dsa: microchip: fix wrong register write=
 when
> masking interrupt
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> On Thu, May 30, 2024 at 06:39:13PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > Initially the macro REG_SW_PORT_INT_MASK__4 is defined as 0x001C in
> > ksz9477_reg.h and REG_PORT_INT_MASK is defined as 0x#01F.  Because the
> > global and port interrupt handling is about the same the new
> > REG_SW_PORT_INT_MASK__1 is defined as 0x1F in ksz_common.h.  This works
> > as only the least significant bits have effect.  As a result the 32-bit
> > write needs to be changed to 8-bit.
> >
> > Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for =
girq and
> pirq")
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> > v1
> >  - clarify the reason to change the code
>=20
> After v1 comes v2.

I thought the initial version starts at index 0?

> >
> >  drivers/net/dsa/microchip/ksz_common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> > index 1e0085cd9a9a..3ad0879b00cd 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_da=
ta *d)
> >       struct ksz_device *dev =3D kirq->dev;
> >       int ret;
> >
> > -     ret =3D ksz_write32(dev, kirq->reg_mask, kirq->masked);
> > +     ret =3D ksz_write8(dev, kirq->reg_mask, kirq->masked);
> >       if (ret)
> >               dev_err(dev->dev, "failed to change IRQ mask\n");
> >
> > --
> > 2.34.1
> >
>=20
> What is the user-visible functional impact of the 32-bit access? Justify
> why this is a bug worth sending to stable kernels please.
>=20
> FWIW, struct ksz_irq operates on 16-bit registers.

As explained before the initial code uses register 0x1C but now it is
changed to 0x1F.

See the real operating code if not modified:

ret =3D ksz_write32(dev, 0x1F, 0x0000007F);

The original code looks like this:

ret =3D ksz_write32(dev, 0x1C, 0x0000007F);

BTW, all other KSZ switches except KSZ9897/KSZ9893 and LAN937X families
use only 8-bit access.


