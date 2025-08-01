Return-Path: <netdev+bounces-211342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE290B1817A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C5E3A3692
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70692343B6;
	Fri,  1 Aug 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="g6hl2gye";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="C30RJfPk"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F82EB10;
	Fri,  1 Aug 2025 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050000; cv=fail; b=bh9N9k3yuuoUvDyC9M9m6CLNNT12z78Vs1bj1F2kTA3phZ6/qh5VGAd+pQNr51qq96mXP0ktbfbDPgEShJhNOHrhWKUGGtxz3fyBAe6dMfJOuNVnIUiDdOFwH/fqd1BMFgGVaaOXCYiOAOBTwzSOe5weCZ9RkpzVRetffH9nT7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050000; c=relaxed/simple;
	bh=ojFeS6Da8g5e4anJQvIiHuGNXwAzcEEocsZR1BR3MVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVE1a64ZyJm5oJD4rotuB7C2vEfdo3Dhjzl3CZWHrelbXqH6sHQRAdckfQcQiWfFiGdlqmENHmYFPBmNgqEaUo6y2h4PPd43k2cl0yet4iuMRCaY4MHs63fhLdbJUu/sX/hXhK7wyppuaSHb0GEtuiU9Xf+PZEBA0BPRqVEx1AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=g6hl2gye; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=C30RJfPk; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 571B8xtE3155805;
	Fri, 1 Aug 2025 14:06:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=QWO+YvIqEgyANLBEtqSZ0Bxd
	mlEJg3iWynkDxVTmgF4=; b=g6hl2gyeJMtSId0YXq3iF+JsKTxh+TucFE9TmUA0
	oISEhOVf1oWkQHBXwPRZ1bGn+lSF6dU+NPJyx3Uqts3H5TwsLSj3xaNa7TKfssvs
	JFUDOphSU7IjOkQ7P6z3yrlfBXKMrvptzraet3/AZhZUnTUe4gJfA+Y07FicVNHC
	ynfX3Wv74YLFx/eRbsP7CY9i+Td5C1BLNAwPt3xTQXBsAVraEqEJfhyN7mPjduFS
	/+p71VxoE0i3i8pIk3pEO7NSlOj6ZdHu5dDfZG5xa/ha9RoBS9GDaMJckdaTo1aS
	cFOuK2vizQHl0DwEWCiA5O1fhtJPJHRQ1qq+Cw1P8kRgJw==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 488c9crpc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:06:22 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrPckbPDlNzrHoVB12LfPhPPIS9ftXMg+3M7eqK7QKsc7fzOfTIls1XGxiJ8oZyZEyJSjwAXYBqn1rWSOe6E8S+3EYl2Q0VZK+93jQtMWsoXc0yf1ZroRS57gho0/PLkfm4hIn7EaJmj3QtvLoBScHNr6LlGWM8odltTqDrDJowIMxN60kaaxmF/6urHTQlWvKL71LjKm8MmiGwL+S2cUzDqAgPO9c1EIhPzaLxKVNIdG61QEpg1aA3/n/UKfWLf1DdQQ7hPRtrEUEpX0sQ1T3HKTjA1zZVwOCRzA5A4Jqonhxm45XfAppVaJHQrtnBSe7c6N33XR+5IrJhUPxNOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWO+YvIqEgyANLBEtqSZ0BxdmlEJg3iWynkDxVTmgF4=;
 b=rXaKfStrG1zUA6S0xqS76PUMds6MLVdAZ9TjaYi2o12pu0Kt1Nkff3DKybDbZwY8i29BtnWaxcDr3ovW4q0ZsUxjbM+LlpObtzbCvRMHVGon6ktuTljLP5jJhO/h7dCRZiqZ+4MhLFJIjkBCnkO7X1ILiAThiBwS4WP8vYi7EPpe93ivQmJkEbBxDIYh4elx+XYAbsnOSlo2tXxiNJVPCFNP2qqDLZh1G7huVNKIGeE7AtuDeBlPRNn4I1vvbuIqinJ1gNJ7D0qMaDv0VlHuaD3umtbyN6VTZKBgOjkgq+Aox9Y+aaZN1JOYfDMQ2UXGcVYRt3YYi2+Nj+TNN610PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWO+YvIqEgyANLBEtqSZ0BxdmlEJg3iWynkDxVTmgF4=;
 b=C30RJfPkHWtc8ocGjUQaP8nZHx0sx3HU9UD1xTdODFbI9NMaug085lNkvHv8UHKUMMhStNW6ZEzYtdIwMahtZ4TsFD2x/pdpT961S2aYV2B18j9xqzWB5uE8zVCETAk2ct44b2ht/OhFDTTCXN5gWzKaveQsp0bEgsGCuLPBDms=
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM (2603:10a6:b10:f1::14)
 by GVXP192MB1781.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:68::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.9; Fri, 1 Aug
 2025 12:06:19 +0000
