Return-Path: <netdev+bounces-252307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIxBBvkRcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:03:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F166597
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D805162BD3B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5A3EF0A8;
	Thu, 22 Jan 2026 11:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C23E95AB
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081556; cv=none; b=YmZec1IDHJ94oHyUZKzWmmIA4yImaYJcBaqPz3ayAl+t3SfJRmXZxqU5nXA4N+77liay0i4GPUj/+x/Qp4r0dN0HKfCDigpvBYd11zR0cs+lwWNmI3AwEOHS8/DvasArcJkj0v2HYEoiozNJY2SohjPOoycnXTr36QPGGjj+Vxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081556; c=relaxed/simple;
	bh=Hz1gu3DrXXHFmq3h1ZTNOZftr7Xlzo3ths2B7ZsBtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0Yj8GzjOKzQgAsP3wY/0bkVHNbNNmwMHUSdww41PMegOTyjGWGSptN3sg2WzJhPUneJJn7cYSx80Nbfg9oUoP/vIjht910RvQp2WwX5B7od3iJYGVKsxzXqUW8RI+0B/OXtDr/nqhQjmj2kOjBKfVROL0xgP2AA5yyv43Y/s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c8b850f96so567151b6e.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081553; x=1769686353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHAlKWdigu/dpowmiGEPP+hWTchneUXrrcu0qUva3LI=;
        b=uG1bmcv4oA7hzt97wMdyHYSt4RHW8/rNOktw0SJnAZ7OuZLggoiy5cq+QsWZAgrp/V
         us+9NrCUma4MuObVqMLGbDoYHg5u1JAYMvxyFfm8apP2n9I/cAlbqOHpKyMMwkgNmg1e
         q1zfVqqJZrjeqHYDlsm0EtSrucnmLuJPArQEttc9FWLr56u2X0uV8I8w0IqSflTdDqZL
         vuJCyd4TzCWGI0MNf+9rKU6KXULgelKkN/W/CQZFdmsp555Wm1tYHhQzgmzxK1uqvmVj
         4m121gedgQhzLZdH5fWQj/mqbGKHoh76itbCGcJuFKn5DGoyYvZkPiLAvXJ0tniMWe6S
         keeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7G0QGlp2bhbl8tMD5q/xzZQEklUEopKRCQ2K7UQWHqZimrXa+8cvDIBcnn3E2rPCWP3x92CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0hbxcFPSvDqat0AYkASA2vAzNzYy4osR2VIUo1YgqvTuiZxI
	0bKwwT86n0uD73qnRIGo2COgGbb+OcJ2i+JzF+ZyTgtH+JwSu7JLK2Yz
X-Gm-Gg: AZuq6aIW5JqHeT2cxTdwx5M5P0bmb8wtm5ugedc3+JCdIqfAlja9RpR9Xm3GW/NWWLn
	ykomcZZcBUQmNl8mUM7kxEOAVHFTOkJrLmWIHiGX6d4LVpqyAGXawnnN4JHMBd/6bO/yoaoh+Du
	l+8IV7gpy27nGO6Sg2o6bxd/jzSRguOiaemwwGLk057YOfTS5AUURcCqJrQO6yovu51vjAq2BGf
	6IxZqUlxIrrJVIb5O5AvcvzuyzFS8fz6HvbHfPn2l/CcQOBjjMTws7AIYDEdvzbXYQjGk2AAkNZ
	tjlMc1Lhctl1yZka/HepXEpImOEcxMEUFZH3TqFsIfhEbbGUMxG8PHw+cPWxNACSn43FWEB6L3N
	xQrgOtxtPpJiWw+WWWKAvw+prqF65dbAZqL1WC29I76YrfqnbsX48vsJz8g/DUxS7nYRBYoTAj+
	7pS2QDReqs2mMA
X-Received: by 2002:a05:6808:6901:b0:45c:881c:e0d1 with SMTP id 5614622812f47-45c9d74062emr10548102b6e.23.1769081553090;
        Thu, 22 Jan 2026 03:32:33 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e0086a4sm10160669b6e.12.2026.01.22.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:32:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 03:32:10 -0800
Subject: [PATCH net-next v3 2/5] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-nbcon-v3-2-a722f2f0dfa5@debian.org>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
In-Reply-To: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
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
 h=from:subject:message-id; bh=Hz1gu3DrXXHFmq3h1ZTNOZftr7Xlzo3ths2B7ZsBtME=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcgrM65kr4q4DiCJRkPIWZcOuT5I5mkopp6WFR
 YokhN3LVR6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXIKzAAKCRA1o5Of/Hh3
 bevtEACNY0e+WVQ18HdS1G6qyTCgDBgS+8yw11ndlh6PPQ+j8HzBhWVIvnAYPpEXRNO7O0J5hzf
 xRvXvnBMHEU4aPe871JRT6FDLSdXOszc6qM6xp5TLJp5p9mkJLCKfQIALmA0ihUukOfonjd6o6k
 eJ9kfb+QehJ/pkKr9wvAJPSI9d4oXfZDMnZR5fsSTh5KS49YmHN3wNM99KZQEsgsqSvvhfDisNk
 OmHzH9Q8kthxY1+Ui5dBT82YOy5iFP7j3/rfuAoSghJJIhZr/2xHlBESV1h49v55gmWzKVg1P+o
 8qnJLal+gECsuqIMu+TL/QOoJrI3jkS+0PXXs2pDy37TQe1CM7EHGdvDUjIvHdHGlm1zdwFG6xt
 V544D3FAVeFrexFPgRkycAQF6ZOjug6lZv3RP+ruSXnM+Fz4+I1CeCv2+jDhAkiDAAKJtmzggC3
 hYIs8+aGtuxXqxOwY0ilw7X49KCLw4K/PlmokITi6L6LOO8XDVzmtd/FotnWjmRbQMGj8BvA4tR
 vBKmNh4KEcSp/T9EahEmFs66gu9QoEUs8rZ2r9R/zX6+KfSQmqO/XZGXjAwL7Ci3AVkYn5GVJWU
 8XKAypyd5Q0Jj3Xq7/22FUw8x0deHBpg++aSC9TI+fecbRDTMkLtwdR+tUH9nfuoW6icgZQV3A1
 tIksNHQVnVXvxmg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-252307-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 924F166597
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
index 9cb4dfc242f5f..dc3bd7c9b0498 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1725,12 +1725,24 @@ static void write_ext_msg(struct console *con, const char *msg,
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
@@ -1747,13 +1759,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
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


