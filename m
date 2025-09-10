Return-Path: <netdev+bounces-221499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60BB50A55
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA00C7B8CEF
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57EC2080C1;
	Wed, 10 Sep 2025 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aADjG6yj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90830207A32
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468222; cv=none; b=qDKbY5fhA/Egr/Fi13Y8gIQr/hSRAUnXaSLe+p5jOTa5VsvriBVRHzVCL7Q14hWxORQRA4o/Xpqkx142Ld+t3IptdxQBiHPK1z2W2UdP/j9L5vNooAGtMd0ct2a0FK5C3NxWUtHjPDCrhrH5STdOFWya78O3fVv6anOYrIE1z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468222; c=relaxed/simple;
	bh=rhCUZlon729NwzkrwsV8gA6wQWsxOT+vNnkGWVfM/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuHF/gbcXQHuZ0XNTxlpFQjnFONYS9ug3N3ZC2rxxaLyi3yjFzqoYoVWy7aGERToCuxywxoj8hRvSuVYGPjP8b9JWFRH03lfvS/SQhLQ7VOza83WQAreGEBi/Y5u3RPbf0zBivAqjqIpiuf+0zbpcdZGueYUw3XGmgGpY3/sStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=aADjG6yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E8C4CEF7;
	Wed, 10 Sep 2025 01:37:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aADjG6yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757468220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9zDYuKHgCGDYOquNh4yrSt1LZUhG378TCi5rGFKwyM=;
	b=aADjG6yjJc0Md19FSwlG7mLJ90FCAnWJZFzYHVsVVo7YEBv31xmMDl9GbygXx1u/nhjG8s
	puyc9AwalNFPjs1cy0JadcxN2vryCrz3dnGdsRrkhuz4Ce5/Yf7DMM+3zjSjhDitIUm8Sw
	JVaLeaBJJJUTipdkr+2+3k8xJuIAdik=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 991b62a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Sep 2025 01:36:59 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 4/4] wireguard: selftests: select CONFIG_IP_NF_IPTABLES_LEGACY
Date: Wed, 10 Sep 2025 03:36:44 +0200
Message-ID: <20250910013644.4153708-5-Jason@zx2c4.com>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required on recent kernels, where it is now off by default.
While we're here, fix some stray =m's that were supposed to be =y.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 1149289f4b30..936b18be07cf 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -20,9 +20,10 @@ CONFIG_NETFILTER_XTABLES_LEGACY=y
 CONFIG_NETFILTER_XT_NAT=y
 CONFIG_NETFILTER_XT_MATCH_LENGTH=y
 CONFIG_NETFILTER_XT_MARK=y
-CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IP6_NF_TARGET_REJECT=y
+CONFIG_IP_NF_IPTABLES_LEGACY=y
 CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_MANGLE=y
-- 
2.51.0


