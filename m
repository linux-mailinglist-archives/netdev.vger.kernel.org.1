Return-Path: <netdev+bounces-302164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NLUIDtB3PmqaGgkAu9opvQ
	(envelope-from <netdev+bounces-302164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76F6CD3E9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 14:59:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JYBEok7e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302164-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA9F301CFD5
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E003EBF01;
	Fri, 26 Jun 2026 12:57:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFA253958;
	Fri, 26 Jun 2026 12:57:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478663; cv=none; b=IyT1wATI7Vdo+cNRqYU4ztL4/cVFf9AQurlWjxS0O5RKwH0F7NSeSeYEXHlilCdvbnUoHshrJWNjtasVyXC8POH2IwdqbCKWt86adeoH2zJnx4GtSjzRsTx5RC9wOP5EgXQOG37uhfaxToSZp9QhpLXFk6wz5d3Rm6wvuHDsT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478663; c=relaxed/simple;
	bh=d4QJEuNiVaTqLR42uDIxg0/aSDX3ISUzOxLI+ex8Xvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7K5zl9av++WbukVIQiZQzYjdlpjDNT8nSDix6D2CPwPEZDf8uFINf4BZTkiAlyw5XHHfVU0vuu5A0uKLJtjzhlLyTYZCoF6vZaTB64n9Pb/um4XxIddwpiiJzGpBvN6mTqVq97zphX5MkvMEbzxSPGc0d4D2Fq3V3waXh3qOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYBEok7e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FC41F000E9;
	Fri, 26 Jun 2026 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782478661;
	bh=HkeL5ZEgSnnfcgqLGPg8pzG1Em1yMjrCzGjXLmFgA6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JYBEok7ef34aLsRhOaXtmjwYifV2O6L4BxBtuUmJVMStaMRHPHHELUhFiTGZzjOgT
	 FRUjKli7Th9lB7DdlEvjp+QtGBDzJp0mDPBYJG1BeruHwqkpxh/2SeNgoHa9nZUXx1
	 RVPBcQRU8dnCYU7N2TvevP9H9jVyUAYCaY+2vtciNHETUuqRxeX81WacrJOsyprvTl
	 +J4ZH2XkmLfQC8Ihjajykh0xVdCerGAPXcQA6bWYCvkONmCAR9DMy4CoN0X3roEO1H
	 Vav+lVMCs+CGd7pqJ82DOyrYZy6OI1916YuFEZGcHSZUPOdvkUQcIAsCSO553XKCUn
	 ZJaqVbbwQi+kg==
Date: Fri, 26 Jun 2026 13:57:36 +0100
From: Simon Horman <horms@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Corey Leavitt <corey@leavitt.info>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pse-pd: scope pse_control regulator handle
 to kref lifetime
Message-ID: <20260626125736.GC1286967@horms.kernel.org>
References: <20260624204017.2752934-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624204017.2752934-1-github@szelinsky.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302164-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,leavitt.info,gmail.com,armlinux.org.uk,vger.kernel.org];
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
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email,szelinsky.de:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C76F6CD3E9

On Wed, Jun 24, 2026 at 10:40:16PM +0200, Carlo Szelinsky wrote:
> From: Corey Leavitt <corey@leavitt.info>
> 
> __pse_control_release() drops psec->ps via devm_regulator_put(), which
> only succeeds if the devres entry added by the matching
> devm_regulator_get_exclusive() is still present on pcdev->dev at the
> time the pse_control's kref hits zero.
> 
> That assumption does not hold when the controller is unbound while a
> pse_control still has consumers: pcdev->dev's devres list is released
> LIFO, so every per-attach regulator-GET devres runs (and
> regulator_put()s the underlying regulator) before
> pse_controller_unregister() itself is invoked. Any later
> pse_control_put() from that unbind path then reads psec->ps as a
> dangling pointer inside devm_regulator_put() and WARNs at
> drivers/regulator/devres.c:232 (devres_release() fails to find the
> already-released match).
> 
> The pse_control's consumer handle is logically scoped to the
> pse_control's refcount, not to pcdev->dev's devres lifetime. Switch to
> the plain regulator_get_exclusive() / regulator_put() pair so the
> regulator put in __pse_control_release() no longer depends on the
> controller's devres still being present. No change to the
> regulator-framework-visible refcount or lifetime of the underlying
> regulator: a single get paired with a single put. The existing
> devm_regulator_register() for the per-PI rails is unchanged (those ARE
> correctly scoped to the controller's lifetime).
> 
> This addresses only the regulator handle. The same unbind-while-held
> scenario also leaves __pse_control_release() reading psec->pcdev->pi[]
> and psec->pcdev->owner after pse_controller_unregister() has freed
> pcdev->pi, because the controller does not drain its outstanding
> pse_control references on unregister. That wider pse_control vs
> pcdev lifetime problem pre-dates this change and is addressed by the
> PSE controller notifier series, which drains phydev->psec on
> PSE_UNREGISTERED before pcdev->pi is freed.
> 
> Link: https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
> Signed-off-by: Corey Leavitt <corey@leavitt.info>
> Acked-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
> ---
> This is patch 1 of the "decouple controller lookup from MDIO probe"
> series, reposted on its own for net as Jakub suggested. The rest of the
> series targets net-next and is deferred until it reopens.
> 
> Changes in v2:
> - Reword the commit message to scope the fix to the regulator handle.
>   As Simon's review pointed out, the same unbind-while-held path also
>   reads pcdev->pi[] and pcdev->owner after pse_release_pis(); that wider
>   pse_control vs pcdev lifetime issue is fixed by the notifier series,
>   not here. No code change.
>   Link: https://lore.kernel.org/netdev/20260624151251.1137250-1-horms@kernel.org/
> v1: https://lore.kernel.org/netdev/20260622192839.2508733-1-github@szelinsky.de/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


