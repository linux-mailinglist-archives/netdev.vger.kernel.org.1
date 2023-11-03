Return-Path: <netdev+bounces-45977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B67E09D2
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80FE1C210A0
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F923754;
	Fri,  3 Nov 2023 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dd3jt6Dj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0622F18
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 20:04:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D5D63
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:04:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af16e00fadso34886487b3.0
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699041894; x=1699646694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QMKdjowp7LRFwMkdsEykv0oDUSNniaydMvB/qNDV4EE=;
        b=dd3jt6Dj3akEddQZzc3FJg8fvJh5554GF+4N3I8gAENzIzkKTVf0AVqW2ct6Fe0mZk
         +c6Bpgbv+fPI36orgHivm0EWxLAsx2AMlRPfDoiNfXouD3UlTzgAOLdN4a+w4fksu1pl
         /apt/Gqd3FGCXILG7oQyRmLUYkN0p0+/Bt/9tL9TKpj742MEt3z9CURK/mNgUKpEUfo6
         It9oPYMdAaAh8ZRNDAkkqWDg1sZWHOc8Fe2XnRBhWfw6zeQPB1Sv+MAAsVTglncdPp0E
         hC5P4O0swrniKM8I7kZgFvlRDOMm3AmDb+rUNaaoXXd1uYcDhAWuEkoxBBXXdBWt2AAP
         FxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699041894; x=1699646694;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMKdjowp7LRFwMkdsEykv0oDUSNniaydMvB/qNDV4EE=;
        b=oa4wSVuPCe7Z3T2KprRIG74M6e2hquJtBrRo+8qXxKYLd/Bhu9y2NG1ILIrsSr5Zpj
         Z9jk176k6shkbtv7N9nEbr6uFCrSCSqU61SddsR3Rp9dDyShWViB9iZNVYO5LUI3/Vag
         GNTbhZy95WXtfQQh6D8LG46D3QOCS29IyIDOaOnqfPj7VbIY8B1XqBfm8ynMovtCGMgO
         J7eFPZBJgcL087sPY4PN9/h8hApGs8GIu2ND5rGeJ9H9VZw6hbyte/52HYzSA0aUpx5c
         esVHRlhx5od9MbeYuQLCAsNbxyaqC6PtN263j+Kn9U4TaCYpydq1YamoIoIUq8X3qYlw
         Kckw==
X-Gm-Message-State: AOJu0YyBn7ZatcIvLIHsE+AlfKuB7otryPq/q3hcElMLrsWelDpdg6dN
	72G/khsCdvgCID9lNIuo4WIp5dACs39G4w==
X-Google-Smtp-Source: AGHT+IF3pQzjAXIf3Jdeg0mSJVFnHzsBBmEBOlx8Psw1JT/wAYo9VbuRsEtS2OtOPXnJjTWr4145xxX5DhzUWw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:eb0f:0:b0:5a7:a929:5b1d with SMTP id
 u15-20020a0deb0f000000b005a7a9295b1dmr78861ywe.4.1699041893951; Fri, 03 Nov
 2023 13:04:53 -0700 (PDT)
Date: Fri,  3 Nov 2023 20:04:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103200451.514047-1-edumazet@google.com>
Subject: [PATCH net] idpf: fix potential use-after-free in idpf_tso()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Joshua Hay <joshua.a.hay@intel.com>, 
	Alan Brady <alan.brady@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	Phani Burra <phani.r.burra@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_cow_head() can change skb->head (and thus skb_shinfo(skb))

We must not cache skb_shinfo(skb) before skb_cow_head().

Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Joshua Hay <joshua.a.hay@intel.com>
Cc: Alan Brady <alan.brady@intel.com>
Cc: Madhu Chittim <madhu.chittim@intel.com>
Cc: Phani Burra <phani.r.burra@intel.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Bailey Forrest <bcf@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5e1ef70d54fe4147a42e5a3263b73cd3e6316679..1f728a9004d9e40d4434534422a42c8c537f5eae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2365,7 +2365,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
  */
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	const struct skb_shared_info *shinfo;
 	union {
 		struct iphdr *v4;
 		struct ipv6hdr *v6;
@@ -2379,13 +2379,15 @@ int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off)
 	u32 paylen, l4_start;
 	int err;
 
-	if (!shinfo->gso_size)
+	if (!skb_is_gso(skb))
 		return 0;
 
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
 
+	shinfo = skb_shinfo(skb);
+
 	ip.hdr = skb_network_header(skb);
 	l4.hdr = skb_transport_header(skb);
 
-- 
2.42.0.869.gea05f2083d-goog


