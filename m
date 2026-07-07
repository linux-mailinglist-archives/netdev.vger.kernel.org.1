Return-Path: <netdev+bounces-305417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNOEOTjeTGrWrAEAu9opvQ
	(envelope-from <netdev+bounces-305417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0871ACD3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:08:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="P/JPlM9y";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305417-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305417-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5331320F0
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4E3F8233;
	Tue,  7 Jul 2026 11:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBE3F54C6;
	Tue,  7 Jul 2026 11:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422139; cv=none; b=DnyvEb+xLYXdzgXMeGDLX0kNzs3UuRsnaCjYvpqsf2P3VtUynAwJKxQnDoZvWpOtCKWHUSfNlFOkM8JqzhpwWJzxFxmOn7HfCOecIMZmpTwp8nbdpPCgb8BZhbxl91/LussK8k3fzE54RPG0cMK15OWCtI7vh3cAykng9EpHjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422139; c=relaxed/simple;
	bh=5GuMUAxON3UdhOL6uJDJsgLuGVmkNkaGVq7J/vemQCs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rTZUdDZwDrywthhClu6SBq2ZqEcRIDHnSJDpls8+1iA5HL+aQp0WgKYcBO66unCl1WfsKKMx3D0QJT/eDI6HwJ/4zqJ29MLe5E1sGHiHqf+CbpKntw7Gttt+/voDlBtUy7/q/bT80ilQzxguOn//7/ZUUh5OKZFpIyNWAPO+Qrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/JPlM9y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5E31F00A3A;
	Tue,  7 Jul 2026 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422137;
	bh=oaLCMORr56pEga1LE5HYR5tgbSH0xMGtvI0A0A62F8w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=P/JPlM9yXcL+v2ajqJ8oOQe+I2pfTfZmCw2bV+6hdS+0D0nMDoN74spgPMPpfzE6G
	 Uo0a+Y0A7EGGnbgu4MYBERURechr1KMR576sV5mGwPXQvjnppNhPfi4uiD0Ci92wBc
	 YmvbiZqpZ2rasOxvO4UMdP3hHlXrx0tRyL5pXpKp7yfYMWySwj+DL/6tlZNhieala1
	 evPJv0sywTgdiTe+cIwP32FdIm63h3SXPLe27XmIHs1My0vzMJXu8i2s5jzQRPFKF0
	 wjTZHmaRmdCaV3Ng/gaiKet9rKX1dKlYZtJo6AxvbnlJfa9WhJcL3E2he5htGdphPN
	 /eInqF7MLHPig==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v4 3/3] selftest: Add tests for useful
 handling of LSM denials on SCM_RIGHTS
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260705123826.3818443-4-jkoolstra@xs4all.nl>
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl>
 <20260705123826.3818443-4-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 13:02:05 +0200
Message-Id: <20260707-sinnieren-versichern-heuballen-e86897d216c3@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=10595; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5GuMUAxON3UdhOL6uJDJsgLuGVmkNkaGVq7J/vemQCs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53NlsGsmve4ZP9BU7f6H+pdZW9v6v3JbvPVK0OifV/
 jvT/WF9RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESOtTP8T5t5eVXk5QiNve4q
 iQJZh3Uc+5nvabvsUusTFHRff5rzOMP/lKb8GKff8vaKgQ8mXQ76w1L1+vtngVJnTUXxB+0+txy
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305417-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xs4all.nl:email,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51D0871ACD3

