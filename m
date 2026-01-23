Return-Path: <netdev+bounces-252836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLMoMTJoc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D7075B79
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7334630A3468
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D9322B68;
	Fri, 23 Jan 2026 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jZ9qKQ2X"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC852DC770;
	Fri, 23 Jan 2026 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170700; cv=none; b=WGzJVWdPNzEw2aGacB8QpaKZ7ISCb2+tvRBCCUwI1UrE7yJyz16jRghc1Pdb0WKj0zoOKiAHG0nFmw0wBRgQmTgGIQSF5aIq845gdy5k50Gx7CniiQwXOoFyGw0yhAV//7w6f9oEVOWPTmkT//oS15oKpGIqHE1TiBCVaLAUk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170700; c=relaxed/simple;
	bh=sM4MmBb2STkbv+3RBVIqkeR0mqGw9WVKg1AHc37unH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B5rcdWEhI1W1fO6QDXXiWBql6m0LX0XahK4q518iDZGF89SxfzZ/2DxrAbuW7iI8GARVAnzAjXz2x0oQCpHmRGZ8HjFpQ7BaAV84u7Eqg9n0YOFRgKaOgu/Of2mzi7H2pH3/negIjzpMrKdzif3CCQoJw6fKNqt0upWNV8nOj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jZ9qKQ2X; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=46Q3/PMzTu+WOHkGQb8g4PO/Yj+7Lf8peeoI+CL66Uo=; b=jZ9qKQ2Xn10dCnJvERTuRgKE0z
	w4Z45GmrRCD6X1nPIUPvR4uWttMWb41kLzVdc8lSsrJvKkUFNxTjGOSGtPXEisx6e7mRZtPuk8R/3
	guaN0Y412BDf2PChJXMn2SBwolr4BYQUmhwls0F6KN5bhNMHUkCITqXJXcJBswcnv1Hkl01Xqk3Fl
	lqhqjOgnUWPnT9v4PZeVwZ3Tvq4Hfl7ei3XL1n0gCaQjER2VJcDKgs4nFjZEsPsdDe0MN1nKxh7r4
	koMFQkGRQ7IC0NJA6t18XlKt5HAOm/hLMGHLh5eErK+moMYPA80zu1DV1fjZ2RMf3kc/+4anoPLn8
	52qt/VIg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjG70-00DpeL-TY; Fri, 23 Jan 2026 12:18:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 23 Jan 2026 04:17:25 -0800
Subject: [PATCH net-next v4 2/5] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-nbcon-v4-2-46a5cf567926@debian.org>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
In-Reply-To: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=leitao@debian.org;
 h=from:subject:message-id; bh=sM4MmBb2STkbv+3RBVIqkeR0mqGw9WVKg1AHc37unH8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpc2bqGkT8KGl0Ke86GM+ZyfVSjDwxGL7EMqlWX
 dUPtLvAhZ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXNm6gAKCRA1o5Of/Hh3
 bT5ZD/9N4l4vUHyBmLVKBjpGhz26fxwUoSVpcd5CelmbsinSTFscWZ5SMv3adSuHV93ndjT85IV
 zW7ffIGa1kDHD+LKqEEIoo4wrBoWxWylCA6hUjBRMms8kOZrEbwI1ow3In9bd0bJUvmYOcKaNae
 5Uhfbrl2WN89VIGJLtXs4N+hOwMkFC6KHhjhFnZcAwwH1BNcAx8C9ravQj2ylg269Or6g+oikqO
 a87hfMvIFSUdbb0uzxjVfKXEM2rcJbDZJFHxOJJfy+HneYKJLMuIyOmniYaRlsfnQ4bYmG/Wc7p
 iptjLBaJhF/gl6li4qceaSXCex57fqK3CWBwbpHK7hOr2egZe5DTH97b2Lz9slPy+QZICxqaHYL
 7Te8ko2VMQr6Ih8hjdr0+kigAbSBFFa+Rj4MO5lsDyoX70rwtbT+rJKHcq+31DMnU0nlMKEOzr4
 CMcCo0IpvSCmIuS+PVyAL7fuyNEjQm9fYKZAOUKIAEEhmxvT1jdBASYXn5Gcl0U93n/ljbDGjW5
 LZVRmTg87pFj1dhoGvF+Hn9ORPofF4TxYrAGOswN3wtzHuEpsZwa6jRlUvMQUcl4NpvAUdYbBll
 nO5YHtJ1efZQrOb76m6XVKhKVS8f9Na0VIU7E0EeS8A1u1q6nIlM2ALzCl2ci871VHCe8OgNIS6
 Ztjkv54jhD4m3+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252836-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 34D7075B79
X-Rspamd-Action: no action

Extract the message fragmentation logic from write_msg() into a
dedicated send_msg_udp() function. This improves code readability
and prepares for future enhancements.

The new send_msg_udp() function handles splitting messages that
exceed MAX_PRINT_CHUNK into smaller fragments and sending them
sequentially. This function is placed before send_ext_msg_udp()
to maintain a logical ordering of related functions.

No functional changes - this is purely a refactoring commit.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 82c232f9ede24..e37250bf495fa 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1876,12 +1876,24 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len)
+{
+	const char *tmp = msg;
+	int frag, left = len;
+
+	while (left > 0) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1899,13 +1911,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			 * at least one target if we die inside here, instead
 			 * of unnecessarily keeping all targets in lock-step.
 			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
+			send_msg_udp(nt, msg, len);
 		}
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.47.3


