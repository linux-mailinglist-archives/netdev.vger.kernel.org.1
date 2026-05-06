Return-Path: <netdev+bounces-284804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMF9NR0y+2n/XgMAu9opvQ
	(envelope-from <netdev+bounces-284804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F84DA1E8
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDD1430162BB
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367794418D7;
	Wed,  6 May 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nEmWZZmt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15D4218B3;
	Wed,  6 May 2026 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070041; cv=none; b=uxKHblMBQ9TZ1TFbc2A6rKkCzBfkIzAtQnFMIfm6jpRudz3o5Nmc8ySGd/CYhY2wq0KQeEKNEhGIdKHCGErUO5FeZXl9ZX+HIGyBrmyZR94b/BubHX+PVZaO5x9WuZIJlidbJspMovsG2bv9I038J3+KzBGE/5J+7gUmTzipz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070041; c=relaxed/simple;
	bh=Y1K9R2yWFNNKwNhN1mxkmLD2soiEXuCLKYgKNjk0OxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfehK8EPfUh9Jfj3ZqzAKM4acIcmIDyGA5eIT0mT8yHO6XnihxwgTd80jin0Jh9J/eIDH7OK2iNqZkzLDtVn//battTVvuCnwXkdw+krY2QGtrD+xreUKbeAa/5EXMF2+QRVtcKWYO0e/mFs9flrewtplkSkMlO+E7E6HjJU7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nEmWZZmt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pSniqUov44vUMNTsXdR0qPTGsobWMLAF5+gjv4sfAbw=; b=nEmWZZmtU1LbR7368IubWu6P4G
	8nKIdRMit8QMkZ00lZNxah+wXK1nxOXq57ZPtMVgdtlB75tRKGKdTONbJuZv0H1zCc5K5IR+xJCv3
	mHLd4bBk1RbSXivXTMZIfIb9EU+q42/GoyX5QJiNne1IwWlSNXoH6WXQkTbFDC+8gqUM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKbEu-001dK6-2t; Wed, 06 May 2026 14:20:32 +0200
Date: Wed, 6 May 2026 14:20:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "chunzhi.lin" <linchunzhi0@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Message-ID: <d24c2a38-ec63-4973-91c8-357853d837b3@lunn.ch>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
 <20260506021813.3658669-3-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506021813.3658669-3-linchunzhi0@gmail.com>
X-Rspamd-Queue-Id: 583F84DA1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284804-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,motor-comm.com,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index b246902f523f..3cd38bb4de15 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -12,6 +12,7 @@ ACPI Support
>     dsd/data-node-references
>     dsd/leds
>     dsd/phy
> +   dsd/motorcomm-yt8xxx-phy
>     enumeration
>     osi

Please keep this sorted within dsd/. Yes, graph is in the wrong place,
but lets not make it worse.

Apart from that, this looks good.

    Andrew

---
pw-bot: cr