Received: from BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5]) by BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 ([fe80::35d9:9fe3:96b3:88b5%6]) with mapi id 15.20.9009.003; Fri, 1 Aug 2025
 12:06:19 +0000
Date: Fri, 1 Aug 2025 14:06:16 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::14) To BESP192MB2977.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:b10:f1::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP192MB2977:EE_|GVXP192MB1781:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a3cd86-1519-476e-e410-08ddd0f3d2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VvvpRidx+/iWAdj67ZGFE6sKrNit5V2M4kr9/GMqb2oHBQgZdP6ask+Z+lZ?=
 =?us-ascii?Q?9VyzRw+8825LqP5tPMFRa6x6P9ciemgbiZx+OohcE0XqtEYtiiXYqKU1zINi?=
 =?us-ascii?Q?A7nBc8H8Y95aAOxRxkpBouE8UvQ1g8PqhR67ECy2+Kb4tGY0KEt9NOItbpy8?=
 =?us-ascii?Q?4jCEJ3iuUvxp/e2zUFP+wFFn6sz3gMIyELXA5zniW/3yeVL+7E18sujS3w1m?=
 =?us-ascii?Q?eoT3Z+Dca73P67266f3En6ufBWZxJDestmHZg9c8/Fn6o+dABc2JDsDSiqSU?=
 =?us-ascii?Q?xTCU5NtFKbHWZVfs38VixArF9Jz0MqZ2jRN3GeFUMoOv9B2t4PXc5qYgN9f0?=
 =?us-ascii?Q?8E2Ulap597cva3sTcBn/JdH90V52WTSL0SGoPyXXV646HGCKvga2dh0BTqVZ?=
 =?us-ascii?Q?iOfeZx1qx3M60IvkVYuw4YDuxly+ARke2lmuLEaL3Ug9W3Ae2AbuxjUewctp?=
 =?us-ascii?Q?FcBivRX3R4m2Pn1jTLAJQhtQ8EKetlO64mTJ6/Rwx2CKKE+Unm2KuiUxdtpa?=
 =?us-ascii?Q?bloWqRlw6j87BOUeJU3hw/E3YIHU886E7nG8+L60yYXOdjV5/Ekt40EdMf2L?=
 =?us-ascii?Q?rDwW1+U81euYsG5kO4enDktmhM3GnbaCUQtv6Zr26+z+p1+vXLtbiDhSWYc+?=
 =?us-ascii?Q?T4zwm3ktQloD73HuEnUkxPsNmX07/9Wf0VAX0uyNEqeq5ntal8+H8t9+2mZ+?=
 =?us-ascii?Q?T7fViNndwcb9a08fqpUm7Zrhhp8eiTjHe03UOH8okkZpKuNOn1SlgPcKIL0V?=
 =?us-ascii?Q?vcTfmTDHOfMt5JCpg0i3oisGd/ICNVbkdRhHqQNS46mesH/0wTt6EhevB5g9?=
 =?us-ascii?Q?R38paGJ+5eXWPBecuO06nLXpuQiVqfG2x1wb6zJSRgW+nRLao0zWHt+f8CHj?=
 =?us-ascii?Q?6IE96FI9R0K4VzKtiNWYIbxXfVJBWAjflBpYQHlBkFVms9DJg3MC37xiUmf6?=
 =?us-ascii?Q?CVSiHbUnfcqejW/s8mNKbfzCMz4MDF6+AepHR6DpGg+aC8hJDFtLVwGhsK5S?=
 =?us-ascii?Q?WCv9tGlk+8pEZaQPbzlzEBuQkJcK5lOUS1z233rqAchi5nngXkOEb9dtD4fj?=
 =?us-ascii?Q?EH+j29WLkCmpoivi7g6jCPQpMJgCVZo5tSbtUnOaQuIwlKVTgu/Q4l1Ekk1e?=
 =?us-ascii?Q?1R9FlRvTaDdTQ6YdtZV42bAxw9nlLGI8cAW9oAJFHZVMt7zEFZ91xDpyBJM+?=
 =?us-ascii?Q?ekZ7BX8d+OtrNyPDicIaHqPVqJA8B6mj9pnQSKwG++jh7ZCJILo3hN3CCRwM?=
 =?us-ascii?Q?ocswibbfgyC59r7bdWtR9EbSVsQYcwQtVIGcHmpruXwOhuPEUQa+7+0+QkcR?=
 =?us-ascii?Q?IcWtukOGqabDZRk2pjNmWNYhEFPtsELdb0xs9G8VuJ4LbRi5vgIcXH6MihBe?=
 =?us-ascii?Q?xw/y/FZjrJDjSJ2SGQG+we98iNoBVqh3dDBwCzpBjqh0vRHRdAffEvQQ4S5n?=
 =?us-ascii?Q?2KvtzmXB9yA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP192MB2977.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Cq+6QW91suOAsgy4l24HKG7nlKkyrGx8TrV7AnM3qiFzP/mhy3COeJIQSdq?=
 =?us-ascii?Q?OTXrqHYamDikKxcSLxzVCt+eunawZRAjU4KtsteRHzbJI6JGcQ6ej/uv6PYy?=
 =?us-ascii?Q?Y1iW+CGClY+3z6hVQnVmKzfACufw2FklhFl8kpn2fW7l4VL5pHF8pbmknvSN?=
 =?us-ascii?Q?kZRLKjvBHrXuTK0zvGcCRNHBPhsTgLYNNt6hXRESaQVo7RLc+V6aYGmZ7WGZ?=
 =?us-ascii?Q?ZCGItRqS5wGk2nDxoyMhO+baXkAuLEMCRos/FpGhPf5MVH4vHsR23WiqXdsd?=
 =?us-ascii?Q?3VSmHA+81Ys7nunphvD2N+2PIBEpAbqA36vV5eGw820ICAnpENb9oIorVkcP?=
 =?us-ascii?Q?7Bg7oo69OYBAXji/sbizJJbYlT8xs2DQ0ifpagVfth9vIUX6gyFOMqrHwPrb?=
 =?us-ascii?Q?w8gPXAw0nfCpzkkaKW5Ftr+4K27IZjYrLjWbEw7XzVoLW0s+/4hgcGgZgfcd?=
 =?us-ascii?Q?Z+d0ZCi8Vn7glF120hRwErumtDyN1AAilfoP2xpEdYCpDPjiuRocNKH/JUNo?=
 =?us-ascii?Q?F4bWQKTEY4WB9I2++L/uy/U9ofRvrgCgtXup5TIT8Mk28zgmPY2FP1LOZxgC?=
 =?us-ascii?Q?ryJDuJavJNGtiMZaT4lupHZlj7adO2jIkXIlbCbX2gKI9Uf4EOzl1PQgun/o?=
 =?us-ascii?Q?aXYgcfPwCLTt5AUipPY7go9oWtFK4ynbEFxRRb9id9dlmV4US+fia/NTsJ3L?=
 =?us-ascii?Q?FFqHrBcfFhpQx+A/s9a/XJcc+zMqSFouKhi1h7vp+u2fu6d9Z3JoABN0q5i7?=
 =?us-ascii?Q?xApTXKIph7TJatk01vK0Olq0RNAGkuac3OgO3eDZFgKd//LdRHBAm/Zd+0B2?=
 =?us-ascii?Q?b91f6OkYnrPvwoKzE3XY3LQJu54M7VikZGJFHv9jqPbMUfib2PKvQo3/hsQc?=
 =?us-ascii?Q?pvx8dnHMbLgAPgcQXq94h/wvzyFy76JVZZHVnBgTpAZ8dLz0Jy9SniD7ePY4?=
 =?us-ascii?Q?fiTddVD+jRQIE1htYcW97iELeHxL+DSCcPCPQnVmj3nRLF9R44ZMPHV+jlgr?=
 =?us-ascii?Q?lPp7OALu6HgH6rKGa0IN1/sP7P5cn6BRJPHYhf15hFnF5/8s7m2YDmayGFyG?=
 =?us-ascii?Q?2TkTrSU2X3N3Aw02TWMsc7179dK/69s7CYngYLiB7BfxDCn099gpdZK9A9n5?=
 =?us-ascii?Q?rrj+Ta7SmFdOSgLj+V0jeobXq3/xcnHnea+peGX9WqvX+00U9yeVDhfNl7Fm?=
 =?us-ascii?Q?ynVHCF6s2uod/Jd1EEtIKOGKLqWqKBDLYApeUEsasG07fCvif06uaxoFaIeF?=
 =?us-ascii?Q?xY3pfTPBhezCZ0xbKJc5QXPXuLWo33woD2LQMggNuxIShNytAaWKzIXFDqvz?=
 =?us-ascii?Q?MEwit6KpcVn3agq2Nm0uIyJyq1LVEdHIynlJVYsYZKl3Z2GJBq5IyCJuUUM0?=
 =?us-ascii?Q?BcPMYvwSb5be0YZ3BCBQF5ct5H3Msy3UePr69LXQX+FcQVm4E7wvuzj1wz9T?=
 =?us-ascii?Q?4IqgEt/MYzJ2FsO6+ezPbnIBOt/7BatoJwr3E0rO8BXAK0dr05RqW4Yv5Wi8?=
 =?us-ascii?Q?R2iXxzl+1zNQG0fiekh1p2mZouFQFUBAvLNhO9nh51pGoibJGycNUmpO7b3t?=
 =?us-ascii?Q?a1TBiRzmHZacpwBv/Y8GrIKh1y6TyQeiGLATlhWG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	adtKspSHCGYHo568zwSfOheosrC3dtc0p9Ga3IQ6/cG0NlFGZdfipujOIniX5orRs06cs+pOtnGJWGS6sHkJKBqNRHABK0a5lCHMAJr8H3ygzR4gRgFq16GgylNnX/vDt9w2APMKtuOxn8jDEQEbGTSMY/wUZzNDtV5eLJoOnmI1rHx2Gm4HNciKoYFJ/XpaTpI1+rk1KYegSlTh89CzGg1FrCpwkIYlwQe8kV8Qddl4PuRAQkkRolJ9NdtdOKod+3kLgWcoF/yEX+6NORcF2sDU3RefRyR2BPZtAea12h+Hn6PGh+hjXc/jNkC7FyYDMQH/Hx8GmgmQLwPT2EI837x4R4fDMvjXSWFP4sgUnxZXHn38TV+/0Eqmfqehvl2avZRfSf68h0rXqVgzUOwcm/+hZz1BibYr1orM5JsGx/pau1gjNVEMYbNiKuJE1JVqV4c7pIO0wAhUWkdkdL9M6jMfae3Y0pSjgvUA0wuXXb2kOgQSED0Amo2UAh+yjmx9d3JKk8iCwcrEB07Gn+7b4eb/m4i3y5mb3zBWYdgFkxUTTz4h7ZVZ4Ud7LYKU3Fs+FR4q2LQMi4zIWEIu2/jrMwyN0GT1r+EEsaaJ2jKYHoLD/wCcuWILaCIkEkHDux70
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a3cd86-1519-476e-e410-08ddd0f3d2fc
X-MS-Exchange-CrossTenant-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:06:19.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmGt5mdiMkPd+BceybgMBADzYD4duFo5iENp4vOhlSB7l5QDCZxwQhNpaoAyuahXp5Ms1hQEee6ARQECJa29Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1781
X-MS-Exchange-CrossPremises-AuthSource: BESP192MB2977.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GVXP192MB1781.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: OkKgKVLjj8qlLRikxIOG4WJ0gNvlrI92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA5MCBTYWx0ZWRfXyUN6rf/Cbww1
 GAaBrHlHarpRNx7vI+crABLaDwpRvOQURLs6DXSZkaqVKhn8LVigea72fVXTMa6S3cs6VgPmwxw
 AgsOmIWrKk/nQIfQG3K24Kgtbeg74HYFQ+K6v2gcT2z5IpPDTYAFB50cBNC4OA6bt+dRGssVWtA
 cEc0CHaW4dE5qnMqbvj/5r1hv+P0RCIvUvL89Wq+fEbppfVDPDTcWOhzR7k/TGcO1vEx10+ghBv
 +vvB0cfmLfsDHa/bPtBI8KsD4M5sea+L9jW+2E76BLmYyDxL0yWwA5Otgcr1dsFOuYmdCGFkxxm
 JTtRFfU7QWliiUKtZ1vstNOEG6bkhYQOYn6aHqSSDFi7VsntyIbuC62uXet/Y4=
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=688cadbe cx=c_pps
 a=xx55tk8hyb47AkJjldnMnA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=G9Su_PKzgMt-2-K_yNIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: OkKgKVLjj8qlLRikxIOG4WJ0gNvlrI92

