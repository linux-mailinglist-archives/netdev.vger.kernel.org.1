Return-Path: <netdev+bounces-305239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GRm8IZ03TGpZhwEAu9opvQ
	(envelope-from <netdev+bounces-305239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E12716476
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:17:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=onk9ehAK;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305239-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305239-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F54303F066
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60B3DD538;
	Mon,  6 Jul 2026 23:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD723A0B24
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:17:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379847; cv=pass; b=uFCjzfXMEIcKgmcDa0KyC0tXSBz2qpUfF9SYtBnaFNHYGuJpRe7f7wbx/mdH5rBJD0a1sHCy5H6FYpuorzS3F3hXzI7W/NsxSaSWBGkN37t2nmZZeG+lWpiAIphOImbvUzzaj5ICssgyDgCYCgkLuwwGBQYVS/2M0IatEVJCsjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379847; c=relaxed/simple;
	bh=dLk3l8o6wKpS2bhAj8bomNH493j7PIlHJrP2s7SSSzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raG8nFyTEL44m+kt8sI/QeM1TqkmbrdY6ism2th/DyIQ+yxpZ/0c5wyLIWgXWFMNzJ54lqdwJaXxz0yOtODVXoI4x+tFnGTnmExo36VNU7rjrBLVMysbysXOIvHr1l+ROAGKy3rWs1OixksfhIA4pUOyNui2ZEIbUpjkihZbvLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onk9ehAK; arc=pass smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7c61b5292so51751405ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783379844; cv=none;
        d=google.com; s=arc-20260327;
        b=l/cb0XUzd9cwjgx5/wH4mH+/d4xo+zKQify1yD1+SenW/FpqgNU4xEUYtnlZbfrEsN
         3f0yXogE57VEdJdYXz9szV+A+3kQ9IAEwz9pd4mGSgEhmg29m1vGub4U1KOttB3wkrC0
         e6IWnNedBOEWgmnWiSf+/rZzqFwFyWEyx3CaF8tR5rHz66MY+nXzJ2E/+TOqfeKsMWgG
         XGh9EkFJUw/oeDIm3iDWOuT67lRe6kbnM94Gw9IiPOttXegd+bcG5Jk/Nc4++zruhy2U
         iwaIJvqrSsgvu0M8SWqj2jLvKhvBkLzPOVeDzt1mImjnsTEcZbQilDjLZ0W/wDug1pIi
         E/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        fh=X7IsDcoJzEXd05MJGtxPkZ0yQBhiO6gtQJupxlYmAms=;
        b=oib4jnY0g/n1aOrL6PFZVLo2AOY6sHezGYZ/7FLyGEmTN4zBrax8KSAivQ47LhEM/G
         fFwn/EaxRVJ/fkmt/vjMrd/OPhYLKuNHshix0pQGt62D1lg6Swf0/K5yEV/cZwwdadBI
         p+D/4Arfv1fVTiqBk4UywiT46MhJugNyQkvCw0MG8K1sJlzhlQZ7H6wfn2Eh6xpinJFX
         BOhqm3flauo0XDgyd4c70t91hJCvug2JxdtFKNnk4j5SlxESyKGCaD2ib/iMiDJCKvzC
         8V56LTbPFmxVaCb2HU02VFZvUCN5J3IW7LRdgFZ2Xugf80HoPzstNOLgnntgfS0y5DRp
         HhSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783379844; x=1783984644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        b=onk9ehAKukv9SrKG2pmgsC/pGjqcl2y4gNZ7+BKuzIX8bB6vSLNJ8I6BnGW070dXK6
         wmQcn3PlYzmTpGY8y5aXG3MWzo6lkoLjNcLZQK+W2AV6ziQwxqj6bNRXyDB6PG50dKcs
         V2dFokHG8Bx46SDq+Ce+n7srJVGj4FLbkQpVZq/GoP2lAyN+hK4NKZj+eXF5Irt3Iwey
         BhvDCeEnzm2M24VEGX42nupmb/HV5nCv80ycWi4kMJAhQnYVKdj/JA8CluC3nGI1ZTcS
         +VvLXPX+AjvqXMP6A0Dm2+kHFnzMySi3tKidpdsSLpRFciPc0S1UrwPE0g8Eyw20IEPh
         ll3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379844; x=1783984644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+8qKp600TVGZqCnC9V4CuKTCWgTklOkq2jFp4B/wF8=;
        b=q/AFp/PQHuQYWD7YMJKydInXnZtRUWVlCuXZucaRokMh4yqw16cyhxfKIfBltDwtB+
         Hkw2QjkxmaRGK3x6VM5ZnPRiaIjcyWN+AajtXVKNXX7ZvJFeuuLbDriFDs+Ip7W/Dnci
         dB43+RJu1CXv9iG3x+QIwnxzhBKhfgRCbDwN2BuAj3/oMGcWcvXTo49OWqP2xbF7PiVQ
         xyMwch/9Yg9Fv/VHmJ8dTFdq96TFeOqd8IXBwpBT5XIEogkyqGtsu2Gt3bBcYumID5m2
         95klzlfR/Dpw3+t6NYCDiFtL5zIF+P3yvbV9w4zGs6Fl5onHwFSya1DKEGz3z3A5FMDD
         K6tw==
X-Forwarded-Encrypted: i=1; AHgh+RoqfMluQyONd/iP0aXPJ4dL60eq0zYFOKS+JgUkyO8gUHlO2+C5q3SscYQg3MHakzQj/uxM6Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zMMPskSITeCc1xPf2+EHWIHmrlIzb4uWwAaRECZgupzdaLwI
	2XJKOxAaRkUP7pmK9KvMfQz6foPPdtX2uDj6XrItQMcIbH2OJ8D4+e1hs132N0nkx4bgFJ/xalD
	fOLvKe6LR0aRJInDJgYMnD2RaM8hz/ZzycyrUC1iL
X-Gm-Gg: AfdE7clgY/R5MA4Y3GbcmV/HG5vzT7v4H+ETKfnt/kZdRPq0qtn+IMo6nIEWYs0uFKq
	G64WDWuMvjOQ6bIM3S8pm1aVUAty9U8P9sZX/1H0Fvnp/xWQwzUhae8OKnTZ8U8UN2FVNyuR4uj
	TG2lqLg3elYMT1IU+yD9I4UHzKVxMoSMSl5Oy+CErtEMYtSBn1EGTtPaUCt/7820lH/Q9fGk+WD
	4gh2yb8EI9cMa7ycTqp44lvqwy6tO+smlhoTjH59i2QipER1owRqKoWzwpG65lfLy+ITUMscgoT
	thJlqkSlFzvAlhRT9r7QZ1K4zhCmB019fuMmSY0ZMTqcE+J/6p6ptKqEJtivxbWhzYUx/PbEaVT
	TFygbzRN0gUcbVfyl4zP5iz4HbxBH3qgSJTS/aw==
X-Received: by 2002:a05:6a20:c786:b0:3b3:be05:2b73 with SMTP id
 adf61e73a8af0-3c08ecd72famr3009005637.18.1783379843218; Mon, 06 Jul 2026
 16:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl> <20260705123826.3818443-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260705123826.3818443-4-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 16:17:11 -0700
X-Gm-Features: AVVi8CfHos24Kv9fVUY1fKP13GD0sDCI86-gLPvh-ecHWsAM5E-pX13a8-b3DE8
Message-ID: <CAAVpQUA_hhHRr60HWmZqHMT5Gfaiq6D8zjmuqT3KikuUtm9Eiw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305239-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,xs4all.nl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7E12716476

On Sun, Jul 5, 2026 at 5:37=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> Tests SCM_RIGHTS fd passing on a socket with the new socket option
> SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> call, BPF is used. The BPF program shares a hashmap with userspace that
> lists the inos to be blocked (of the receiver tgid).
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Assisted-by: LLM # used LLM to get skeleton BPF and libbpf code
> ---
>  .../testing/selftests/net/af_unix/.gitignore  |   2 +
>  tools/testing/selftests/net/af_unix/Makefile  |   8 +
>  .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
>  .../net/af_unix/scm_rights_denial_lsm.c       | 263 ++++++++++++++++++
>  4 files changed, 309 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.bpf.c
>  create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial=
_lsm.c
>
> diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testi=
ng/selftests/net/af_unix/.gitignore
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
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index 4c0375e28bbe..594cd26ec398 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -11,9 +11,17 @@ TEST_GEN_PROGS :=3D \
>         scm_inq \
>         scm_pidfd \
>         scm_rights \
> +       scm_rights_denial_lsm \
>         so_peek_off \
>         unix_connect \
>         unix_connreset \
>  # end of TEST_GEN_PROGS
>
> +TEST_GEN_FILES :=3D scm_rights_denial_lsm.bpf.o
> +
>  include ../../lib.mk
> +include ../bpf.mk
> +
> +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS +=3D -I$(SCRATCH_DIR)/include
> +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS +=3D -lelf -lz
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bp=
f.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
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
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct inode {
> +       unsigned long i_ino;
> +} __attribute__((preserve_access_index));
> +
> +struct file {
> +       struct inode *f_inode;
> +} __attribute__((preserve_access_index));
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 16);
> +       __type(key, __u64);     /* inode number */
> +       __type(value, __u32);   /* tgid of the receiver being tested */
> +} denied_inodes SEC(".maps");
> +
> +SEC("lsm/file_receive")
> +int BPF_PROG(scm_rights_deny, struct file *file)
> +{
> +       __u32 tgid =3D bpf_get_current_pid_tgid() >> 32;
> +       __u64 ino =3D file->f_inode->i_ino;
> +       __u32 *owner;
> +
> +       owner =3D bpf_map_lookup_elem(&denied_inodes, &ino);
> +       if (owner && *owner =3D=3D tgid)
> +               return -EPERM;
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c =
b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
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
> +       struct bpf_object *obj;
> +       struct bpf_link *link;
> +       int map_fd;
> +       int sk[2];
> +       int files[NR_FILES];
> +       __u64 inos[NR_FILES];
> +       char paths[NR_FILES][64];
> +};

