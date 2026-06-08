Return-Path: <netdev+bounces-296387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wbeaDAtuJmqhWQIAu9opvQ
	(envelope-from <netdev+bounces-296387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:23:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE42653822
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=hQkyNClU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296387-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296387-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CC4300C031
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C61E379971;
	Mon,  8 Jun 2026 07:22:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05E30C16E;
	Mon,  8 Jun 2026 07:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903340; cv=none; b=ifH4nKjouFSDQVdHPHzV4a2STRU4dNtvz4IsJZIFRh2yYEtmNfNmBvev2dh3WtaAwj0CrVKCNECWOkGkas9Ks7yt0hgZJIZobHnIXuccL5iAg2GQpXHadw3rkUiHXrmhjWTzNR8APGSMYpDZVxvAvWcfbuIoF9Wsq+uwAwo1qiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903340; c=relaxed/simple;
	bh=POlbjguZIxiI8p8YrsvrR/hDEeJoeEbuygWZ0xZGOF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e9VfX9ixFUyz06gUNsA5OuPN5lZX9UkT0lsD6Etmw584sgp2ecqO313SqoDo9FEUrJYBqdoVyLzPHhADJY1OZ5Z82kOQr6s+jQpnR7jyIbENHhZm2AMKK5osQciLZGMpZTxqCM8riT2caiWKfDWJ955nrSMFKGdurCrZQQ2C0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQkyNClU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A288C2BCB0;
	Mon,  8 Jun 2026 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780903339;
	bh=POlbjguZIxiI8p8YrsvrR/hDEeJoeEbuygWZ0xZGOF8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hQkyNClUiv/Nab1MDxqtuor/NGlka9IrRlVK8a/L4Mq+rLSSx9GNpOlEi7k7wmeQn
	 KAFHRpuQa1prQFQI/uu+mzyUv+6FDeYxpi2M/06N6wJHrRzkPQhagheD63gXfYOpXA
	 U8UD9Z/RrckMpCHtH8JNs/thR0WCenYwH+EvbPm4HIf0BVWBL4Xvdcl6XlQ+Q5yr6G
	 GB7KUYSslOoysKRRHHElZFbFRc3QaQaHHcJH0qG76SyqkQtfvVFVKNf8qxFljqrjnV
	 8eQxtleFTkT/T83CqdxbhdP6I35GoepIOyIgjnuW9FDovk4Tqec2hcWqYbFDTICZfB
	 ACn38SPsVFdDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E64DCD8C92;
	Mon,  8 Jun 2026 07:22:19 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 08 Jun 2026 11:22:08 +0400
Subject: [PATCH v3] net: dsa: qca8k: fix led devicename when using external
 mdio bus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-qca8k-leds-fix-v3-1-a915bb2f37ae@outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MywrCMBCF4Vcps3YkpmkdXPke4iKXiQ29pCa1C
 KXvbhAEl/+B822QOQXOcKk2SLyGHOJUoj5UYDs9PRiDKw1SyFa0gvBpNfU4sMvowxuZjHLk2ai
 zgXKaE5f5C97upX2KIy5dYv1jGqFk88+sEk9o2pq8q4kaq6/xtQwx9kcbR9j3Dy1x+lqkAAAA
X-Change-ID: 20260608-qca8k-leds-fix-e8b4d8feb47b
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780903338; l=2408;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=HiUw3Q504F5hs2do7v6tmrj/sdstwjc54LpITglorVY=;
 b=6akJitugOoduxzekxXr8wUyxaunTXPSPvklTHqMbAzdPnSbxEeFFnt0i8kmIwCy8NxlIWVsL1
 UFb4R/AmSnvDsmCKI1yyVbZUYEV0weZfCN2/aOR1uGK2stn129rnQ5T
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296387-lists,netdev=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:f.fainelli@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:george.moussalem@outlook.com,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:mid,outlook.com:email,outlook.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FE42653822

From: George Moussalem <george.moussalem@outlook.com>

The qca8k dsa switch can use either an external or internal mdio bus.
This depends on whether the mdio node is defined under the switch node
itself. Upon registering the internal mdio bus, the internal_mdio_bus
of the dsa switch is assigned to this bus. When an external mdio bus is
used, the driver still uses the internal_mdio_bus id which is used to
create the device names of the leds.
This leads to the leds being prefixed with '(efault)' as the
internal_mii_bus is null. So let's fix this by adding a null check and
use the devicename of the external bus instead when an external bus is
configured.

Fixes: 1e264f9d2918 ("net: dsa: qca8k: add LEDs basic support")
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Resending this patch as v3 with an updated commit message. There was a
discussion on removing the notion of having an external and internal
bus which was never followed up on, yet the issue is still there.
Link: https://patchwork.kernel.org/project/netdevbpf/patch/20250425151309.30493-1-kabel@kernel.org/

Changed in v3:
- Rebased on top of tree
- Updated commit message to reflect renaming of slave_mii_bus to
  internal_mdio_bus
- Link to v2: https://lore.kernel.org/r/20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com
Changes in v2:
- Fixed c/p error from older kernel version: slave_mii_bus was renamed
  to internal_mdio_bus
- Link to v1: https://lore.kernel.org/r/20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com
---
 drivers/net/dsa/qca/qca8k-leds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 43ac68052baf..ef496e345a4e 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -429,7 +429,8 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.fwnode = led;
 		init_data.devname_mandatory = true;
 		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d",
-						 priv->internal_mdio_bus->id,
+						 priv->internal_mdio_bus ?
+						 priv->internal_mdio_bus->id : priv->bus->id,
 						 port_num);
 		if (!init_data.devicename) {
 			fwnode_handle_put(led);

---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260608-qca8k-leds-fix-e8b4d8feb47b

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



