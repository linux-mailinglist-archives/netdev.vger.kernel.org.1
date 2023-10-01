Return-Path: <netdev+bounces-37243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91687B45CA
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 33331B2080B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72931BA35;
	Sun,  1 Oct 2023 07:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3920E1
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:31:03 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43240BF;
	Sun,  1 Oct 2023 00:31:00 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qmquc-002Oe8-EW; Sun, 01 Oct 2023 15:30:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 01 Oct 2023 15:30:50 +0800
Date: Sun, 1 Oct 2023 15:30:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined
 reference to `crypto_has_aead'
Message-ID: <ZRkgKnpgW0tfZgTc@gondor.apana.org.au>
References: <CA+G9fYu2DKDxOEFTeJhH-r_JD8gR1gS8e4YsSrW3rfGegHR4Sg@mail.gmail.com>
 <ZRbPBdu0ZJ86juff@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRbPBdu0ZJ86juff@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 03:20:05PM +0200, Sabrina Dubroca wrote:
>
> I guess the problem is that CONFIG_XFRM_ALGO doesn't select
> CONFIG_CRYPTO_AEAD (or _AEAD2?), just CRYPTO_HASH and CRYPTO_SKCIPHER.
> 
> Herbert, does that seem reasonable?

Sorry Sabrina, this patch is already in my queue but I forgot to
push it out.  I'll get onto it now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

