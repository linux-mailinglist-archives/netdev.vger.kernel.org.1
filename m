Return-Path: <netdev+bounces-283060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO/LG3f/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A614A98C8
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68CEB30727FC
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D842DEA89;
	Fri,  1 May 2026 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPij8ARO"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80392DB798;
	Fri,  1 May 2026 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598186; cv=fail; b=heXQojtzdlx/fLse5FV2NSCaRuZ8ofeXIqIJ0gH5u3N2hNryM2Vej/fU4lzTCSpgv3+JILtZPFlC7q7r46CsDtZWqo8NB5zx96I/nctm5KqvgqcKoeQrTP31OyWFNbFGLY8xEwTgXrxAx+DZtjDAYJpf3PnwXQDQXg72CGnHdUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598186; c=relaxed/simple;
	bh=61gScocZPUo9b67w59nQD7HckavXtffCAlXEfjMHJL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUlWcfzlgK4ONRdXAK28CUixpZeRv5sORQ7LedpTnKkZ/9CUWMt3qcrLa2MobnWTnwl/FqYiwOxRUX5Vjcx5r72Q6XZA8oYB/3FWpacJs+voDmrL+L0k4AFsDieZxa5Bjzzdp4KPL2yGT1dnuoHwOHTfqEgEXmQs0Ej8wUj6q9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KPij8ARO; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/py2EXaltjscaqQGEf0kc0PDKnGqiXosoBasXd3QJvu09beuRi1kfrZ0Rbx9BYW+uYd33WqQjLaQ6wuhh+JLNLzbwSh4XtxFsFk8isOajm4X0juFwERihliTdwVzV9dXpiMphBbiQBzOeKzsnapad7j2UX8pUs1Q6Sjvnl1K5t/g7uhwESo+Zc72h4ppvvAOaPZ7CSaOnDYUw0RfbfI4jVGOj/HkFoadEDHucwU85rR4rg1M/7Z4dcOG8t/Ry8cFWQSToIE7fHSqVAreNx2N9ThaEajiEJh4244vxPmesiwi0D8cG8g0gBOMYgT6zejLW8VFr6BnjlVboO+zX4SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAd3BehVcy4Py0TS/4q35/P4IWy+4uJA2w0e9WU2hz8=;
 b=hx0+a+xqG0m/TFlZNmd6cZ8WWUz89L3KfT31TXVz2cgFDKAuMGlKa8HKg0bJRz2EtOBF5tGgGvdkbkiCti3rykS0Y67RiCYaWjN+tzTxldRZKwBfOauZ4IlEsjHe4uBOt/3aEA+vMDALHMzUE6UyvRsIK0OZaG5ajz+wj0zTlx4OrdkXyoRNOEmB7Rqe2tSNyk09GBGxFkkkeRbmGrOfVRaz7Q/uOOAEYnq1EO+6W2GEaFtETlVtKqd0n1n/SEZYEB30RfdCkcbXRW8Ql6HM8gE98qeVkjA+tk0CQ1p5nhyS4xYEq5h2FXAdPtZdXZ4CgocJX0h8uip4zO17Fd4mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAd3BehVcy4Py0TS/4q35/P4IWy+4uJA2w0e9WU2hz8=;
 b=KPij8AROFUcbDYp1SuOQWzri31KshrKDyVNa+C2jJ0KbWwES1b3IpvLvdYmnS92wsr2TKkG8mcMVopwmrsWbp24tJ3T5un316cdaB5yIF/A/4z8wWVCpNoo0sD6g/+lr9R1k6Vg2yVmEP25yrc2N09hd7QgpRzGifxncFpCU07irqNxIRC1l7YkwsCbtS//r3JsYy76VorzB0ujHn71JXNW8wxsZpLbd/lskApqYqs24yqLVGpCqXYUaH+yLH5HJ1ORpx7i0auovIonup6Fbvk66aKVzDQl1H7NVSbgpkmpWbmBzWh0VuQls39P7ps2VrJ8NC+GeIm+Z+0GEPvD9Kw==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB10557.eurprd04.prod.outlook.com (2603:10a6:150:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 01:16:19 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 01:16:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net] net: enetc: fix VSI mailbox timeout handling and
 DMA lifecycle
Thread-Topic: [PATCH v3 net] net: enetc: fix VSI mailbox timeout handling and
 DMA lifecycle
Thread-Index: AQHc17CRGSmZt98tIEKQV5KOjIkWQ7X32MwAgACHMuA=
Date: Fri, 1 May 2026 01:16:19 +0000
Message-ID:
 <DBBPR04MB7500C307D75153F1BF27406B88322@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260429081930.3259824-1-wei.fang@nxp.com>
 <20260430170922.1729686-1-horms@kernel.org>
