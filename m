Return-Path: <netdev+bounces-285001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK04EQOM+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-285001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:44:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E74DF7C4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1806C300BDAB
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8371C4C6EF0;
	Wed,  6 May 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hKRycLqY"
X-Original-To: netdev@vger.kernel.org
Received: from iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com [3.221.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA43FBEDD;
	Wed,  6 May 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.221.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093042; cv=fail; b=SKRiqGRBZM4aaEuMPD6Kv3UdEwd1ME+t9kN+EVEm5vpLg9yxQbRveYEn0NeDhP1Z53TKjlrIA4Tv8yXBP9V107qs317T8Sp1pQ04M/V/nsj+8bGObWI2WYl66znvXRezolTCOVHKgDcSTmmCXj3gXBpoPIpaY+JUTpP5GRV7XmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093042; c=relaxed/simple;
	bh=tYrlD8VkZ+HQUhPOmmL2meDnP9XN5yQj/cTVzpcnou8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9lHc0P/ZbgjA63JdDp7X2yk9YT0rcG0lfutRUecihD8S+7G1fYPevjAdQXOPFSKG1yS91dcrEsPp/sY5TxOAO9s8qMtl4oZZqoHeFGr466lQYl7sqPEcDMPn//bHtJ4z4WwGJcfXFjVgnek2EAZGTQQbP04TmrvoVwQP6xv7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hKRycLqY; arc=fail smtp.client-ip=3.221.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778093041; x=1809629041;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=tYrlD8VkZ+HQUhPOmmL2meDnP9XN5yQj/cTVzpcnou8=;
  b=hKRycLqYSNWkSe8NPftUhi8tHF1Rld+N8S3vG4UXL9Dqy7pREShfgFWT
   5L/Llv7eXnH24oPmqL9DF4H2WXRP/AD/CLlC2e7CHqqAaTNsuEk1gmOc8
   P+9u3bYZUPsLcsfjlFANIi0x4aHt6mTmgvF4HdKRDdrZXkKzI+KtE/alY
   d+Uoz7VWufM4SJTeSUZGfRz9Gs01H5rPGyyPf9Vx6EqSq7V5qim+upDRv
   zC4NYcOLPda9lHWm7XIZYbKaWgpyWwM3ADSBfwBZJySJJSqQeayINPIU+
   KVetxqwvD6rH/D9msZLnA/4a+2LWPvFuUBo1lKVEfOhSlSIXuiWAsK8AX
   w==;
X-CSE-ConnectionGUID: v53mDIPVQVmVk6CBQ2eo3w==
X-CSE-MsgGUID: BscRL2vFRRWPrUSRZYcUxg==
X-IronPort-AV: E=Sophos;i="6.23,220,1770595200"; 
   d="scan'208";a="18059999"
Subject: RE: [PATCH v2 net-next 0/8] ptp: Add PHC timestamp quality attributes
Thread-Topic: [PATCH v2 net-next 0/8] ptp: Add PHC timestamp quality attributes
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 18:43:57 +0000
Received: from EX19MTAUEC001.ant.amazon.com [52.94.133.134:14924]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.34.7:2525] with esmtp (Farcaster)
 id b45225bf-0fc8-40ad-b4f7-49f61273a334; Wed, 6 May 2026 18:43:57 +0000 (UTC)
