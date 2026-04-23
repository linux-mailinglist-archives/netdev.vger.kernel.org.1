Return-Path: <netdev+bounces-280754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAQHOAAa6mmzuAIAu9opvQ
	(envelope-from <netdev+bounces-280754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E823C45282E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EE78301E56D
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CBB3EE1F8;
	Thu, 23 Apr 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEo0j4aw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABB1F151C
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949447; cv=pass; b=X5kGPPDcZlqBSbwLSaKzvnqD0cf6NWVr1ECJwLcVWTdwmVLlIkUpsWtJOOl4hoJyDA9F5ByuwaPgNX5tFOi+zVW45csiO8EY6PvToofBeIlYTduHjPACAYEIN2c76jT9VCPsE9Sw/Cr1bO2cCnman/YCAuCo4ulImaXYsgx+iSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949447; c=relaxed/simple;
	bh=8FF26mb8E0TrtOaVeijnLuIzX+4gd+vVt030n0CwL0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USJ4DQaeHsWK+KqAO9M/nz1XctMKPHsAyxwPZv6rADWK9xLFGkcCZHjUVdlfueVIQXETlfg5WnZtI80lnKED2K3Dpz35sQViwgWE6q5vgx7ToBKYtaOB7VHFIM9s5Hz4LhpJkKvk+E7g3/680pkTngb5g+UdnHmYtcxcBvpHcjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEo0j4aw; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6418065eec.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776949444; cv=none;
        d=google.com; s=arc-20240605;
        b=O/j4wZ/15sBojkI2Kms1G+KfM4CwU4d8bfZwS5m6ULigZFnQOs3/t/NcCzNLOD2ezV
         HgQBdJCVYlwEvUZQeWyTnYasfiW5omnqUGOISCQPv0GPeuiQeegqj5dZb1XSdOBU02c1
         cqjURW+IXYU+YgUhzIGKKTTnpXE7xpmELSc+/E319Bi6/K4J5oMuugX3Opd7A5VMh81T
         EhXJco7KHd24qxOV1K9h5JjPcHsl+R9ri3R34oXXAzAQOyMTYtJvzVAuVL83GuE113BA
         Lq56CYqHKbSaT7PtqxnWSnoYJuopup9efSEb5JSJrrQ+YPRSGA53xiRONfrVIx1c0AKL
         Dlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        fh=qZZedOY663xeaLu/1iy/oaa+j+r8PvhyUwSlMF4KXAg=;
        b=GF46ZcY60oG8YBPmTpQhneHWFwMISopSNCFKiZODEfhWluMocKKSTBYx3lcsmZDMvK
         NhR4CK+SFTLGQsZYkpFXnbaM0F5NNWiVvzAOlb/mS1/ZD7/8wr+rJoa1ujNub3/gBY7b
         Pvy9SO0+9PQO+6Ue8z+/tWLAwedhwAIMOE6wg4vn6X+SAwKQChTwT5ruBAPVPEmIxHq/
         DYe7L7XiSr31tV32LfQRPm+hzQMWnPwPMMB8srYHsqYHXNNc0VT4cK57TYVwhm7twh+K
         nPHQWVq9jIlnUDapAQbZdt1OdTSFVK+viE8uzi3qF7UBtHNp/tecpC6Gi32tK/aD7Fhh
         sRsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776949444; x=1777554244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        b=PEo0j4aw5geGxJPczuStFVqxJZ4rbWINneLGpcFAV/3FLY6X/5TGcw6vNxsPz8d3oe
         +vYwLXJr3rtV2iS7xQjTy0kV424PX/ei0PCobCXm64M04MXrZFTpE5/kDQ0Lhcz71EWH
         hu2hxiC6JIo0wEqi8NzTDPWxdtE8xSLRsjvtJWcNtJDW+6NBsCR2UBen7UoKkJgreAmu
         rXwHEsVFZ0CzCV46Ha3QgCBLAVuG3aXNCswLsL2tWw9I7sH2zy3bpwElt5ukvPieIWRB
         fS3ABSuC9WLU3++BslaDkOpjZxotOzm2V10OHqeggaq8HlUoyhGACjHG3WhrvS+wS/w1
         /xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949444; x=1777554244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TiFSwPpA9mYVqELcqFDz1TcWtB/yHTcPJJWGTStDmM=;
        b=rhUutoMQVF/uCZEAEDGKfBc9NQBswQqRHDymT+in1S48bJIN+8APbxY4fCs6TkUR9k
         /d5fuhVSth17/hOwhy7WKX7sNgGle0Owy6LHhMD3gwPc1ye8ksQORcgwb8OSGa+I6cUw
         M9Yl0hOgtBnnfZQQhmAOUnM9SXjP0Dw/LTTN6B9dEF0HjQeKmccY1ize8eTr9fe8nJfr
         zimpuRVPLvjBwCWgLh+TRETgyT0lH5t4i9OlyzKgKPN3jkXQcdWk08byosMaebhiOrMS
         dXnJEu2dVBPhSwCkK34I22Z/IaoH/QiMIuEMJjHwDwbM/XqepNM1w/g0IPnIvKTh7Had
         xx2w==
X-Forwarded-Encrypted: i=1; AFNElJ8hANwvsrpGTTea0comuE7KppVEhJFIEVyuVDBZrKvwWYAc2DJgTLT61G7EILMZZIhea/WhSl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFhGxKZVptRnxzRbeTMLvpcIpsTSYMhuRGvyFXFYIUJPB3anX
	S5UsSEDGIeGnlit8WL6oBz+XFn1/ptxCsDkgoqpgYmA9itqjzEGhJL74dD3pGQgxSXbTEoaA89m
	k9V13bbm6nCm7Jm69e/7KIdDGNI9jXEU=
X-Gm-Gg: AeBDies5VQgTc+LNHQelr9Wd3iaAiP+NNfCwwsnlIUTkkM/gGANpz72MpUDtan6hEbU
	qilcQNSr0Y+mJ8JdLUoz7RLA98PkvOEQbqMVJCJ5MSIUzWkSpoVKs8oEwx7/jb8AWSI7ydQfcrA
	UZZgXD4+vDwiIAeKiF+yy7Rwozrbf5SV+Sj0WlzekCwE5+15pr7GNPMy6PzM9UpsSeWOh5SnF/n
	3P+P7NvJd/StsiPLlqO+7CsYPR8NEd9bXnEwmVrk0e6Bk+tUPBJrmU9F96I30KikgzG0HzzA7RC
	4Ii7YjMWjU/DW2M18K/UDJ+qbyYjgCFUdZ0fPTbndca76dgblA==
X-Received: by 2002:a05:7301:168a:b0:2d1:815f:19c1 with SMTP id
 5a478bee46e88-2e479c0427dmr12992747eec.15.1776949444189; Thu, 23 Apr 2026
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com> <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
 <aej+JZyYwUrRXD6e@boxer> <CAL+tcoBH9qm0Ce=vBuCResVEbC_9a1D2VofTW73Uo+t519Ui0A@mail.gmail.com>
 <f78a505b-6be1-4b4b-86f4-005d709e0253@intel.com>
In-Reply-To: <f78a505b-6be1-4b4b-86f4-005d709e0253@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 Apr 2026 21:03:23 +0800
X-Gm-Features: AQROBzD4k1mHNI17wfn3lWtGGtS8eQLUBW2cu6UV4dKTucG_vxA1xkpjqtb1tN0
Message-ID: <CAL+tcoCmcT0PFwwFr+ZxL8qtWXmukepUChZjU78oTZpZ-j0D0Q@mail.gmail.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280754-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: E823C45282E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 8:15=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Thu, 23 Apr 2026 07:49:58 +0800
>
> > On Thu, Apr 23, 2026 at 12:58=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> >>
> >> On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
> >>> On Thu, Apr 23, 2026 at 12:10=E2=80=AFAM Alexander Lobakin
> >>> <aleksander.lobakin@intel.com> wrote:
> >>>>
> >>>> From: Jason Xing <kerneljasonxing@gmail.com>
> >>>> Date: Wed, 22 Apr 2026 11:36:50 +0800
> >>>>
> >>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>
> >>>>> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> >>>>> descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> >>>>> uintptr_t cast:
> >>>>>
> >>>>>     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> >>>>>
> >>>>> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> >>>>> the descriptor address are silently dropped. In XDP_ZEROCOPY unalig=
ned
> >>>>> mode the chunk offset is encoded in bits 48-63 of the descriptor
> >>>>> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset=
 is
> >>>>> lost entirely. The completion queue then returns a truncated addres=
s to
> >>>>> userspace, making buffer recycling impossible.
> >>>>
> >>>> What if we relax the restriction a bit? For example, refuse to confi=
gure
> >>>
> >>> As to the bug itself, yes, It only affects the unaligned mode.
> >>>
> >>> I wonder if we can support this after someone requires us to support
> >>> 32-bit arch and use it in the real world, then we can use the previou=
s
> >>> patch to complete the full support (which doesn't harm the path on
> >>> 64-bit arch).
> >>>
> >>> The code looks like this based on your suggestion. Just for the recor=
d.
> >>> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> >>> index 58da2f4f4397..03417b04592f 100644
> >>> --- a/net/xdp/xdp_umem.c
> >>> +++ b/net/xdp/xdp_umem.c
> >>> @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> >>> struct xdp_umem_reg *mr)
> >>> if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> >>> return -EINVAL;
> >>> + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> >>> + return -EOPNOTSUPP;
> >>> +
> >>> if (!unaligned_chunks && !is_power_of_2(chunk_size))
> >>> return -EINVAL;
> >>>
> >>> Actually I'm fine with either of them. Right now I'm not so sure whic=
h
> >>> direction this patch should take :)
> >>
> >> Abstracting from discussion, that is not a patch we would want against
> >> -net. We should not forbid 32bit on stable kernels, maybe there is som=
eone
> >> in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag=
 vs
