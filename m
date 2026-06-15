Return-Path: <netdev+bounces-299309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8eVKDVh7L2pgBQUAu9opvQ
	(envelope-from <netdev+bounces-299309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:11:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EC168337B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="f/P/tUVK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299309-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4E6300737D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83A2E7392;
	Mon, 15 Jun 2026 04:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4634249E5;
	Mon, 15 Jun 2026 04:10:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496659; cv=none; b=A86kl4mZDd+EZoiEfrp4ssdOv7MjFUgy33apn+5VAH7QabY4vXPfIEDvAH66Tm00+EEiht0WCxK21d9IkSHdNXfH4D0Bl9XLTlSQYrvzWtFwD4PL6DrUPNr6vUJVhkk2Xk3TFQbu+pHOw/HrMw0WOybaL2otYQ2ZbbrzC8I60jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496659; c=relaxed/simple;
	bh=9oxFnvt0hqbPVELZESivaWFfXLv1XhiCca+xj5vV/QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaT1HvsM+2mXMlAFudSnYobLQvCzN+iBhhl/v1pCNq2u8nDkSrWAbl51ZogUmhZRiNGviptxOcR60sFIY8kXeU4sp8lGNeaRwcMsl37AhAyOzCx1fKJaO1967PLv7smc2gEdgeg+/bAzI/arPoVP3xBA92vRSoQjcQbGZELfVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/P/tUVK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005D41F00A3A;
	Mon, 15 Jun 2026 04:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781496658;
	bh=MBs5J8wgb3QPn7TFVPRBrDLOU6PSgWEFjXQWr3rd7wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/P/tUVKDQRTjQxFEJPRYeZkdgACDWBVh/FKp3USEjrjcQ9/khiDt2Th7+YOL5pKf
	 D4pZXIbZes/4BW34sS1nH3bV8vxDvi31JCmRFYSCvabgUf6tQH+3brYSgI4R82/PKd
	 kkMj8wmDzhepe3QXDg52Xz3v2Q7+2mYXM+9vMmq8MD3WwdnZEvor+3u/CIhpzqv91L
	 PQUVLYL3P0NYb1o3YtPvI3AYZJ4POz/BwF/6kzrflteURWWYsc2jtXTIqSXoM1schM
	 sBNozTPApq1iyCmcXaqVjPOERjSpaJV4g9Lboy92PXkCXJnIE30X6H4SRAw0WVCYPj
	 33NbkzTYtROWA==
Date: Sun, 14 Jun 2026 23:10:56 -0500
From: Rob Herring <robh@kernel.org>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v5 14/15] dt-bindings: net: add onsemi's S2500
Message-ID: <20260615041056.GA1426553-robh@kernel.org>
References: <20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com>
 <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-s2500-mac-phy-support-v5-14-89874b72f725@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299309-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84EC168337B

On Sun, Jun 14, 2026 at 10:00:30AM -0700, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
> compliant Ethernet transceiver device.
> 
> We use IRQF_TRIGGER_FALLING, though OPEN Alliance 10BASE-T1x
> Serial Interface specification calls for IRQF_TRIGGER_LOW.
> 
> This is to match IRQF_TRIGGER_FALLING used by OA TC6 framework code.
> This bug fix requires changes to the stable branch. At that time,
> this will be changed to IRQF_TRIGGER_LOW.
> 
> ---

Everything after this is dropped from the commit message when applying. 
Your Sob needs to be above it.

And you are missing tags from prior versions. It is your responsibility 
to add them.

> changes in v5
>   - no changes
> changes in v4:
>   - added spi-max-frequency as suggested by AI review
>   - changed interrupt to IRQ_TYPE_EDGE_FALLING as it is
>     being taken care in net (stable) branch
> changes in v3
>   - Removed URL link that failed verification
> changes in v2
>   - removed spi-max-frequency entry
>   - changed the compatible string to s2500
> changes in v1
>   - Added the first version of YAML file for onsemi MAC-PHY
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../devicetree/bindings/net/onnn,s2500.yaml        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