X-Farcaster-Flow-ID: b45225bf-0fc8-40ad-b4f7-49f61273a334
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 18:43:56 +0000
Received: from DM5PR08CU004.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Wed, 6 May 2026 18:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orX/y27HMl3XRAQr+76DtdGjOICjvisvXYJo540HN1fRYZf4HdxktfZIuhc0Fyx69mTra/7MQj+s3zz+gaa+76Qg6wmgpfWTPy0cUpBrY7p3Y6V3G0axHxT4iJCSQqYLBw/PtxGszjXuzyFe2bbOMJdB5sXRpEKDef0PuqoqXO5WcZojJcww61XthibrIB+qCgp8758Z0xgtfh4NljHFR5vRDIR7R1XW8qYrywoFrbbULnVaHRNRHCs9Ppvj/a6y4Lwwl9guG8HGw0pOV0w8oqaAFkOSII+xRUOvz2901mLZDU8tQnX/t8x4AIsJkH7rQz4QoYqHgVkFMjCBckGD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYrlD8VkZ+HQUhPOmmL2meDnP9XN5yQj/cTVzpcnou8=;
 b=HCruPDSj3/LAw5cNc/uw54VJgMCMij41xfGcwcTTYPNhkHtNye3MoFkmVWVKxu8urr/2LeK3jhF7zXXaHyyPofetFif+hByDC6sk26JepPOhf5MkQatGrw7K7S6DDnKPvBleOhDHURFdyXUD5ZvpYME/PXsQyKFDrbVRkWdvKPCgjZJ4XPiaKSs5Yst7DEWXyAgdC9JJhow6CLWX5dPw06j5TSNLuF7X8Lsd0BKQqt1TWa5ZMLUj6WBhqzAdYZRGie4TvCGpIENRT7uil1kEtirWjlJAeeUyn8ooEfrl1DEek1Y+ZEb+aLb16r0XQDo2zpsX6xDZVfds9k0pqPo+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by SA3PR18MB5273.namprd18.prod.outlook.com (2603:10b6:806:2f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 18:43:44 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.20.9846.016; Wed, 6 May 2026
 18:43:44 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Sarna,
 Yuval" <ysarna@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>
Thread-Index: AQHc2FEIaS8LE0+2H0qreoYSpWOGbLX/NC0AgAIqmUA=
Date: Wed, 6 May 2026 18:43:33 +0000
Deferred-Delivery: Wed, 6 May 2026 18:42:51 +0000
Message-ID: <SA1PR18MB46642903B432AA7D7500BFFFD93F2@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260430032507.11586-1-akiyano@amazon.com>
 <20260505093444.GQ15617@horms.kernel.org>
In-Reply-To: <20260505093444.GQ15617@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|SA3PR18MB5273:EE_
x-ms-office365-filtering-correlation-id: 2192ef46-e8d0-487d-5db8-08deab9f66ae
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: XopCSuJaPfQZlCvs3iiFXc9bh6clzMojnSECFIVJEavCaXqOwUuLylBmzaVNG6TQW41mvTBCo0zW6YZajHKyVnWgxXk/ryMP15ewBwIU/Nq2oIC4/ZGtSiaKFJSck/iRTJAZxlQduU2JWYYvjdl3Zb4lUYVOu+qF7DqPivs0KhQnm4MFWeDAriC4u7ts/0bvdu/C2QYYtzlE/Tn8jh6U2ZUXIgynR/Os7uBYUdZo/yIj/ULJa4Eoo5x8ID+0RBsKBdyq/sZ7SCZg5yDWeKIfhKM5TjgXAUl+GeN5T2v0qGq281SlDUeT+5fZsUs8HJ/TD/5nQJUinzhHIwB7hX3DY2dPpjvPXyNd6CpO6VfBa0DcjEGhCeRMjBXOZjWkC6Qm/GcHJBfdV75vrkbwTqPwPLxDoMqo8D2qUzctZKjLDRE4nirxtwbXR7MZo6oNiuVj5CFD2qxzQGlUJOpALZT2IHsWeNwmESQHAtvUcoU1vSdNrhikJSbSqS0KdnSm9f83lTCs6c8JQd13wNDxrdxkboIrse87WfPSbsmcrPzifoSjY5hyrkqgsHE3QE6tI3HdDDELbwg/OTeYZ6V/LoF3Ivhi2IGe76bdwDmpT6HkhuskcupHZ9WSDQ8LIvjK7pSAEpnI0LSC6eVl8YiqCfRjKbH69SiOQE4FUyYA41vjyosoeU0L/OlRfn2j59g/N481xaUOFGO49P7AGrlAZ+QDmqP82xskNImkJMmhIZWkRTUVWiM+t2padcjQzpKlekP2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wdx8P0lubNSGeyKL/HGRNCOPd4BUpj+8np72fcPpteCI9tOtJTco3PZSbZp?=
 =?us-ascii?Q?Inlb0qzFFPG2d3mufH0wNSlYjmVss7DwsZhNqc7Q0DE4SLczpkPQqa9xHDu7?=
 =?us-ascii?Q?MaKP5LHgMMvgW+K2Vbxz/Zeo1togBSRjXc5mmoU9iWzV8h7ka/Nis9TPzyAZ?=
 =?us-ascii?Q?/gJ5h2GOucypbgnaaXGkHJWZH/nZXAzag9by1o33ccEKhUlS0ipGdW0ZYvOn?=
 =?us-ascii?Q?hmDDlEDcLkoGYAQquzBwvUNui0j8PEuEbXLG1BaV+lTqdYgoW2fjSCfjgkjq?=
 =?us-ascii?Q?wxBFTMyvq5Uy2/JMNEMDGWNdT9KaQOtnRfZ/bhV1VLhTr9P3qdgh+DvSK0vX?=
 =?us-ascii?Q?B18CB1LeadxOFxbiG4hpNnLAAlMs/drw65p7Z0TinFLVbuCQmm4oqcVV2xS6?=
 =?us-ascii?Q?CLxYxhxTyOVh/+gNWhlwe6bcFOSnVLcY0WkbNtkFXi5OJClA/MyVuiHoHieV?=
 =?us-ascii?Q?sol+5GHK1F6soJl66yQntXyA3bgm0MN1X2cJe2PlFXVa7qv6KVtXMUpjpNGQ?=
 =?us-ascii?Q?zPQQ9O/ulkm2ax5HuVxr8wt6cLxWSMJ9XLGocKfW+dqSZlsy3Qg9uguGaNhn?=
 =?us-ascii?Q?3E5jj6TOHcAy1joPyPnMpT7xFBIVVwrhSdBwKf+f2LwqNt3KO6goRpj73L+8?=
 =?us-ascii?Q?GN1wVCqHFMLxIxiBEuM0uWdhV51FIE6H8PyYCxrK20gbBKUxND7cH83Yvcyj?=
 =?us-ascii?Q?59+Jh/uSXCskn8jad6ea4tOKmh5CeOLPYVozyoBaHvcJ6gPhXPAvQ03Tuvj0?=
 =?us-ascii?Q?FHfxKVVn/nfb7INHN738z+z6yYhIVLP0oChjWtKsgVe2ekmIYvmHhwOA3npo?=
 =?us-ascii?Q?2m0hdVtysgh2YPeVGASPdm50oMYJzZWbKLNUTj0G8ZhWUKhAD2OCW0X1YBbS?=
 =?us-ascii?Q?4jCDgzrJKjhHi4onD0FuiEjgrt9k+e4a41P/XuDz8G023uylwOxfqgGxS0WK?=
 =?us-ascii?Q?0TzcUWU+5w6QQNny5a5kUgXNuLsAgCb3604cz/VBd404ANNlt8hZYdOqki5g?=
 =?us-ascii?Q?HB/Q6FsvLmJm8/VGOnVrrrlR19g8+yXbGKeSbe4bEGDYefOi+OSCDdgHT7KS?=
 =?us-ascii?Q?xsqxlhA/qNWSyP36+75EbOhUCGOlqG/MGgOGDactDzxshCbwxolyQB/vefbH?=
 =?us-ascii?Q?vx7yKgfYxr4TR9h2UXWCCDs5egIqYbtPsZujFK8ijjC171jRjjNeWjBDekGE?=
 =?us-ascii?Q?o4dQpzarJDNa+qPDHaXEVk5+NRy8EvisEZVs6+h9ZQD+gkF1ybkXxZyBnS1n?=
 =?us-ascii?Q?XWs7BrJAC/IJvvMFaUXJiWOaz7CHrlgTjz+OYgvob8EitxmVIViN4ts4sO+2?=
 =?us-ascii?Q?SBjRStA7TbzfC2UzvhQus2JXzH7wHDBbiEYRdx/w337oMrFpmcDEC2AyIPOu?=
 =?us-ascii?Q?j+rXRA28DqwRAfMKXl/r1d79jfGMP03QBZKBEZU2R1jLEX187wWid6yEOhs3?=
 =?us-ascii?Q?FDc9RDfFFNlxHEv3mMvs37r522dCR/DQGxpco3ICNYucm+ks/8q5tS7vKqO3?=
 =?us-ascii?Q?N1tm8v1WVXbF0zEKP/lR6tlwORXz8pf9lfzYtX7Y4CwjCbDXqR2GHh9h+qpe?=
 =?us-ascii?Q?+pCN7+/vB6iTi9oxSdj/r+m0A35rMzBd3gYAPRHGupmKjFljGFF+MrGS3g0w?=
 =?us-ascii?Q?P4JtsCYo85jJxTzFvAnzQFhXBPYKmFSWrAzbW/rkgfUIylsbcAlM03LuSL03?=
 =?us-ascii?Q?1B6YoK6K3OmT+qrwo5qXkKR72d8v9RzpTkixpTIK9Rkvfeu4joB63c70uX05?=
 =?us-ascii?Q?uIZZpx5ZjQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wA8a+Z7TjNmH9vFBUsXdVvlORbsmhWrZ2fTbY84VggU3FEDOWX41U3kL0qIFva1/NZxnDWcBMR9NvQURY9+g5U+v0xiDMdR+Y5+wPUwmBpgoZu2a6OQoqL8NU6mcAZbLm09bE65SpApvc93FV+hqR+Je+pHVq5hswMobpal8nChXTOSJQPC0MoJBWqfZig8fiKVCNHivrDIf7i9aYZ+E+JWED22HZHGpf8hoPbaMXfOAhbBEprwZhO2rQhN7FCMtLn6J+DbVOJEw6CH9Nc28jBvCtrjLyqcwUV9gNlsTXDkE3pbLLindKhTgHcajpOp7jup7dHgsE5U0TIARVOD/lA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2192ef46-e8d0-487d-5db8-08deab9f66ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:43:44.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzYeltb7iqLYL328xIXo8K4qOp59Bjwr/KA7VGv2pobokuEDa7qOYMOt1FKkPlT/6crYJOhSU44dmVn/UOQzjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5273
X-OriginatorOrg: amazon.com
X-Rspamd-Queue-Id: CA8E74DF7C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.co.uk,amazon.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285001-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, May 5, 2026 2:35 AM>=20
>=20
>=20
> On Thu, Apr 30, 2026 at 03:24:57AM +0000, Arthur Kiyanovski wrote:
> > This series adds quality attributes to PTP Hardware Clock (PHC)
> > timestamps, allowing userspace to obtain error bound, clock status,
> > timescale, and raw counter values alongside timestamps in a single
> > call.
>=20
> Hi Arthur,
>=20
> There is an extensive AI generated review of this patchset available on
> sashiko.dev. I would appreciate it if you could look over that as it does=
 seem
> to me that many of the issues raised are relevant to the progress of this
> patchset.
>=20
> ...

Hi Simon,

Thank you for the heads up.
I will take a look and post an updated version.

Thanks,
Arthur

