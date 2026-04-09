Return-Path: <netdev+bounces-277070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMFyFBHb12klTwgAu9opvQ
	(envelope-from <netdev+bounces-277070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A407C3CDDB3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 19:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45ADA300D30E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250833E121E;
	Thu,  9 Apr 2026 16:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F23D3002
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753997; cv=none; b=kxFeVJ8OqEF88horAocPQWvGaY0DjRq1UPGiH8kU/yWW+FYOuI4oHVAlNr84IXkN/cQQaKWaO/EnfCXbylNXHY9k4xsMdpEIMtrUsYaHfsX4vdKu5iFFPXLwd/LEFUPgHwhCjNDYksOtz1U7Jsoact+QkduuYLce0dACRsAtCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753997; c=relaxed/simple;
	bh=eXxS4VFy6ectYMjWcTz0fJhuEU4RJ6AR6xQPEmQF5bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEKx+yg9QOcefu8YIOC0PDLcMfPKgK+dWcbMsloOLCHZkhVFAcn9b+DAuU8mQei3Ux1yDJHMvuHgedew01VLgGUGpDzGNKMswxcaWyfncSIIRBUbSFsz6brK3qDopNS7hEItlMfLlFgg6uzqSRBVvz+b1syFkQxAvNuRiXHNomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsjN-0001hp-2v; Thu, 09 Apr 2026 18:59:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsjM-004YFE-2C;
	Thu, 09 Apr 2026 18:59:48 +0200
Received: from blackshift.org (ip-185-104-138-116.ptr.icomera.net [185.104.138.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AE8DF518B27;
	Thu, 09 Apr 2026 16:59:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2026-04-09
Date: Thu,  9 Apr 2026 18:57:06 +0200
Message-ID: <20260409165942.588421-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277070-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A407C3CDDB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev-team,

this is a pull request of 2 patches for net/main.

Johan Hovold's patch fixes the a devres lifetime in the ucan driver.

The last patch is by Samuel Page and fixes a use-after-free in
raw_rcv() in the CAN_RAW protocol.

regards,
Marc

---

The following changes since commit ebe560ea5f54134279356703e73b7f867c89db13:

  l2tp: Drop large packets with UDP encap (2026-04-09 10:19:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.0-20260409

for you to fetch changes up to a535a9217ca3f2fccedaafb2fddb4c48f27d36dc:

  can: raw: fix ro->uniq use-after-free in raw_rcv() (2026-04-09 18:51:42 +0200)

----------------------------------------------------------------
linux-can-fixes-for-7.0-20260409

----------------------------------------------------------------
Johan Hovold (1):
      can: ucan: fix devres lifetime

Samuel Page (1):
      can: raw: fix ro->uniq use-after-free in raw_rcv()

 drivers/net/can/usb/ucan.c |  2 +-
 net/can/raw.c              | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

