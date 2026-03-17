Return-Path: <netdev+bounces-268755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCHnDGTRuWnMOAIAu9opvQ
	(envelope-from <netdev+bounces-268755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:10:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D15232B2F71
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2B953085B6E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3F375ADC;
	Tue, 17 Mar 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS84RUY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756D364EB1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785387; cv=none; b=Ut1zqaHJD5E7D5UQgxyzj5RC2p1VOQza1RiYJ75srL+upEceK3ag9We6JBGBF3TKwniH4d2dLH7RYgMSYd3PzUd7BEpFhgLqErgvtc7j6eXVrivSlj2fYPD0Pq4egd9cxiI1AIpi2wWQ6KfqcYXdnWE1BS7Jpn8oY/DpIdV70Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785387; c=relaxed/simple;
	bh=FBy8AtaAcW3f/5x6drndhY5A+fYaOe5p6SxUT4nTXdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8jEZ8sSu2gjky/CCM+v6qSLL2XrHZJ/F3FqAPqt/xEt7Vdp1Kq+fmpziQRr3+mkC6Y3Xq65nnwnMgJUuVH08C3TfA0Vq2F/9WLY1elQmfjMi68dfxkvDql6JdDZzQndMivTAlTA8SiO7rMXB3wQQykDXAQqVuJcJiUAGa+SGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS84RUY5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79801df3e42so5597707b3.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785385; x=1774390185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjfBq/ftguqa5YG03YiYsY84WTL2L0ZPXeWuB5y9CnI=;
        b=PS84RUY5QWsOZse27RqkOgN9KuYXyLqlLiPUxUxbJWfvauIagezLbtgrDXm1kBBbfx
         e7HrBw1L7wUPfMFkgDx/D+fK1H81j+LkSoawz+AzYw519Fjn37/7nVQSovWZnPlV08qY
         tBzmS5eCkxglCoJSWQQ/raTbX4RgwR8qb2TKQNSGMYFWbI7ai4ChNVeGl6UGTBEgwiF1
         gYa9rWXU+gWn3/yP38cet/Cp6dHKHLyolxKZ8nFc3z9WfNd+tZPwBoct1quEfPg+7axe
         1fvlOtuM89JnGyeTeviTd9eYvIr7Eibg/JLDSMY6d+t6L56UJ4YHM99hhf/19og9w4kP
         Bw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785385; x=1774390185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TjfBq/ftguqa5YG03YiYsY84WTL2L0ZPXeWuB5y9CnI=;
        b=qLwVKM+h+sA8c6Y6OCFLihA5nwR9x5rfXNvA3CIPkJJmSg/MFvrfLhEzHdsSXZ37PI
         HvoChQdaZcrPpTpLNod2ne7MLA9RaQc8kbFqjMeF/VRe7VXfKLLFiiXpR3iX3H7sNELc
         orn6DdKu8lO3otBwygtboxu/YLF2RRRhuCVkwEIWyG8tjM9xkXb4RbwS+HeGGJhzMzh/
         TKDhNjAC3cgGAt/8Ig8x7Sj6ObuSCD7yNepmYIr3jS0dBPWv+qGoSoIUeiTvkatMRzj2
         PTZlFMZBITc731gUScnhitzBvvuTrRMq6tKt1HjQ7cQVTAbuRVzj1B29hfPul5dgJWb6
         t/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX78BP6bAdz5O3K951+mWyfoy68uc0jreEq1rpoJuvtscNMpXJMTk66e3PUJJFsZIMCLjQtGqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxevGa+CjZ28OURVYvcEOiSxDnC3/i5gFDXialHaBKhZrokb3Oa
	Ol0tTH7NomckmEMzHrcuyypTD1lJxzNLZNTpfA4/b8jkLvdC5AwReSbi
X-Gm-Gg: ATEYQzz4WEPx34CIW3bWMsQAtAogxWE9z76cqu/EIfGu1brNmwAaKttnZgDdiOfmApB
	M+/I7BkKuJMCt+Gw2QpkMW7sFcduVtk7rHHocGiM9yN08jbZm1aBxgcAR2SiWBVsa/KNau9exGl
	VQqrCqnGvTAz6lHBl7pyjO/X7pKx+2/uBL/GucIfUsTfpyxJUInvL82h53uF4vs9ayhU4DTQS7y
	O2Khoyk1Cm88cq6yHw8IbYQsHJgKKjIjqnmaLVnTaRUqoaXfPIDT2xT4v5LrUtZnfz3+MK0eR7d
	XyHLh/Y65mXzS3QZJEu25E39mklwoM6B85cRFRhqvRG7JUQD+mGsZOeyw8oPG65RCt9ittDrQYs
	8yWKOocFDQS2lw7Xh3gd5b1tyJEuVOsqth513rBCU9I4SoMZo1sMvGL9jZ0IJOaQ2VdTR8HlAO0
	g2/y3MQYest4HJGCuMmKIzXA==
X-Received: by 2002:a05:690c:6ac1:b0:79a:3e64:c15d with SMTP id 00721157ae682-79a61930f27mr46203767b3.31.1773785385300;
        Tue, 17 Mar 2026 15:09:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713d9d98sm5600677b3.15.2026.03.17.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 17 Mar 2026 15:09:36 -0700
Subject: [PATCH net-next v2 2/2] selftests/vsock: fix vsock_test path
 shadowing in nested VMs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-2-0b3f53b80a0f@meta.com>
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268755-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D15232B2F71
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
index a4b56322ce9b..30c06544f2e5 100755
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


