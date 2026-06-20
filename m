Return-Path: <netdev+bounces-300841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +8QhLPDSNmoqFQcAu9opvQ
	(envelope-from <netdev+bounces-300841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 19:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 624966A96A6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 19:50:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300841-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20DDF3036CD3
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64132AAB3;
	Sat, 20 Jun 2026 17:49:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F0331A63;
	Sat, 20 Jun 2026 17:49:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977753; cv=none; b=j5xdZwX7EJNxeFyFeU+HbWpzNk3+CQtM96+gDeKs56LwEx3xp1ejS0IJPnL/R02tU0HryUzkD8FMu5NQ5RCsAm7Q7YeMxa2B1dEoZLCsKv8jaGK2dzIpREt6kA2jYjmpeq/KuM7eo8KWs0mHKfEcQvZlS61MqyM/MgueRJWK7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977753; c=relaxed/simple;
	bh=KAPoBf9BExen4IaZoij6WCkOt/dAfiQP4OlXnivQIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dilg1D1Rb7SUhiRY9TjQUSr2ZXS4BDM2l3R5ztSDG2KCMZvXLPhNV2NL5gOMUlBEpRzM63r2lOY4BQO7MYa3OHyXdXrR6ddAyGkxiOLWVnARj7V/5C/q698a9fy44O0E6w5XwP5H4i9smwn8ngG0z/Iw5ZGpLKEPRml34cCtG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Received: from work-wifi.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 97159C018D;
	Sat, 20 Jun 2026 19:49:07 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154-next 2026-06-20
Date: Sat, 20 Jun 2026 19:49:03 +0200
Message-ID: <20260620174903.1010671-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[datenfreihafen.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300841-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:alex.aring@gmail.com,m:miquel.raynal@bootlin.com,m:netdev@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,datenfreihafen.org:mid,datenfreihafen.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 624966A96A6

Hello Dave, Jakub, Paolo.

An overdue pull request for ieee802154, catching up on all the AI found issues
at last.

Shitalkumar Gandhi fixed problems in the ca8210 driver for cases where we could
have a leak or a pointer truncation.

Robertus Diawan Chris made sure we do not overwrite the return code when
associating.

Michael Bommarito worked on properly gating our netlink API use in the llsec
security context.

Ivan Abramov cleaned up the netns cases as he did in other subsystems.

Doruk Tan Ozturk ensures we have the correct skn ready in cryptoo operation (to
avoid a  silent overwrite).

Aleksandr Nogikh fixed a kernel-infoleak detected by syzbot.

regards
Stefan Schmidt

The following changes since commit b85966adbf5de0668a815c6e3527f87e0c387fb4:

  Merge tag 'net-next-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-06-17 08:17:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git tags/ieee802154-for-net-next-2026-06-20

for you to fetch changes up to a6bfdfcc6711d1d5a92e98644359dedc67c0c858:

  ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation (2026-06-19 23:02:42 +0200)

----------------------------------------------------------------
Aleksandr Nogikh (1):
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Doruk Tan Ozturk (1):
      mac802154: llsec: add skb_cow_data() before in-place crypto

Ivan Abramov (3):
      ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

Michael Bommarito (2):
      ieee802154: admin-gate legacy LLSEC dump operations
      ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation

Robertus Diawan Chris (1):
      mac802154: Prevent overwrite return code in mac802154_perform_association()

Shitalkumar Gandhi (2):
      ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit

 drivers/net/ieee802154/ca8210.c |  9 +++++---
 net/ieee802154/core.c           | 51 +++++++++++++++++++++++------------------
 net/ieee802154/header_ops.c     |  9 +++++---
 net/ieee802154/ieee802154.h     | 17 ++++++++++++++
 net/ieee802154/netlink.c        | 36 ++++++++++++++---------------
 net/mac802154/llsec.c           | 14 +++++++++++
 net/mac802154/scan.c            |  1 +
 7 files changed, 91 insertions(+), 46 deletions(-)

