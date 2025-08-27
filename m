Return-Path: <netdev+bounces-217232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1148B37E46
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C953A872E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF631CA42;
	Wed, 27 Aug 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="wh4R78zt";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="RcCB2v29"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA41D7E5B;
	Wed, 27 Aug 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285461; cv=fail; b=dUXP/7fTvlZKEQKLzzAoFfVoHsMBEh7/PkFHIIW9lY1V6iwcTE/RaFB0Bnx+jWhFtFFDfiV6kJ8EImwcJR2USIkOsvdQWWC63ZcRXlHQEP0VuwNpU1LmNjdtA8+ERM9oiNw55w18Iw5kOb0uoGL43+yYjqfvbn0j22JyYgnnafU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285461; c=relaxed/simple;
	bh=/uUP3UJXisMLfd0PuFasPS5ImsYs21emtcztZyWuDVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpotdKkQe2Ryw+9CnsxZJqy66Meir74YEL/Nzdu+1lLiUDczeEbW2dhVGMNKSG4x34iSY6aKurG0ERMg1MqUnmPfuu4JSR7WuDkXe/T7yNVzG3jkh7hoVWAUBnxeqhY2LeBde37GPKYN2rUF5bt4R6SNZobxhKeB8YeS+BPBrSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=wh4R78zt; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=RcCB2v29; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R8R0hn2401703;
	Wed, 27 Aug 2025 11:03:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=ECdzSAUkACReZuVsS/zdiJqc
	ndXO/zSZOXGCHH52Ygs=; b=wh4R78ztqM3/lV26WNNg0rDSl+0uNqXGRWzq/J2Q
	y4dpx/7O6Z7nuyChQM5QVcvVCaxQBNsdxoZZgHBhlsEzipYTTsuh+sWIxtjFvqSs
	8sl3H9j6Rh2bIl0tGGpmMFG2cxo8jDkwsbUupl8FB2nnDhT9LvTDVT8k85mnihgY
	Dpq5TW325M2HaZqnvE0KKxMkF7ZSw4k/4SBX0fVG34if/HpW4Y4POPL3vUlgb1xq
	rOJkXhcmmJIiU4upN6EY1+1vRJxfwD42M5/eT+GIvVk+ZcsEGaUyHT5ZpJj65r45
	We7nmNi6hgotSpFBxXNHTyBIMKVI2mD6B4MRHepZF2LZyw==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2138.outbound.protection.outlook.com [40.107.104.138])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48sxfhg10w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 11:03:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLZaBMvjmWNXdDxbVZSW6XF4mDmAtmrvRRflYlWMxBv90pr1UqxamESPyW1/N3Dred+6OorZGEBsk1wIHI1ENRnbr7OYR4cM3XZ3QVeT9oKn3A4GqJF4Ucc+o2DxFrA+Et7/C+2BnYnVNFU8wZkn6nUYZrF3Qn7RR9oea7CnLn/xjXlHkDol22AgP7f8ziJqgMaql6H1UjdksKZUnN3dhSwG4lC3nGZ0rdEAO8A2O4Vjnu/3E9iHbE2mPGeL/pzdAzOYMQdel4voOimCQgNZKjAOqSsLntd4HAskGuhbCKfTtFwIqvXDMSo/WjKQjDhDnb36HHJGAnfUxd4HGIkNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECdzSAUkACReZuVsS/zdiJqcndXO/zSZOXGCHH52Ygs=;
 b=aoJ5eF992D8F8ux2Pa4H+fnzZm3zhGYTgo2jGejZ26AuILT6DRjNASpsT5Vx+daSS3IV1OATMnaknyzX/h3v04kRPnJ55jE/WYJE8yz0IEsqIcHb6VZ4nbp/UiBm4nyrsAetx7PpYxVkaDhcdq9tx6Y3HJhgY3twK9MmuB+8iDhl/EkuTpy897hV9aZIhXNX6NFxEQAp7yQ4RzvLbCQHE7wkm3OsXRoZGOSZBzLdEe2f1S036DsIwGPNUyz2BpPq+N89mejEWKSD2+Bj9ydCtcaLxu6AtN6nyn6noJfQwxtFDTkpPHcSqGFBSs4OOBiexwGtUgTna35goSZR5JB4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECdzSAUkACReZuVsS/zdiJqcndXO/zSZOXGCHH52Ygs=;
 b=RcCB2v29H6bjVMRiSj5ZJdiMHQ9wAMtEdEdsSlZyDeCAX3f37kZc4l99/MPicjC2dS6ooRYLvVOC5lDZpreLgTd7hMNnmjDIozBeh0nq+EmkuLHWvLTbnciRNs/RgUK6C3oAT0zkpUoEfyrRol8iBHO7xD9WQbfDgXpLPxNz1ME=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PA1P192MB3086.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 09:03:46 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 09:03:46 +0000
