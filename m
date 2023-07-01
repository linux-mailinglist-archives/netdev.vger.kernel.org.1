Return-Path: <netdev+bounces-14957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D05574490A
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6BE1C20914
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF847A933;
	Sat,  1 Jul 2023 12:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAB1857
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:45:44 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855294213
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 05:45:31 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qFZyg-000Aae-SB; Sat, 01 Jul 2023 22:45:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Jul 2023 20:45:20 +0800
Date: Sat, 1 Jul 2023 20:45:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Benedict Wong <benedictwong@google.com>,
	Lorenzo Colitti <lorenzo@google.com>, Yan Yan <evitayan@google.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
Message-ID: <ZKAf4M5ypasK3fgI@gondor.apana.org.au>
References: <20230630153759.3349299-1-maze@google.com>
 <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
 <CANP3RGduOc4UgNoeHE+jcDw7ExrbCm64LX6zwgyh5FfyYzGSGA@mail.gmail.com>
 <CANP3RGemhoHyeki_ZzbX4JAWuCq3YZOOs64=T5YZ0XSaK8wbpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGemhoHyeki_ZzbX4JAWuCq3YZOOs64=T5YZ0XSaK8wbpA@mail.gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 02:39:36PM +0200, Maciej Żenczykowski wrote:
>
> I guess it's OK that this WARN_ON is remotely triggerable?

That's a good point.

We should audit all the WARN_ONs in net/xfrm and get rid of the
ones that can be triggered by a remote peer.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

