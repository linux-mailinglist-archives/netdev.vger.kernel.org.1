Return-Path: <netdev+bounces-252010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCoqCLcUcWkEdgAAu9opvQ
	(envelope-from <netdev+bounces-252010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:02:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A425AF0E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5B9D89016F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54C376BFA;
	Wed, 21 Jan 2026 16:50:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CC2E5418
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014237; cv=none; b=GSNa8pGdmx1+fMHwMMGh2Wn4fHiofTwXz9yWvy0hC78tJ0H16AAg0qaWninnykYDSpGHDgTxsRTySzb4HGrfdIny9rfnvJhFirA/xURCEPGV6ZpQHjk+6IYaY+QHbVx/0SYTnkaTUf5XBYJgKuZ2721ykGdc2A82VU84SojxXoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014237; c=relaxed/simple;
	bh=Z7VKEEbh/Mgf1KxHQovLwFtrWR4g8Q6l3XL5VtPDtHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBmcibKM6cnMUe4L4AGmfDbY/bEHvMA6JooS+c/+DWUeaC2+c5TfzPsGaFQ15WY9CzgkEfPI9CXhZB0VLZN83MmNOG3PUTV//ybE/fjxaTKqPJ0RYAn/x9evXuKGFWNN3vjKff8f/x9lbk9xa4Xx+XAIWZCIIBcmYZy7RyUXLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so610501241.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014233; x=1769619033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfo6ycbyZBbclnkJIZoIDjxzdLcGep03l3zua5CmEAY=;
        b=ng0teJipKUoS+fAn6sNY13+J8nQ3dCd346Eqsaby6C8YMDetO0U2nPShjEteuz92uI
         ECJm1TXqvm3cuCgDOFhbZx4XnMdmE3Vf0F65YNMR22sWHBeg8xI/2QbTCG22vuVRpJa6
         FqBVcTME/dIBcYU01fWhoXk71f5PYyYp/TUcNmWMjoNromEVtOI0TPEE3wmxBysLQnGx
         44eUO9GNArfrsUEf+3yVS6H0Nq1WfffoHzq3TDu8eEuMP1uHJVpSiXyXmUCWcL1VJPmC
         5QsBm4ADki8fXBPcvSBBRB2Ogm3Y9X17MWlcV0RF4Vx+8ih/14zPLqaodbstRalaK/Df
         EizA==
X-Forwarded-Encrypted: i=1; AJvYcCXqB3drNzodsosj/T2yEJ59jRsq3LWZOpwcZdhMewkH+861hBfRyZk+Zj+IXSE4fd2dhlDWJvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB0pYCk9Uzln18FC1oezInJICup16eDKiMBo5mXGV0wvXC0xJ
	V/bnLVmfAa9nSLBJF2+K9KNXHYncCklBxj9P1DrWgFTCDYnDkwht5d0E9r2Qnp+7
X-Gm-Gg: AZuq6aJK/P1H+uqnEtZIpMmD2eH1/v1hUPqGMZDI3cwyzdcREhrBNgTUv+adeDTVpwp
	5KdMCXyvWmRxOjeRxR98/AgCaFxI7Za6Q1IG2YLOgot5q/bfgE2pNYC88+uxWIO6Yn9qhHeeMTR
	7WbwQjsfSDkuKM5JamYVgd5n9cCPgzQd0U4vKGBpUZQMeqzGBrwj2OfCxhOu5Ymu7qGU0c4pUnP
	OjEdmoqeEy2+59jL8KK9qObasJ1B8ZgMtuwTJIMRsbskJmlFpuU7pyxH8xmLXbfu6Z8JI7Hbp4P
	sKTBnJbutrIYnorfC7NPauRKLJAlDSri+HU+jYD7oUlNRFaBwzEbU3vTjUqRRLc42MfzY98DWz7
	Ig+gTE07Y4Xp7EOlo+GFOlYpjqUdV2EKlLiGLwknliPpEepqIx7nJOxDuYwxhWSjso3zFRqW5Vg
	XzizPN4FzI+yBdY+RwSCym2fFzVCSSmRJNrPIg/AKNlcRKsDht
X-Received: by 2002:a05:6102:945:b0:5f1:c9b3:9fa1 with SMTP id ada2fe7eead31-5f50ab1a706mr1739456137.15.1769014233508;
        Wed, 21 Jan 2026 08:50:33 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d0437f81sm4775875241.11.2026.01.21.08.50.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:50:33 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94801cf4bb8so716592241.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:50:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8MTVGP8ein+afFN7M/3WQhk4VSmtghqP0CrY/5KbDcmCmokgsxCtML9JR3yJosOSZD4xScTo=@vger.kernel.org
X-Received: by 2002:a05:6102:162b:b0:5ef:b3b7:6e3f with SMTP id
 ada2fe7eead31-5f50aaa8a2fmr1678275137.3.1769014232636; Wed, 21 Jan 2026
 08:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212193721.740055-1-david.laight.linux@gmail.com> <20251212193721.740055-4-david.laight.linux@gmail.com>
In-Reply-To: <20251212193721.740055-4-david.laight.linux@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 17:50:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV3WAxshZL9gw4+NeovX-9FjUZrk+coUAA7+=y6GmPECA@mail.gmail.com>
X-Gm-Features: AZwV_QiqIMwt_a12kTPgIHFmNfmJbn0zP9R9-I36H0fdo0DzJDyqVo7w364KYOw
Message-ID: <CAMuHMdV3WAxshZL9gw4+NeovX-9FjUZrk+coUAA7+=y6GmPECA@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
To: david.laight.linux@gmail.com
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Luo Jie <quic_luoj@quicinc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andreas Noever <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252010-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,rasmusvillemoes.dk,vger.kernel.org,bootlin.com,huawei.com,melexis.com,intel.com,quicinc.com,infradead.org,kernel.org,davemloft.net,linux.intel.com,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid,glider.be:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: 88A425AF0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 12 Dec 2025 at 20:38, <david.laight.linux@gmail.com> wrote:
> From: David Laight <david.laight.linux@gmail.com>
>
> Instead of directly expanding __BF_FIELD_CHECK() (which really ought
> not be used outside bitfield) and open-coding the generation of the
> masked value, just call FIELD_PREP() and add an extra check for
> the mask being at most 16 bits.
> The extra check is added after calling FIELD_PREP() to get a sane
> error message if 'mask' isn't constant.
>
> Remove the leading _ from the formal parameter names.
> Prefix the local variables with _wm16_ to hopefully make them
> unique.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

