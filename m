Return-Path: <netdev+bounces-274692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6OJBXZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A138E306
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FAE3038163
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C55372ECC;
	Thu,  2 Apr 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QMPkaeDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432736C9C5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163603; cv=none; b=C1M/pPbWLdF6OsPVOJYDGTM4fVtwUh26QsdaVv4mKTAF1ZB5/I8U7WQxHH3I1sa+9sgaqIZGsLvuKuoX3LwjC041UD4h35SYa0tgVBm179EshhruA/Xpb0sN2035ynZlczuT9ILwU7SnkezpJOgRrl8mmkHDQ8gawv299yTOwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163603; c=relaxed/simple;
	bh=u54I39wHWUHbDyBdb1+/nfBUiIfO1SJ+AZIT0MAjnsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQF45fFgqgm+BbwTF3Y8+dOWodgPkYnTXCi+tn0/myAq0hI2F0VQxc73So8u87uVr54qA318bgMtrevRySohOrtOGCq6ubzIHHUdsB4KtP2jN1MweUAM0IJO9aqbbAT2QGVgtkU1bxfU1oAgMUg2WPcxPEXtCXzhZg6jloWzqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QMPkaeDF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce09b4197so599524b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775163600; x=1775768400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCpzZqe6/GN8u+eCCZI55uBzEHgmE5Itzy/ezeiV81U=;
        b=QMPkaeDFoQ+WWZN1aGpnLQJwMkacotRy78374fSVeRHQrjW3V5ll1MbpWxI/HZk4Sq
         YAsAiLe/A4LcyUIU3ZvTivOazOLmFeZs+YuZBwtn6xh3HbG6Nv70VCBf5+Bv/gPjY4Rh
         QnC8zoKcgE50G7mvxotJdmYnPhJYmQTetWoN9heJ5HDzZbq6VjqSy7Ip/Vx4a1ZggHP8
         RWWFs8G4btex6KLraQ1SUIgvqq8OolP4KKFNd14KlkKmMXPAaUWDln3ygL5VMlGvIbd7
         slPmM5rW7PYuxm451RKdYtg80BnKfU9tOQgk5MXLBbNWb8v8cu/c09rr/FlqEwk0G8Ah
         ps3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163600; x=1775768400;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCpzZqe6/GN8u+eCCZI55uBzEHgmE5Itzy/ezeiV81U=;
        b=Ch+mGoiBuRgGUNPFHzAv9X9aO2y3In7m6/eweR0ZElTipyjRriXBh6JXaIg7/Gbc7x
         GpYqqROY444QC0/wQ6ZoQSZOjh5fm8dQFoVI+vgdaZO+wGT2+mMXCitUU4UO2I+m/jYy
         0qI1bBVFxRpBM6PALkkmkPxvYYI8ibmrV5BM4DKALPXdcZHDAu/1scur624zteXkx+BJ
         6o9z/ta7I1ZHiAuqVMBhtTgZnjMvkACAenSnHbYBQIs6HfMNgkflM22Ch2EOOed1envJ
         uH58Yb7gYf8onpF3LgQ8lGBvRYgWlQOpe8XSb2tcNtV+hlcfY/hpWcpBnF5RLPlj3RBK
         XBdg==
X-Forwarded-Encrypted: i=1; AJvYcCX/uB81ppX71YGeJrISOknGlPV3U7WkS/WvF4HKLbs4Jfpu5UlAYPx8klZU1kUo4fYeRqzLtNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92j6wvfzJ0/GsNvKXWmo4lcg/RPP51EGe7cJ4RoJfl9Yrf8DF
	Bu9bFtz7/0Mx1nU+/OrGUTwwh/UxXHKubpSlNkvPgjhU50l66YFwU38ySeQEYTtiys0=
X-Gm-Gg: ATEYQzwLL5T0ZRn3joNZUMWisFdFV0JpqCeMUoiD2sBLjBCEDevuDpUjMsATguAELjc
	4M7E09p+FZG63ePlHgij+XqATmshqDyURyc3K6E+NdaoL0YwdACLfzzsvVHyjngCGwfZRltCm4+
	wJh3Q5etuSHR1Pb9It+Fl6HOurM9FPmM3jTNFpGiiTpS4yjhafb3Joeqsn5/ooAU0GqIX0Q/UFF
	3Ek2Dnh+Nx7A6n82kfKaxMI6fWw+Z2w3Q5c87jePjIKSZpX+dMjw1nYY/xxLPMUq1+N673nq9G+
	znr40bTtL7cUoDf+r7IDRPsu7mzurEDzuBmr3OZegirKXPixLmkM9RHwpMLph01dNU4KbihIUPG
	e/HPbiadtQWFINC5gCGXriNc8Xv818lHXR95vJx6BMrJl94Y8RhkyzyasmU4IBxGRWZGxG2zxdR
	BMk/c=
X-Received: by 2002:a05:6a00:3902:b0:82c:e816:412f with SMTP id d2e1a72fcca58-82d0da5502fmr501200b3a.18.1775163600420;
        Thu, 02 Apr 2026 14:00:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ba2fsm4034726b3a.45.2026.04.02.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:59:59 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:59:59 -0700
From: Joe Damato <joe@dama.to>
To: David Carlier <devnexen@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: lan966x: fix page_pool error handling in
 lan966x_fdma_rx_alloc_page_pool()
Message-ID: <ac7Yz2X0t3ibnNha@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	David Carlier <devnexen@gmail.com>, horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402172823.83467-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402172823.83467-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274692-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email]
X-Rspamd-Queue-Id: E78A138E306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:28:23PM +0100, David Carlier wrote:
> page_pool_create() can return an ERR_PTR on failure. The return value
> is used unconditionally in the loop that follows, passing the error
> pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
> which dereferences it, causing a kernel oops.
> 
> Add an IS_ERR check after page_pool_create() to return early on failure.
> 
> Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

