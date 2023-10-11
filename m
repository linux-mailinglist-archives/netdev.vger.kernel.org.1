Return-Path: <netdev+bounces-40005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7D7C5618
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E6D2821F7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10552200C1;
	Wed, 11 Oct 2023 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYcdQnv2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F92200A7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:01:34 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16892
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:01:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77063481352so84152285a.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697032892; x=1697637692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swEOKGydJoH1qZIFmsYX1yLD8XZOv6z7P+SVZH9SpFI=;
        b=dYcdQnv2GRMjQrfrnoHXzizcTqqZhkSmKiPBbCm9gsVBk0+JUyAKhxuwkNeiqOj2Wd
         R7HMXH+l0jrYuckq9iHiyoxeJavE7qcxRAXDs+7SHiGuXgTyjw772WoSNw8HE7pwarti
         zo61vIr13szFqVQIt4WuDthdUMuLPR7tGlMvQQUpXoH+Z/81xQ20gMLlNbxySg6L/cVU
         lDNOG0HeVod6IqnXfV6gsgiPY4WiUhyc2VM2B1Z1GH/sst92jJrfk0UtRNTz0il65AJJ
         RW5vX6lA4lYQ66E8p4qasqFusqott/S4tT6fqREenB3r765iTsQuUNsjurSh3kLhZtHX
         aCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032892; x=1697637692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swEOKGydJoH1qZIFmsYX1yLD8XZOv6z7P+SVZH9SpFI=;
        b=qmJfnOLMwG472AfJN85p0/wY4K8Oqp0J1OQj6LbtbvAqWRIpB39hmL2QT368JszVNa
         TH7Op/Cnmsd2h7vssGqfacMISoMn5oK66qpHsSauAoXQxNSBZhd47ZsBmvq73jjJc0hN
         LZLFiznVpv56JZJxTTGAzQgLq5x7AiSXjjY3phRFjjlLLkk1MXPffKdd++QVcIXUsubF
         llTYYY/XUeAU3/+rx0JkmrjCwfqzO045TjgNQOH4HtKFkaOj73v8g8lhxg7F6pyZdgMI
         1V4bnc0wXZ4Xosmu47FC2hmxx1WqWILb4YCx2vBVxSGGzMx9raIhZEiO5fnA7yu+S5eL
         LK6Q==
X-Gm-Message-State: AOJu0Yzo7hVs6zhSC7otf8KO2ktgiybXk6me3SpSd6QHAyWZ27VmdH/5
	vbIP7U1sr7xGcwqzTRV/aVCAf0VnayM=
X-Google-Smtp-Source: AGHT+IHs2IggKKr5i0YccBGemjJ47gniT984OMewQGiYewO+nw/iJ9XVy6byYSwyG/csKq5qJjgxdw==
X-Received: by 2002:a05:620a:31a0:b0:76e:f3a9:1e12 with SMTP id bi32-20020a05620a31a000b0076ef3a91e12mr26310740qkb.1.1697032891729;
        Wed, 11 Oct 2023 07:01:31 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a123600b0077423f849c3sm5214505qkj.24.2023.10.11.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:01:31 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew@daynix.com,
	jasowang@redhat.com,
	Willem de Bruijn <willemb@google.com>,
	syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com,
	syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Subject: [PATCH net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
Date: Wed, 11 Oct 2023 10:01:14 -0400
Message-ID: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

From: Willem de Bruijn <willemb@google.com>

Syzbot reported two new paths to hit an internal WARNING using the
new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.

    RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
    skb len=64521 gso_size=344
and

    RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262

Older virtio types have historically had loose restrictions, leading
to many entirely impractical fuzzer generated packets causing
problems deep in the kernel stack. Ideally, we would have had strict
validation for all types from the start.

New virtio types can have tighter validation. Limit UDP GSO packets
inserted via virtio to the same limits imposed by the UDP_SEGMENT
socket interface:

1. must use checksum offload
2. checksum offload matches UDP header
3. no more segments than UDP_MAX_SEGMENTS
4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN

Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet header.")
Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@google.com/
Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@google.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/virtio_net.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 7b4dd69555e49..27cc1d4643219 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,8 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/udp.h>
 #include <uapi/linux/tcp.h>
-#include <uapi/linux/udp.h>
 #include <uapi/linux/virtio_net.h>
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
@@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* UFO may not include transport header in gso_size. */
-		if (gso_type & SKB_GSO_UDP)
+		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		case SKB_GSO_UDP:
+			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
+			break;
+		case SKB_GSO_UDP_L4:
+			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+				return -EINVAL;
+			if (skb->csum_offset != offsetof(struct udphdr, check))
+				return -EINVAL;
+			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
+				return -EINVAL;
+			if (gso_type != SKB_GSO_UDP_L4)
+				return -EINVAL;
+			break;
+		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
 		if (gso_size == GSO_BY_FRAGS)
-- 
2.42.0.609.gbb76f46606-goog


