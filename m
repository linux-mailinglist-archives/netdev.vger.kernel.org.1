Return-Path: <netdev+bounces-280688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLLzIUzt6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:58:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE410450205
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA3C3051162
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D233E6DFB;
	Thu, 23 Apr 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="xPr3VPJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A273E5EEF
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937751; cv=none; b=j/Qj7/eZZ1KAGyHnW+1KzgPl3uD7BMpO5uBOYfDPRlGfEvuthk/8M2sExSkRGUz7nwwOMSn/sOQe0lPd5c+HRkLKJRmafQxGKatnfwUxyKIu+lhTvoVHcXyTjGKs4GIcHNC/ZtW4uhHUYV2HEiwUskgLVqLlDP/HIQE3TKevOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937751; c=relaxed/simple;
	bh=AuJP2O6s6sjf22qhVkoBhi80p54Kz3idPppPg0Vnsio=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liWPOsa/37CCAITp5j+YBWLAL7NFRbgUTgYqaN/z/cIY4cSkE2fOA2coMFJNU53Si7rRRSA+yyQsls0FUVoKvQg9+H6ayJoDCE3RxCshMK8jzxaV6t8RzTTePMVAa2wYUMrVK67XSvf21AkzzJyxIv/av2Z06M40xT8YP5Xw3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=xPr3VPJI; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776937737; x=1777196937;
	bh=nYdzQzBkBvA+hLgpIa8MLVdS03AP7ZSnn49gBuNRwtM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xPr3VPJI2KWS1HLk1xQ3fsldTIrcpYvcgegipJJ9DDp90ejd8TfK54uWFif/ihmH4
	 IUMMweqBaZ1WW05t2A9LiZC5jQXvY4WANGMHvxFk8ZXZ90hGGUmJ5zRJTDJ4L9svvV
	 sFYk3HxWT25w5v60bnsCIx9k0fIc8Kxncc1KV6q6nG/KEYaY1NhroK2Wx15DWlsGF/
	 gQu1QsB5JWP2MRANHU8VcyU4t9mBER49pvBMawqsVc9x30oU+uIYwE651vF2Yw2VN9
	 E6KosUwT8FM5oMkRLDd839WByxk4ksTVSdnFWesgr/rKhUdRdYn9rAC6LmRaZnRRLT
	 X0i2eMvafQveQ==
Date: Thu, 23 Apr 2026 09:48:53 +0000
To: Kory Maincent <kory.maincent@bootlin.com>, Carlo Szelinsky <github@szelinsky.de>
From: Corey Leavitt <corey@leavitt.info>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <177693772506.254295.6378636892307427408@leavitt.info>
In-Reply-To: <20260423110544.052f631e@kmaincent-XPS-13-7390>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info> <20260423110544.052f631e@kmaincent-XPS-13-7390>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 3416088fe9b126c48c731d95ff173bfb021dc17b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280688-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leavitt.info:dkim,leavitt.info:mid]
X-Rspamd-Queue-Id: DE410450205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kory,

Thanks for the pointer -- I had not seen Carlo's thread; I should have
searched lore before sending and will do so before v2. Adding Carlo on
cc.

Having read it end-to-end, my read of the state as of 2026-04-13 was
that the conversation had narrowed to two open directions: propagate
EPROBE_DEFER further up into phylink/MAC probe (Andrew/Russell), or
resolve psec at PSE controller register time (your msg on 9 Apr,
"save the phandle ... then at PSE register time look for each PHY and
try to resolve every unresolved phandle"). Nothing concrete had been
posted for either.

This RFC implements the second direction. pse_core publishes a
BLOCKING_NOTIFIER chain with REGISTERED / UNREGISTERED events,
phy_device subscribes, and psec ownership moves from fwnode_mdio probe
into the notifier handler. Concretely with respect to points raised in
the earlier thread:

  - fwnode_mdio loses PSE awareness entirely, so the MDIO bus scan no
    longer sees -EPROBE_DEFER from PSE lookup. Consistent with
    Andrew's point that bus and device lifecycles are separate.

  - psec is acquired at PSE register time, before
    regulator_late_cleanup (30s) can run. Carlo's admin_state_synced
    guard (his patch 1) therefore isn't needed in this model. psec
    resolution happens eagerly on the REGISTERED event rather than
    lazily on first ethtool access, so his patch 2 is also not needed.
    And because fwnode_mdio no longer looks up PSE at all, the
    non-fatal EPROBE_DEFER handling there (patch 3) drops out. This
    series is a different architectural shape, not an increment on
    his v2.

  - Oleksij's concern about lazy resolution dropping UAPI
    notifications is addressed: the notifier fires at register time,
    so boot-time observer semantics are preserved.

  - One caveat I already owe a fix for in v2: the attach helper in
    phy_device currently treats every error from of_pse_control_get()
    as retry-on-notifier, including non-transient ones. Carlo's v2
    patch 3 was careful to differentiate -EPROBE_DEFER from bad-DT
    errors at the fwnode_mdio lookup site (which matches his msg 1
    concern about catching broken bindings at boot rather than
    silently later). I need to preserve that discrimination at the
    notifier-handler site -- phydev_warn() on anything other than
    -EPROBE_DEFER. Trivial, but worth flagging.

  - The DSA genphy force-bind sequence Carlo hit
    (phy_attach_direct -> device_bind_driver -> deferred retry
    skipped) does not apply, because psec attachment is not tied to
    phy_probe.

  - Patch 1 of this series scopes the regulator handle held by
    pse_control to its own kref lifetime, fixing a latent
    dangling-handle sequence that the notifier unregister path makes
    reachable. This is a separate regulator-lifetime bug from the one
    Carlo's patch 1 addresses.

Validated end-to-end on a Cudy C200P (MT7621 DSA + i2c IP804AR as
module), with lockdep active, across the i2c driver unbind/rebind
cycle that triggers UNREGISTERED -> REGISTERED on the live system.
The cover letter has the full evidence.

I would welcome your view on whether this is the shape you had in
mind on 9 Apr, or whether the MDI-based binding you raised with
Maxime is the better endpoint and we should be reshaping around that.
Happy to keep this RFC as the scaffolding either way.

Carlo -- your debugging work on the DSA phy_attach_direct interaction
is what made it clear this kind of approach was needed; thanks for
laying that groundwork. Would value your thoughts on the tradeoffs.

Best regards,
Corey


