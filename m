Return-Path: <netdev+bounces-290368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FjxKlDvDmqmDQYAu9opvQ
	(envelope-from <netdev+bounces-290368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A865A4261
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42838301B3FA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F23C345F;
	Thu, 21 May 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vzecz3l8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B93C09FC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363662; cv=pass; b=Uy0kRUtn+qHsFRc/i1mhcC9/MPvVcxRRNmD9tmaBIm0NBvaZSLJRHJ7PeuYzdpWVj5ueV4GOJIrug2Kc7QE2X/fN8i2Seab5uoBxUBhtP9b16AggW89aw9qUxF9ZboLPCxl2yq/D4HD2y2lJxZSBP0XS8wh/UFzaXjZeFd298Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363662; c=relaxed/simple;
	bh=riJyyQBHmcmUr4FLiqYcGUxqo/3HIffc80/U9WyxWpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/oKR45Wv0vfyjgcvfR9u9mzZeTCRrDRE1ZR6exvMJ4Hr4ZVc1w5hlYjJS/UkjDYGg27X7cjBbxUIax45zr+V1oQhnLuYcZPUHP9J4hoBIF+xQBniAGsPw8OWBBNnj+GX2P+5aNAicITJ8FY+YxNxkbloVp+WztLJamssU3Ipk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vzecz3l8; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e61648f10so601cf.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 04:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779363659; cv=none;
        d=google.com; s=arc-20240605;
        b=ace/ADIRInBNN+JLg1T/kYZXfujrHsutg8CcwHL84+SOkzeBzm6VPZK5+ZfUG1vv09
         1EcVIhWv22AWe97nmnMKIyZcnS3qwepiWupeHsb0oGv+jAUJJXneVjZcrrb0rsQPfcvd
         eXD7+azOjJO8z1J/JqFmKB3iLzcWHYrQLCqsKNy1o6oNMIEkK8LjS4yKFQ+jXL+Tgl8V
         U7olAjQ0kcZbcSxOCa7yQYNpieu8+xILs3Q0RUvKQjW2GXRVFVsl1wtMxb025av5qTcR
         WuJgt1fVd5qkbY/kegAi5XeXfUYhdpPlVQFRPCi04tJupfM9qk3BB+9lFmvts6QmVXJr
         Durw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        fh=UpPXQTcTpa94UrdfgRcHmxl8aN+axoqCHro7AP74aLk=;
        b=hsFd9jlYxaF86GPvlCI8GC/5zGrXRCfHMDjwe4KbLJBm9SyrqzqRdGp6WM1R9sZ923
         SnxNJaujRXo1o/zp05P+pxPPyRUeaYguQSBk+hm6VCEiAPz6Te0EW7lOKsU4eXYhmHi6
         p0AE9z4slVr5DQbgMCuasJWXH4fbvZln6wHRyqLiGxR5Pw1QQxmpPAU98NmejHE1NRp/
         cWY58+DYzIzhT1lwnyTead6+SxVfvUoWeIQ4b4xpf7wwEAWM5hefAWuzRg8k5fP2mX/8
         cFyxKWDle34RvLUSvUQ2nElmq36iaLGlqvoCpvf1u2f+pok/R35IEdlLiNJz0M+ZHQ0v
         sy1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779363659; x=1779968459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        b=Vzecz3l8Z8HlAE4eXB8ac5yjuUr4scO3+amtVCTVTVI1ycbXZBN02VySl2SEpkBlpV
         84+FJcIY8BRpNlclBLyw9mqiqQN/V2a6iRMJBzccwJ77T9nSkvQM7fx2LUYoE1z8P31u
         5kJidmpgtJ1/c3FWli28BxVI+i95FkHphTF6ql6JZQUTdd9cTALUZc4G9k3Hl5gaYAfx
         PgsleDCtdrbGvDw3EaCfAK4+FGdrpxCrlWjmv2l4XYXIyG7YnBe8MrJgCoIwYNr78zUy
         xP8jgsnTuVuqh2rhFPLMNVb+GjHC21hAhOR8r827ZtTJsKU/TLNmO09z8SAtSMY0Xf9u
         6MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363659; x=1779968459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/o74v8Vq3GABGlC1t1lTUtlP7/VYHfplVzyMXpW76dY=;
        b=Zs/NYhas7BG7z3PBcSy4laicb6dfXZCghr4o0K9xFvq0tri+H8sFvAzkaX6kc6JJkH
         6vOZZPJA6IHKS2aLb3zsEm9pbqFsUx8K7u2fzD399+zxCPpu83JIPuyFCLGrgw1DnUNY
         fmCv6k9fRE9eV1Eb7CEHSN4gSOt/tt4VabB7EBSNSe7xC6BuvwApVB8p39OBy4rJyGPe
         8peXKIQinDqoX20SP19DX0JHjz7Lbuz55XOqx7II6Q94kZ1/h5aYYCZA1ajP7VI0i5hx
         SHhJriDxQiQkvY/hKn1U9JvNBNHP8weUKlDfPkPLhJjPBOeL8guD2S3QMjYWZEclLRPk
         XRgw==
X-Forwarded-Encrypted: i=1; AFNElJ8gMmnjHWOmGldsn7kA9rpL5L8TCmpO2XVp4KR2B0k8ISUVpCdM6dyrcnXy1Yrmxqa76l+SzV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHw0zFBo7bmNavSMl9xghUkvAR2TR0hc0R2vqGc+8ytU3bZQTG
	0+uxVv2iZlcGyCSB/wGwOGJQMnbsiTWfgX/SELGOyJ+HJV+SpcqHDPxTChFdpfsgQbnDSnc/2Jz
	8TCd9h2n1kyZk+6D/k8E1GZLUo+IHRUCHtDwCBmOW
X-Gm-Gg: Acq92OG2tX+8y0GwwDkigAeR9JplYRL/qJ1sjPnRZeDPfUK1QphCupSAJTSosXvKS/8
	UKABoF62e0DwJkdKs8JT28vzoMvuLZrUt9UWgKEK55Kb/3rU5r1fduEzTFoiRn8XPUWia4RnURB
	XGWmhncJdY20+AkXAytvF76EMHqVigMMgAXdEVKU1yr5vS0XiLNuJlnDp0jw5+kjHkQ/XZRrmas
	slMnLiN5woDNxy2VxKWXPsCKmFa++oS9zK4kUDbXR8RlOy5bzJaW03npvl/55HtmKSK054hCLFL
	wKMBIX1e3mNWt87JSnvWPDvP+WibtvaPig71OE9bGbwgMbKKRQ==
X-Received: by 2002:a05:622a:4cc5:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-516c552713emr8883241cf.19.1779363657940; Thu, 21 May 2026
 04:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com> <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
In-Reply-To: <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 21 May 2026 20:40:16 +0900
X-Gm-Features: AVHnY4KDqeWgH1b717hobUKU0xoHOtcJ-628JzCiilCfBkbsFuci0Aw-f-9_VXQ
Message-ID: <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, ast@kernel.org, andrew+netdev@lunn.ch, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	edumazet@google.com, kuba@kernel.org, jolsa@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	razor@blackwall.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, 
	song@kernel.org, sdf@fomichev.me, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, maze@google.com, 
	lorenzo@google.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290368-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[29];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65A865A4261
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>This looks like a bug fix for an out-of-bounds write vulnerability.
>Should this include a Fixes: tag to identify which commit introduced the
>unconditional copy_to_user() calls for query.revision without checking
>the user-provided buffer size?

 > Fixes: 3fe213c040b3 ("adding ci files")

I completely missed this checkpatch comment. I will add the Fixes tag
in v2 if there is a consensus that this patch is the right approach to
resolve the issue.


On Fri, May 15, 2026 at 5:14=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> >     bpf: align syscall writeback behavior with caller-declared size
> >
> >     The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input=
, but
> >     several commands write outputs back to userspace unconditionally. B=
ecause
> >     copy_to_user() does not fault on adjacent mapped memory, a short us=
erspace
> >     buffer results in out-of-bounds writes, potentially overwriting adj=
acent
> >     userspace memory.
> >
> >     Address this by introducing two policies based on field type:
> >
> >     1) Mandatory fields (original ABI): Return -EINVAL in __sys_bpf() i=
f the
> >        buffer size does not cover them. This hardens the syscall front-=
gate
> >        for the following commands:
> >        - BPF_PROG_QUERY (min size: query.prog_cnt)
> >        - BPF_PROG_TEST_RUN (min size: test.duration)
> >        - BPF_*_GET_NEXT_ID (min size: next_id)
> >        - BPF_OBJ_GET_INFO_BY_FD (min size: info.info_len)
> >        - BPF_TASK_FD_QUERY (minimum size: task_fd_query.probe_addr)
> >        - BPF_MAP_*_BATCH (min size: batch.flags)
> >
> >     2) Optional fields (later revisions): Skip writeback if the buffer =
size
> >        does not cover the field. This is applied to BPF_PROG_QUERY's
> >        'query.revision'. Older userspace passing a smaller size (e.g., =
40
> >        bytes) will have the write safely skipped. This size-gating patt=
ern
> >        mirrors the existing precedent used for 'log_true_size' (verifie=
r.c)
> >        and 'btf_log_true_size' (btf.c).
> >
> >     To support this, the user-declared 'size' is plumbed from __sys_bpf=
()
> >     through the query dispatchers (cgroup, tcx, netkit) to the underlyi=
ng
> >     writeback helpers in cgroup.c and mprog.c.
> >
> >     Cc: Maciej =C5=BBenczykowski <maze@google.com>
> >     Cc: Lorenzo Colitti <lorenzo@google.com>
> >     Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> >     Link: https://lore.kernel.org/r/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02n=
OMkCCR-YBZbOm2suWA@mail.gmail.com
>
> This looks like a bug fix for an out-of-bounds write vulnerability.
> Should this include a Fixes: tag to identify which commit introduced the
> unconditional copy_to_user() calls for query.revision without checking
> the user-provided buffer size?
>
>   Fixes: 3fe213c040b3 ("adding ci files")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/259059=
28331

