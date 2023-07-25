Return-Path: <netdev+bounces-20702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963A760B85
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329BB281059
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80D8F70;
	Tue, 25 Jul 2023 07:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7719F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:19:54 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2101.outbound.protection.outlook.com [40.107.14.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C946AC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSeKpUAOAxQQgfupys/jVppY5zuqK7X0BHsLzzvsCpsdLOoAP2ejhPQl+5XrZ3xh/uVSY6H2FgOxT4EGWPDx59UhLBgAjT4H+SaNwJSpbQhEhZ3QShqw7kEx6jwzRwVNqBbO+Kh2y8VvbzSLVKboPqcp5ai51TesYT12xgOS5cxYEMC8H0eErdqKUrgZLNGfusKG3bRsBsGxNShS4AR480NgIlgfFddrmSdZgfCDlZsJqAh1wNYZ1sR2KH1gSPE3/ip7A1Bq2pmhCLzyrKRaiXPyD8p5wgWhgRxPRf+y2w/aa6KX4HHJQLxsmMJ1T3WHUU8zDtHU0mzeE4EjPRh4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFDjRVFrsX+XNRTC5FYez6Sha/M1EpfwnOrzZsSS9yU=;
 b=gfdeaomWbUS6bOVGxN6fDol783fKoY4PTUc9iWypvGk9wrQHxr98KQ+XnM7Nd+LMGiKsvqBjgu/vwlIfD/QIoFYRKp25ajVSKvG9qKBo1/XTd72YOxO6n5q71WpvYjaLSYsFVhrq+IcPSO3YfHcU+YiV2CTkAUb0YPnRxnkOLum0qTQuDbrg8t82I85XNoxvMFAyyRJeORoJN5sUNbZHC+LfKwNA1qCS/xTOyGPasnLckdgOXTHRvIuyKgusIEbHU59pFMS6juaxAeLDTLPF8RrHH6J9JufTgH5O3Yc2O2h6dtRdVYfRcUdfP3dwYCbFAJZOWvesXYeRhxkunfQl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFDjRVFrsX+XNRTC5FYez6Sha/M1EpfwnOrzZsSS9yU=;
 b=QDe0KfhLiLdDOZoZ72LL+XqKVOKR7NPwSZ30aPm2tMJwkyOtP8wF90RdkLBg0YM7dCtYV2j54ofkRe7he56++ufjdGMA3GksMbYZou6zIc6dyey/5yzAOOEqLOiKHHHH3OHvvfvwcJ8iu6ue4b8KNCW9IZeMlq1/pZgW8K8+eoE=
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by DU0PR05MB10571.eurprd05.prod.outlook.com (2603:10a6:10:426::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 25 Jul
 2023 07:19:29 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::85b:aaea:a5bb:e08d]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::85b:aaea:a5bb:e08d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:19:29 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>
Subject: RE: [PATCH v2 1/1] tipc: check return value of pskb_trim()
Thread-Topic: [PATCH v2 1/1] tipc: check return value of pskb_trim()
Thread-Index: AQHZvsYwisSsI43XKkmaP/yNSycLH6/KEr5A
Date: Tue, 25 Jul 2023 07:19:29 +0000
Message-ID:
 <DB9PR05MB90784178D27E1ACF9AECD3F18803A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <20230717185710.93256-1-kuniyu@amazon.com>
 <20230725064810.5820-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230725064810.5820-1-ruc_gongyuanjun@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|DU0PR05MB10571:EE_
x-ms-office365-filtering-correlation-id: 0b4e8634-d524-4a20-2f12-08db8cdf7c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AJe9qGrGjBVhG1U5tsw/i3VtBZStRo3cb2eY1GLVyHIPqnzlrwmdlxbYk+lzWu7mgC4Qf0doerPCPxL66GvbbzE2PT7d9AspC311GZZt6N4R8naBjFYuHXVkCJw3xOb0XRNsbaFopIxm9DWAu1YVBU/0HHgv4sJN48/YCmINFISmuPWwHogPu/9hfUXFb9hybNMVDsgYNk5gbqFRdMQ359C0712AqKWmpNhcRBUNLH5vOc3zpwNI6lfqJ//ZCcE1dGgPI8s9MT9zxndkk5KkN3SDgGN9nt2+5zE8qPzK+vzVAdNVwUbmknltjKpYgcvvBS3/I3ptUEAD/znSw+avVfTYENXQGghyetnpadkbiSANWpS347hZtPMQuQOpoOnmbrVAq15CzBFjrjb5sA39EpwCJl7DowB+nZzLK84LBCYljcY+/91S70ub1fA7VDYzXn0e8LziBNmBObsT4If7KW76jMQcgqQnfJZynk7J9cjoqbPmLszyvrz/tLZPP6p53ohtgVelqTqXoFNlo9gSBWy2RewKGTE3DIlycAzu4yQ+t1ai/Zj6wGHOK8dRqhiJQ/bCNbvEBzNsuScxAnNz0WV+iJpqFqxTnkO9PeSYghER6mwH+9EXG+aroFK/e3d6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39840400004)(396003)(451199021)(6506007)(478600001)(66446008)(26005)(122000001)(54906003)(186003)(7696005)(71200400001)(66476007)(64756008)(66946007)(76116006)(6916009)(4326008)(83380400001)(66556008)(9686003)(38100700002)(52536014)(5660300002)(38070700005)(41300700001)(8936002)(33656002)(4744005)(2906002)(8676002)(316002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WJ03zVWXhcJH86KxWAOLGwm5bPG0K/hIEiUPMA7iysm3cSAkpEt0xxsD3eSX?=
 =?us-ascii?Q?NPHqL/sFVziJ9IN4Pw6up0wBtgzPypX7frtmNoCruJas37yS6mkq75Fr6irK?=
 =?us-ascii?Q?jozkspohMN4vJ0oU+fwBSpyxvjW9B3VTRJNcTLaIF9r9oVTZJKSUlLgLQ5SJ?=
 =?us-ascii?Q?icCPMJRMo6613i2sjudmpFC24+n0RThGmfSyCjgqq743Ud0wW+A+86KjgSuP?=
 =?us-ascii?Q?aOtqcFgXnzDFkSvq6T0kfwi6E4AeUqOQBLtDkNaLfwt1eOG8rB/QmzZm+iRJ?=
 =?us-ascii?Q?HZYBjjpyb4LjTPQ2xrodwd1S0bfe1Czr6dgckbmwQQNROy1JcUeZTKNK8jQT?=
 =?us-ascii?Q?xSyNZW+sMfsq//j4v+U3ul6d93B0eFZV0MpfDSpqGHNRujejRIiR8jps1reR?=
 =?us-ascii?Q?oCYl330+MpS4mIvNTjAWEqXzDScLJ/EXC7Lh++ZsUg9gunSPbfzRPmHaSQ0g?=
 =?us-ascii?Q?tVWfvyBGgGjV4PPDW/a8jjchnJcFxd+Na26GY5BCE8kG4/qYdvdybQGzXn23?=
 =?us-ascii?Q?DeRA9b+i9oAJNwUf2ZwIrpGIamuifiGngr9nAGJoJsigXfSYgJLCG3ctmQBC?=
 =?us-ascii?Q?6fQkaw4/H6UR/KL22nMgAO5/5IWTMnWeAiQmusMoTMTrnkF/X+iPf4+6U3me?=
 =?us-ascii?Q?+PWrc+mh1QiHJ+t1ZGuLsv4i9vSjEvj+Q7Of1Gy9ssVomYf/f2I9sz6BjVG/?=
 =?us-ascii?Q?MDJRTVAP5MvNdhqJ41Ezhn96UDfPPtZh29Yr2Ob3S7gkgdH9UBTrT498vfeL?=
 =?us-ascii?Q?ZNXVwO6Tmc5+5g1za/soGfltU9SUy6u+PaNO/S+SKzBez8Tpar2zckFSgKqN?=
 =?us-ascii?Q?1++FDdYWyTuZDSGeE7JAxEEpvo2LtxfmMzNrHwbDOh5tPoi4owxpuw1Nh5rD?=
 =?us-ascii?Q?9Us8AGZFqgPrPZmEKVygnsBD5roH48j26oqkJUhuX1hLwqmh4pERvzNUlPh3?=
 =?us-ascii?Q?4B+XGFjGyzUqxaBhj28KRsB092tw1TsQjnTvGjT3dhlH1k6jyPJJ7YS+6qpa?=
 =?us-ascii?Q?mV0LTdToqP4WyNrF4TOLca206gPcb7pkiPLGmRGgmRGp5DA/tsmA+I/yKlUI?=
 =?us-ascii?Q?dCwZkD3QKIF/cgFmHyqOEG5dHRRkMHwfA62+s/z+i5rck+fySw4r2UTLQIO7?=
 =?us-ascii?Q?OEcWa29wznTCLd+v4nsVtL0bu4I6g0Hj+aFoKfQeUYxKZLxBA6g4EMQsXHXp?=
 =?us-ascii?Q?5iLMyPn+CdQYr7DtQkdnSz2obY92pKhbElJXiFrewNpl09oWP4vpoodz7/Ph?=
 =?us-ascii?Q?Pw6eVu4cvMVEF01i8RVUlNupyAz4pAjfwkWgwoKz4TlWKinrvIbkp8QHbmY8?=
 =?us-ascii?Q?eg8yM3iUboIpQ5hG6okcrZ8VVlkBXvoasOHsMc3mrCtT+BQ7+dTsqLWSFeZ8?=
 =?us-ascii?Q?LiAQsvqvaA5oR9PtV7k6zidbiM+imv7heMwJlaXr8iW1K19Cw9XRBV5FpYn4?=
 =?us-ascii?Q?YNGXexjx1d2vVhAKuf4XehO01JtxJQe49eOgkgCjHmhhBNdJ/ZmZ0Z6fTfdV?=
 =?us-ascii?Q?f2Mj3fqoTvI2ZU98q3AZd3DwzSUtNkxMncZ8tyNIpYiOwzFdr0o2R4nKwDn6?=
 =?us-ascii?Q?94798Fvz80JyxhC7yg6EZALqu5sDofrDLdzM9b1d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4e8634-d524-4a20-2f12-08db8cdf7c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 07:19:29.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrxyRRCWMHckDH2OWIL4sdhsjIpe6Y799XTY2qeLehMlI80fuLJG446LBdyrX+3Ii4NPXwvGJT5acBOoqWhsr2H86IIqU+2D+ExNY/zuFCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>Subject: [PATCH v2 1/1] tipc: check return value of pskb_trim()
>
>goto free_skb if an unexpected result is returned by pskb_tirm() in tipc_c=
rypto_rcv_complete().
>
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
>Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
>---
> net/tipc/crypto.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index 577fa5af33ec..302=
fd749c424 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -1960,7 +1960,8 @@ static void tipc_crypto_rcv_complete(struct net *net=
, struct tipc_aead *aead,
>
> 	skb_reset_network_header(*skb);
> 	skb_pull(*skb, tipc_ehdr_size(ehdr));
>-	pskb_trim(*skb, (*skb)->len - aead->authsize);
>+	if (pskb_trim(*skb, (*skb)->len - aead->authsize))
>+		goto free_skb;
>
> 	/* Validate TIPCv2 message */
> 	if (unlikely(!tipc_msg_validate(skb))) {
>--
>2.17.1
>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>

