Return-Path: <netdev+bounces-16741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6129E74E9CA
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B23B28157B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6671773E;
	Tue, 11 Jul 2023 09:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61A17738
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:04:12 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1810F0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:04:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A1EB9206B0;
	Tue, 11 Jul 2023 11:04:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Jhg2yDBy4AI; Tue, 11 Jul 2023 11:04:06 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0715C20684;
	Tue, 11 Jul 2023 11:04:06 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id F3C2A80004A;
	Tue, 11 Jul 2023 11:04:05 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:04:05 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 11:04:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2ABDF3182C3D; Tue, 11 Jul 2023 11:04:05 +0200 (CEST)
Date: Tue, 11 Jul 2023 11:04:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>, Maciej
 =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>, "Linux Network
 Development Mailing List" <netdev@vger.kernel.org>, Benedict Wong
	<benedictwong@google.com>, Lorenzo Colitti <lorenzo@google.com>, Yan Yan
	<evitayan@google.com>
Subject: Re: [PATCH] xfrm: Silence warnings triggerable by bad packets
Message-ID: <ZK0bBR6ERPcNduMR@gauss3.secunet.de>
References: <20230630153759.3349299-1-maze@google.com>
 <ZKNtndEkrzhtmqkF@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKNtndEkrzhtmqkF@gondor.apana.org.au>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 08:53:49AM +0800, Herbert Xu wrote:
> On Fri, Jun 30, 2023 at 08:37:58AM -0700, Maciej Żenczykowski wrote:
> > Steffan, this isn't of course a patch meant for inclusion, instead just a WARN_ON hit report.
> > The patch is simply what prints the following extra info:
> > 
> > xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> > xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->protocol:17
> > 
> > (note: XFRM_MODE_TUNNEL=1 IPPROTO_UDP=17)
> 
> Thanks for the report.  This patch should fix the warnings:
> 
> ---8<---
> After the elimination of inner modes, a couple of warnings that
> were previously unreachable can now be triggered by malformed
> inbound packets.
> 
> Fix this by:
> 
> 1. Moving the setting of skb->protocol into the decap functions.
> 2. Returning -EINVAL when unexpected protocol is seen.
> 
> Reported-by: Maciej Żenczykowski<maze@google.com>
> Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks a lot Herbert!

