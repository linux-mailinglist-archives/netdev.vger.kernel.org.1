Return-Path: <netdev+bounces-51430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E947FA996
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A6B1C20BBF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935C4594B;
	Mon, 27 Nov 2023 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddfi+4eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0AD60
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfaeab7dafso28631135ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111820; x=1701716620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPaN4vg9SQDJHqYebN2/xKdXNgaWBfzTAU2wIw8MN1M=;
        b=ddfi+4eHj5Wh4pGNj6IGvkv/wNLWH1oB//3Sxg0otVK4lJIjv1wJ5KczsyN+aHmlsM
         dCjY/htveE0GjdbkkNe5PSQwQZv2s440K1Vc86xhnXlhT6JUZIzJy8m/h5tPL62vhyTx
         Vh/ovvgjVH6qy2l16PVb1cs4vir6+Lmsf7SrqIv8U3JEJ6OaLChTZwGwFaOdfubF53x0
         w/43esw5uXq6kvoK2tWBhHJGoUqxzDDguTepi0yWc6PN+ojepYnY59LuBB69N0enIEWO
         Dpk5WBWa8YckW5Yfhofgt0UVXJOnB/V7N78rO+nbuExwp3/4NzfgJ/n6C/8XCv7EV1DU
         wmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111820; x=1701716620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPaN4vg9SQDJHqYebN2/xKdXNgaWBfzTAU2wIw8MN1M=;
        b=prOuwocT8WZHZbfxqXmV6GFEFiwp1QxKGfrWAk2U3NvcMo8EU00Ajcrk6R0kl1g0od
         zD3nNEAPsqZRHP0xk+t9Ge+ZALAEyG53N7T/9y/1HDVffL6Dh/ldmyYsFb8Blj82f5B5
         JgrDy/ELAaoJG1I0tZMZvH9B19s0feIKIahbkKaWhUnsidL454ntKMUVKPj4Mzqtydeq
         +0zyuZjOib2ddp7M19KKN9MC/rO2/fG92MQhBkWwfo5fSKWoVIoP5U+e5nxJmL4e2ATa
         rm48Q4gxzrn9S/OHWtgHwNLn411NaTJCcKJU2D5EU1qZmg0VwPHIqUKS3eJtww6d0PVq
         aVMg==
X-Gm-Message-State: AOJu0YzWCgOg8VR8ElsF1bB84GTSji7ENAvHwXb50MSvkSFmEd1y/K0o
	U62d2sKJD9CghuhTKIBcnZdHlUg=
X-Google-Smtp-Source: AGHT+IFBTjrElYjTEV9WQEofymDfgw7+CwNBeZf4OoRmbs32unp/IJ0ulmfxZYSw4cDD/GY5fzng/uo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:b948:b0:1cc:cc77:94ed with SMTP id
 h8-20020a170902b94800b001cccc7794edmr2695776pls.10.1701111819885; Mon, 27 Nov
 2023 11:03:39 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:16 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-11-sdf@google.com>
Subject: [PATCH bpf-next v6 10/13] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Checksum helpers will be used to calculate pseudo-header checksum in
AF_XDP metadata selftests.

The helpers are mirroring existing kernel ones:
- csum_tcpudp_magic : IPv4 pseudo header csum
- csum_ipv6_magic : IPv6 pseudo header csum
- csum_fold : fold csum and do one's complement

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 34f1200a781b..94b9be24e39b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,4 +71,47 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+
+static __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__u16)~csum;
+}
+
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		s += (__u32)saddr->s6_addr32[i];
+	for (i = 0; i < 4; i++)
+		s += (__u32)daddr->s6_addr32[i];
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
 #endif
-- 
2.43.0.rc1.413.gea7ed67945-goog