In-Reply-To: <20260430170922.1729686-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|GV1PR04MB10557:EE_
x-ms-office365-filtering-correlation-id: 195ea9c2-0c2e-4a01-259b-08dea71f404f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 /uM+pt+QgKbSvYariiE+jFXu4UarKDtca8vDJ+u586ENE0C7kRVgi7uSi1di2T+fO9GmpCLCejME6P+szGO3XYHC+tHQ4B5hPBetzAIqQVUDcMjUniAsRDbtWy/eXc+JanhaY0T9LslMBJ3trSWqSYc+c08J7tPth5P3ZjTU91P9SkbbTxBvwhBdXeJSVuGzIpc7pZkXhLprCkc4bIwtcI6/gEKrRQfkjwy63V8XG7TiuJQgheQd3rlkRyc+4Q4WW3HQSIUrwE07qx1/U6mUa5RVtSN5ox5SJUcRQSPFn5U2ua/Kww6e6RwggTgXj9Rode6zCS1zXqD90JVwWW/H1N6SBMhmMNT2zDuuqmIMPIYGfN8FUgACjhc9g55LxRgUTlRiCP5zmcAgtuF1qX4mg/IetFyIcE287TWzH/f/sXAjHOA0rTvKRb1qirsGXDRjPlRK6i7ffcawqiApNfBqWudQSQ3WkwqzGUQfIfB+d1655XutFf2Kw7CrkYRcKvp2MGu94wee3GRZYUaYsX/qjpXaH3g7w9pYOlnJmy4zgOloa+25xa0bq8UBvnlYS9XnOIM6LLfd8vLf3YN7usU2oH8tsvHETph5ctJe438sSD95FpI3wRXxdYuBsSa4ubZBpYRjpl7z4kNyM6pQC8wSC02N6A4FRTvbNSAYLFx1Lzu4un80Tu7Aki0tMZ3Tto9RzkQwW0FE3QGS5cbxc2GPhz5JchGofsfgL04ZLdD1JKniemi762YSUJ/1NW9qedWi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r/hr4bOHWeL8fv7X/9cMUr66SqW5NiGrfK5zgxTefZhq50ZebMiisKs+eE0A?=
 =?us-ascii?Q?dp91aZKHfEz16W6E7tIVIY/Xjc0xHbZT/kOD2rTnQEsCrLHURWx0Hmc50WXU?=
 =?us-ascii?Q?dxusEboLnCSO3JeozNxyHSz8zgqfqeeRSmvp7IIHFbn6nQ5SXQ89JRhi6maG?=
 =?us-ascii?Q?giMtFEzA8GgKCf0A3f9JWkjaYpgOX/VxcJaK8QmKzjxLVopyPXav3hzO2QM5?=
 =?us-ascii?Q?Y59leylhoHUCr/QEu7pyH+qafoucAm45s6UkWiNZ64YeDpdjBePqsfIS6dWC?=
 =?us-ascii?Q?cjeSPTK4iUJtyK2VruQdd6v5M1xVPzHvMqzm1G3uoSh77srKnW49ioLN5CUl?=
 =?us-ascii?Q?shcrzBgItKlTR3vaZf/tAv1OXmwyfvCh4uwHtSZvnJc1PgTcEbYPrIi9fTEm?=
 =?us-ascii?Q?NSBEIK/JEzuaK85h6YnCPq+HZNWL+qIU9YrGYyRZJXrRBqo7LBS8rOEZPACf?=
 =?us-ascii?Q?EbG99mggy1zMYtFyMr/DE0eMI08g7PX6BcBdLqQjCgxndpN9tq+8SqPRnjhE?=
 =?us-ascii?Q?U9cj9FuN1zwLxanURmuuY7BTisNnot25taupdVy/F/vv5dcGrEpczCdX51W4?=
 =?us-ascii?Q?iaemTuIBEIxTYC+Ut8N6OWHITysc03zfaeZDiQr6xREmwZWC59AHJTlOLv2u?=
 =?us-ascii?Q?IGTktXisX5gJQaqh3Fqt32TDDQ1VQrAgDDGq5EO9HfZlbrd3GFe7noPHGwe5?=
 =?us-ascii?Q?KprUXCE9cbaQLMkFgCjEMO/PpGOMnOizaUZ5eprIuNbjV98jhZpisse3vL8c?=
 =?us-ascii?Q?w4Ky5ynA4PDe3MzWReb2vbqfGX1IihfPQQxjWtNoZG6Thzjqr3uaLqHd6avS?=
 =?us-ascii?Q?ZRWVktbONlyJwiIENBc36JKE8EQOy3vVdKEh3PfnT2eaXDlzNcDs3M6/z2s9?=
 =?us-ascii?Q?fcFlIURT3zu9N7SQBkwD2/xztL8ZzzOHQyLgjkVONeFUeXXuIRLdeEZHic/7?=
 =?us-ascii?Q?eQcsK+Y8nDXi/ipli4DmxAcaegWZNPr3b/QAqDRsu4z1pizYisgyo06Fx79C?=
 =?us-ascii?Q?MnbseJ5ZvphuHrQ3EowOsJDYU9DOX3MHOhIUzWgkPDuKVB7Ed9xBAJUpL09D?=
 =?us-ascii?Q?SP+mCHKhMTuIhqpQ0sycqSjEy4mPJw3U8hPmw2Qi9AmuZfHfMQyRzCnyY28Y?=
 =?us-ascii?Q?ILj9a11JyXBkcMj2TInKMgmYBnx1J6NOzy8JBcmIqGl8M9MUJSSWiqJd+VlV?=
 =?us-ascii?Q?r1uWEPnwns5XT27S0q0WwKxeKRxKMmVZ/45T1W6CFV5cxDF6RdedrtnS2CMD?=
 =?us-ascii?Q?kMox/Du4AW5EqpETsYr2bE7IpPcYOdDgfgV23Ca3EaxNU0hzwIGB1yy78bPZ?=
 =?us-ascii?Q?WtN5hIYjsQaeD2nDJ0byek2Xkv4OBSZZfUe5a+FJWwWtQehFo7NJR8M9a7EN?=
 =?us-ascii?Q?AW7wwWBsZ72VXGERoIWanZcg470fD0Z6Qt2q5CafUE5tT8/vdi8S/kbS923V?=
 =?us-ascii?Q?fLlSqIiXyt2jXEf3N/cLYoJjByquCg/ngbvYgb97qUHRFTVM3GBlC164RmxR?=
 =?us-ascii?Q?MWkVkq2WvSzzgxsTYR31a87kdgEcF2+MtGNBZvrSjnf5YfHjPkuHxWKhYnQI?=
 =?us-ascii?Q?QrnwWxF5vAq9MnZ+v/a3x839v77CoYw+g1zaNZq69VtJfYuDRkYCotCDP0Rx?=
 =?us-ascii?Q?hJ+zqCD7ufIkISv+qwvnQgCBuuV2mAj6huv44Oi4LPyf6j/r2PhRvz/XaoYa?=
 =?us-ascii?Q?9/+SUy1Bz1eCdfQKz+cNJiClh0rsRRow3fi6UzGkEepacjje?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ea9c2-0c2e-4a01-259b-08dea71f404f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 01:16:19.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rr0zdUdxK/jyMdMvYR4MYqDn0tbW4Rz2qni1YNwZthke1QljlX+LvC7Jzy0r6PXmDlLPkIy2IbsRm3H5CWT3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10557
