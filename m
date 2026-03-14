Return-Path: <netdev+bounces-267644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEOxLqGltGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:02:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5C28ACE9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72253189AC7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CF32264D3;
	Sat, 14 Mar 2026 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsmJ+vuU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8213AD05
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446454; cv=none; b=QMrsjRVMnhqgF35VBNUUJwTs4yX5xUDGGbdBXKqFfusbTSlFt8sXTH7IHPWHQE8o880cuH+XVoWD3jI3UjmXb5FDHAFLxcx8whtMjzXUoFv4JClB+KetemHbDHMZ5k8wDuYUmYveVjefHEUlgY5wBnRmXfvC/FnLr2wwEjfDaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446454; c=relaxed/simple;
	bh=qQSv/5WdpZH4XBXZwbx9dzgQ4o8yOA7GNQGX0IAwggY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXWpBe9bE6452+qq5XuEtHBfYaw9s/yf2gyFikEmMHhUkaWf9qtzTBC0E321vXtupUZHC3ihbc8em4GudF9sUroB2DTZqZAwmv+ti6dbWOvCJTWRr+w/PjaztudKNkfRWqhAWOLwatQlsH6oD4o/ygOVY+nuXsIboZ3Rz86auLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsmJ+vuU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79800183233so41961187b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446452; x=1774051252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W86A6Y/31ihOHZ6/xNMK1KyCGKpHT+7je3oM4+QBYPA=;
        b=hsmJ+vuUSP3+l9K7+ZZrsfasOwOkxFRpqvn0JQex614/Zzu1lqLoddBjnygLZp5v/G
         BmMD5Dx5oIkvZxDMZs/K3tmHRnqDAQ4mmAJkzR17Z40KQ0r/mjSslcRI1nrVTcokDvVG
         x9zLIrVEdzmMUnfk7ihMl5Wk75Y2boItaGjCHFa7RnIQ+j5dqKZ75ygdrAyxmcBrUxY1
         z6ZdL3j3TCcAZ9WjBMXpg7Aiqgmgkg4xaQ+8AaL/kM/MmVay5HZSlxRANySTkXNICLh2
         iR984qlbdaRVOJWvw3Uwnjt4fS3DFcSpilF7sVJq3vSASHRLNIBNU9dcyBPbgNHcWmwp
         hL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446452; x=1774051252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W86A6Y/31ihOHZ6/xNMK1KyCGKpHT+7je3oM4+QBYPA=;
        b=ZPGU4pSnzhANZ8F026cJAsKc1vuaN/hToLFEiCXDbip9g4OTb1+9vTmpphH1j7GqQi
         JFaHsPqqSNqZNOw26oWhU2kSTfLYfr7uKx580PNDsX3T8nSpgTvw6t0aWMIFhn6T+uzn
         LGWR/5A+Xaxsxz8lkgsxTWp8usF3z6Mo9akg46jKEGWevbD/HQpLo+cosOE4S6/XhX+T
         rCxlo+MoTSIW3N+ebDQf3g3rHS/wQHQyZpWWqml2yl+u1FqrxwyHA0tcj4I4zTa24gK6
         sORqSAXRcjVrwkKCd7TUuaEcrGROHbEj1MWF71KS2pg52rmnJMDXhluQn27uVmJkrg9q
         xIPA==
X-Forwarded-Encrypted: i=1; AJvYcCU/qHLQs5T57v/DpSZbSVM9idPgYmng9OfjyyeOdGUIc4orBzReZpXh4osSQs05d0AhuTX+aSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c+UZV9so+qiCZNxTvxbeq04+27+EdM41tvUfgIZVgT6XbcfG
	WAuv4qWQPrn5/mp8Wqjv/ngtdgrPOUzbm9h4QxraP3o4IehO7nh7jDeVtx1OVQ==
X-Gm-Gg: ATEYQzw+VfEDDxqW3p1T6dMxQ4iiy2Vc1PbqXJAh5/kneBXZK8Y3s/Fhw9C1mGC82nr
	Wkd78Hdc8oRqJD3N1P83hUy+lJ0gJPSqdh8XlmJsJWN9uKgfkWmeWmkLL71vQmh5uklfwg0vyDk
	tv63ow4srhIuiN0I3IQuvnX2aGzUJkGoaQ1bSopd7VxDu+U2GFZe2yUJ6lbZOe6kfMMnG8FohkU
	l8Y7cdJgdZ0jxAgwSdfI2ZLiEatWH+5ipOOeiqd4YzPTwhhOIn7TyuzhJWfcQE5CL47YRG3NIbY
	f4fstXBjle96WT1FnChu/YcdiL5htEUcE3gxbTlli9ocX+vretUW8dVLappfZlX6L87AhPZLQFB
	rwFdfEITUg/0lRB5QUOqUHMyKhM+voVvSxqGBG1gGf4Quawxznm8RYYsrtGwAyNQ3s91qYBklj1
	UasjDIwFirrGPNkbQtCAuZvg==
X-Received: by 2002:a05:690c:348a:b0:794:a8ea:f04a with SMTP id 00721157ae682-799475ee218mr90550227b3.20.1773446452052;
        Fri, 13 Mar 2026 17:00:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm54769307b3.45.2026.03.13.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 17:00:15 -0700
Subject: [PATCH net-next 2/2] selftests/vsock: fix vsock_test path
 shadowing in nested VMs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-2-d0e6274c3193@meta.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
In-Reply-To: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 21B5C28ACE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

The /root mount introduced for nested VM support shadows any host paths
under /root. This breaks systems where the outer VM runs as root and the
vsock_test binary path is something like:

/root/linux/tools/testing/selftests/vsock/vsock_test

Fix this by copying vsock_test into the temporary home directory that
gets mounted as /root in the guest, and using a relative path to invoke
it.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c2cfcdf05d99..8182c748f214 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -393,6 +393,7 @@ handle_build() {
 setup_home() {
 	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
 	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
+	cp "${VSOCK_TEST}" "${TEST_HOME}"/vsock_test
 }
 
 create_pidfile() {
@@ -601,7 +602,7 @@ vm_vsock_test() {
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- ./vsock_test \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -609,7 +610,7 @@ vm_vsock_test() {
 			2>&1 | log_guest
 		rc=$?
 	else
-		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- ./vsock_test \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \

-- 
2.52.0


