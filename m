Return-Path: <netdev+bounces-190151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101F0AB551B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5902D3A3C15
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91728DB6E;
	Tue, 13 May 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="b4CK2ayA"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB428CF68;
	Tue, 13 May 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140215; cv=none; b=RGv99m5jUfv8UfmFobkOYmAvTd51dLISQTw9EkgsUHoydR5K8j+Xu6VAhvlHHuPq8IYmANJx08UmW8GYMRbBdrBIW1Ed8fPXawRwkRy+3xJ99zOPr/xl3lKCd+mrBRiLb/2+LilX/5CAx0a0C5+kijQ200OMGJuF0yN2wrxNk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140215; c=relaxed/simple;
	bh=6iHfKiz4WKe+cAHmUEXMyds2YmUzVKy+KnkYoWTKDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdwH4A6UZ6jAOSlAwO8C4xf4fGjiyX0dxXdoLki5fx/MA30mb+LCN3wov+q26DpB3nvK04R/S4PIJE3SWcwMaVy/c/Ng8fzVIcE6YIVayBnsvgGTNNe+9UQXv2Jowh6VMSp+oF3rdCbKdSWRhUagQT4juz5yZgfwP/MvpM9Nn+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=b4CK2ayA; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1747139687; x=1748003688; bh=6iHf
	Kiz4WKe+cAHmUEXMyds2YmUzVKy+KnkYoWTKDQc=; b=b4CK2ayA9+skC79kqW/v
	hLkKn7UoVL1UlpjpXU6ADilmafCK6x4/ShcRO9IghEPaTunVxAbWlNYuxTal37dX
	7Ou4lptWY7f0DTiyXzV3ibrZ3tYyqY4JIdGJI+HLURhPQE4gz3X2Jo+zkmY7uH7z
	Iy0lre3EqPHkfdU4igrrEIy1cujoguSBF+zB70H7Ce3nGt6+X8Xv+WbOSlnhgJ7b
	lxaemBA9XA3qiISOvSiG+YpEiDgCMUw93LtwteknAt4DoT7RSB4HqJ/jxMAco4T4
	9R+B2B8D1VTeOF7iKTMWLEzkDaVxMAxxgDKnxkDcnmHchEVnwYg6HvP0Lu0jCUJs
	tg==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: from Antony2201.local (hal.connected.by.freedominter.net [91.132.42.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by oak.phenome.org (Postfix) with ESMTPSA;
	Tue, 13 May 2025 14:34:45 +0200 (CEST)
Date: Tue, 13 May 2025 14:34:43 +0200
From: Antony Antony <antony@phenome.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH] xfrm: use kfree_sensitive() for SA secret zeroization
Message-ID: <aCM8Y9iNXmbuPD5G@Antony2201.local>
References: <20250512092808.3741865-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512092808.3741865-1-zilin@seu.edu.cn>
X-Mutt-References: <20250512092808.3741865-1-zilin@seu.edu.cn>
X-Mutt-Fcc: ~/sent

On Mon, May 12, 2025 at 09:28:08AM +0000, Zilin Guan wrote:
> The XFRM subsystem supports redaction of Security Association (SA)
> secret material when CONFIG_SECURITY lockdown for XFRM secrets is active.
> High-level copy_to_user_* APIs already omit secret fields, but the
> state destruction path still invokes plain kfree(), which does not zero
> the underlying memory before freeing. This can leave SA keys and
> other confidential data in memory, risking exposure via post-free
> vulnerabilities.
> 
> This patch modifies __xfrm_state_destroy() so that, if SA secret
> redaction is enabled, it calls kfree_sensitive() on the aead, aalg and
> ealg structs, ensuring secure zeroization prior to deallocation. When
> redaction is disabled, the existing kfree() behavior is preserved.
> 
> Note that xfrm_redact() is the identical helper function as implemented
> in net/xfrm/xfrm_user.c. And this patch is an RFC to seek feedback on
> whether this change is appropriate and if there is a better patch method.

I would prefer to use the existing one than an additional copy. If it is 
necessary. See the comment bellow.

> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  net/xfrm/xfrm_state.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 341d79ecb5c2..b6f2c329ea9d 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -593,15 +593,28 @@ void xfrm_state_free(struct xfrm_state *x)
>  }
>  EXPORT_SYMBOL(xfrm_state_free);
>  
> +static bool xfrm_redact(void)
> +{
> +	return IS_ENABLED(CONFIG_SECURITY) &&
> +		security_locked_down(LOCKDOWN_XFRM_SECRET);
> +}
> +
>  static void ___xfrm_state_destroy(struct xfrm_state *x)
>  {
> +	bool redact_secret = xfrm_redact();
>  	if (x->mode_cbs && x->mode_cbs->destroy_state)
>  		x->mode_cbs->destroy_state(x);
>  	hrtimer_cancel(&x->mtimer);
>  	timer_delete_sync(&x->rtimer);
> -	kfree(x->aead);
> -	kfree(x->aalg);
> -	kfree(x->ealg);
> +	if (redact_secret) {

I recommend using kfree_sensitive() unconditionally.
This code is not in the fast path, so the overhead compared to kfree() would 
be acceptable?

It's generally better to always wipe key material explicitly.
When I originally  submitted the redact patch [1], I assumed that in 
environments with a good LSM(like AppArmor or SELinux) enabled, 
kfree_sensitive() would be the default kfree().

If kfree_sensitive() is called unconditionally, the call to xfrm_redact() in 
this file won not be necessary.


> +		kfree_sensitive(x->aead);
> +		kfree_sensitive(x->aalg);
> +		kfree_sensitive(x->ealg);
> +	} else {
> +		kfree(x->aead);
> +		kfree(x->aalg);
> +		kfree(x->ealg);
> +	}
>  	kfree(x->calg);
>  	kfree(x->encap);
>  	kfree(x->coaddr);
> -- 
> 2.34.1

-antony

[1] Fixes: c7a5899eb26e ("xfrm: redact SA secret with lockdown confidentiality")

