Return-Path: <netdev+bounces-251660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLt4LU0VcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:52:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85A4E26A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17F9AB2C708
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81742EEBE;
	Tue, 20 Jan 2026 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGCncxSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9C41B37B;
	Tue, 20 Jan 2026 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952655; cv=none; b=lF1B47WqcawXkSpOO+8Ej1LNyeP4/FFUnJk7fH4lzXNSrBhJ2yD9EaYUS6XoIvbdzD9K1lnpvV9nY828cF8fukyjIcBuPw2PvfLLW1zM2hHYV4p7O+EqyF6nNXUPMxIymdey+plLLtfMjt9vgWRNr4xma+vIe/uNFu+rdQg/Qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952655; c=relaxed/simple;
	bh=mcsyzByCvkGLlugDD/5Aaw9CFYHbBzbPOcx2/0kg+gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR2QUEIUadFvqhjX4VlLQxvZxSU+VwFqoOePzZwWmfxrISHBrWH0pfjb4S/r4+cYBg3Mxi13y4zyk7k4ERMr3tJuoWw5qgmFqpR3gTEiM2hKAZx/CCR18Fwk7M5a1jmR1yDDZnEulo7N46ZlCKbYlCp64lt9UNIpZG3NSZTpvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGCncxSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1FDC16AAE;
	Tue, 20 Jan 2026 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768952655;
	bh=mcsyzByCvkGLlugDD/5Aaw9CFYHbBzbPOcx2/0kg+gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGCncxSPQ1MwLqR4bJNswZ+TU01kFJRUAt0rmY+ohxM3h5A17ocSloKT1B+9v65Zw
	 Z8fosnIm5R09utCC9CCpwYAYoUmLVhxnw8UIoRzNlF1VGXGy4MxnAXpo81PC8yTrX6
	 4hHFOwiTNBdslK2MRvlVbhIUWloWwZWvD41S2fi2B4i/DvPVxUP5ONULIva3Z2baqy
	 dRU97svXWEaly64mutGTz7iI8KOViepx406ccGNJfK+S77IGLVW7bwKwcMnwcUqXTV
	 kkjG1Nq1beXZ7fZa1JQ9xoLjDi7mPxbk97C8vbPXTY4mRQjE3knoISq0Gw+RXTzllB
	 PC6I3TqsN+wvg==
Date: Tue, 20 Jan 2026 15:44:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Joe Damato
 <joe@dama.to>, Stanislav Fomichev <sdf@fomichev.me>,
 <linux-kselftest@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net] selftests: net: fix wrong boolean evaluation in
 __exit__
Message-ID: <20260120154413.6fe90947@kernel.org>
In-Reply-To: <20260120124733.604590-1-gal@nvidia.com>
References: <20260120124733.604590-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5C85A4E26A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 14:47:33 +0200 Gal Pressman wrote:
> The __exit__ method receives ex_type as the exception class when an
> exception occurs. The previous code used implicit boolean evaluation:
> 
>     terminate = self.terminate or (self._exit_wait and ex_type)
>                                                    ^^^^^^^^^^^
> 
> In Python, the and operator can be used with non-boolean values, but it
> does not always return a boolean result.
> 
> This is probably not what we want, because 'self._exit_wait and ex_type'
> could return the actual ex_type value (the exception class) rather than
> a boolean True when an exception occurs.
> 
> Use explicit `ex_type is not None` check to properly evaluate whether
> an exception occurred, returning a boolean result.

Sure, the checkers complain about this, but I don't see an actual bug
here. bool(terminate) must evaluate correctly, we don't compare it
to True or False explicitly.

To be clear - the patch LGTM, I'm just not connecting the dots on why
its a fix at this stage.
-- 
pw-bot: cr

