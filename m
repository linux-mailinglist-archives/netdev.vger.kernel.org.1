Return-Path: <netdev+bounces-259343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNysMDgBlmlHYAIAu9opvQ
	(envelope-from <netdev+bounces-259343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:13:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E915898E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15202305BBF5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B4346E7B;
	Wed, 18 Feb 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUp7oJdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4E346AC2
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438276; cv=none; b=KJiQAxZ23febr0l1mukjxAKOPKNvidhE816/XdVJeEbLRCIaShgU3txWXAGE68KPNbe9M80oeR3Nc/qH61BWEnoy8m3KntnYLNAUlHHD9uxsKquhwdjPKDC844Yhqemzn/4XG5OIYQAVpgOmRlVh866R9L4woCoAjcagiYzasPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438276; c=relaxed/simple;
	bh=nlAlDEhBcV2bHlFAryaUj7ZOcWtIQPl+cHubqkhJz4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjWGmfv5/Kxtob4zhQfVhF5iY3tAep19/L2pCjTD5cBr/GfSMHA6Ap3ej93jBCMgRVdN0evUI7KHMKs7o4QKkTa3uk0snfWgYoJQJy/jUS7XCmir0jdLTgWf2YLLv3vtlMHPnLHQX3AcQxXAYt3mEVRbarrbkNko9GeDZQS0dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUp7oJdp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7948e902fadso933297b3.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771438273; x=1772043073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYXQVsGZ6QB5W8jT2tab5YPGUexmQcws943nTeNPNNs=;
        b=hUp7oJdp3Hotae+s6O2fU5aY27/6OUVkspJ/J1FKgfyZnP1J8y3i/tT0h+me+TXuVz
         LFZnwKmOMEZjCPwT9kZy0MxO3u2adyIArKxflc79iNOk1+meLeqJgvG+UddxMJGU7k95
         X1yc/DoHlDbA5gSEUF65wXAMXpdXQG9hMpv8Urdy3h0zdinnnEJOH6amloSk26ufsenZ
         xwYZYGz9d2xwSXYpdtIhwVSha3eSG+QU3dh+zZ9L85SyHX0X6agnkTRV+v2wcV5TKnSH
         NP6bngIRgVCtAUmOvC9nKQRRMNpFKei1Ze1UpUimKVaE+994K9sCpjnMJLo9ZeOBSuv0
         HmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438273; x=1772043073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EYXQVsGZ6QB5W8jT2tab5YPGUexmQcws943nTeNPNNs=;
        b=Gz1VIW+C9WhQXr4O3Ab9f6PaW6VzC8uNpetHD+dOFrcHHzIzT4a1J9bAqLr5Hebv4E
         U0GMNhBaH//OcYtSQyEFEwvZcQFN9T0fdfE2DZmfjkJVi63zQeonMcbhM33C8LfrwPsb
         Xm079k0CzbY3Rt14Qg21+bm7YP2s8yS6Yn2UKQMndd2K9Dde+a3rn3VOV5ld0WnGPN19
         aAB1zA47MiRuDGi13jrzKMIuFZ+LO3IAo2UMspXRTnA8KHwgq1EBqWeCxpZDe7ekiO36
         K+g+nwyEb618WwB09nIrhLibbYi5ucBA3G3PHQThy13KlWzA1p+AJnNEikQzE2kgIzn6
         7Nog==
X-Forwarded-Encrypted: i=1; AJvYcCW0XCYv1cpNAG3mdTHXrvbcIcYxUyFmO2GnmLXN+jfJGTOwnMY0/IlfVBLgCAoXk8cMKuUfG9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96vXvefGEBBk2SHbariJzpcAjgT6Xu0ahTHF4Zz9UvYx0PJfK
	te9wRYKhvCrRYclwhXcVsD53zrevGv1ez9TZ+EUV2tX08irDrzP1Npd/
X-Gm-Gg: AZuq6aIc0ndtrSsiCAYd+saIC92b6H+Gp75Ls0RYm4vbd8VJ8eTQjX7xXwkgsAVxULC
	r+H8p0L5omRDOyBcCJDMzLddtgc4r521NuWcDMvs0BYP/4F2C59GZ6RRp/KnLitJnQpWF2uDu5l
	Oeg3iY509SWmYb+WQamhkHG45qlCL+cBlA4dUimau6TDGJMR20rL9kTe3SxgVo8oNF68DuYvXYx
	14E+631YUGYv02VJPxAUdQ32ZhmDKRG7RyyRvGI+mRaZlOGqbli7CPlBhZAPVvjkzvFltT2qfXu
	CHnRO07w7MesY/UOfg2Wz5w3Bc7sK+NUJkUW6e4QHXT9W0c6kWhZqB3H2odbfsc+WNpHwc91+BT
	LmPWuiaPrOmk6LxikD8aJNKUafo3iZEL2MhtVDvqoqyweQicJ73LEJhg8IgB6MJOmmTpgU9epnI
	if0zwCcw9or0Nij7Rf6heWSg==
X-Received: by 2002:a05:690c:d8d:b0:794:7be0:8217 with SMTP id 00721157ae682-79803d031ffmr1521947b3.52.1771438272580;
        Wed, 18 Feb 2026 10:11:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d5asm129169257b3.43.2026.02.18.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:12 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 18 Feb 2026 10:10:37 -0800
Subject: [PATCH net v2 2/3] vsock: lock down child_ns_mode as write-once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-vsock-ns-write-once-v2-2-19e4c50d509a@meta.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
In-Reply-To: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daan De Meyer <daan.j.demeyer@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259343-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 704E915898E
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Two administrator processes may race when setting child_ns_mode as one
process sets child_ns_mode to "local" and then creates a namespace, but
another process changes child_ns_mode to "global" between the write and
the namespace creation. The first process ends up with a namespace in
"global" mode instead of "local". While this can be detected after the
fact by reading ns_mode and retrying, it is fragile and error-prone.

Make child_ns_mode write-once so that a namespace manager can set it
once and be sure it won't change. Writing a different value after the
first write returns -EBUSY. This applies to all namespaces, including
init_net, where an init process can write "local" to lock all future
namespaces into local mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h    | 20 +++++++++++++++++---
 include/net/netns/vsock.h |  9 ++++++++-
 net/vmw_vsock/af_vsock.c  | 15 ++++++++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d3ff48a2fbe0..9bd42147626d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -276,15 +276,29 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
 }
 
