Return-Path: <netdev+bounces-255865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YECTCEWigGni/wIAu9opvQ
	(envelope-from <netdev+bounces-255865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:10:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A7CC9E0
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAD7300EF86
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA5366060;
	Mon,  2 Feb 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0gmmAoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDB361DA3
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037826; cv=none; b=gDt0Qq0OntCCWjBAFGHUF+W6Mod65vNzRsVEMaNcrTWofLaV0M2T/+KGgSzrbjrmlkflShHWIPFBeDVSOgP6WT95d977IKbCt/dj5cxaSx3VCYESa9r8piJX7LNyBP2yy5pmjcYkm+hEpfg5bI0+gl1crEpfwnuFi2chGkC00VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037826; c=relaxed/simple;
	bh=kTc+By8vcdbzquQ8RjRTi/Kx9huvLukCOUjDmfuFC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtK5ZE/VzQCyUZRxWysvG6XBgdB3rEkIXLtBh+LBghq8DxSwbLDXsdoLKisI2dd6Tm8Sn5a99J2cWU0oHVWRIQChN/+L+L6ybCEH26dN0P4G0HHUDBRollCu5YjxzDGmRx3xuS2quoH2CJF4juCBTNaT5tv1DTGpEoJanXEI8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0gmmAoY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee9463ca3so3081405e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770037823; x=1770642623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5zMF7HqmfdsxiMzbiVAGcCbe9kzfgf1p2X3RVPb0ck=;
        b=g0gmmAoYvSRmshMoRgJ73gOVMsDs0ak8a8QACiC63mZ3llizoAkRyS93jn5zLpAnOh
         gfuR2rxMxV2UblstTnkY5Tr1OVn0tvXMnOHu+VnQ/H0DIf9HwKNOE7lnczXfZS2UI3A+
         07o7J1zb8zw6kXAXzW8yQfxmQt9CgHFj9GZkec8h4nHfPZqP2zKWVKQ6ToxYNr+o4WBU
         68t7szp+VbVyUtFX1wWuURT6YSAycXVWw57ykqA/g2PzyNjZAeEKfTRB4zDOq9lCh2y0
         0jij2huz/TThEsGY+/w40fBAWNu7NZXVzsQUNoxD9cfNIcx2io5MQlKk1/S38Xv6FxeC
         R84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037823; x=1770642623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5zMF7HqmfdsxiMzbiVAGcCbe9kzfgf1p2X3RVPb0ck=;
        b=T4pgXUG31KF2t7OCy+lijKjpsf3VAcGG0842FZIEqSOaSFIlfv1OiHPiE9zLlTR2Lc
         PFqvyebrFkiaYlYgMseR063jAA1+HJxXFvZOtvLQcmF2jZeXx7gbFDMX8SJyxfVE5vwJ
         K/g589DXW1imJlzcefAgooUL5Wouf6ObiIJotg20wSfXyY8/YzLPvoGvH0MAfnDSS1rt
         VW9qWPiiF9BSmj5JCRPyiQUFE999EGMgexdWOZe0pC3nAdr0Muo1wc6zJs8AzdZZaxXs
         rKNQP4wFNlXL914zkVfOMxedhN26+cZhnS8L6R94GH5BxYZlxvAXujL6Qj5wZRrF4DfF
         +aoA==
X-Gm-Message-State: AOJu0YwtqdK6SB2G9ZCNt49ItUPCowy7GGThDJ2yDjDOu39B5Sk/2nlc
	zzl91wOH22MmPxOdq8jPAWxxt2pd2qMa9cbCCGUeX6RjAZBhXdk+1VfD
X-Gm-Gg: AZuq6aLG3nEcNNo8BRw5u2ZR9nO+EJGNwO7vJtzq2amdovNUODXJX/yiYCl81/zeLCt
	h++hTAgJ9FVrOY/60tqiViJIAKM2UY/3qKRlci2Q2PnN+z8MWcOaMjoKF3PEa057Obe3/8oCbu9
	zsgiBpf+CrSpgAdjGCYyobJ83vIv+79H3a/zWrhh1S7AhVMLq9049Z7snCsDRgTuhbxDDdm8uis
	7whGmNQWlQ9HVn2YxqG7dGLZ/M8MEhcf640eF1TSxVb4lDuuOdKKpTJHiPWNNyQ3cZfI5NTmkfc
	1HGTOcOocDqgZTvc3WrDSbC41sYgv62A44fwS6NYKVIsHxNjBpqzR80gyM4wvVd2pGpMv2cxuhW
	mNH804JkfKgiQcdfYiyNNYc60ktSaq9osv6/rNOYQG3/9ZhmGs8Jv4gN0Oa1gq6Ge18xBMOitFh
	wPbr8=
X-Received: by 2002:a05:600c:4f10:b0:480:6612:253 with SMTP id 5b1f17b1804b1-482db494609mr94330815e9.3.1770037822450;
        Mon, 02 Feb 2026 05:10:22 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm42729518f8f.34.2026.02.02.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:10:21 -0800 (PST)
Date: Mon, 2 Feb 2026 15:10:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] net: dsa: yt921x: Add DCB/QoS support
Message-ID: <20260202131019.6qz73anlgutewrww@skbuf>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
 <20260131021854.3405036-1-mmyangfl@gmail.com>
 <20260131021854.3405036-6-mmyangfl@gmail.com>
 <20260131021854.3405036-6-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131021854.3405036-6-mmyangfl@gmail.com>
 <20260131021854.3405036-6-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 794A7CC9E0
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 10:18:51AM +0800, David Yang wrote:
> @@ -1774,8 +1778,11 @@ yt921x_vlan_aware_set(struct yt921x_priv *priv, int port, bool vlan_aware)
>  {
>  	u32 ctrl;
>  
> +	/* Abuse SVLAN for PCP parsing without polluting the FDB - it just works
> +	 * despite YT921X_VLAN_CTRL_SVLAN_EN never being set
> +	 */

Why "abuse" - what else does this setting affect? Does the port not
remain VLAN-unaware w.r.t. filtering/forwarding destinations?

How is the unused YT921X_VLAN_CTRL_PRIO_EN field from VLAN table entries
related to VLAN PCP parsing?

>  	if (!vlan_aware)
> -		ctrl = 0;
> +		ctrl = YT921X_PORT_IGR_TPIDn_STAG(0);
>  	else
>  		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
>  	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);

