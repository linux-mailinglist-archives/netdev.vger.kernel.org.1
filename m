Return-Path: <netdev+bounces-278298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Srp/L6Ha3WnukAkAu9opvQ
	(envelope-from <netdev+bounces-278298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DF3F5DE2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD63303A112
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426A30BB97;
	Tue, 14 Apr 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9ymhVHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0332FFFB8
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147103; cv=pass; b=im/BB2LX40IZC87eYk9dUl0Gl4JKQbtxzl8cxSXlyr3A3/DwcBpNUIar4g44Oco8MEs7nVWqHWEwf2ydO2/sCtVWIxaO8Kt5oxBPdjgO4IEjrnL+IvQcgpeBh/Ui4wWg7LVeZuldI/+mq+/p1rjk2zYnbyaG+LfoepzeYl0ZTOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147103; c=relaxed/simple;
	bh=zlED/jrEEWRWLJ0Yf78FvE6LghQYdstVM2QEXnaqevk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN6DmOuzY2arXHyWmUQ7vjFFTbIsYOiM10new1ON3a8xtyNc9ottz9GBAK77KY8oajxBZpWksaSbPAzJVIkGZvdUALVR0tKkGZNuBoyKuTrDn3LJYovojhXae8whSZKn1puJnxB9kidKANp8aqhwhYDGVFEAX7NJn2n6j1Vx9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9ymhVHe; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfdac74050so537474485a.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 23:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776147100; cv=none;
        d=google.com; s=arc-20240605;
        b=UAEver+xPiYg4dz4G9dMTHRnoCwVzb4o2lJXr/P5Dif0uUiu4wio0oPC8PnpQgHB8s
         IKIcB/w/j7I2E8ZiPZfJiYIJAsC+o2q98ii+KMGK97z0NlAkTO6rBUHULe6kML9iNaJL
         ziB3LjCgzi4BcSYO7DIv/FnzBlGdOomKiFJ2Ye/VmysV2+u6kL0dMMRxiX0Sc0exKAp+
         BBB9/S9hQ6xfWKxQKus86Ha2feHJflEu0B1T4edfWYABEBdP3Mx6mvLYKqjUlgigHCdB
         TZD43/DOLq+uvqWDB4mGezQ3srXYDWmTcqCpJkKqIPDXIUKuilT0/Qt2ZiW9LUe3vdMr
         Nwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAF0Vl7njHyXK7EYn4RJLUuBj27JTwxYrzgtP7tc5r0=;
        fh=f4E7HkNM2fQGXBmVy46i+QLVt0GmkH+V13fhpkTRjMA=;
        b=cEFRbp3y8dM/OfIoF+GLJvpk3vHeBZGM451pArG076m42+fmPhigGIVTVeEtzpznnm
         AliJYAcfpDtKfAiszaAGkz68LMMgMJcn1O3bJToanLtrPkrgfINtvKJBfbwtgVEnKFA9
         esmD6F9vcUXm9acomyJFSstnNdiqOVMUEHFTUW15aPWfcstF7FGhOWl7RE0miOkcTRTA
         2405msnHSH3ua0Dxp1K5sBlY8+0qPDJPodkosYzpCTtKnmjgDD7YyQsDp2XqV+wMx/LZ
         UeZR1+8SyhxWURdOdYBbXZeNYRp/jTzRJT+NwT4XBgkWhBAwEhEHRz/pMXUjKgR+Q6j0
         /xHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776147100; x=1776751900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAF0Vl7njHyXK7EYn4RJLUuBj27JTwxYrzgtP7tc5r0=;
        b=F9ymhVHecZjpAjNFwjuwn2HO+cqwe1ARVzE5KmP2DjqQOtiYBfi/xIRnkk35Jr/CET
         4E7VT8PZrsr2gNdSlQf3K4n1bFPGlWq03JS0x60YHCs9RcnfElEok9JbYNYOIHmAjJ1K
         cjkrlEKvyvJq/jAcxWEV08frh0MgKh9o4pew3Hu/WKVPQfmTKyAoIsUx/hX8qb1O08Qf
         yH/rjlVQSaFNEs6rYspxrHz/J9wmisSu2L79tvAoSG9QyNN/xPWG+jmmJmS8X5uenOa6
         Tg/nnUvXUyEVTSKHppGcZb7RHFj10Tircg2tYXSb6FHa/Z3lIJcgtM1ujdhe1ns9QCBH
         PsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147100; x=1776751900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAF0Vl7njHyXK7EYn4RJLUuBj27JTwxYrzgtP7tc5r0=;
        b=Q+ZFbOAG4rTnyus1IfTX+P8qm/XUxZ8yAqcz5QX8h2kKGdcckdAulXp/vyW3tbY/zX
         Fwo/TdCu7OCNsas8HLa/CKlG5h8xrioMVnsA8c329oXWyRamT5zXxImow/4VDg5NXDCU
         wl7LYFld7YsM6zyuCn163IPVhSJk1MWTU7rRsYlLncztmR0ugZntMuTv2vxLgT29ufbr
         2rntT1bcmT398dtP8tCxEOgxIbQJw9rZXd5meNNaSE1DOA4CUaLrGQ3DlcMLuyvn/6YT
         2TTbVPiua1MvsThUjOr45T3FYooTo4bT3O2d3gsmUIeNzqqvPwjY5ARFyHwY2FqJYcNV
         ltVg==
X-Gm-Message-State: AOJu0YwU4SIiIARIT/rQ+1FT4b8KbOnLmdMyZcqwPrwWFP/w6fW2tBpT
	FwsBaiE0OCOS5VVVRvPwjLOj1bPCxQkk7L/xxLm3H2wKRgJRNyP8vQQbRReiSEfDxw7ImtZYlqj
	FCbW5x2/a64BY0dWmjocsfASdDvQRHXYvNxUoOvmd
X-Gm-Gg: AeBDies8aH3SU8EDir4ZTYSKbIQ3zSXDs0Rb2CXlj6DDuNOF57v0p+lU6nrwkt/40V5
	qE48MlLqJI9msx/i/E9VpCuuwZdfH9803/uhmoFePGKYO/7XZo4At1peWY5XVARxw4CXCarlJiI
	0Jn2VjF5uomJ4el18UcSXcjnkULkr7MGroPJ8mwRmEC4wm6txCVYNnTxQwiTSi4na82El0sTPtr
	XUrsrFKHHLAQ+i/5MJ8LWV3CacoCnG0tH7FMlNf4LU5nGSbA9qlr9ITnWbUcoBKpiRW3xe7B7JK
	x72jEj1yTzmauNZD5J7uN0GfBngT4dLQtXY9/NEaxL7BiTZK3FS6rgT1ZbzsvTNVGQV+5D3UoBD
	VGsRoxRA=
X-Received: by 2002:a05:622a:90d:b0:50d:b030:fc6a with SMTP id
 d75a77b69052e-50dd5bbe532mr244310831cf.49.1776147100067; Mon, 13 Apr 2026
 23:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177614667427.3606651.8700070406932922261@gmail.com>
In-Reply-To: <177614667427.3606651.8700070406932922261@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 23:11:28 -0700
X-Gm-Features: AQROBzAo4pWAgj6mqIT7boi1_hwaMvrf2yxvVlFSjJeeXAUS1D9VQOZ7QAM6Iog
Message-ID: <CANn89iLXG5ZMNeHkcLW+Ug9PxNnw_EKtpGVkPw1qeXEjJNtA0g@mail.gmail.com>
Subject: Re: [PATCH v2] rose: fix OOB reads on short CLEAR REQUEST frames
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 050DF3F5DE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:04=E2=80=AFPM Ashutosh Desai
<ashutoshdesai993@gmail.com> wrote:
>
> rose_process_rx_frame() calls rose_decode() which reads skb->data[2]
> without any prior length check. For CLEAR REQUEST frames the state
> machines then read skb->data[3] and skb->data[4] as the cause and
> diagnostic bytes.
>
> A crafted 3-byte ROSE CLEAR REQUEST frame passes the minimum length
> gate in rose_route_frame() and reaches rose_process_rx_frame(), where
> rose_decode() reads one byte past the header and the state machines
> read two bytes past the valid buffer.
>
> Add a pskb_may_pull(skb, 3) check before rose_decode() to cover its
> skb->data[2] access, and a pskb_may_pull(skb, 5) check afterwards for
> the CLEAR REQUEST path to cover the cause and diagnostic reads.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> V1 -> V2: switch skb->len check to pskb_may_pull; also add
>           pskb_may_pull(skb, 3) before rose_decode() to cover its
>           skb->data[2] access
>
> v1: https://lore.kernel.org/netdev/20260409013246.2051746-1-ashutoshdesai=
993@gmail.com/
>
>  net/rose/rose_in.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
> index 0276b393f0e5..b9f01a11e2df 100644
> --- a/net/rose/rose_in.c
> +++ b/net/rose/rose_in.c
> @@ -269,8 +269,18 @@ int rose_process_rx_frame(struct sock *sk, struct sk=
_buff *skb)
>  if (rose->state =3D=3D ROSE_STATE_0)
>   0;
>
> +if (!pskb_may_pull(skb, 3)) {
> +kfree_skb(skb);
> +return 0;
> +}
> +
>  frametype =3D rose_decode(skb, &ns, &nr, &q, &d, &m);
>
> +if (frametype =3D=3D ROSE_CLEAR_REQUEST && !pskb_may_pull(skb, 5)) {
> +kfree_skb(skb);
> +return 0;
> +}
> +
>  switch (rose->state) {
>  case ROSE_STATE_1:
>  ueued =3D rose_state1_machine(sk, skb, frametype);
> --
> 2.34.1

rose_process_rx_frame() callers already call kfree_skb(skb) if
rose_process_rx_frame()
returns a 0.
Your patch would add double-frees.


Your patch is white-space mangled.

Please take a look at Documentation/process/maintainer-netdev.rst

Preparing changes
-----------------

Attention to detail is important.  Re-read your own work as if you were the
reviewer.  You can start with using ``checkpatch.pl``, perhaps even with
the ``--strict`` flag.  But do not be mindlessly robotic in doing so.
If your change is a bug fix, make sure your commit log indicates the
end-user visible symptom, the underlying reason as to why it happens,
and then if necessary, explain why the fix proposed is the best way to
get things done.  Don't mangle whitespace, and as is common, don't
mis-indent function arguments that span multiple lines.  If it is your
first patch, mail it to yourself so you can test apply it to an
unpatched tree to confirm infrastructure didn't mangle it.

Finally, go back and read
:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
to be sure you are not repeating some common mistake documented there.

Also:

Indicating target tree
~~~~~~~~~~~~~~~~~~~~~~

To help maintainers and CI bots you should explicitly mark which tree
your patch is targeting. Assuming that you use git, use the prefix
flag::

  git format-patch --subject-prefix=3D'PATCH net-next' start..finish

Use ``net`` instead of ``net-next`` (always lower case) in the above for
bug-fix ``net`` content.

Please

pw-bot: cr

