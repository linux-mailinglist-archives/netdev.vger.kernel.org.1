Return-Path: <netdev+bounces-36611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE937B0BED
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A34BC1C209D4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC9D4CFB0;
	Wed, 27 Sep 2023 18:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1344CFA9
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:28:10 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF820DD
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:28:08 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57be74614c0so505195eaf.1
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695839288; x=1696444088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOy7sCbnNqQgGbvteCdWRECvuP3hTLAyMWSL0WbbTkM=;
        b=IAvwteSFF+y0gsj2e2NOfnBTqHMtbIsSw6n6HeIwXF3v+1OwCadeRltFNDqSw9OQhX
         F7TTC6lbfcy7X8Y4rrY01r7XW6bIw1ptEy/PHvmsIyDeV6pTlTumiapDcBZk6ED+68LH
         PPsItMAcygJkgSLemDgrlQJdEJ26u0sdQSLQ8fM2rJUgluJRC41BaxuTkdsgLIiLb/zk
         pPnFT77tcCWVr3nQAXfbTPO33xdAD0uwCItWs/W0hicCBCHy3rENdlbr12TJOhndkjFk
         Tdkw2eF5n2PH8Er4HAOM+l64I4yiNIlY/zON3bf9fWgr25HZsYGVF4Zk4NTWrWpqL4cZ
         0X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695839288; x=1696444088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOy7sCbnNqQgGbvteCdWRECvuP3hTLAyMWSL0WbbTkM=;
        b=ttBRBo9r0py6QkdvUbLh+qsUo/Bu5PBl87Bx541wwOW8XkCSwYLUj9MjeCjlKgu8HF
         9gJrEWp71iq3qErYu4xBr0AqHnELzIN/MuZ7DlQ8aXgO0oaZjxpSKfQsxksXiAnjGN7U
         Pxa3WjO8T7EK/BMWFD29tJ5gwwaR8bENx4VneMO8gqQKbvuQCUK71tSYmi9U8RLtz19U
         i5VONvSDc6+KUvyqNx5WsTD8Tk9FCUqeSOTL3KZpnDr9tiFwZ/LoWZLGIZ2JHyPZLoeG
         U2bmeVCJMrBtrRSLC0QesPrsa0xxYiBRcKFE75jBiMi0qqvG/hFp2dj0wCB288UdX10W
         NyPw==
X-Gm-Message-State: AOJu0YxF/r3XbxBnasvwv5mVUx0bh2zsiaUR46nwk96ASBm2V2LFDkO/
	/s1Go/O4snChYKu6qY10inQ=
X-Google-Smtp-Source: AGHT+IEAd54hFIbPv6Mq/SJitJHpP+h5loPQxf2z1XcvYoXEWQcC/Pa7qJPFlSZkSNlB9zYj/p+SGA==
X-Received: by 2002:a05:6359:a1d:b0:147:4660:372 with SMTP id el29-20020a0563590a1d00b0014746600372mr2534666rwb.1.1695839287944;
        Wed, 27 Sep 2023 11:28:07 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c2f1a2f6bsm11658599pge.41.2023.09.27.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:28:07 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next 2/2] tcp: change data receiver flowlabel after one dup
Date: Wed, 27 Sep 2023 18:27:46 +0000
Message-ID: <20230927182747.2005960-2-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
References: <20230927182747.2005960-1-morleyd.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: David Morley <morleyd@google.com>

This commit changes the data receiver repath behavior to occur after
receiving a single duplicate. This can help recover ACK connectivity
quicker if a TLP was sent along a nonworking path.

For instance, consider the case where we have an initially nonworking
forward path and reverse path and subsequently switch to only working
forward paths. Before this patch we would have the following behavior.

+---------+--------+--------+----------+----------+----------+
| Event   | For FL | Rev FL | FP Works | RP Works | Data Del |
+---------+--------+--------+----------+----------+----------+
| Initial | A      | 1      | N        | N        | 0        |
+---------+--------+--------+----------+----------+----------+
| TLP     | A      | 1      | N        | N        | 0        |
+---------+--------+--------+----------+----------+----------+
| RTO 1   | B      | 1      | Y        | N        | 1        |
+---------+--------+--------+----------+----------+----------+
| RTO 2   | C      | 1      | Y        | N        | 2        |
+---------+--------+--------+----------+----------+----------+
| RTO 3   | D      | 2      | Y        | Y        | 3        |
+---------+--------+--------+----------+----------+----------+

This patch gets rid of at least RTO 3, avoiding additional unnecessary
repaths of a working forward path to a (potentially) nonworking one.

In addition, this commit changes the behavior to avoid repathing upon
rx of duplicate data if the local endpoint is in CA_Loss (in which
case the RTOs will already be changing the outgoing flowlabel).

Signed-off-by: David Morley <morleyd@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Tested-by: David Morley <morleyd@google.com>
---
 net/ipv4/tcp_input.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index abe7494361c0..f77fbdb3103d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4511,15 +4511,23 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
-	 * The receiver remembers and reflects via DSACKs. Leverage the
-	 * DSACK state and change the txhash to re-route speculatively.
+	 * If it seems our ACKs are not reaching the other side,
+	 * based on receiving a duplicate data segment with new flowlabel
+	 * (suggesting the sender suffered an RTO), and we are not already
+	 * repathing due to our own RTO, then rehash the socket to repath our
+	 * packets.
 	 */
-	if (TCP_SKB_CB(skb)->seq == tcp_sk(sk)->duplicate_sack[0].start_seq &&
+#if IS_ENABLED(CONFIG_IPV6)
+	if (inet_csk(sk)->icsk_ca_state != TCP_CA_Loss &&
+	    skb->protocol == htons(ETH_P_IPV6) &&
+	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
+	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
 	    sk_rethink_txhash(sk))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
+#endif
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
-- 
2.42.0.582.g8ccd20d70d-goog


