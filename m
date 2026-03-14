Return-Path: <netdev+bounces-267643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN4QI2yltGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:01:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A828ACC4
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA932314465C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A518D658;
	Sat, 14 Mar 2026 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY9C0Kum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5F33EC
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446452; cv=none; b=iFvjVWahQbSduRX/HH3EMlkmY0il+B/pde0fU6YYeGta1mVR/yUHp5wobloYxxIyaMWzRplg5EyTpX+f0Y5FA9UJwz++9SsSthby9mhYLhMP8wKi8k2RatyuBVTHUxvXxPZUmr7UXaaqKBUWUvklt9X81JbGejMzEdYhLXXIuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446452; c=relaxed/simple;
	bh=3QJbJv8nDTe9UFWDuhjUpYU/uYCzaMl40LclqolWBe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SILZd9Iq3jjQtSfeVXKB5Ux10FJHyLSJr5hk8sD5O8BEoxufFl9ECUsJiWtTpeyd3zuDd/44lknjxQ+tX4W8tjVQsSBBJ0BN7r6O3EKa5Xp8sVOEa4/oAcYdyq1SadNrYi+irF1jZwQtM2zWtL6Qu28uhTs/sH/auaI6NW5Mtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY9C0Kum; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc4425b6bso28723607b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446450; x=1774051250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z7785Nihx26mdg32kyA0yD1bLg4oGypoWx8npW/Glg=;
        b=KY9C0KumKzeU02ILZfuBgAwQviCfd0XPb8iCT0FGtxktjJ5mEWdZ5n2ii+WvGZYECf
         niQ22wo9yDCs25cEI+VxGqjb6eTSwg+B+yD0SFufneNbt2EywYbrgHlN9ItLyYTGPtwO
         i8OVPX4fLpO6SYHWXHhPhryYYj4VdJhbOBGLyqmYScFczQPStJXgfOlZwX/AbR7weKXA
         5Rvpgrt3iunzW8nMsg7oBl/ytCeE6X597f0NPF0VKLLOHTkUh8txZd0eN/U9haP75i+t
         U7fAXp7o37v/fidONvqXsXq5UVrMx01sihK0CvkAONn1wtHuzG2QYAjSYzZUP0xENGyS
         VJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446450; x=1774051250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Z7785Nihx26mdg32kyA0yD1bLg4oGypoWx8npW/Glg=;
        b=nsOZvaUShaBiOI3eh/FqBw7x+zSd0w0hK0eYHlgbvKdUVuVtW1K/df/5O7RrhShvbX
         VWmYuJ2+QvA7AE9BQKCTDHNeOrdgOGJuALOyiS9/VKZSvPpihTh2awORKHKVGgXCdnJ0
         4PwncBclqXWgIijVTZLo7rBqjT/uzfj7vGBHcsG000ytraijGpcshnpH0VoFHAi5tMYX
         RyWX86UA6dzF+FU7WJq4V4uEOX2B46QMcrcDKNE+wFgfPIbCZH3wxhCo8cRhCIoUa5/p
         7FmYBDygZgrXGYgROpK9iUWHlfgZXN6si6YC1mwZJHXzqIZjiSHjxIQV8Qm8NmyX36w3
         8wYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqdQ3LevKNbjhvI8f5+4WQuC0sjkUw4lKroHqQZgLCatWIfFwRnL+7hqFrBoLd3DjjR3ur22U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iTI1gCxNnaOioDNiSWoZ0Fn6PFPLTLcP1JkEYmuWzJROhlUa
	gLQ784aNbY519VK6itGtzU9hzcysmyGO+TFONNDTB4jbgxU82tw1AfV0
