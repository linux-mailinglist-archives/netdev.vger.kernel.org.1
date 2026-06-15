Return-Path: <netdev+bounces-299390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fS0rFS3VL2rTHgUAu9opvQ
	(envelope-from <netdev+bounces-299390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:34:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1496855F3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fkt6tDlH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299390-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299390-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C86E301AF57
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4A2D7DE7;
	Mon, 15 Jun 2026 10:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D619A2A3;
	Mon, 15 Jun 2026 10:34:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519657; cv=none; b=j7S/cYLXG3OraxPXUD6XBTSo9VaHM5km52CMdf8m4lXoGWt6Qz3XYDz3RuTBLNOf5+tTdPGQXzMq9Pe7aGy2uB4hDCGjSp30xiuIHdpyA/uNP507uXVlcuC7Mh0pB4idDm+pvmVD6cT5fLsvI2RZjL0FNEn4WUTPYSwOZubW9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519657; c=relaxed/simple;
	bh=89apKyoVyx0NU3Q5QdL0cWDoy6xVDB2ZD2br42avnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjh6JNJWbT0cSojylOx977iFxVi8V+FO6wPcuZ5HMV0ECJRgGaJ7mKBOmOKqtzX2mY3b+ea6Vkr/9syHR4P/0/GWran8VyO+adjX1cwG8ioF4PIcj9iO3EaTMpfuFQz4GR1WaN+YMlayJQZMv/wFvwLbYX07X+0EhcvfhKj7WBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkt6tDlH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E11F000E9;
	Mon, 15 Jun 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781519656;
	bh=Yq8kBNPmxB2ckY04TeWOViDae28qQtfQoD0vJLW20hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fkt6tDlH+w/N+P4fpIgDcfDg9soPXLOeY6i+dbDff/a/8jd6bT86JVIRvtfQaq2tN
	 d7P82EF5JiVClS0K6GeSUxEGGTxSoO6j0TUktovHCdH03D0H9RxOJxH5TEle02Ho+O
	 nhIBX5Z+QBs0GH1XoFBovFhN+sXw9oqxkxFvld6qcKvZsl4Tc9waTT+35rZNZpIQ1S
	 LmxwnqecSysi7o5oFxS0hUqgLa7sFhrMBnVsc+KetRv50409sZ5ISGV9Ea7ia0QTUj
	 9Hoo/wDBrenEcjkMdyLyQgfsutonXLbHjw8l6jDyoVVFnzDtsp6BN9MlId/snVNTgx
	 yIxmVOUCFH0lQ==
Date: Mon, 15 Jun 2026 11:34:11 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: jelonek.jonas@gmail.com, kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, bjorn@mork.no
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: add Realtek/Broadcom PSE
 MCU driver
Message-ID: <20260615103411.GF712698@horms.kernel.org>
References: <20260612132944.460646-3-jelonek.jonas@gmail.com>
 <20260615090733.739423-2-horms@kernel.org>
 <ai_ITHd_xxt7an4q@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_ITHd_xxt7an4q@pengutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299390-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:jelonek.jonas@gmail.com,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,mork.no];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D1496855F3

On Mon, Jun 15, 2026 at 11:39:24AM +0200, Oleksij Rempel wrote:
> Hi Jonas,
> 
> On Mon, Jun 15, 2026 at 10:07:33AM +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> 
> It probably sounds scary, but sashiko finds not all issues in one time.
> Bigger patches and more different included frameworks - increase findings
> probability a lot. With other words, it may more rounds than expected.

FWIIW, that matches my observations too.

...

