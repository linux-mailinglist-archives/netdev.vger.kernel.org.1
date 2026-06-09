Return-Path: <netdev+bounces-296865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sq2DOWJ6J2ogyAIAu9opvQ
	(envelope-from <netdev+bounces-296865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870A65BDA5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:28:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ox0dD+An;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296865-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313773019514
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC13469E0;
	Tue,  9 Jun 2026 02:28:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4113DDAA;
	Tue,  9 Jun 2026 02:28:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972117; cv=none; b=LnGH/8vtdrf9KaVwRos4a5E5pU0jIMRyrhvhGCw9TnRa9xEv/ZgHEn2ltHTqpNlmOsRLR9V9cBptmpQzeThs6rqGoUflwXOeVxj/xqA2jgC6291kMYIwtzglrlI715vqWbflE7AByfy04QmfVcGqVpgXdfqAjwssMhlPWkgdx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972117; c=relaxed/simple;
	bh=veZp40KEl5yIqswYoBozJPKjad6uq+68JnfqHDCxcQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJG6DBDApg277xLeaGkXaMUjcwHPs269fY7FYvELwzY+QzyMqKKKBDU2gCGWOef3LSQTzlMt4dUom9LKcSWwsf9JVQKinZJ3BJ9viNzNtyF/BKb1++CcW92aYH6/94/FWP7nxt4Vey1/3ddd3S0y18d3vLG14G6SuX/PF8yIkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox0dD+An; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9DF1F00893;
	Tue,  9 Jun 2026 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780972115;
	bh=cwxpf8kSX8737xmFn9bWE+GiAzV9m+yFDvV80gYy6eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ox0dD+AnTk5/0KPqZP+MqAYw17kd6W1fdHSxOUNBd2pti7O4xlqZ5msjw8IdBfENt
	 6UMAmONixeWmg1PuJ/fGK86QERQvNU9Mb5B8I2HfepcuFvmSnTVNVpKWvB2Z5SiKeq
	 ZMMSUBCIOzbntzm3Vfpw/z3cVnD3MTJCwzx83K/mf03Gg+mvsnaG/7OOSijE3iKBZL
	 6Nt+LoTO3UnqCw5PIb6xL6KnL5fBgJhnSSk0m/Z05FZVCApCSrU4CDdiNspN024adn
	 6kntGrv3s/O0dueDDqHdsb010sVlcct73DSZtvaCLoJ0qmgnxk29wfsNr+rEdBggYB
	 n7gh0yyIEhttQ==
Date: Mon, 8 Jun 2026 19:28:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, bjorn@mork.no,
 olek2@wp.pl
Subject: Re: [PATCH v2 net-next] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
Message-ID: <20260608192834.4244bcc9@kernel.org>
In-Reply-To: <20260605053056.1977-1-petr.wozniak@gmail.com>
References: <20260604181207.17468-1-petr.wozniak@gmail.com>
	<20260605053056.1977-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,lists.infradead.org,bootlin.com,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4870A65BDA5

On Fri,  5 Jun 2026 07:30:56 +0200 Petr Wozniak wrote:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
> bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
> sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
> i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
> sets mdio_protocol =3D MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
> runs (up to ~17 s later on affected hardware), the bridge is fully
> initialized =E2=80=94 but PHY probing is skipped because the protocol has
> already been changed to NONE.
>=20
> This affects both modules inserted before boot and hotplugged modules on
> hardware where bridge initialization exceeds the 200 ms probe window
> (confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).
>=20
> Move the probe from i2c_mii_init_rollball() =E2=80=94 called at bus-creat=
ion
> time =E2=80=94 to sfp_sm_probe_for_phy() in sfp.c, where it runs after th=
e SFP
> state machine's module initialization delays.  Export the probe function
> as mdio_i2c_probe_rollball() so sfp.c can call it.
>=20
> For RTL8261BE-based modules: the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE =E2=80=94 eliminating the 5+ minute PHY probe retry=
 loop.
>=20
> For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> AQR113C): the probe now runs after initialization is complete and
> correctly returns 0 =E2=80=94 PHY detection proceeds normally.

$ git pw series apply 1106341
Failed to apply patch:
Applying: net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
error: corrupt patch at .git/rebase-apply/patch:44
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: phy: mdio-i2c: defer RollBall bridge probe to PHY=
 discovery
--=20
pw-bot: cr