> Tests SCM_RIGHTS fd passing on a socket with the new socket option
> SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> call, BPF is used. The BPF program shares a hashmap with userspace that
> lists the inos to be blocked (of the receiver tgid).
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>
> diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
> index 240b26740c9e..5034482f8864 100644
> --- a/tools/testing/selftests/net/af_unix/.gitignore
> +++ b/tools/testing/selftests/net/af_unix/.gitignore
> @@ -3,6 +3,8 @@ msg_oob
>  scm_inq
>  scm_pidfd
>  scm_rights
> +scm_rights_denial_lsm
> +scm_rights_denial_lsm.bpf.o
>  so_peek_off
>  unix_connect
>  unix_connreset
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
> index 4c0375e28bbe..594cd26ec398 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -11,9 +11,17 @@ TEST_GEN_PROGS := \
>  	scm_inq \
>  	scm_pidfd \
>  	scm_rights \
> +	scm_rights_denial_lsm \
>  	so_peek_off \
>  	unix_connect \
>  	unix_connreset \
>  # end of TEST_GEN_PROGS
>  
> +TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
> +
>  include ../../lib.mk
> +include ../bpf.mk
> +
> +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
> +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
> new file mode 100644
> index 000000000000..4f2414465bfd
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <linux/errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct inode {
> +	unsigned long i_ino;
> +} __attribute__((preserve_access_index));
> +
> +struct file {
> +	struct inode *f_inode;
> +} __attribute__((preserve_access_index));
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 16);
> +	__type(key, __u64);	/* inode number */
> +	__type(value, __u32);	/* tgid of the receiver being tested */
> +} denied_inodes SEC(".maps");
> +
> +SEC("lsm/file_receive")
> +int BPF_PROG(scm_rights_deny, struct file *file)
> +{
> +	__u32 tgid = bpf_get_current_pid_tgid() >> 32;
> +	__u64 ino = file->f_inode->i_ino;
> +	__u32 *owner;
> +
> +	owner = bpf_map_lookup_elem(&denied_inodes, &ino);
> +	if (owner && *owner == tgid)
> +		return -EPERM;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> new file mode 100644
> index 000000000000..b8656de86efe
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "kselftest_harness.h"
> +
> +#ifndef SO_RIGHTS_NOTRUNC
> +#define SO_RIGHTS_NOTRUNC 85
> +#endif
> +
> +#define NR_FILES 2
> +
> +/* Per-file content, so a received fd can be matched to the file sent */
> +#define SECRET(n) "secret %d", (n)
> +
> +/* Indices into the socketpair */
> +#define SK_SENDER 0
> +#define SK_RECEIVER 1
> +
> +FIXTURE(scm_rights_denial_bpf)
> +{
> +	struct bpf_object *obj;
> +	struct bpf_link *link;
> +	int map_fd;
> +	int sk[2];
> +	int files[NR_FILES];
> +	__u64 inos[NR_FILES];
> +	char paths[NR_FILES][64];
> +};


> +
> +FIXTURE_SETUP(scm_rights_denial_bpf)
> +{
> +	struct bpf_program *prog;
> +	char lsms[256] = {};
> +	int i, fd;
> +
> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +
> +	fd = open("/sys/kernel/security/lsm", O_RDONLY);
> +	ASSERT_LE(0, fd);
> +	ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));


> +	close(fd);
> +
> +	if (!strstr(lsms, "bpf"))
> +		SKIP(return, "BPF LSM not active (boot with lsm=...,bpf)");


