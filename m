Return-Path: <netdev+bounces-275634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJQvErLT02nGmgcAu9opvQ
	(envelope-from <netdev+bounces-275634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:39:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01993A4D48
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B27300BCBA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532C303CA0;
	Mon,  6 Apr 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA5kMl0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C4301717;
	Mon,  6 Apr 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489967; cv=none; b=li5N9P+oFBAeQ4uboKPLO3jLhmtNhFyjHBfa7stCG7mV9Gc2MLaF7TevPIp7/JnoZGo7PKZkbtA5fZ9YolmfEFBrknwCgvqW5avkomVbtQ/t27hCrwEo82OK+WpenuEwsbSYl5Yy8DqjSLfcEEw0a5v6SbQRzw9sIhQY+0H77v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489967; c=relaxed/simple;
	bh=dBBOOPYccQdP+A1MwC4aCCDHzpoBm0wvT7ybVzIt/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJw3BKWM39CGvX+Tu3stI5gOeY4mHEtn8PsRLl3HiHKUraaWQRvGSFwtwsrxFclciH7mc7S9fmkYGc8CST2mfTPByLBgmoTFveKmifMbdeb9WnBUV5wNviF+8MeXDLh98K3+PblRFqR6QEQYmbVjx3yPBfg79OaUDtagLEI0vn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA5kMl0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B0C4CEF7;
	Mon,  6 Apr 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489967;
	bh=dBBOOPYccQdP+A1MwC4aCCDHzpoBm0wvT7ybVzIt/eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OA5kMl0Gi+T8g5RhjXEe9hvsyaDredPQ0qoKai/Yc2nG0IF2V9s10lPjTrGcgfHqD
	 /MOwP5I4JtbJx9Cft0D0SL4Gb3BxDzumow+6rjVi0BMtkEPjYmujEfQA2o9pgMGTIh
	 JKDJlwP27ryxpBgtjRqlaqNL5n/ALriHd/KvIoO9xLgUTUX0j6PSNbTaUNNw1OtCoo
	 RgjpXfMbWHNCqxfvUTwm8D3Nzy+qe4MDYEzh2uzUew0bv18KBjyT/eacUGgZ3vTjW3
	 fPodZeSM7qm2Wmg5LySWQZ2mRa3pBaCsvrmrOEghQjMH6cnhP/VYK++30tt5UjY2CP
	 N3ybr2jKzraEQ==
Date: Mon, 6 Apr 2026 08:39:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Julian Braha <julianbraha@gmail.com>, davem@davemloft.net,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2] stmmac: cleanup dead dependencies on STMMAC_PLATFORM
 and STMMAC_ETH in Kconfig
Message-ID: <20260406083924.5711ecd9@kernel.org>
In-Reply-To: <CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
References: <20260402145858.240231-1-julianbraha@gmail.com>
	<CAMuHMdUfzVSQpadJYpEqPJ_UOBAgswnGzD_bp_U3U6jt2dy0dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,st.com,foss.st.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-275634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C01993A4D48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 10:23:46 +0200 Geert Uytterhoeven wrote:
> >  config STMMAC_PLATFORM
> >         tristate "STMMAC Platform bus support"
> > -       depends on STMMAC_ETH
> >         select MFD_SYSCON
> >         default y  
> 
> This now lets us have STMMAC_PLATFORM=y and STMMAC_ETH=m.
> Does that actually link?

Hm. Sashiko didn't complain when patch was posted.
Typical LLM indeterminism? 

