Return-Path: <netdev+bounces-260177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOmOE0CunGmSJwQAu9opvQ
	(envelope-from <netdev+bounces-260177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:45:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD217C7D6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08EA5300C7EE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6C372B37;
	Mon, 23 Feb 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3FH5OOOC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70050372B25;
	Mon, 23 Feb 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875899; cv=none; b=E61iyV5Tn3U8FZwMvpKFDiG/WymeuxJL/BUl5dUkka9h2sjqovU4SVQWynKCSaZXe0iYX5+m1SQokLOcwXh4/H1Z9b1w0YNAV3nkFqlYLbRC0oFHdZwYqW7XO18RfYUPSakh1tcDwG0LdUA8AO0PaDGPZncfpKR/O4zN7lnLTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875899; c=relaxed/simple;
	bh=QOrJEEXlaQLObhJSUyE5ecFFySbo4RimNxhr3hLlYXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ9RBVsgGnWfWnPrKvvGzt/6pdtznrK9ti5HVGY15QthmR0TytXPBopmoFUvFErSsgbVudGiE5ca6/utXWejRW9uf6mydMiEyyYCv8rWql4U5I0fQrHm/ZP/ts0tTrWnAcowDRpO//VS7qcPk1dHUvQgvx/5K4rHFbwV1EmJ16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3FH5OOOC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v9wjxYCvvOyI5XN0/kxrJ4ahrWI41bXN3B63JHu9q6o=; b=3FH5OOOC0jx/HV5x4u0GCAIDxZ
	RmeGpHkLVuBvf7lh04CwsiEm495ybu/XuFA9cTJ0U+L6y2wRIAH8Ann/dyNutC48PM1xgrNh/hywo
	4SDqKD85SsGdVmPAsFMooHzVB0oPs/bywdbDNWnCrzBMANpdoAkNpe7d1gmWyZqRN5Xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vubrN-008VRc-EX; Mon, 23 Feb 2026 20:44:49 +0100
Date: Mon, 23 Feb 2026 20:44:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 3/7] bng_en: add ethtool link settings,
 get_link, and nway_reset
Message-ID: <f2bbeb1f-962d-4e7e-9b0b-5d4a4ef762d4@lunn.ch>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-4-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223163641.755200-4-bhargava.marreddy@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260177-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72CD217C7D6
X-Rspamd-Action: no action

> +	if (link_info->auto_pause_setting & BNGE_LINK_PAUSE_RX)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 lk_ksettings->link_modes.advertising);
> +	if (hweight8(link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) == 1)
> +		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 lk_ksettings->link_modes.advertising);

It is not clear to me how you are configuring pause, and in particular
if pause it being autoneg or forced.

Ethtool has:

       ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

The autoneg here is separate to global autoneg. You can have global
autoneg on, but pause autoneg off, meaning the pause configuration is
forced.

The PHY should only be advertising pause if pause autoneg is on.

    Andrew

