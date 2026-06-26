Return-Path: <netdev+bounces-302163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 60fBHyp3PmpJGgkAu9opvQ
	(envelope-from <netdev+bounces-302163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:57:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681E6CD38F
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OSzHaDCv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302163-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302163-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DA43032F7C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B93EFFB4;
	Fri, 26 Jun 2026 12:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA473F4DC3;
	Fri, 26 Jun 2026 12:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478631; cv=none; b=I3GTxoB5fXkQSTMUnLX/73gPHuwVToIdzrUGr1Px1as2cqITtHxbocO4JhlOSZscz/N67ttGqnHsz0gMBOLcyc+ddVXoWUaEQRp4wxP5CRfShtX1t3/teE9GfPmcrFz0DowZZXfUPBlCx2HgDcBWd02qJiHXtTbLjmt6xy71r2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478631; c=relaxed/simple;
	bh=JKkIQ2xtaWpdcdL5oNWIYG2ZruReetAGYT/TabZTvJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugL8yP3KT2As5GBR4nskhNFxxqCShaUnpzuxMZvNqT3oiuBjDT1rvB+n+NSxM6Cb/iGTZNblNcAHNilap65x6vSwTOMRvX/uDnGr4cWihW+MzEWpgzYx+hf2tHu0Sax3s9A+SjSLHakCxpYC6+0WZk7P+StDXPLNy0wHmRnmQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSzHaDCv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076CC1F000E9;
	Fri, 26 Jun 2026 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478629;
	bh=DTiO5SmGaNqn/JfhF5aNozR6oqtKfzT51CnTd6I+BIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OSzHaDCvOWkLxy3KL2rN7a0YJ557rlhZuv19gn1Nwjj4P3tHx+7dufQ5Ouu1R5CWH
	 IcivpfuGVo3rl6cyoJX5rd9u2QMNK7Z69hHqzjE1IGrcr0tXJBnluHuk/epZeF0mkH
	 LjG20JEzNqkX3Rb0woYP+6LtuLtVDMDkMvuojg9JS/x6Nsj3XaByEPEfXeLgUEd60i
	 TIo09YpLYLl6NlTOEnfZS3CLmGvTO52jTOLuHPDAcw8ZkFW4AfRzGl1SS1mezmUg2g
	 8/TTcBFfTSR3sat+VooSBy6h9bmJKl1iKZHvQFFgs3KyEGzmnvhqqVlSYx9AiQDxSQ
	 mRtT8cg2UYuGA==
Date: Fri, 26 Jun 2026 13:57:04 +0100
From: Simon Horman <horms@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Corey Leavitt <corey@leavitt.info>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pse-pd: scope pse_control regulator handle to
 kref lifetime
Message-ID: <20260626125704.GB1286967@horms.kernel.org>
References: <20260624151251.1137250-1-horms@kernel.org>
 <20260624203838.2752376-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624203838.2752376-1-github@szelinsky.de>
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
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[horms.kernel.org:server fail,sea.lore.kernel.org:server fail,vger.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-302163-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9681E6CD38F

On Wed, Jun 24, 2026 at 10:38:38PM +0200, Carlo Szelinsky wrote:
> On Wed, 24 Jun 2026 16:12:51 +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> [...]
> > [High]
> > Does this fix the use-after-free completely, or only the regulator-put
> > part of it?
> [...]
> > Would a more complete fix also need pse_controller_unregister() to
> > drain outstanding pse_control references, or have pse_control hold a
> > refcount on pcdev, so that psec cannot outlive pcdev->pi and pcdev?
> 
> Thanks, the review is correct. This patch only fixes the regulator
> handle. In the same unbind-while-held case __pse_control_release()
> also reads psec->pcdev->pi[] and psec->pcdev->owner after
> pse_controller_unregister() has freed pcdev->pi, so those are still
> use-after-free reads on their own.
> 
> That wider problem is exactly what you describe: the controller does
> not drain its outstanding pse_control references on unregister. It is
> fixed by draining them, which is what the PSE notifier series does --
> PSE_UNREGISTERED drops every phydev->psec before pse_release_pis()
> frees pcdev->pi. This patch is patch 1 of that series (by Corey
> Leavitt); the rest targets net-next and is deferred until it reopens:
> 
>   https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
> 
> Jakub suggested sending this one to net on its own since it is a fix,
> so it is here without the notifier patches. My v1 commit message
> overclaimed by saying it makes __pse_control_release() correct
> regardless of the controller's devres state, which is only true for
> the regulator handle. I have reworded it in v2 to scope it to the
> regulator put and to point at the series for the wider lifetime fix.
> 
> Does you agree? Another option would be to wait for the entire series.

Thanks for the clarification.
Yes, I agree this is a good approach.