X-Gm-Gg: ATEYQzxkhHqEakP5vKe2vSHvu5g5lqK8Qke9h8hDF47hnBocqDTRumGF9MxXjwBXEWi
	a7paI+dIQnWLHkcopl1zgFPNvhKEwu2C+Nm5MNX5xxFpi8y3/zzb26H6PqI2+SfSImCojQtJQIw
	874ehfnG2CCWdgxD2NuNWhsqfsE4Rt1z18QiPJL3m5vKDCDsJeReHIWsWmauu8xL/nVs1l/LYt2
	p3XzcmM5ApaWaPSLqZuaZqvyvYKx5OHAoTMUxWTyQ2PgH7UASpZ/YJcBlToo49YohIexj0yxBA0
	z7Lx1DpE5pX9bMu69adjjQ0etF80cRDtrx318JReNrEwa2cHw5uVZHjl358TrKvvSkNGBpfAiGo
	Yw55NWYXmWccJYGOA7YdZf132TfY7COcjM0VYwZ9R8Y5eNoLqqYgXCM8J/vB4CfqnI1jIWqNJ3F
	o+5zpjeEl810/Bs1J897w6jg==
X-Received: by 2002:a05:690c:e3ee:b0:799:1773:527d with SMTP id 00721157ae682-79a1c100004mr58333657b3.29.1773446450219;
        Fri, 13 Mar 2026 17:00:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee4fdfsm57042447b3.25.2026.03.13.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 13 Mar 2026 17:00:14 -0700
Subject: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for read-only
 nested VM runners
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
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
	TAGGED_FROM(0.00)[bounces-267643-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmtest.sh:url,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 059A828ACC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

When running vmtest.sh inside a nested VM, there occurs a problem
with stacking two sets of virtiofs/overlay layers (the first set from
the outer VM and the second set from the inner VM). The virtme init
scripts (sshd, udhcpd, etc...) fail to execute basic programs (e.g.,
/bin/cat) and load library dependencies (e.g., libpam) due to ESTALE.
This only occurs when both layers (outer and inner) use virtiofs. Work
around this by using 9p in the inner VM via --force-9p.

Additionally, when the outer VM is read-only, the inner VM's attempt at
populating SSH keys to the root filesystem fails:

virtme-ng-init: mkdir: cannot create directory '/root/.cache': Read-only file system

Work around this by creating a temporary home directory with generated
SSH keys and passing it through to the guest as /root via --rwdir.
Disable strict host key checking in vm_ssh() since the VM will be seen
as a new host each run.

The --rw arg had to be removed to prevent a vng complaint about overlay
(in combination with the other parameters). The guest doesn't really
need write access anyway, so this was probably overly permissive to
begin with.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86e338886b33..c2cfcdf05d99 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
+readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
+readonly SSH_KEY_PATH="${TEST_HOME}"/.ssh/id_ed25519
 
 # Namespace tests must use the ns_ prefix. This is checked in check_netns() and
 # is used to determine if a test needs namespace setup before test execution.
@@ -257,7 +259,12 @@ vm_ssh() {
 
 	shift
 
-	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+	${ns_exec} ssh -q \
+		-i "${SSH_KEY_PATH}" \
+		-o UserKnownHostsFile=/dev/null \
+		-o StrictHostKeyChecking=no \
+		-p "${SSH_HOST_PORT}" \
+		localhost "$@"
 
 	return $?
 }
@@ -265,6 +272,7 @@ vm_ssh() {
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
 	del_namespaces
+	rm -rf "${TEST_HOME}"
 }
 
 check_args() {
@@ -382,6 +390,11 @@ handle_build() {
 	popd &>/dev/null
 }
 
+setup_home() {
+	mkdir -p "$(dirname "${SSH_KEY_PATH}")"
+	ssh-keygen -t ed25519 -f "${SSH_KEY_PATH}" -N "" -q
+}
+
 create_pidfile() {
 	local pidfile
 
@@ -451,11 +464,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
+		--rwdir=/root=${TEST_HOME} \
+		--force-9p \
+		--cwd /root \
 		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
-		--rw  &> ${logfile} &
+		&> ${logfile} &
 
 	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
@@ -1532,6 +1548,7 @@ check_deps
 check_vng
 check_socat
 handle_build
+setup_home
 
 echo "1..${#ARGS[@]}"
 

-- 
2.52.0


