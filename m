Return-Path: <netdev+bounces-104571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED790D5CB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337801F21D9C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0891586CB;
	Tue, 18 Jun 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DYOTifOM";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nNdWgYM2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22318823B8;
	Tue, 18 Jun 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721101; cv=fail; b=OiSnWIpflfn8JKOOFasAbjKwB5Qejw8vOwB6C2fiaBSFHrN5pwz4Zq7xXBc7H4TaIw4dx5xTOHo8ID0Atd1/7ZzVA8F1cwss8qdpnGdm6uZ1RMmKiAkafR03J6/ZqrmKUK94Bqy76dnOXqvrPyiVvNP57+dMG94GP5bV5HKbbmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721101; c=relaxed/simple;
	bh=q3OPV63mvr8tEdPLHqmRcIob8vM9VSaEP+st9VLrr14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lj9MaOnI3bWAFhJ095GnHe0o60b39sdCGp1YP+H2j89FwQQWXyFxk1hd6hJhBqJQnc6+5BUBG9kBCeqWjKSeI20wjjAdkMm/qiPSN24Sk8pVFv3dEAzrWt4SrRxH8XWmXEXFDj4aow7Q05cmA/lpEF7t4ozY+bg/HRGLWf3ll0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DYOTifOM; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nNdWgYM2; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718721099; x=1750257099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q3OPV63mvr8tEdPLHqmRcIob8vM9VSaEP+st9VLrr14=;
  b=DYOTifOMCFKxdC3CxCsL1SXsD0+WnUiPcTcSUbTT8jLVe9aLGQV+dDx9
   QUYtnkQEqbyfIfW4TTSr8kVqqz8m20cNeUyaMrfv7iLEBSp8rDjADhvhV
   SbOLTveqGrxZh5kAaT5h5o0SJ5wKWC6Y7LRSf4sJJAoRCRYmt8VEuanto
   mo9DArimUIlbgStSUz2C2GMX3rg+CG4OfNHwLRl/S3dkRXo8cWb3V8dtJ
   pE3PgslERnVAjxYAla6kZ1HHZ23YLOdgY2aSx/rzyztQVU+g6MfTJpbf+
   qWl+zMw+ES5gc+Ds9b5JWa0AdE185pqPOARrhncuPSIeN33gL8MBxKghz
   Q==;
X-CSE-ConnectionGUID: e6/VLKKeSmOYMLzNwTkVxA==
X-CSE-MsgGUID: nUNq08XjRo+LYd4axtwnQw==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="30558788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 07:31:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 07:31:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 18 Jun 2024 07:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdMJt1dXcqd1gJZQM9n4r0VZNKlveK+MqgSpVExqvAJQo3Hjya0kSQ/TWLUVSWp0gjKEhPeJL+SLj1af73y+94ixHyzArnxkP9P2ZfmPoCETkVhaD7kdxPtTT+kCon06t4FOp2pxFVOlhmy8MdKwcJr72Yy7ZoOHkkkh32Rd4d470F+CCvReGKsjF09CAFe28argt3sbaQ13bp7zqaqLk2LNcs1PHmmmrb7ZW387cpROpvOOH77lX+0uVxIi0u/euZh74mZ0q6fsxF5BPwJ1bfxS+aG8GyQdQBYWAgMwXnbm5M0NZEQoDhlOO3tvcRrcgmJaIgDBEqd1FnjlCPxlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiJVKJxQOg2DhwYlGaYDbsxFjrNxTlUYpkxB2s4dEPo=;
 b=J6Lo6I5Qm1zFT2Ua/k+FczsTYfz/7pxRuAVS7Va7hZbpNsoUyJmH3ms+WwvyW/8d9owlNoshKHZhbRyr/o5T27b6agScsNS5d8hxD6V/7/u3+HbQL5QfLoXvZyoTD8QbOr20HkHsiEyHvjluHYJ1tJ5skNjsxvLr6763P8I19Ei0KXK7kqJylJQToHoaDrXA7Mc5yqIGTv4QAy6a9ZZFyeeDskKOd0zTjnyNrzXfKZaQNMb49YaBrIZ6NhpVB5IeNTIJ0vSP6Oxs5tun4p4KMMzEjAGI6G1eMuFNDAX7s123niV7xa7XM9i0kzWmictwG70M997JHZk9XgX0IWQYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJVKJxQOg2DhwYlGaYDbsxFjrNxTlUYpkxB2s4dEPo=;
 b=nNdWgYM2eDuuaMlEfERgjUlY+F+EkQPoSAByxc3y6hK5Y5gdUov5pnnJBzy12A0iKQld6FZA4gCpKNTTsZ9wcLkNsYofDz3Sy3mIwlywtimdg8om0n4dpx8zr0jXf02QpZi03MdFIPO5lRV6/mHJLQcDekDsZrCrJenXs7k73N+eRmaKKVzd0Cmv2+BUKG1gAAHTxFbfIJGfK8bu5yS4JuX4z2xvMUs/gKwsxCFAOXGL8rSklsaXzOz4q61s7EMmPGNm7Ct1tmKKKWb1EqvJIWjD7XagosdRHrRHevP+r8+K0Gd0cq5ZqZHtTWikvAzXFmc+oyzbMAAZ37DelPr9ew==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 14:31:28 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 14:31:28 +0000
