Return-Path: <netdev+bounces-127779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE59766AC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476FEB21379
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9BC19E963;
	Thu, 12 Sep 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7FqY+Fv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FD1E51D;
	Thu, 12 Sep 2024 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136742; cv=none; b=O41NiAwpM4/diSIc4CGiBiXm3UBc/v9un3ty0wg+oIduPzXy8siOlzt2SMbR6SmVJ66rt6o2r/N6VF1Q7Ux5fWlu0470Owgu09gmmkMAGB0tm9cS5+raL8epzSN0Zb3eijwkJAgcoJyEvgIfrWT7MAYVzOWVd24jh7Ala25rVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136742; c=relaxed/simple;
	bh=oXbbTjOHGHmZtZvnO4Qfes2ALZT/UJIHdI3bDDQzfLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=unTuLXDgz1erUvRG8ZHhAoTuNm0hl+73cEyyZZRKf3IyDFBcV2NYbPEF18npPnNN11TwXxESRG7txg/NGbskbBiqXHY9efEjQKzyH+h0bhdBvRT/Qrh7MzQpK7S7wA7zIE1psCB3CkoyMTnafu5ySc3OexRe2InKM8uau1Ndncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7FqY+Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D2FC4CEC3;
	Thu, 12 Sep 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726136741;
	bh=oXbbTjOHGHmZtZvnO4Qfes2ALZT/UJIHdI3bDDQzfLQ=;
	h=From:Date:Subject:To:Cc:From;
	b=t7FqY+FvUxu5OXhh7crKNG3iZ69w6gsY11E4Fc4nnFrRyZP3v72IrJDFe786PvFXN
	 yaMuaf6O+ecwbn5MM1NAxHZtFEBtmy4wp0D4QHEXxaXvj2dQIlzAvYdY77pai42aHL
	 9ykfpxzIwQvOWWcQFQMzUXOoWXJIknJLTvK6IS5vLpzMCbLCpz+CgPfbe6yJOI4/oA
	 +3VZagcKlzkWs609XgXKeknvjAhbiJAg0juPYMte6VqTL+KjMD1PDnES/nBMWgj+Wu
	 ECfm+prS4CL5x5sLfpqOV1pAXGJtpin7+tlfC+YvtihO1jF/LoTMTx+dvZyDT7r44g
	 s2/gzx7wmzc5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 12 Sep 2024 12:25:29 +0200
Subject: [PATCH net-next] memory-provider: fix compilation issue without
 SYSFS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJjB4mYC/zWNwQrCMBBEf6Xs2YUkFqH9FZEQm7HdS9QkLYHSf
 +8ieJjDG5g3OxVkQaGx2yljkyLvpGAvHU1LSDNYojI543ozWMcJVdMqv6TxjOq1iNh8bv67YoW
 XFNE4WHPto30ONxdIZZ8MHfyO7vR30OM4TmV5KWuCAAAA
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oXbbTjOHGHmZtZvnO4Qfes2ALZT/UJIHdI3bDDQzfLQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4sGib91L7eitagSjw9kzYEQxKTG4nYn9I3RM0
 ZQGJMyTVQuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuLBogAKCRD2t4JPQmmg
 cy/zEACpAeui9HGTi1xdx8pVB8E+XEFoUDJUe31hBfp+Nx7GDqwWDHYqOTxyN50HA7vX/H4/K2h
 djQAXjz62oMzcvKiE7HnQMRi5vBQ4MRCmRR8AO0A8dowTrZXWYnnk1gKX1mt8iiMr02Jl5lBU3M
 iLivXq3dcrGyh9/fWKx89ZVZ3X0U88oYgjAjwurtjTfCungTHwbdpDcO/kBqmnoqLzHBrZqalu5
 8RERGJlG9gvUR1L1s92iYujaMQk8qd9e85bIkXFO+nmpe4uiqhit/iiUpHLfO731iBcvAA6DWxU
 Mb19OPpLtu+/tBBVJj6swvaOn/fg2nuVF4uj8hvHTnZEetq7btHOKhJZNXxze1QDInWFUmIjpEU
 1rbe7PjHAeXsAogJWaE+rxvxC2SNpwGjZ2SiKlXdwciNpGFC5b5wBt9TCiZtpkkCLIaOr1/fP+J
 Vva9D1jNWF8qvLPHZbUUdL7PqJsV3UC6C08byd1GDWTsDQ68fgpm/Z8o5pzGI2AU31FbQB0iGg6
 BH5InEpyH7MDBbTNV+x9Pa+0w8QTFovsy7Ph2YluH+MhSOJBbYXyq26Ccq1g/+rKNR84UeCB4xB
 c1UWnZvjIcPtHDu1dG2vP8ei2pzNzxgoU/d2D7LZ+C7S6euNE2iHdkpbHNtNDM9WHDVD9ZNQDn3
 dGN8srlZ9HhXrIg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When CONFIG_SYSFS is not set, the kernel fails to compile:

     net/core/page_pool_user.c:368:45: error: implicit declaration of function 'get_netdev_rx_queue_index' [-Werror=implicit-function-declaration]
      368 |                 if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~

When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
as well. In this case, page_pool_check_memory_provider() cannot check
the memory provider, and a success answer can be returned instead.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/core/page_pool_user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..a98c0a76b33f 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,6 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
+#ifdef CONFIG_SYSFS
 	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
@@ -372,6 +373,9 @@ int page_pool_check_memory_provider(struct net_device *dev,
 	}
 	mutex_unlock(&page_pools_lock);
 	return -ENODATA;
+#else
+	return 0;
+#endif
 }
 
 static void page_pool_unreg_netdev_wipe(struct net_device *netdev)

---
base-commit: 3cfb5aa10cb78571e214e48a3a6e42c11d5288a1
change-id: 20240912-net-next-fix-get_netdev_rx_queue_index-a1034d1b962a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


