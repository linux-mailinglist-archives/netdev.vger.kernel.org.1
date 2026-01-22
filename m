Return-Path: <netdev+bounces-252309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEmsBXAXcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:26:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D9669AB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7102B704E61
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8E4418CB;
	Thu, 22 Jan 2026 11:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1143E4A1
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081559; cv=none; b=fKkcT3YJj2vJKVSVMT831Kpz0Tc9eE/hwbAzp2WzqLNFRgNfiX/fGeGvuHrla3yjSbd7BRvZEEXGsOgZIGDeDbcLxPLZe7GDjO/LzLTuo09xZ42Ehm+cyPQ+JqDObBRlueOZfohpJdOW1Z6kLn/sL+WFUlsbw3zr+6L0uXWczck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081559; c=relaxed/simple;
	bh=Z/eJKP6B+lnkveHqwQ4bU1op5TiRpJyESUvmwsOC3jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLX557kNJpdfynB3DBSypdApJJIvQ974ehkQu2mz4qeXarT73vZm8saCDo19hexIkLtT10BdvswkUAv8259UkR+tmKMLkNzgQJ3aBq4kHv6H+xZZYNZELUacMcQ9/op7TxkxgDuTEtznc+idXLuzIx8XUSu4A3MwCwDStpvYFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-6611ca93e45so421836eaf.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081557; x=1769686357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+yubY1RUIwnNaWbHs00xTytVNqcEoilttntzBi5GkM=;
        b=xJ4zFpvFg1XFT6HrmRd6/dAHUoFyH6S7HeWAJmxnFk4DbbcaIRrjOzBlDCE0Sl+n8b
         ymvNY9K4aow19kE5j9zyOv6jCLuzIbw8Q6dN7wORAmS5UGh0QnTjiqj62b5fdZdUHS+T
         ERiOmA8myWCYIsmbXPdKC67Yb5Ac9k8h1dJQRYQGIviRj0ThXForObSQ9pzJVeOUUbYr
         TPUHZZW6FDSIsdoppNLnTV7HgZkazLEwgRm51q6lSVyI0IObbsJGQBcVDnvolaL5BDpQ
         NNSUuWmKhkH5ECG24PhpuVRlSUx0O5mzSj83fStUXBbEQ066BIvqc7PpYoQmulcb/O77
         3tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXGHhT7pnBHn4IrpcYcRVMUWDguRRo1VqumMkV/ZKqaprXCjeDGE+sn+5TYrbdwdT3Hka+ohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcEBWhARXsWoitqAyOSQ1yWouuvlYy5RmAsdp4idFQColWIrI
	ZvaU7/kjKHnJZpeC6NTqfrdX4DlNHzrhvACMwTAiUbnSCXENwpaJq+OC
X-Gm-Gg: AZuq6aIAHuD3HgcwWQzG/0e3HNpvY7k77z5rxN39hMjHtCaUqAw4vrUO+N/5QAt9JZv
	uRSSAZn6IPXQAvhP1TwBFN45p+s2aTyQh0NOxSfBSAsfYCWJVVPpCsl90xIx97ZAYntU9L/Ybej
	U6DAt/MHpFi9ZUC8wFTdmUoDwnLST6o0BH6Tg9h5l927isb94zIxNQXQv4/6QiGwcAwlpMjRhrw
	iuZVIgOV+4s3OKU86SEytAhvRUZv8xWYRYvEYxl2hwzBYfmUONIhCnKhCePyXbLIY4vIE08yMfn
	qSzheFz1vESkZ8iWyfsiooz2qvHlmV1wSRM6GRSuNcOGREl9lSm3ItwFVr6wGUkSG1JHnB/86RQ
	L8pKXW2u2MPYzpY2fEb//EVwBK1PSPwWIxCl9eTl+E0MjgfIMuaR9eRxioz6e4tjG38Wm7CKV9i
	R/
