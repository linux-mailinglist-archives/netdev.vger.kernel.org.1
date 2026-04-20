Return-Path: <netdev+bounces-279953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPxKHwOx5mlDzwEAu9opvQ
	(envelope-from <netdev+bounces-279953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:04:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6F434C90
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6160C3009B37
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FC3D3319;
	Mon, 20 Apr 2026 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="tFBQWOVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B53A6B97
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726269; cv=none; b=Rr7H+Jmr4lqXUp39tY0j5bHnBf0+1u6IqUv9dz/L2KX6UunFHjCWe2PZK9L9PSd587ho2+J3/iP35hObOht5br8+8eRp7su41Lxk/RluFBsnNEMcqqRXJ9xxS/GBWrn+hRsbhcRSGoxQ7axiD/LDnfr2utzuN2lq/z2JcS+O6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726269; c=relaxed/simple;
	bh=WsgQP6q8FcpLQu9XggQp2iqVoQxjSZH+TF9xExnwkqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRpyWoxODE6JJVYRVAN+g6PmK9KV70xpxXxy4xD95Wx0CsiCEy040/+5MSQ+W4CFk4276fjirNTc12p5n9vgORddGYjC+nWlVbLDMpfFidh4OIimjW/SRufKCdXO78rcfv0ZES0DLde+E8nWR/fBTP6SRzUvl3nOEWOE4xPLCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=tFBQWOVD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so505395666b.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1776726265; x=1777331065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Ugsr5aor2hHamUiRPHM175EjJyXQfoFJRoWwmyq8I=;
        b=tFBQWOVDYZNBoEfaRZMRhN+P9Ehzc+gGNEODFUu5CkaYFGhEdwTJHF2hokAaD3wJnV
         0FKRT3CPs+RBsVhx1oTzsBMYvkagbmv/3ILPa/PmwAMNmgv6U72pOsYk4x4RWANaoRo1
         aa6x1cREBXiHcoePmccD7It1vTzVJZ0XLtL9raQuhvg2BoxVnwO/oA0IqFd77GhjffoX
         I5UX9NuCSjB7LzePFtvoidOuL2uzmg6rXiF5IOTJqQiF6SB2KkcGL48lnhOLKBN21FfJ
         IBivfj1dX4Q+IWU0rXCT29jYfn7IXo552qZgkzQXAeLK1oryitYNCOKg2fMTB29vM7MR
         v1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776726265; x=1777331065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Ugsr5aor2hHamUiRPHM175EjJyXQfoFJRoWwmyq8I=;
        b=Z8GSULhBQztHLVXOXNy1Huz0nBkkg/ky6XL6ECs4pyr1g7HS0lAXU30PQhPU+z0xVT
         gTEdTmjV3DekIgOzG5GuZyc3gagVy/JM8icLkGDxRCaYqA7QysnV/7NLLDL0sPmhbeLu
         glF/a7k0UqhHNDNpjQrye5Y51DrreUhWc7TrZ0WfT5y+2cycIfBV+Ikn4lpnloOdjib3
         TT4cu6MIGemnPWhjclmstPjHALkBH+Yeq9nDzX3rKWDrMQgkJtkHjhSO6wlfU1/DsFQY
         0TjE/CdQShs0+87JbHpP4L9Hd9E7h66rAah2khr/fXhr47ryOmgYBGTjRCCN3blIw71B
         vCDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AXsXRvXC39ag5I8DUegIZEmOj2xzcuHxlr3Qm+djUA71kZ70oRpy9LWf2E/ikESvIfh49fOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAWAG51HH745IRjWl9Twl8Rozfgj3NH2VazzD63gOkqYKIXMN
	PswWDGy4jGQ5UmaHKREVX88KrMip/YLxEAvY2QpzE08uixpzG2yZTHzBlpgFNNhAsAJbyhKrf9j
	x5KQx
X-Gm-Gg: AeBDievVDOMpFzSVkub7+QJUnf949rYjJeKHhF/h7yLDkb1t13xOSz8EubYjDgRyyyk
	/22gboL7QH26BJIfejKxUnHnype6xgyjcJpai2LWUNcvNV2TMgTp6dd6aDyXecZznO2dAQiXF+D
	3spOLmksAPFFnuUnGeYa7HAEQ5xpk1BiEj31tXCP2xgxy5fKsLOzDtU6wb80Q+w3x1Mub7kGgXl
	i+6CDjkAMwbz6oYG6Y92WVMdz/CaqGOqaPGaSuPtijLhHnSeIE+OPJq6+anv4JGQ0Uk/WbPSGYn
	z1WxHaJGWLGlfeF9CatMrr9+hjNJpxibaIEAU6W/ebA9fTAoq8OWvQxUu85t0o+DX4BUkyScQ4B
	9ja1vK9K2rTzjVO2UJ7BCc7YFuuvY2EsqkqONy8y+MbNTgiYEZJ/cq86bHgW7x/hYoCPMnvbcw7
	lD40FkuW0sPWqCtuQ11WlprVRfFiGl
X-Received: by 2002:a17:907:748:b0:ba3:e99e:18dd with SMTP id a640c23a62f3a-ba41aef07c6mr729681066b.35.1776726264946;
        Mon, 20 Apr 2026 16:04:24 -0700 (PDT)
Received: from airbuntu ([146.70.179.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba5498b3ddesm319994766b.22.2026.04.20.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:04:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 00:04:22 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Message-ID: <20260420230422.mdfy4icsuhjh7fe3@airbuntu>
References: <20260419214217.108901-1-qyousef@layalina.io>
 <20260420131847.75248693@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420131847.75248693@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[layalina-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279953-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[layalina.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[layalina-io.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qyousef@layalina.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A9D6F434C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+Ingo and Peter

On 04/20/26 13:18, Jakub Kicinski wrote:
> On Sun, 19 Apr 2026 22:42:17 +0100 Qais Yousef wrote:
> > To make new tools that depend on it like schedqos [1] more reliable, it
> > is important to ensure users can find it by default on all system.
> 
> If scheduler maintainers think this is appropriate they should take
> this patch via their tree (please). connector falls under networking 
> for historical reasons (it's Netlink based) but we lack the context
> necessary to apply a "default y" patch of this nature.

I see, I didn't add them, but I'll resend with them added.

> 
> default y should be used if the symbol is necessary for most Linux
> users across use cases and architectures. It's not obvious to me

Hmm I am not aware of such rules. It should be generally is useful and doesn't
have a drawback - which what I understood this is. What is the cost of enabling
this? This seems widely enabled feature by distro in general.

> that that is the case here. The commit message links to a tool 
> which is less than a week old?

It is chicken an egg. We want to add sched qos support and it relies on netlink
to monitor tasks as they are created and tag them with QoS. If we can't make
sure this is available on all systems by default (ie: users must consciously
opt-out of this option), we will end up with inconsistencies.

I've hit this when we added UCLAMP and it took debian two years (approx) to
decide to enable it by default after making a feature request.

