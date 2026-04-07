Return-Path: <netdev+bounces-276067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIDPBSYs1Wli1wcAu9opvQ
	(envelope-from <netdev+bounces-276067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F084D3B1845
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8E13304C8A9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939683AB275;
	Tue,  7 Apr 2026 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="d29tw00A"
X-Original-To: netdev@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED13D1CB6;
	Tue,  7 Apr 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577845; cv=none; b=t6wt8dqfvEsKvrS7YHdm34mD4WpvyPwqHz1a7wJ+Sswiq1LO6wwwyty0OQuhHLP1s1s9V518/8T4JOymVh1geJxGMpJDBMLI4/CSx8Vt+52otWHcgCKgq8mLI5Xs9wcMkbZCL6GKTomhRAc8NWkDQmRjbIwLWVpwj1cqZdr+Rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577845; c=relaxed/simple;
	bh=wHapa6bYWvJzvpoBm8/tnoueHb8aD9aXe9o4B9DjhoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8JECfXb9ZpXjeacT7I5VbdhPrrYqi0LNEEUC5e3hwtvPut3oqlKAYAHdO1DMiGLw0z7nqPyzvWeJZp8Sb4uYdolcGGUQAq6a4a1l5o+XpqpQc5SaeNf42GNuwJ/+2s/Oa7nJamNvifEPFzghhvEu6vqCgu+zbEagmA6laYnIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=d29tw00A; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=TbrjwGo14PmyvPU5IuDe4577IkjzAwCCxvuZ9TVYC1s=; b=d29tw00A1K/qlUbkw3/tldt/0+
	T5BRYVIH9OjG2rCTK7MAGPK0ECcWTdXrA9EM7SOAB9prk/bmwWsizRvrOOzbitJtjG2Gwm3WFeRL/
	4iZdVq6g7ew51RTmVyebzqq113yoLmOtUlBF48AYEygkhAYn6SR7nn3gu/avFK9LBxN99Mvl9WLOl
	8ieGv4jApxY9oKqEh1TF36KY28RASNSSjyp8L7P43Sa3p/ToOeeMWztWrESq7KQULkAZmkqZy7yry
	r6dBqNg8wF9otrPINe+ykFoE68ZZRK2AA2W1Wf66eNmDHTkLRKv2uB1y+iFn9HLG/Qm99wB1y7qDV
	CzXS5begpBL8ZHbqD7MdnTpOE+WbkEDxImMVl5TjV0X1TaaGS7spQb1YTO0bFFRabGMcSGChQuNcL
	LMwGFPWNdhe3/PV5GDer27EARLhK/I5qaJUOvlmIOY0hH2BLoYRdzbuBZBfrZtbsmsE9D3k6G92PL
	K/uLP90F8QDUYa/ct5cW+81u;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8u6-00000007XkD-2WGJ;
	Tue, 07 Apr 2026 16:03:50 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-kernel@vger.kernel.org
Cc: metze@samba.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Michal Luczaj <mhal@rbox.co>,
	David Wei <dw@davidwei.uk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] sockptr: let copy_struct_from_sockptr() use copy_struct_from_bounce_buffer()
Date: Tue,  7 Apr 2026 18:03:16 +0200
Message-ID: <b9b7e22664a53251d7ad099b12aead8b599c1257.1775576651.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,cyphar.com,chromium.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-276067-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F084D3B1845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The world would be better without sockptr_t, but this at least
simplifies copy_struct_from_sockptr() to be just a dispatcher for
copy_struct_from_user() or copy_struct_from_bounce_buffer() without any
special logic on its own.

Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Francesco Ruggeri <fruggeri@arista.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Michal Luczaj <mhal@rbox.co>
Cc: David Wei <dw@davidwei.uk>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
CC: Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 include/linux/sockptr.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index ba88f4d78c1b..706a8526cf3c 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -87,24 +87,10 @@ static inline int copy_safe_from_sockptr(void *dst, size_t ksize,
 static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
 		sockptr_t src, size_t usize)
 {
-	size_t size = min(ksize, usize);
-	size_t rest = max(ksize, usize) - size;
-
 	if (!sockptr_is_kernel(src))
 		return copy_struct_from_user(dst, ksize, src.user, usize);
 
-	if (usize < ksize) {
-		memset(dst + size, 0, rest);
-	} else if (usize > ksize) {
-		char *p = src.kernel;
-
-		while (rest--) {
-			if (*p++)
-				return -E2BIG;
-		}
-	}
-	memcpy(dst, src.kernel, size);
-	return 0;
+	return copy_struct_from_bounce_buffer(dst, ksize, src.kernel, usize);
 }
 
 static inline int copy_to_sockptr_offset(sockptr_t dst, size_t offset,
-- 
2.43.0


