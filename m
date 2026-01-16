Return-Path: <netdev+bounces-250487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B98BFD2E4CE
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 441F33019547
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B530E82C;
	Fri, 16 Jan 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZfmZi7Cd"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FF30F550;
	Fri, 16 Jan 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553603; cv=none; b=OGgilM98gdj7ydZ3Q2KO+mdI2UVNqIBkqZjiAKkrJTA2OuJJ2TKSGM9MF1l0IIZ6btemi2zpZ0zvoKrqjBgXtaHcL2+fNjV1gwUYI7jkUXyiN5oS2ktw8cD5FENBzSKUoQGJjTZTtjfCubinnW8pbAO3ZyCDVB8EvxcxSXn+ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553603; c=relaxed/simple;
	bh=rPRrOO9EpEhd6j2mFqhrpiOMDftBm6VQnFQJlZap5tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QPD540x+vvrb5uy9M1ggBL8f2IaroCwAAtVqntniFHtQVhm/Um1aSlFeGxO4n39j7QmTfa49fP3SztzXNuHLLU3VqICH3lxkUNZRP3WDzlmyAabSKF+itVkeJvxk50tofVBLiO7Uun8JR+VLxVhW/U2G7fWTidi2erHltQVlTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZfmZi7Cd; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vgfZt-008RKy-AS; Fri, 16 Jan 2026 09:53:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=LIqElcPRbRn6PMxm7/HJ/icGwZZsBWYgtsGeUEkL/L4=; b=ZfmZi7CdHmy1VrOQevq3Hsb40T
	RYqxxjE51+15zasdflKMtTyg5qjsRwqTqCdBeXOCTEmxOMxWM8kXNTm90pujdypI40ghl9wRJXwil
	Q1oS7Jv+LBOUNJ6OfLEpsuhSRy/rRTk2AeULVOqv/pk/KFBldVegaO68jPFrpW8TLqZhNSUyEh9Ta
	oOcQE/C6cXcNiyw+FiWobF0J+N6mW1E9IgcBqJdHZeKq0Kf1qfWWa5SGyh4/qaG49w4WrKQsHpmG/
	WraH6EqwCRYCT78v+0ZuwTYBgEs/CW9w/soaqiiYL12SAK+o7rK27Nwqv8sVE5CV6goKA+0Zzvz11
	Wa1u+mXw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vgfZs-0004kF-V4; Fri, 16 Jan 2026 09:53:09 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vgfZn-0036un-Ph; Fri, 16 Jan 2026 09:53:03 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 16 Jan 2026 09:52:36 +0100
Subject: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
X-B4-Tracking: v=1; b=H4sIAFP8aWkC/x3MQQqDMBBG4avIrB1IUhDbq5RSJPnVQRslE8Qi3
 t3g8lu8d5AiCZRe1UEJm6gsscDWFfmxiwNYQjE54xpj7YM3Xfz0zdDMUzfP+v8pDwkrw7Q+PJ1
 pnA1U8jWhl/1evyki0+c8L20l+idvAAAA
X-Change-ID: 20260113-vsock_test-kallsyms-grep-e08cd920621d
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Blamed commit implemented logic to discover available vsock transports by
grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
by type 'd'.

For some kernel configs having

    CONFIG_VIRTIO_VSOCKETS=m
    CONFIG_VSOCKETS_LOOPBACK=y

kallsyms reports

    0000000000000000 d virtio_transport	[vmw_vsock_virtio_transport]
    0000000000000000 t loopback_transport

Overzealous filtering might have affected vsock test suit, resulting in
insufficient/misleading testing.

Do not filter symbols by type. It never helped much.

Fixes: 3070c05b7afd ("vsock/test: Introduce get_transports()")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
man nm says: 't' stands for symbol is in the text (code) section. Is this
correct for `static struct virtio_transport loopback_transport`?
---
 tools/testing/vsock/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 142c02a6834a..bf633cde82b0 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -25,7 +25,7 @@ enum transport {
 };
 
 static const char * const transport_ksyms[] = {
-	#define x(name, symbol) "d " symbol "_transport",
+	#define x(name, symbol) " " symbol "_transport",
 	KNOWN_TRANSPORTS(x)
 	#undef x
 };

---
base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
change-id: 20260113-vsock_test-kallsyms-grep-e08cd920621d

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