Am Fri, Aug 01, 2025 at 12:58:23PM +0100 schrieb Russell King (Oracle):
> On Fri, Aug 01, 2025 at 01:54:29PM +0200, Alexander Wilhelm wrote:
> > Am Fri, Aug 01, 2025 at 02:01:06PM +0300 schrieb Vladimir Oltean:
> > > On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> > > > and this works. So... we could actually reconfigure the PHY independent
> > > > of what was programmed into the firmware.
> > > 
> > > It does work indeed, the trouble will be adding this code to the common
> > > mainline kernel driver and then watching various boards break after their
> > > known-good firmware provisioning was overwritten, from a source of unknown
> > > applicability to their system.
> > 
> > You're right. I've now selected a firmware that uses a different provisioning
> > table, which already configures the PHY for 2500BASE-X with Flow Control.
> > According to the documentation, it should support all modes: 10M, 100M, 1G, and
> > 2.5G.
> > 
> > It seems the issue lies with the MAC, as it doesn't appear to handle the
> > configured PHY_INTERFACE_MODE_2500BASEX correctly. I'm currently investigating
> > this further.
> 
> Which MAC driver, and is it using phylink?

If I understand it correclty, then yes. It is an Freescale FMAN driver that is
called through phylink callbacks like the following:

    static const struct phylink_mac_ops memac_mac_ops = {
            .validate = memac_validate,
            .mac_select_pcs = memac_select_pcs,
            .mac_prepare = memac_prepare,
            .mac_config = memac_mac_config,
            .mac_link_up = memac_link_up,
            .mac_link_down = memac_link_down,
    };


Best regards
Alexander Wilhelm

