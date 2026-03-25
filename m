Return-Path: <netdev+bounces-271626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF0SLIoAxGmlvQQAu9opvQ
	(envelope-from <netdev+bounces-271626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:34:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D0328196
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A73A3036AE0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49E3DE43D;
	Wed, 25 Mar 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="fi62UMQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B034107F;
	Wed, 25 Mar 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451803; cv=none; b=djPwiKtadz2sAGbXiz0OiKFNQiGPBc0AZ+gcKu8VWlkhKOSkrcxbjZOwAvkNW3q2aoRQazUAVS/Q1ufBAkuJCJEYwL9pDIzQ30BQbB6FSJqOum10cUX6IM6Y+Oeq2WmV0icapXepYL8PTM9aK4ikV1U2HViBuujxog0HFiIlev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451803; c=relaxed/simple;
	bh=1i3NxWlICBbOFqtT7C9smmQo82RtasGv7L9o4l/iSIQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=eUHFeaf+WslsWQxzhvgHuIUi7Wc/e+B35x8igHYkdmGWXiCHzQantZxxBJlpoKkW8v9PBH/pUdZWcbjAbHMMaHNLb9AperDOnJSyNEwL3ExsoXKTEDffylI7Fi/1muL7mU2Z08jR4vYvyvi6WVUKy5k+MMi0uF9EN941q93XB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=fi62UMQA; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1774451800; h=from:subject:to:date:message-id;
	bh=1i3NxWlICBbOFqtT7C9smmQo82RtasGv7L9o4l/iSIQ=;
	b=fi62UMQAn7pIMyPBSY9xt3ENVEbG81A5b1OvP0FhLHQdFE/5I1mf0gbT/Ho0t7h/6mTr/7CPZ51
	tiq8+mrZN7z6bOY1b0b5DxIHwCEClVYS3hNsAHiBhcyJdvucIVKp+T+HP0Nt9X/3kc2lUjHHOtoU0
	1nbpM+Q53Dftg3rg+7HB8ceeaQSw8kuN0APYQ2/ZrZsz5W0OgoO+TTNGjg4n8rzY4hYf1PKcaWO+o
	FvtiJk01ijCrEEaudjJVKlwqDgZfofx4sB9tPfrmXuBrNCTb0r16cXyKgytIQWCMeW3xlqK7dt5wx
	FYMKRLOP17J5YuE6wgdSGEaVZRgc01ikumZA==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:16:40 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next v2 0/2] e1000/e1000e: limit endianness conversion to boundary words
Date: Wed, 25 Mar 2026 18:16:02 +0300
Message-ID: <20260325151615.1407182-1-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-271626-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amicon.ru:dkim,amicon.ru:mid]
X-Rspamd-Queue-Id: 4B7D0328196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the EEPROM write logic in e1000 and e1000e drivers
to avoid processing uninitialized memory. Instead of looping over the
entire buffer, we now only perform endianness conversion on the boundary
words that were actually read from the hardware.

Patch 1: e1000: limit endianness conversion to boundary words
Patch 2: e1000e: limit endianness conversion to boundary words
---
v2:
 - Moved these improvements to the 'net-next' tree.
 - Improved commit description for clarity.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 11 +++++++----
 drivers/net/ethernet/intel/e1000e/ethtool.c      | 10 +++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.51.0


