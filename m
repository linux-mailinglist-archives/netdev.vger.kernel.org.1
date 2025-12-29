Return-Path: <netdev+bounces-246281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68131CE812D
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA5E3012DD3
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E6221DAE;
	Mon, 29 Dec 2025 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="gSh+81xV"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17EE215F42;
	Mon, 29 Dec 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037415; cv=none; b=OgHZxmb29H1J/SNw1mh6fcAUCnRXjJu4PE2le7ICZpzuEXaGEsb8SA5l+S4gSuGgmpuf7RQtKjvj48EQfnIWwBZwb8BMhXTfJhke5iodRWxpXRUa3Bz5u2iyEFLboO9s4CH3UBvp1g6EYb0ZEhUqZvqOsK1bpaABvptYGUZKNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037415; c=relaxed/simple;
	bh=mumakuwGdLBzLzk6e4czTmQbX785Gxu9ciavMRfH+R8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nHsIKGM6k1B+mV3CtNw2yYRLHEESBT7YxAKp2nuAf/qfI74uXlMhnyT6fYRd0xYOT6tA19+Ikl/vq4E801xeMKn3szlmwZdEMXaeoEduKc2pNsA2Tn6rGZCM58dD4321DcxholzUjS14/+h8i3bAkspX2oev68MNykD+qOMm6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=gSh+81xV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9O-00DYtW-UQ; Mon, 29 Dec 2025 20:43:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=P7++EmvYFmvUeCzYrRvjhyvzJfMFPh7IoMxVV4S8Nrg=
	; b=gSh+81xVIEavGaC4ZxWz1pGAJYrgt+KRG2bT6H5Edn5a7aL3HmtNvmxPYzgM6gWN3TshJ+Ya1
	AlGNCbRlfJ/UGkss+de/8+K3qvNQD/c231EWB1p8mBZrcw6jKaZ8xnzByM15H4IBhcMBP2IOWU2kv
	EmA6BTf9e0EHhyEmbPlarTveX/u0kROfJRH/rxBlUBNIP396ezpuhszINkPe41KpvRikKVmRcXZw5
	4GddBGTFwNaIbK2+W8yv46F+q+ovxZxzXblDRmWnFJwU1HS4dDml8j0yeQlZGcWkK4JGhNWI0dmir
	Ni04al13JwGSyFlalIWd205Z7jOsHPxhE6SFaQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9O-0007qY-Ix; Mon, 29 Dec 2025 20:43:30 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJ98-0055FL-QX; Mon, 29 Dec 2025 20:43:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/2] vsock: Fix SO_ZEROCOPY on accept()ed vsocks
Date: Mon, 29 Dec 2025 20:43:09 +0100
Message-Id: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3ZUmkC/4WNTQ6CMBCFr0Jm7ZgyUEFW3sOwgFJkorakxQZDu
 LtNde/u/eS9bwOvHWsPTbaB04E9WxMNHTJQU2duGnmIHkiQzIkIg7fqjmrix4Bf+fKLfSZt5wW
 p6KvqrAqh6hHiy+z0yGsiXMHoBdoYThw37p2oIU/VD1D8BYQcBZYnWXaVHMQo64vr7XpUFtp93
 z/Rag2E0QAAAA==
X-Change-ID: 20251222-vsock-child-sock-custom-sockopt-23b779c30c8f
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

vsock has its own handling of setsockopt(SO_ZEROCOPY). Which works just
fine unless socket comes from a call to accept(). Because
SOCK_CUSTOM_SOCKOPT flag is missing, attempting to set the option always
results in errno EOPNOTSUPP.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Fix: set socket flags in a consistent way [Stefano]
- Test: simplify sync by removing sync [Stefano]
- Link to v1: https://lore.kernel.org/r/20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co

---
Michal Luczaj (2):
      vsock: Make accept()ed sockets use custom setsockopt()
      vsock/test: Test setting SO_ZEROCOPY on accept()ed socket

 net/vmw_vsock/af_vsock.c         |  4 ++++
 tools/testing/vsock/vsock_test.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
---
base-commit: 58fc7342b529803d3c221101102fe913df7adb83
change-id: 20251222-vsock-child-sock-custom-sockopt-23b779c30c8f

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