X-Received: by 2002:a4a:e908:0:b0:662:c63e:986e with SMTP id 006d021491bc7-662c63e9d06mr761960eaf.58.1769081556613;
        Thu, 22 Jan 2026 03:32:36 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-661186db995sm9049168eaf.5.2026.01.22.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:32:36 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 03:32:13 -0800
Subject: [PATCH net-next v3 5/5] netconsole: pass wctxt to send_msg_udp()
 for consistency
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-nbcon-v3-5-a722f2f0dfa5@debian.org>
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
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z/eJKP6B+lnkveHqwQ4bU1op5TiRpJyESUvmwsOC3jc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcgrNJwEagEDZlOhs0VR/nfajCiKHKHAF5tQnY
 56hwDjIBh6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXIKzQAKCRA1o5Of/Hh3
 bb9+EACKkTYZ0TMk9aLXVlMeAD7Jb+fz2tY68WcUiBV/BuWleRP3XTqC7hYTj5Ro66fgoIyQCnx
 nQ8PDjzPO86e4qrB6ZnH9oV5aegR8XVsgaPIaZ+v820K8qeVnPjqOTat6e03Na1sUbG8mfYRHoC
 8nzoRPZsxGwSgpOfPsEU5yEavlizJ8u5HcLglBS3gJFzAyzqq0ikVkRuyL8To5Xjsr9udpa08Cb
 e0Q5TZUqjaBb3Pu8FJe698lVARIF2NP66K6SjUORLFIPVggEo8J4mO558N10/6/Gez1zlGFhbjQ
 4HhbzZ4Wn7Kxe6mezabz2uZ4P9sp/tRgWF8v7zsqnKAZSeFmUYwECmaUvn7mawWvMoM4ytKwGme
 9zJjHvrI/0ib/aWW8hqXqAB5Om9ADrXH7sC4jTm3dgeI52P9sN+KD/fu4+JR29byiTqw8eEWNtn
 LC1AXSnzlAX6tKsRJBNezU/qEBG2F+m8udKf85F+/gde6JUxIBRhRpiRHwrNT3GAFz5YV+zJG7y
 xZYkvYgNTcxppM4w/D31b4J9Xf3ZAhKZ0/yR2T/Yj/tjU/R6YgkReBmXl7mTL76iBBS6AFDYiew
 9IMzzf/dMB9z898OFwlzgOYJfmwJVNtPQKqZSe3PeJq7naIc163FyJhfKT7UNZfFMlaygA6O63S
 Usf4tZKAJEnDs5A==
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
	TAGGED_FROM(0.00)[bounces-252309-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C19D9669AB
X-Rspamd-Action: no action

Refactor send_msg_udp() to take a struct nbcon_write_context pointer
instead of separate msg and len parameters. This makes its signature
consistent with send_ext_msg_udp() and prepares the function for
future use of execution context information from wctxt.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1dc53b749c75c..044ad1bc713fb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1715,16 +1715,16 @@ static void send_ext_msg_udp(struct netconsole_target *nt,
 				   sysdata_len);
 }
 
-static void send_msg_udp(struct netconsole_target *nt, const char *msg,
-			 unsigned int len)
+static void send_msg_udp(struct netconsole_target *nt,
+			 struct nbcon_write_context *wctxt)
 {
-	const char *tmp = msg;
-	int frag, left = len;
+	const char *msg = wctxt->outbuf;
+	int frag, left = wctxt->len;
 
 	while (left > 0) {
 		frag = min(left, MAX_PRINT_CHUNK);
-		send_udp(nt, tmp, frag);
-		tmp += frag;
+		send_udp(nt, msg, frag);
+		msg += frag;
 		left -= frag;
 	}
 }
@@ -1758,7 +1758,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 		if (extended)
 			send_ext_msg_udp(nt, wctxt);
 		else
-			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_msg_udp(nt, wctxt);
 
 		nbcon_exit_unsafe(wctxt);
 	}

-- 
2.47.3


