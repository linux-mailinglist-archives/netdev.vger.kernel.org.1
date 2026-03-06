Return-Path: <netdev+bounces-264784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIVrB83Rqmn3XQEAu9opvQ
	(envelope-from <netdev+bounces-264784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:08:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECFB221628
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F893019F19
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163C390C9D;
	Fri,  6 Mar 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn1euWhY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF77296BBA;
	Fri,  6 Mar 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802300; cv=none; b=QGS+p8UhS+fIbqN79TBU5NLM7l36olHCKNWW9+GyCRAurHirLNq9I7BA91HLPUjxzHDj/bDzmFW6wZI18Ds/UIcP7WFIwN/DibyYbSYO/rxrJ53jyRjVL1FYF+4RmhoQUTJ7J2TPSbtPGglfuVIiOJPCHCdBBR/cJNp5k6c0u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802300; c=relaxed/simple;
	bh=YJnF7YYdSjTbFJ8+etdFZLhgzDDcBHopGM6zUsnq2ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8QhZABFrouzUUpUrMW5HIX8ZRTQInH0o64Vc4JRimlbbkT9HAe3XYjoNlmDzdDCJdfIXAFIuMw98oWNbjbrkxmafKJzhsp6gmd5LZw8Y+t8xMrSl93r04ypx4MSg6l2i/aSz4gqAmfV4HxE0F+ymNKjaYfyaKdEOaX4logk9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn1euWhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A16C4CEF7;
	Fri,  6 Mar 2026 13:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772802300;
	bh=YJnF7YYdSjTbFJ8+etdFZLhgzDDcBHopGM6zUsnq2ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jn1euWhYr/Pd9jPE66YzP8kHD3pZ4nV3KKC7AcJLmzKI91pTUlGm/ZxkZcmnfLqWQ
	 gixWhqWW0AgaUI3k/3izuS8Rk8YqulP0waTkkory339bhClMLI6pY9Gr2tNTUoqbou
	 pf1B8zyQDqinDt6D59p0S3gw1upaA86ZdVk2j0JT6V/oz5dvI1zCnC7koCEF05OPuV
	 WZzsnKXleKIFi3Vunt5XdE/82g+Q+EKlI6qyqu3+trFXycG/GQgtOF25Av3JXeAkWz
	 AWrrK5JtvIMBt2d2CRrLLksECsMSLTq9OxK9ETsGGjhHZzOqjOTHbhq+hSE63aWFM4
	 NPAjakE06dAdg==
Date: Fri, 6 Mar 2026 13:04:54 +0000
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
Subject: Re: [PATCH net-next 4/4] net: macb: add support for Microchip p64h
 ethernet endpoint
Message-ID: <20260306130454.GB461701@kernel.org>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-5-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303180318.1814791-5-charles.perry@microchip.com>
X-Rspamd-Queue-Id: AECFB221628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264784-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:03:18AM -0800, Charles Perry wrote:
> p64h doesn't have the USRIO register so MACB_CAPS_USRIO_DISABLED is
> used.
> 
> p64h does support PTP and has the timestamping unit so
> MACB_CAPS_GEM_HAS_PTP is used.
> 
> jumbo_max_len is set to 16383 (0x3FFF) as reported by the DCFG2 register
> bits 0..13. The JML register also has a default value of 0x3FFF.
> 
> dma_burst_length is set to 16 because that's what most other platforms
> use and it worked for me so far. There is one other mode where bursts of
> up to 256 are allowed but this might impact negatively other masters on
> the NOC.  The register default value is 4 (bursts up to 4).
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


