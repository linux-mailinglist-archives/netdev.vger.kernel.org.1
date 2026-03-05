Return-Path: <netdev+bounces-264325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI2WFKRrqWkg7QAAu9opvQ
	(envelope-from <netdev+bounces-264325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:40:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC534210B6C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1291B3016295
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090230FF37;
	Thu,  5 Mar 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poQQX8wH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9941C8604;
	Thu,  5 Mar 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710816; cv=none; b=NLM6HpHPpid/JGezaPTI6jlidsoYswYiB8TWPCSS8r23aFdtIDSNe6GImtrd9rQW3W1fYwYR5Air5eOZwm5FnUCTw0gkrhg6Aj5hmkv0BTlStgGVi7JwESK1QX/WAwcNqfjFqzaVyHvb5ydnvxoH+TYU2iWCY9DGZqW2ikfSDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710816; c=relaxed/simple;
	bh=1p/Nk0MC98exNpyGON9gfNuYIE+M0R7ekjo6NyhRjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCYwX5ob5rFRNGiiNOOt1YqyIEiXjkHrm0FEVpdPdNqbcLsMwdj1FOQvh7xMw1CQtzh1yic7lrMerg1i3nkDcXuA2q+a5gDDf0oBUVr2m1X2wBVXSJsIIaHDtJfvMYjYBnydXInbkmAoAkQxJIzSlS1ien35GH63knMzFaEu8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poQQX8wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EBFC19423;
	Thu,  5 Mar 2026 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772710816;
	bh=1p/Nk0MC98exNpyGON9gfNuYIE+M0R7ekjo6NyhRjsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poQQX8wHUes7U4A4/FdfuNLTv8TdhxS3QZC4eOqAQYZz0YHGITbbxknkt5B41ZN8p
	 p5U9r/0GWTatkTw1pJFVkuPmYmIg8IFjGL33O/BNrUDcgEKTjl6VD4aekjVf/4XIcc
	 W4ZPHExrCLlq3TWelO8dg1qMRaXli01C5GfiCX06Y/oS6uCJji6x7PtTVSuda1xWXs
	 AvoB5hWYJMzXZBiCdjeu6sw0RRqjnkaJtqBWdLHUKZTXjdIMSLRpjn0caaaXMItLOd
	 Sb/W0uk1qJ29AvpbzhjM/3PjrqBhikXss5PRi0mVRytHGJ9p5yV8YJxcVuCt6wIydC
	 iHuquGwPZi4bA==
Date: Thu, 5 Mar 2026 11:40:10 +0000
From: Simon Horman <horms@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: macb: add safeguards for jumbo frame
 larger than 10240
Message-ID: <20260305114010.GD90938@kernel.org>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-4-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303180318.1814791-4-charles.perry@microchip.com>
X-Rspamd-Queue-Id: EC534210B6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:03:17AM -0800, Charles Perry wrote:
> The RX buffers for GEM can have a maximum size of 16320 bytes
> (0xff in the RXBS field of the DMACFG register means 255*64 =
> 16320 bytes).
> 
> The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
> can take a value of up to 16383 (0x3FFF). This field is not used
> when determining the max MTU, instead an hardcoded value
> (jumbo_max_len) is used for each platform. Right now the maximum
> value for jumbo_max_len is 10240 (0x2800).
> 
> GEM uses one buffer per packet which means that one buffer must
> allow room for the max MTU plus L2 encapsulation and alignment.
> 
> This commit adds a limit to max_mtu and rx_buffer_size so that
> the RXBS field can never overflow when a large MTU is used.
> 
> With this commit, it is now possible to add new platforms that
> have their gem_jumbo_max_length set to 16383.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

Hi Charles,

I am sorry if this question is a bit naïve.

I understand the need to clamp the max_mtu to avoid overflowing RXBS.
And that this hasn't been an issue up until now due to the maximum
value of jumbo_max_len used in the driver.

But I'm unclear on the relationship between DCFG2 and the max_mtu.
Why does it need to be set to a value larger than that corresponding to
the maximum mtu and RX buf size?

...

