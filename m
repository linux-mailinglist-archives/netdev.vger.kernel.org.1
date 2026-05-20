Return-Path: <netdev+bounces-289987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6vX1N+bYDWrE4AUAu9opvQ
	(envelope-from <netdev+bounces-289987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C559145E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A48A31B1392
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D662E62B7;
	Wed, 20 May 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NKYi+8O2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB02D94B5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290059; cv=none; b=LUpYo8HJF9SKYQjfOTVib11xIHo51CrhqOYeWy4n9NH/G7enihcjVR7o4yW27Os+9qa5yVRpUg//Vps5+GZL56aWAC0Z5jxRunYjLg1cYXVTwDhCjdx4kMVvx5uY8RdgxlG/VUaUdxt9jNE//WmtGIBikVld6EcO+qevbgP5Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290059; c=relaxed/simple;
	bh=tBU/y8NXwO+HznKDeUAhUrw6+S0levSMmkSBR0DWUOE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=U6q1QU5MSjM0ERuLIRVb8agyT12L/WfD5nfXrhn4eEAceD0X3MO64m7QQjUJtrDSzfn5dK+dNIttGvwEsmvHDx64z+Zm1dNGUmOLy862n3YmRUzCGBfNptwePFTUS8wJIv/u70OdSyrdgSeRBihwtrXOEkA9X6AZEzZ6ic1sW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NKYi+8O2; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779290045; x=1779549245;
	bh=tBU/y8NXwO+HznKDeUAhUrw6+S0levSMmkSBR0DWUOE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NKYi+8O2U969qbeyTqpQH7SPY0E8UJibtW3e2OvwqrErFtgRMCynvKNGt19miZg1g
	 e839TLKNeSRIJ3sYDHV0sbrKk8EzHh1QIDzjbBVWmF3qB5fo7jqVtMXpHpMcOv0LVg
	 UhCMRybtwMcJecBy68ssQ+Nw0myoe677aNQX5h/OtS1pW1L7vrjZh773Quw+e5Gt7Y
	 UmySrn1uMzfXOCv6vm1kSUOy123Up5vT+NvkR7FOyQjNJFjY/VYh6Lgjjf7sZQ++Ye
	 byfAizxlX0wMmO9J/NwVaV4pvqFhDqRL2B13USGfD15GhwUiC45bVd1NliMFnFZafM
	 HKjxTClv7ZY2A==
Date: Wed, 20 May 2026 15:13:59 +0000
To: netdev@vger.kernel.org
From: "leo.moerlein@proton.me" <leo.moerlein@proton.me>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?utf-8?Q?Leonardo_M=C3=B6rlein?= <leo.moerlein@proton.me>, Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on unregister
Message-ID: <20260520151355.1371163-1-leo.moerlein@proton.me>
Feedback-ID: 198615653:user:proton
X-Pm-Message-ID: ebeb80a96ffe5828a66b7942284ec46f3495edd3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289987-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.moerlein@proton.me,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 478C559145E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leonardo M=C3=B6rlein <leo.moerlein@proton.me>

Some PHY devices are discovered again after the MDIO bus is torn down and
reprobed, for example when a parent driver first returns -EPROBE_DEFER and
is probed again later.

This breaks boards where external PHYs have per-device reset lines
described through reset-gpios. mdiobus_register_device() acquires the
reset GPIO and asserts reset, mdio_probe() later deasserts it for the
active device, but mdiobus_unregister_device() used to release the GPIO
descriptor without first driving the line back to the inactive state.
If that descriptor was the last owner, then the PHY could remain held
in reset across the next bus registration and disappear from the reprobe
scan.

On a Lantiq GSWIP based FRITZ!Box 7360 v2 this left PHYs 0 and 1 missing
after a deferred reprobe, while PHYs without external reset lines were
still found. DSA then failed to attach those ports with -ENODEV.

Before releasing optional reset resources, deassert reset again for
PHY devices so the hardware stays discoverable across a later reprobe.

Link: https://github.com/openwrt/openwrt/issues/20629
Fixes: 8ea25274ebaf2 ("net: mdiobus: release reset_gpio in mdiobus_unregist=
er_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo M=C3=B6rlein <leo.moerlein@proton.me>
Assisted-by: GitHubCopilot:GPT-5.4
---
 drivers/net/phy/mdio_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 56080d3d2d25..9caeb9ea5248 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -215,6 +215,12 @@ int mdiobus_unregister_device(struct mdio_device *mdio=
dev)
 =09if (mdiodev->bus->mdio_map[mdiodev->addr] !=3D mdiodev)
 =09=09return -EINVAL;
=20
+=09/*
+=09 * Leave optional reset lines deasserted before releasing them so devic=
es
+=09 * remain discoverable across a later bus reprobe.
+=09 */
+=09mdio_device_reset(mdiodev, 0);
+
 =09mdio_device_unregister_reset(mdiodev);
=20
 =09mdiodev->bus->mdio_map[mdiodev->addr] =3D NULL;
--=20
2.51.2



