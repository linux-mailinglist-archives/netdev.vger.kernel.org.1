Return-Path: <netdev+bounces-270704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAo0LL2dwWmFUAQAu9opvQ
	(envelope-from <netdev+bounces-270704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:08:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E72FCE72
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F2D311DE0C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0053DCDBB;
	Mon, 23 Mar 2026 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOD2+Fg/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4834250E;
	Mon, 23 Mar 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295285; cv=none; b=o7sQuQmQAv1aqUIGELNcCifI466rxC9iOWjR45icFIMAxYDRDfqdd+Q6RolkXylU9N6DoshGPqO8evs07/nSE2llG4PpXeimfD+g+hcaHXAtwSS18zFRx8sotYEI5xhXHAuTJU4w28SstCrgAm8LhqJolEQU4lQInoOSgJHM62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295285; c=relaxed/simple;
	bh=SHnio8tSnG8NWlOkobDBosLZL29iinvQCLbdljIlaRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=breEaFHScbHf8zQfUjnIizU0qHR2aVrD8p+uvk7eNiauT5my7AIhilB/pe9TaTU4e0Do67upoVvo8Rfohwi6P/sZF0kmJ3UHSkzpiFn0fwtFNa2e9DhyRs0yL2q46sMIfJXkjOm7ynFQhNUN8k+xrQ3X6ZrSCo+SvR/4cYTGT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOD2+Fg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D2CC4CEF7;
	Mon, 23 Mar 2026 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295284;
	bh=SHnio8tSnG8NWlOkobDBosLZL29iinvQCLbdljIlaRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOD2+Fg/JSDS1W6G7wkG8LiPf3EEAXvjUhDOZfI4I01cbcK5pOp6nzqOXEDUvzyhy
	 ku4Z2/OS5OjUyJNBTHbOoDX+cNSEVg+TOS4OfQ2X2rZ/NkxVr1L8AHGZV3t6Z5BKET
	 mp8txeYxx6gDgqn7Ty1pXLQ1GkQB7Nh3DCSKhCgZYxQIsm7etRqbZL2yKU+hedFSVC
	 W/YWFT0gmuPy9ZWjcXpKTvYbpWispuCDhMqij6+hIiGXZi9Ov5y/J1RjMkQ62hNBgC
	 QTEMDDFbxTtl7L8UI1CXy+hRJwwgjyWU8d0vcXmRUkanMkWa0u+vYVzOreNLAzru0l
	 thF0X8W8MoKkg==
Date: Mon, 23 Mar 2026 14:48:03 -0500
From: Rob Herring <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Barker <paul@pbarker.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Remove redundant
 ethernet-phy-ieee802.3-c22 fallback
Message-ID: <20260323194803.GA1241974-robh@kernel.org>
References: <20260313130623.297712-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313130623.297712-1-biju.das.jz@bp.renesas.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270704-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,ragnatech.se,glider.be,bp.renesas.com,armlinux.org.uk,pbarker.dev,linaro.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 542E72FCE72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:06:21PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Drop the ethernet-phy-ieee802.3-c22 compatible string from ethernet PHY
> bindings and their examples. The c22 fallback is implicitly assumed for
> PHY ID-based compatible strings and does not need to be stated explicitly,
> unlike c45 which requires opt-in.
> 
> Remove the c22 pattern from the ethernet-phy.yaml schema and update
> examples in amlogic,g12a-mdio-mux, mscc-phy-vsc8531, renesas,ether,
> and renesas,etheravb bindings accordingly.

This will introduce a ton of warnings in .dts files which I don't think 
anyone wants to go fix.

While I think it's redundant to have the c22 (or c45) fallback as it 
isn't really useful on its own, I think we are too far down that path.

You need a custom 'select' in all the schemas that have a c22 
compatible to exclude it from matching.

Rob