Date: Wed, 27 Aug 2025 11:03:42 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
References: <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00002BAE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:8) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PA1P192MB3086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e805e99-484d-4da6-3536-08dde548a13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRfxdE3voKVw/s7bumh++O8fAfczc8P9/+yqPisP1sA2oCg52500Fr2Z4sbR?=
 =?us-ascii?Q?G2tPD2ovjAYRdEok5AvBoyeXB+e3Iy3Vlmfl5pMyYtmaU4BQqjY0pyX33j0v?=
 =?us-ascii?Q?2oYetzWJvteo0b1vODPKw1eUTLXaHgZumlnpTNAsi37CsfFukcwb5djkOwsG?=
 =?us-ascii?Q?MCU55YZPOycN34+Ikuo08/nmXYUiGvqdKxz0ckQ7PWRuDQFQ3vg403zQAEkK?=
 =?us-ascii?Q?Q/lnxrn/bSvy9H5ulUARZU+d6eBQhcmvdyjwIBRbxV8udKFhH1iyrsoficJj?=
 =?us-ascii?Q?kY0usEI4ADk2UcsL/rP5BB5Gj22Av8Aw4lIO5MW8SS0Qm3OmJ3vyVNTBwRXU?=
 =?us-ascii?Q?57IywvgxAd8feYoZVtZdfd0k0TWbGM70c0IiD7vBJvZaYiwksnfv0cznXJ6Z?=
 =?us-ascii?Q?pVv0hrXWDjq8pxWsODVB/UNCs3wKqoLYJbIpIH/JtFjW294QZ4Vu59hYJhWg?=
 =?us-ascii?Q?KMduvS1q65MsIzs5RkZNPuiPNM5bGQqGTA9Kz28uqwfOgzOkORor3QtoK2WS?=
 =?us-ascii?Q?O0+Ni2OhMFjN1KdFf5Yyaiuf9bHy/0tjCPh8XOUlAoSt8CIQ9hSqKwjbENJs?=
 =?us-ascii?Q?cJnGeZMew7Qt17DN9Q75lh/6H0oNhbE+hXfzp7l45I+y2mQiuSCykK4sZaml?=
 =?us-ascii?Q?onSJXmE/8bSn7r9H62ZlNHZPehY9QNT7YftdRgEpMHJXWPeQWHzCSgwF0URH?=
 =?us-ascii?Q?ofp8TQIbQCxR2mphhMRLcvsxZKfcjxajXgyvE4e0DY01yZ1LTXj8a0i88UYU?=
 =?us-ascii?Q?ZGLBTlYMFBbNNWhSmu4BZQoX8TxBvhCe/LHxXiE+3kZl9CmEYl365ahi0Fx2?=
 =?us-ascii?Q?lcWXNamQizGEpibQ+jnKwXip3hR/nOmswLwEtR1riNn5U+40G6oiqZYZ8P3p?=
 =?us-ascii?Q?aI8ysGpIlm08/GQsyOtuY6UQq8kgrbuf35V4ssW2ye4W8ImgDE+ouBBnIa6G?=
 =?us-ascii?Q?cBgnGdmDulGmZibe/l4G9n6E1rDzqLQ2Eei3NzkhmvLlOKuE2OTKnbvK5nNI?=
 =?us-ascii?Q?1xfnU4Djzif+UIyV+kkLZhm5YKVdEFjr7SoR2+WRE2+dfyG6DDlYRTfeEG3o?=
 =?us-ascii?Q?3cf0557aNj3VyyB4z7SIZtq2DroCxz3AaLJebjJkAAOejwOUISHSPhPhubGP?=
 =?us-ascii?Q?Uvova1Z2WRS4SM3BUa5XDrOqYmAZA1he0ms+5Nf1rpVmwYAra/8oOlNV3f1v?=
 =?us-ascii?Q?e+ffq4SGGN5MSXCWlYpFY3y2QGYWt/NO7/YHNsxPcE6veo27+M6sQ3cbhk3Y?=
 =?us-ascii?Q?1IDo7PUwH+M9bXwSu9OxymoYZsn0EEZ1iTV9jtzYXr3JUuYlztgr6Ff0iNf7?=
 =?us-ascii?Q?35TihV0sZVhRG0PDa1m/eQE5e6Bd7+RHaglCTr4APPcJJt1+Gr9aktRnavJF?=
 =?us-ascii?Q?DtaYJNVciYg2UYOTifNQOj/YXammlqCxd+0MLePKJlTfBX1CxCMke3x50dIZ?=
 =?us-ascii?Q?/v2De561Cb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uam9WFXp7T37UA46mfTyi+VR5u4n+SW8tbSUrpI79jSdlGqgMsL3sf29Jfvy?=
 =?us-ascii?Q?3sXMUb0JdI1LIrGRstv0OrKBwEgihQgay0whJ+GKr1HNTYDliUmtOeBYEMx2?=
 =?us-ascii?Q?hNdk9exnoHMfhEAAAL2nG9uReaJ3CHhymR1CqfBJL1pPTilZg4X7pFZyQ6+g?=
 =?us-ascii?Q?FfTWa5ylHLK4jc+hw9ZPY9VzBwH38yl1v8ZEUH6GmR1kSHrQO8sBkAkP+VKM?=
 =?us-ascii?Q?2vw2cawco5oAgC3H1FPF2JP07+iJSftsPAtbVFgfuDE+r2ApNFA+bf5Vqguw?=
 =?us-ascii?Q?Vq+wO4EkptcfPkI8pDdfNlx/6CiuSq/wDqY2hnpUiaAcadIOg/dCG0crFc55?=
 =?us-ascii?Q?cRyb2pcirsDYBaWOm9CRGuCcsaQJTTbt1GJHQASmN8HZbeI+zpABtS9EVKgd?=
 =?us-ascii?Q?h3LziuYtmI8ZIbz0D0WKLNSV6xNLTJsEtnt5g+bQyD6iBnaLtwumOoMcus47?=
 =?us-ascii?Q?+pjMSzgfpBlLgKtvVqQcPj8qm5TsoWd800Q/YbtsUEQZPKxOKuyQ8JFr8Wzs?=
 =?us-ascii?Q?FAPzX7l3clE9C0zFzBopEwYIPdeHNkTTlJpJiPUlC0h2/us07LhYZGPpz8KH?=
 =?us-ascii?Q?/EH4y30vu2GJbz8hRuHzL5syIa1tvvFhMXbM7XH+WhBBuyzFqalE9V0KJ6k/?=
 =?us-ascii?Q?Oz8w2xSekIf8XSxwDy8683uyKntPy5fA98Lqa0vQ7bXlGEJHyXASUUYBc6t4?=
 =?us-ascii?Q?0rE4+diTTaf+ClvVP1kC+NO+nNPwN19bb5Fbs3mB24uqEHVA6mBME8e1VT7D?=
 =?us-ascii?Q?0wFESbrMBsh/ZXXDWrXtqCenXJL7ADeZkpgUzZIk14OZSAjC218VjqTVSZlX?=
 =?us-ascii?Q?Uav/wpJblIwHhM70B09Nh9YHFMOckMAC39p7sELUKWMNcoMCGSyEnRjWqcUN?=
 =?us-ascii?Q?kJpQXng1rx6p/zDMS8aI/O/a6ihz2/2GB154r+JfH8igKWB5/kYBs3ly6DTk?=
 =?us-ascii?Q?g2wb+B9HYlYXKPEMp9gVj5v5JSDZ1BIIVJcxQ6VSdmwr2lMfV08836risxZE?=
 =?us-ascii?Q?c2z+vzn4e5SHjmK/44gifGF1Nb2EEmooEFXmC4wDKsvHEIVWItoe3s0PVDPG?=
 =?us-ascii?Q?uHe/+uGGguItFMLNsioBkbIuapUGyUe7ZMsVNX77tazjVFEv0E3LfogS93VF?=
 =?us-ascii?Q?gdF/o8NfVWbsbOqHWfGMl3qYvix0+3Jem/n31u32q3XqUw9g0q2qy/6AENcJ?=
 =?us-ascii?Q?iJERbCjIzQXE62vEkF7EMsIpz0j2grrCru+ZnETVCfamrg772tQudJlZnyDW?=
 =?us-ascii?Q?0QJ210CqWGcL2V3dyeVV7b+DT0Lpog/k6hh9poQfiGh3RmsTNaYYoIzve+30?=
 =?us-ascii?Q?Vn4O0exwfqCpZoery32jF4zrMJJsjwh/fKU0aVf/QJzTNyifL63UKZ8mADYA?=
 =?us-ascii?Q?C4Gnk3d/nbY2jW4ZHj2nPEsPuMjGxZLineWyKewLqcOKu5uoZBWz+75m4gOE?=
 =?us-ascii?Q?idz2N/tkUirq8kTJBPhuLDGEek8L4jfYs4qBUmDjA/S0dTBUydZ3irhV4q6g?=
 =?us-ascii?Q?UqrMUvJWcbdsO2VEY/6jikn3BzxcC9uVZ7phIO4JACG2gXmbJ+BmS8XD6H2I?=
 =?us-ascii?Q?Jfow7avXf5+vd7JYYutFGNag3cALA3WhtD79jGpt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o3ldl2Cnf5QIdVxybM2Kfjbp9iYK/kVLucth9Z3Ty2AfJURlyDAW1mpJxexPT3M5sgjRe1MJhpYsb6kuUylg0G4l7yMheNslwKUzeaVxP84rxF/UCyLZ3PlNUJYAb4XwJ5sO7eHfVRiM9Y63WcnWn84/cfRMLreDuqkg025riVJH11jWLNYRJnZo+NPdjwJwNM8JeanWCPM3LzHMYeZCZ6/lBzKSzoZnICFWNhKKH9xy18XnYQcPKpp2Es/3pyR2QYCJGR5OdT8vjpu50q3jd8binoRqvnekrmzGupmQYuGWT4buOrmHfBbzmKUba2AqBFCfJLYCSkUpWeRbOkKimXuREKvsRbmfKkAcHshPdrEQqthq+tfJuAYIo8zusMBaoiymacMCKtEGd4NkzWlxlqsSKDBLicds1yYC7qH9bNcofrtlBkleyko65uwK3h8iKVBT5gvpcGbjKokuPnBY8W9La9CEJvMNDgFrtiUhySHlNomXkYqXVOyVRRcDVPz7sPYft/nsNko84gUHU6ApN+ybxRMQ2k64OpRttWo4+kslPqNl1SwIxgEiHGHJNfPsofjUeLhZdk3y0sHo3vVuujVIjxO6t8/kb1hMdOz0PD161xrsDH3RiOgImgind46H
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e805e99-484d-4da6-3536-08dde548a13b
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:03:46.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neaEvZB5H1Q8gDHHVSKF87N1CHhdyloGv47pnupNMVxCqYnvR/vZ13wHJL9CWzGx7WjBoI+wAxnbhupntbKLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P192MB3086
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PA1P192MB3086.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 2UykdSXpVkvQrrdqsfEkweS4V2aEHCuR
X-Proofpoint-ORIG-GUID: 2UykdSXpVkvQrrdqsfEkweS4V2aEHCuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA3NiBTYWx0ZWRfX6QfrF05m2KH/
 T7VLkkeXv4Tf/CGAixwup0yvJo6k+GdCYgZbx7kSTeb88oAIu2r69IsVY7fVvpn70LPvWy+vk1w
 WHvZq5kyHNc3hVtVtLS5R8Dd1b/8EMX1kTbfOKc38Io/CYGq3McxThJvPHnb7xLK7eHoGYpi/A3
 N8kOfqOZwmRDDghtHslsMTa0Yj2i3uULjJPZ5H9X+ht+kgsjBvvFtfaJ8Edn2qBcM58TwT+itMo
 JJO7MnSnDAiUbC0d1fDQvnyvJa+ZhDbWuMT5lZw4RZ2k26nw3LESLaVLgX4O4H0JwzJJBzqe2W1
 TULPeKKbuaKdOiA8qV85GIVqPmdBzvf2JBbHG6HnamPgKIEPnzSC/8noHJb5vY=
