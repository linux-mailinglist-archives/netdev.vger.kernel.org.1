Return-Path: <netdev+bounces-19247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD775A091
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B751C2111F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20A22F0D;
	Wed, 19 Jul 2023 21:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE322EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:07 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD311FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so1492357b3.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802146; x=1690406946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CoKCdu+fEVHU7QPD9NBjcftHMh0a8V1/HSMWoN8PDE=;
        b=ckGFCOi3LAcCaHYtsHviQcojASPlMwZrVDmagJ+kpoRrm0mU0urOoSAmDUBdCGiYlq
         Q+do2qRkGGSSVcaEHD0g7D25oSPGS/+cp30LKT89fE2ImuZzXaiqabZyTgwWxZic2mai
         TdQfLyMOQgCaydLN2gYDudRG7aQO+prDOjTRjySYPe9v1Wz7tcvRoRAjSLRcIEu7hJ2v
         lc7AFEBMwKt3YJspOunKBju/cQB4RMFaZ+p4lGkLBCGLuhOnJCqWS1DO7MfleJ+ajX8f
         +VktrmWew5dMJuyTE/7nsFVg7RVJ4l3SvxDRauKnY1OM3sL+S7jbYdhIQUdfMZehIAHf
         +PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802146; x=1690406946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CoKCdu+fEVHU7QPD9NBjcftHMh0a8V1/HSMWoN8PDE=;
        b=Jdm2h5OIkLuq372KbatIqwtluhOBVNBTPcWuDvKRNpIOvWGGZmYmZLkH8Y5QuIx+s+
         duY0nAaX/R6Ag7Mki3MMHQfHnn5fX4tmd+QzJ4qlLP9Pcsb7chG5Zk0+vrC2PeNf7n8e
         PTWp7oyyOePnpRvxbCh9UABPumKJY2UcXiXBAaeckh5a1jzd/o7kNzOqbTN/Ms471wY1
         ZLYmRjEp2Xzgj5DGTXqdwbnlxBHw7pAcJQxm0uHiyXcNWIO8sfTYnF/j3DzUFAeq0iee
         sjwTTzXnVwCfO4hpgidnr3pmeohBqn80880hXAunFA4IQ9ZjcNTDCp1Mowwoue/p4rOT
         JVjg==
X-Gm-Message-State: ABy/qLb2yDxYZXxBlHNmDsbjeKCQSobt9b0oqw7sesRz52wvTzPlaE6h
	QqWgiT5GCBfsEp7lARTqipwqmRTR72XEpw==
X-Google-Smtp-Source: APBJJlF7lqDOrsxLhN9dO0fLwxY6THBM4T6Zk7URsNKXtcg+fb51S0mmOrw/8+ny/CvGotH83nPyrOQXzhcaLw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b2a4:0:b0:ce8:f8ac:c979 with SMTP id
 k36-20020a25b2a4000000b00ce8f8acc979mr28301ybj.1.1689802145907; Wed, 19 Jul
 2023 14:29:05 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:47 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-2-edumazet@google.com>
Subject: [PATCH net 01/11] tcp: annotate data-races around tp->tcp_tx_delay
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_tcp_getsockopt() reads tp->tcp_tx_delay while another cpu
might change its value.

Fixes: a842fe1425cb ("tcp: add optional per socket transmit delay")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03e08745308189c9d64509c2cff94da56c86a0c..bd6400e1ae9f8ae595bbe759ff3dfb1bd02765e2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3674,7 +3674,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_TX_DELAY:
 		if (val)
 			tcp_enable_tx_delay();
-		tp->tcp_tx_delay = val;
+		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
 		err = -ENOPROTOOPT;
@@ -4154,7 +4154,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TX_DELAY:
-		val = tp->tcp_tx_delay;
+		val = READ_ONCE(tp->tcp_tx_delay);
 		break;
 
 	case TCP_TIMESTAMP:
-- 
2.41.0.255.g8b1d071c50-goog


