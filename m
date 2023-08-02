Return-Path: <netdev+bounces-23504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD076C3A8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C16281C16
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC340EC6;
	Wed,  2 Aug 2023 03:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBAA4C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:45:29 +0000 (UTC)
Received: from clt-mbsout-02.mbs.boeing.net (clt-mbsout-02.mbs.boeing.net [130.76.144.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE119B9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:45:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 3723jO7q005931;
	Tue, 1 Aug 2023 23:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1690947926;
	bh=KZSb1KttasEBFj/08NfpvDf74CBnDzK5HHTvUW+4ACQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PL+87D1//4EKnelh9wdS2Dy39R7y2WwtcZmbp8BqGCEIbyN3KQ33+RPKo8Gzj5DCy
	 eqHYbzGiZSDk1q4+B2ngLqXW53Lkpx0Dp7Ub2Lf7q74jYbiRBQUZKvUbxl8FhsPWYw
	 onchcZeLmuda7r2J6goT0ZB/u+QrwDzPvtGthuq2dPaop9BtlOzaRCQEZgYObdb83x
	 7kifmcU7WQJKpWKNo3gzMsIAUEwL1e2GPIZKRkQPSotLGol9+7kRKAKGSIG4ZiNw3j
	 vusT+cuc/l+txfKRgnwt8KcPXCitmxJglTRE+jfHnz1b6fZ0IehYIPNwgOkKYH3kM1
	 zCKNmslUGv/Nw==
Received: from XCH16-09-08.nos.boeing.com (xch16-09-08.nos.boeing.com [144.115.66.156])
	by clt-mbsout-02.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 3723jIBW005859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Aug 2023 23:45:18 -0400
Received: from XCH16-09-12.nos.boeing.com (144.115.66.161) by
 XCH16-09-08.nos.boeing.com (144.115.66.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 20:45:11 -0700
Received: from XCH16-09-12.nos.boeing.com ([fe80::c591:b386:9cff:58f6]) by
 XCH16-09-12.nos.boeing.com ([fe80::c591:b386:9cff:58f6%5]) with mapi id
 15.01.2507.027; Tue, 1 Aug 2023 20:45:11 -0700
From: "Hasenbosch, Samuel J" <Samuel.J.Hasenbosch@boeing.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "hcoin@quietfountain.com"
	<hcoin@quietfountain.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: Re: llc needs namespace awareness asap, was Re: Patch fixing STP
 if bridge in non-default namespace.
Thread-Topic: Re: llc needs namespace awareness asap, was Re: Patch fixing STP
 if bridge in non-default namespace.
Thread-Index: AdnE8x7zvcof3v0eQ+iVbqkRfREN+AAAH5Yw
Date: Wed, 2 Aug 2023 03:45:10 +0000
Message-ID: <60bf35338d424beca3d9ba60deb1839c@boeing.com>
References: <35b7a25672c1405383960557ea4d6131@boeing.com>
In-Reply-To: <35b7a25672c1405383960557ea4d6131@boeing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [137.137.12.6]
x-tm-snts-smtp: 8173CEEB1BD25C36F001708C7729B31DD6AE284A7A19E5299BC8B13D798048DE2000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Forwarding related issue:

https://lore.kernel.org/netdev/cf3001de-4ee2-45f2-83d3-3c878b85d628@free.fr=
/