X-Authority-Analysis: v=2.4 cv=H8fbw/Yi c=1 sm=1 tr=0 ts=68aec9f4 cx=c_pps
 a=4wed0SJpTQImvsGLk7hrEA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=wr9uHl8oAEsY6W0foTUA:9 a=CjuIK1q_8ugA:10

Am Wed, Aug 27, 2025 at 09:47:49AM +0100 schrieb Russell King (Oracle):
> On Wed, Aug 27, 2025 at 10:41:11AM +0200, Alexander Wilhelm wrote:
> > Set to 100M:
> > 
> >     fsl_dpaa_mac: [DEBUG] <memac_link_down> called
> >     fsl_dpaa_mac: [DEBUG] <memac_link_up> called
> >     fsl_dpaa_mac: [DEBUG] * mode: 0
> >     fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
> >     fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
> >     fsl_dpaa_mac: [DEBUG] * speed: 2500
> >     fsl_dpaa_mac: [DEBUG] * duplex: 1
> >     fsl_dpaa_mac: [DEBUG] * tx_pause: 1
> >     fsl_dpaa_mac: [DEBUG] * rx_pause: 1
> 
> So the PHY reported that it's using 2500base-X ("OCSGMII") for 100M,
> which means 0x31b 3 LSBs are 4. Your hardware engineer appears to be
> incorrect in his statement.

I asked the hardware engineer again. The point is that the MAC does not set
SGMII for 100M. It still uses 2500base-x but with 10x paket repetition. He could
measure and proof that with a logic analyzer.


Best regards
Alexander Wilhelm

