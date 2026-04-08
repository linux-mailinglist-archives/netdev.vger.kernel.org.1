Return-Path: <netdev+bounces-276556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D7VLdZb1mmNEggAu9opvQ
	(envelope-from <netdev+bounces-276556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD53BD205
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93EF0302979B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89263CFF4A;
	Wed,  8 Apr 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aohr4wmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E83CF665;
	Wed,  8 Apr 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655644; cv=none; b=cp3moIUu1+cpHV7WsjESzv4/fHEB+Lfgu+mU/jQLPGlr0z2Qz5qmIWaXserWORSs7uQyFnSIEcd6NRwgzL45IAdcbKJUV//dit6h+06Mi47+WTVpX/eobKQQDk5LrDM9TLolckg1tRcJBym/XcVS13KmJB4GSFS4aXVojep4PZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655644; c=relaxed/simple;
	bh=+0oydsix3eqfdw2Aq3Jilu/jZTS1qQw8+lp0nii5wyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE/SMH1rel0XB8Bd6npOf+2PIxPXyEeJcbAUlyQY9WtP9BuwteUkh4H289/mzlfY4xgZEXIWhmSWJiClCj66xBLwLkgWHKhNPGTjrwLLjTPyDA7rvxfTmCdnr9elYWtdO/A+31kR5fOSJ6QkVBzd/kZw+9Hfn9iycCqQXmpYkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aohr4wmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFAAC19421;
	Wed,  8 Apr 2026 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775655644;
	bh=+0oydsix3eqfdw2Aq3Jilu/jZTS1qQw8+lp0nii5wyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aohr4wmM+rkXMNtTgbWcQxOdPABsfIvSLaiIxSuvA/Fa8w9jq4e8zeL57njW4E/Zn
	 1WmGBU1a5jmW5+6caOUtHvg5bYtc+mflLu56N2stGp6vaOUTOzZRdMoI/mbpkHA1p5
	 nmJeRbq+sjtnoNIyAC1LPL99XGKtLIJoSrdODO68A6rM6UZjHROd3q0ujEOGRh0h7s
	 bA6TZb9Uoc6BJqyuwlIlc8juqpaH9G1nzEkHvzWujtWq2we0nAAfepTL22yIhKmUOc
	 /oeV9xf98fewJR0OCIknbua+MEcBDQSk8uoy215juMx8bqtDRxHtG74XC7kn2EPLUq
	 h943YSSVcZFIQ==
Date: Wed, 8 Apr 2026 08:40:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, kuba@kernel.org, andrew@lunn.ch,
	linux@armlinux.org.uk, davem@davemloft.net, frank.li@nxp.com,
	edumazet@google.com, imx@lists.linux.dev, pabeni@redhat.com,
	devicetree@vger.kernel.org, horms@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, f.fainelli@gmail.com,
	linux-kernel@vger.kernel.org, xiaoning.wang@nxp.com,
	krzk+dt@kernel.org, vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org, chleroy@kernel.org
Subject: Re: [PATCH v4 net-next 01/14] dt-bindings: net: dsa: update the
 description of 'dsa,member' property
Message-ID: <177565564199.1953964.14327421234664978113.robh@kernel.org>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
 <20260331113025.1566878-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331113025.1566878-2-wei.fang@nxp.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,lunn.ch,armlinux.org.uk,davemloft.net,google.com,lists.linux.dev,redhat.com,vger.kernel.org,lists.ozlabs.org,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-276556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EFD53BD205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 19:30:12 +0800, Wei Fang wrote:
> The current description indicates that the 'dsa,member' property cannot
> be set for a switch that is not part of any cluster. Vladimir thinks
> that this is a case where the actual technical limitation was poorly
> transposed into words when this restriction was first documented, in
> commit 8c5ad1d6179d ("net: dsa: Document new binding").
> 
> The true technical limitation is that many DSA tagging protocols are
> topology-unaware, and always call dsa_conduit_find_user() with a
> switch_id of 0. Specifying a custom "dsa,member" property with a
> non-zero switch_id would break them.
> 
> Therefore, for topology-aware switches, it is fine to specify this
> property for them, even if they are not part of any cluster. Our NETC
> switch is a good example which is topology-aware, the switch_id is
> carried in the switch tag, but the switch_id 0 is reserved for VEPA
> switch and cannot be used, so we need to use this property to assign
> a non-zero switch_id for it.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


