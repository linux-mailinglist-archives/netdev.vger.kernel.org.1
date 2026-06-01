Return-Path: <netdev+bounces-293569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ28ALgkHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF061A12A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE52300D32A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5833AD8B;
	Mon,  1 Jun 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YRsng8fA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBC27FB18
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294778; cv=none; b=l8+8aSmYXF6luaHnnP81NH3O05kJbldgyTo4P5VTCfGJjBOujoaSFYcnRN0pUAHqZXUQummQz8KRrjbfT5pVtB5WLA+UXe7WpN/YkQhXFti+0Rsq+ZeovFcaZWysV/L7K7sfLdJ1n9I49F50/jK8jaTFv5sHOZ8HmT5PjOx2kOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294778; c=relaxed/simple;
	bh=OJf6Jrho7l0BHrvLQhxK/07RMk9wGzkK/7GjX7mRplU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mW5JIEb63lNivHLv6qvMRtGqPUDpSQYnCqxb2OcnfUbocqE3qef4U0IOXzk8vQsL0j/ToAwwmHTQJ0/G5As//JnIQXoZZ9RRvXH1swNUHPNBIAU6JoM0YFRhMdvnSdV4sDwffFNmTPo5AY4m3bZu9Npqqc3zQ31u0bEWLzpmngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YRsng8fA; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1780294768; x=1780553968;
	bh=UGqugeIGGNHkt1QY9TpB8W4urY02c7aWKCiTn3mvj4w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=YRsng8fAe2LVbNICY1whBeKKsNR98Ml6KAuuOQkDcoBCT+8A0Cca+D8MgBnV5bbMX
	 BNwuPKhllL2zmfuyjhHFKcaEorT+jb0MW6LmM7o6zRztEzS6f7uNkTlY2BI9wTPKxb
	 gDPMhcouhnw2OaxAeOqBMjlWXTPDn8za/EQRJcs0brgAPZ1L2h9VJjJ8u+heB3BIqf
	 UuM19IFdBeKlTMGd/Mct+HcwTJA5Gt3TPK/rUt3onNXTMgVBMiYY7rObgz3jfJMdGk
	 wMLRZb21GJ0oNg86VYJqR+04rheLfGhwB5pppy7Y7sc5tOwLAcmY2Dld/NxEn/v8qH
	 RMj/KO8bmQn8g==
Date: Mon, 01 Jun 2026 06:19:22 +0000
To: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH v2] net: macb: check return value of clk_prepare_enable() in runtime resume
Message-ID: <20260601061906.127174-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: dad26ad65a0240fbed8162ade397c178e0e62905
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293569-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaneko.dev@pm.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[pm.me:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pm.me:email,pm.me:mid,pm.me:dkim]
X-Rspamd-Queue-Id: 4FFF061A12A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

macb_runtime_resume() calls clk_prepare_enable() five times but discards
the return value each time. clk_prepare_enable() is marked __must_check,
and if a clock fails to enable the driver would silently continue with
potentially unclocked hardware.

The symmetric disable path, macb_clks_disable(), already uses
clk_bulk_disable_unprepare(). Convert the enable path to the matching
clk_bulk_prepare_enable(), which enables the clocks as a group and, on
failure, unwinds the ones it already enabled before returning the error.

This was found by code review, not by an observed failure, and I do not
have macb hardware to test on; it is a robustness fix that propagates the
clk_prepare_enable() error instead of discarding it.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
v2:
 - Reword the commit message: drop the misleading "atomically" wording
   (there is no locking involved) and describe this as a robustness fix
   found by code review rather than a fix for an observed bug.
 - Cc the networking maintainers that were missing from v1.

 drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index a12aa21244e8..85bd4ff0e4e6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6185,16 +6185,19 @@ static int __maybe_unused macb_runtime_resume(struc=
t device *dev)
 {
 =09struct net_device *netdev =3D dev_get_drvdata(dev);
 =09struct macb *bp =3D netdev_priv(netdev);
+=09struct clk_bulk_data clks[] =3D {
+=09=09{ .clk =3D bp->pclk },
+=09=09{ .clk =3D bp->hclk },
+=09=09{ .clk =3D bp->tx_clk },
+=09=09{ .clk =3D bp->rx_clk },
+=09=09{ .clk =3D bp->tsu_clk },
+=09};
=20
-=09if (!(device_may_wakeup(dev))) {
-=09=09clk_prepare_enable(bp->pclk);
-=09=09clk_prepare_enable(bp->hclk);
-=09=09clk_prepare_enable(bp->tx_clk);
-=09=09clk_prepare_enable(bp->rx_clk);
-=09=09clk_prepare_enable(bp->tsu_clk);
-=09} else if (!(bp->caps & MACB_CAPS_NEED_TSUCLK)) {
-=09=09clk_prepare_enable(bp->tsu_clk);
-=09}
+=09if (!(device_may_wakeup(dev)))
+=09=09return clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
+
+=09if (!(bp->caps & MACB_CAPS_NEED_TSUCLK))
+=09=09return clk_prepare_enable(bp->tsu_clk);
=20
 =09return 0;
 }
--=20
2.54.0



