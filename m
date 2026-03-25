Return-Path: <netdev+bounces-271752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPj1L7xXxGkCygQAu9opvQ
	(envelope-from <netdev+bounces-271752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:46:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8A32CA4C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 22:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D7F3012803
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70A381B1D;
	Wed, 25 Mar 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd+skQjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6102773DE;
	Wed, 25 Mar 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475191; cv=none; b=fsv+gGBzFtiJvMaWQ+TA86za1rGGS2pNkHLfwsB1PhVyhUU1nLXbnf2U0ViLG+agNLSR6wNhibxM5AZLOvljwoMuGnkuHeEMAQ5bawKt5eixnAPqaTZUY1viaPxDRK1KGuxJ6WgvRpjEEIKgU+9Mvgc90dKKsSmQ9d+QmMv6VZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475191; c=relaxed/simple;
	bh=4Fe2RtyviX4XAyMQSkJ4js2V2P1pz5B/N7YGrsl9zcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3LGQhAetbNF0MR7eFxixddUUQrwk04O1mYuTSgUIRLxba+tLtrKNxGhssvpbgbomE3yiByOlI4MJT4hp3ONGAbVFQ3Fbioa6HvQ1RucPTo1/Wp+70r/QiTNyyQ3c+Laj8UGb6DqcR+hYGguFxqBsx2RmEEDgcrVX+NZLZGv9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd+skQjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEC6C4CEF7;
	Wed, 25 Mar 2026 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774475190;
	bh=4Fe2RtyviX4XAyMQSkJ4js2V2P1pz5B/N7YGrsl9zcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd+skQjS3BMVlPvY/Wq2/oTBkb3Q/8to8HmZ2p3JV8T6KVAB0Hdh3NuBqQibWG69O
	 sTIdjVfGv/pVHtEboALTgNO8qC4pctE9+BrgnOFbNoSJQWvd2ho2m3stM8wW9QVRrB
	 jsqc/XHaccHO/YHl2JI3wRXJnr8s+HTlQS1fYge0ucJe2vG4RpE1nTr/0s53cFYJ/N
	 M8eYlciKHFcCoh2AdKuge+r0/BbSunYysDZqgLvqP47ttBFcfh4pPQSraN1QvsffbX
	 wKW1iYoqH26weoB/8paywGKkmu9d+XwJSxkzsv/ju6Gl3XS97nHfty+38gOL8CePP/
	 NBfC4CCUN+hUg==
Date: Wed, 25 Mar 2026 16:46:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"David S. Miller" <davem@davemloft.net>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Valentina.FernandezAlanis@microchip.com,
	Alexandre Ghiti <alex@ghiti.fr>, Abin Joseph <abin.joseph@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>, Ryan.Wanner@microchip.com
Subject: Re: [PATCH net-next v4 03/13] dt-bindings: net: cdns,macb: replace
 cdns,refclk-ext with cdns,refclk-source
Message-ID: <177447518882.6335.6622280371140449690.robh@kernel.org>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
 <20260318-mobilize-rule-d4a704468218@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-mobilize-rule-d4a704468218@spud>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sifive.com,kernel.org,vger.kernel.org,raspberrypi.com,gmail.com,google.com,microchip.com,redhat.com,eecs.berkeley.edu,dabbelt.com,davemloft.net,tuxon.dev,lists.infradead.org,bootlin.com,ghiti.fr,amd.com,linux.dev,lunn.ch];
	TAGGED_FROM(0.00)[bounces-271752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B8A32CA4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 18 Mar 2026 16:37:34 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Ryan added cdns,refclk-ext with the intent of decoupling the source of
> the reference clock on sama7g5 (and related platforms) from the
> compatible. Unfortunately, the default for sama7g5-emac is an external
> reference clock, so this property had no effect there, so that
> compatibility with older devicetrees is preserved.
> Replace cdns,refclk-ext with one that supports both default states and
> therefore is usable for sama7g5-emac.
> 
> For now, limit it to only the platforms that have USRIO controlled
> reference clock selection, but this could be generalised in the future.
> 
> The existing property only works on devices that are compatible with
> sama7g5-gem, so mark it deprecated, and limit its use to that specific
> scenario.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/net/cdns,macb.yaml    | 56 ++++++++++++++++++-
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


