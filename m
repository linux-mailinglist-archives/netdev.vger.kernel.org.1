Return-Path: <netdev+bounces-275552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ddm4LIN/02l/igcAu9opvQ
	(envelope-from <netdev+bounces-275552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 11:40:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049283A2AC5
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 11:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26AD13010D87
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086031ED7D;
	Mon,  6 Apr 2026 09:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15C2E6116
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775468416; cv=none; b=WYOv4/xyNIQ66WOEF4yNEl8IjRzsQL+JWTDm8vnflyYJHPYquhl9d79c7Tmp9Qjj8kecEEPyzsxNN+0RNtpsKCMYbz4N8J9OmkDx/VwfVRNv4NK4ToAyMGeIrne3ZoVLz7GS6vXsbHYj9CqS5/5WWMWau9jA9RrfUt9ilWJVwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775468416; c=relaxed/simple;
	bh=guPcM/1TpLQ4xlArYto3zdkhVSpU1xI2Xk9woLUd+VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIMt5TyoZxGrkn235SkXjPocdYY3u6EWELDgmmhAJ3fPO5jmGtqZ1BA3OXequl6616Zg2GP4Xq5dFqzxk+pb05CijRQZL8qxik4DQBStIwuVToMjN1bhjvp84heHwCGLOgw8I8AXZqn/1ip8Ij7qk6C4HIx+dgc48uzdjNYVLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5637886c92aso1631582e0c.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 02:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775468414; x=1776073214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EBVPa5+SgsD0dXnuD7pGvS4tR2VULAk13x8kX/y8Fc=;
        b=HCSre5j8D4m6bQjzP8I+P+gHh8Kcaixlv2Kc+Ftx8fyG0FjBA9AphCmaEpJS5QPGf7
         WpIa3UfzIEgjRkE/r2gQ5/eYRgV6T2R9TXcLI6fUxs5mrXErzUBUuD0e9Doh4b/z5cj5
         nAGL2nw/hOSMZ58v8LTb5NqxexSG8LuVNiGJZjzcVk8dyCQIINHHZ0VuuJ3bumW+CtVU
         zXUYkPTgH+k800Mcu25LbSGJ0EpTRedRfup59fQCLdbcyfZS3QpGaopqIOjDRwuKJpBK
         Lu6QIpsHt0hZurHOheOkb6XTfsq8x600Yx5R1vihxJHJS4dx65wNduKXBa+gtbaxHjo7
         XUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3/j45s/ZB0rO1ffszof4HRIlHmdw89FRG9zj9G4PYy1TE+14lm4ZgUnJSt51QuqIOn1xq+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDWIeSZqtw1FoDDAL/NGV8nJOVN/9EA7lYqHoerXMl4DHcia7
	yQzToXB3Wl5c/A1MQj5AA4iWvh3tZ2iskMe0YcUg+vUABNM5Gz3zwdF5q6/mY99u
X-Gm-Gg: AeBDievyaCav6EYhHgryvjXThowIQjZgvyAEbWwgyijqpAKRg/FLwCtJYpca+2ORPn6
	xcVQIlFf8w2WS40twIttLGNMEw5IrZVHzMnjOvLgBoiX+cd3moP7NRGOXeOgHn6ePulWTUWmSlP
	Y7TKbcYX4d0Pzd2MQFkP9Bkjy+C4V8l6IiJvagDoUSxrSTUsm1vtgteBIvENPt8TrzQYZUJW5Nf
	pz3Odsh8wWv5uCTKuFzFVfBO3xd6x5NBn5/HtVCTHTEXY7UGHo0wPGRncLY8+c7LmXB8I3JBR85
	lhTo8CoWXLykQbKRreIqhOUfgUboDgX4WmhnEsyQKs+A/LYQ1c98U8xys41tl45lqrLjIUsc2ne
	CKYq6mqbxXuae6T01NhHD8KJc4wnyQYCcN2RWqO26RXLZTHtQV6D5x65CG0bB2cDAmpi4c4RFFH
	vqbUlB9uC8cu/iaVbHUfeHLnpXrUtdqUsumFjScz42/KkBLrPUFEZehzEOftaU
X-Received: by 2002:a05:6122:1687:b0:56c:d58e:8c0b with SMTP id 71dfb90a1353d-56dab996dc3mr3349573e0c.10.1775468413805;
        Mon, 06 Apr 2026 02:40:13 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bceb2e6sm15091920e0c.15.2026.04.06.02.40.13
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 02:40:13 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so780382241.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 02:40:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzBGgp1Ehc2K5BgAepjJ5Yts10Nsamk5CqSR2Q+dg/SNC5U+Ao+M9cKHxCHj1ogF/M3wpqdww=@vger.kernel.org
X-Received: by 2002:a05:6102:6c3:b0:5ff:e0be:f538 with SMTP id
 ada2fe7eead31-605a50d358emr3135757137.30.1775468412939; Mon, 06 Apr 2026
 02:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402145858.240231-1-julianbraha@gmail.com>
 <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com> <f914fb50-ffca-49dd-901d-0b0176e5ee93@gmail.com>
In-Reply-To: <f914fb50-ffca-49dd-901d-0b0176e5ee93@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Apr 2026 11:40:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX71HJL+krjUrDdnVLA44wxo6HfP9e4-qvFRhrc1qjigQ@mail.gmail.com>
X-Gm-Features: AQROBzAeRHlZRx6XLNF3owpO_ayyuIljh1J_K_FbzGbRKkLMW-kjt6HUF_2Ww_w
Message-ID: <CAMuHMdX71HJL+krjUrDdnVLA44wxo6HfP9e4-qvFRhrc1qjigQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,st.com,foss.st.com,gmail.com,armlinux.org.uk,kernel.org,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-275552-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	NEURAL_SPAM(0.00)[0.012];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: 049283A2AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Julian,

On Mon, 6 Apr 2026 at 11:27, Julian Braha <julianbraha@gmail.com> wrote:
> With the patch applied, I've attempted to configure the kernel
> with STMMAC_PLATFORM=y while STMMAC_ETH=m but menuconfig gives this
> error message:
> "This feature depends on another which has been configured as a module.
> As a result, this feature will be built as a module."
>
> So it looks to me like this patch hasn't actually changed any kconfig
> behavior, but let me know if I'm missing something.

OK, thanks for checking!

I thought there was still some difference between "if" and "depends on"
when the symbol is a module, but apparently I was wrong...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

