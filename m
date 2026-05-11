Return-Path: <netdev+bounces-286424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENT8KFE9AWqcSQEAu9opvQ
	(envelope-from <netdev+bounces-286424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B23507294
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 04:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 178F23006F1E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D725FA29;
	Mon, 11 May 2026 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmCevei+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B7E573;
	Mon, 11 May 2026 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466125; cv=fail; b=NCDvJjjyA6czznPir73NwmdwB18xhVt6zQI21jAyYBKF//sLYya9puD7q+FCRFiGYE9fCJ3rloEw31X4VlwzeenJ1jEVyN7l25qznfCbhsB6AX6xiLeKtj2mF4As5mRNfMosrJAdZJI5Dbr76sHSQyCZiLFAi0rUnw4lWDsnMtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466125; c=relaxed/simple;
	bh=vyQDkI5xSVjRBHYFmDwtSVyiLGgDEBzfjyCFd+2QiRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fojmyJGLxo34SIZXeEewUf5pkXJTQTxt0WWkzX4PwrSKvLoxomkJ0XjX7UFYE3hmq+sbc+ydj90rhe9tkulIeGn6ockO/ibP9xmCOKCWd3lK2E2OaB7OG4Dyr3ZQywHmszdF9LjU2xPCikSqetOXL0vOrzwL759yRqd9SVwKTjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmCevei+; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLi6TrlmNjDSsbs/Eg5A+UchWEACsDhHstg5H6LptN3DbbrCeabGaElgWNVLwDqnbV+YRjtkhWhnlAZ0kdSdnMW6zkTipuABz9SsQFvaIg4UuJbnQeoBeDZmpFhH+sL0vdJVvacNkgPGhWXmlWLGFuzdYkGnfJuO5CT0x+FJFjGATkGay1RdG9tITAe1/YE70ma6jQojw0Hhax4sGFsfzRRYcDQ8fME6NRnLRrVpBEE8ji3goLLVi+inINYN1ReJGHukNXnJ1CobSaJ1d8XUZvmNfrFmShnO5eDMWzYg6N+T2ZxQ3xAJa0g6jJLtThS4qJeaZ+vBDN3ygLX+pqhYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaLCmDK2jHthFvTZwqN4aKTA1TOMs7yiZieu+sX7Ivs=;
 b=LsdO513s6IiDtjeSzfkee4oUrTHeYyg6302pw+gjMuS1uB1iq7jUzb4O3YnDmVFVNXcfuDVINNYhoLf/ZlLx5OJF/Y75HQjmUr3pS4awr46i0+eS8yQELF1hcHaR3BcUqe8fWK/b75tRVvEFtnbUCkGhhWMLEQtJjh3CSJm6D29LAJH6tMAuzA3r+hNNPss4YyFKWKVdayQ9SBB5kZsPNCkW/xf++Q8byexG8RF1CKPQ1qAcDiPMPPidX9D4jUvQ1IiJvqstCLD3cXJoVPyPOBcdGz7b/jJKuWg5kcvGM9ylWePd+pseSiQA9Bs8MN8rV/A3/YIxVVJ74S5WOvo0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaLCmDK2jHthFvTZwqN4aKTA1TOMs7yiZieu+sX7Ivs=;
 b=MmCevei+n1hepEv+FjNTaTxzw/r3oI5ba2CdceU2HmyL8GZWtFkPIKczm9n7FvDGoaFs16t9vpk6r+mQLCLnRuRGkvWrrepwtQDlQklqLPWiQ0J05IQ688aPzHE/lfHVsrEaENi8eZAdosxxQ94mIFWicYpNM8vsFrK1vBoF8n8rk6jUE+gFzxlaccsSiuqNOyNQDp0zJgGWWvREBNU870ubsqO3JnGEeOk5iqnQcgsXG+qQ7aTSUAnGsAUqpar3N7ZYtlqZZVi/3gv1F57Ki+IkIadJi0pVI5XCuJgYmLONGLtTmRKHWv6xKtDY39QaXHd6VzcuEAsMhXZ+Oh1cEQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 02:22:01 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 02:22:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "robh@kernel.org"
	<robh@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 06/15] net: enetc: add support for the
 "Update" operation to buffer pool table
Thread-Topic: [PATCH v6 net-next 06/15] net: enetc: add support for the
 "Update" operation to buffer pool table
Thread-Index: AQHc356QOmzuSm991Uy4YWZhyqKJfbYHFdkAgAD8S+CAAAh3gA==
Date: Mon, 11 May 2026 02:22:01 +0000
Message-ID:
 <DBBPR04MB7500D3E90AF38CE5BF20A5D688382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-7-wei.fang@nxp.com>
 <20260510104833.5F0AEC2BCB8@smtp.kernel.org>
 <DBBPR04MB7500D614C25B584703C43BDD88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
In-Reply-To:
 <DBBPR04MB7500D614C25B584703C43BDD88382@DBBPR04MB7500.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS4PR04MB9574:EE_
