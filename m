Return-Path: <netdev+bounces-242581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1691AC9248C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 921AE34F95F
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37E303CAA;
	Fri, 28 Nov 2025 14:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F572459FD
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339660; cv=none; b=MW3BjumcgZCB3UVsv4Xxz9Jcgg84XLQ/Cj5ODDTSUwGNAUC1NhnBexwoINpw94Q6ip12fA+9EOBBmjdpsLT8rSshsaGHlmC79C13Q/FD2XXzwHpO05ne1GMrcZ5rvomJyP44ULdefnbXz7XwxoTBW87AMYT7LlSFaijzwQC0Epg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339660; c=relaxed/simple;
	bh=8AeeNuKarsu5qA34c7lNeF8QhulWBTrnEQ0CggOIbSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPZngXk0tIuSV81iC1AXwevvfQPo+D5o09oRMbjdE992kDoXzJtr5WoLEZA6DWH1zoCYb+i1BBy5sBOvA95u69X99SB8yAORYPoW0h+MWXnlAUhO/giQ0aYBEjMBz3+5z3bMYpYzCVEE5dHfnmKC8rJKc9Au1Gv9a4ObLymJRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c52fa75cd3so1394112a34.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339657; x=1764944457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IO8fpf+Qe7KA1hAphkMPr2BDEzo3Q3M23aOQSgVd6Z8=;
        b=j3eK7I+KlwVlpcdrRJp+r259Q0/WmBGqT/XjkYcBDZPU+aja7GccH5319t3FAy9FD8
         u1OuFMQNooiTVxJ/E1TSkHPFVlg8rxo77Brqxvhc7pM7gXAj2PTGz60I1VKgunpBYjG8
         kiAh4QV8QmDKE02QjqYv93CEBaVg2BYd5V6KPJAXKr+ApdBzHIWW+/rc8NB74xkNQqov
         Xhw6+BLt/6korJEFqimSNEQsEB2LBge3hjmnDLo54ooX5NZB89dIr4C9QdpqF7jDPSR4
         dXCFwxfuAJC2QuW3lzjUYROQ1u8+odB7WXUvlSNQgVxql3sZHJa/VHCarkZIZfM7Rxbi
         +FDA==
X-Gm-Message-State: AOJu0YxOXqHNjdBDXcvm5zH+Tqk+lqAAvIqaw0y717bg/1+aiLXT5BpG
	c9g6ov1MHMaEk84F6ytAjTt5Sp3155gZyTxFo4AtN/SOtH8lpGfJW/Fi
X-Gm-Gg: ASbGncvu2HzgwdBpkOBrAE2S234xL0CNtS6IrLT4JBcYU+8K72hepWKQiVwCecuh8HR
	h/32mfIFLJF0OHWVFuTazlWQu1sWk7lNJvqpuLhW+8iYnPdUDuTv+QRY8RJgZfJAd3umGaliWWx
	WXXQaAhUfpj7p+8L2T9tSucQ317CH9Q0sgmOlLQJkZSDxVbZUpVWELK2MaZuP28Pu78UZRZFVWp
	Q9yWx9p4t87amtksYCwr3GY0Vqg3zX8NWCBxAPI9H6i2DZrFj7tYD9VUeW0KJVD6qAAMMjnQKRQ
	hkzDCMP8m48JjfTBHOk8IHzjxpFBGvUUHQPKHVZ5rzQNMaHJTb0zRZoqURcqb8czZuWY0PylzQp
	NECkgb4sYXnOog5AfqopE0/IHlnljEFm9oqpewgzejHtaWgzO9g5IKURct8dO8wcjJGX7/It+lu
	XErNiSMctLCA==
X-Google-Smtp-Source: AGHT+IE8Csv0x3Otw25HTHmycCm8OmZBQcHgbovfIus9/bAoq/UixullE88axucO5VUxe/H7t0bIYA==
X-Received: by 2002:a9d:6143:0:b0:7bc:f443:fa3c with SMTP id 46e09a7af769-7c798de468amr11684101a34.25.1764339657047;
        Fri, 28 Nov 2025 06:20:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe0b238sm1586166a34.20.2025.11.28.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 06:20:46 -0800
Subject: [PATCH net-next 1/4] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netconsole_send_msg-v1-1-8cca4bbce9bc@debian.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=leitao@debian.org;
 h=from:subject:message-id; bh=8AeeNuKarsu5qA34c7lNeF8QhulWBTrnEQ0CggOIbSI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FePe42auqDY/Qs7XpYdwbHd6fJqLNwggTf
 H3VVdrUTfSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bWEJD/45t6CqWMn+sI2J6+MyW697ZsxhgZ539JQ7X8cHcLAwGA2l4VRPb+vljF+qZ6sV6BJCeZ+
 Tsxb08lgFu+44cvvEKSO59GXsfsKgGPRVe3obqlCcy99XLONvtOjT1WZRgN9L9h85HG/YzXOoeQ
 j/17CmNiqgeRNwjiZDCcgnJqbsUlWumE/8WoI+8lL+AibpkKcKkTW2Bdil74n6zYF1k2tWDB4Cs
 9trke+OdIrF4b47c3a91ZBxzdZi0918GKat/sKevUD7eDoQBrLOeQmiP+ZIv09pCBavFFquA86k
 ZPZg9i0CuRkCGQpwew0n94sHV78imAeHK6n+H8wKzKuBTgQ0hh+aCyU0X5+CIXOOMMz20jd6Qft
 d0H9qaOjkgbkP/t/YV9Up71zlF/DOlQDwEp1wDXtlH04PszFsRUhJ1VqDZksJLoAMl/owzcDQ50
 onheqsBZqT6IwvdImVa88fwcS+02optkhu9kSZQXt1u+TWJ87RcJ9VcRJ+KJIxbudo6oS8Is0Iy
 5cKccRhcZFN5qjxN0JfVJfVRMUfXRT5o5yGUYqw8TqiV/UO9KTDSy/tr+HuynBy0skfbitfVx8t
 bL70JidMIQe8IOrhsngRbjrw/PEnjEoPbx/JRtpotnia8TJrrLh+K4S0PfdLjcyxncZ6yUtRwQX
 Vg52jnE6T2U5QcA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the message fragmentation logic from write_msg() into a
dedicated send_msg_udp() function. This improves code readability
and prepares for future enhancements.

The new send_msg_udp() function handles splitting messages that
exceed MAX_PRINT_CHUNK into smaller fragments and sending them
sequentially. This function is placed before send_ext_msg_udp()
to maintain a logical ordering of related functions.

No functional changes - this is purely a refactoring commit.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..dc3bd7c9b049 100644
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


