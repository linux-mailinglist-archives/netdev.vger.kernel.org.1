Return-Path: <netdev+bounces-37134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334577B3BC1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B00FE2830AE
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAEF67272;
	Fri, 29 Sep 2023 21:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B67275
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 21:04:57 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC91A7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690f2719ab2so3296733b3a.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021496; x=1696626296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW8z9mo9mujkPmi5h0QC1IbfkXSpqDPhUDg0cowrpTM=;
        b=TcOkNqPT4AEhbdmoYeGivPRWRs+R/FmMHTl3dUBPSutSBDv2tQvmebo29Uz+dvuzaT
         eqPHaviMpAQS5y39+9J5Kl8CdrenPKhzRh16kBYDco4tXeWsl0JM2y5NQGkml8vW5AfU
         HDiRWuulhd45XWAa3Sr9dHNM1tAqqEd98tSJz1/kEea3UqDs8kcbfBEeWhXF3OuLNjus
         xpWx5P6+ngToFyoV7MwhoP8ma3D1xwx+FKck6rYAqavxYUaDgs/4r9ATt3S3yCOfDR5/
         zgyNpV4oiOGIXTj0twH3h2vqNKwvN7uTP4+haGoLU1dSiZm3Kv6ltdleyQ3DMX8x70B7
         VJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021496; x=1696626296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW8z9mo9mujkPmi5h0QC1IbfkXSpqDPhUDg0cowrpTM=;
        b=e8Pw2+emymMHNkC39Ep4Dfa3t1wjxEURCqo4/eHzssREDoxPBqdhpy0WIgSUgc/17W
         O8bOKh1utbk5W3nnQdwgFdnPABFfk/2LBx9QkCfcj0Aq5dSufBL7fEq/J4sJTABJJvFz
         Sn63TNtZs9wbsDjC3RpMfSYRPX9ooxxhuQBfOTeda7AqjehiEV8uKVwXIWz63GiiX1d6
         M8NNP3Mwin+QsOdu4FPPI9xaBbiO3Z8CdBlgOfaStEHK+DWsdkrrtdt6T6TgMbxjdM5G
         /CRGiqDT7hf/zneyrwC7W4wz25OMC07SD9mZIvd3qWO6u8n5jia1Ox5QdI8TVM04qxKs
         N99g==
X-Gm-Message-State: AOJu0Yzr2ga3pXj0xLMk/vHWE+aMb9CyR1gsNzT05N59Qj7ReXBsXFLh
	j7+HvVM14sMneF8DEBDcmqg=
X-Google-Smtp-Source: AGHT+IE2in8fktr4jLJq5D3xxHVbzTXdLBCAfHUufQUqoNO/YbETiDWG1D2XxKeP1ZU2nAEuMHobQg==
X-Received: by 2002:a05:6a00:3015:b0:68e:25ff:613e with SMTP id ay21-20020a056a00301500b0068e25ff613emr5065937pfb.3.1696021495806;
        Fri, 29 Sep 2023 14:04:55 -0700 (PDT)
Received: from dmoe.c.googlers.com.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b00690cd49cee2sm15431120pfo.63.2023.09.29.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:04:55 -0700 (PDT)
From: David Morley <morleyd.kernel@gmail.com>
To: David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	David Morley <morleyd@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v2 2/2] tcp: change data receiver flowlabel after one dup
Date: Fri, 29 Sep 2023 21:03:52 +0000
Message-ID: <20230929210352.3411495-3-morleyd.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
References: <20230929210352.3411495-1-morleyd.kernel@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


