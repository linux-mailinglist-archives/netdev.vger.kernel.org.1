Return-Path: <netdev+bounces-259341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FXcBcUAlmlHYAIAu9opvQ
	(envelope-from <netdev+bounces-259341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CF158910
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CEDA3004DC7
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860EE346AD6;
	Wed, 18 Feb 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ3vfek1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A630C36D
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438274; cv=none; b=R5YAw5smlZdEnNBobwzfgpiX4Z7hC7assdXhuqS/dSEbp1zQkKWkILfnVJAC3kKRECCtxgVOI2UUVbB9Wsg1qcx+J9Lpt8+atmOvzaCJz6yNd263oF2jSh+oZhWU6tMxTMcQEkOXhHN21l/iHUWzL06iF5hu6ngInkCliVTpwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438274; c=relaxed/simple;
	bh=Cq8ZzrMm3CGi0RM5HOgynfAVi/zZ/p+NhaJGJ/csZCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujFdOLD7+LSkvoL5CrOmZwnt3PwBcE4pD1Ke0c+gJ+1xOicUN96yme+JwenRygTWYrqGHLxoeWv95bCJIyfyDh6gFvZ0tL8nQtJ8bJHMKwk6VhtVJ9ByV57OcOkuhTd2UH98h6c/bKNaZCzeqxUaF12SVCH8Fyc6aeeRkSn1SeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ3vfek1; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so31376d50.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771438272; x=1772043072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAWE751YSOrD9FsbhK2tX9K0BdH9Fj+XqGCptsOgLbc=;
        b=lQ3vfek19/TPDGVoW0qJolBoOaC9v4wx70NXe9In4xQ7zUngHnQnQRAjTcgxZX6zlI
         Pbd0JQpjx6Mr48dnUmj4I083ockdOXWHXLwgB8p6af1GXEwLvJKNry1uW3UWRLW6reBf
         WtL1/JeYQ+bd9JWTSYDf/P0SfJO4O/jDYbd2C/EWaYfBCwcPTNKkNriMJzfBnqnBVHGz
         A8kOMUvpBuY6WIu8JKX4YyrijerCvoNhqO6gWYea82udAHojLZWP6jOwP8r3Pt9lVT6W
         Su/8dJ9dYppKw2BmuEX8RUX1/wmgzWsj0dLWpuJX6WpvThyRC91JTmNF8FQJPGGfIwlW
         LRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438272; x=1772043072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PAWE751YSOrD9FsbhK2tX9K0BdH9Fj+XqGCptsOgLbc=;
        b=N5ItcCTPZP4G59+QRvDWWbYKDD1DtgkYEkot/mR0YOgOodYHG1P7zbCAbdlC/Lh5RG
         dN+P1ZdFcISQAwvKwjrTDE3wv9kvc/AISHJOCWRkzrQtK/Rndu422hPHd2/WLghv6AKd
         dqU/IpW+8g8pEWQ0BdUGSVcYGJ21jEu5CdVRJXrORQzwCF5vRkrg8GpB5nklKQ6hgA3R
         ZbaG1lT/sBdl5dJmUsudUN5FiZ2d19x+wN+utvnEvrbDLRmxF8/LEjI9CTKwMKlVmCRr
         eSlb4HMXz8rcUJ3d5gGmx3pRIk9yb4VyQS81xQXBKZQxMr+wY7LXiEXvBaV69OL4qV6j
         r+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqHXbi4IjTgJJYJ8Yj+wLvB3O0SJHxpLHpP1iDWuFB/Ri2a0BYvlfvb1KsBHXWOD9tsrATxGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhdtwa+zKybxDlyQOJXHeP1Jj7isESxAReO0uGeDYQxPu5wVMf
	20P99Zawn/eqm8CzyUcowkhWUdIKaotu91mY740gZY7CIIw1ICvq44ZL
X-Gm-Gg: AZuq6aIrIaN1oQpLfaiIfAI4bEpf33/t5xc55d9ok4QBhfHRghafDEQMozw2RuulD7V
	b3oArWY0Co9OWhO/bibNPhyR0goy21ca/1u2kB6OK1PyO6WH9T+CnI5H+PwPePHIaHkqNxvKtla
	csxFq5N2nLxM+rVDMQXeXlWe4GL8Wpm1Uo3wX9Mqu+gWywV3RWDtoXwqLmyma+hzySjHD5llrta
	R/wwDdWwCXmt0pL4BQwCrbTmuDYWR2CJ/6BvQ/uTorWvQyD8xCxWTeVMpw/X+7DBS0h3VO2IZpi
	B1Sj37g+FBLTD8FRjMD3dnf+dH6QzGj7q2J/6NsFU8KQxMQOY68JOlmyQJtZ1jMlOM7ykMFbql0
	WDRjCCqFE8iStU4Kb/ccAkjaf9VJxrxgLK6+SMKp7AE+5pWTmzjt9DIDfXimhRvEbDDZKIaO3pF
	dsifN4wVWjM6o2IV8+u+lRhA==
X-Received: by 2002:a05:690e:1384:b0:64a:e063:d3ad with SMTP id 956f58d0204a3-64c556dfed0mr2342999d50.94.1771438271947;
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fc4bb9sm6143499d50.20.2026.02.18.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 18 Feb 2026 10:10:36 -0800
Subject: [PATCH net v2 1/3] selftests/vsock: change tests to respect
 write-once child ns mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-vsock-ns-write-once-v2-1-19e4c50d509a@meta.com>
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
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259341-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B14CF158910
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

The child_ns_mode sysctl parameter becomes write-once in a future patch
in this series, which breaks existing tests. This patch updates the
tests to respect this new policy. No additional tests are added.

Add "global-parent" and "local-parent" namespaces as intermediaries to
spawn namespaces in the given modes. This avoids the need to change
"child_ns_mode" in the init_ns. nsenter must be used because ip netns
unshares the mount namespace so nested "ip netns add" breaks exec calls
from the init ns. Adds nsenter to the deps check.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dc8dbe74a6d0..e1e78b295e41 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -210,16 +210,17 @@ check_result() {
 }
 
 add_namespaces() {
-	local orig_mode
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	ip netns add "global-parent" 2>/dev/null
+	echo "global" | ip netns exec "global-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
+	ip netns add "local-parent" 2>/dev/null
+	echo "local" | ip netns exec "local-parent" \
+		tee /proc/sys/net/vsock/child_ns_mode &>/dev/null
 
-	for mode in "${NS_MODES[@]}"; do
-		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
-		ip netns add "${mode}0" 2>/dev/null
-		ip netns add "${mode}1" 2>/dev/null
-	done
-
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+	nsenter --net=/var/run/netns/global-parent ip netns add "global0" 2>/dev/null
+	nsenter --net=/var/run/netns/global-parent ip netns add "global1" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local0" 2>/dev/null
+	nsenter --net=/var/run/netns/local-parent ip netns add "local1" 2>/dev/null
 }
 
 init_namespaces() {
@@ -237,6 +238,8 @@ del_namespaces() {
 		log_host "removed ns ${mode}0"
 		log_host "removed ns ${mode}1"
 	done
+	ip netns del "global-parent" &>/dev/null
+	ip netns del "local-parent" &>/dev/null
 }
 
 vm_ssh() {
@@ -287,7 +290,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh ss socat; do
+	for dep in vng ${QEMU} busybox pkill ssh ss socat nsenter; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -1231,12 +1234,8 @@ test_ns_local_same_cid_ok() {
 }
 
 test_ns_host_vsock_child_ns_mode_ok() {
-	local orig_mode
-	local rc
-
-	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+	local rc="${KSFT_PASS}"
 
-	rc="${KSFT_PASS}"
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"
 
@@ -1246,15 +1245,13 @@ test_ns_host_vsock_child_ns_mode_ok() {
 			continue
 		fi
 
-		if ! echo "${mode}" > /proc/sys/net/vsock/child_ns_mode; then
-			log_host "child_ns_mode should be writable to ${mode}"
+		if ! echo "${mode}" | ip netns exec "${ns}" \
+			tee /proc/sys/net/vsock/child_ns_mode &>/dev/null; then
 			rc="${KSFT_FAIL}"
 			continue
 		fi
 	done
 
-	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
-
 	return "${rc}"
 }
 

-- 
2.47.3


