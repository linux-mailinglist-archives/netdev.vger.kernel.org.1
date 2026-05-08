Return-Path: <netdev+bounces-285982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBjNKTZX/mmupQAAu9opvQ
	(envelope-from <netdev+bounces-285982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDE4FBF9E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AA93091088
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBB279907;
	Fri,  8 May 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw94ObXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787D29AB05
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276000; cv=none; b=B19iNR4fXe5ELhKnGV4l3O19iihU8iIvMbXIpP8yTI3DgL0BLYVdDLDAdtJUa9bg67Odt8BCHCSTkLPNet8jeC/JH0wZsSfbavRUbLqYXxfYBPwnL+xVSpk17ju8qO0pCc3K0SxbzM8gOkLMDc36VhteEF4iATqFcZODY4j8ZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276000; c=relaxed/simple;
	bh=Fpv8vqcTDP2OD325rdpzUCJg2tHK1JG8n9fGJE8gGjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrfxqxzw8EfmREx0QsCkzSHiamXW0+tVIjwm1STaqaGtwMi27UxoseU957V19GXCx+Ddb0J/W7FP/D0R1T4VyqlZhy9HRv+KW4+D1+mCTzrhI8uL6UDs1qoT6jhOtGZBiFP6X9eLGCoGmMl60isW3XfLp1cssUWlRsenSEH7OT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw94ObXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ACFC2BCF5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778275997;
	bh=Fpv8vqcTDP2OD325rdpzUCJg2tHK1JG8n9fGJE8gGjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fw94ObXJF64zyCYMhBC9f8t/4NKxlxnxfhaSJtOz1LgVoZYhm/R2irJI3jmmXBWg0
	 wIiXtgyzxWlpP7DzGVGoe3UwwppWEQdBQ2XNIFwy1NdWudM7xLi5jfvfcmaOoYQtz9
	 SXLeAzTu6zw0LHQnD3eN8ID8PBF6+8HLXGFnf1RfcYpk0q7NvToEzK+pjuoc2ThRIl
	 Ycy0l86JCAT9Z6tXFMxfLfLHJTu4FthUrBJACbCuQXen0QAwxBzIWZEIgFFXGHX54c
	 geuxXxt54z6ZAyMwZ08FGB2l8Kx3lOjkdUBF1Je2pA+j2T4rrVPH2Y7IZGAYRn5VLC
	 aKp15bcANxLGw==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso23258536d6.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 14:33:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/BrlQEjys61mIdCef1ceueNInjGjWAv0DshE4yb7oByRLsTKv7sYDTXss/VVmwwg+kJthReCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIF5iU+OmrPJXc7HoHWzZmLyRd3jiETrwW/VpTPWVEtfRYPLvK
	mjUJPeVs5I+VxUVr3RH3QQ3t1ujkupGqZdcVIaHG3SFMWwggRP1HDC3Z+/j8WC+LjzK2627vIh/
	o6Vw2TlUXTRa4VP21TALxYOqVOgRQjvM=
X-Received: by 2002:a05:6214:3f88:b0:8bc:15b:aa6 with SMTP id
 6a1803df08f44-8bc46bc64d8mr211395376d6.44.1778275996984; Fri, 08 May 2026
 14:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108010728.207536-1-houtao@huaweicloud.com> <20250108010728.207536-2-houtao@huaweicloud.com>
In-Reply-To: <20250108010728.207536-2-houtao@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 May 2026 23:33:05 +0200
X-Gmail-Original-Message-ID: <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
X-Gm-Features: AVHnY4Knk9WhdOnOaKS4fye1tq5_PhBoNxLXm78yAE1krFiPnKdL9lJR161UyE0
Message-ID: <CAPhsuW6hMX9LqnD-0tc=t+TDUFA7j8WUgNEshnYtUwwCDX-J5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/16] bpf: Remove migrate_{disable|enable}
 from LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 23DDE4FBF9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285982-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,gmail.com,kernel.org,google.com,iogearbox.net,fomichev.me,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.053];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Jan 7, 2025 at 4:55=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Both bpf program and bpf syscall may invoke ->update or ->delete
> operation for LPM trie. For bpf program, its running context has already
> disabled migration explicitly through (migrate_disable()) or implicitly
> through (preempt_disable() or disable irq). For bpf syscall, the
> migration is disabled through the use of bpf_disable_instrumentation()
> before invoking the corresponding map operation callback.
>
> Therefore, it is safe to remove the migrate_{disable|enable){} pair from
> LPM trie.

We got some ENOMEM from bpf_map_update_batch() on LPM_TRIE.
I suspect, this is the trigger, as we are missing
bpf_disable_instrumentation() in bpf_map_do_batch(). IOW, I think we
need something like the following.

Thanks,
Song

diff --git i/kernel/bpf/syscall.c w/kernel/bpf/syscall.c
index 3b1f0ba02f61..a8d5959a96bb 100644
--- i/kernel/bpf/syscall.c
+++ w/kernel/bpf/syscall.c
@@ -5686,6 +5686,7 @@ static int bpf_map_do_batch(const union bpf_attr *att=
r,
                goto err_put;
        }

+       bpf_disable_instrumentation();
        if (cmd =3D=3D BPF_MAP_LOOKUP_BATCH)
                BPF_DO_BATCH(map->ops->map_lookup_batch, map, attr, uattr);
        else if (cmd =3D=3D BPF_MAP_LOOKUP_AND_DELETE_BATCH)
@@ -5694,6 +5695,7 @@ static int bpf_map_do_batch(const union bpf_attr *att=
r,
                BPF_DO_BATCH(map->ops->map_update_batch, map,
fd_file(f), attr, uattr);
        else
                BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
+       bpf_enable_instrumentation();
 err_put:
        if (has_write) {
                maybe_wait_bpf_programs(map);