-static inline void vsock_net_set_child_mode(struct net *net,
+static inline bool vsock_net_set_child_mode(struct net *net,
 					    enum vsock_net_mode mode)
 {
-	WRITE_ONCE(net->vsock.child_ns_mode, mode);
+	int locked = mode + VSOCK_NET_MODE_LOCKED;
+	int cur;
+
+	cur = READ_ONCE(net->vsock.child_ns_mode);
+	if (cur == locked)
+		return true;
+	if (cur >= VSOCK_NET_MODE_LOCKED)
+		return false;
+
+	if (try_cmpxchg(&net->vsock.child_ns_mode, &cur, locked))
+		return true;
+
+	return cur == locked;
 }
 
 static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
 {
-	return READ_ONCE(net->vsock.child_ns_mode);
+	int mode = READ_ONCE(net->vsock.child_ns_mode);
+
+	return mode & (VSOCK_NET_MODE_LOCKED - 1);
 }
 
 /* Return true if two namespaces pass the mode rules. Otherwise, return false.
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index b34d69a22fa8..d20ab6269342 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -7,6 +7,7 @@
 enum vsock_net_mode {
 	VSOCK_NET_MODE_GLOBAL,
 	VSOCK_NET_MODE_LOCAL,
+	VSOCK_NET_MODE_LOCKED,
 };
 
 struct netns_vsock {
@@ -16,6 +17,12 @@ struct netns_vsock {
 	u32 port;
 
 	enum vsock_net_mode mode;
-	enum vsock_net_mode child_ns_mode;
+
+	/* 0 (GLOBAL)
+	 * 1 (LOCAL)
+	 * 2 (GLOBAL + LOCKED)
+	 * 3 (LOCAL + LOCKED)
+	 */
+	int child_ns_mode;
 };
 #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..50044a838c89 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -90,16 +90,20 @@
  *
  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
  *     mode, which is set at namespace creation and immutable thereafter.
- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
  *     child namespaces will inherit when created. The initial value matches
  *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
  *   current namespace or existing children. A "local" namespace cannot set
- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
- *   from the parent's child_ns_mode.
+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may be
+ *   configured and locked down by a namespace manager. Writing a different
+ *   value after the first write returns -EBUSY. At namespace creation, ns_mode
+ *   is inherited from the parent's child_ns_mode.
  *
- *   The init_net mode is "global" and cannot be modified.
+ *   The init_net mode is "global" and cannot be modified. The init_net
+ *   child_ns_mode is also write-once, so an init process (e.g. systemd) can
+ *   set it to "local" to ensure all new namespaces inherit local mode.
  *
  *   The modes affect the allocation and accessibility of CIDs as follows:
  *
@@ -2853,7 +2857,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 		    new_mode == VSOCK_NET_MODE_GLOBAL)
 			return -EPERM;
 
-		vsock_net_set_child_mode(net, new_mode);
+		if (!vsock_net_set_child_mode(net, new_mode))
+			return -EBUSY;
 	}
 
 	return 0;

-- 
2.47.3


