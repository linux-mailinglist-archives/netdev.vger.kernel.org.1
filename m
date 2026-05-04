Return-Path: <netdev+bounces-283922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKBXOV28+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86F4C0BAF
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9443020A42
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D163D348B;
	Mon,  4 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbI9wg3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B73A5E92
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908760; cv=none; b=pjw3aNCnzOsQPrnjgWSBL2cRzQQlyCFFlmmByQdovueNGVmnSmEbZXdyvrmeGLNnH+EI9nCDxxoTFVBlghSAqvltzUczBe3vg+dYBJ5ugWc0MFMjlD0SxlZjKBGSv/wOCHYmiDnZV4oZspUeBOZZxQ8o1BoyRahKZbnv6maFmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908760; c=relaxed/simple;
	bh=EYI4V78aTv/qKhCSa+8f/27QMleraEp8qZkWOkkFvtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr+h6Bh+FQcls+DJw47ZrdjPtBnraVnA8jMatzIiOP88slcjXUGUrXdq6I/9ZnS2pVyaU9jLwhovY0ZxfEeCZOyp6FkXnlhx8sJtYoTTEaO6xZPiZRNVunRtO6PO8qbKiXuhSGRhpkQ0gOOzGeyWpg6YUJl8yI3E8H9e/QA6RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbI9wg3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E9FC2BCF6;
	Mon,  4 May 2026 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908760;
	bh=EYI4V78aTv/qKhCSa+8f/27QMleraEp8qZkWOkkFvtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbI9wg3RAhq3eRSEZ7gyZI9FV9iAZnJdKxF15QhGLLWoT09gCMjAnu3d21F2NFbBc
	 SEk5gMQj5j1kEPuodwkTTVl9wiMGJLhHYuGekFmuH2gkOQkvM5QSRvNdybdAKoinUB
	 RVwPbqXkcCc1pFxiKyUNiUSbfHcRCWxIsL4z+Hs2q9vriMx8OQEwUljfCxK/jgPrep
	 w4iBzOJkX6Xvq4Cy+7bQD2Suun9YMVqaKqeu+1IEz3yDXXKuSHggmeyohu113HM9zz
	 HmMOImAqf3GnyiW2MwblzqYKg3jglqz4Rso6nK7EaOn3mEIX0PwcqTgDWnU/ioxWXV
	 3Msz0FO/mq0MQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org,
	Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 3/5] net: dsa: mv88e6xxx: define .pot_clear() for 6321
Date: Mon,  4 May 2026 17:32:25 +0200
Message-ID: <20260504153227.1390546-4-kabel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504153227.1390546-1-kabel@kernel.org>
References: <20260504153227.1390546-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A86F4C0BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,waldekranz.com,vger.kernel.org,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kabel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit 9e907d739cc3 ("net: dsa: mv88e6xxx: add POT operation") did not
add the .pot_clear() method to the 6321 switch operations structure.
Add them now.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 78799666e6b7..b55a9d4a1ee1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5244,6 +5244,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-- 
2.53.0


