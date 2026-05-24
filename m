Return-Path: <netdev+bounces-291205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFuELuMjE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:14:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 216FE5C30F8
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F046300DE25
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484133A8FEA;
	Sun, 24 May 2026 16:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CF3A63EC
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639149; cv=none; b=MRXpg1FPG1EFNx4PfSU+/rV5VKMM+pU+a8fpAQrv8C59+qMDoqgAjr7QjmkLbuw3AA2WV04QklO56eZJ5x32Vmrc6W6JVSgZ7tZ7Xfbixr7kaulzhjYsXLz7Q8EUhOgfnzlno5pI8QG3sBZfpaZz/2fU4I0iQ664/lnZAhRssAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639149; c=relaxed/simple;
	bh=GNE2yLcVmAnaMs7p03niEqNRSstWxlcBl/ztKs03sM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLIHxC9XqU2ACJBaphIu+xJbRp5ku44BRZ/dyCuyxotD3gOG6KAsn62tNzCDvsLd6rjnmOqBNGQLyxwLmjvLeAGmZJHsUoE2cKqCUySrgo9dzDYC7TgRIl9ZjjO8VkdYM4IHYWdkZQ2WTgP+yI40bMb3TjA0Zlzv86/LY2Cu5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43b7e186a0cso555284fac.0
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639146; x=1780243946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25z3ic8/Pkx2AcYB/9aDrA71CiSAFUJRzNWM3+IEVSA=;
        b=YYgdzVi8NomojP5sXgcLrrDO/rLjYGSjaMh02VBgqae5A1Vruvs8ST+4BHKDWd2G5Y
         ceSep8g0CzyefT3nk1C96KKGtPmkc5hTEtN0LguYdSfxcuPoJPGYsVeMhq3lLpd4NjBu
         o0DuRRY/dCeQJDrl/62qpLYhI5kEHHrNBUvBPZAgn9wrWiE6eQNwm7sXt62vZNaFKGrc
         Dm49TawjAcifaWGaOptaQtApV5Igh/UDIJZrPoGHsVbZt6b0vUGvWSbkxwqInOcLvEJk
         pwsoe1hwCZanNRaKoTTsKc/WBTEMQBn3LL3xsJ88XzpcEG6cJgymQ8GbOP8QRRtFQuEa
         xEkg==
X-Gm-Message-State: AOJu0YwNZbTk9qDySe94MTGnwAC6rczR0qnpDVx55z4opST5FVgQvG/9
	vQpQr9vQ6tdxFYPxP0VyJ55iszpCRigUHVr1YzII6h0OZGxeQ7mBKfLWo9lJMfmW
X-Gm-Gg: Acq92OEUSbLJExQuHHH/sXVdCEU8z4i3mpQyv8hWMGNkmHXNfFwD9sms/XUgjT2Xx1A
	pER84N3RlsFHz1F1U+5z49GL+f4wx0qLFW+8ud7VVxX+NhCmWpEI7qOSkY56Icfwi9dwfjA+XPg
	87MowbCD+3VRvHihNCa6akfwpyNt0M67BNbS8Q6KE+sWmAe6aoO5uW9io9Af6HfkL8psFEa/hIA
	BX00s9sIIex12GRDXyvRygyrZHqP0gcqurz9JkhKLr/mfceqjTqSpAp86yD+d/UfSxVinWoyBhY
	/KC+lwFdRCh8t9xzXNPQJe2TJo2sFriXLvnVbbI2LGHXm96acNRyaVIoDHqtJjKTSsxRWB/yimJ
	m7Ah/ds4d7iewXPY5icxQ37X98IH7oFSaWb06h9WKIt3AaQttPJlIQWw4+lN0iZ5cEbrwtGEXdt
	KXkhvAUram7izB8d1LRTNBJaFK
X-Received: by 2002:a05:6870:d36e:b0:42c:1a8e:7f84 with SMTP id 586e51a60fabf-43b5aa16546mr6645847fac.4.1779639146237;
        Sun, 24 May 2026 09:12:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm7646019fac.2.2026.05.24.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 09:12:19 -0700
