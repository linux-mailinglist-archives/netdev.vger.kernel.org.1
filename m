Return-Path: <netdev+bounces-301173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmm6M8tqOWonsQcAu9opvQ
	(envelope-from <netdev+bounces-301173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA746B15C9
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:03:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YSNUZ7pu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301173-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8FAF300380A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1633DEE9;
	Mon, 22 Jun 2026 17:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0323FBA7;
	Mon, 22 Jun 2026 17:03:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147782; cv=none; b=U6mPSYY/NNMboT0tXH2YItVB85rVB0j95Z0rJNwZ/w6j0Yuhh+B4w+yIf7e4hA+hnhqrkkvRGuSZQxBWd7BroHVkYVBRC+9Z4J7L2NHj9kqkpddmuxj5gGvpRHSPkGszMksozxWo94plGW0FXODXYkS8oHJUQ19Bdnv4iUS1FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147782; c=relaxed/simple;
	bh=PNAwaPyfeFAN5jmhjq3UqEWbMj4RHXJpvd/22xLK0lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne162BH1J6sWI24lZlevR4dCUR9T6aP8POUfSAqYOEFLmw5m+dQ1ha31TjvoACm/+x6bDQ1/p0uPR3h2rHvR72Ocjx9jelZpELrvAomR6Vm1+XDDpD2VO/rSDmgOSwio7+n/W3iBHNCnb9Tm7pkYUFZWSslTy+G9IUyP9P9oE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSNUZ7pu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA81F000E9;
	Mon, 22 Jun 2026 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147781;
	bh=hSLwvCEZqAbWTIqOAv5AWwP83yp2ofxs8EnL3FIWSVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YSNUZ7pu3LHk1J14Czs7mheXNU5Lsl4I1XFOgeRGW5vp3H3u7kxs3Z41GJTbOIcGk
	 PDG5UQlemj5IKy4tzgioxB9i8P+H+9roFC7r++Shmpw7S5YRfEOsSvjoaKr5KBXgTi
	 9lxFnTXls1s/yPUQ2Few17QPkLjCwYVGn3C/ZySYWkegaT60MJ0A9jbzI/wJrs0W2H
	 abT6lkbDfqxV840k2e8WaKbrmKTKLbdUCbNOUYYVW1A2zkR7qefNLQ7j/sT0br3Dw/
	 dJKEG8wWPRAvKz2tVrltqejDM0L5681tRYnyti9yWomjKWvtdfz1+gtSoxfx/uFMmM
	 vwhwsNC9idIWA==
Date: Mon, 22 Jun 2026 18:02:55 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sungem: fix probe error cleanup
Message-ID: <20260622170255.GJ827683@horms.kernel.org>
References: <20260620155326.80582-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620155326.80582-1-ruoyuw560@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AA746B15C9

On Sat, Jun 20, 2026 at 11:53:26PM +0800, Ruoyu Wang wrote:
> gem_init_one() calls gem_remove_one() when register_netdev() fails.
> That path unregisters and frees resources owned by the net_device,
> then probe continues into its own cleanup labels and touches the same
> state again.
> 
> Clear the driver data and remove the NAPI instance on this error path,
> then let the existing probe cleanup labels release the resources once.

Hi Ruoyu,

I think it would be useful to explain how this problem was found,
naming any publicly available tools that were used.

And to explain what testing has occurred.

> 

A fixes tag should go here (no blank line between it and your
Signed-off-by line).
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

...

-- 
pw-bot: changes-requested

