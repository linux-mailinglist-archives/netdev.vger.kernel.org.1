Return-Path: <netdev+bounces-57310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A4812D53
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F811F21882
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2F3D96E;
	Thu, 14 Dec 2023 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGuvqZPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CE10F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e3c4d70f71so2854237b3.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702550949; x=1703155749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gyoXbbowcvcf+QJZPC9lZ17kNT+jYTSz1WiLTPH1tM=;
        b=wGuvqZPsBpl3EHU5uD5YrLKs7dVrtSBbRZBldo9WOopAQNcvqBRZdVylYbkY7Z2H80
         HGaSmG5zIw9CcCOYnvFxo2sNBrjDWeySINmHxQUMKsq+D/Rey6eCybU/GlK/rhNH7JpN
         RJ5JCPTF5r5EBoAN/s/oPN3yxUbCz7LvFt4JZ3iHQH+nEE+A3dbfmkKgTeYxgczS0H0N
         HyDpBV5MK3Dgqfmy038T0KV8C09rgELZm5Subvp/oY34GZ0lgQKtHR7bH63jCw63LRd4
         /U6Bq+/ZbD1PmxyDtI6UOmP4Ucf+1gYqMkdL24lYY8FJbrbS5QRLIWbDrVwuU5194++Q
         YeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550949; x=1703155749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gyoXbbowcvcf+QJZPC9lZ17kNT+jYTSz1WiLTPH1tM=;
        b=cnsDMq3l8ArpbIXDA6kly7lX51DZKbvH52OXpvgUilZdWaqkCBmJfYgmwsY3TzE+5z
         oQtez2+j+0XX4JcD5FrC6RiUBBeOF4q62s/IEpJOozHLAm1bhiHPxD0kI8iwOvdC1tjm
         5DCR8B7T9ofi+imzAvFFNMjaWtCdqNarUh0ozYyCNTKi14fbqezf7j0kxyUuJSsggAEx
         gyECevoeE3v0+c2QdaTyYhAuHgsyNcQ+1ByK1vFmAf5cbyxu6t8oy7Ev33fmQrdHoVsn
         N+1yU5FXNorOXSqOfERPY+BoF8u5zxdEhPAxt/axvLT+LRS2sUCd/M9yhi5l5P0eIvOb
         HxXA==
X-Gm-Message-State: AOJu0YyDJmK36VGeAkL+nST/Lh01Iix/AuAH/W5Z0x/eBu49pSjIbL3Z
	eKexa7+ZnriHYTK4yZ2Dc9Pcc3tHL3ih0Q==
X-Google-Smtp-Source: AGHT+IEetGIBcLBafdkbwPxk6sLqSXceIsd/g4ohL976gCTJw/NJme7mqohAIt1ABinpgnEg1vuR400aiZJ9LQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8409:0:b0:dbc:eadd:944a with SMTP id
 u9-20020a258409000000b00dbceadd944amr4503ybk.13.1702550949359; Thu, 14 Dec
 2023 02:49:09 -0800 (PST)
Date: Thu, 14 Dec 2023 10:49:01 +0000
In-Reply-To: <20231214104901.1318423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214104901.1318423-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214104901.1318423-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] selftests/net: optmem_max became per netns
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

/proc/sys/net/core/optmem_max is now per netns, change two tests
that were saving/changing/restoring its value on the parent netns.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/net/io_uring_zerocopy_tx.sh | 9 ++++-----
 tools/testing/selftests/net/msg_zerocopy.sh         | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/io_uring_zerocopy_tx.sh b/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
index 9ac4456d48fcc6c3517ea7055c757102ff38d0a5..123439545013d0293464e16337fde10452d9e1e2 100755
--- a/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
+++ b/tools/testing/selftests/net/io_uring_zerocopy_tx.sh
@@ -76,23 +76,22 @@ case "${TXMODE}" in
 esac
 
 # Start of state changes: install cleanup handler
-save_sysctl_mem="$(sysctl -n ${path_sysctl_mem})"
 
 cleanup() {
 	ip netns del "${NS2}"
 	ip netns del "${NS1}"
-	sysctl -w -q "${path_sysctl_mem}=${save_sysctl_mem}"
 }
 
 trap cleanup EXIT
 
-# Configure system settings
-sysctl -w -q "${path_sysctl_mem}=1000000"
-
 # Create virtual ethernet pair between network namespaces
 ip netns add "${NS1}"
 ip netns add "${NS2}"
 
+# Configure system settings
+ip netns exec "${NS1}" sysctl -w -q "${path_sysctl_mem}=1000000"
+ip netns exec "${NS2}" sysctl -w -q "${path_sysctl_mem}=1000000"
+
 ip link add "${DEV}" mtu "${DEV_MTU}" netns "${NS1}" type veth \
   peer name "${DEV}" mtu "${DEV_MTU}" netns "${NS2}"
 
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 825ffec85cea3e23cd672541bb331302f6c66aa0..89c22f5320e0d603ae7ca7ca2b64ebd83bb8979a 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -70,23 +70,22 @@ case "${TXMODE}" in
 esac
 
 # Start of state changes: install cleanup handler
-save_sysctl_mem="$(sysctl -n ${path_sysctl_mem})"
 
 cleanup() {
 	ip netns del "${NS2}"
 	ip netns del "${NS1}"
-	sysctl -w -q "${path_sysctl_mem}=${save_sysctl_mem}"
 }
 
 trap cleanup EXIT
 
-# Configure system settings
-sysctl -w -q "${path_sysctl_mem}=1000000"
-
 # Create virtual ethernet pair between network namespaces
 ip netns add "${NS1}"
 ip netns add "${NS2}"
 
+# Configure system settings
+ip netns exec "${NS1}" sysctl -w -q "${path_sysctl_mem}=1000000"
+ip netns exec "${NS2}" sysctl -w -q "${path_sysctl_mem}=1000000"
+
 ip link add "${DEV}" mtu "${DEV_MTU}" netns "${NS1}" type veth \
   peer name "${DEV}" mtu "${DEV_MTU}" netns "${NS2}"
 
-- 
2.43.0.472.g3155946c3a-goog


