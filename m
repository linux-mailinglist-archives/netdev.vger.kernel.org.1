Return-Path: <netdev+bounces-261562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBnKLx+moGk9lQQAu9opvQ
	(envelope-from <netdev+bounces-261562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:59:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E601AECBF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337D73008793
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E538A72A;
	Thu, 26 Feb 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH0k25i0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2742B735;
	Thu, 26 Feb 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135661; cv=none; b=BQnbO9muxRAKUS0bX0TOZ1ebK0O5I4cHGLfiSOKjpQp6VOAzRdtUmFImxLkvMHGgFBlFg8a7sN4zf++Ra6HHxjCWI2TxS0WLwhNxnUDKCCDsqIRV8DvcZln2hVSUTZshZsM3OB3fKDqM1FrHxWLkJuFhBielMdJAqj/9X6z8uSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135661; c=relaxed/simple;
	bh=ra19xZQ3U6KCpnqoVkJJ26X+RkV6l54AxB3o5a/KUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIJ8rxqFHCfGtsr3GQVv7ndv3l+YKddcl9B88CTTupnorGxpVGqIM/szPiumJjAj3l9YrAfZ5S9IiJoNOC4r1VgirZK2xhk2mArreGJEiqgBPC3RUv+OpYqBW2iZtLTkRnKqB2ad5S2M4wgaByeH4xqUBg6Y7Ant5t+de82ToQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH0k25i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70BBC116C6;
	Thu, 26 Feb 2026 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772135660;
	bh=ra19xZQ3U6KCpnqoVkJJ26X+RkV6l54AxB3o5a/KUT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RH0k25i05AyewiHg+mLoRLkocZqu1CBJgC0LIpVRtwWr98r5m1qlfIj1yrWxqxJ7i
	 D8yrK3WqKNx0xTAiugcdYzxZNjQ4YVn3diFg4jLh9pHf/nekt6Dvhuy/QasfNp7NPd
	 QJbXCi2HnvFWCJujt2lyUvFLIscz68PcFCjuu3sVgf8tN90f9dJkGowGIaHLG+GDIq
	 UUlIT2HVRuXfHYptcuopoGnlIjflhPxPOK6azzYCSbZHfI1NvOAysdc7TSe80bMYvh
	 BxS+u16/ITHxY4ufmvLVnRyBwuXebdPZFLm49lbKFn2dZPo/dIbBLaj4wedYbIVALc
	 SNwDRqKtOhKOA==
Date: Thu, 26 Feb 2026 19:54:14 +0000
From: Simon Horman <horms@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Vishnu Singh <v-singh1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Nishanth Menon <nm@ti.com>, Michael Walle <mwalle@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix
 multicast entry handling in ALE table
Message-ID: <aaCk5pDO-xGf4W4A@horms.kernel.org>
References: <20260224181359.2055322-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224181359.2055322-1-c-vankar@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,gmail.com,nokia.com,kernel.org,ew.tq-group.com,linux.dev,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E9E601AECBF
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:43:59PM +0530, Chintan Vankar wrote:
> In the current implementation, flushing multicast entries in MAC mode
> incorrectly deletes entries for all ports instead of only the target port,
> disrupting multicast traffic on other ports. The cause is adding multicast
> entries by setting only host port bit, and not setting the MAC port bits.
> 
> Fix this by setting the MAC port's bit in the port mask while adding the
> multicast entry. Also fix the flush logic to preserve the host port bit
> during removal of MAC port and free ALE entries when mask contains only
> host port.
> 
> Fixes: 5c50a856d550 ("drivers: net: ethernet: cpsw: add multicast address to ALE table")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on commit 'd4f687fbbce4' of origin/main branch of
> Linux net repo.
> 
> Link to v1:
> https://lore.kernel.org/r/20260205070951.3170631-1-c-vankar@ti.com/
> 
> Changes from v1 to v2:
> - Squashed two patches into one as a fix of the older implementation.
> - Added "Fixes" tag in the commit.

Reviewed-by: Simon Horman <horms@kernel.org>

...