Could you add FIXTURE_VARIANT() and cover all types ?
SOCK_STREAM, SOCK_DGRAM, SOCK_SEQPACKET


> +
> +FIXTURE_SETUP(scm_rights_denial_bpf)
> +{
> +       struct bpf_program *prog;
> +       char lsms[256] =3D {};
> +       int i, fd;
> +
> +       if (geteuid() !=3D 0)
> +               SKIP(return, "requires root");
> +
> +       fd =3D open("/sys/kernel/security/lsm", O_RDONLY);
> +       ASSERT_LE(0, fd);
> +       ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));

This style is easier to follow the logic for me.

err =3D func();
ASSERT_LT(val, err);


> +       close(fd);
> +
> +       if (!strstr(lsms, "bpf"))
> +               SKIP(return, "BPF LSM not active (boot with lsm=3D...,bpf=
)");

Could you add minimal relevant configs (CONFIG_BPF_LSM etc)
to tools/testing/selftests/net/af_unix/config ?

NIPA (netdev CI) uses it as the base config.


> +
> +       self->obj =3D bpf_object__open_file("scm_rights_denial_lsm.bpf.o"=
, NULL);
> +       ASSERT_NE(NULL, self->obj);
> +       ASSERT_EQ(0, bpf_object__load(self->obj));
> +
> +       prog =3D bpf_object__find_program_by_name(self->obj, "scm_rights_=
deny");
> +       ASSERT_NE(NULL, prog);
> +
> +       self->link =3D bpf_program__attach_lsm(prog);
> +       ASSERT_NE(NULL, self->link);
> +
> +       self->map_fd =3D bpf_object__find_map_fd_by_name(self->obj,
> +                                                      "denied_inodes");
> +       ASSERT_LE(0, self->map_fd);
> +
> +       ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, self->sk));
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               struct stat st;
> +
> +               snprintf(self->paths[i], sizeof(self->paths[i]),
> +                        "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
> +               self->files[i] =3D mkstemp(self->paths[i]);
> +               ASSERT_LE(0, self->files[i]);
> +
> +               ASSERT_LT(0, dprintf(self->files[i], SECRET(i)));
> +
> +               ASSERT_EQ(0, fstat(self->files[i], &st));
> +               self->inos[i] =3D st.st_ino;
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(scm_rights_denial_bpf)
> +{
> +       bpf_link__destroy(self->link);
> +       bpf_object__close(self->obj);
> +
> +       for (int i =3D 0; i < NR_FILES; i++) {
> +               if (self->files[i] >=3D 0) {
> +                       close(self->files[i]);
> +                       unlink(self->paths[i]);
> +               }
> +       }
> +
> +       close(self->sk[SK_SENDER]);
> +       close(self->sk[SK_RECEIVER]);
> +}
> +
> +static int deny_inode(int map_fd, __u64 ino)
> +{
> +       __u32 tgid =3D getpid();

nit: newline here

> +       return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
> +}
> +
> +static int set_notrunc(int sk)
> +{
> +       int one =3D 1;

nit: ditto.

> +       return setsockopt(sk, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
> +                         &one, sizeof(one));
> +}
> +
> +static int send_fds(int sk, int *fds, int n)
> +{
> +       char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))] =3D {};
> +       char data =3D 'x';
> +       struct iovec iov =3D {
> +               .iov_base =3D &data,
> +               .iov_len =3D sizeof(data),
> +       };
> +       struct msghdr msg =3D {
> +               .msg_iov =3D &iov,
> +               .msg_iovlen =3D 1,
> +               .msg_control =3D ctrl,
> +               .msg_controllen =3D CMSG_SPACE(n * sizeof(int)),
> +       };
> +       struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&msg);
> +
> +       cmsg->cmsg_level =3D SOL_SOCKET;
> +       cmsg->cmsg_type =3D SCM_RIGHTS;
> +       cmsg->cmsg_len =3D CMSG_LEN(n * sizeof(int));
> +       memcpy(CMSG_DATA(cmsg), fds, n * sizeof(int));
> +
> +       return sendmsg(sk, &msg, 0);
> +}
> +
> +static int recv_fd_slots(int sk, int *slots, int *msg_flags)
> +{
> +       int nr_slots;
> +       char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))];
> +       char data;
> +       struct iovec iov =3D {
> +               .iov_base =3D &data,
> +               .iov_len =3D sizeof(data),
> +       };
> +       struct msghdr msg =3D {
> +               .msg_iov =3D &iov,
> +               .msg_iovlen =3D 1,
> +               .msg_control =3D ctrl,
> +               .msg_controllen =3D sizeof(ctrl),
> +       };
> +       struct cmsghdr *cmsg;
> +
> +       if (recvmsg(sk, &msg, 0) < 0)
> +               return -1;
> +
> +       *msg_flags =3D msg.msg_flags;
> +
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +       if (!cmsg)
> +               return 0;
> +
> +       nr_slots =3D (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
> +       memcpy(slots, CMSG_DATA(cmsg), nr_slots * sizeof(int));
> +
> +       return nr_slots;
> +}
> +
> +/* Prove a received fd works by reading back the file's content. */
> +static int check_secret(int fd, int idx)
> +{
> +       char want[32], got[32] =3D {};
> +
> +       snprintf(want, sizeof(want), SECRET(idx));
> +       if (pread(fd, got, sizeof(got) - 1, 0) < 0)
> +               return -1;
> +
> +       return strcmp(want, got);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_allowed)
> +{
> +       int slots[NR_FILES], nr_slots, flags, i;
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +       for (i =3D 0; i < NR_FILES; i++) {
> +               ASSERT_LE(0, slots[i]);
> +               EXPECT_EQ(0, check_secret(slots[i], i));
> +               close(slots[i]);
> +       }
> +}
> +
> +TEST_F(scm_rights_denial_bpf, first_denied)
> +{
> +       int slots[NR_FILES], nr_slots, flags;
> +
> +       ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[0]));
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +       EXPECT_EQ(-EPERM, slots[0]);
> +
> +       ASSERT_LE(0, slots[1]);
> +       EXPECT_EQ(0, check_secret(slots[1], 1));
> +       close(slots[1]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, all_denied)
> +{
> +       int slots[NR_FILES], nr_slots, flags, i;
> +
> +       for (i =3D 0; i < NR_FILES; i++)
> +               ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[i]));
> +
> +       ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(NR_FILES, nr_slots);
> +       EXPECT_EQ(0, flags & MSG_CTRUNC);
> +
> +       for (i =3D 0; i < NR_FILES; i++)
> +               EXPECT_EQ(-EPERM, slots[i]);
> +}
> +
> +TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
> +{
> +       int slots[NR_FILES], nr_slots, flags;
> +
> +       /*
> +        * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
> +        * truncated at the first denied fd and MSG_CTRUNC is set.
> +        */
> +       ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
> +
> +       ASSERT_NE(-1, send_fds(self->sk[SK_SENDER], self->files, NR_FILES=
));
> +       nr_slots =3D recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
> +
> +       ASSERT_EQ(1, nr_slots);
> +       EXPECT_NE(0, flags & MSG_CTRUNC);
> +
> +       ASSERT_LE(0, slots[0]);
> +       EXPECT_EQ(0, check_secret(slots[0], 0));
> +       close(slots[0]);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.55.0
>

