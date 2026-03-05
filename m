Return-Path: <netdev+bounces-264587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHxIGsoVqmnFKgEAu9opvQ
	(envelope-from <netdev+bounces-264587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:46:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3E21977B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DFC3066BCA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEE368284;
	Thu,  5 Mar 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUosBPS+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6A34D4D6;
	Thu,  5 Mar 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754124; cv=none; b=OwULX0v50aNSW2pejTGgDyHrz6lplNQjoixdWVwlgEKi3txK2/xk0NkL0qAF1YwrtSQ3NZT4Yrl8Yji9yepOm4ueSCvRdy8ssUo05p1ciVKCtajPRhfRA0p5AH5lYHhP5hboJaFPiKjQ5xYVlKGaucuZtzQugQv1P2oEunfukd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754124; c=relaxed/simple;
	bh=ylk/u69oIA4HjLPyU2UuATCgoA7N9ABraCIFHL30FbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk9cHFgT2TgMp36xhTeErxslsawG7pZgfduJcKG9P3++wrBpYPiRceWdEAXdlVK9JrmaoLPC8SNbwbhsD/pnAymx0aNojInfykxxR87rBEWJCGHY3yvt3vI7JeDvC5901qRJMitzVbJKRHc8mkL+R35lduXIY2Nv9JBrH/Dzwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUosBPS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E39C116C6;
	Thu,  5 Mar 2026 23:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754124;
	bh=ylk/u69oIA4HjLPyU2UuATCgoA7N9ABraCIFHL30FbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUosBPS+cW3plRB//egcYoKUgOGLpzTT/QraxebJuAqMmL5oL9WNS+zab1Mvjpw1x
	 MOoH0+5zpJUdcThPW9SyCrpO/6oRl7KUzKo3TAw5e6LRBEXtEagrC1ST+m9jp+EWnG
	 KghpA/iodoV4cboihmSb9FeRUH2kvtdWUohFg2mkUxYiGXiRdy/F9+zWrP3RLox+/H
	 4ZdMwrvSWHiP3e62R7/ukHcGtUTTsxRRZUWS/HpF3okUAmC66pHXGR8F27/clTAzD8
	 lWrNIiqrvweG7YY9HKLwpVpp6hHWfDUN4pkEqybtwM9HBjmLSIsKJsAasxr0MiGQ3L
	 eXND455nIUVAQ==
Date: Thu, 5 Mar 2026 17:42:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: pabeni@redhat.com, maxime.chevallier@bootlin.com, hkallweit1@gmail.com,
	andrew@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: net: ethernet-phy: add property
 enet-phy-pair-polarity
Message-ID: <177275412245.793285.15497822015744786237.robh@kernel.org>
References: <20260207092539.647768-1-dam.dejean@gmail.com>
 <20260207092539.647768-3-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207092539.647768-3-dam.dejean@gmail.com>
X-Rspamd-Queue-Id: C3D3E21977B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,bootlin.com,gmail.com,lunn.ch,google.com,vger.kernel.org,kernel.org,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sat, 07 Feb 2026 10:25:38 +0100, Damien Dejean wrote:
> Add the property enet-phy-pair-polarity to describe the polarity of the
> PHY pairs. To ease PCB designs some manufacturers allow to wire the
> pairs with a reverse polarity and provide a way to configure it.
> 
> The property 'enet-phy-pair-polarity' sets the polarity of each pair.
> Bit 0 to 3 configure the polarity or pairs A to D, if set to 1 the
> polarity is reversed for this pair.
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


