Return-Path: <netdev+bounces-274078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGpsIPMTzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:47:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5837AB49
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF2FA30E43B3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B83FBEAB;
	Wed,  1 Apr 2026 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="SMCZinU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE63F7AA0;
	Wed,  1 Apr 2026 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045390; cv=none; b=ir7djUE54tTTw74sHFfJVKg7BMPJ/RxdMslmZFw8o17zcOwUfSMohlEov8lrlXOMWZiVm04jVxsNeGUHIvZB/0EdZoDt/W4zh6vi/mRGkq/RxVJmWBU4KRKzM2QXDoFOLhE1pkd0pQvG143aiccXLrThFceSBPtpq+wDWZ3k1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045390; c=relaxed/simple;
	bh=PlaAOt0ssCukJ7V+OLnR4/beOc5FHiklgNa9+yhyvr4=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=LpfUySC8/paf1GHx/n1Aji8QM3O48PEMMY5sSJeHxJ9Uj1IiYm9xIs0Qlgqu8XMishyJSDYfIXwgewXo0J2CDwPweOgXvBXLGL4JKivn/kkX3mUUeeTLLGiOAjJYiBHum29j3PPMdRJgZkAgfXITRQw7cquROXDIdXS69oc72rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=SMCZinU7; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1775045378; h=from:subject:to:date:message-id;
	bh=PlaAOt0ssCukJ7V+OLnR4/beOc5FHiklgNa9+yhyvr4=;
	b=SMCZinU7YdIlx6vXdse6mQDcjiESHnZRuK1jGXrJiu0sOzNxF3U53/sdQoG2oDAccGBi7IcLQse
	EyC2KvaBECt5XBEamdvI0ZXX1evaXPUkK2QM+Jssw8JV9iC4vUZaZODaqzEGPAjrxUUAZDrtlVzf3
	Tie00+KdRwRGeKUD4WWd264ove2hwsnLr2tgVdPetXHLgauRaXu+QgEIajK/QhjRK4TIQtvZnUS1V
	33+pxHm6yvSSEa1lrC5MjjC3QQ37EJdBYK3wqryeTXe3oOiNxmpSgnMmf0EbSsf9aFUE1wSPk7VIf
	G7Y/F89A90Ft42N2dMhUcxhC2lQl5djMomSA==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 1 Apr
 2026 15:09:37 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next v3 0/2] e1000/e1000e: limit endianness conversion to boundary words
Date: Wed, 1 Apr 2026 15:08:22 +0300
Message-ID: <20260401120919.282668-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325151615.1407182-1-ade@amicon.ru>
References: <20260325151615.1407182-1-ade@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amicon.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amicon.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-274078-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ade@amicon.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amicon.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amicon.ru:dkim,amicon.ru:mid]
X-Rspamd-Queue-Id: D6C5837AB49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the EEPROM write logic in e1000 and e1000e drivers
to avoid processing uninitialized memory. Instead of looping over the
entire buffer, we now only perform endianness conversion on the boundary
words that were actually read from the hardware.

Patch 1: e1000: limit endianness conversion to boundary words
Patch 2: e1000e: limit endianness conversion to boundary words
---
v3:
 - Reverted to v1's "check-then-convert" logic in patch for e1000e: the
   return value of e1000_read_nvm() is now checked before performing
   le16_to_cpus().
 - Removed the redundant full-buffer loops in patch for e1000e that
   caused double endianness conversion in v2.

v2:
 - Moved these improvements to the 'net-next' tree.
 - Improved commit description for clarity.

 .../net/ethernet/intel/e1000/e1000_ethtool.c  | 11 +++++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c   | 19 ++++++++++++-------
 2 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.51.0


