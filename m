Return-Path: <netdev+bounces-13841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE473D3AC
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF781C208E8
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817388F4B;
	Sun, 25 Jun 2023 20:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B28C1C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 20:25:20 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BEE9E;
	Sun, 25 Jun 2023 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4paSFHeIlmi01eelJjcHibWu0numZnAAbkmYQwsVvVw=;
  b=uTuUd+lYkqHEhC/7BYEgrQLODKlleWH78OO7eRNLvWWsdlxUHM5yQBYw
   xRE3XSszHkl6bHc1aHvBcIAto3CrGBfPhNk5l3nVLWEY6hW5S9ACjsQsM
   7A95HWKENPTaXZGy4u+aI+Dsn1QImuOWTVzsQfDfeIGMLVGYx/9XNA9MI
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,158,1684792800"; 
   d="scan'208";a="59758804"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 22:25:12 +0200
Date: Sun, 25 Jun 2023 22:25:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
    Veerasenareddy Burru <vburru@marvell.com>, keescook@chromium.org, 
    kernel-janitors@vger.kernel.org, Abhijit Ayarekar <aayarekar@marvell.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 02/26] octeon_ep: use array_size
In-Reply-To: <beb409e3-0c13-b817-dfa3-15792a341130@wanadoo.fr>
Message-ID: <alpine.DEB.2.22.394.2306252221310.3022@hadrien>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr> <20230623211457.102544-3-Julia.Lawall@inria.fr> <20230624152826.10e3789b@kernel.org> <beb409e3-0c13-b817-dfa3-15792a341130@wanadoo.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1326197144-1687724711=:3022"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1326197144-1687724711=:3022
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Jun 2023, Christophe JAILLET wrote:

> Le 25/06/2023 à 00:28, Jakub Kicinski a écrit :
> > On Fri, 23 Jun 2023 23:14:33 +0200 Julia Lawall wrote:
> > > -	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
> > > +	oq->buff_info = vzalloc(array_size(oq->max_count,
> > > OCTEP_OQ_RECVBUF_SIZE));
> >
> > vcalloc seems to exist, is there a reason array_size() is preferred?
>
> Hi,
>
> just for your information, I've just sent [1].
>
> CJ
>
> [1]:
> https://lore.kernel.org/all/3484e46180dd2cf05d993ff1a78b481bc2ad1f71.1687723931.git.christophe.jaillet@wanadoo.fr/

For some reason, I have only received Christophe's mail, not Jakub's...

In any case, thanks for pointing out the existence of these functions.  I
just redid what Kees did in 2018, when I guess these functions didn't
exist.  I will look more carefully to see what functions are now available
and resend the whole thing.

Thanks!

julia
--8323329-1326197144-1687724711=:3022--