> >> patch's content looks weird ;)
> >
> > Sorry, I don't follow this. Any specific suggestions on how to move for=
ward?
>
> Maciej just says that if we go the first route (forbid 32-bit arches),
> then this commit should not go to the stable/LTS kernels.
> But
>
> >
> > Now we have three approaches w/o the fixes tag:
> > 1. completely forbid 32-bit arch
> > 2. only forbid unaligned mode on 32-bit arch
> > 3. completely fix/modify the allocation logic of the first frag on
> > 32-bit (see the v2-0008 patch)
> >
> > I'm wondering how to proceed with that?
>
> I've just reread the v2 thread (I realized I missed it earlier) and to
> me, the v2-0008 (route 3) solution looks good. It introduces a bit of
> overhead, but only for 32-bit arches, where the XSk performance will
> never be push-it-to-the-limit anyway (esp. given that this is skb mode).
>
> So I'd personally vote for number 3. 47 insertions(+), 7 deletions(-) is
> not a big deal. And for 64-bit arches, there won't be any object code
> changes at all (unconditional `return 0` and checking the return value
> of xsk_skb_init_misc() will be optimized out by the compiler).
>
> Number 2 is also okay-ish, if we're sure that addr is always 32-bit on
> 32-bit arches in the aligned mode. But given that you already has a
> proper fix (n. 3) which allows to not forbid anything at all, I believe
> it's more preferred to fix rather than disable.
>
> + as mentioned above, if you go route number 3, the series could be sent
> to -net and the fix would eventually hit the stable/LTS trees, but I
> don't think we can disable/forbid something in the stable kernels.

Thanks for the explanation!

I will submit solution #3 to fix this issue. And the v4-0008 should be
simpler. We'll see :)

Thanks,
Jason

