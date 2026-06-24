Return-Path: <netdev+bounces-301691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1q4BKCn3O2ocgwgAu9opvQ
	(envelope-from <netdev+bounces-301691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:26:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03DA6BFA11
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:26:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=acZWOAfe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301691-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301691-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC37C3183C81
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242B3DA7E3;
	Wed, 24 Jun 2026 15:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBB3CC7D3;
	Wed, 24 Jun 2026 15:13:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314007; cv=none; b=qAeZ5Iy2q/5mtz444rNs1Yde4qUFBSR7u7/zxLgzKKVhwvLpaCvSNaxlZb9YpvxB62CjgEoG6xxBFXYclxgllG/z+RwVBPxkUlCuSmDfJXYS6EnCKsMBgCZFQ65HuotD3G/hSukCbghxYyj0fsdB6BAQu/67SQ+Sxmdug4qv1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314007; c=relaxed/simple;
	bh=BBgm4KsunVTzGUFon7JwqfYL59f6oGPb8Jaj6iIoKWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIms22Mx2xDjf7LwGOTgT1SGOnFbNOkiJLsG1LEGBGdMHRA1Gix7rSLAKWi/LfySKAhGyU8P6QttVqhPRSFhwcUiwBWkHxB32pnSOlPAPBA+GIvczL/4N4+i5T6977jVxMydWgsH2+OVuTGy1fUQeaZuGyivNX6YscDMwKQkrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acZWOAfe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8E11F000E9;
	Wed, 24 Jun 2026 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782314006;
	bh=yAEkEfkFb1rXfvioJSw2SFWRO5YtcpI8u4D3Wdiz19k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acZWOAfesJMYLaNhI3/19Lz/GBOrFpuz2cdZUCxVkVbcFPEo42CHo5Ld/pI2Q3o+v
	 7D6xTek3cUIGjVNK5tyxfB9mut+ggJX7GmfOnnhIQ3vX00siS/2TUoR5TjVJLdEH5b
	 fcF7MlkzHfz1BqMVaoeFBrWQ60S8tu6dN6MapIFwVg/xtJfcx/r0utcqkpJ9/CvOAe
	 w0OroGJG9qgbfnhFizc2Ya+dg27kXDodxHlxuqA1xco1lofeT121PVnyw/heNjsuot
	 Ej6GMhZYzMLtfJm7QUDxEOGntPxgst0VFB9nFz2S9CoX0K2+sU9yOZ/YUThj0aw6Ar
	 Qy1emEdq4K07w==
From: Simon Horman <horms@kernel.org>
To: github@szelinsky.de
Cc: Simon Horman <horms@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corey@leavitt.info,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pse-pd: scope pse_control regulator handle to kref lifetime
Date: Wed, 24 Jun 2026 16:12:51 +0100
Message-ID: <20260624151251.1137250-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622192839.2508733-1-github@szelinsky.de>
References: <20260622192839.2508733-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:horms@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,redhat.com,leavitt.info,gmail.com,armlinux.org.uk,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F03DA6BFA11

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: pse-pd: scope pse_control regulator handle to kref lifetime

This patch switches the pse_control consumer regulator handle from
devm_regulator_get_exclusive() / devm_regulator_put() to the plain
regulator_get_exclusive() / regulator_put() pair, so the put in
__pse_control_release() works regardless of whether the controller's
devres has already been unwound.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 69dbdbde9d71..a5e6d7b26b9f 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1367,7 +1367,7 @@ static void __pse_control_release(struct kref *kref)
>  
>  	if (psec->pcdev->pi[psec->id].admin_state_enabled)
>  		regulator_disable(psec->ps);
> -	devm_regulator_put(psec->ps);
> +	regulator_put(psec->ps);
>  
>  	module_put(psec->pcdev->owner);

[High]
Does this fix the use-after-free completely, or only the regulator-put
part of it?

The commit message describes the scenario where the controller is
unbound while a pse_control still has consumers, and explains that
pcdev->dev's devres is released LIFO before pse_controller_unregister()
runs.

In that same scenario, __pse_control_release() still reads
psec->pcdev->pi[psec->id].admin_state_enabled and psec->pcdev->owner
just before the regulator_put():

	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);
	regulator_put(psec->ps);

	module_put(psec->pcdev->owner);

pse_controller_unregister() calls pse_release_pis() which does
kfree(pcdev->pi), and pcdev->pi is plain kzalloc memory rather than
devres-managed. pcdev itself is typically a driver-owned allocation
tied to pcdev->dev's lifetime.

If a later pse_control_put() runs from the unbind path after
pse_controller_unregister() has freed pcdev->pi (and pcdev), would
these pcdev->pi[...] and pcdev->owner reads operate on already-freed
memory?

Similarly, would the regulator_put() then be called against an rdev
that has already been torn down through the controller's devres?

This pre-dates this patch, so it is not a regression introduced here,
but the commit message frames the change as making
__pse_control_release() correct "regardless of whether the
controller's devres has already been unwound", which seems to only
cover the regulator handle and not the pcdev->pi / pcdev->owner reads
on the same code path.

Would a more complete fix also need pse_controller_unregister() to
drain outstanding pse_control references, or have pse_control hold a
refcount on pcdev, so that psec cannot outlive pcdev->pi and pcdev?

