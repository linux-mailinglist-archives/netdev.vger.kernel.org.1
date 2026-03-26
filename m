Return-Path: <netdev+bounces-272015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DJFF60lxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:25:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF83F335281
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF524300B10E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6BD3F7875;
	Thu, 26 Mar 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VPG6ZaWP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8938B121;
	Thu, 26 Mar 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527265; cv=none; b=dg6yUfd7chFBT96xilf0CalauPxUTfM7Ct4QVAfEgNFqL/+oZe9RoeTxHy5PWh/7nmWwLaTHMrTWrh/fm8NAjm+SzGR+S8PV5CV7+ZyMngZzwKlRnL6qu6mdQFz3/TzuHTXVpuymuoOC7+RzqmXyGd7Ls6sDxCatnBmAgMc0Z7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527265; c=relaxed/simple;
	bh=bwHn5ee8/BMiVEQ2a0oY/PvtpiJF7va3KpPKdeTQTfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIbRuXXzLD7Ez7ZRwbaVz84oWYvyUCZ81DTpRhCfznfyzo3tfb/BRm0wXiiL4oWonNOu6hcA3pkv4DZ5VjPfQeSAaBtYXI1qy8zPYjbyH/JvITntFxqR9bDrPL+mSBP1+P4k5Aj6fM6t2P8hlil1L9dAL753j2nRy+YAo1YDvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VPG6ZaWP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nODx/pKi0XY2U0hMYX1gKhrixXQuNH+ob0VCp10UmDM=; b=VPG6ZaWPQYooabUf1pTssgK19i
	9edbhjTKUlwuiUunE6xIcxMOI1ys3rsdTQbq2rZ8vMezzrkL0R8E4zjXrJjXmZ4/VAD/tl2BHzLa4
	ca7NhAOuq1Zda82EfcvNvZ1zfmVV0WkwtW6jJ0igHPKI4EZESzjO1xWL3DuArqszoM1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5jbF-00DTO2-Vo; Thu, 26 Mar 2026 13:14:09 +0100
Date: Thu, 26 Mar 2026 13:14:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH 1/3] dt-bindings: dsa: microchip: add KSZ low-loss cable
 errata properties
Message-ID: <521cf729-50d2-44c1-8c96-c1fba2127b9d@lunn.ch>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272015-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,vger.kernel.org,exotec.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF83F335281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:10:21AM +0100, Fidelio Lawson wrote:
> Microchip KSZ87xx switches are affected by the "Module 3: Equalizer fix
> for short cables" erratum described in DS80000687C.
> The embedded PHY receivers are tuned for long, high-loss cables,
> which may cause signal distortion when operated with short or low-loss
> cabling such as CAT5e or CAT6. In these cases,
> the PHY may fail to establish a link due to internal over-amplification.
> 
> Two workarounds are provided by Microchip, each configuring a different
> indirect register value to adjust the PHY equalizer settings.
> 
> This patch introduces two new device tree properties to enable and
> select the appropriate workaround:
> 
>   - microchip,low-loss-errata-enable: boolean enabling the feature
>   - microchip,low-loss-errata: selects workaround 1 or 2 (default: 1)
> 
> These properties allow board designers to opt into the errata fix
> according to the targeted cable characteristics of their platform.

Does the errata give any indication how the two different workarounds
differ? How would a user decided which to use?

I also question if this should be a DT property. The length of the
cables is not a property of the board.

A PHY tunable would better reflect the same board can be used with
different cables, with different lengths/quality.

	  Andrew

