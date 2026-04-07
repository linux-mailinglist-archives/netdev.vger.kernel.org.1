Return-Path: <netdev+bounces-276066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL3RMQ0s1Wli1wcAu9opvQ
	(envelope-from <netdev+bounces-276066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:08:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A937F3B1836
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFC8030498DB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A413D1CD1;
	Tue,  7 Apr 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="1uUaBP75"
X-Original-To: netdev@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD13D1CA0;
	Tue,  7 Apr 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577842; cv=none; b=BGLx+X0xHSYqJamEsk/qrf36pieE13/m1UgcdsPEzlL7RDyxmBGyHtMZ8n6FU1rU3jvyseQViGLaJ0VtbEdoL5OvRGkLWWkiPds72Sy0I8kXBELBi5Lb9VJ7oHq5KcioLB0UsBwjFApYr5LttQ0ZMAS41Fwvxg8l+5oMcrRAQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577842; c=relaxed/simple;
	bh=FWMfd4yEZoHIlu5luv1+ztRX+2BUPIE7X09RroYvLzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB1LcydSGRWY/M/EBZSiVvWXtda7Q+tEuPvxowxi0zFmrSH/mSJXDW4AnOvcmmniEqhhv/A8DPVd3h8lezJN4YQDobLjLoLEX/1hCIa+lp7j1Xg1ZKgGWwF+78QNkfkSnDhZ4Q5kfXn73TYRLCKHsCm+TjnfCRpYZccbIpZkNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=1uUaBP75; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=QCAv72jbBIAtTDnzhZIyAqvyUFhGw6j7cPQDLw9NObA=; b=1uUaBP75Ys14D6HcBWqrdyGS0g
	mBbWVgPvTGWnAJgaHv3k736UUiqAETp273iQ2hWevvyRzfSkrSfM/dOowzDCUN5ILbJDj58G5Xnoc
	3tfUEpWFs0BnFzp8wRdPYcB6Npg1rRNboC8Zhj7DTT6dw28HdN53j/7NQHPsYxDIcIkFnbZUwTjGD
	yY3oo8xmbkqGkSxtQaKINztYOoLOvgBsBueZpsJ65X2exPtGJGTE1iXxqDbb46b9UlIW7SuMfkHdG
	REYfK+evCYf0W5cLBxN8G6iRlKZCmBxSdyrrTiBBCLV/bFz58fYbyM3uE28GWExHkSKB1e6x4yLJx
	VZMeu24fFstazA4dyHkt6UOB3mQhSr1TgPfApyS5ZvGGB9cXTGCYr19uFcyokmpGoec4uB8PG7wOb
	NuuduNmOzQbqvoZtHp8eEBCOU+mZiVqFvUyNhozZn7dD89OkAb5EglxXpSQqcWzYthYBo0hrEgNTl
	MkCiYhhprowhTP/I25xR8/fL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA8u0-00000007Xjb-3ZOC;
	Tue, 07 Apr 2026 16:03:44 +0000
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
Subject: [PATCH 3/5] uaccess: add copy_struct_{from,to}_bounce_buffer() helpers
Date: Tue,  7 Apr 2026 18:03:15 +0200
Message-ID: <f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,cyphar.com,chromium.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-276066-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A937F3B1836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These are similar to copy_struct_{from,to}_user() but operate
on kernel buffers instead of user buffers.

They can be used when there is a temporary bounce buffer used,
e.g. in msg_control or similar places.

It allows us to have the same logic to handle old vs. current
and current vs. new structures in the same compatible way.

copy_struct_from_sockptr() will also be able to
use copy_struct_from_bounce_buffer() for the kernel
case as follow us patch.

I'll use this in my IPPROTO_SMBDIRECT work,
but maybe it will also be useful for others...
IPPROTO_QUIC will likely also use it.

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
 include/linux/uaccess.h | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1234b5fa4761..a6cd4f48bb99 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -513,6 +513,69 @@ copy_struct_to_user(void __user *dst, size_t usize, const void *src,
 	return 0;
 }
 
+static __always_inline void
+__copy_struct_generic_bounce_buffer(void *dst, size_t dstsize,
+				    const void *src, size_t srcsize,
+				    bool *ignored_trailing)
+{
+	size_t size = min(dstsize, srcsize);
+	size_t rest = max(dstsize, srcsize) - size;
+
+	/* Deal with trailing bytes. */
+	if (dstsize > srcsize)
+		memset(dst + size, 0, rest);
+	if (ignored_trailing)
+		*ignored_trailing = dstsize < srcsize &&
+			memchr_inv(src + size, 0, rest) != NULL;
+	/* Copy the interoperable parts of the struct. */
+	memcpy(dst, src, size);
+}
+
+/**
+ * This is like copy_struct_from_user(), but the
+ * src buffer was already copied into a kernel
+ * bounce buffer, so it will never return -EFAULT.
+ */
+static __always_inline __must_check int
+copy_struct_from_bounce_buffer(void *dst, size_t dstsize,
+			       const void *src, size_t srcsize)
+{
+	bool ignored_trailing;
+
+	/* Double check if ksize is larger than a known object size. */
+	if (WARN_ON_ONCE(dstsize > __builtin_object_size(dst, 1)))
+		return -E2BIG;
+
+	__copy_struct_generic_bounce_buffer(dst, dstsize,
+					    src, srcsize,
+					    &ignored_trailing);
+	if (unlikely(ignored_trailing))
+		return -E2BIG;
+
+	return 0;
+}
+
+/**
+ * This is like copy_struct_to_user(), but the
+ * dst buffer is a kernel bounce buffer instead
+ * of a direct userspace buffer, so it will never return -EFAULT.
+ */
+static __always_inline __must_check int
+copy_struct_to_bounce_buffer(void *dst, size_t dstsize,
+			     const void *src,
+			     size_t srcsize,
+			     bool *ignored_trailing)
+{
+	/* Double check if srcsize is larger than a known object size. */
+	if (WARN_ON_ONCE(srcsize > __builtin_object_size(src, 1)))
+		return -E2BIG;
+
+	__copy_struct_generic_bounce_buffer(dst, dstsize,
+					    src, srcsize,
+					    ignored_trailing);
+	return 0;
+}
+
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size);
-- 
2.43.0