X-Rspamd-Queue-Id: 00A614A98C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283060-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DBBPR04MB7500.eurprd04.prod.outlook.com:mid,nxp.com:dkim]

> > @@ -259,6 +282,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
> > {
> >  	struct enetc_si *si =3D pci_get_drvdata(pdev);
> >  	struct enetc_ndev_priv *priv;
> > +	struct enetc_msg_swbd msg;
> >
> >  	priv =3D netdev_priv(si->ndev);
> >  	unregister_netdev(si->ndev);
> > @@ -270,7 +294,9 @@ static void enetc_vf_remove(struct pci_dev *pdev)
> >
> >  	free_netdev(si->ndev);
> >
> > +	msg =3D si->msg;
> >  	enetc_pci_remove(pdev);
> > +	enetc_msg_dma_free(&pdev->dev, &msg);
>=20
> Is it possible for the mailbox to still be busy here?
>=20
> The commit addresses the use-after-free in the send path by checking the
> mailbox busy status before freeing the previous buffer. However, during d=
river
> teardown, enetc_msg_dma_free() is called unconditionally.
>=20
> If a prior message sent via enetc_msg_vsi_send() times out and the hardwa=
re is
> still accessing the buffer, and then the driver is unbound, could this ca=
use the
> hardware to read from freed DMA memory?
>=20
> Should the teardown path wait for the mailbox to become idle or ensure th=
e
> hardware is safely reset before freeing the buffer?
>=20

enetc_msg_dma_free() is called after enetc_pci_remove(), enetc_pci_remove()
will disable the device, so it is safe to free the buffer.


