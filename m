Return-Path: <netdev+bounces-297140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VsqkDEQ6KGoaAgMAu9opvQ
	(envelope-from <netdev+bounces-297140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE80662262
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:07:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GIPTHSIn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297140-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297140-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA32530D6615
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C674279E4;
	Tue,  9 Jun 2026 15:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188940C5CA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:38:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019486; cv=pass; b=oPeGzzKK3WhDsGOsq7j1UOU2XE1kz+1zL2D4ypPEwDyH9/9lbukgSqJlvI/ZqSYT16uOT96HyjRRHjaA7onmNuXPo2Mh+kYQDY4HJPeKqW0uF3X/KwKhzlh88/6d0Ftw0CtLsVG9A4FrmnbV+WqK3xOZfmiV1MzAehMR8Otf7H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019486; c=relaxed/simple;
	bh=QM40V01bWRwBkb6ARNGNQmSmnfFwewJzhKbE4kmq2HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HygZ7/MbwxR96Mp5kS5w1A0+4uyJHb1n+NGK4xTOkE4pPIg70LTtc2jWFHUtYb5RNsgozyqdXU5iqZgnB/u6CEVbGHnkUwEwbNkqWgf41wx9vD3iVV9PjHVB8MweWs53yT1mlAQFzz9TQlH0cJM4CYcoGGOEDCXoEStoWWPbcqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIPTHSIn; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51761d27612so67210091cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019484; cv=none;
        d=google.com; s=arc-20240605;
        b=aJ1Pt/dsKfS7Q0z/5mp5B8qEdcdH14c8za1QViDGSDz0TDICgDOnjvoaWDrS24XFyp
         UbrYIPsUTpPH0NAJ+E5VDL/9+1VxdwRy8LcrQSUu41OdXxbyV6OO9kSh1bl+hJz58Rrq
         4BAS5xgY8klJC80rz6O9wNXRRHmOosrnwq464y7t9as9eu7qrNynajpayxR6ncV9afWN
         GSMhiKSP0PayULp2XfbBWHtKwyyq8Xdx1uGby8ZturI/Sx6frZK4oEBZ/KXuv3JwU0xd
         miLpB19eZb3kTfvETo726d+uIDE5sxYrxIhJvN/rkxKlW6L65Tvn//WAkSDhWI79nVyn
         Jg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QM40V01bWRwBkb6ARNGNQmSmnfFwewJzhKbE4kmq2HY=;
        fh=iOWGacYR8pby42biID6yJO/tF2KUV0BThCKMAEjlqm8=;
        b=UDhQ9qYIvoSqLJcqd6y5/lacM6/hGtNvM5/GKpOA8HqjCvSgAXMpR6rIi6hIIIfeD5
         vpvUYP4Shwl1FaKTT62HTBCyYdojfNGH0HUlayum/gZEqdiiXWlF/FNlum864lh9Z7Ty
         t/WKTlZMm+gneEkpWbKs6yzwABah/QRL8zctxWF9fckMK65eWHL9k9zOvscnqs5A6t32
         wiEicWkpPULsBjGTcUxpMjvmvMOeiRryJtOGDnA7WiqVH1vs0QqSaqEHZsnYU4WIilg8
         qWG79rBHf7W8I9dg9YfLoLKOsduWuVVNqogkeEo9r9F/jNwRv33h7USu8gZ1lAnKnhFd
         /8Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019484; x=1781624284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM40V01bWRwBkb6ARNGNQmSmnfFwewJzhKbE4kmq2HY=;
        b=GIPTHSInX1ZeA/1xxEPeRWZwUKmUkKwfemfizSA1pZJ4wV4OPjc8U4Kah/bBx62hwn
         nF4hOBD7t7RcRjjA0cpctMMukoixMea1ddwbabaJAGW33P9firroPnzB7/1H9UL3lJNl
         RDFO+0wpx/JymZtl4xpKIf/52hUQDcx91c0PBmtRfPm9HcwjJLJHz9nVWjh3ITvLZjkn
         f0S3zA1I2sDufBj5jJod1a+ZJf7pjR1DSfyMB8gVVzqq2F5xpIfbrLdAfGxD7Qq9i9Ot
         bNHgZ7qUUoJBjwsaxUKvT/f0vqbV9lM2WZMwA/JaFM+XlXKpp22wum0QTXZgf9re5qCP
         pGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019484; x=1781624284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QM40V01bWRwBkb6ARNGNQmSmnfFwewJzhKbE4kmq2HY=;
        b=f9p20+XBDx1116ZxiGC3nKCJEV9XxxPTkmggzt6tI2YyNcVw5FWcXDx0KuYTs/V9ZT
         f2+YWimM2T5PwXIyoXN8g0fq7yfQ9Wjceu25fmWyvO3nmtT3OPr4p52Rk2xIC6eVqbfR
         7mChxXgd6YD3RaOy0F0IUxEdv3kUhR6T+HnwuiF0z4HgBcqxCy1ZZCRcyRSGfEo/hY6O
         sWPLGECUSjiKPVf/fMb5E3G+3rg2K8j0uw3Pqjq2DAUB3xH1bEVRNXW3Bafv/9uP4Ye7
         BtJjeXSuEcgYS2oHg2MGINzs4NgcasGykWIHzmv9TncF5GCYbh6JLHPuz8vJwxK0JLcn
         s2EA==
X-Forwarded-Encrypted: i=1; AFNElJ99082PVOotzodJS7aEsqA3Q6WZaSwNkO8DTSHcr1oRfXy4rHD77lY+7EH+X/0dVCqd9ZFDkwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJDgnyPzlT35H+sQfPdsCBWh+Sz97uGMi23d99TmE6t/30ss7
	aKiYotB3n696c5poESJLnRq7gNTDnTPf2sNfLdSBy+OStx0eYeGGSlw8jqYrOdb+mZudb9yoELf
	9EP01gwJ/lEEBUpmZDc27kSUAf6rO78xCc2ex/OWV
X-Gm-Gg: Acq92OF8pQ1x+tiyP8eqOIreS6OOisAyBELv13VaEBoXrNUGS22mLy/Ns0U7ftq7qey
	ZW3xtAKN6yulMBOKQ34Xj2QvW8ixPqiaHEKwZADU25+nqPP/08a+bAAyAeOxluqidslpZah6nG1
	nbrZo7EA1tWnmrTMfiivJuqJyjVc6fvZ94v3TVdnijPEzVb0055ZEQSJeU85OyBCQPKyQSvhL1L
	x1FNGLUr6QNv+G9CYxTWKdgwo2XgAnS6m4VYLOGoRm6CGkPbQa0RftPKt78C908kmWOPIo2d0C+
	EP6dxO3tVt5o482gS1XlK5dpbK1NYov7YLkTBGxDodIFP7mFlcRZAzLn5UFwaZW/60Xa4AM9zA2
	Gy2Ghwi/6i+8EC/jC0Guw3hmELBBAtw==
X-Received: by 2002:ac8:70d5:0:b0:517:96f0:5663 with SMTP id
 d75a77b69052e-51796f06e2dmr208940831cf.36.1781019483634; Tue, 09 Jun 2026
 08:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-5-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-5-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:37:52 -0700
X-Gm-Features: AVVi8CeG75PwPhtcf2XPO8vXCVISq0qEt6lqezmTxh-l-kt8SCV6Fl74_vYd_7c
Message-ID: <CANn89iJZqFjZN6ZPtq226Fj7UyNJmjA4a2+1x0kyK9C1NLZ8fA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net: ethtool: optionally skip rtnl_lock
 on Netlink path for GET ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BE80662262

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> ethnl_default_doit() and ethnl_default_dump_one() are both used
> exclusively for GET callbacks (former to get info for a single
> device or get global strings). ops-locked devices don't need
> rtnl_lock for GET callbacks, stop taking it.
>
> Introduce an opt-out mechanism for devices which use phylink (fbnic)
> since phylink currently depends on rtnl_lock protection. Subsequent
> patches will add more exceptions, anyway. Practically the new helpers
> for judging if command needs rtnl_lock could also call
> netdev_need_ops_lock() but I find that it makes the code in the callers
> slightly less obvious.
>
> Add a helper for IOCTLs already, even tho it's unused so that
> we can keep them in sync as the series progresses.
>
> This is the first user-visible step of moving ethtool ops out
> from under rtnl. Subsequent patches do the same for SET ops,
> as well as the ioctl path.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