From: <Woojung.Huh@microchip.com>
To: <dan.carpenter@linaro.org>, <andrew@lunn.ch>
CC: <lukma@denx.de>, <olteanv@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<Tristram.Ha@microchip.com>, <bigeasy@linutronix.de>, <horms@kernel.org>,
	<ricardo@marliere.net>, <casper.casan@gmail.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Thread-Topic: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Thread-Index: AQHawYAhWaz/WFawKEC+9dCImD/657HNh9OAgAACqoCAAAPlAIAABY/w
Date: Tue, 18 Jun 2024 14:31:28 +0000
Message-ID: <BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240618130433.1111485-1-lukma@denx.de>
 <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
 <24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
 <1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
In-Reply-To: <1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|DS0PR11MB6325:EE_
x-ms-office365-filtering-correlation-id: d9ec083f-59a4-44cc-8241-08dc8fa3572a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?tE4E+iBN0nVl0dJD5ibyKI4oqzIrwjYHKMiTSZPU7xFXKn9xNNICE4fwZdU7?=
 =?us-ascii?Q?UPq/dm+L2dQPNb4zhqmLzZnYS/6Ci0Ys5mJtHa7fYRAFA8EO3aVutvQPYwWq?=
 =?us-ascii?Q?/vEHbRrBLVjq4MAJ8b5dnYc+wIAa4vV640usBwLZQFC3p2yI6A/BHDbd3vEN?=
 =?us-ascii?Q?PVQv/Eq9Ub+a3rHyMhsLem3ORvUKYmSLS3q/5X24zuRHwDO7FT/YpBYb0Gvx?=
 =?us-ascii?Q?62jdX7Ljzn+8MxPB7uJ4uXLp+8k+5DUbM8Lrr5MdPk8SpiRwyueRi1vKzspg?=
 =?us-ascii?Q?tpP4E9XVb61bP7v6gtyV9nMM/RVsDDhrV4CFETnE3UZMPMYXujOZmvYUamTJ?=
 =?us-ascii?Q?GbXvTTS/Pw2JP4Grn+i0cgu32BKtMVJlt0Dd4on/5iVfCv7MKu4mpTyeSmuI?=
 =?us-ascii?Q?4aBgw6rXflTYc1tf2Lh2Rgj0XLpZuLYf/xyFWh9qlNvjHEW+QEpAwT8ggurd?=
 =?us-ascii?Q?J+DXpkPYLWECP3Q84n9Auhmc/s7jTAtQNPTMWdgKPTWxPOOVsBy12AWNWvS9?=
 =?us-ascii?Q?mivgKdrC23A91tbiWdCKwmSJ4jOFc8sHcR63dRO4JP9S5UQR9074LwZqo45L?=
 =?us-ascii?Q?HBl0/EPl7QNwi9rtxKmQykqlPvWQflhPYF/dg9KivAHa2oDcoc3rlURGkZ6s?=
 =?us-ascii?Q?Qq/7TgVGkRmd3GPq8gMFbC1xMoE02bgEuu37SDh8M7a3oB5vYITmZOF/SQae?=
 =?us-ascii?Q?LhrbtV8O/mVD9IcnldqljAoAi2AG7Mc00cl4vv+tvZExtjZh9m/0/W/DlE0/?=
 =?us-ascii?Q?nzR58lr2KCB6vJzPo0V36se2VuFhJT1nrBKHgfZMVPgyS9YoIHi2ISSvtdqg?=
 =?us-ascii?Q?fwCMFSUHN3+HJK3kuFmc9K1gLmAE7iEko8nOqcImYDtayUBiSdyG5qFEqTtg?=
 =?us-ascii?Q?yu60UsvbVgbrpZhtuWZtg5yjzvxz9EM49L+BLFDKYeYjaFxMrzkcALieu+6B?=
 =?us-ascii?Q?g98YS83a8YyOuUbYSrvXCjc1e6DMMyShGma9kIpff+soBvEN4Hq2+Ns8yVFZ?=
 =?us-ascii?Q?cxQxmFoCY7xnUgVr3ksh3yiIVSLxtg6gs9sTwM4l+bbUeSYPSpZIgpj48cSb?=
 =?us-ascii?Q?NAoUBClKsfsic8bi2T3WOC1JKcFqePHudlouRm1jkSB/zl1/gg7OI+Lt3HC0?=
 =?us-ascii?Q?wIFaEwqgnXsHd5TmQze289cO0g5fyvYJaYU/NFJuXhXRaz9d3z8V9z8eHong?=
 =?us-ascii?Q?KfiBTZSrOvhqiqEFPYTP15Q6Pbd75lr9WuXarKJmp9C+e/O9PPYccWfYKrvL?=
 =?us-ascii?Q?T1vCWCe4UhOZ9cGiDOgnv39IJcPDWeQdWomi6Vc15Hyv61QV4Z/i7Lnk4prf?=
 =?us-ascii?Q?8bVWWPpNHyc+8jQt7HRGZTipEjZeoHi+ssz664n31LIUqMsSxDTeonG4qfXF?=
 =?us-ascii?Q?X4ZPU0c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dnK+NUieSyEhS++f/9y0jUpVWMrRt1YnTyGlMyKyDn2BSAC87UhmpCr72ech?=
 =?us-ascii?Q?SZRDyTuF9kLoYhfAB29UPnf7/1eE6nmZKf06qIByKwW0OCznSkoSE1kCBTos?=
 =?us-ascii?Q?8Ph2LNXcwC9x0bxcejwYO0CB+EdjexMRdadh7o57gF4PfuSlZrN8bnK611Rw?=
 =?us-ascii?Q?NrhaJ9vdAKZ2F+3WCGF/DdwwB/Ab49bK0ZljQ3cJdd3BN7mE+4h56sgaR7aw?=
 =?us-ascii?Q?kpdtWCAsmgBFHP7Dpvj3Bi77zzNnMwKfkJ4r3QGYKFg8oSWfl0+P+meMdKwv?=
 =?us-ascii?Q?a0fUKbaVMWpyZWvFjN163m3jHx2iCAknYEOuwcj//RfhuLGeRl+LRqHIX3Lz?=
 =?us-ascii?Q?3qGYCyneutg/i00bg953sORp/lrMeHe5C9o8cir2bDDkIHTlPOpAIxi8nscw?=
 =?us-ascii?Q?dg3iczAbxYgzNGxI/CJKJMI2OFDmY+p+dqyKIEFWOu3j7Uqp1z6a43GOneFW?=
 =?us-ascii?Q?ZvQSgdZ4U7zrBTL5ZsGh+hGqwlRbYfnXHctzbgzAEAhgzSEA7STfX7SWVHkg?=
 =?us-ascii?Q?8jvfHWbkGZsNs70GqiXB+TporBTohUmOsYvi9vlOmwM2YMVdOPa7c/R+vA0/?=
 =?us-ascii?Q?3yRFYcdFn4QmcSRNZEIeHUzgiuWcNpWbY/6knz5zpu8BFAOZqUGjiHGX6anE?=
 =?us-ascii?Q?8Q06ysJs02pHLRAdkJKj85fxdF2ggzH13W+2Rrk4wBh43dt0dwVw4moNp/SK?=
 =?us-ascii?Q?iGg/Buz2ob0t15jI6re+Lb0feMANUjfwdpCjWe4ev+ndcBLzbTteqe76tKjF?=
 =?us-ascii?Q?T3zevkFZnY4R32/TIdceXCXQwLJpZfQt9fLlaf8BsRmeQZKoLqdsBW4bN6PX?=
 =?us-ascii?Q?0MWrgLUJnSkcYd+/Cccnk0wWmQ6+FmObR7iH2vJ2oH/p13mHRCj+OTcqYhfD?=
 =?us-ascii?Q?4blYCkb/ctZpEF9bFDOniquNTVib6jlOnkA5ckNdMN6MtE5DtA8QIj1bljzl?=
 =?us-ascii?Q?4oQJ08StJ0HrDIblKqXiwRVIP7ZWAQ98+YfeenijWGjKOhdK0v6JnY6HP9bR?=
 =?us-ascii?Q?EFmVxtMWwc82+DgYjuA9+3XxTgokXSJ3okg2TyOcsBysXMdHX7io+Bc1TC9W?=
 =?us-ascii?Q?sSqpPOnBDJMK4iTv5XiIuIxxLSuTI6UTKGYZSfVRvnM1OhhCKTfTgn2lBMVN?=
 =?us-ascii?Q?OcR7NX2gLfuc22sSvH7WKorzWXUHGNJ4fwZxvo9/TFZ7T2GpcB+Nu8bcPVkM?=
 =?us-ascii?Q?jyBHZHg4QF4HCp340s51hTgtvCMLSm/j1P7vMJotaxc1yhTA8+/Fgo9oxy8b?=
 =?us-ascii?Q?CJWCx70Spcfr/NpZ6yFLRJaQQykJ5m1jcjKGg+8U5Vdm8Un1/G0xQG0qWwgG?=
 =?us-ascii?Q?jWHEAhhS36vp9rFDLZASssIuzIk9gx15R9PJOJLbaUycOfOQzEhxIVcrmdpH?=
 =?us-ascii?Q?hWIj49Ac4+ufWwN4qCM1vkN+wBHOUGPkOZgqr+f1SZoBRj2MBtimrIZ1iRMj?=
 =?us-ascii?Q?7XiLRlRdQRoq77Jd+7IIi7+niK+smEJdnIJG3kTEl9dR8g1xKkgjB6UKNe3r?=
 =?us-ascii?Q?cFyqpCbb5Mq9xiB/2V2aVLKoLXjKB00bpSy6osWVS9BgkK62a+0gN3lGib3+?=
 =?us-ascii?Q?tuTFmcjiB83aDdxSK4m9KoAseo1Fe8nWIUMsVnmq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ec083f-59a4-44cc-8241-08dc8fa3572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 14:31:28.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hg9dKbd+4ZRCeY79Jxj8e5qX7+EOrcBrXW1idY8ktxlNZfAu4fCxBBjLwhg7ftKFq8vhLe5uWNhqgYJ4P86ZsNTE5ANFtpJDNgQSFaByv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325