> +
> +	self->obj = bpf_object__open_file("scm_rights_denial_lsm.bpf.o", NULL);
> +	ASSERT_NE(NULL, self->obj);
> +	ASSERT_EQ(0, bpf_object__load(self->obj));
> +
> +	prog = bpf_object__find_program_by_name(self->obj, "scm_rights_deny");
> +	ASSERT_NE(NULL, prog);
> +
> +	self->link = bpf_program__attach_lsm(prog);
> +	ASSERT_NE(NULL, self->link);
> +
> +	self->map_fd = bpf_object__find_map_fd_by_name(self->obj,
> +						       "denied_inodes");
> +	ASSERT_LE(0, self->map_fd);
> +
> +	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, self->sk));
> +
> +	for (i = 0; i < NR_FILES; i++) {
> +		struct stat st;
> +
> +		snprintf(self->paths[i], sizeof(self->paths[i]),
> +			 "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
> +		self->files[i] = mkstemp(self->paths[i]);
> +		ASSERT_LE(0, self->files[i]);
> +
> +		ASSERT_LT(0, dprintf(self->files[i], SECRET(i)));
> +
> +		ASSERT_EQ(0, fstat(self->files[i], &st));
> +		self->inos[i] = st.st_ino;
> +	}
> +}
> +
> +FIXTURE_TEARDOWN(scm_rights_denial_bpf)
> +{
> +	bpf_link__destroy(self->link);
> +	bpf_object__close(self->obj);
> +
> +	for (int i = 0; i < NR_FILES; i++) {
> +		if (self->files[i] >= 0) {
> +			close(self->files[i]);
> +			unlink(self->paths[i]);
> +		}
> +	}
> +
> +	close(self->sk[SK_SENDER]);
> +	close(self->sk[SK_RECEIVER]);
> +}
> +
> +static int deny_inode(int map_fd, __u64 ino)
> +{
> +	__u32 tgid = getpid();


> +	return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
> +}
> +
> +static int set_notrunc(int sk)
> +{
> +	int one = 1;


> +	return setsockopt(sk, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
> +			  &one, sizeof(one));
> +}
> +
> +static int send_fds(int sk, int *fds, int n)
> +{
> +	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))] = {};
> +	char data = 'x';
> +	struct iovec iov = {
> +		.iov_base = &data,
> +		.iov_len = sizeof(data),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = ctrl,
> +		.msg_controllen = CMSG_SPACE(n * sizeof(int)),
> +	};
> +	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> +
> +	cmsg->cmsg_level = SOL_SOCKET;
> +	cmsg->cmsg_type = SCM_RIGHTS;
> +	cmsg->cmsg_len = CMSG_LEN(n * sizeof(int));
> +	memcpy(CMSG_DATA(cmsg), fds, n * sizeof(int));
> +
> +	return sendmsg(sk, &msg, 0);
> +}
> +
> +static int recv_fd_slots(int sk, int *slots, int *msg_flags)
> +{
> +	int nr_slots;
> +	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))];
> +	char data;
> +	struct iovec iov = {
> +		.iov_base = &data,
> +		.iov_len = sizeof(data),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = ctrl,
> +		.msg_controllen = sizeof(ctrl),
> +	};
> +	struct cmsghdr *cmsg;
> +
> +	if (recvmsg(sk, &msg, 0) < 0)
> +		return -1;
> +
> +	*msg_flags = msg.msg_flags;
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	if (!cmsg)
> +		return 0;
> +
> +	nr_slots = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
> +	memcpy(slots, CMSG_DATA(cmsg), nr_slots * sizeof(int));
> +
> +	return nr_slots;
> +}
> +
> +/* Prove a received fd works by reading back the file's content. */
> +static int check_secret(int fd, int idx)
> +{
> +	char want[32], got[32] = {};
> +
> +	snprintf(want, sizeof(want), SECRET(idx));
> +	if (pread(fd, got, sizeof(got) - 1, 0) < 0)
> +		return -1;
> +
> +	return strcmp(want, got);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_allowed)
> +{
> +	int slots[NR_FILES], nr_slots, flags, i;
> +
> +	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +	ASSERT_EQ(NR_FILES, nr_slots);
> +	EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +	for (i = 0; i < NR_FILES; i++) {
> +		ASSERT_LE(0, slots[i]);

Why do you assert less-or-equal? You want a valid fd so you should
expect >= 0?

> +		EXPECT_EQ(0, check_secret(slots[i], i));
> +		close(slots[i]);
> +	}
> +}
> +
> +TEST_F(scm_rights_denial_bpf, first_denied)
> +{
> +	int slots[NR_FILES], nr_slots, flags;
> +
> +	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[0]));
> +
> +	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +	ASSERT_EQ(NR_FILES, nr_slots);
> +	EXPECT_EQ(0, flags & MSG_CTRUNC);
> +	EXPECT_EQ(-EPERM, slots[0]);
> +
> +	ASSERT_LE(0, slots[1]);
> +	EXPECT_EQ(0, check_secret(slots[1], 1));
> +	close(slots[1]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_denied)
> +{
> +	int slots[NR_FILES], nr_slots, flags, i;
> +
> +	for (i = 0; i < NR_FILES; i++)
> +		ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[i]));
> +
> +	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +	ASSERT_EQ(NR_FILES, nr_slots);
> +	EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +	for (i = 0; i < NR_FILES; i++)
> +		EXPECT_EQ(-EPERM, slots[i]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
> +{
> +	int slots[NR_FILES], nr_slots, flags;
> +
> +	/*
> +	 * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
> +	 * truncated at the first denied fd and MSG_CTRUNC is set.
> +	 */
> +	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
> +
> +	ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
> +	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +	ASSERT_EQ(1, nr_slots);
> +	EXPECT_NE(0, flags & MSG_CTRUNC);
> +
> +	ASSERT_LE(0, slots[0]);

Why do you expect less-equal than zero? Don't you need ASSERT_GE()
because you want slots[0] to be a valid file desscriptor?

And even the other way around... Zero is a valid file descriptor so on
failure you must expect ASSERT_LT()?

-- 
Christian Brauner <brauner@kernel.org>

