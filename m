Return-Path: <netdev+bounces-251541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMsPG0fYb2kKSwAAu9opvQ
	(envelope-from <netdev+bounces-251541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:32:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E92694A766
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E46158C53C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527044CF3E;
	Tue, 20 Jan 2026 16:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C444CAD3
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926251; cv=none; b=u9O3iKV3MJNo1qVTeg6lpS8UMWH6Twu/trDEYUFx7/NNEz/kYJ28dIZfqttbVQRA+cVTjinKJooxFLeU9IggNmPluMmersVk2i3amgJZ3IwsfOInWLj9f+4yDUF2KNyZxa+1ulkim9FVIZrO1U75/Ep/dVNcpqODMM51lWVmkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926251; c=relaxed/simple;
	bh=Hz1gu3DrXXHFmq3h1ZTNOZftr7Xlzo3ths2B7ZsBtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rf26gMR0ApnLcKSeBP5+SK+WG9XM70P429KITpFCHqSq9WPOVzwGr4n8psZ29QWHK9RlXgp6wZgTl90LJ3Ez/Qc3pbAnVt8X3fzUQPt86zIcDdHu39PTe4VJ9QhcSVaes5NfPXBWOffi6+qntpIiGYt61jdmDr7GfRw6NCTgOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfd65ea639so3247516a34.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926247; x=1769531047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHAlKWdigu/dpowmiGEPP+hWTchneUXrrcu0qUva3LI=;
        b=ghfBjexgKFqTg72TyVsuU57ZY27yH+lM0XMxBKuH1v1/0ANE1CjTyIBRk9VISpGm7R
         vMgyJxZsZ305WCl+8xG8leIAQcTW1gfzQnipnqUWoyzYIqTRTiuN3GZU8wgXlqFa/1gX
         Ly6sAfrIq7W9b2k3NLIETho92iKw++cNw9BNsAFi5/I02EoiabIvej4B2dmiUAHmhiix
         ZGQkjU01luGETsFOXBotT78LVC6gf7n1hjxLlyq5NDnJxDy0nVmzhzzQAEuFiYTjeRZb
         EHidc//XBqGMcp7g2xHtUTYC0XiJh8r4mR6HoxFtzYAjrQXJyZbmkWfexrQLkMUc0KuY
         i8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS/Vp3SQsC66cKyJEofwsYKfcual2uVmI3n+fgvUTnrC8KF8PlQWblPY2YmegwRSvXHtFhjJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKIZsmuVPM//ftJyem0DZvvbqdhIhaOyd3uB2l2Q9SUJBRUjT
	q/VNlZesavrwux27EHcu4y6GeNwfE3upfeLIpb3orrYhQUHdM6ub7iTT
X-Gm-Gg: AY/fxX4Z+4A0NihC3KwxFsjO/ltRT6dKX8f0QMsYvfw/QNCwZu5NlRnww43ypPC1TFW
	V0jwmwuc/EfvqXsaL5RcvVknEWb/p+PxxPgSWuScewNuFV72yNBD2ip/b+2yN7ploZapCB3JFXr
	keuthLSZGqwDZ0jhsArJatIbJqU27MjfzhI9eWCfv9vT9Tgs6AciMQWqb5rJcyRzGh0uC2oZTUC
	4DmAP6FCBxgsxgao+f+046wMIG/5L9fA2ocs0QX8nN75RqBVx1YorRf0dUzucGnL+OV7fvCSEvQ
	seBYiIxdAClE/c7AEySSMLoCTop/cDXCtz0+zDV6/nA1xrBdCKz+skk6kvEebBlY4Inej55mCEr
	DFa51Pjrs33t6Astr2MtM1xiWr3XAIQVUV3QJEYpLkb72CqHGvX6/UK/2fDo6mjX1BTa2eC7nY1
	cZiQ==
X-Received: by 2002:a05:6830:6d1b:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d140a53feamr946309a34.13.1768926246958;
        Tue, 20 Jan 2026 08:24:06 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a696esm8726514a34.21.2026.01.20.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 20 Jan 2026 08:23:48 -0800
Subject: [PATCH net-next v2 2/5] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-nbcon-v2-2-b61f960587a8@debian.org>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
In-Reply-To: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6wi3TDiQTF9DJsNQ9QEETZt6lE5D6Vdw7PNT
 gthtjl4HuOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIgAKCRA1o5Of/Hh3
 bax6D/4tsqHXFVNND9tXUp/J/V26ws2Cbx4cKuDdSMTEXoz2sHCt1Sp3Cs0HTPr2+xuTKxsnZ7S
 5GKKmW/XRRd8ac05Ip8u6XmRktacbAqISPyX/vDZBXqlmdgYarZ/5C7qrsm4RWIS74yG3wytKoB
 BMj48ACCD+7hISk6kvuEibEHKhFvMNOrHP/CWRZVU/8RdwjOH2k3ApqE6/WGoaIe8s3oV+CL8A4
 GI42LqfsI4pa4OAX3hz5lVIRqP5ClExWc6NWbOrZU6J6QqryOe68CY8y+hAfw0BXaxvqM2GtZFh
 YcNyreegZG3OgamqKC8NpyoMm8mVGm3gnzmI/GWYXzCPvwL3s4JjD7xj9hF5U4nDkXNdkoY7JyC
 zv5ag/wP5gexMc7ukhVxIXf07HQcadyA2dCTOPu1YsVGzGDx1eA+xTOaa7fEfEWfYN9E/ZHfObs
 4pt/50J8/5CBjfNeruZBMMfJ/7sEOJKauEqOVy+9KIco13r31HchkvSOs1cr3lNRDnl/U5K0+FQ
 eKVW5Dx5sxykORH9Xjeqfjp6uoTtPuNCtoUKbL4jGlYjRJS7b1XaKdvfjeCLHsNNZMYW7iQuPY7
 pYoE8+VWKUA8hF8NvivNuoLZSTT4Uu4k60btYF12u/ACr39ilH6NTv+Mpux1LbD1mFNaJblG7Uc
 P74A+PTee6APNqA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251541-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: E92694A766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


