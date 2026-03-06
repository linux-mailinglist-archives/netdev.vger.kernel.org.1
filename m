Return-Path: <netdev+bounces-264783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHHAM+TQqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:04:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C822151E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E05303018689
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987434F255;
	Fri,  6 Mar 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYl9VpUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451061F4181;
	Fri,  6 Mar 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802272; cv=none; b=D8egZtNp54q+UAWhzUqrQgNyHFB5NJChaufSBeStqvIwO3bph3UoQUU3WYeZuYXKZ0Vr51EJ586Ketg0f602PsmQib2h0ggrcSBfpHCkVb/Ro1a/uygcf1mkpEA5nKxPEqdzpfAWpnGP6UansJg2FczJEEr7nK3sb2lTooouA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802272; c=relaxed/simple;
	bh=06lrB6Cem8O0hQ+qehfrzTjYRLpjBYf5oVGxmkJ5xwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isrdCk+wP8qe65E886K0BjmdKe6QiBwIszlSCDMK58lCLLK9h17IkR8faWRYbXSwiP8ecitqu/oTgVkSdmSqVZjSQWR2Sm2UaWPsHR9q1x8B+oHefXfLh9otO/XF8CnV1DmOrvWvUWRG42zQyL882zqyo6u9ics1FWDJ4hjF6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYl9VpUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF74C4CEF7;
	Fri,  6 Mar 2026 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772802271;
	bh=06lrB6Cem8O0hQ+qehfrzTjYRLpjBYf5oVGxmkJ5xwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYl9VpUxVzM22P75c7uX9CKGr5Ba84nQBnvOQIKLaZVb7N6vqFjy4668XxTZh0YO0
	 EqB60DdumnECxGfDSDDIrne3EwVmGHBjGrbuaizyhEAmhQUjvQ8GoKJRRepAECHtNS
	 djEASD+wGdsm/e9KCkqwVYOYDBR4jM1ZREMCaFarwNIMLsecnLZuKBJR3h0WbECjfY
	 flAvRMP9ZzvBtIUmsnN3Z5ajvKllGCPCa5IBKBc0/NZiJN2VTF0rc4AbG3UiXxrKP3
	 eutrRgB/s0pxsUef74uwJOXKME2aoG9R8PGlrVyh8TKBj9JpHldBzBQODPo5kzP3kH
	 rc8dm/IanJCOQ==
Date: Fri, 6 Mar 2026 13:04:26 +0000
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
Message-ID: <20260306130426.GA461701@kernel.org>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-4-charles.perry@microchip.com>
 <20260305114010.GD90938@kernel.org>
 <aamSGKwG4i+7zBqV@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aamSGKwG4i+7zBqV@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 775C822151E
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
	TAGGED_FROM(0.00)[bounces-264783-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:24:24AM -0800, Charles Perry wrote:
> On Thu, Mar 05, 2026 at 11:40:10AM +0000, Simon Horman wrote:
> > On Tue, Mar 03, 2026 at 10:03:17AM -0800, Charles Perry wrote:
> > > The RX buffers for GEM can have a maximum size of 16320 bytes
> > > (0xff in the RXBS field of the DMACFG register means 255*64 =
> > > 16320 bytes).
> > > 
> > > The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
> > > can take a value of up to 16383 (0x3FFF). This field is not used
> > > when determining the max MTU, instead an hardcoded value
> > > (jumbo_max_len) is used for each platform. Right now the maximum
> > > value for jumbo_max_len is 10240 (0x2800).
> > > 
> > > GEM uses one buffer per packet which means that one buffer must
> > > allow room for the max MTU plus L2 encapsulation and alignment.
> > > 
> > > This commit adds a limit to max_mtu and rx_buffer_size so that
> > > the RXBS field can never overflow when a large MTU is used.
> > > 
> > > With this commit, it is now possible to add new platforms that
> > > have their gem_jumbo_max_length set to 16383.
> > > 
> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > 
> > Hi Charles,
> > 
> > I am sorry if this question is a bit naïve.
> > 
> > I understand the need to clamp the max_mtu to avoid overflowing RXBS.
> > And that this hasn't been an issue up until now due to the maximum
> > value of jumbo_max_len used in the driver.
> > 
> > But I'm unclear on the relationship between DCFG2 and the max_mtu.
> > Why does it need to be set to a value larger than that corresponding to
> > the maximum mtu and RX buf size?
> > 
> 
> Hello Simon,
> 
> The DCFG2 register is the max_mtu value, there's some public documentation
> for this for AMD versal [1]. "gem_jumbo_max_length" is a define in the RTL
> code, the hardware designer probably makes a tradeoff between gate count
> and the max_mtu. The maximum value for this is 0x3FFF (16383).
> 
> The maximum buffer size is 255 * 64 = 16320
> 
> The GEM driver, in its current state, uses one buffer per frame, so the MTU
> needs to be clamped at the maximum buffer size.
> 
> We could just set 16320 instead of 16383 into the "jumbo_max_len" of
> "struct macb_config" but it would mix information about what the hardware
> supports vs what the software support. My approach is to put what the
> hardware support in "struct macb_config" and clamp it later when
> calculating max_mtu because we know we have a software limitation.

Hi Charles,

Thanks for the explanation. I agree that it is best not to conflate
software and hardware support. And that the approach you have taken
here makes sense.

I do think it would be nice to add a bit more detail to the commit message,
along the lines of the text above. But I'll leave that call up to you.

Overall, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

