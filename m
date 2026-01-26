Return-Path: <netdev+bounces-253505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBJxNrl9d2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:44:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BEC89AB7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C716E3006833
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F400271471;
	Mon, 26 Jan 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLmBy3Vq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D2241686;
	Mon, 26 Jan 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438645; cv=none; b=Orxac/6k19vt4asszGAm4eRZf8+sh+6gykZhAp+wnfm+ZN96AGw7jRzEqRTjh4C/XAKtRvKI/mGxufzi+tqW8UJt4EhrQc8jfqTl5M2/qUGHZoWV+nUc3oIBVadFxvI6/NGlIRZfy1b3DKICoB/UJ9vlw/yQO53lIryGHzG0dVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438645; c=relaxed/simple;
	bh=2iI36IOk6jeGCNqxuUHoxbcb4Wx2sV9c46tZ9eD3WR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCk0L/at7OGbAdHKOgwi0bzSN9hHLkzY/kOt9u9AT8iYlLNv341Vj0YIU2i3yfZlPYxydDQWVfd6xcTbhcGzTKmu1tMjt1Sg/UX2fmhRh5DAxFHHFiKCUSc+fFMWdpqQVDlk/BaaXo138khhfSaKphMz54UxxpGTeoeFR2PVHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLmBy3Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23961C116C6;
	Mon, 26 Jan 2026 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769438645;
	bh=2iI36IOk6jeGCNqxuUHoxbcb4Wx2sV9c46tZ9eD3WR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLmBy3Vqewzf0+9PzSovKhA5IQ40MCejWZrJtWqESQN6ClQ/uRUC8iuaurEFPPbzm
	 0jjaoqUAvMYBssw9uOVwKqch/HxgQIzIFr45ykq9Ei4vGQJC/GY4c+Hzb+UPk65iu+
	 /PKooqXaa39NWWr5gLbm2POxi7F7BS5QpzTl9RR3Xbrr/C+u1RgmZhCWF3vFdhmhuf
	 gEFjUyJx3gg3Q06Qsf9wpDMICQrHkwuHi9aGY4CDbw8YzgECVOTU7ZR+LHcWbCOVRi
	 fiEftIuD5Q52anRnYn9mMzxERM6fVQdSuaSf64Ue+hPv6ISo7qaeFPMjWotRcnfrI+
	 UdO1A8UAQsryA==
Date: Mon, 26 Jan 2026 14:43:57 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v10 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aXd9rW0hzAZAUM1p@horms.kernel.org>
References: <20260123132235.1846216-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123132235.1846216-1-o.rempel@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253505-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,denx.de,lwn.net,linux.dev,resnulli.us,nxp.com,iogearbox.net,pengutronix.de,vger.kernel.org,armlinux.org.uk,microchip.com,queasysnail.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 63BEC89AB7
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:22:35PM +0100, Oleksij Rempel wrote:

...

> diff --git a/Documentation/networking/flow_control.rst b/Documentation/networking/flow_control.rst

...

> +**Global Constraint: Full-Duplex Only**
> +Link-wide PAUSE (Annex 31B) is strictly defined for **Full-Duplex** links.
> +If the link mode is **Half-Duplex** (whether forced or negotiated),
> +Link-wide PAUSE is operationally **disabled** regardless of the
> +parameters set above.
> +
> +**Summary of "autoneg" Flag Meaning:**

nit: I think you need a blank line here to keep Sphinx happy.

     As is make htmldocs says:

     ... /flow_control.rst:345: ERROR: Unexpected indentation. [docutils]

> +- true  -> **Delegate decision:** "Use the IEEE 802.3 logic to decide."
> +- false -> **Force decision:** "Do exactly what I say (if the network device
> +  supports it)."
> +
> +Component Roles in Flow Control
> +===============================

...

