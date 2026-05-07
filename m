Return-Path: <netdev+bounces-285114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAs/MMzz+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:07:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD214E22CB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CAE3008A41
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A279DC2;
	Thu,  7 May 2026 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6UR7AHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9423D283;
	Thu,  7 May 2026 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119625; cv=none; b=Qya+kUCMNQ5/6dlyzc8X/tdwnTLyCuib9slbon116WER/DMnuoN5kQEh5hmU02xKY+O2qLfVSWcWWuKijgCiFcrkaVFBT872TzZueed+o3f5+MUFLpVp5CnirkKaDSpKaAVWA738+PTx4hmGHJl2RLMBq6dONank2VGFnPLRyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119625; c=relaxed/simple;
	bh=pKUcgXiFCysWkoNRC4FAViNRvnHbPPvFv9UzLhXpVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak1QJNN6IwA7ONxx8qkgidRgIT/kF/djg3fB18MQ0QHRpto6yZ6ic2gQy3tzfG0uumyZdFjAEDWCLWCcpvJJvw/IuUFlRSmB2wXEKfiqtKs+IXa9vlWDgZ9dgQ6akgAEnXGCkK3qLikNiqp1maczdVOdJC3F+cysB7vllX3Jlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6UR7AHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E63C2BCB2;
	Thu,  7 May 2026 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119624;
	bh=pKUcgXiFCysWkoNRC4FAViNRvnHbPPvFv9UzLhXpVqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6UR7AHdGhinWh27fvRJ6odfBWXbPk2N/dgqVnvVD6bdNvXxkSidro7l8Sksqo64k
	 Ik76XVSBmFtnyHdRfAYwx6NqJbilq0JrGwRHclP/syAUqZvn7Zn1DHiDXJ41aHfuzp
	 6SRFEzqm4QwkogRQ8zuU6hzCLRy8le5aHJJ/f4Z7lmeO5DiKyLV3AFFJ9uhfyd1oTB
	 y9u3KwsQilFgaRSctj7HPXOZhjeeB3fa0cf6X256mbB2obBOpcct9WTjnkWDdLq59+
	 8y1JbbDRwQ0NKNRL+hV3priUipOvqbpNdCAgEx+PRXBJNbaMjxGwiz5AOqgCsADR7t
	 11ebdKqG2bYmA==
Date: Wed, 6 May 2026 19:07:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: Add support for TX/RX channel
 interrupt
Message-ID: <20260506190703.5937aea9@kernel.org>
In-Reply-To: <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260506020018.25014-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BD214E22CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285114-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue,  5 May 2026 19:00:18 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> - Add net-next tree prefix to subject line.
> - Fix variable declarations to follow Reverse Christmas Tree order.

This patch does not apply to net-next, please rebase and repost.

