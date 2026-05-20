Return-Path: <netdev+bounces-289694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK03AaMRDWoOtAUAu9opvQ
	(envelope-from <netdev+bounces-289694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:42:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D745869B5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F255301FA69
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBF2E8DEB;
	Wed, 20 May 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b4OSmVWQ"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DE28980F;
	Wed, 20 May 2026 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241375; cv=fail; b=BAp60NhimKju4uH7fDj73qAjg64td989pJ0X/BCvNhgsIe8e2oZu1sMS2v9WtMLLPfzLAbMbPErO7CB3zKumJN1ZY7R+ueU8LCa2Mw4iIPvwT6OTjKlFDjK752tv4hJ4yp05UUeM4LVDm9Fo2lt5wYHaUgwaFnCoYNC7Gvb7Uds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241375; c=relaxed/simple;
	bh=pC0PM+g2Yz+i4vpMdSbPm/cYlHSD4FmTX2MaelJrVY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWf8cGrooy2dCLS9h+e2D+++U2L5i7oZyW4qxUm60AnY8+7altCnQuflfMcXKGUC94OhUE3eNdzXui/HwpblWn1f/X2p1r/xYX1WFYWKjbL6xBm3Hxpc/+SqmbbHhpEGj5nuy8sEpOKteIpVDwuMKC1PadjZcn5egixIXtgfBM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b4OSmVWQ; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAIdLQODHnDlqsfOcqr4zcaGUZfTuMEBmRTjhlekwePvxJ5Hsh+XdHakKUO5fN8XAcN1E5b6pwkHK/rkPaFTu8C5x41ZBxaXT8r47xOnAOkN1T5iewi/6hzqRmu7dJvIkez/v2KvYTZNhU73/J5Eu9HE3yn1Ej5jlLqjr2Ku4XbpRLiTU3PKmHAx++LP+4zItOHeVnY+Y68M+EhMeEg9VG7A4I6+txAtkY/7H+/R9I0TOPcNrWZpKKS65pTfWM+/rQDmYR2lD1/7YxsIaZBSErEwSa9/8axUQA8osWcczxyPoI+Rx1FKyMn7yfrMI089F/xiknyV1K7ISwLczmsHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCXtAXeIbrQ8mvQXjNtb7mF3i24Xd3SKjWHpVtsf4QE=;
 b=F5tuyMUVVomKs32TEXtMhHNcoN/A04a9RQ2acu7slAf959Sew/ILaCmSkprOoX4rsxiDRshzy55JwcEEJkpLGMYVAas8wPyz5h/yiZK24nv5JF8lP7EFIrXXQN1TpmOjaR+qcAh9odf83vlRLmi6OA+dDQ1U91zQS+J7ocRvwFGKGTf2tR8qwjiGmGyp/RSO4rfMsjd0Z5Hhuj1A6SixdIGvQuXq1JOShyARf/SUwplNFylcRGfxIuXDax/FEc6b1/L61ih64hBQUwwSiMqD0kc7yI6k/voCS5YtdXUUukhey8vWUBqhBLQkWpFbkN21hmjZwAdBvtFrpLMEfmz9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCXtAXeIbrQ8mvQXjNtb7mF3i24Xd3SKjWHpVtsf4QE=;
 b=b4OSmVWQy+m6V4rmf74uuJv2NWnWpxExJWGLCQhXL/Q8expfPvbgGWwgLUzEnyKkNJPlqg63CNKyQn1QarotgcTaoKjGuh+pnJyORTpsX+sY0jxwEBElkwHjF8UobgQgEMSC0hOWpNugM6NcgjxEPJCkLc/kfPuBJKYvSdwarzCmSbpuU1QgEjByYk3DnnhSRY+/sMu+ITiKUo17Ktf17Lzyllq2vdb5FC8f415aYaZvMhl5MaNnxcl3vVFEiLE4aw4GqIPwtMOnbzzYKzCwoJ9MHlyQxhfxRNxSq7SEB7asNGRYrLgtqFVSkJzJcyz4cBkxm/jps/GS6KXz8+tQ/Q==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM0PR04MB12050.eurprd04.prod.outlook.com (2603:10a6:20b:73e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 01:42:51 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 01:42:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.horghidan@nxp.com"
	<catalin.horghidan@nxp.com>
Subject: RE: [PATCH v2 net 8/9] net: enetc: fix initialization order to
 prevent use of uninitialized resources
Thread-Topic: [PATCH v2 net 8/9] net: enetc: fix initialization order to
 prevent use of uninitialized resources
Thread-Index: AQHc5nLpmOljOwZT/06dP/xS4Sj/2bYVmU4AgACM5AA=
Date: Wed, 20 May 2026 01:42:50 +0000
Message-ID:
 <DBBPR04MB750048752B9378DF2B6BD94C88012@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
 <20260518030535.1057228-9-wei.fang@nxp.com>
 <CAEAWyHfk7y691oYNmYy5W8dA8cnpwG4ejnXPssMLOUO+Ljo24g@mail.gmail.com>
In-Reply-To:
 <CAEAWyHfk7y691oYNmYy5W8dA8cnpwG4ejnXPssMLOUO+Ljo24g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM0PR04MB12050:EE_
x-ms-office365-filtering-correlation-id: f207c55a-a770-4732-1007-08deb6111a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021|11063799006|22082099003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info:
 5mWv0haOEiict3IrZaToSpKpa2Yf2lARAdkRruwAJglHEmZuZg+RRe+IBqV92cCXCxfGtrZraa62zNz6HUPYg8eztZDrpItHmlJK7tVXPC19OQgDabxAn3uP5bUEg2RHp+HTVmff5Z2xMkNAZ3NsIpthH24YjbTWbbIvthOsLdtJgIESfNI4M6y/WOliICH/YCqF0qZQQy6H8XFRJ4l44Uul0Yrnrwbsy97xneIHPpzmBfoMjfsNDgjZQ9J1Atlrk+UGYDQGWINpcmAVGq1d4RkQGqfGLOIC/ccz+DKVVbk9/O6qDKbLjijNNrQuJQI1Cq0k8Ve1U7g6Fzwkd9eU3hrdLQcdTb/hL/LRUpFt0c/RO23/QWn1tU05H9OD/CPKHGMUYaovKhblgBD3NbH6onIyLc+sgQ0qrYWxpkSZDPg3ATjKc/SwTLAANaD8vj7eWZlLHOFzaE/3t+PWqNr7NPq++clZNymROMjGmOmvJ7pyjueFPNd+Uktg949nL7tkEzkRsOJBGo1uELiaPq6XbdCCbp7+PrjpjOB+DiX3otS2bN2XBudWREG5ymtXzMzAKvyK/K6uGbX/1ZSTrjz8jXa4v7Vo2IMy5S6DRLi/wqQVkFMpcZ/8UBYOqMyTatO1z4RLi5MUNFN0eFNifXTpX8bX6RiHNx6QPk5d1W0SKHSPVTr6ku2QkV9RHf+xXMej601NDY7rPNa+TSjdg9NmHk35XFv7Pa2PpjJEFtQbiYI+26j2vBb56b49RcuLRYbn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sn1RmD0moNTNPWTUCCaf7k+ntX7JRUYhCvToqffd3dnAot67lzD2YxyAQfj4?=
 =?us-ascii?Q?JgLKbavxXAN/sg8xEymsKdW1oB4x64Hydvrj7ir/jKAHyvNNPGI7zt0jNk8y?=
 =?us-ascii?Q?91FHippif+RGw6OVq76UfLvYpBM0Ssp6yyCUGB2tDsFx5l0MFWev0CoxZSsg?=
 =?us-ascii?Q?q2SwXqkYx3rZ2TCjhX0Lujr7SFihz57jHMVgddW0P9rdjXH4k8z+a4OyIAJS?=
 =?us-ascii?Q?M4NN3S7fjM+f519YRvxWFK77ZzTWtwQvS7RXhLqRfg6sIod2e2vOPKg5Yh1i?=
 =?us-ascii?Q?G9XTK/kewjYqpumcBqlh2CmChBMjyF6xH+IZml86W6LJtmf2UVCMVWerT2Yo?=
 =?us-ascii?Q?HOIYugVpaSMXIArbEMXUkDpi+KEImNbsqL1zoB3Y52w+rzKRF51UIC/UtSvT?=
 =?us-ascii?Q?Vv0JF5cQGQIzDKGh/hi8loHsJJBTStzhNUMHXMgcKp6izBLOKN5y6pitlVEc?=
 =?us-ascii?Q?TWMy2aJK0+OzSPGlOLt65C4Yun1+HkploxeLmuX1e7DzKYhkpBS6Ia875JHP?=
 =?us-ascii?Q?VQiItlgbs93ry/bK6wyqpSaOVFmgmtVNksQfe2nU1YmC5xzBknhLmfqLXN71?=
 =?us-ascii?Q?1aJbpl+VpiVr1mdeceiShuWYNe/ciD1pzfPynmajgY+jV1D8NrZFbr3c7IAJ?=
 =?us-ascii?Q?Rm40blMLC2F5w6ZmNoz6F1/klH2wgk8mVqXayWQvUg8SI+ej+uKzgtKAMknl?=
 =?us-ascii?Q?vI1GLcMyNgQtD4bg/AjOkKRIMoyMEyGw8FBsU97m/PGXKf/sY59yAlf13Tz8?=
 =?us-ascii?Q?c9m7yAdhHsrwSpFwp5tUzlPMq+0hGeky+kUny32XE5XAiwEfL4/u9Vxjom+M?=
 =?us-ascii?Q?QrjPkLXe4VIuUM9ZPpSRVlOu7gBhrXDIEk1S6NKdUV9L5tIs4r09TvARE8EK?=
 =?us-ascii?Q?ixqtzZktAyQ4tt37hJnv8tFOGnCDjuUtGzAgN9g3HSgFMIPZLO0ca4EVZ6W9?=
 =?us-ascii?Q?t2C7n679rXhH4fhHZS6I9LMARQzG+83BpzZW7IHpMx65k2XshLIsLsmOCQ3Q?=
 =?us-ascii?Q?vnF8P525u7Abi/LbN1F+FIF+dBJltS41AKneq0w8Kng1CX39P8Y6pkRmwnGl?=
 =?us-ascii?Q?XylIawhWSo0ypqM+1yqC9MbSVS6dpCubzc/J30Iyldiz/9Yd/p5sl7w6a6MU?=
 =?us-ascii?Q?2UU9NfylaA0Qr4sM45JmWeHdF9KAXHgu9vFKO7V7T+2yWfacAf7z+eeVFdlg?=
 =?us-ascii?Q?6wxHdZH3RTDVP/gldi4OKFl7Gl/s6jDZSc0OKdhtjGuaCfVVfYzhVF5oFV/n?=
 =?us-ascii?Q?wUTgBo+NtN4lJ74+/wW2FHYX1To6V9toQof3bJPEhalO9YwBjBlu+vJCO8Rj?=
 =?us-ascii?Q?eIJqE18cGW0t8DSH2fg/T8bgiv0es4OAGFMSxZa3DPhlpdpqwPXV0hM5Lm88?=
 =?us-ascii?Q?U/JsVUN7MHi+21BWBFKS6PizAtbDRlQp3109H/gou9CPtGlzNLpwKuAL17sp?=
 =?us-ascii?Q?MJwLniNetrgs/oLNujVJNw++t1ScRW8qnVRVPKU9DVmJf85Ije9TUTDWsM/+?=
 =?us-ascii?Q?ibwxA5wmWzxsjDkMnhrnrUEr7AgbQPrYwlyJvjVudiG4z9Y1LpBT7bDxQAf/?=
 =?us-ascii?Q?v5PMxdsDD9JGjKjQ70mjEbZCieUcRHTDtCg1sOfpSAoAZAQC93Q5vzoNftti?=
 =?us-ascii?Q?pxjoM1l6RaeZcxblljOitjbjCxnavrTG7I+xK3mt3Zdznk3jgDQ5mvrsc+lo?=
 =?us-ascii?Q?S5RCVHh1e0ANJczjgh6VjvbKzqOD0qbWZ3t0Chz9guF084D/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f207c55a-a770-4732-1007-08deb6111a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 01:42:50.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ly2qyJsw2Ln2c49bopa0Tt1k0nDfguM9dArirys8lsjU0TAwbCPlZSGgng26JeG0aOqVzpc3NqxYkh0BAJ00yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12050
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289694-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Queue-Id: 59D745869B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @@ -151,14 +149,17 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
> >         struct enetc_si *si =3D pf->si;
> >         int i;
> >
> > +       /* disable MR interrupts */
> > +       enetc_msg_disable_mr_int(&si->hw);
> > +
> > +       /* de-register message passing interrupt handler */
> > +       free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
> > +
> >         cancel_work_sync(&pf->msg_task);
> >
> > -       /* disable MR interrupts */
> > +       /* MR interrupts may be re-enabled by workqueue */
> >         enetc_msg_disable_mr_int(&si->hw);
> >
> >         for (i =3D 0; i < pf->num_vfs; i++)
> >                 enetc_msg_free_mbx(si, i);
> > -
> > -       /* de-register message passing interrupt handler */
> > -       free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
>=20
> Code looks good to me but a nit: would be good if the change here in
> enetc_msg_psi_free() is also called out in the commit message.

Thanks, I will update the commit message.

--
pw-bot: cr

