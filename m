Return-Path: <netdev+bounces-270001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNzNFl2GvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA82DECB8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CBBC3218A87
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBD3C9EFD;
	Fri, 20 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo0FnfV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55602284881;
	Fri, 20 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027935; cv=none; b=W5hbnI9ogZSgU/ZB5dWHn/cWlVKTeOL1cykf7vwE5Z2rshvTAy9u277JSiBaWDhfvAAdk8EIZDVEyn6UDvFPlHb7PDMB+Wta+aWwklMs0H4A4/jVN/1lW5IWtxPOIx2Fc0W1z0115kEhatNdQf/05oJVgU/Tm4NtLAjGgH51kxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027935; c=relaxed/simple;
	bh=TWcQpTrWg7vW03FQCU5s0F6HRyE5dXVyDotFQye0EWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlVUTE4b+HYfUFsMx5pWTeLUOoYMEE2MxOlOgYOVXuoGKU52tn3GRe1bfgq/xIQ9svCmoEaLtRp45+8Gi5xRDp140u6esWMMUzAZixxvTptkNox8jYrozXQbrlj10YYvF0fZC0nrCYyNOfKIjMcNvZLNGMCnEx4JIWVYSzRVDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo0FnfV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C219BC4CEF7;
	Fri, 20 Mar 2026 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027935;
	bh=TWcQpTrWg7vW03FQCU5s0F6HRyE5dXVyDotFQye0EWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo0FnfV880etH8ORanw/T6IC9Joa56C2WkgvbezTCgs3CPnWj1YMiAF6nJZ/MZhPu
	 v18g+UymczeQFiPHcMm2sciXXtFFuHupkeimSDDKnxhEl/lSdqmNVIsZl4BZmk8W8Z
	 ksb0q22B4AuedmCBkidJCov0dn4jaHRcCtxGq2dOfzgjdLAilmiAYecTNiN/vX585y
	 CjMIfHT/XFCa+3yDqbq5FIVgkKxxCVzKi3UCXj6c3t3XyrLUmUnOtuDNq6zwN5e0jm
	 58RIVAKQO+wGA7FS2P1t2ZaKVgzihKg1JX3VrOqUV1oaIS7sXIEaVLuKYloc7WIXR0
	 wmoOEmd5y/WPg==
Date: Fri, 20 Mar 2026 17:32:10 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: Don't embed struct
 phy_device to maintain the port state
Message-ID: <20260320173210.GF74886@horms.kernel.org>
References: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,microchip.com,gmail.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C4BA82DECB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 07:17:04PM +0100, Maxime Chevallier wrote:
> The KSZ9477 maintains the SGMII port's state for speed, duplex and link
> status to be able to fixup the accesses to its internal older version of
> the Designware XPCS. However, it does so by embedding a full instance of
> struct phy_device, only to use the 'speed', 'link' and 'duplex' fields.
> 
> This is also only used for the SGMII port, it's otherwise unused for all
> other regular ports.
> 
> Replace that with simple int/bool values.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


