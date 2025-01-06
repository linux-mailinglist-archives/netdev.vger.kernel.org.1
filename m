Return-Path: <netdev+bounces-155550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7022A02F3C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4901884916
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154601DF263;
	Mon,  6 Jan 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpCTsWax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673481DF73B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185583; cv=none; b=lVtqv8utkSxzXb9B09X2yYxXWgiw2vBJABAkhmKDCnRNoZzXrD4/wVTlg4sVofcFq1L1ar737AJwzWOGgRCDXoOHMnuKn8XjI32tmqOP0UTpYGJftkCnVQfW/EUjNYICAk7GoTA8gnd1cprHmWZBDEd3+QjCH6BTPuxpdGNQkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185583; c=relaxed/simple;
	bh=uW9GkYu5gQtwFMIjKJhUpF82owJOz8+dxzEqPIHMP7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzZcarZuUhWB2kdsRsDoKDbwSSAAr9ghYwuW6+08WIMAvH9K1ww1HB6duts8vKT+YOypluAWR1eAX0u5qnXYpN0myVFiEgl0cdpNEW5m8GvAZdINdAFW6cJVtvAJ16EOiDGPLjNnGMkSo7KczH2JQnEUdu5/XuHdldsvlXGohuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpCTsWax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F717C4CED6;
	Mon,  6 Jan 2025 17:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736185582;
	bh=uW9GkYu5gQtwFMIjKJhUpF82owJOz8+dxzEqPIHMP7k=;
	h=From:To:Cc:Subject:Date:From;
	b=EpCTsWax3MMH+M1GHV/LGwpBjuNvSbMvL3SV3rbpiR71QjBMoALI7mTK09bK+FwFY
	 QCf8LUW4D8SI41e1GVc4wm8NXRfwPP0ilZMHQG1CxOIsSoe/56KCoyIGCrMzQQPs/a
	 drB1jCJyN6z5c3yKB/bKJLpSxv92fmOZInvfLL17vtn8ukNtIGYTZC76xGQ9Wci0tD
	 0sjxc3sE/tnnyCz54TnFmZpQKHrTrCWJ2bwcB/EfREYteiIyyPDzuFd4G/IyLoqaV5
	 qoDWShxdGNEQBBFneAVgtLVP0CDiS9hZxjL8tzw+rma6q09QMG70i9mR/Ilh9g3Cmd
	 RMpFJfdSR1Khg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] if_vlan: fix kdoc warnings
Date: Mon,  6 Jan 2025 09:46:20 -0800
Message-ID: <20250106174620.1855269-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While merging net to net-next I noticed that the kdoc above
__vlan_get_protocol_offset() has the wrong function name.
Fix that and all the other kdoc warnings in this file.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/if_vlan.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index d495cbdb52cb..38456b42cdb5 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -176,6 +176,7 @@ struct netpoll;
  *	@real_dev_addr: address of underlying netdevice
  *	@dent: proc dir entry
  *	@vlan_pcpu_stats: ptr to percpu rx stats
+ *	@netpoll: netpoll instance "propagated" down to @real_dev
  */
 struct vlan_dev_priv {
 	unsigned int				nr_ingress_mappings;
@@ -414,6 +415,8 @@ static inline int __vlan_insert_tag(struct sk_buff *skb,
  * doesn't have to worry about freeing the original skb.
  *
  * Does not change skb->protocol so this function can be used during receive.
+ *
+ * Return: modified @skb on success, NULL on error (@skb is freed).
  */
 static inline struct sk_buff *vlan_insert_inner_tag(struct sk_buff *skb,
 						    __be16 vlan_proto,
@@ -443,6 +446,8 @@ static inline struct sk_buff *vlan_insert_inner_tag(struct sk_buff *skb,
  * doesn't have to worry about freeing the original skb.
  *
  * Does not change skb->protocol so this function can be used during receive.
+ *
+ * Return: modified @skb on success, NULL on error (@skb is freed).
  */
 static inline struct sk_buff *vlan_insert_tag(struct sk_buff *skb,
 					      __be16 vlan_proto, u16 vlan_tci)
@@ -461,6 +466,8 @@ static inline struct sk_buff *vlan_insert_tag(struct sk_buff *skb,
  *
  * Following the skb_unshare() example, in case of error, the calling function
  * doesn't have to worry about freeing the original skb.
+ *
+ * Return: modified @skb on success, NULL on error (@skb is freed).
  */
 static inline struct sk_buff *vlan_insert_tag_set_proto(struct sk_buff *skb,
 							__be16 vlan_proto,
@@ -582,7 +589,7 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 }
 
 /**
- * vlan_get_protocol - get protocol EtherType.
+ * __vlan_get_protocol_offset() - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
  * @mac_offset: MAC offset
@@ -808,9 +815,11 @@ static inline netdev_features_t vlan_features_check(struct sk_buff *skb,
  * @h1: Pointer to vlan header
  * @h2: Pointer to vlan header
  *
- * Compare two vlan headers, returns 0 if equal.
+ * Compare two vlan headers.
  *
  * Please note that alignment of h1 & h2 are only guaranteed to be 16 bits.
+ *
+ * Return: 0 if equal, arbitrary non-zero value if not equal.
  */
 static inline unsigned long compare_vlan_header(const struct vlan_hdr *h1,
 						const struct vlan_hdr *h2)
-- 
2.47.1


