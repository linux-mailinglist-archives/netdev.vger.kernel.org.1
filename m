Return-Path: <netdev+bounces-28155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6877E699
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F59F281B8F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0C15AC9;
	Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B752F52
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE87A19A7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:03 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57D46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3F50DFB5C5;
	Wed, 16 Aug 2023 18:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692204002; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
	b=yI/IKRhFy+YW+6ro/aDBeavgCLP2gfTSSqqgmlOK6g94B3tgyXgsQaSnO7AaMU0gjz2ouH
	isi1zVyCb/vH/oCBUaHx1fhVfRDIE4UoJdZPQL+DJMaio8BzNFQokIHK9URzmz5Vk2F/dB
	moqyqNMPed/JRFDlBeuUZ1cCRPm36DEW3mqxg/AJ0+L1mJBn6G2Ao8hjZ5gRb5ARlW3jAX
	jOpx6vtI8xN19gIvA5Bj78kL4bGkjMksbaltrAatgbqj2E3RMk/3Kw356MrqddGabXHlut
	fC/FGUEbzj0aAUYp7q0FubhxUihsr8xPuBKvyb9a8mIDQAyXLYGMEQ57XO8rVg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	YueHaibing <yuehaibing@huawei.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/7] batman-adv: Remove unused declarations
Date: Wed, 16 Aug 2023 18:39:55 +0200
Message-Id: <20230816164000.190884-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816164000.190884-1-sw@simonwunderlich.de>
References: <20230816164000.190884-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692204002;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sUYbNqhvEwel1SnIcIOzH8ev0lU6YpbfJPn2kk+jys=;
	b=Gjw+X2TXV9lmXC2cIouRX/GeRbLar2fuBT84HRlICSgzqBChzqj39skcG0mRZu+8mvvh1F
	G6WVzSF3odlKr1GCo//vvsqO5brAlsO0Euma4NG/bdPz4qkdcqB25FtbisOavGNoKiKuzo
	lpgg9uNTWp5/DFsgh84CEzK18tKhOpwhZiIpiT+64SUatjoaxLLd5t6r3js0NZJYJsBC4l
	c+qhsseClEpjaHYnVPqmdSgEuoHxg2I6Hibk5O0Q8IhgTdUlJGX5dQkPt0Fgg8zTvZpoF5
	3l/Ig6cDmMOQUHu5OGUsw8x40qgwbr8bjdvavvIMHYofLP15KnH2fQib928uDw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692204002; a=rsa-sha256;
	cv=none;
	b=gl2LSSRhCEl91VNW5tZZDVEtC16utTaoobwQUh0q6JOUwaLs4wNhqVfok4sHYDoof2wImu+sRSrd+nEGIQefI4lO7YNaX+tWJiULon1/MD+OiGGzGTh0f+BeNRevoUieTIAsM+E8bx7sb8s55quDgRLHQZFNk4QHBiVMarsJqpPvrhJUhwP4KRNaNP9yxaBvpJRZAmJHS4a1iIZwHXD8UQSGmkWwQSsKyTOkpseE2QF7xgiO54R52psX6htzpQvxDU3sE75s7KO3iSJnJu5TTEMd8mGIceRjBT/bcFuHnLhMhysxNAs7Mc0X3nL8yKyL5qEPePrXe4sD/oPbdJMQAg==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: YueHaibing <yuehaibing@huawei.com>

Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
batadv_recv_tt_query() is not used.
And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
left behind batadv_recv_roam_adv().

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5f387786e9a7..afd15b3879f1 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -27,10 +27,6 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *iface);
 int batadv_recv_bcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
-int batadv_recv_tt_query(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
-int batadv_recv_roam_adv(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if);
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
-- 
2.39.2


