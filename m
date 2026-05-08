Return-Path: <netdev+bounces-285569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNDSANZD/WlDZwAAu9opvQ
	(envelope-from <netdev+bounces-285569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:00:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03F4F0AC4
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7300A3033A82
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0725333F;
	Fri,  8 May 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="elYMhxGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C824E4B4
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205592; cv=none; b=gM5VxfGAWZbVpLsBhAJbZe6djN5gaTmwXWsdBQCYPE0c6gWLmv6R6HfTf1TwPFJUzNNIIlrAlvlwbCT6R4Trr+EaVC5L8BoyToV6BZ9IC+vXifxXL9jjTMU0fkEMdYdVFsYfmpAcemUfhU3Wdx9G0Plnd4eGu540prShA7EaY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205592; c=relaxed/simple;
	bh=OoNYBkVO32de2zHSO/KF+HizE4nI+dWFnqVhVZpP2GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St9K7W4Ua2wsXNU4RFOz9SzEp9IFoJuOj1TzWgnha46ZS2z8rwd0+3veO8GEqFwE/YgZ8swOhPKMqZLXFVlZREf+P06fApuASUkLokFzJ3xWZGzTjsnYdD7tlgZvK87GK++mdFYb8L9OqK4xaOzRHxD9sSGSxqhGpO0UvLw+rN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=elYMhxGQ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so947386eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205590; x=1778810390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=elYMhxGQlMKG7OCKFxjCcypS+liBmtvv25kO6fMO5J+EXYv71glPizDF8kldSFxCut
         NTJkPOJQ6n+eablmKTMAjDOwf5TuuK0LVI1Jx1dNvmlhpgdUlBgZvNmVaSYHZyT697iH
         pikvM+m9/rGymU6fWQoepEBsg87uUhEKwxJ3LH+xA0T9CHPlsLp9HBaWIpc7sjAA/b6c
         PP+XOSFcv95YI+c27xOdZAmedfl1s7yh3hBK46scweNUW8IOaTtzk9mCvXO5T3Y+Pdv/
         yO+CAlUSt9j0Ue/Pz50gBQJ+1BV+QB/x6kvcLlwcgcueQYWrnr0qRRTaNIBLApoJAyQa
         ifmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205590; x=1778810390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=iU6OcWQxcIvTzPTtC9jLJKuLPVU0tsZ1nFOc5fgWGSJtbpc6MgnSYbJrdKlLMi5827
         7RnQlPMBghcXCuWNcuGLPrV2QxntwRLeZQjbbhNo1ES4qiROjQ8a9vvEM4hA6nxI+Gvb
         GmIWKdNbc3Sgq8B8x3eVM81n0GDKx34jqXEYBhhTBmdRNjKufYm5Xtf7u7PuPzvo275l
         oGgfD0ow3TjhlKkXtqNtLeQznXkXV6juQKLWlDfVOtxTD5G9jJn9EdbfgzigT63QRDK9
         CgJQKCC4y3Y+ee5iubKGJyylaXtAYb2Gtp7jWt9D2K6zlFlHhZSucPfGgGhUGHCY1Za6
         KhQg==
X-Gm-Message-State: AOJu0YzedmP5OLwa1/rM55nVI9DkPGDAROex6tpYcIW257XPKoQ/uigJ
	bss+jtiOeYN1ar5nz3eNYMyJnojf7Ayr0eUOECvwXHkxajbbOfzhorbwebQgYCa0BiqpmPHeouW
	tDQ03
X-Gm-Gg: AeBDievd+SaerQMk/uwfcMi2GiQmMoC2TDqncVkU5VtP46/1Xg/tMSJ+eZirACsBwSZ
	PBbM1p/U1AP35grokRNvgS86HeXHO+dsOzG9NkZxOAmpoqweCb3Ox0nmMZgsDZz9ueM2XYSaXlk
	zPnzZ4v6XzsVTFN1SMYJxIXBcLxHEywFLbC5sSmZSVckJBJeWq+1+5jXpZnaaPNjfenIKUZx8kU
	xtNS8NMFX74EewObUoPHImQAc4sct19UolScw0wgTLBHKq5wBOiIu85E2datgF1x+Uzrx4BGbxS
	temdV9BdmIzyMvRgXwAOwD136ypAjp2Dfnw32IM8UcL9B3WjA9DcoF/usCf7CCH868bOSmLYi0Z
	X0+oAp6Bukuqqk/QtCkSbb573tHLSH3Hcjsy28GorKckekks6CC800KZZSRPhYwxwGKfUyjP2G2
	0dHxNP+FY3dHnObwnfuC7b3cIJhAZdcgwLOAPLAnUuVAw=
X-Received: by 2002:a05:7300:bc11:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-2f54c482e34mr5640845eec.14.1778205589738;
        Thu, 07 May 2026 18:59:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/5] net/sched: netem: remove useless VERSION
Date: Thu,  7 May 2026 18:55:18 -0700
Message-ID: <20260508015940.554462-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508015940.554462-1-stephen@networkplumber.org>
References: <20260508015940.554462-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C03F4F0AC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285569-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 616d33879fdc..2b0b5c032e70 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1413,16 +1411,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.53.0


