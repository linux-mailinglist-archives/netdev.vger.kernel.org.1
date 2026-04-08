Return-Path: <netdev+bounces-276260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dp8Nd/I1WnA9wcAu9opvQ
	(envelope-from <netdev+bounces-276260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7123B68FF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A90AB30205DE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C0274B28;
	Wed,  8 Apr 2026 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YI9xLm5S"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9521EB5C2;
	Wed,  8 Apr 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618217; cv=fail; b=RuqomX+emRmrextC17f20mE9iJzYyVltLn7A59F0H+Kh4DyS4awIwxuFfNTZTdkK3+fVCeO8w9usSY2aD280k7pL+Dl4HjWbBEdpCp1NH6Fr+VHnv//YQELBjYxQyXe0uFcEGG+zSUdyTnGeQqyaiPnLcm9Go/At3AOLRrGN2ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618217; c=relaxed/simple;
	bh=hfcqcyAyMF0pIESZNkD6Y9GT/OkVuuOD+nfW/wPnEzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b5zTQLVMKoViaVv0LmMbIt9/OwCJhDSbPktNiEntw5kt4EMteN8U9SftdVe8wQF34lH2eIT/gI+bylphUGq+afq2MOhqwhwS8o+yD2LhU+UFp2XT3pJrrOb/9eNEJKQEyW48XMvfwjL1jRLtvhvxb/qONKOd9EU7njpbUqw6SCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YI9xLm5S; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls1unfx//wTRSYckX81N+9SowLC0HVaYDRPg/wv4aPPWR+p6rXJI2asKlNA5QenVmEYWSIoZtKfyuJ2yy5+beMKkEuAoZojZ+SlCM33RDyvbocnI27igB+BQP+w6pvjN3Kggis/I8GukQ4kVX/eBIgQ86vpwnPZPvGPWfABsyL5v9zGExT8le+m+Oqb1rGywqKnNToRYPo4L4TCM8/P/zt+A3GR/y9AFGWS+l4yaUfAMzuQf/JELeSNebNiSaZRGrDQ6L0jkxCz+gKQAxtmpWXTEIitIFc+1ODUR6OnqlSFKVpK72stJeCA8hUK6Mz7VoMwgdrRAp2v8a6rmirL3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y76r62emDGgKMaYenjP+ePeIkXOxaEKrSJi5FBrQ7E=;
 b=EhxSZDCt+ljeEp7dWjhkpxH1Lxce0DhfzyhLxHStN2VVkmu+mSqOS2lTLiT65jzas2W0yka/ouU4jWogk0EGh6bpapoenXcNUWUr8+GfmB5lvj1Yu+VwWEGe5CiYFVNqJe8mCLD+N5ax+0HbmdFTCuGeVoNQjc9IrWBKsEP+QMayt46DYaIWHBTeSOIWI6l3mFpfN9QhKqd5e3meZA1CWzeyzRZ2m+PbE3rCwLg/9RyK5j0Q1OOmbYjo8p1rn901qnEW9PL5BNviAUIGUWYF8Lu7Wy88ZRFs9tRkRLEvoGLjHxZH99vKK3uh9mM+hxK0d7rdSmwvYi0+CA6WxJe4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y76r62emDGgKMaYenjP+ePeIkXOxaEKrSJi5FBrQ7E=;
 b=YI9xLm5SxnZ7v4UyJk9J/1H4er5V5TA4BXp5knbfkrtx8h0XeC/LzEf6tuT/2MYK6TuTlF8prkMsOIVJD2fBwyDNrx0H56JbpZd1CzjdwZVMPZqC2q894AR3hD7mJCebyVYjgR7zu5047mzoL8HOo337wsq0DS37QVnTebX/XkcaSdIy+ZdQnKsazTsT2CrNHVnuWQXsNiUsvAtRqKQiryxchSrCEL6RjMmlLfrdKw29pN/2y1yVOfySXsB/2kNIzu/VAs6J7kig9Em1VdnK8SkSbaiOpmTREKd7FRQH28kNwWq/sLr99Biexm8CiloFUORmCfEsAUKsm55wVonlvQ==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by AMBPR04MB11762.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 03:16:53 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 03:16:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Zefir Kurtisi <zefir.kurtisi@westermo.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net 1/6] net: enetc: increment error counter in
 enetc_xdp_xmit() on DMA mapping errors
Thread-Topic: [PATCH v2 net 1/6] net: enetc: increment error counter in
 enetc_xdp_xmit() on DMA mapping errors
