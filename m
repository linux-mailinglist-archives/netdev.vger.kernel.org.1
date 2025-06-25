Return-Path: <netdev+bounces-200904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362BAE74AE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAFF17CE0E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49031A0BF1;
	Wed, 25 Jun 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="cBYZC2qN"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24D33086
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817780; cv=none; b=VdL5jUiUJaogj6cwaqSckDYCNVnjXv7FAPFH/wn6tltfejApZPn6kSYHBmN7PMM7++G8awC/2Nu8DGj0uHRKAC9nkE4hjhMiIEjIsv7p/12pJyA9I4eoaOJaigkCBlFrA1c1Ng8Y2IkgDXaf47slMQxbgwSdtKyJ+b/iG/gcWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817780; c=relaxed/simple;
	bh=So9YkZ+FsXyGjufrJoPrzHlXAhtXM7HxlZ4gpDO/Bjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiE0S5fahzmXmEeAQaLy/SLJKsr6qeOtTRu4n9KL12og8BjRH/gb301F/m5TaPQY6BFGfsWiGI6bmNzOJvyV2YDIgc1pgGBKb76TigQG0g3V7dZbVK6AJpNvvpW8YhEfSCR50tVvcRB7GZloE6aQgENzM0s60NJTp8FZlg3koq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=cBYZC2qN; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kM4siONN2mJdDX29Q5Xc6iKJghkgWnNsYKmCkYvmbXY=; b=cBYZC2qNye5eDqzY96Jkc/jn4s
	86BFDSwe3sTA77JyiLkOL9ADZwmTH6T7xp7UiI7D7XKkuI1j7zDcCO6q5kqxCeMilt2pafBV/YTTV
	ySr3yV2AVIOutpiFOHoob3Bkcau4qGWtZWIfWZm3l33UF+yM/DwxcEZsY6s1alA1WUw88bM0Th+4R
	Sxcb5e1SRvwl+ubXswojsxYwy/4HnxK9OEEI37XRt0p0smUg78MMKsKlrKho/codVlEN/SsUHf/9Z
	YA8YOYlpDySluvlcZeZtQwZn55/BZ9dHwShGjBC9fvihgmOjiDZlutfg3Yx2zlV5+5eGL74AD/bU9
	nPGlr6Ug==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uUFQr-000mJS-1P;
	Wed, 25 Jun 2025 10:16:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 25 Jun 2025 10:16:09 +0800
Date: Wed, 25 Jun 2025 10:16:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com
Subject: Re: [PATCH ipsec] xfrm: ipcomp: adjust transport header after
 decompressing
Message-ID: <aFtb6bNxShhfDuzi@gondor.apana.org.au>
References: <20250624131115.59201-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624131115.59201-1-fmancera@suse.de>

On Tue, Jun 24, 2025 at 03:11:15PM +0200, Fernando Fernandez Mancera wrote:
> The skb transport header pointer needs to be adjusted by network header
> pointer plus the size of the ipcomp header.
> 
> This shows up when running traffic over ipcomp using transport mode.
> After being reinjected, packets are dropped because the header isn't
> adjusted properly and some checks can be triggered. E.g the skb is
> mistakenly considered as IP fragmented packet and later dropped.
> 
> kworker/30:1-mm     443 [030]   102.055250:     skb:kfree_skb:skbaddr=0xffff8f104aa3ce00 rx_sk=(
>         ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
>         ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
>         ffffffff84281420 ip_defrag+0x4b0 ([kernel.kallsyms])
>         ffffffff8428006e ip_local_deliver+0x4e ([kernel.kallsyms])
>         ffffffff8432afb1 xfrm_trans_reinject+0xe1 ([kernel.kallsyms])
>         ffffffff83758230 process_one_work+0x190 ([kernel.kallsyms])
>         ffffffff83758f37 worker_thread+0x2d7 ([kernel.kallsyms])
>         ffffffff83761cc9 kthread+0xf9 ([kernel.kallsyms])
>         ffffffff836c3437 ret_from_fork+0x197 ([kernel.kallsyms])
>         ffffffff836718da ret_from_fork_asm+0x1a ([kernel.kallsyms])
> 
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Link: https://bugzilla.suse.com/1244532
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/xfrm/xfrm_ipcomp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks for catching this.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