Hi Dan & Andrew,

> On Tue, Jun 18, 2024 at 03:52:23PM +0200, Andrew Lunn wrote:
> > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> > > index 2818e24e2a51..181e81af3a78 100644
> > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > @@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct dsa_switch *ds,
> int port, struct net_device *hsr,
> > >             return -EOPNOTSUPP;
> > >     }
> > >
> > > +   if (hweight8(dev->hsr_ports) > 1) {
> > > +           NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two
> ports (in use=3D0x%x)", dev->hsr_ports);
> > > +           return -EOPNOTSUPP;
> > > +   }
> >
> > Hi Dan
> >
> > I don't know HSR to well, but this is offloading to hardware, to
> > accelerate what Linux is already doing in software. It should be, if
> > the hardware says it cannot do it, software will continue to do the
> > job. So the extack message should never be seen.
>=20
> Ah.  Okay.  However the rest of the function prints similar messages
> and so probably we could remove those error messages as well.  To be
> honest, I just wanted something which functioned as a comment and
> mentioned "two ports".  Perhaps the condition would be more clear as
> >=3D 2 instead of > 1?
>=20

I'm not a HSR expert and so could be a dummy question.

I think this case (upto 2 HSR port offload) is different from other offload=
 error.
Others are checking whether offload is possible or not, so SW HSR can kick =
in
when -EOPNOTSUPP returns. However, this happens when joining 3rd (2+) port
with hardware offload is enabled.
It is still working two ports are in HW HSR offload and next ports are in S=
W HSR?

Thanks.
Woojung