Thread-Index: AQHcxgXCGgbCTsWNkECEXrfB25CBw7XUfAtA
Date: Wed, 8 Apr 2026 03:16:52 +0000
Message-ID:
 <AM8PR04MB7284172758C594B8A89960BD885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
 <20260406204122.167237-2-vladimir.oltean@nxp.com>
In-Reply-To: <20260406204122.167237-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|AMBPR04MB11762:EE_
x-ms-office365-filtering-correlation-id: 3f6867f0-94d8-40f9-fa92-08de951d4815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 hnhx14ZKYOWiku/oGFDihX4/xUKT3K50WKsxdrQIPF+bSgUq8ahY/T+2meV5uCzvnenQCNltgYEY77NUmWmVCaEFbFd1Vu/Wm/uW5jGIqu2YpRLxSgSX5JuWWGF+fJUchbicWE7kaN9lWAGcPGTi6jX56nvGgubK3u4YAqJEdXZurhpszbL0wbSvXmTn+Zyyoz6qZqTPztku6ZRAGl04aGneICREQM9wqIF+gKeSb2u6RofWv+z96SOwa0iac0mLeNgnNp8hNcCBoX0V+S/JY7Mw0Jev1htPRb+IO7UH9EU6A6ofkBVVecAGvBeBPegubKggnDiQn5crHWeEH6MlEN/GYNpduqtSDhbj42wzdINkOH851eeZ2cmpI9E476gOD7vsy3kanNyxZPDdmNmy6u9P1Kr+Qd3L6Ox9FqsdMKmPgyBx1vT60eNz11XYWWMm4Uy4cfqz+haArKulMqaGvjaa3UhYvV7h/9bMwAw09cAhtihqWt1XJKR6h7zY1CU1z+dpdWDEzRcHccJh2DokO+wC9I2zDmjq0ytcg+RQ9cOWKVWxB36Z+YWL/1+mXqbVe1zOakyyddTd8I4PdZjFlnCoNxDElZDaK6BGW+yVJ4UcR8cwgd79SdlGw/gw/1sTjUNdOc1sbl0Gh52FzGLNZwgRY3bixfYhn2mDExODKSeGPlM7BUqRL7ov1rTZjG1lSRcLlPYCXd9CwIUFiLDeey9d5f1LJOYVJQsCofV6UKe04S3DBAdFEp2dTQ+7u7HpEbPT2AV3iSsas1FtIAraJi0SW4JB/hV+CLrzkIpXzgk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zhcp4JvukB1nZV8I6ZS19KZuKadLKxMpEm39DI3YQm2EuwgRuFpF13A5buaz?=
 =?us-ascii?Q?p5mVez0BXUUsvfe7Mu36K89haBLFT0GbHTlRqTaa4rlJPy8R039+6UO4d2BO?=
 =?us-ascii?Q?rTNXEEF89LaCcKKmlkyjTQvELEcYhMJsIb2NCQJ9WIRNPI8vGj3v4AyXYyTu?=
 =?us-ascii?Q?D8Vp2ngima8N6wgOX0mA5irpecDS3EBP0vmWenr7KQF6E6tQybLGxBHzvGLK?=
 =?us-ascii?Q?qKFgJ1LvCtXPld9NBGvqBAOScRJvaU4S7LsyegCGsEqQMbWodbvXmnipY+CD?=
 =?us-ascii?Q?cebbbYne9AboeaCEsaOQ0jJ3/5JWP7PK/vOSZdmOcH2/c92s/gF+rpaM55il?=
 =?us-ascii?Q?8u7xHFDcQqrwTaQDJ9cAyaCgRc2BVxYd7mqwNKPCCiKDGClGAcD2d5zSveYU?=
 =?us-ascii?Q?oa8tftGZ37x9Cxp0TTZlPs8D/ylg+OQpdPf7GVwpHGRuyOMP40daGgjWuJ3i?=
 =?us-ascii?Q?j0RcguRt6momvwzjfTUN8B0MAzOhcEfFI9PDIxlQibmyRuXiSfuzZIy1emhM?=
 =?us-ascii?Q?M/lwBUElRew4qGgw7p7X904y1+G2TnQzi87gn3GVFFQSk/rTr5R04ithALyR?=
 =?us-ascii?Q?hWnxzUpBaFUGePrnNL8yxxCyD+mqtrUvMqKD7UovpNYdaqEIq+GPtNXq0FNa?=
 =?us-ascii?Q?saGkWebZ0DzYxRXczKnLUVKxrHJDE3nx0ZBrBu4iMglix/26+6ufB+cz72VJ?=
 =?us-ascii?Q?z9yN/l6SHeblSUih58+4yoFJAClMHDNTlmTj7RQdgF78M1ddLuWqj0w0iFbn?=
 =?us-ascii?Q?9mwIhg87iZB8N+0LZn3tECF09WUl5RRYdacOJWZe0FczHlPXhQ32fp79lbjC?=
 =?us-ascii?Q?Ibd7BXnNmNlWlw7yzxt82w4VOWoLzIjRgwgq7+kJ/HV0KeWO1VN5DJdsfE1S?=
 =?us-ascii?Q?jKUYCF094L6fEOtLDzL6fcyozK2LNFsfzZWNDpT7YIXO8kN82zRQRFaJDSrT?=
 =?us-ascii?Q?+HlQS0M3gLK+YSr+SIdrgzyyTMZW/0kXm+v13R5LUv1c++XrzCL+cgSvbtFV?=
 =?us-ascii?Q?jLnuF+nxEzwZJN32YCUtSjoyYSc/ea6MEUnyQHct08Q8A734AqdrZoywPa4Z?=
 =?us-ascii?Q?ZBvj+5SEHxYVADi2otxnwT/dpmatlDKDF30EGdfvf5sbZuMEgUdhcLSjKaTa?=
 =?us-ascii?Q?4e287vh+mXapx6CS7gVAOc9qDpHihMrxO2PcRlHxawpfNU7dKN72rSM+gFt2?=
 =?us-ascii?Q?8+RDFe382sAP6obNlVhDDTV5a3lN5XcDo+Qh/6O5ctODgGBvFitbrIucMBwf?=
 =?us-ascii?Q?nZL4+92JhgWfBbibqvIwsZjqOgxrqgGM1ALMP9yW9LS0Ws7Ww1CITxc+gLEm?=
 =?us-ascii?Q?fPd/tEn8jFvXW3Ud+FLwyb+jg1t0K4Y8p+BnepIHkc1NPx2ZpYoCwoiEBi7q?=
 =?us-ascii?Q?BGohEzigxZwTW1cVnoWUIXfJoUL457bZtvEABG9clbUrAkms9qv+pn2rW+Or?=
 =?us-ascii?Q?UlroQPq5aedEg0LZAIAt6TrYwe0wcHW6EDL8cwkgcpEv+6U42UF72oYAN6gB?=
 =?us-ascii?Q?XWQhREuzCKwpNm2CWZF3JvAd0wf/VWwF/jkT+6vSYqkw55Pf05Msb29Xh81b?=
 =?us-ascii?Q?9L1Ta3Ih7w6xzBzaL23FUn0uzUH2uGIKWQhfnuWpm4tA0zf/BValRvZpH25F?=
 =?us-ascii?Q?5/L+wEHksDM4yFAhkxCpotzK1JmmsefWAqdcTuNOwXf5sPpSeIVVr7zdq3kH?=
 =?us-ascii?Q?Hs9G1PiwmPyCuIxpq4QDAid0B7m6UYhv+vC4GN7EPxsVe3/S?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6867f0-94d8-40f9-fa92-08de951d4815
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 03:16:52.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEAcXbIOs5A1rdzlwPfWSw/TCwcH83jfsyTQnNUMqd35TH2T/yYv/qM/a/zxuulqrylKqFP8ixmUoSktz8/sHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11762
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276260-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AM8PR04MB7284.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 4F7123B68FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index aa8a87124b10..ece10a58d44e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1801,8 +1801,10 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> num_frames,
>  		xdp_tx_bd_cnt =3D enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
>  							       xdp_redirect_arr,
>  							       frames[k]);
> -		if (unlikely(xdp_tx_bd_cnt < 0))
> +		if (unlikely(xdp_tx_bd_cnt < 0)) {
> +			tx_ring->stats.xdp_tx_drops++;

xdp_tx_drops is also used for XDP_TX statistics, so it is difficult to dist=
inguish
how many packets are dropped by XDP_TX and how many are dropped by
ndo_xdp_xmit(). Would it be better to add another statistic variable to tra=
ck
the packets dropped by ndo_xdp_xmit()?

Additionally, I checked the code of bq_xmit_all(), when ndo_xdp_xmit()
returns due to failure, packets after 'sent' will be dropped by
xdp_return_frame_rx_napi(). Therefore, 'xdp_tx_drops' here seems more
like a statistic of the number of enetc_xdp_xmit() failures than a packet l=
oss
statistic.

>  			break;
> +		}
>=20
>  		if (unlikely(!enetc_xdp_tx(tx_ring, xdp_redirect_arr,
>  					   xdp_tx_bd_cnt))) {
> --
> 2.43.0


