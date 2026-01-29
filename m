Return-Path: <netdev+bounces-254910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBTBD93Ae2k9IQIAu9opvQ
	(envelope-from <netdev+bounces-254910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:19:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95221B4348
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27462301BC3C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74934C826;
	Thu, 29 Jan 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Roqsz8Un"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989C346E75
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717978; cv=none; b=BBURNOp0VDuFQkSpBuvy/8LZMysSNVV3jC4cfsw5VK1HCkg7ONPxH6hiIHlw38Hh0N4XPmWOEouGL3/jsO7ATWLhXuSRaRCGCSHky14ptgrXx0cTO/BRUn0plc88vuQT16RraONY+Cp0r++vOxggM/btUqoO/cG50Hxfyi/f0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717978; c=relaxed/simple;
	bh=yKKqLKrna1e75AeheR1k1gpFUJ1h20aVEE0f+9dCC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt72zeXGcHr2EgaWpptcmSbcIDWjw/C/9oEKVjSBsiaST757d0MiaYzNo3ZOIaLgWKkk7+Anl8t8GcWKLZSS+nqTDRrqPuGsJhDaj8RRaRf0UX1RQGvTkN3CBK8cCHIO5i2CTKnz4CBkkp7Rxxl/xwWzYEwrUmqmnoFaK4WtdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Roqsz8Un; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81df6a302b1so1354866b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769717976; x=1770322776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG9JP8LjRrR2xfnKj4V7+0U06WZgMz5Gz7dTiO9L8Zo=;
        b=Roqsz8UnchpMi9RqEMlGuStitppLRWqslM3Xe4/YL3A/i6Aa2D9kWHz7Q+O6u8+qR8
         GkDr4kLItgLg7e7LnhF4kDtYsQXLjkgy5p54Z1HEheP8+lq47z+w8387fOuGXnADt5UE
         ow4F9rnB5iquJ2tzDmYG6KGMaHRKJuxqpFC9DaXiQwYBYjPMP7iTQP5vZhyuFK4vOxJW
         ooTcpv4T3Qbg5rvP/FzpoWYoC2jSIlWxtLGikwD0egb2psw9omptk+nKtHmTtaVPUQsG
         54h1zC8S7r3MiPWoIFu8sk+y75Z3wPn/yOpc87DctIVL+cwQdYXuRwBQQX7ikdXFuhbB
         ZL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717976; x=1770322776;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9JP8LjRrR2xfnKj4V7+0U06WZgMz5Gz7dTiO9L8Zo=;
        b=j1N0L5tm9oxqyuiprFiLUOD9yI3Y0nm9Ww1q9w1FmAJJqglZSOPLzyBREtOWnN6QsZ
         CY36qnRfwrYd4GY29E8jfVm15sBZaBqkrFCy4IZmol0JCHPpoiOyWb4t7OzeKzAd7XVu
         PPK/G1l0SH5TqLMkqH0ggcKhOpOHypWCkrKBRmgKSZCz0kJDV+Qb7hvAm/0M2P2K4DJS
         zunJfHqTbT5/0cALSQefn5EKQmI3StC/shbsg7nTNBxAMAQxFSp1iiiJn3ELBFUcbRKt
         MBVO9L+RcrDWKQvfjJSwKecuP/4sfN9wXvqxoBsvD8Ec15I7kS86Z/lZYblZiq9iD9oQ
         D5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXvafiDZBMEivXrjh0Tl0HPLfgHtXqm1E/e1wq9BIhTPO8R+swvbD0r1Up7Tpxla+4m/KI3GfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWu4sRIoMwue433zxTOijNA9Sv3TX6MRzXNfWNUpdj2AyU5hri
	kMKD5b27RScyVjt/wmVJEXCZljRAfUTkLgNWG+aiiysceD+mTgO6BicqOucnyAaC27I=
X-Gm-Gg: AZuq6aJPvAnKm9T803olQebi3pVBCSqcQ2LubnjjiXRv6kuGB95nKPEUdGP74MLjBEy
	DIhmfYRySgEoZI3Dxl8kY62DGfxP2u0cKzp3fFx4wkL63IUTescFiPqqhrB5j1/r8z2ql43QViG
	04xUBt8TZb6dySJeckHfXxPD0Lql7gm7rXiD8MaRKseLhzAELNE5NMxNB/0G26V7eRV4U+vujtq
	WRydja0mDtcFQtyrOpTkmPpN34RA19tcd0w9W/nR0b1T65RUAeeDSjMhsnvhXEVzYmkY619T2Iz
	GYJDHhia4xikBJQbhlQosrOwDIcwq3kRWRiP5I3Is3k7NZU7BdV8yvvgBzV32Bh8nlMvYMDFx+s
	qtjDspwvkaU9r+AFgLT571TUBEp/ukQ7njErHOCPh3hVaEtZcqYBzRrj5fR6n2Y0Ugc8=
X-Received: by 2002:a05:6a00:4c0b:b0:823:d04:dee1 with SMTP id d2e1a72fcca58-823ab706ac9mr396250b3a.32.1769717976607;
        Thu, 29 Jan 2026 12:19:36 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcab8sm5892679b3a.36.2026.01.29.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:19:36 -0800 (PST)
Date: Thu, 29 Jan 2026 12:19:35 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <aXvA11H0AvNcjaWJ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
 <20260129061646.1417185-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129061646.1417185-5-michael.chan@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 95221B4348
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:16:46PM -0800, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Add tests to verify
> 1. that RSS contexts persist across interface down/up
> 2. that RSS contexts persist across interface down/up along
> with their associated Ntuple fitlers
> 
> Testing on bnxt_en:
> 
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: rss_ctx.py
>  # TAP version 13
>  # 1..2
>  # ok 1 rss_ctx.test_rss_context_persist_ifupdown
>  # ok 2 rss_ctx.test_rss_context_ntuple_persist_ifupdown
>  # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 1 selftests: drivers/net/hw: rss_ctx.py
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 117 +++++++++++++++++-
>  1 file changed, 116 insertions(+), 1 deletion(-)

I feel like this one might be net-next material since it is a new test and not
a "Fixes" ?

