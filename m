Return-Path: <netdev+bounces-258895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IPwDBglk2kX1wEAu9opvQ
	(envelope-from <netdev+bounces-258895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:09:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3B14473A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C139430086CD
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A0261B78;
	Mon, 16 Feb 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1yBmi4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312521FF1B4;
	Mon, 16 Feb 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250939; cv=none; b=aRy8RjCQXMF5/cXyoGzm0BTFXEjGnAMhS0SHCPR7YUTA4jbiHBYYuuSZR4Mbty72VxsOgU9jBtnqgs94dpS06tSKk9KhynVVfmqUUt6ynsb4iPamRdzAlaNcLwz71KYnJ+SgoTvnFFf961634cSqTHkTRAqEQtTkLoySfFeoGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250939; c=relaxed/simple;
	bh=116cb+xgGbgoc9C8jCmlL+rj9u3xCBtRU9JNDUE26qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIIYcyXdrXPNc/aNefbPPRJs5hPToN2Jk+R5ukNO7dVOeZdA/ySNKooe3pIUjqDzFkSDLGVG7V/ddErcOjnG2B+mp8OKYUEU2TD2/ns26oojVtCBDpP++7dRZwgyJPsL8DxzWUXB7AJmBLu10NJXA4G73Tv8Ce7pOxywJAaoi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1yBmi4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEB0C116C6;
	Mon, 16 Feb 2026 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771250938;
	bh=116cb+xgGbgoc9C8jCmlL+rj9u3xCBtRU9JNDUE26qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1yBmi4MJQtYsAey06aRlylVW0WIDNVtm/sXEP8NgoJbam8+HZ0nRA5//Dzz8RXvq
	 r3zo3njqA25D8Zgdk3HjkeBMWFkJozK3/1Is888H7v0hhMdaa3AQBKb81lYdBatJqC
	 /YPpRC3/+5F0BT4aIyk3zXstGDWx3afXRzhqBUxsAMhIGEA7fqX7whGBqzs5QyF271
	 mSyIJZOKirgohiUwAzmP0FUbWkzYD21MiGlzU3P+n3CJBTRAiCN/Jphxtp3+w5fCZV
	 ObOFXugdu/SBOMrGL2fRtCuPvz3I4HIAMq8uJfo6O7nO/WQbi+gNAzDjLsvDEbUz72
	 OVhBX6ZRFY3Pw==
Date: Mon, 16 Feb 2026 14:08:53 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net Patch] octeontx2-af: Fix default entries mcam entry action
Message-ID: <aZMk9VbY7XVIA24T@horms.kernel.org>
References: <20260216090338.1318976-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216090338.1318976-1-hkelam@marvell.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258895-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89F3B14473A
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 02:33:38PM +0530, Hariprasad Kelam wrote:
> As per design, AF should update the default MCAM action only when
> mcam_index is -1. A bug in the previous patch caused default entries
> to be changed even when the request was not for them.
> 
> Fixes: 570ba37898ec ("octeontx2-af: Update RSS algorithm index")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

