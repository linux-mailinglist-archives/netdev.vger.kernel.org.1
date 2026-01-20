Return-Path: <netdev+bounces-251543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAHWLknUb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:15:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5784A1E6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D553758E07D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487644DB8B;
	Tue, 20 Jan 2026 16:24:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE44D02A
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926255; cv=none; b=R4rHESYYhgxrrpZWF6G2629+qliFaJaTaQgpTfoWXufW82WYbdxaaTqrHFuFqNCWDGrDCEVtALfGxtuk2PnkXn8eEfEog1A6K1+5vi5dO6QvmVRL8xtssMOauGDuMPGI2j8MRVyVovJEdLVnYu9P2M1au/1YroUyyiAV1c5RlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926255; c=relaxed/simple;
	bh=ZcGn2QU3A5rJ+BEvrbsS+gOvZYduC2WGaH1yDzJLGqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWF7RdRb1li5L5bU/ifmuNpkUwSdTSjgSPKI/mS99Y7HtAbwL6VBHaOASvAvTsxMIiEyuD3CoD3FZwEQ4whpU6ySKbP/a7aTYOsr9xju2EW5pAARBUrDWclUILq6FjTeRyaugta23O/ilOG1rSneiwNz+IJzKmO+hRhnAh3VkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4042f55de3aso4209564fac.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926251; x=1769531051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dl37PaPNvQYRR39f2b+lPF/nR0NSHw5P2RkhHNPahM8=;
        b=UTGShSzsRyxEWYeRGcjKyfJOT4tEfWvwMfSwdZkN3qjW+hPa2Y2L239ecGwTxCEw6e
         YMBdVD2YKxMJCq06/mZrVP5nbiRlpsTGdYUq3+GoqhvR/osHaDR3ZJuQ3jFoSGhq44TC
         6i12mn9GUJEPkcHJXSGAVx+NWR9tL/8YOTBI6GV3TvUbp5XVJimcU22kNFbzMJlKaOxs
         y7+hLxNKsbHs6SzuCRNWl5F1kCTv9uaNUSs3VezjAZnEgo4rVsOoWXiqBy4gOMUwcxdY
         cdblYWYGNAbiOoS1kCYV7JGpNztGP1pF8A2r1bHj4LyULL5DTMgIfrckhxOT3+i9mgUt
         0H1A==
X-Forwarded-Encrypted: i=1; AJvYcCXUVFWexkEmImQdc2stxZUeSbhwhrxu1QFyGW0Ulmaph8ZJp1c+hir+Mgb8HdoWBoA5+xShGQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSMftqdFaQ7x+qPpBVTwEXO+Nxv23xD/h4ky3Xmq5yx2UPaX4
	p8PrTvjpidxmCAQYrRToHlDoPJLchuj/InDG9/Li3QH110CxVLcX9+WX
X-Gm-Gg: AY/fxX6QeShQIGNDdPxnKOUDM1tMo+/mEbn63zWppHpSUawPu2vuEaBBX3EXihHjuUc
	rUkmv0pdBgTQlaUYWyLaxo1gl+BdtEAV+fevZbZN9U+/NJ1amixl1bsgvyWySTPuIHShT9DHUpC
	1IAh+Uax1J4ZlbpZAHqwv52VKkG4pcg/LedfMtj3yBoVjfkxPfIcHOPBzUk85aF8UxJk1LPuqbb
	Bob6bouBg0NrMd/jnvA/d95IWxVGbGaYizYxgy6A96HM6auK6KdJ92pq/NVoPTSbhLK/nOxQmde
	jSLT5QHowBn3ZTyRHXZJlzOj3G/ynskTETXAbpacVxJpJjmxvAcMyd0sUbYdlo1W3NUFfUXVKen
	zekV9QBr1stZeuVTG4wZsx+q4U7OFMLVCJF2xwx4SIFj01zhk5nocLNHdtHbxsHzvakPT2n694E
	q8
X-Received: by 2002:a05:6871:4314:b0:3e8:8e57:a40a with SMTP id 586e51a60fabf-404292d752bmr8953949fac.26.1768926250867;
        Tue, 20 Jan 2026 08:24:10 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044baf613dsm9050115fac.3.2026.01.20.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 20 Jan 2026 08:23:51 -0800
Subject: [PATCH net-next v2 5/5] netconsole: pass wctxt to send_msg_udp()
 for consistency
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-nbcon-v2-5-b61f960587a8@debian.org>
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
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZcGn2QU3A5rJ+BEvrbsS+gOvZYduC2WGaH1yDzJLGqo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6wjQnnyqrLMFLj0gu6gSbbc2cuzcIPOAgASz
 nT/fjibktCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIwAKCRA1o5Of/Hh3
 bT8PD/4jD+NSzKxWe9ZzPcZV+X/Op7hg0Wi05Sh/Fi8OGivZKnVA2ONjHLqvkCM4bjiodkN3kGV
 h3K9yBe4JG3njjEYczIi9BSJrC8mV8WZgQlx/zHO90JtfB0uyOh6F59r4NqXEbRfJ/kNX1+ldHZ
 3oeD91ZDjIM2SBmvt7l9gT4qb2z96D3pS0rtCp+/hg5r0eGJrs5W8gYtcDl6W2IX/6G3C/H82mm
 vig9fOhZFMpkHS4cvWVN+LywsVJLu+g1Y/1dJS2EbyFXQSTZ8QjgTd4tbg8hnAvVuflyaeOZirJ
 4qmi8ArJkCfXc2ubA2lmw7UCyherySwD84BMovz5suIlmFfRjOs0fwjT0sdPhfQZNxuJY3vzO5f
 0lTItYq6w8cgTCXgm6NgYFTZt7197x0jqPd6xpnBmxVH0wSriHegKB/PPW53qBHfrGgv3KbQMbK
 r+qm7W27LieDf4YW6Z4sCA0ECa9rs3x7wyZs3+ZMsIP/uMLR3z41MLc0og17I8gzDds5yKbynHH
 qVyMW/vvxFR2Rr5KejpfBbB1OO56GiOMUmwncI0VpI+xO+0dpZBbIrh2C+B2f7BMJFrmXuZB2a3
 EJXbjvOLOBGNHats0+tXJGzmkbX/XZ5SRMPdpCAyetnUxOhdUcVuZLWfWhLEZNBBGLhsevFw7Zg
 zm0TMglBinAC3Ww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251543-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AB5784A1E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index d89ff01bc9658..ab547a0da5e0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1713,16 +1713,16 @@ static void send_ext_msg_udp(struct netconsole_target *nt,
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
@@ -1756,7 +1756,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 		if (extended)
 			send_ext_msg_udp(nt, wctxt);
 		else
-			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_msg_udp(nt, wctxt);
 
 		nbcon_exit_unsafe(wctxt);
 	}

-- 
2.47.3


