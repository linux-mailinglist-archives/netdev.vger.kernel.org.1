Return-Path: <netdev+bounces-41086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64ED7C9979
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 16:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDED1C208EE
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C204748C;
	Sun, 15 Oct 2023 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RFS2pRpO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E99746A
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 14:17:53 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A87109
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 07:17:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9bf22fe05so22328415ad.2
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379462; x=1697984262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvSWVbZXn/MrVEcGpo16B6JSHdwZ2fR7rly5J6YWZNE=;
        b=RFS2pRpOPj0Fz3zbI6kHMAvLIv9pOZrbCw4IRXWqTM7IE4gIwhuZ7cMWL1lnx2NzjC
         JmP2knUtSyyY1syJLyq+qzp3nZc1bh+nyiKBD+XFfVODB9AmKmpspLEWul9jaksfPYFr
         gBcy3eEG55wtAaa0jTvrgZKvGgbxI3eEu1jJTw5zD9zCWhHyN3HfaBCMAEqTPM9AyP+R
         1C2HXXFQqdZ7eis759QCNODeaizm5UiraLBG3eSS/s6vVAZlmCMFmyTShNOh4Yb59fRT
         aHjvrGrh9h5WNqVk4iyDoarINlIy4OjJwRPgwySNoqVkKpXCYwohnBXH/4xDkepnrruM
         T9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379462; x=1697984262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvSWVbZXn/MrVEcGpo16B6JSHdwZ2fR7rly5J6YWZNE=;
        b=afk2j2+W2DBAnDzsTTOFMZaQ5L/vCSWzCdSLu349V4ZxbLNwAf24iXZCam7pOxR59+
         MeJ3M9GZulhVtuWkuaXGCES2X4BSe21ge/50uR/jSt5aTPHXSQDED26zHrRaf0q9T+m0
         CMtrJ0Iul3CjA+0RrQjwNM0l4zD2M5p+zENbJFkwZBwpIb+JbQvgGvVwziFzzXrJaGWO
         ZXFxVvtlD4KFyIp/vQ95+5bm3Zxa7gPhhZr7hC6oQV03DGlQs8e/R2ZbtXlrfcNNnOyK
         vCio2p/UjOGyQf5C4TEKiqK/B4o4DeDtcBFBDGgifcgyXBux8bFt3OIhDunOvBYO4pRr
         CcYQ==
X-Gm-Message-State: AOJu0YwBe2q6K/f60jNODojGZRpa6aATlxAIcPvYcuyvwWHQO4HPU480
	cezwW54OQQok9qdA9Jq74dVIHA==
X-Google-Smtp-Source: AGHT+IE81It/1ElAFh3WqzA1MDP6+KyM5FALauAhwzot5b7EduhSxG7C2ZYhheRbI8ll3TgU9FJn+A==
X-Received: by 2002:a17:902:aa48:b0:1c0:bcbc:d5d with SMTP id c8-20020a170902aa4800b001c0bcbc0d5dmr25880675plr.61.1697379461931;
        Sun, 15 Oct 2023 07:17:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id d8-20020a170903230800b001c62c9d7289sm6869426plh.104.2023.10.15.07.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 4/7] virtio_net: Add virtio_net_hdr_v1_hash_from_skb()
Date: Sun, 15 Oct 2023 23:16:32 +0900
Message-ID: <20231015141644.260646-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is identical with virtio_net_hdr_from_skb() except that it
impelements hash reporting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 7b4dd69555e4..01e594b4586b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -216,4 +216,26 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
+						  struct virtio_net_hdr_v1_hash *hdr,
+						  bool little_endian,
+						  bool has_data_valid,
+						  int vlan_hlen,
+						  u32 hash_value,
+						  u16 hash_report)
+{
+	int ret;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
+				      little_endian, has_data_valid, vlan_hlen);
+	if (!ret) {
+		hdr->hash_value = cpu_to_le32(hash_value);
+		hdr->hash_report = cpu_to_le16(hash_report);
+	}
+
+	return ret;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */
-- 
2.42.0


