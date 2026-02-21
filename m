Return-Path: <netdev+bounces-259831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOxoIur2mWmAXgMAu9opvQ
	(envelope-from <netdev+bounces-259831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7E16D798
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F0DE30300F3
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D1309EEC;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oATpNW0l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC12D5412;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697894; cv=none; b=tRqyF9wOs1f7Fxxr2zPQFH6q+DPek7JZ49UJy2pTFK+i/AADYrHA889jkpuLtUUGNZVhoT5htN/OH+Zb8XrO7WSEsB9tGdf/kklK/1938UplT8I1gJ/FnjHQVGCoHpOx7vJKmgCFLZkmda1Z9Wn30ezbS5Bu03jGg9oO2RjfJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697894; c=relaxed/simple;
	bh=UfDNKpDb/dwweC33U6JoY4SpY1Q5JaNKwn/41UrKx2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BLxKA2RHOWr/mT/JRpowOQ3VsUao6uA+Aw5M1kG6TGRuS0tMCqRP2nDDtvouFv2JCPeIGlvtjvaoeo0Lkm97ckgab1/8mPxMmUeQ3HdiTtYjo21RFIhM20RDmgKia9N6J5+9eTeF5OxF3oQUM62gh2XaMKvfYr70740ln+5MSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oATpNW0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1347CC4CEF7;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697894;
	bh=UfDNKpDb/dwweC33U6JoY4SpY1Q5JaNKwn/41UrKx2A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oATpNW0lWIScPc8vAhKQl3LWuxIi7oUGOTFD5nuTaqvlgJ1X2VQvkUqdYPDLG5Mey
	 7yZL5Q8p/Dj3zlzYIk20qU5KzQncQjrYhdqbKHj5Y+4d1vAb88QjGrvvjqvl43jo1p
	 WwSMZPv/EAoQ5SNiER0MuQS6kQf9XKoKUdBLaxlUM2evdO9sWE91jRa/qKCKPZTabp
	 l8pXXKfJVCkMzsA5nQIiDluIkG4XUEoOG5KuJc5t7yYfGYvukjcwLvrWes1AI/IOag
	 6NIX/8BUJOjQmW/OnVHjR1IewVzYm6Cig6IYvPRYr2OmYEce7gMhkIKzic/42focIG
	 b3hTg3i0neakw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB9C61DEB;
	Sat, 21 Feb 2026 18:18:13 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH 0/2] net:ethernet:enic: add VIC ids and link modes
Date: Sat, 21 Feb 2026 10:16:58 -0800
Message-Id: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr2mWkC/x3MQQqAIBBA0avErBNGRaOuEi1Kx5qNhUIF4t2Tl
 m/xf4FMiSnD1BVIdHPmMzbIvgN3rHEnwb4ZFCqLSqGgyE647B7WVhsjhuARNzMGkgituhIFfv/
 jvNT6Ae3wD9NhAAAA
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771697893; l=687;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=UfDNKpDb/dwweC33U6JoY4SpY1Q5JaNKwn/41UrKx2A=;
 b=E138a4JkR3wEgSdZl0KLO5LE1B3LTYiHO+36w0Gt6yIu63nAsq/ms5hBlwmjEliHoKFuNBIfr
 jtaY/PsSqEjCk4Jmv/nJuR12uZKRGVB5xDbm2k4uBqSCuV5p6Wvqje2
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259831-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9E7E16D798
X-Rspamd-Action: no action

Add VIC subsystem ids and their supported/advertised media types so ethtool
reflects the hardware capabilities for the VIC variants.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (2):
      net:ethernet:enic: add VIC subsystem ids
      net:ethernet:enic: map ethtool link modes by VIC type

 drivers/net/ethernet/cisco/enic/enic.h         |  39 +++++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 229 ++++++++++++++++++++++++-
 2 files changed, 261 insertions(+), 7 deletions(-)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-enic-cscwi36355-7fd00b59fe10

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



