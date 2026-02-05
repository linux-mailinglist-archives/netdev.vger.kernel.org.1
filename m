Return-Path: <netdev+bounces-256960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNm0G5YlhGlRzwMAu9opvQ
	(envelope-from <netdev+bounces-256960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:07:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAFEE9FB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F019E3014135
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313B2BE647;
	Thu,  5 Feb 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XztIqa4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018F29D29C;
	Thu,  5 Feb 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268050; cv=none; b=ou0zhHxouHLlF3ttjA5gBqhRcsL5eGhHDkx1tOdstYDDHZALHXsoN1+x+k1MerF2ttwnDYvXgkMr982H+FUiwlL2xCvFmbrfqnqpyGig382cyyw1/Tcajm8ieiRHagXztC72qXyi9DgCjBGtiEFJW2ujWjhhHRxDzq/9r0k/+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268050; c=relaxed/simple;
	bh=6SCfcJjSYv9wv0XGp9gJ1XtalkseSFa3QjFOE/x5GAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9813sSXoG67e+wNOdS7HCF2XanW5rNWDwdBwBU/EEzlODcbWhJS7u8HXByHZ+W9P+xkgQMbU/YgJ+/oPETq4dLbJm+m1ttshyJKxaOfKiBqt4iMw2BbVcI7jfDroaiuMEJ3xx//36eAGfJTvuekf4V3OIMynIbc8vyn0zR/bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XztIqa4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E96C4CEF7;
	Thu,  5 Feb 2026 05:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268050;
	bh=6SCfcJjSYv9wv0XGp9gJ1XtalkseSFa3QjFOE/x5GAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XztIqa4xwTTXY+9PHizMPJqIoaxb2VFTFWAFkzGo+Em7zW1OeLquJv+Tyq/2vkze6
	 1tZNnjxL+rU8qtnI6WC2t9cJo98pcAct+sXrUH1ejnzRI+e5/plRzW8onVvL5po6Af
	 BXDOlgLD+cKtVux/biZKezn7AOGdeylPpAGmEYgOrLN/5jdrrP89RhUA8rgqe7mB9M
	 xBol6o78klQigrAgGX2G+GWvEm7gB1o+QTrAioeDIjaYIrKL+H77QePzDqNyZ1kr0n
	 QyF273mdZO9pJ4uUgWQpbU/6+ar35M0nfzeD7Xrr478vN27a4hCZfdFRUAm6UeGpMN
	 ZQxG8J7qScWwg==
Date: Wed, 4 Feb 2026 21:07:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Refactor port error
 message
Message-ID: <20260204210728.1c1f0463@kernel.org>
In-Reply-To: <20260203171305.95085-2-mmyangfl@gmail.com>
References: <20260203171305.95085-1-mmyangfl@gmail.com>
	<20260203171305.95085-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256960-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1BAFEE9FB
X-Rspamd-Action: no action

On Wed,  4 Feb 2026 01:12:41 +0800 David Yang wrote:
> +#define print_port_err(dev, port, res, action) dev_err( \
> +	(dev), "Failed to %s port %d: %i\n", (action), (port), (res))

functions are preferred over macros when possible per kernel coding
guide
 

