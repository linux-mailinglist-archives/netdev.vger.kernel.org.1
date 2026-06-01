Return-Path: <netdev+bounces-293890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CoLE1/UHWq6fAkAu9opvQ
	(envelope-from <netdev+bounces-293890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A581162445E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57063066AA9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4B3EF0D7;
	Mon,  1 Jun 2026 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwvftzJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA43DCD90
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339354; cv=pass; b=g2KDCkmzntXMQ/bkLyr0bKkV1Rg71ayw9FWFFJkEqaQAgPPbCEsJR/ULynE9JIEnfykUSg09OCQnB8V9Gs+mkm0kPkRSBE3nQXrb4uUTUo6bj223Xnk/gWl9TS8UCLTyhu9NF0HJeHqRavZ2dXLgWWxDLvSzW86x8w8FikS4BKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339354; c=relaxed/simple;
	bh=ceIUUz0QUk7dm/8ISeRpOOGqbccQMk4npZ+3ANrKM3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqJSg/DbyVtjQOST31IEhqiUNNEJ0GqhjOAbFgsosItGACLb4crhkNrziNl/4KhCtMK0izZU79dXQQL4X9VDOsRu/X5xB+uGukPUA8Svx0tBPz5v7TJg0mzTdJqgH0MKbsKGSDyVUb5InypClSRXGe/uFKM8KeVBL9PgBQffkLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwvftzJ3; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dc6fbf3e86so53990187b3.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339350; cv=none;
        d=google.com; s=arc-20240605;
        b=k56dpphdp+EhTG0KLOQ2Z81YxUxRgucCjrLmr9sLwRtIAddzqT/XezZfYbqLCiB2O+
         bjywkmptUvXXICz11tZ1ywJz0Rc3wsT0jgn9aaRIdWdgg5KXMbWrw2qxXypz1ANvWuw1
         kTE8af/pBjGWG3QmhuWEtn/3xp3yejqQDtnX8wR3bF3ROs9aAoEeR3NY9np7gh0zRJ31
         HSOzQjMy9B5nZo/zurEyaXWTf6Y2S2eusqsJSlSIcRmvKtwhWxk+s+HZd/Q6R4JF7rRA
         vh7/oXFuHlqRHyO2lBAh8RWDaw6sOrlNu83/2lsgO6lKBnGHdA5Iz4CjpKbR1xO3gDIb
         YuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        fh=xAK+A191y2leiEEcunOy3SLVUBS9gFKydfjjk1xlDVA=;
        b=gMNm9/QXi/VfltukRyp3UShnh5nc1a4yeAxz4NuhgpVcH+WCtfti1boDA7uZv/Jth4
         Ys8eyoU/OexZ8biZ1fcfCWOdnHy5YO8V+SEUe/gF9ptBvVFdhr8GJrx8Nn8+xELwzdtw
         yGHTsEnX7u7StyU9FgW6WKbHtdzHmLXhulzZeVQm1MltJu5wSCFBRGNa3aKfRJnrLCeF
         map8SSTVx4RrTD4Pi43b+UD1suG335sEoKlD5ycSj2DVFKtTcQq+zUU2EQI3Mp1PzLeL
         Nagc110XE6Qbn84Sh2PrLMJb7xG/Lo5pVUbkKLeqVmzqGPwFZwow9/JOaNj8/LU5AmS5
         zkWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339350; x=1780944150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        b=AwvftzJ3sRAvQlcI4u6l+7Z81hqt+sqIS+YTWZysG8FIwrJAbirPdd28MZ++8ZffcJ
         JVmATe9vLdEmIDaUfU1Ok7NHOFm+KEknpwy4XKCUPS+JORuDdh853DXZ45VkfGtEjue4
         95HZRYoTqBbeDuVMGuSdxStHCLceyihb9cA/Og+mefaVU6Dq1t0Ro8EhxTJ9Mion0QoL
         lz8Rd3a/2fZ3aYe7E4MIi+Jeip9aa2Q/gtF3DUaipNxUrikbYtDku+NUMxPphKe9JqN4
         tOpqLnvj2QPrZs9+i6aO+9G7RF08WuIQPz37ddQPpIRyOm9eD6P9MCnNMlqCvBYFHAPe
         4Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339350; x=1780944150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        b=hVPadaCHh7O7+B/RaaDz1ooS80mP4kbavNvwBQceO9NrR1ooG0Yia835w2HW0eJRg8
         Uf1TxQFfXMYg+VDXxJFOn1J8oagPWuJyXBCiNyXYmYAV/814JhJ3CrWlV307zR6scoi8
         mi5/uttgZEgyOsnPmr2O3xMlyrHIC1Qg1vmTLhojR411enDxKw9gAQ6JxP8tVTab580c
         ZB13nSY4y97lNROabBrACi1AZZ5eqV7Dka4sHH8kJkAjx/WnGtFhUwfHqk7FZddPFMMn
         hljkN1JJq0/fXi3zGPNbMqdu6bBu8bDh2JqJV2iTLm3W5Z7JkPk75qAqNfxMIc9Qilug
         LH0w==
X-Forwarded-Encrypted: i=1; AFNElJ/L9+uyEmDPqJpPUBiwjBc4TJx1v4hyfi8VLC65UHODmE2Zkk8GSonZtelYHr6s9tYfytD6stw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtwzvi9Mu81qqP1mkIDh3gVlYwlEk07HzT5PBR5R25U0pHQYw
	8HGg24yTtI1Of08p0s+TaNLs8GLHv5Oh6bytBTle12dBdXbccWUSmq2r9eseEOwAoc32PtrWUvx
	9o8aulIuXqjBI+6A/VRaNEufPqo1co6o=
X-Gm-Gg: Acq92OEmpvOJwYpvc7J/xniidwzJOcHsm14z+XedcyxM2Lp3F+72Z3Zw9BxcdW5vgiv
	mzF9Y8TYE8sEzaS+mHXnRTUJBnHYbTaoxY0+0AoeCPcq+X2Wq5WVCbUd/lmD88Sv4axbKSvR4gB
	T2tMxc+FbLuHRU8ibtHvByZd5K13bzpsOT/hzzZUm76GTY2Gv3o9J7EHJOqt7u3w438fMLxp+Lx
	jK8/wZmM/jMd87J9oNFy6pPxNXGXMDfPhz7AwBWW6xv35sjykTrN0+2+ftzHsRGdzOO+v/jGx1T
	Vzg4rLAEEmj9TNDuDqM8r7/Kk7oUNDQbGA==
X-Received: by 2002:a05:690c:6202:b0:7bd:a4dc:c22a with SMTP id
 00721157ae682-7e061bcfb82mr110330297b3.48.1780339349532; Mon, 01 Jun 2026
 11:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-13-ameryhung@gmail.com>
 <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
In-Reply-To: <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Jun 2026 11:42:16 -0700
X-Gm-Features: AVHnY4J6STqccTyyKpq94c2tpQzdQmVj-nX3qCB_-eVaQzAEU1Tt8OiWPvMh6CE
Message-ID: <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr
 after the reference on file is dropped
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293890-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A581162445E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 5:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 5/29/26 2:49 AM, Amery Hung wrote:
> > File dynptr and slice should be invalidated when the parent file's
> > reference is dropped in the program. Without the verifier tracking
> > dyntpr's parent referenced object, the dynptr would continute to be
> > incorrectly used even if the underlying file is being tear down or gone=
.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/too=
ls/testing/selftests/bpf/progs/file_reader_fail.c
> > index 0739620dea8a..d5fae5e4cf9a 100644
> > --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> > @@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
> >       bpf_dynptr_file_discard(&dynptr);
> >       return 0;
> >  }
> > +
> > +SEC("lsm/file_open")
> > +__failure
> > +__msg("Leaking reference id=3D{{[0-9]+}} alloc_insn=3D{{[0-9]+}}. Rele=
ase it first.")
> > +int use_file_dynptr_after_put_file(void *ctx)
> > +{
> > +     struct task_struct *task =3D bpf_get_current_task_btf();
> > +     struct file *file =3D bpf_get_task_exe_file(task);
> > +     struct bpf_dynptr dynptr;
> > +     char buf[64];
> > +
> > +     if (!file)
> > +             return 0;
> > +
> > +     if (bpf_dynptr_from_file(file, 0, &dynptr))
> > +             goto out;
> > +
> > +     /* this should fail - file dynptr should be discarded first to pr=
event resource leak */
> > +     bpf_put_file(file);
> > +
> > +     bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
> > +     return 0;
> > +
> > +out:
> > +     bpf_dynptr_file_discard(&dynptr);
> > +     bpf_put_file(file);
> > +     return 0;
> > +}
> > +
> > +SEC("lsm/file_open")
> > +__failure
> > +__msg("Leaking reference id=3D{{[0-9]+}} alloc_insn=3D{{[0-9]+}}. Rele=
ase it first.")
> > +int use_file_dynptr_slice_after_put_file(void *ctx)
> > +{
> > +     struct task_struct *task =3D bpf_get_current_task_btf();
> > +     struct file *file =3D bpf_get_task_exe_file(task);
> > +     struct bpf_dynptr dynptr;
> > +     char *data;
> > +
> > +     if (!file)
> > +             return 0;
> > +
> > +     if (bpf_dynptr_from_file(file, 0, &dynptr))
> > +             goto out;
> > +
> > +     data =3D bpf_dynptr_data(&dynptr, 0, 1);
>
> File dynptr is always read-only, so bpf_dynptr_data() always
> returns NULL. Verifier does not know this (not sure if we should
> address it). Maybe it makes sense to remove this call or substitute by
> probe read, just to avoid confusing example.
>

Thanks for taking a look at the selftests and pointing this out. Does
replacing it with bpf_dynptr_slice() make sense to you?

> > +     if (!data)
> > +             goto out;
> > +
> > +     /* this should fail - file dynptr should be discarded first to pr=
event resource leak */
> > +     bpf_put_file(file);
> > +
> > +     *data =3D 'x';
> > +     return 0;
> > +
> > +out:
> > +     bpf_dynptr_file_discard(&dynptr);
> > +     bpf_put_file(file);
> > +     return 0;
> > +}
>

