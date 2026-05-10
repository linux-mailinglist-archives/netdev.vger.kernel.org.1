Return-Path: <netdev+bounces-286333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKXFE+C1AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6AB50527A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 808843002500
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF93B19A8;
	Sun, 10 May 2026 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="ghPH/st+"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682D39EF1C;
	Sun, 10 May 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431448; cv=none; b=XCc3qpin37qty4HDdfm3SDZH4nv5A/q+DUMSWIMS3eJqvzyLI7F1O+XlT6tPnPIMF18t76yh48KtR8Itb0cz7GZri3o77OwSQ0pnVClv544/F/I72kz+ixAqpDb8LuZOCMzPS8/CFIlFjLucdLnFQdI4mGxPfXGEv1q7+HRI33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431448; c=relaxed/simple;
	bh=N3duTWqU4pFsbiaGRw0cmtx/NQYpMFCH77JRqm/Vcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ePpsByBscZgM2LSOZJ0qE/3plKStOReeIppaulPtmKPBh0Sue4jynmNulNTWb0eSyO3JeBHrInTc5b851soHvk02xmRhI10+aMAWfI6rR7eNxAEg2OGhUNFVpUnhxWFMPYn+wAdRp/RYwFqiWADLJlv564SSr7RaxXd+RPYm71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=ghPH/st+; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gD7wc5qWXzDqJ5;
	Sun, 10 May 2026 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778431441; bh=xi3qfonM/fxxkErgpkpyWq6RqDhn14z/0dVuc/pda3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ghPH/st+ZStpJkWvPA3y2e+jiLAA1QkB2lVRzBKpnizKpbb6Md63CrgtEbRzQnCve
	 cD9CSj8J0CetkL1PyRewHv8IlcR6XcmlzUfsGiqU35qQcZ9sGMNgNefn6Nrupzb+yg
	 ZJuxFrnvIYdKGpD1yQRqB5rzWkXH6uZf/NlRUuv8=
X-Riseup-User-ID: 84D200AB20CB8D2F72B8E0087B19FAFEBD973C63C5B16F999C22A26D3C44C315
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gD7wX6vqRz1yZZ;
	Sun, 10 May 2026 16:43:56 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Filip Pokryvka <fpokryvk@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
Subject: [PATCH net-next 0/5] netdevsim: get link via ethtool, set via sysfs
Date: Sun, 10 May 2026 18:43:32 +0200
Message-ID: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E6AB50527A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@riseup.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riseup.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riseup.net:mid,riseup.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Allow to read the carrier status of a netdevsim device via ethtool, like
most of Ethernet devices allow.

Also, allow to set its carrier status via sysfs. Currently it's only
possible by linking a peer device and setting its admin state to
UP/DOWN. By editing the carrier status via sysfs tests that need to
check carrier related stuff may be simpler.

The third patch add the proper selftest for both things, and the fourth
and fifth fix a few small bugs in the selftest itself.

Filip Pokryvka (1):
  netdevsim: Add ethtool get_link support

Íñigo Huguet (4):
  netdevsim: allow changing carrier state via sysfs
  selftest: netdevsim: test carrier change via sysfs
  selftest: netdevsim: cleanup the devices and module on failure
  selftest: netdevsim: suppress socat warnings

 drivers/net/netdevsim/ethtool.c               |  1 +
 drivers/net/netdevsim/netdev.c                | 23 +++++
 .../selftests/drivers/net/netdevsim/peer.sh   | 84 ++++++++++++-------
 3 files changed, 80 insertions(+), 28 deletions(-)

-- 
2.53.0


