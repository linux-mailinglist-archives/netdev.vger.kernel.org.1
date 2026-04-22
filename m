Return-Path: <netdev+bounces-280335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LzqATp66GlvKwIAu9opvQ
	(envelope-from <netdev+bounces-280335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580C0442FAA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1197C305E2F8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638D372698;
	Wed, 22 Apr 2026 07:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E437266E
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843080; cv=none; b=uGBpJyOIGsMWALl+EaIEs8suD6eF4R3JYWu3KL5ZjLukEqxWNF63LLiXtWhzHx5ypaSNCpN43MSX7XXbCpTR9x2oTdiikXgZDnXamW9e6hGnICCE6Mu7ef/XUO/ipjqJvcek0e4xUxhtRHnqV3GnbDJ9kkPLEb67WK0fCxXbf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843080; c=relaxed/simple;
	bh=/UWyFxIqZ0kNMlHfoi7yu8dKm9vFSeq3QcEOL4MLFuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL+OVq3d68q5cFGFn97GXVKoi7FayHTirHG3JljSSvF4yHuNws1ydrky6Lehh4q9GHiq+isSMc3DEf1g/a0P61D9lRGK3HMFbcaVvvgpSgre+S1AH0Uzu3vIb6dV/iJzwLgz7a9X8+1x9W8o4se01HymWt0ym8TKjjNLG0nCaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56f6afbd205so2577465e0c.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843078; x=1777447878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQwgq6EqJNpFWLWCEPv0RlVhigX0dz3qmgahm/Rlf/g=;
        b=NLSnBy6NerWq/YIK9hmMgJVJAFvBtyR1fKjmh+unpeEY3/fivWwmrna17mIqMCUc0N
         66Du0BZy9cXVDKTVlptA0kVxS9NMSdRoaaXXB/bXIWlh4KUNtThar7HbPXNCnox0dXH4
         psgzsVViZMOaeRbx8BUoPnrTSgPUu4GTxNROwiAqHKlSmFtPkRUE8njxuLUizttjAjxn
         6g1nf1M6Pk0yKNKMO7gJXSDOnQP+SWHyAFaNUuvFX01EAfUvkXmgSa+ParF0smd7hYA2
         T20U+/vqwS6rGLvsgUv+7RJdhJkZbfTiKdNjzoiXAtqTj3qsyL+XZwklbqj1u7bh0Yg7
         ndWg==
X-Forwarded-Encrypted: i=1; AFNElJ9F9A/msouLQ8+2NrV7+uo/uxJh4Ex28aXcM/lGEPXVmoaOGiG9m88V2lOF2bdqdTmu0yftcOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9QWFtgcRFayKBJEVxiasN6O3WCSmNyCBSY8Tk5muJ9TNZHuc
	m2ZOBQae0t72zd1D13NBNK6werKXiJpehne0+HBkSAIfMu7FOo0HdKtzS9LTfKq16MA=
X-Gm-Gg: AeBDiesyQZKS9jMnEWLZ1CMVk03ezQFUFMiAfCCaH279KuI7LpqbdRk+hvyU+7tKk+I
	A4xIo7WAjfiWLgyNinBxD5pjYkpVUFW+xf2IYlW+oHJPjbRSgqz15Kq+YBBAivYqxIswFbEzat7
	/FmpE0zXL5jX0E9CGQ23p4bkmLEtYFVIecQQ8QNjstyG2VXMIODikS0vj4PF3oLh4DTiI/wn+Cx
	17LRXJipgBo/orcdo2ga90fZ+bBMr4HM2LB3DL1Y2/UXGR9TydXtB7+24iFgXTdcKS5yj9dl21m
	BKOumD+6sVY9S6hbhGfH3xd1HYsThcZx/Mh1qy4THlVrsO8FbEd8p2V7WsD8wQed3J5Ib86vmWJ
	n7sP6Xb2EnO0szG+r4cqe7HzD1U8KJroLTmZMprZgJcFVWN5PPdUSWwIk3EvLYD+fDKgXxTRWGO
	bRjTKhwOvEEZVzlWvUM/3i7uzBJol0RW9IzC3XGh5cJhO6wcCJfvlo102B60ioJGgzlSWyjzI8t
	zc=
X-Received: by 2002:a05:6122:2bcc:b0:56d:892e:e291 with SMTP id 71dfb90a1353d-56fa66d07f0mr5635961e0c.9.1776843078165;
        Wed, 22 Apr 2026 00:31:18 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91bfb7asm9550069e0c.4.2026.04.22.00.31.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:31:17 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56f72d27e7eso5202213e0c.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:31:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JP3dk3Q1L9x8+TmJ+nsu3B178lr/9TJutcg3IvWpUpZsf3YoBGUAzsDE4iKmN5OSkowg7Fzg=@vger.kernel.org
X-Received: by 2002:a05:6102:5a93:b0:602:8742:1fa with SMTP id
 ada2fe7eead31-616fc3bb2f8mr7873346137.9.1776843077349; Wed, 22 Apr 2026
 00:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <20260421-v7-0-0-net-next-driver-removal-v1-v1-11-69517c689d1f@lunn.ch>
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-11-69517c689d1f@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 09:31:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz=ucmKxHXmzKj=oTn6yMVxPnkNxtG6X2C3ts_ZCg4Cw@mail.gmail.com>
X-Gm-Features: AQROBzBru55g_Cp5qhyGna3PYI2tAgoVWvZO0sTyGM38iTeLxvBDeekBc6dxHxI
Message-ID: <CAMuHMdWz=ucmKxHXmzKj=oTn6yMVxPnkNxtG6X2C3ts_ZCg4Cw@mail.gmail.com>
Subject: Re: [PATCH net 11/18] drivers: net: cirrus: cs89x0: Remove this driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-280335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 580C0442FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On Wed, 22 Apr 2026 at 03:04, Andrew Lunn <andrew@lunn.ch> wrote:
> The cs89x0 was written by Bonald Becker 1993 to 1994. It is an ISA
> device, so unlikely to be used with modern kernels.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks for your patch!

> --- a/drivers/net/ethernet/cirrus/Kconfig
> +++ b/drivers/net/ethernet/cirrus/Kconfig
> @@ -17,36 +17,6 @@ config NET_VENDOR_CIRRUS
>
>  if NET_VENDOR_CIRRUS
>
> -config CS89x0
> -       tristate
> -
> -config CS89x0_ISA
> -       tristate "CS89x0 ISA driver support"
> -       depends on HAS_IOPORT_MAP
> -       depends on ISA
> -       depends on !PPC32
> -       depends on CS89x0_PLATFORM=n
> -       select NETDEV_LEGACY_INIT
> -       select CS89x0
> -       help
> -         Support for CS89x0 chipset based Ethernet cards. If you have a
> -         network (Ethernet) card of this type, say Y and read the file
> -         <file:Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst>.
> -
> -         To compile this driver as a module, choose M here. The module
> -         will be called cs89x0.

This is the driver for the old twentieth-century ISA device...

> -
> -config CS89x0_PLATFORM
> -       tristate "CS89x0 platform driver support"
> -       depends on ARM || (COMPILE_TEST && !PPC)
> -       select CS89x0
> -       help
> -         Say Y to compile the cs89x0 platform driver. This makes this driver
> -         suitable for use on certain evaluation boards such as the iMX21ADS.
> -
> -         To compile this driver as a module, choose M here. The module
> -         will be called cs89x0.

This is the more modern DT-based part...

> --- a/drivers/net/ethernet/cirrus/cs89x0.c
> +++ /dev/null

> -#if IS_ENABLED(CONFIG_CS89x0_PLATFORM)

[...]

> -static const struct of_device_id __maybe_unused cs89x0_match[] = {
> -       { .compatible = "cirrus,cs8900", },
> -       { .compatible = "cirrus,cs8920", },
> -       { },
> -};
> -MODULE_DEVICE_TABLE(of, cs89x0_match);

[...]

> -#endif /* CONFIG_CS89x0_PLATFORM */

However, no users of these compatible values ever appeared upstream.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

