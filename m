Return-Path: <netdev+bounces-288855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLq1IsWeCmpJ4QQAu9opvQ
	(envelope-from <netdev+bounces-288855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BE565DD3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2479530028BC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F30388375;
	Mon, 18 May 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxptlgZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E7380FFD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080888; cv=pass; b=WDi9PkET7Y2bwMv3OJCJwjgYfX/6DYKoXjKqujv4x1+mXig8zclGYXqnxg0eFWg8jNixCbgM/hOLH/GlI5el3qEccUP1wGP5ZNb1mgRi7M2Tb8EeSRl0N1L9oq8mHNIfHHBO4Z8Uz8tgLoo1c/g8HAXbWBShnLsYNo7dNjiYMGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080888; c=relaxed/simple;
	bh=Z6E0MXc38WsNUpI9/E+q7zdtFMGyY0/TRIM+ulMUnZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCE4oHzLM9l+0WVSX5NwFjd0F1gGViC5sfImEh1Z9iWM49l8/K5z2EagqBp7ASgm6nFcJXCCNeaCXPa4QmNANkpSWdegwIBNOgZ27jqnB1oMDXC19c8BfVSXY8VrACca1NefMnFGhjF6omUoNWKo1qGJTZakPe2Nz1u+tb5MI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxptlgZF; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e61648f10so10281cf.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080886; cv=none;
        d=google.com; s=arc-20240605;
        b=epbAY/gRE2O81ZfvZRfb6EXZxwodNllO/y1U9RztBRWv9bCWDpk9iyVD/J1eVFaIRC
         JhIWfHbm2whYXC9ydYMQEtWHHwwZDiDbyjlHSOpOQqwDhPpk9KMKgsb2xzSxXaMdXF4j
         NA3d3ecAT2nxy2obrC2nG62SnuV/BKw/3Az/X1zmo1i2IR5tW5FH1Tba0azGhPjIDeSg
         ferRjP7Kb0kpOTHDkfPvhUxM+sgzoaY6XoMnngAWLqJIDONrHNO9g/Hjlsec8pCBzxuN
         qyv84VbmwL0X8GVP0npRyRlPnY8tDwIGL88cZOfNS/4bkSIiwXFJp0cbGYvRvhLtcAzF
         pYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        fh=FQuyizQzaIywsae1/h+SH7arjJQGlwu2TWt/2iEnbLQ=;
        b=C24uuiiHJsQcbkaR03QDJKhtgGojeUdsaM7Dj8xoFGnYA8LGCnyvsKNO27VqvWgqGe
         MtCWZt1PwPz0XpH+wLd70FwLwScKEyTNF6TzMdg5C4byjCgMGOuB1p3WkmU+yYkMbH49
         Fxp6WnWi1zzqt/B1yDe4c83xFtm2wA6LOFY7Mbuotas9Wpq+LyjAXC92fXus6YB0Ktzj
         6gYQPx90C1iZFnhiJaXY9+LfWEsWVOdRLkwx4vsDDdVleQmH9ODakiSJ62rBcc8owAN4
         glCMl3alJahi5uuXnD+Fdrbs+U8CQfMWDWU2YqhNKAtmsjCmCSoosLEk0caNaXMQQXqs
         1g5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080886; x=1779685686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        b=KxptlgZF3J2RjP2kA0+rshgJ//Y2dyhyaPxw9rVAq/wVX+Lhg38/L4WQ4iY/gvrpdx
         J+d38d1vidaLJPcaxvMbSJFjfvNEBtKYztVHn6TDMF4Ckg5ZroP0rdYtTnasZYkjbh9/
         3aKOk3QW+5LnnhHBez8GExoYXDnYd+2QTqgA5VYUQ8yZwexYjc1vNiFf2rlkrC/fN1wy
         +kgbafhdmOhHPniJdt4jFPuZPS4kZatJiAZRkangfgH4BBD+DvA/MmB23JTJqu+sAT2h
         oaDpUOCUii9sE7Arbc3bYmfJOKXMglm8Qkq3HzIZKtoGT03VKCHgYvwSyXm0SK0oINj1
         7GlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080886; x=1779685686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PgGO0nV6zeGKwarKeI0vOixvX+FJHU5rTim5V0Roj1s=;
        b=IwIzDZifbadgq5kCIJ8YK+bny+g855CA/4uboalRIa8/l/9lCpzYEB1eAX2a8oFdXs
         YYWN8BT/YmUy1D1hmtsfDyGT/lmFW5k+cv28RntQ1hW/zkUyZqu3ug9/sjIUvwjlkuSn
         dyTPSgjdzbIswJhrv6/JM+o6Krm/C5YSAWmTy+ffMPUCYYxbkvId9wy1HZWNeUY7Qf0A
         venhxyB6IFpdPTn0MnroJkPGauh9pbQFZ9bAdL6LlSg17O9aoeu1e6m0/IJAWHGYH5/Z
         K0OZMAlmemEFy7qxmyJMyF2pQ4vry94YPiGRvyYc6bU+UdW6g5Z0f6iY8bKg8stOiSVq
         trZA==
X-Forwarded-Encrypted: i=1; AFNElJ+zjrzHNqCMqwiS/CstToeah5IvBt8+CYmvhRm514HV4US5JmOoL34aOYQoNkfBNmoiem1hlGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjLVS2JFi5oWBP9otO2WDMBB6Btz4c9vAYIC8vQdlzA8zOZ38
	6GGZIQQbo7rODxGjASInwjbLZEWLhPJtba/+ZcibuhuzGQzet46K64C+c6OGMerqxehOiPTvvGK
	WVZEz1jofEUHO8j/ZEpCmi8sv2whXv+FbEr49Ynol
X-Gm-Gg: Acq92OFXrnovCkpywyTnnctDkoyoXSrZTXfZPtcozwrPVux+zlQzjex4xBfHJf0Ucx2
	SbEhsAQkBN5T9rzGWkq+4dKRlOpitTliSI993jugIcEPDYOVJHNyTjUiA6NJi6mGnCFFhQ/0vHY
	sBbYc83uC6MHr2Li/5UzVI/zi/zZeqYw0GSlQZgQvveeADBLil7Q2vda7DH0yfZHtb3rf4AzVDh
	jp3dbZaiY6HXBi+MrdfHoJzFARPAzdA2NsmxAOT4wJnzcNJ34gYleBqNKUl9xZba+joUyC3ItGu
	BUsGYw7RRT/hDkmpdf9mlUDw+98hDb8sPGWrabal1xnBY8Ohstj/FDCXTcyp
X-Received: by 2002:a05:622a:5d4:b0:516:4f62:85eb with SMTP id
 d75a77b69052e-51679462c6emr13074271cf.22.1779080885212; Sun, 17 May 2026
 22:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com> <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 18 May 2026 14:07:29 +0900
X-Gm-Features: AVHnY4Id0O4-8DzVSPeGl5IFxiRysVVNPFTf9XpoWx4UkzENJhMEoOAWU_Sb_Xw
Message-ID: <CADXeF1FvFrT4i_=3Z4USRV5XnOzhk92M7ahvcs6LyA9j_tWU9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F7BE565DD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

>The whole thing sounds like a user space bug.

Could you please clarify why you consider this a userspace bug?

From our perspective, this is a binary backward compatibility issue.
An older binary compiled against older UAPI headers has no way of
knowing about newer fields. If it passes size =3D 40 (the correct size
at the time), the kernel violates the ABI contract by writing beyond
that declared size.

> Please demonstrate a case where this issue is seen by using libbpf APIs.

Our old project does not use libbpf; we interface directly with the
raw BPF syscall.

For example, our Android net_test  suite uses this legacy 40-byte
Python ctypes struct layout:

  # legacy 40-byte layout (pre-revision field)
  BpfAttrProgQuery =3D cstruct.Struct(
    "bpf_attr_prog_query", "=3DIIIIQI4xQ",
    "target_fd attach_type query_flags attach_flags prog_ids_ptr
prog_cnt prog_attach_flags"
  )
  # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)

As shown in the original discussion thread, without this fix, a newer
kernel unconditionally writes the optional revision field at offset
56. Since copy_to_user doesn't fault on adjacent mapped memory, this
silently corrupts 8 bytes of the caller's heap (corrupting the Python
interpreter).

This size-gating pattern in this patch should be identical to the
pattern introduced by commit 47a71c1f9af0 in btf.c.

I am not 100% sure but, it seems running a binary statically linked
with an older libbpf version (or directly using raw BPF syscalls)
might face a similar issue? Do we expect those binaries to be broken
in the newer kernel version?


On Mon, May 18, 2026 at 12:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 15, 2026 at 12:15=E2=80=AFAM Yuyang Huang <yuyanghuang@google=
.com> wrote:
> >
> > The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, bu=
t
> > several commands write outputs back to userspace unconditionally. If th=
e
> > caller passes a short buffer, this can lead to out-of-bounds writes,
> > potentially overwriting adjacent userspace memory.
>
> The whole thing sounds like a user space bug.
> Please demonstrate a case where this issue is seen
> by using libbpf APIs.