x-ms-office365-filtering-correlation-id: 03e88ec0-72cf-409f-0e53-08deaf0415fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 asH7qXsKAspsx3KvOHKNfATfS1wJ0VjPAdAp6UCuF9gdvPScE1XmRF5tUneOfb1ifKMHe7/6HPx1m1UE4+rpz1/2XHULs+teeS8w30t2wnooYjdEfNIHL2QtKVjfP0QZCBtK0bZ529u7scqU/63Mb/DzsuCQOutaHndI0oXqlLGmLTQKUjYrUWMHdus6OQmK8Yq50JnVK31s3e5R9C0oLVkoFfL6VktlxqsKdEYZve51ajsJm/ACRiY7NI8FnlvgtgLb0g017YYD0r9tuUJXzjPeRB2Q0HfNV0UsV3ypWoAOYlJBgzvfyfH01YwqpwRnOsbh4GsZkwKFfy86Ih4fHsomtKUMr+5hyMYGBDdOBmAeaeBExpsfuIFdAE3Y7VbAbbnlAYJ3VxLkqN/cQeyY5z/4gzhmjZHNRlTHJ13or7Bfg8XKp18Og2/eElOhoO4B1PkrmDxGO2kxPKZOc9/GVIgJH3BlvXCSnrQWQKzbxlTtMJyLmzfxSls9DqFPFP+I9/YhN16k59RlVGJxFmKH2HoiS9MttQgbv2qTCU6TjniHYRajfjV+Jel8Vm1n+RvPPBAKBaEMLQEBJ0ZHB/MVoQGCbklWaiiCs1e6w3aCARxyassxoaHTMxhq8fV+OkrXT9tlyqPZQrQySXN145DTf6ZZ/f09bSioAiMTrgyRMkkwKkknLZwgZGReNQeAS1ht0LiKQ+iamB7TTBbnB5Wo9RSWzREiP+Uky4YkScd5eXmzLSXsfc3PQ0nuLCMU63yg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZDQxTtaMTzOcYC8Yq39dgF8Y4H5tiDU4LJyWFtHW7u/oZVmB6CTe+VPbWLLA?=
 =?us-ascii?Q?Lw2rrBhqcW3+P64ExtTfxefDAKHQRC5HyWhjNKHh6Ifz3SvbLdZaXTJ6v8Gn?=
 =?us-ascii?Q?US+fMhkAt9gKXzNCXXr7tSjVlvTkkSzjx9HdSuSqFhnkRVhGONbmkHbqHQsN?=
 =?us-ascii?Q?AUDH2+cRUwe0orb7GTB/4OFWEOL5kc/7AEcRQ0w9x5Y6nXBdkOtieVXjK1fJ?=
 =?us-ascii?Q?ROFivZqRksT2a0ukIl+jmiTB6pQWx6f8xWdcsMN0kLCGLVpU1XIXMvqzlWWI?=
 =?us-ascii?Q?iVeEMVISlMSJ1W0ccyYlFlXlR58FobQGxAN5SVcUoKgs8AIzX5EYiD6lniNq?=
 =?us-ascii?Q?Mu66LPWAFuFHuwADmSuqcvr8zUwT0iLlpbaUDfVo8AS67uh2WrpYEGKB0LdZ?=
 =?us-ascii?Q?ed0a2s1XjCCt1FeVGkWCcdW3gXnHLDcDcueus+/4YFVUUr+0wUwOxw6y1hPn?=
 =?us-ascii?Q?7i/jKGNqjUoNkHpqcUbZ/7mnYQLsxNsSSJJfi2wmEzHVz12OAHC7NHJhhB+2?=
 =?us-ascii?Q?8Q3LeUnMcouvBOVsViDMgVCp3PYk8ZAfzoTdlhwMvYCh620OYPrsj5n7cSwn?=
 =?us-ascii?Q?+BndwL0yZHTL8li9WryxBhEsf0hD9rMjz6wNacOfljTvENlY0TkTJRQPBDCC?=
 =?us-ascii?Q?UkVAP2aFjhTaUO7nLwxRi3laNZvcEiQZu7iGa/h2FSMlji/f8G/vh5TyBX1f?=
 =?us-ascii?Q?38vi5AXFzIRdtmxK8dV9XDlQwHVQzOP+LnHZc3+8DL5/72cqvhyEWuHF5CvN?=
 =?us-ascii?Q?n66iT9r7anX2gb9wHSJhcxwe98tVSpe8l36i5iDTndoWcucOF59HnuWL40C3?=
 =?us-ascii?Q?NWNp92THxbLPuZ1nR8jAesCF14GWJxBjUpr/sAwP0lBItnvAzmKisUlh2asV?=
 =?us-ascii?Q?zCHxMmc85erNx5YQHU2V8Jj3wqQ9euUV6t+0+Zfr4RT+1hMenDa4De+Gbf8P?=
 =?us-ascii?Q?fk+4saf0fyBm0sgs2bUvLQRK+uv/vxBviWJ4QFj1Ie0nNPo7KJxagGavQbTJ?=
 =?us-ascii?Q?2ExQJ22b7p6zEJ84YNryOEaMTxiFcF6lJEDwlqDB6buBZK1oMcdBDj9UkwG7?=
 =?us-ascii?Q?DPXDukuta3V5HXnJpZ+EttOHIvIPl4XnHzno1mZEk+rObQECKRBKJd/g3N6a?=
 =?us-ascii?Q?cVJIPy57oCT3338+W+dzHE91I4fznR4w/sI68hvSsLknnm8KLPwmilNNgcrP?=
 =?us-ascii?Q?xUZhvNokBW5Lpy5T3X2Urd978AQc9oKqV51HM43MClptlN1Ek3clW7HrbQi+?=
 =?us-ascii?Q?ERoGBigCF5rYoztsAjgS21gYzufPdEBI+4GkTZwys6bp5+lCiLhjewsz9FQG?=
 =?us-ascii?Q?re4++euBzo9DegVVIbIdSiGz6yFhRALLHU87Sng7GyU/gdLVMKznf6Umhzgz?=
 =?us-ascii?Q?X0oYoT5z+n90NJzYiWj0xJC7JC40O/xhmbFyEciB313s2OjfNL9WeGjQZxpC?=
 =?us-ascii?Q?gmWR7POQ4JZznxft+fPdnMvWmRR/Ut1+wUyUBPiFCDbJz6T+eXV+4NjUsaPZ?=
 =?us-ascii?Q?e0pG9g96YmIlT4crQ9TKKEo0EUt3zQGqkbdpw0CZncmzgba7VczFogcQUATz?=
 =?us-ascii?Q?1ThcpGzcg/Dv73AsthR8PfAZBhza2t/FUEuh78lQjgrryrhxV46atksaK2hR?=
 =?us-ascii?Q?S3+m6ie2lXyju2vvPzuGrLxhVHaEkbxpm5aavmye7jKsO//S8/AfBPDIZG3e?=
 =?us-ascii?Q?8vFwEXUvP9XJQj8AbsX3AT87cnqCd6FS+CQdPCRTVH1gOQXn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e88ec0-72cf-409f-0e53-08deaf0415fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 02:22:01.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ES0kC+Fci/oziOWcaFD9vAUJJViwtyuBOC5AhyC81KeZs79TKY5UY6rPb8/Yc8KM7nk6Frrm8aZKdu1o2oXBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574
