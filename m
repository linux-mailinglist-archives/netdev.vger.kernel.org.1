Return-Path: <netdev+bounces-17638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F87527C7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B9281D44
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577831F169;
	Thu, 13 Jul 2023 15:54:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6111F163
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:54:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E222686
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689263682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OpGloaBWnj5MoBWfiTNEz+6FTbZvx0Cg+d8CD3SV6Uo=;
	b=eyT7o2weg7Lf5r9gTULrMQFt0+SrQCvFa9cAdS52Y4y0ScWHiLucd0fi7k6XvATKiO2UND
	6ObAD7LdUWThsPihx511LP9/8Ti1TE3BwcBZolr5X/VftazVFV2upsXFQMqxBo7LbPtA03
	oS33R8tPj9+gS6MD/Ha5bcU8PPM5MKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-SNd6AOccMHm6qbNBjoSbpg-1; Thu, 13 Jul 2023 11:54:39 -0400
X-MC-Unique: SNd6AOccMHm6qbNBjoSbpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2191983FC20;
	Thu, 13 Jul 2023 15:54:39 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1CD940C2063;
	Thu, 13 Jul 2023 15:54:38 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
	by firesoul.localdomain (Postfix) with ESMTP id EB02F307372E8;
	Thu, 13 Jul 2023 17:54:37 +0200 (CEST)
Subject: [PATCH net-next] gve: trivial spell fix Recive to Receive
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: kernel-janitors@vger.kernel.org
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org
Date: Thu, 13 Jul 2023 17:54:37 +0200
Message-ID: <168926364598.10492.9222703767497099182.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Spotted this trivial spell mistake while casually reading
the google GVE driver code.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_desc.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Yes, I know net-next is closed, but perhaps kernel-janitors
will pick this up for later?

diff --git a/drivers/net/ethernet/google/gve/gve_desc.h b/drivers/net/ethernet/google/gve/gve_desc.h
index f4ae9e19b844..c2874cdcf40c 100644
--- a/drivers/net/ethernet/google/gve/gve_desc.h
+++ b/drivers/net/ethernet/google/gve/gve_desc.h
@@ -105,10 +105,10 @@ union gve_rx_data_slot {
 	__be64 addr;
 };
 
-/* GVE Recive Packet Descriptor Seq No */
+/* GVE Receive Packet Descriptor Seq No */
 #define GVE_SEQNO(x) (be16_to_cpu(x) & 0x7)
 
-/* GVE Recive Packet Descriptor Flags */
+/* GVE Receive Packet Descriptor Flags */
 #define GVE_RXFLG(x)	cpu_to_be16(1 << (3 + (x)))
 #define	GVE_RXF_FRAG		GVE_RXFLG(3)	/* IP Fragment			*/
 #define	GVE_RXF_IPV4		GVE_RXFLG(4)	/* IPv4				*/



