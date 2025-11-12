Return-Path: <netdev+bounces-238064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB53C5372F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AECA3469E2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57133970D;
	Wed, 12 Nov 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vJ26Nqr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oiAJR3WG"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596542550AF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964963; cv=none; b=kRP9wWZ92swRZUXGEVKGrsEB6nhaqZTBoyoYVhJViYkTX1RGNhdVc3VAnqwXL0BAy3BHHeSoeyk+EYt5PQc1Deu6AXJ9MROmk+/OF+NWk0Mg+z6JQQugaLKBLAoAKb6hBB3k05/tm9qv8P85UdCEPWCWUPb6gETBlz6ousN6WxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964963; c=relaxed/simple;
	bh=9ZAyfBSZkjFw6t6tesPjp89F4i5/XToxggH/Myp7Hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx+UL0bE+uA9ndt9m0g0FKmwJLC2oZiM/Nc11gn1AagP+PdizS9T1M5ephTU3pTRvQx4H9CJELl4jCfe+2RVjng/l+E6Mg7PXDAC/pY/JtmLoC6M1KIRw9D3VQQo+ouO+tiSFYfrG3JiI0qlJqjxMncBZFxVtYaKqAozFqI/RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vJ26Nqr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oiAJR3WG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 268DDEC02F1;
	Wed, 12 Nov 2025 11:29:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 12 Nov 2025 11:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762964959; x=
	1763051359; bh=xA2MNB57MGhHXw3GXGUNElUFH16jvV2Gk1L1LUDJRC8=; b=v
	J26Nqr/J2Lo8ai3+UUixCP6iCi+mtMxyZ7ytvpprRxrvlUze/Y3P3KO7qBCurScw
	okVgPnHzvLaMdMnqjCI8cyQZ2wy1Tg+vwapzFU0KahuI/2SIETphjk6usJaEJsVf
	ciZJf2sWFt8wEMsY+TzY+pj1c3j/1hpEv3bzwPNj/KcLHYvje4AitUgeFKc4HOgv
	00olluG4RwnOaaHn/cNaeTE5PTE5ISb63B1sunmzKZWIjrQhgvkSQj3mHtxtShpM
	pf+XRz2t6DuLoeY01f/lsOJJ7PPNc0MV4mujAVEaw5Hq6alLgT4hRggGs3P6Jbnq
	41MikdnPOUGMlJLwhIFvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762964959; x=1763051359; bh=xA2MNB57MGhHXw3GXGUNElUFH16jvV2Gk1L
	1LUDJRC8=; b=oiAJR3WGVEYC9SjNGwvW3+IZ5T0vdiByCipabFK9vOuZXc0JE8x
	r0zYzQq4oVKq/fHqDf9ypxi0ZoIyiVntNoCiGQhqoFm7SO0AgAUl2RfSgqH4it9e
	x0LcQQZry0cgyGXmdynjNs7XEp6FrBsdzs8mIJbyC76pJaaPmBv0sWGAgmZ94uO9
	HDrYdSj2JPWeQ0CskRzTJJJnRRg+mzpIJdkaSOnaHCwp8MGVlO5HA8fJeGQRZkn3
	QdrbY8U1bOI29sCoJwgDPR4LtIRhZIEqYSJ755A5t8zaE7yFH/8k6D+qJV9/mwGv
	NCkBHlbSNCUXgnbERMkBwZ8B1PduWpjxBdA==
X-ME-Sender: <xms:3rUUaaNpHjHAx2xoklqCf6K5iOoCoCuExRmi1-ugt6FFK3YKZCYVTg>
    <xme:3rUUacqtkPDCMxbOQzDLv_HlvFLuxmjjKCv0WxLLgqR0Av0waG23He2_MxCNhHrlA
    9SE3_NPtOyUQ1b777DwaQ3RTkr5l7yJQBZIzpEcLTv3wP2Yz9e12pQ>
X-ME-Received: <xmr:3rUUabHVuBTAhPxZjR2ZxWA5-Q8XHKHpPBHVhsxAgiBZSaX-y_-gUzstu80Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomh
X-ME-Proxy: <xmx:3rUUaRpyyUM25Z9z-FpLf6AeLt-cfTrfp-YoNoxj6GVomhh8fFxrKQ>
    <xmx:3rUUaUbAtvvN5jTEf-pil7mcXfVCB_wtE9G_zyzg63nPMhYfWv79Lw>
    <xmx:3rUUaaXgRuEwuqq2Yi8vYqywAox3Y76zRN3_HWjfOiwkKZRgK84L7w>
    <xmx:3rUUad9aJtVKrFeeYz2FwgSzPlprwhkPccZPI7o8bIH1CozEGFYL4A>
    <xmx:37UUaTWi7QOBzdNCGlAG9qcXGYBjSEYh5fX0RDRIGTuClhRd7X3LLtPH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:29:18 -0500 (EST)
