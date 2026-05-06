Return-Path: <netdev+bounces-285058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKrqADe/+2nqEAAAu9opvQ
	(envelope-from <netdev+bounces-285058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965094E1355
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A925A30087C7
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342D34F48D;
	Wed,  6 May 2026 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmmjiaY0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028C214A84;
	Wed,  6 May 2026 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106161; cv=none; b=HVIDbvpahf19kh2xIR0mObPmk01XPvswpBZxsTFx67lpyvZ8z6pnsIyJsXA7GDZnlQ+tGqMSTkyMRKf5sfxKH4E6qMy66vzbEE+IkM9mFa/wp6HTrtyUblR0QcKExyPTk23FbUU8HMPYNUFg7cv0j8qf/5LEjB17Fv8eXHOxIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106161; c=relaxed/simple;
	bh=hwqxnsO+ALySBum5tOGbNdnlNfkkmm95U+0x4x3rmDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVOVfH98iTvT9ZsIGMjiXmiA3zcm1614Hx8Lhncc5zAYMAqZNQVp9lyJifKsVjV+caU85PBLD324hCyQFThqNXvYbF5Ot9f7FZm8iWVtvXSjJzIcXbuhkDjfaUozq/0kXoHO0I5oBKmSk2xb5T/EVmXcb/HEbs6fwCtuvzOR23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmmjiaY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83875C2BCB0;
	Wed,  6 May 2026 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106161;
	bh=hwqxnsO+ALySBum5tOGbNdnlNfkkmm95U+0x4x3rmDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmmjiaY0RCKWxcyRYn2cz29/lsX5fQSz/IWZDpve0Lp5yKmf/XZsTwBAdiItqQd/v
	 ytC2W+0oI2bJTUNIej5Jc16Nv+73nR7hOaLcRa6C/io0s4Gf9lfn/Zu+GltbUyfwFs
	 TIUDbWVJQkZ5ZchQJqKyK5kSM7slM0d8bOBHouiNcF0XxWczgQHo/qzF20tPEKl8MQ
	 MeHr5le2grDqsuthLd1VI/GvFceYfilCV/zERRmhRWir3hxR044MvPW711jreeywR0
	 QaeYfEweLTOjLbilLinl8omGMgd15zx90I5ka2o6rJBcVyW/VYTzd6L5z84wgV7uHI
	 RE7DF+tOVEU8w==
Date: Wed, 6 May 2026 17:22:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux-kernel@vger.kernel.org, chleroy@kernel.org, edumazet@google.com,
	frank.li@nxp.com, kuba@kernel.org, netdev@vger.kernel.org,
	vladimir.oltean@nxp.com, devicetree@vger.kernel.org,
	linux@armlinux.org.uk, conor+dt@kernel.org, horms@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, xiaoning.wang@nxp.com,
	pabeni@redhat.com, krzk+dt@kernel.org,
	linuxppc-dev@lists.ozlabs.org, claudiu.manoil@nxp.com,
	f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Message-ID: <177810615811.3413821.3835724819820623979.robh@kernel.org>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430024945.3413973-3-wei.fang@nxp.com>
X-Rspamd-Queue-Id: 965094E1355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,nxp.com,armlinux.org.uk,davemloft.net,lunn.ch,redhat.com,lists.ozlabs.org,gmail.com,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Thu, 30 Apr 2026 10:49:32 +0800, Wei Fang wrote:
> Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
> it supports advanced QoS with 8 traffic classes and 4 drop resilience
> levels, and a full range of TSN standards capabilities. The switch CPU
> port connects to an internal ENETC port, which is also a PCIe function
> of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> of a back-to-back MAC, because the "pseudo MAC" provides the delineation
> between switch and ENETC, this translates to lower power (less logic and
> memory) and lower delay (as there is no serialization delay across this
> link).
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,netc-switch.yaml     | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


