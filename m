Return-Path: <netdev+bounces-268359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xz5jC++iuGmkgwEAu9opvQ
	(envelope-from <netdev+bounces-268359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885B2A24E3
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43637301F182
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43721ADA4;
	Tue, 17 Mar 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZutkjnfN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774712F585;
	Tue, 17 Mar 2026 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708010; cv=none; b=hA9GMuRUE7o7RY6bMlajqLh+faGsZQJ1AAY9OklcE7Xmv7tYqnbc9IWC1ps5TRB07lLILyI8j7PRTRkZfrqwX7hgXqWNARTH9aORaoftbppXOcXyzWk4RCKBGkyW6Pco/gI6NWvcS1N5aLKmpAXE3wGDLM7BURiyzyeTINHPin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708010; c=relaxed/simple;
	bh=ERa2UmY7GpSiQ6Gjcuh32NTrztyArLpVxWbF7l3LPXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA1E9bzyXTcXH3hYwWqg5xtexJFpPQAqBmge1ekowDOI69k7HQjSVPmqezafuwGBN6DHYOaafkpzKbqYVsMh6tPrbCGDz2wDEVr4B4zYfnANSCYLqV43w6G7pk9rjw3zdifTZynSbqexPCveL3DG/AJO+EMYhUwgS6L7fI8x1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZutkjnfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7534C19421;
	Tue, 17 Mar 2026 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773708010;
	bh=ERa2UmY7GpSiQ6Gjcuh32NTrztyArLpVxWbF7l3LPXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZutkjnfNyRjrqJWZni3bv2LD9/VH5WuCG5uD5uJ6O9JNOwQLfZgLApKSB+k3DI4iZ
	 PGYz1iO/HcER7VdnOqO22cIgtHdxwgzdQrtQcCp4/rKpI8baot7+8ztI35bb6T1OUv
	 ScXlbOFZe1w6pSoGz2OQVS4k27wk1nkOzgMzT6p/QMy89mqqyFsmT1fOwhxtkYXqjn
	 SfsJzdK6XgQM/BCxkBG4eTKevwb16X4gQnWdxQCLrCRukIX1vD66eUyrhMeZ+Yhvej
	 MiLRW8UGYx2l/dCLC/TBuqTGCqS4szzIltFfsNpSlyeMeGhxyRyGegTeP9IsCU5gh9
	 o9QxmLAmqiPRQ==
Date: Mon, 16 Mar 2026 17:40:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macvtap: add missing blank lines after
 declarations
Message-ID: <20260316174009.335191b8@kernel.org>
In-Reply-To: <20260315201338.12943-1-rayfraytech@gmail.com>
References: <20260315201338.12943-1-rayfraytech@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268359-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
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
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7885B2A24E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 21:13:38 +0100 Oskar Ray-Frayssinet wrote:
> Add missing blank lines after variable and struct declarations
> to comply with kernel coding style.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