Date: Wed, 12 Nov 2025 17:29:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in one
 chunk
Message-ID: <aRS13OqKdhx4aVRo@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111214744.12479-7-antonio@openvpn.net>

2025-11-11, 22:47:39 +0100, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Currently ovpn uses three separate dynamically allocated structures to
> set up cryptographic operations for both encryption and decryption. This
> adds overhead to performance-critical paths and contribute to memory
> fragmentation.
> 
> This commit consolidates those allocations into a single temporary blob,
> similar to what esp_alloc_temp() does.

nit: esp_alloc_tmp (no 'e')

> The resulting performance gain is +7.7% and +4.3% for UDP when using AES
> and ChaChaPoly respectively, and +4.3% for TCP.

Nice improvement! I didn't think it would be that much.


> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

BTW, I didn't see any of these patches posted on the openvpn-devel
list or on netdev before this pull request. Otherwise I'd have
reviewed them earlier.


>  drivers/net/ovpn/crypto_aead.c | 151 +++++++++++++++++++++++++--------
>  drivers/net/ovpn/io.c          |   8 +-
>  drivers/net/ovpn/skb.h         |  13 ++-
>  3 files changed, 129 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
> index cb6cdf8ec317..9ace27fc130a 100644
> --- a/drivers/net/ovpn/crypto_aead.c
> +++ b/drivers/net/ovpn/crypto_aead.c
> @@ -36,6 +36,105 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
>  		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
>  }
>  
> +/*

nit: missing a 2nd * to make it kdoc?

> + * ovpn_aead_crypto_tmp_size - compute the size of a temporary object containing
> + *			       an AEAD request structure with extra space for SG
> + *			       and IV.
> + * @tfm: the AEAD cipher handle
> + * @nfrags: the number of fragments in the skb
> + *
> + * This function calculates the size of a contiguous memory block that includes
> + * the initialization vector (IV), the AEAD request, and an array of scatterlist
> + * entries. For alignment considerations, the IV is placed first, followed by
> + * the request, and then the scatterlist.
> + * Additional alignment is applied according to the requirements of the
> + * underlying structures.
> + *
> + * Return: the size of the temporary memory that needs to be allocated
> + */
> +static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead *tfm,
> +					      const unsigned int nfrags)
> +{
> +	unsigned int len = crypto_aead_ivsize(tfm);
> +
> +	if (likely(len)) {

Is that right?

Previously iv was reserved with a constant size (OVPN_NONCE_SIZE), and
we're always going to write some data into ->iv via
ovpn_pktid_aead_write, but now we're only reserving the crypto
algorithm's IV size (which appear to be 12, ie OVPN_NONCE_SIZE, for
both chachapoly and gcm(aes), so maybe it doesn't matter).


> @@ -71,13 +171,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>  	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
>  		return -ENOSPC;
>  
> -	/* sg may be required by async crypto */
> -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
> -				       (nfrags + 2), GFP_ATOMIC);
> -	if (unlikely(!ovpn_skb_cb(skb)->sg))
> +	/* allocate temporary memory for iv, sg and req */
> +	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
> +		      GFP_ATOMIC);
> +	if (unlikely(!tmp))
>  		return -ENOMEM;
>  
> -	sg = ovpn_skb_cb(skb)->sg;
> +	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
> +	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
> +	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
>  
>  	/* sg table:
>  	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
> @@ -105,13 +207,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	/* iv may be required by async crypto */
> -	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
> -	if (unlikely(!ovpn_skb_cb(skb)->iv))
> -		return -ENOMEM;
> -
> -	iv = ovpn_skb_cb(skb)->iv;
> -
>  	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
>  	 * nonce
>  	 */
> @@ -130,11 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>  	/* AEAD Additional data */
>  	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
>  
> -	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> -	if (unlikely(!req))
> -		return -ENOMEM;
> -
> -	ovpn_skb_cb(skb)->req = req;
> +	ovpn_skb_cb(skb)->crypto_tmp = tmp;

That should be done immediately after the allocation, so that any
failure before this (skb_to_sgvec_nomark, ovpn_pktid_xmit_next) will
not leak this blob? ovpn_aead_encrypt returns directly and lets
ovpn_encrypt_post handle the error and free the memory, but only after
 ->crypto_tmp has been set.

(same thing on the decrypt path)

-- 
Sabrina