Subject: [PATCH 3/9] netconsole: move refill_skbs_work_handler() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-netconsole_move_more-v1-3-909d1ab398b4@debian.org>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
In-Reply-To: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=leitao@debian.org;
 h=from:subject:message-id; bh=GNE2yLcVmAnaMs7p03niEqNRSstWxlcBl/ztKs03sM0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlGC2QPKnSBTStkOWy5dirRvVJvuTsmZ3pc
 YFnsdXAM4CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bV3rD/4jNzFbGDNiwaiK+mjIptKK/m7rF/fDd/zwoeYN3L9Pi78WqnYyO1ze5Pgd3xjZUmiqm7m
 sz3wTAeiFAa56IBZIPby+VRSK6FaSd7N49zhpm/U+VJBilNJVxPSTrXKoe6SQ/WwpOM3xXH3FGS
 OhBR/367FVsyCfV/9LVRfHbFd5BHfPABM0hPsFoJaJc4E3V+UlItpGtSB9u74/7ylbU8cIKMphU
 yTETzpz+47z50B26TZUA4gptEXq+D6/Xizj8Igiach4sancEsnOEoguwn5hXRGgZ80VTyWPwl9d
 dCZI0SN7MwiKvZRTOaAm5wyx8/eQs+uWeIrna+xc6A62OV2/yamuHch6MJMCuFMmWA0Mn2Addlk
 UyJVrUN4RV9FqZuZcu5LQvUrNnj0Dgrnvt8F/yhYgsStghMaFLG9QbkhpFoi0YptXX7o7hAGQAq
 5yR77IUzlydlWq65z0nihjauio2Jp5SZUPZ9V2ztUC74A/tzKduyHSSL5Mu014AG4hAV7TAYPNk
 fHMbZ19UmXE3ZdctppNiWNa7Xuuv9+y1omLv1uHkQ3Xteu20s/gV5ZJaylT6V6+SbhtwNPlTehM
 bbjgQ3uknaFyB8PHCs8DB9nWIoigz6w26pQKCqmzkXAutQtq9M8Q667S14EaRe4TFgOMatZgtbw
 wxfSQigWVDPxQpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291205-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.766];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 216FE5C30F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The work handler is wired via INIT_WORK() in
netconsole_skb_pool_init() and has no other callers since the
previous patch took the skb pool lifecycle out of __netpoll_setup().
Move the function body into drivers/net/netconsole.c as a
file-static helper, drop EXPORT_SYMBOL_GPL() and remove the
prototype from <linux/netpoll.h>.

Pure code motion: the body is unchanged and still calls the
exported refill_skbs() in net/core/netpoll.c.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 8 ++++++++
 include/linux/netpoll.h  | 1 -
 net/core/netpoll.c       | 9 ---------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b84de3ba44c3..3d7d17c59902 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -283,6 +283,14 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
 }
 
+static void refill_skbs_work_handler(struct work_struct *work)
+{
+	struct netpoll *np =
+		container_of(work, struct netpoll, refill_wq);
+
+	refill_skbs(np);
+}
+
 /* Initialise the per-target skb pool that find_skb() falls back to and
  * seed it. Pair with netconsole_skb_pool_flush() at the matching
  * netpoll teardown.
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 9fa4deed0bff..1a497d12f336 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,7 +75,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
 void refill_skbs(struct netpoll *np);
-void refill_skbs_work_handler(struct work_struct *work);
 void skb_pool_flush(struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a4d176ff9376..4111d6ee8d4b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -367,15 +367,6 @@ void skb_pool_flush(struct netpoll *np)
 }
 EXPORT_SYMBOL_GPL(skb_pool_flush);
 
-void refill_skbs_work_handler(struct work_struct *work)
-{
-	struct netpoll *np =
-		container_of(work, struct netpoll, refill_wq);
-
-	refill_skbs(np);
-}
-EXPORT_SYMBOL_GPL(refill_skbs_work_handler);
-
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;

-- 
2.54.0