X-Rspamd-Queue-Id: 25B23507294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,DBBPR04MB7500.eurprd04.prod.outlook.com:mid,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

CC netdev to avoid the same comments

> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to
> > consider:
> > - [High] The BPT update command incorrectly sets the `BPT_UA_BPSEU`
> > flag without providing the required BPSE payload in the DMA buffer.
> > --
> >
> > commit 04028be08f5e1d61341410aae72c568ebdb38953
> > Author: Wei Fang <wei.fang@nxp.com>
> >
> > net: enetc: add support for the "Update" operation to buffer pool
> > table
> >
> > This commit adds the ntmp_bpt_update_entry helper to support updating
> > the specified entry of the buffer pool table.
> >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > > --- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
> >
> > [ ... ]
> >
> > > @@ -175,4 +175,10 @@ struct vft_req_ua {
> > >  	struct vft_cfge_data cfge;
> > >  };
> > >
> > > +/* Buffer Pool Table Request Data Buffer Format of Update action */
> > > +struct bpt_req_update {
> > > +	struct ntmp_req_by_eid rbe;
> > > +	struct bpt_cfge_data cfge;
> > > +};
> > > +
> >
> > [ ... ]
> >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c
> > b/drivers/net/ethernet/freescale/enetc/ntmp.c
> > > --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> >
> > [ ... ]
> >
> > > @@ -749,5 +755,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user,
> > u16 vid,
> > >  }
> > >  EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
> > >
> > > +int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
> > > +			  const struct bpt_cfge_data *cfge) {
> > > +	struct bpt_req_update *req;
> > > +	struct netc_swcbd swcbd;
> > > +	struct netc_cbdr *cbdr;
> > > +	union netc_cbd cbd;
> > > +	int err;
> > > +
> > > +	swcbd.size =3D sizeof(*req);
> > > +	err =3D ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
> > > +			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
> >
> > Will this command fail due to a missing payload for the Buffer Pool
> > Status Entry?
> >
> > The update action is instructed to process both CFGE and BPSE data by
> > setting NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, but the allocated struct
> > bpt_req_update shown above does not contain a struct bpt_bpse_data
> > field.
> >
> > Because the provided swcbd.size is only sizeof(*req), does this cause
> > the hardware to either reject the command with a length mismatch
> > error, or unintentionally read past the end of the provided buffer?
>=20
> According to the NETC reference manual, there is no BPSE_DATA in the requ=
est
> data, this data is maintained by the hardware's internal buffer. The
> BPT_UA_BPSEU flag is used to indicate that the hardware should reset the
> BPSE_DATA of the entry.
>=20
> This is a false positive, please ignore it.

