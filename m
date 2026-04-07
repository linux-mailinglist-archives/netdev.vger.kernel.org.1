Return-Path: <netdev+bounces-275787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN7+G9dR1GnRtAcAu9opvQ
	(envelope-from <netdev+bounces-275787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:37:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9273A873C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39945304FF95
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A141C3C1F;
	Tue,  7 Apr 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6hVQfDy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1741A6827;
	Tue,  7 Apr 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522227; cv=none; b=jJ5MdS4h7pqP7uytDh8QJVq2q4HmHyvz3hFQtBV4A0CViPEWowORnHAd5TwA37/jp5uTLN8cKWwGvayh+VpaACdK4Ee+wux7C43jNvzjJ+cSLdo3BVj3bXCSpjWPXR87IGOrDzIuLYH4L171u3xmdNyyMHAPVO+OO52sya7oT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522227; c=relaxed/simple;
	bh=m7rSGSDcAArgoErR9NmUr8qvQOw4pCD9BnVxNZo8Z5c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ian1BbCnq23jJhbHMb10EYstNPteGp+S/h4VWPrzd9Vu7QfmpHWsN+ZoXIm/7NWeGIc+jjImAkdALdIhiNHYqB5toSCe9t/guQMfVgaHGEJDHIXgKhkfRpFNaRKhe9go/NBSXoS0HhZggesqzNSZYQS/dxX3yfZxL7ugi6a7H3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6hVQfDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07468C4CEF7;
	Tue,  7 Apr 2026 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775522227;
	bh=m7rSGSDcAArgoErR9NmUr8qvQOw4pCD9BnVxNZo8Z5c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l6hVQfDyFDQ9zeQdGhdAQbWPIpC7mx7jlGMsxdgYjNrk1Vej6+S4dayJr9Mp+sA9N
	 tffsLGuWgErqMxN8M07hgIec9DbzM5Sb7gt0PLyJMqboSGMeDIXMSbgLLZ+qIqGPoo
	 3FQZ2IzlXE2scCHJUK0UXRC5bDP7ULHAP+m1RqN9Hws+nuE78cMANFm0tuTkRvhffI
	 fQLEL0t2kBdChff4PglKNkBjfWhtVD78MywzUfOhAjtFzCu/9MgDujBCJ+YHJQBvwp
	 HaHir4cctC4HP8C7TeUduX9+9Y044YHAnlhjsTaZTOzKm8v4iJC0ZwPK/qnOxLpH/d
	 /K+3AJzEErRWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC9EFB516E;
	Tue,  7 Apr 2026 00:37:06 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH 00/10] enic: SR-IOV V2 admin channel and MBOX protocol
Date: Mon, 06 Apr 2026 17:36:58 -0700
Message-Id: <20260406-enic-sriov-v2-admin-channel-v2-v1-0-82cc47636a78@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKtR1GkC/x2NUQqAIBAFrxL73YJphHWV6ENsq4XaQkGC8O5Zn
 /MY3jwQKTBFGKoHAiWOfEqBpq7Ab05WQp4Lg1a6U61qkYQ9xsBnwqTRzQcLfqbQ/g1eOWeot9Y
 aA+XkCrTw/QfGKecXiPpjwnAAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775522225; l=2495;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=m7rSGSDcAArgoErR9NmUr8qvQOw4pCD9BnVxNZo8Z5c=;
 b=9RLyg+rfwbrqQzcwFFHf2L4/PnVrqUObPdPaRC+RDbEDpVswcBTjqExPar+LMo+ewLyFjbXaA
 7Ix/JYrmYhUCIYBhgQeYXgev4kua7MLOW5lZgNR2xVDnr9Jp3TjNI79
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275787-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 1A9273A873C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds the admin channel infrastructure and mailbox (MBOX)
protocol needed for V2 SR-IOV support in the enic driver.

The V2 SR-IOV design uses a direct PF-VF communication channel built on
dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

Firmware capability and admin channel infrastructure (patches 1-4):
  - Probe-time firmware feature check for V2 SR-IOV support
  - Admin channel open/close, RQ buffer management, CQ service
    with MSI-X interrupt and NAPI polling

MBOX protocol and VF enable (patches 5-10):
  - MBOX message types, core send/receive, PF and VF handlers
  - V2 SR-IOV enable wiring with admin channel setup
  - V2 VF probe with admin channel and PF registration

This series depends on "enic: SR-IOV V2 resource discovery and VF
type detection" (Series 1), which has been accepted.

Depends-on: 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (10):
      enic: verify firmware supports V2 SR-IOV at probe time
      enic: add admin channel open and close for SR-IOV
      enic: add admin RQ buffer management
      enic: add admin CQ service with MSI-X interrupt and NAPI polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration

 drivers/net/ethernet/cisco/enic/Makefile      |   3 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  27 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 509 +++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_admin.h  |  27 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 208 +++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 530 ++++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_mbox.h   |  87 +++++
 drivers/net/ethernet/cisco/enic/enic_res.c    |   4 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  11 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h   |   4 +-
 10 files changed, 1397 insertions(+), 13 deletions(-)
---
base-commit: 3e6ef4fb822c971b464d44910a1561b4e7f9efa7
change-id: 20260404-enic-sriov-v2-admin-channel-v2-c0aa3e988833

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



