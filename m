Return-Path: <netdev+bounces-262585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJXbAjpbpWlc+QUAu9opvQ
	(envelope-from <netdev+bounces-262585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:41:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECE1D5ADC
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67463027365
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7A38F63B;
	Mon,  2 Mar 2026 09:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3504A1A2C0B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444469; cv=none; b=itI06b/HqjkrlJYO51lF1/K3q6ngIaAFEtikfyhIcClE3VLgxpeXxyzXcjU9ELezsyQnUW4T6hY4s76HwjXMZYUdzu4jdfF+B1r2RU5QswknQUWt4Olg7Ohdlb2rhlfUhVHuMCGxnI+6YaNaCsSzmLePIXFI8Fc8wwOHDLegnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444469; c=relaxed/simple;
	bh=Ez64KVPyUYsQ2awF9e6vDqNmteH/+x0+y1/m+pgXlFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVcNxnhtSXEHQRmVl1BYqWEOaTDCKkEk4WJunrI2uT47LZds/tpGd1fDimV4T3AnG2F7/eT0eSx7cu7+E+L26VjolZhkhR8Lzsc3rxXfW7UASzT3g3A2VLZlIm+ekXKnenyq/YUjvhUCfQRfF50JIO2m2a0d9gKKYJZAactEln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a87d7c5d7so3461711e0c.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 01:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444466; x=1773049266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVUkTgXHkbBKhiDnIN0oTaONlF7U4tUeTKHJdKgOm5w=;
        b=cfIhQTniFIMWbNy9/VLfZiJNiiSHcSKHC/oZ3y4wYn3zJRrGC/hBsosa15cGcFYZZq
         5fIOIuI1lvU4sfH/74ZxM+g2sbhY0EdzUxJixnXQydyi5LVDMeWYyoMNa90qJuv6D6d5
         zip2Zk86y1EUQi5+IALZBRPylWlZtz9T5YxlsF/oQ/i7eFwTw0kfCXVoAqM3HP/iftl1
         lpvTFptCDMBjfia8W0TuCBvWnpJ+kSzgnlu9j1MNhoYD1Maa05QuJ1OGVgcSech7t2W0
         LYZXiJF8hJTBtKlWw6l8DaCmQp8ZjdYe7X9Uwel01TxyG9H0uH+6nzcOtQtNijeyzo8R
         kL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBFY3U5vo+/idbmRv5BI9ADhHnSoV9lR3r3zlb/HqT6gWr+wbmBFCsGWLolUD8TihS8ksmpD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4A0ES+NFXsWhH67PgiYgwcZSOEQPyq9wcqepVQkbwDA83rvs
	ZhQ0aPfqUWy4LDQwTbVRSv89jayoyXnfxVC66f153fCufCS/2+KPKkHgWj+GniNI
X-Gm-Gg: ATEYQzyNHApvqWdiEvalThxYxk+5HFeQhRxpiMXvbWsSlcYys5ebo42IwsXgrnuckBW
	LfBrd0q5br/VceG5TVVOM5SkXa7YdAaR8O+HWp/ni/VEfJdpem7Qr0tYrHpo51zymrz+XcJY+gf
	yBrCpolLkCRmhM/sF40q9JFAWsN0aH2pFOu82+uVwUmScOToO1mq5B1P7wMr+JIaVRWdg/I7F1+
	r7a9xys6nLYyAqHLQgLDEZyyei+/3dXwFS/nVQ9LrG8eiDw/x9WqEs5+QFQ9+R5wriOrmBpRB9P
	1uoCyGYjguA/q+BMgfarHmQ82J2MQNL39fZ7ZGXnlsu3dBt3ZebEVYGcwTScGjRBGvFAWy4ja5p
	OQVVCqkxAdMQldju2IeibJSSJCtAGdTXT8ZSugBaT2LRUg4lBDHcTejm2yfLffA8cm10K08Q6Df
	apIOWfCT4g2omu/Jg8y6VKIgJ3keb+G0SMYwfjs9CJscARwOjKS/Y7GRvuv96h5Vqzwrazu5DM7
	Yw=
X-Received: by 2002:a05:6102:3747:b0:5f5:3619:8bd1 with SMTP id ada2fe7eead31-5ff32494193mr5490530137.25.1772444466007;
        Mon, 02 Mar 2026 01:41:06 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6f03sm11470580241.3.2026.03.02.01.41.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 01:41:05 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a976305b3so2899076e0c.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 01:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPhY8Q4AlJ/2QkMqQQJ140ubtORgVEi+tD0ht4TrTM+ItYBrapId8uUkZMMJD5QzxFjH39a/U=@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f5:3619:8bd1 with SMTP id
 ada2fe7eead31-5ff32494193mr5490525137.25.1772444465487; Mon, 02 Mar 2026
 01:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com> <20260228180821.811683-2-seanwascoding@gmail.com>
In-Reply-To: <20260228180821.811683-2-seanwascoding@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 10:40:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
X-Gm-Features: AaiRm50IkzgTnKIsbY1hU9x7p3C6C39FPDtFYhWApldWfRRArQZieFo-6dS1RfY
Message-ID: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262585-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_SPAM(0.00)[0.186];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email,lunn.ch:email]
X-Rspamd-Queue-Id: 7BECE1D5ADC
X-Rspamd-Action: no action

Hi Sean,

On Sat, 28 Feb 2026 at 22:29, Sean Chang <seanwascoding@gmail.com> wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
>
> Following David Laight's suggestion, simplify the macro definitions by
> removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
> directly. This ensures the compiler performs type checking and "sees"
> the variables, silencing the warnings without emitting any code.
>
> Additionally, fix a build error in fs/nfsd/nfsfh.c reported by syzbot.
> In nfsd_setuser_and_check_port(), the variable 'buf' is conditionally
> defined via RPC_IFDEBUG. Since no_printk() now performs type checking,
> it triggers an 'undeclared identifier' error when debug is disabled.
> Wrap the dprintk call in an #if block to synchronize its lifecycle
> with 'buf', following the pattern in svc_rdma_transport.c.
>
> Link: https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.com/
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

This should have been fixed alteady, cfr.
"Re: [PATCH v3 0/3] sunrpc: Fix `make W=1` build issues"?
https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@oracle.com

> ---
>  fs/nfsd/nfsfh.c              | 2 ++
>  include/linux/sunrpc/debug.h | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..f7386fd483a6 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -106,8 +106,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
>         /* Check if the request originated from a secure port. */
>         if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
>                 RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
> +#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>                 dprintk("nfsd: request from insecure port %s!\n",
>                         svc_print_addr(rqstp, buf, sizeof(buf)));
> +#endif
>                 return nfserr_perm;
>         }
>
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index eb4bd62df319..cb33c7e1f370 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -52,8 +52,8 @@ do {                                                                  \
>  # define RPC_IFDEBUG(x)                x
>  #else
>  # define ifdebug(fac)          if (0)
> -# define dfprintk(fac, fmt, ...)       do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)   do {} while (0)
> +# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> +# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
>  # define RPC_IFDEBUG(x)
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

