Return-Path: <netdev+bounces-275694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAbuKSf302k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:10:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B103A60A3
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D04E302A2E6
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B130C37A;
	Mon,  6 Apr 2026 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="w2Z4HDhg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A738C400
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499000; cv=none; b=Fp513pYBcX/wUIDhAQ93jgxpjchxyuuav2/vsHq+nqeGhnKigXI4JxxwLBTQYKJV4OkIyc/LBQk2b7MBF4XbLijXorqL1WKSyw6NmKqtJ8yS2G5KCvvf4iNGUc1cJFFz9ub32oPSkNZzMz6pKBVAtEm3nb8XZJuWxke03i7/Fak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499000; c=relaxed/simple;
	bh=y87UGnEvy+KkqoyI9K6D3ZSqtPHNEV6mFem3Govbx0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adbFOYwPUnsSjixfDPTEoGDQ+HP14dyFK7PzeVVM+VEnETZwhqlxzXgqSUKde2Tavi96IErw5O0dK9VfJVjiOeOIuionmLlzAiAE60TrPUk8uu42P0zo+ahoBDBJRJSvltflOQJKCfsf9rgnOx02/OOG2EaWoiWcfIitezH8UW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=w2Z4HDhg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9f316d68so17225455ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775498998; x=1776103798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjRd2j/guPJEuyJ4mogcE8ofw18KOTulc7ao1ZGMUDs=;
        b=w2Z4HDhg1PJezTM7L4d7GIEQbA8nG1NcyAPPCtZXohOlyTaLw5WjEWbPxALTWJwdDJ
         dDha5Qxm7e6NSZGTmPLGi80ylGWh8iiBv/k8FpGYJcjMSYVoHE+Qkn6dvmSLpAQzZ/2o
         nXQ/4qAehKwWvukRxvMS71ksHiSlHVsnskXtKq0ASykSnr2uzc1QxRvhH2uM/Kjp+KaS
         EPPZt9uoNJrLvyJflz1pa6DDmejP/EFFDqaVPAhpM9dJ9GJWEcejPNtiDrpSxPSNoJgd
         nQH1769THVuM30r1Jz+p6+lgz6q3BFKg09iglaJcO4Zz3rz0TpE1mWFofryc74LlTYB8
         hnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498998; x=1776103798;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjRd2j/guPJEuyJ4mogcE8ofw18KOTulc7ao1ZGMUDs=;
        b=Igc1JzjZnDYFmB7YoCw2uEezgbqcW2d+nNs9ftQwflNtfQZmqQHFg4JVn8rv2QXn1c
         b1QcJ973YHdzpyYreb+Tkna7bvFRn9ILdUt+Vt+A93EqBVY7EUomI9QTswfDTn8/G2RH
         PhB0dJBDxgcifJcZANYLIIV2q5vNb2au3Ebyx8od6JahchKI2wms1G2eTLH4mbMpKK3J
         L9sEkHtYK0p4IBxorqX7m+F6i56IY4NeHxDi8hLurCc6M3EXWJpmlO0l3gz6AhvA6xSl
         xm2jNWKvF+wA+szMdWcI6ATW+FiNjZWsrkXP4lxHoxeQUq+nQs1Vn70KuqQoqz1DuzcV
         dKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6lPGzenP9Q4j8O6M3FeL2qW0g+OMKgVRUHlmUwUC5MfgRjjCQUxEaBxzw9rX0orHLqysmfgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLaBKCBF7LtipkW893FtDavkAlSUo/mgL9GKxJ5cgOTq4Upxu
	mrifuOnXmAg3a0Xfc3nz9qT0hWYdGYoOYvFXDTF5rVuo7+sPsTf/zWll2PQrFOpJIII=
X-Gm-Gg: AeBDietyU7ChoLiAwdNputF9xoL3ljLEIP8B/7pjXx+3pcGWfx7hhDFDRTAXW9qbSV0
	BlKqF5Qct8juMjllneGBZrhR0gN2FBdH3fqCESpM0O9g0RuBcwo+8ApMPgY5IGFMgZHmxUWZuud
	QlDe+V3tLFXTbsVBmnZPswHQyEhGFWeW1EfC1mLEqYpkaLIFi7qAeUUElLguxyIYt++PaRR1pG3
	UTCCKCoQcbEev3bf/DQg/Sqe83kZ1mNR2r2QK6DeKKKjP7YyBQoVNwgLvrEoLtJTxWd2D9KlAvQ
	uZmhov+XgkyGx9SKZRImrWgqhGHzlZSYI1rBycPtVYedbL8bn0WOQMw31khFEGZtrxZCXi3Ti2I
	lIEa6QkfLD+zMKxWqcloEqDEk+hfRJebJEctl6D6SKBLcupjHXODJsu0B/TOzkd9DNwlffjkKNi
	rdLWo=
X-Received: by 2002:a17:903:240a:b0:2b0:c90f:449d with SMTP id d9443c01a7336-2b2816e7071mr138195105ad.19.1775498997925;
        Mon, 06 Apr 2026 11:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274757fa7sm143694175ad.21.2026.04.06.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:09:57 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:09:56 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: improve wording of reviewer
 guidance
Message-ID: <adP29EHk6Rgt2y7W@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
References: <20260406175334.3153451-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406175334.3153451-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,devvm20253.cco0.facebook.com:mid,dama-to.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 00B103A60A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:53:34AM -0700, Jakub Kicinski wrote:
> Reword the reviewer guidance based on behavior we see on the list.
> Steer folks:
>  - towards sending tags
>  - away from process issues.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

