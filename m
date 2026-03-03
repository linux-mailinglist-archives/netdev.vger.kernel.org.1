Return-Path: <netdev+bounces-263229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPvUCeDtpmlKaQAAu9opvQ
	(envelope-from <netdev+bounces-263229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B318A1F150E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70EA23004619
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7D3D6CA4;
	Tue,  3 Mar 2026 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fzgxBuXR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492636D9E9;
	Tue,  3 Mar 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547535; cv=none; b=CbplvTIdyxtSzlU6RTpjHxJ1MPs+sZArK4dd8uEyMf3aTrOkbqKh7cw4EODMM4UyIDf7ZMLuWPG5eoayXUPNn1X0TO8EkNMv9WFDWquw3nG/B7Z0/Mukye4VvO5aRnwwVv1F/4L2TNqZs5jhAUxIWGDfWJb8/CLQIxh/1Cx5LBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547535; c=relaxed/simple;
	bh=JPFqgYi1Dv6MyQj6TPG9TdPWn3O2Cor+PGrwtLhEj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi3e45FEVQOIlBGvFkqgFSM7oKRGIyk0vj8kyEFUIBJgLlcckFGymz0WEpuQ6KZfJvxajSAQAuayJqEqPXH5aT7/ILpbUeasPkuGZ1VvCXfrtmM0XsUXslaG16esSN5DK7HxDzqwtcKNXptzvGQ3gLZEo+skdbzYm5G0YZ93drU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fzgxBuXR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+nHBkmQijyAGhMX32bNGbPnMfuA80dIeNxevfOH31Aw=; b=fzgxBuXR6XzIMO3VO4rjmSXZD0
	8Ief15AJ+nt6Mjx9E/pQbAo0RGEa8bXoaxZP2wH/YolvHIsxzj4gYfaVkvxmrppDQnm1CF5/xHcHF
	SPLrvI5UZFUqEGxVnxsQ+WK+8Sg1zFbt6gz+ppvb1M/9ea7ZiLpRRx/KDI/kP74aktMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxQaD-009s1E-Sv; Tue, 03 Mar 2026 15:18:45 +0100
Date: Tue, 3 Mar 2026 15:18:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: B318A1F150E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263229-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> +        properties:
> +          microchip,led-drive-mode:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |
> +              Set the LED drive mode for the copper PHY associated with
> +              this port.
> +
> +                0 - LED1 and LED2 in open-drain mode
> +                1 - LED1 in active drive mode (can be used for single-LED
> +                    configurations requiring active drive)
> +                2 - Reserved
> +                3 - LED1 and LED2 in active drive mode
> +            minimum: 0
> +            maximum: 3

I doubt the DT Maintainers will accept that. This looks a lot like a
value you write into a register. How are active drive and open-drain
described in other DT bindings? Is there something you can reuse?

For 1, what happens to LED2? Not used at all?

    Andrew

