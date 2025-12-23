Return-Path: <netdev+bounces-245824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42498CD8AE3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABDF1300100C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93731F03DE;
	Tue, 23 Dec 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="icKlT9vO"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF59156F45;
	Tue, 23 Dec 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484142; cv=none; b=AiHgds3ohxqC/yvM3EWEyjz0uZfQdeMDFVgUThQUPzTzYRuRngiKGsjfUhHs/Q+2vxquw9atDAEK/xQrFDNsii1mxjIi7b/ubQnQDgCqZ6T8/3Cko1IoMohAovLqT/8QocOG5aTWTMcWTMFUL9lz/Oa2dnpdlLxBoKtHagrywCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484142; c=relaxed/simple;
	bh=M6m9ZR3gOJPB/c8SonAHbP9mPbovYQRt2g2HwOhudqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cmA5n8TFuK/3FGxOiZUbIurhr2TWyMu+btWziWKoN3EjG7/ZJOUZu+XH3ivK4W80H+sRAbm7Kg1Oyo8cRzLSxnsk1FdmIyvw2iCLc0xyHgPIHaqFUdqSC06qCPu1ow/Em4zNEIdurBRYTh8ry7F7884n4qghAor1WvDu5FG7Ihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=icKlT9vO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUl-00ABjr-U1; Tue, 23 Dec 2025 10:15:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=2Vj52tMb4Pb2xJ6Ddbf2pSKXvFqOetVFjgvNEJ55Rl8=
	; b=icKlT9vOZXDroFI6HFVTJfNSadoeWyAnIUu/TgYFJsWiajFS4u+/UfJ6kuuojSr7AjIZ/HMVa
	U8Sn5ObzbrSAls0UHLKaw+v3zJpimT8Qw49dmqotulEdRFMDRxsrSLikMsWTJb9avd3S5FRHp4EeA
	94cq6B1UY6dEHJqfljXXuU8ujEIPa/lDLGobQRbi3iHyZ1pBkiV5mLunJPEs3lBuEVT3iKLqNi0rS
	D3H8JDKtW9Ix1kGMobz2Ctttib7Gw0ghcy3Kt9L52DY0wHwiFHbk3Fnvee2fRHXCzWDtc4XZMhEQc
	AS96uCxkdnTfCro5nnVHucNM1U7SHJrctfiYXw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUl-0005KW-33; Tue, 23 Dec 2025 10:15:55 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vXyUf-009MHY-Pb; Tue, 23 Dec 2025 10:15:49 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/2] vsock: Fix SO_ZEROCOPY on accept()ed vsocks
Date: Tue, 23 Dec 2025 10:15:27 +0100
Message-Id: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9dSmkC/yWNQQqDQAwAvyI5G9BIsfoV8aAx1mC7K5tVCuLfu
 9jbzGXmBJOgYtBmJwQ51NS7JGWeAS+DewnqlByooEdJRHiY5xV50feEf9wt+s/NfotI1VjXDVc
 FP2dIlS3IrN/70IGTCP11/QBQl6XxdgAAAA==
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
Michal Luczaj (2):
      vsock: Make accept()ed sockets use custom setsockopt()
      vsock/test: Test setting SO_ZEROCOPY on accept()ed socket

 net/vmw_vsock/af_vsock.c         |  1 +
 tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
---
base-commit: 5e7365b5a1ac8f517a7a84442289d7de242deb76
change-id: 20251222-vsock-child-sock-custom-sockopt-23b779c30c8f

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


