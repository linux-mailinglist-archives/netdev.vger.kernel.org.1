Return-Path: <netdev+bounces-39474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB57BF6B6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E9D281B05
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237615AF5;
	Tue, 10 Oct 2023 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3A156C0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:04:11 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB098A7;
	Tue, 10 Oct 2023 02:04:09 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qq8eW-005TST-2G; Tue, 10 Oct 2023 17:03:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Oct 2023 17:03:48 +0800
Date: Tue, 10 Oct 2023 17:03:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Ma Ke <make_ruc2021@163.com>, steffen.klassert@secunet.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: fix return value check in esp_remove_trailer
Message-ID: <ZSUTdBpSTgNz5CA8@gondor.apana.org.au>
References: <20231007005953.3994960-1-make_ruc2021@163.com>
 <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 08, 2023 at 10:07:30AM -0700, Cong Wang wrote:
> On Sat, Oct 07, 2023 at 08:59:53AM +0800, Ma Ke wrote:
> > In esp_remove_trailer(), to avoid an unexpected result returned by
> > pskb_trim, we should check the return value of pskb_trim().
> > 
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  net/ipv6/esp6.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> We need the same change for net/ipv4/esp4.c?

Please verify that it can actually fail first.  Note that I'm
busy right now so I haven't looked at it at all.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

