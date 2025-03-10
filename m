Return-Path: <netdev+bounces-173704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95AA5A703
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FAD3A29D4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8491E8322;
	Mon, 10 Mar 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2pFlBXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BC1E5B6E;
	Mon, 10 Mar 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645374; cv=none; b=ZM/mnKJylIMWa2GDsOWYVpxCxcesvlvSO04Gr5gBvZ+XFxA53BSO0Y9uL4fkN9rDyI5Od5wPXo/UJKQrMH0GfWyVRU7oAYeAcjhii07crUtm6GF9XUt6/HVwW/NQkW9ecUt18yRQUFmyy6qSwVq3ofG84uCrNmxCmLy5Aa4sGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645374; c=relaxed/simple;
	bh=2rHOo5c0XEAGVKs6Dz5LeLPMAvByFQIdJjluLeMe4i4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0izNTdOi67ipnDlS+jTObwqYON0NRt1XM8izmLfpepT+N4/nByYqfcafawQSjtOviveGqEW1bBlYKU9AqDcTSZW+kXMihEdQUIqzh9YapezZ0Ktw0NmV9No14Ga3bGx5yTp2Hvx9G9aRQHwYdFA8W+zrQe9gp3h/+ya4xSQArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2pFlBXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10338C4CEE5;
	Mon, 10 Mar 2025 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645374;
	bh=2rHOo5c0XEAGVKs6Dz5LeLPMAvByFQIdJjluLeMe4i4=;
	h=From:To:Cc:Subject:Date:From;
	b=D2pFlBXhXvjGc5rlcY/jJhQafQmI56NZKnH6uFlYEn2TvX+X1OWrGK6CvlWM9G/2c
	 DwvHNT+fHF9R2mwpPkssr4b3aYYfYZIVuoulbGjyCr4MqWi5uyzfgfrlfQBwiUl6J1
	 PakwC3SFUuo+KydHwy5DX3PJ1ZvcfDYt6D75+7YqQLfGtPOELyUJ9K9d9Gmm8j0jSh
	 555Oc6DVq2zscBBtsWWH7SX/eahvT3T1VfzwkcsFsIcaPwGVjXrOG5bQjjfTwvh1zo
	 2Vfm5DL9WjPM2n5nTHwn+AlRaUtnUSMl+LyV+uN9GGOlSztXRNmDlqvsmy8R1FH3/2
	 nP4n6tmdsk3EA==
From: Kees Cook <kees@kernel.org>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wireguard: noise: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:22:50 -0700
Message-Id: <20250310222249.work.154-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=kees@kernel.org; h=from:subject:message-id; bh=2rHOo5c0XEAGVKs6Dz5LeLPMAvByFQIdJjluLeMe4i4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn0yx9nOf3hDGwzsqOzOee5Wl7nTXKsznj4Rq+ejPRo 1Pu6t/uKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMjlDkaGpoO2nJtNjy1+wmHk tiNR9tctsccNPp32LTFvStUPdvZfZmRouxos9+z2201ZQUZ3o8J2W7mvrRe7+c9Z4nQGy9WUugn cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireguard/noise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 202a33af5a72..7eb9a23a3d4d 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -25,8 +25,8 @@
  * <- e, ee, se, psk, {}
  */
 
-static const u8 handshake_name[37] = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
-static const u8 identifier_name[34] = "WireGuard v1 zx2c4 Jason@zx2c4.com";
+static const u8 handshake_name[37] __nonstring = "Noise_IKpsk2_25519_ChaChaPoly_BLAKE2s";
+static const u8 identifier_name[34] __nonstring = "WireGuard v1 zx2c4 Jason@zx2c4.com";
 static u8 handshake_init_hash[NOISE_HASH_LEN] __ro_after_init;
 static u8 handshake_init_chaining_key[NOISE_HASH_LEN] __ro_after_init;
 static atomic64_t keypair_counter = ATOMIC64_INIT(0);
-- 
2.34.1


