Return-Path: <netdev+bounces-266896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HBSIe00smkuJgAAu9opvQ
	(envelope-from <netdev+bounces-266896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:37:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1726CD65
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2091A300BEB8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF250383C78;
	Thu, 12 Mar 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGbGB67m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027232B98A;
	Thu, 12 Mar 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773286630; cv=none; b=QQMgDThQd2TTGFyWnUqQTwh4IBjs6mwXYVRQ22bd39v7lAbGjWTfFJ0cNKnLw27EgpXa06v9IlS/LRBJ1hFptrhcPsMXpnpNVlMUASRW6aOJ7/d5cJSBf+II0OqmpzxwU/gk3hbM/Hgx1XZzSB4/RuQmfl0nFrW58VFFiuiwPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773286630; c=relaxed/simple;
	bh=sJfbpv0cFhrG9HZt+fsACC7pn1MLtg8z11mYBSar9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co4lNEZnsbX9s+aLYlrRtq3XKJ47y720/b9NqzLHgLM/dIlTW54cENqQawEspay6WMLbCkeMuaqNMFChRqP8T3nCyspu3q6MOXNluIkacOlTKn0bo1nDl7x/4x6s3cRMp6mE+6ZdrQb7spqq5E/rrExoQGnhPLmrEXjXvoHK+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGbGB67m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1EEC4CEF7;
	Thu, 12 Mar 2026 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773286630;
	bh=sJfbpv0cFhrG9HZt+fsACC7pn1MLtg8z11mYBSar9xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGbGB67mDMMpmHF3SDOFpmf4xmV/KbBqkj15/sPwkFU6+Y6Wto1mBwMUZfmyotisi
	 /Dt5PDTFZaWT5uY7EZ1/64o4LRAfDhmtyahZ+opdXN3Ys+g/X6vYnUP2Jn6LhKPPqv
	 XtssRw1xT31UjSTPLJF5L1Hl3h0Uud/SYmeNGiusUNtgquVoVaGq2K5Nhn90yHtuaI
	 84lC+XW1hSNT4lBa8e3r5Vm+GMT+Rh8m3IRItGYnl/QA/nthOaRTAzpMWpqZErd4P6
	 zEAS/1wYIxtS5puOktW6fz6FzOtOoJSp9ttNjmCCbru8Lx2Dp+c0Rp6RMuVmgczAF9
	 odhbJxVnfPxKA==
Date: Wed, 11 Mar 2026 20:37:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Cc: jan.petrous@oss.nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chester Lin
 <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, Ghennadi
 Procopciuc <ghennadi.procopciuc@oss.nxp.com>, NXP S32 Linux Team
 <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
 boon.khai.ng@altera.com
Subject: Re: [PATCH v8 1/5] net: stmmac: Use helper macro for loop over
 queue-based arrays
Message-ID: <20260311203707.1d5ba94c@kernel.org>
In-Reply-To: <20260309-dwmac_multi_irq-v8-1-f0cc5bc811a7@oss.nxp.com>
References: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
	<20260309-dwmac_multi_irq-v8-1-f0cc5bc811a7@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,suse.com,nxp.com,kernel.org,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,armlinux.org.uk,altera.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,jan.petrous.oss.nxp.com,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BD1726CD65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 18:55:20 +0100 Jan Petrous via B4 Relay wrote:
> The stmmac driver contains similar pattern for processing queue-based
> arrays, ie. interrupt lines, etc. Factor out the for loop and provide
> a macro STMMAC_FOREACH_MTL_QUEUE(var, limit).

This is macro is neither shorter nor more readable.
I really don't see any benefit here..
-- 
pw-bot: cr

