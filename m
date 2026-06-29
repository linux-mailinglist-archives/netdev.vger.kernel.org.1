Return-Path: <netdev+bounces-302816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 505pBbLKQmo8CQoAu9opvQ
	(envelope-from <netdev+bounces-302816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:42:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2D6DE780
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:42:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=WZ273hGX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09913039892
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D43C10A7;
	Mon, 29 Jun 2026 19:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA633B42E9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:42:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762153; cv=none; b=YzK1LUaYVV9SacFqEZBLhmGiFtuZlsxE+1y7VZ7I5iX/22yosgzVO0ge+yieGqIL+4tjgRp53ZAxd26OkHwnhzBO3srpTX/2k1I6u8ZS0NadMZfB3ynKQT+4sQ2i3YjF4WzE+Kw+Wp6vmSx7enwKqYfrX9TchXNFTz1SkFWviQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762153; c=relaxed/simple;
	bh=iQfIYpwKRdMJy1a/rEWr97wL5aBe1iET1JEYChP+I3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5yh8mJoExAIlWqO+pu7Z++mPUiA3Q/FNxxXSsk8ECyeb7pyW+BRO0NnjHPh3gIe2HqK2b3z+IG0VNPIwrZBwpWfh8BOaMzSingp47KnbmYdl5kjrKgXG6B4VHwYp1ggnRbyCvuHjVmkW8dYdqIp0BZqL1ZV4+j7gsuvBFN5Cds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WZ273hGX; arc=none smtp.client-ip=195.121.94.186
X-KPN-MessageId: aa60ef0f-73f2-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aa60ef0f-73f2-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 21:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hku7+dnRaiVh1NM/qXbJI8Zf9gVv0HH2UBe/fZ82O0k=;
	b=WZ273hGXp03+FKSSyaQAaMEdUswtfTn2b0EzukA7/l9AZDqXW2sLy+cKfMj1cVp+p82YB6tjYO9FZ
	 bLTRQA2A50Uw43YCNGsH+4aVEpF/66SbA2U4JDOX0PJ+ANIhR/mPh7UjjomDMuhP6SCX2P+K62sWU4
	 zDZc/rWaLVFPBWfToxcnjCJMQXdeXot6pormsUqlG9ew2sjnR9u4VEUtF/FeuLaizm5TzCZfnPt8Tj
	 /Qy3ApxXzARDNIbmsA0Zu/kp5xQ+BKqCUyhU+WIuU8vl73KjcROTffOOjPpX2g1OAWvRQwmwMGuOc5
	 eK7Xz+A37X088jNJ3VXKLaGDUSGdqkw==
X-KPN-MID: 33|0C3WjuoC7fcDt4DX3tFEUDiET9bw8m0mRysKIUfg5clLNUEXDmOHmgbY1TS+W6v
 dbn2uNFl7g3/TFs/KsQIjuS51+5MwTX8MmE6fM9bxD9E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eJfPE4vLd3Z3OFLlEEN9Uxms50YEzpzckxJS0ScKqlv4r9VZ/zMCIJi6pOYKsX9
 acUZdQw+ND8ZKG77RbVrDPg==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id aa1ff099-73f2-11f1-8076-005056998788;
	Mon, 29 Jun 2026 21:42:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH net-next v3 2/5] vfs: add function receive_fd_filtered() that makes LSM filtering explicit
Date: Mon, 29 Jun 2026 21:43:24 +0200
Message-ID: <20260629194327.2270798-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-302816-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90E2D6DE780

To prepare for filtering LSM blocked fds received with SCM_RIGHTS, we
first need to know when a received fd was filtered. Currently,
receive_fd() relays the error returned by security_file_receive(). As
there is no strict convention about what errnos this LSM hook can
return, the caller of receive_fd() has no robust way of knowing whether
an error is returned because the LSM blocked the fd, or because of some
other failure (put_user, FD_PREPARE, etc.)

Fix this by adding receive_fd_filtered() which carries an out-argument
that is set only on LSM error.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/file.c            | 48 +++++++++++++++++++++++++++++---------------
 include/linux/file.h |  2 ++
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..2bc22cc69e84 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1367,6 +1367,25 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	return err;
 }
 
+static int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+{
+	int error;
+
+	FD_PREPARE(fdf, o_flags, file);
+	if (fdf.err)
+		return fdf.err;
+	get_file(file);
+
+	if (ufd) {
+		error = put_user(fd_prepare_fd(fdf), ufd);
+		if (error)
+			return error;
+	}
+
+	__receive_sock(fd_prepare_file(fdf));
+	return fd_publish(fdf);
+}
+
 /**
  * receive_fd() - Install received file into file descriptor table
  * @file: struct file that was received from another process
@@ -1384,27 +1403,24 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int error;
-
-	error = security_file_receive(file);
+	int error = security_file_receive(file);
 	if (error)
 		return error;
+	return __receive_fd(file, ufd, o_flags);
+}
+EXPORT_SYMBOL_GPL(receive_fd);
 
-	FD_PREPARE(fdf, o_flags, file);
-	if (fdf.err)
-		return fdf.err;
-	get_file(file);
-
-	if (ufd) {
-		error = put_user(fd_prepare_fd(fdf), ufd);
-		if (error)
-			return error;
+int receive_fd_filtered(struct file *file, int __user *ufd, unsigned int o_flags,
+		bool *filtered)
+{
+	int error = security_file_receive(file);
+	if (error) {
+		*filtered = true;
+		return error;
 	}
-
-	__receive_sock(fd_prepare_file(fdf));
-	return fd_publish(fdf);
+	*filtered = false;
+	return __receive_fd(file, ufd, o_flags);
 }
-EXPORT_SYMBOL_GPL(receive_fd);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 {
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..748f08470bb4 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -119,6 +119,8 @@ DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 extern void fd_install(unsigned int fd, struct file *file);
 
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);
+int receive_fd_filtered(struct file *file, int __user *ufd, unsigned int o_flags,
+		bool *filtered);
 
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
-- 
2.54.0


