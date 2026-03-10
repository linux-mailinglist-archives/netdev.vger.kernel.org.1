Return-Path: <netdev+bounces-266347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB49I2yOsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:34:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6E25858B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB5853022597
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2B3B0AE4;
	Tue, 10 Mar 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw1PdunN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9F355F2B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178470; cv=none; b=cX/lj8a8+dozG5LtJRPVQXAhZ29fzxUvy8EW9zocgbPvFQ49KNkwB8s6/RQylUnhBHYrY99c1siw0agVjP2VzAmG22ZULpPu6HaQULz21xBdgL5I6ZEGQOG+TF0wvlyOIm8iWcwRwGrvIUkVkYSXp9vRjx20YvTyoLFiIwkydtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178470; c=relaxed/simple;
	bh=kugXFntQiGrBA5LktHgKLzXFY9CjzatEh5uzKMEFpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quYs6+nh2hUvN/9StjLnEPVeuxDSGkm8gLLLtseCxgF7sMk43Kr+Rf2rwA6858Mw5/jWuhekNoftcmyyoFHdOs2egOLFONRI8K8rkzu0IXMkew5FeBq8bsJAhrLP0lVlQbYhqIJ1waWkhWUFHjB/L/ntv9YaHS7K0brALInFUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw1PdunN; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12732e6a123so869859c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178469; x=1773783269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk9iz62e9Zzbp1FSdoEUGk+EwY4bkDsWcYwExbvR3YA=;
        b=Gw1PdunNxpjLtMwSELRxIy+VD5w5fbSqgjtINFTvllS7MnNtHejkqVO9OkpEcGMjgd
         lfm8u/RBxtUkwMwz2LaPlUo4355/As0n0Z/vEHT97PtSfgw54MvJai2jYQv53gKIK/Sk
         NvD6Tm6gogdK9YMxTBsddZoMkYdSOV+eWPZHNg2UfQVjE4il67bag+oUqovGL4BfDAp/
         thEvGy4yGs+g7eDjCJYZvjAuy2favu67KrU3u3Ck9d5xHzScWnxQnht+cRKqUVXKKJIQ
         l66RjqQ3U78SxXKqfnz6iEaG8zAvaPDv3dyTlOX5Mfb+4ofcstCw0HYz8ge9NGsOFd8Q
         citA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178469; x=1773783269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk9iz62e9Zzbp1FSdoEUGk+EwY4bkDsWcYwExbvR3YA=;
        b=a70BEUQp0QRvsga7uH8p0X2My8AeSeeMlq+w9eCaMnEAkUmjaX8CfCa9E16JpEbeqm
         viGicATw4gyOitrNYuDSet1iKVxwm5r6J2rrpH8/Or9tETH/j3aMr/Pzrx8VcRckbdX+
         2G+0GQWmSw2EwTjovk5f/VaVLm7+hKZXtAOjqG+g5oeyAd+BtXEWA2aYj7YTkA9y1O1F
         TEJPzIqEd4fOTaF64RjTrNr7q1sR6a76KGf5dBmI0wBJ8S240UKsCVSNVmshmQuDhibV
         78HjPA7/s23iKkXTn4CVfTrhKtrx3vY+vkC8AYzMwxNh6UVLH73fiN0FQsKeoJCBB/Sj
         KyKg==
X-Gm-Message-State: AOJu0Yw47AhZtpmSW96fOZZCLpYa2uERM9Db3iL4Uulr97yslGOgjQT8
	KI3HIRssYwRc4dW53Vm6sI5bL4w6SvCHKR8LVSF+6uYr7283tCDMCkE=
X-Gm-Gg: ATEYQzzx8bPMx3NHU7rPdxXxvTooKLRs1E/YKAYVbDUD8ajB2/w+W4N48UMf2Fp/l4r
	eG9PQaJgJ3CWKaDONnO4wqlDkPl/xSjYv5tJw7Y4ifkqZDxf3WNT2mFFOXV+V4ANvc6RbggZlPC
	axD+xer9XdqxjX3ObQyZmbiUFuMsNn1gPD9VuOj31Fi0vugtNdWHw4aJqmitFN+PgsAz/LUEUvx
	wWrrJgDvZLVe7B+pn/tItthjxZdOifH9V2Z10gxzH21/mb7lRBmKu3bjQy3S8hQgsZnC3CB3I20
	qXvSOouFABczSA1ALBwe6d3WgpAUn9WI3RKkG90oUb7aszlL7shyjtBXqOn+XkfGwH2SmeXPEw7
	HyArx9R6wPr6xabYgRYRPkUJCLjjhWHgMunuUlbXMGc7hCPbPfCP36+jZZEUg4RNmPJN4O5/ZLj
	50NCAnsRcY7ca232t+ot26YowJM8J90IjvRLA6FrPlCxZI/ecEHS7uPP9twhbdJ+4BO9Cv4JszF
	xby5wz8wmXxzxp5Mg==
X-Received: by 2002:a05:7022:78e:b0:128:d4be:7415 with SMTP id a92af1059eb24-128e784b788mr143093c88.34.1773178468586;
        Tue, 10 Mar 2026 14:34:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7cd6aafsm89761c88.14.2026.03.10.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:34:28 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:34:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: remove doubled defines
Message-ID: <abCOYwySxuQnkq_k@mini-arch>
References: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310134327.422540-1-maciej.fijalkowski@intel.com>
X-Rspamd-Queue-Id: 92B6E25858B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On 03/10, Maciej Fijalkowski wrote:
> Seems we have been carrying around doubled defines for unaligned mode
> logic. Remove one of them.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/net/xsk_buff_pool.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 0b1abdb99c9e..ccb3b350001f 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -174,13 +174,6 @@ static inline void xp_dma_sync_for_device(struct xsk_buff_pool *pool,
>  	dma_sync_single_for_device(pool->dev, dma, size, DMA_BIDIRECTIONAL);
>  }
>  
> -/* Masks for xdp_umem_page flags.
> - * The low 12-bits of the addr will be 0 since this is the page address, so we
> - * can use them for flags.
> - */
> -#define XSK_NEXT_PG_CONTIG_SHIFT 0
> -#define XSK_NEXT_PG_CONTIG_MASK BIT_ULL(XSK_NEXT_PG_CONTIG_SHIFT)
> -
>  static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
>  						 u64 addr, u32 len)
>  {
> -- 
> 2.43.0
> 

All consumers seem to be in net/xdp/xsk_buff_pool.c, so why not remove
the defines from xsk.h instead?

