Return-Path: <netdev+bounces-272322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABR4I0/hxWkeCwUAu9opvQ
	(envelope-from <netdev+bounces-272322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:45:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7433DEA1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C60730543F1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DC33260E;
	Fri, 27 Mar 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIGVhIuH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2B331A63;
	Fri, 27 Mar 2026 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575821; cv=none; b=IvNlpVv/eH2y6seeqdjPiHnUUWr6F7Jm1eE/MHsOO4Dc0JYAo9CIdZRhVQQHwY/GNl1LgJrKuvzTChUfpm4Qt+LtioGAHXsh/r/AIbYfYlIhCk46MdlgwbobbWpTAacrJ6AfTakLAnKzV9mGFjllY6QtzHcD3tHDxsZOKab+EvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575821; c=relaxed/simple;
	bh=iiCnivrI3+fK1Ik1PMZAHClyS5F+z72Tq+mPnjBj2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmUkcRQE4esTtVwaNPka3uxRv8HyTrd6RGsvfcxPmegVIhUGLUQnFngNwYYYMmpW7gg195vF9UystTPNfY5drzQt297HMmH6026baIzSktsTgd+fchYBLz5jNV41LGNFDOxYNJyflqwlmCI1EmjnGta6dQyX2S0B9zv5vrShVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIGVhIuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CB0C19423;
	Fri, 27 Mar 2026 01:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575820;
	bh=iiCnivrI3+fK1Ik1PMZAHClyS5F+z72Tq+mPnjBj2Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIGVhIuHjwV5IYDKaNMshGTJ6CKlt1wYMaCt8i4Pe0NuSnuoLbjDkPFTYdHd7GfYV
	 9zdE1lBMkE1VBLtbPd/1blL9X2SCDgYmnOefWqbdfQ7ta+7G1XKcsvvk7FoZjYMDHv
	 gCcFb3xOlS/XWf02qRvxlYB5eA0kFIM/sZrj1ORmIBAt4whUMXmNZMkzIt6nGZRpUG
	 /jlNhejXrO3VfXIGpnJvAuCFlF3IutjqNx/99kaVXw9lobw1AWU1mTCUb2jcNNRZ32
	 cU9h6Pv92sYpHemYNvDuqeS9FlEcF5LGc2geVK1neKlwnlopI1UDyZz/DpaiqJHLQ6
	 wDsSd2ePz2ncQ==
Date: Thu, 26 Mar 2026 18:43:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com,
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <20260326184338.12dd5c6f@kernel.org>
In-Reply-To: <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
	<20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
	<3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EF7433DEA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 13:47:43 +0100 Andrew Lunn wrote:
> > +	if (phydev->link && prev_speed != phydev->speed) {
> > +		val = phydev->speed == SPEED_1000 ?
> > +		      AN8801_BPBUS_LINK_MODE_1000 : 0;
> > +
> > +		return an8801_buckpbus_reg_rmw(phydev,
> > +					       AN8801_BPBUS_REG_LINK_MODE,
> > +					       AN8801_BPBUS_LINK_MODE_1000,
> > +					       val);
> > +	};  
> 
> This is unusual. What is it doing? Please add a comment.

Also - nit spurious ; after if () {}

