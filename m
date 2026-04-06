Return-Path: <netdev+bounces-275537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODaZNqRt02mliAcAu9opvQ
	(envelope-from <netdev+bounces-275537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:24:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D883A2304
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17323007F60
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601A30FC12;
	Mon,  6 Apr 2026 08:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8230CDB6
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775463840; cv=none; b=FJl+66lzVvHQdqjX/RWjrLK6WV4lg/HpZvzyiXYasIgV4gDyk1A4TXf9+wakIUI658CNY8ZDhtyhQpU9wtknIpJfvgGCA4cu6bf7+OM7dXRwMb16TZlzsqJC9PMvRwQiHwhDqwUejrhXF9xCXoAB8gOZ38FKLogNqHwwpyn9HCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775463840; c=relaxed/simple;
	bh=BX65me5mLZQjtMfoaQ8EsoRlsDSUYlP0+9T9kUokOr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnUmGJ/jmO1I3nWEjIv6sHC2uEm+9tQGEApYQB9mrQ5mzSP6ZMVGfWT/Xn7NGGjD062Zmxc7lH+nU1SNYmHYpjXsByxg0PYPlCwqXSy1WfX6KGPXgiASxzzwMB0D2iQSEUYy7YslFZmElUztCLfjtapMFSnlxea/CnRbyXlfvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so2327650e0c.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 01:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775463838; x=1776068638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm4gmsxfzuPacthTAxy6gqvMa+aeeObOg4q/cYiuqlM=;
        b=JZPfgWzzE94R9oe8E/Nn3ZhIWKVcWIHjFlTZbca4RzXvx3pe88SmIDu3NRB/Ck+i8C
         9vemqPYSMgq9LHHlLr/wm3NhwSIS28NNHn7JawvHTAdk+/vrAaJFlfN+qmmLpR/x0bxN
         NlOSlswp3pnpVaK5m74sJ3lQSZ8Jyz8dnTNgGuy+cUAgVwTbai3TGnDw+cSbERRwu2eO
         pskamDjuJlX2J55KqrGlpRvaBUt6k0dpzmFPhH6QxVLhc0LLZnXma0DZ6bi9vdNCq5Hp
         6ikizmZLkxH9d5Po2YCqzjA3SY9Wn1b87I7nf4xkJskpBimoIH8RwcnKReR3YyXOf1tr
         ASEw==
X-Forwarded-Encrypted: i=1; AJvYcCXKYmRWHS/RizRmBq5i+T4xDcxbU8N+iwPBxT+3GPPA2GrQSrSvU5dsaCLNbnRhQJIC0ysCuhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXdWwBKSjZvUMaYdPpEl5GiJXUnHCsEckM0a/m5xSiA1Gk6se
	oh+D2McCRQKTg+aT1ZV1GfVUM71EckJB0oTE7DThVzHoZTKzpV6ivHWBA/ncs2t/
X-Gm-Gg: AeBDieui7ClhzRduNEBroR3hjyhuzHu55EkiLE89+CESV3liHejFGDuPVK3+OMW6VhS
	/cVgndcayena2r23I/MB84wWuuvOWP4HliMQFULsP+FLTtV2ESn3ZdGRxghMwT6bLtDpTGjOWja
	MXjVyundnK60WQm9DdnmB8vubkUKzd5sjDxUDZvczMnBwhrfBGxbNpjjK36v6qDk84QdDME38mc
	XBTCzliUwLjzyINtYRQs6JjfAF9720Kc+2CuMJV8SEqx5fhn8ST4pn6+dAESxee99RJEZ26VMQ/
	Ma9azCkL+Wkdck9pqoO0p3ipeUruXw6tmLj4AM+Hw3iLV3HA7yKdX/E9csQk4hAfPf6mMF9pQJW
	24PFPU5PeeEMkCaXTrXAos9fFb9IVRGboFVnYMs7S7OihlCvvsO4023Q8+Fnk+FGwlK0mrG3b9U
	WoCRc4Y9MOhlRG+AKJRBgYoacrgc3bcHtBm/5CXIWaHl6KXq/qr8htALDEVtuFfy8w
X-Received: by 2002:a05:6122:c86:b0:56d:2ca7:fbc3 with SMTP id 71dfb90a1353d-56dab88bc0emr4096188e0c.5.1775463837923;
        Mon, 06 Apr 2026 01:23:57 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9bb4csm15408261e0c.10.2026.04.06.01.23.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 01:23:57 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso4320954e0c.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 01:23:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJkpO50oG20tSLn3Oq+modWbBVPe6hPILLghBEtDM+n1A7m02CDODtTNGwAZGvQqqULllHDxs=@vger.kernel.org
X-Received: by 2002:a05:6122:1684:b0:56d:a7d0:e6c7 with SMTP id
 71dfb90a1353d-56dab81d7f4mr4227715e0c.1.1775463837126; Mon, 06 Apr 2026
 01:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402145858.240231-1-julianbraha@gmail.com>
In-Reply-To: <20260402145858.240231-1-julianbraha@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Apr 2026 10:23:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
X-Gm-Features: AQROBzAqL9rNRSn7YSRIrLEUG739hJGVEAMTZghBzjMy3CbjG_piq-g7yibHfdM
Message-ID: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
To: Julian Braha <julianbraha@gmail.com>
Cc: davem@davemloft.net, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,st.com,foss.st.com,gmail.com,armlinux.org.uk,kernel.org,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-275537-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_SPAM(0.00)[0.832];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 18D883A2304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Julian,

On Thu, 2 Apr 2026 at 17:07, Julian Braha <julianbraha@gmail.com> wrote:
> There are already 'if STMMAC_ETH' and 'STMMAC_PLATFORM'
> conditions wrapping these config options, making the
> 'depends on' statements duplicate dependencies (dead code).
>
> I propose leaving the outer 'if STMMAC_PLATFORM...endif' and
> 'if STMMAC_ETH...endif' conditions, and removing the
> individual 'depends on' statements.
>
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> v2: add back default STMMAC_PLATFORM for DWMAC_GENERIC
> Link to v1: https://lore.kernel.org/all/20260331125817.117091-1-julianbraha@gmail.com/

Thanks for your patch, which is now commit e2f152c822cf5d37 ("stmmac:
cleanup dead dependencies on STMMAC_PLATFORM and STMMAC_ETH in
Kconfig") in net-next.

> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -20,7 +20,6 @@ if STMMAC_ETH
>  config STMMAC_SELFTESTS
>         bool "Support for STMMAC Selftests"
>         depends on INET
> -       depends on STMMAC_ETH
>         default n
>         help
>           This adds support for STMMAC Selftests using ethtool. Enable this
> @@ -29,7 +28,6 @@ config STMMAC_SELFTESTS
>
>  config STMMAC_PLATFORM
>         tristate "STMMAC Platform bus support"
> -       depends on STMMAC_ETH
>         select MFD_SYSCON
>         default y

This now lets us have STMMAC_PLATFORM=y and STMMAC_ETH=m.
Does that actually link?

>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

