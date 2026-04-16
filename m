Return-Path: <netdev+bounces-279027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D+LISzQ4GkkmQAAu9opvQ
	(envelope-from <netdev+bounces-279027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B4C40DC8C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B333D3087452
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231583A9DA4;
	Thu, 16 Apr 2026 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKub4dON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03433793B0;
	Thu, 16 Apr 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340862; cv=none; b=Mx1zYzSkmE27SOzeDazDleBcvyhIh44QuIrw0XXYXKWhnpbmxx3uowxoMeuk72q4Mb67ettZ4b026WGc5nBhKYBOTbjZlIE5FlJ8hmyYrmNDFLj0sd4+JPNtgpm6xiJr/sUx0VLAYWpJr2fZglP8ln/Ne5/Rrf85VjG58qP4Kgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340862; c=relaxed/simple;
	bh=S2XabBjYZhsC7sABAPetHBPk84SDJde1dhmatVsKbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdx+Z5FM6D+ZCAERTaWo0AJCoLJLM2zCfZccCx72XLF95JETFZWOyVy0Aui6iZwOok1mR0MGAChyzIAHvWND78ZE3WTgGjYOrLgS5nOOwA0MxH98cUQWKeVv58d4jqtcUKGwc+t/FADb4dSWagNeB/P5RMqFhPTUPL18ya/v7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKub4dON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69799C2BCB4;
	Thu, 16 Apr 2026 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776340861;
	bh=S2XabBjYZhsC7sABAPetHBPk84SDJde1dhmatVsKbbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKub4dONgo057cMnGPJrd0DDstAxx1WRIKk7zzO26GHp4JPrOpwSyYkrEyP4ejlPF
	 YvWOlnaMvEPxSzfYI9tgqifsZHkq/kStKcJw7RydmGHeScanaNiTlXhPVWCrkJVsab
	 YeFlw66HR3RUHzJWgw3PpHvIkupicHLOoCdoee0KDKDRW4fWYGaakz75+T7DycJ9Ga
	 CTr6jtz4zs5UOMv35hOsB61hMtHRWKBIhWVs+va8tO+3X8mhnLjjxO0glh+kZJ/qE8
	 j95FM46aqQEHceyCXOfO7OnRyzAUx4xBVbSDRabf2lgq2CNo8FFCjFQFxfubMK79Cs
	 Mz9I6XY9SDxCQ==
Date: Thu, 16 Apr 2026 07:00:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v3 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <177634085879.2732675.9167969896775365019.robh@kernel.org>
References: <20260410-dsa_lan9645x_switch_driver_base-v3-0-aadc8595306d@microchip.com>
 <20260410-dsa_lan9645x_switch_driver_base-v3-2-aadc8595306d@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-dsa_lan9645x_switch_driver_base-v3-2-aadc8595306d@microchip.com>
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,redhat.com,google.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-279027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 30B4C40DC8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 10 Apr 2026 13:48:38 +0200, Jens Emil Schulz Østergaard wrote:
> Add bindings for LAN9645X switch. We use a fallback compatible for the
> smallest SKU microchip,lan96455s-switch.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
> Changes in v3:
> - remove additionalProperties: true
> - remove unnecessary | from description
> - change top level $ref to dsa.yaml#/$defs/ethernet-ports
> - use ethernet-ports and ethernet-port
> - move ethernet-ports under properties instead of patternProperties
> - move unevaluatedProperties: false after $ref
> - update example to use ethernet-ports and ethernet-port
> 
> Changes in v2:
> - rename file to microchip,lan96455s-switch.yaml
> - remove led vendor property
> - add {rx,tx}-internal-delay-ps for rgmii delay
> - remove labels from example
> - remove container node from example
> ---
>  .../net/dsa/microchip,lan96455s-switch.yaml        | 111 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 112 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


