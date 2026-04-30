Return-Path: <netdev+bounces-282977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A5PXEiqo82m+5gEAu9opvQ
	(envelope-from <netdev+bounces-282977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:06:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1B4A73F0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 967573014694
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE44014BF;
	Thu, 30 Apr 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J1/D+Sml"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4344CAD7;
	Thu, 30 Apr 2026 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575973; cv=none; b=erhFEWN2QvgtaBmNY0JFCgiVSL+f5WXADRfAYveBLcBGDEpfQLm/wba36J2mnpCjs2gdXw/WQ9yLXf7/ih47Qcmq4VoGfB/mHrOxGkiTLbjic3dnMAB4SWEvAKpSLZARDhS44Mb1wG4/Xf3dTf1mRkbhKJfKIAevOspFgCXzhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575973; c=relaxed/simple;
	bh=WOhDFDKSM3ahVB9kjQ37P7I8YZTkab2eRDEUcMDU9VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNpqYGsCKYtd/+XhqG/43ptq9dhARm9E6OEGHhhsypkp11Y2CDkJ+VI+dQeKQWcz54fW0/UFd5eFfpUCYL6a2EREJpNEIxmPOjLp1nKEeoBJ4Ep/aygbYkD6RlbpwceU+VfEu8ppFh04DU1/zCBQHpAWXvePnhcJxwlY7vo/uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J1/D+Sml; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5BDXp7gwtYFwG+SRKtmbzMSZqR4pqpEjVjeJfr6cX1A=; b=J1/D+SmlAplNJfVdy8FRE5+pDL
	ft9ICD+cbmT7Z0XhOVYaiDZKXoBuuQ/6zCtGObJQhGN4/Fe/QHbIiW8j1O0hjHlHAUVQtoMruZBFW
	jyfIlwMzZT7qXnydV2Jo78qzZ49YWOaaF01M+PgyYJk+0sFWvt637D9ANX5AIAc5Cjqc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIWi2-000j5o-IP; Thu, 30 Apr 2026 21:06:02 +0200
Date: Thu, 30 Apr 2026 21:06:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.eckerman.ext@ericsson.com
Subject: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes
 functions
Message-ID: <1a57e151-7fff-41c7-9616-20237c27e935@lunn.ch>
References: <20260430124907.3533344-1-fidan.aliyeva.ext@ericsson.com>
 <20260430124907.3533344-2-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430124907.3533344-2-fidan.aliyeva.ext@ericsson.com>
X-Rspamd-Queue-Id: B3D1B4A73F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-282977-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> @@ -185,7 +200,7 @@ size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
> 
>  	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
>  		stat = &mv88e6352_serdes_hw_stats[i];
> -		value = mv88e6352_serdes_get_stat(chip, stat);
> +		value = mv88e6352_serdes_get_stat(chip, MV88E6352_ADDR_SERDES, stat);

If you generalise this, you can use the same code for the mv88e6321.

> +void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
> +{
> +	int err;
> +
> +	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
> +	if (err <= 0)
> +		return;
> +
> +	mv88e6352_serdes_get_regs_from_lane(chip, MV88E6352_ADDR_SERDES, _p);

Here as well.

This is however looking a lot better. Thanks for the generalisation
patch.

    Andrew

---
pw-bot: cr

