Return-Path: <netdev+bounces-253463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEu3BxJad2maeQEAu9opvQ
	(envelope-from <netdev+bounces-253463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:12:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDC880EA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A498301302D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D1334C3B;
	Mon, 26 Jan 2026 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuBm9zFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FDE55C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429519; cv=pass; b=fBAAz2eDyFqa/O46y2ErrgXzFLxW//xq2zUDAAS//vOS8uRtmbT6iMrPhSnQff7K1ok8/poFXPxAp2Ewku6I8NcCeoP00MpZGAysB6h6dTT0eqh68BKMLh4r4GLelhYKS2hnq8GSPT5L8cBJtihfhHv9lSnm2SfhamNpLsDwuX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429519; c=relaxed/simple;
	bh=L+jNPCM8kd0izDUdN9JGN14eNGBtXy5sJSYaS3rIKQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj2vn+Mwy82wj8S4V6ik8fDq3m1Z10jdpPHNF8Y5MPD+4lQ2wytW+2MAaHH3AcNX87j5pm1Uou192psia2O06LuHXFdKk2PYAfs+CmHBCrwhQvWWshN9BAcs2GXPJd6py5KZZVvY4azCM4soATJh/LaR5CpLtNnon4io2zsmiYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuBm9zFt; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7a9e4bcc2so4169365ad.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769429517; cv=none;
        d=google.com; s=arc-20240605;
        b=QLS/n227nopk7GKjD3j+d9MT+pmZ4z0votsBORJow2i4rR1Kw1iVBG3yUO20aOVsyP
         xWRzJ6VK/Bd2N+9PQA4JLe4X/KYXHR6/+GUBtE8nZinjcNc5IWrWHJ63VWFBlQLCkkz7
         b73DJ3BwEM+5wV/pVuEYIYVWiWjb0tRtKRPCtKItyIutBhbLND7Zh06rwP/l3wD6QK05
         FoNFzIa4qJ3ZuRVoO2+6PJC14PdsKfjlc1g6Of0AhpJ5CqLyWY0stwQXJITRP1qGOwk6
         5OeiKUVi/vVyItWzJc7+bRJkyfJgIHqo2xAnxnzWzu23pnBpO3ncyFQ5DVibINNlvopQ
         tAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OoHIYrOzAZ2W6G8laevw4V2lKg43ahjcfbTQK57idF8=;
        fh=67B0PFWqprQ0kpIJqFo3PCtqFw4sfmuDJz+xzl+iB/o=;
        b=EvW6UD1j844spvX937/jGytlW1liDiFbyKMf4zYxJqA0JqD7ejMmIVJfl5MzoFyiBG
         w+g7cAF5gffuqeXcf7K7Csz4cYH5MRgdwSIQNs8SilzHHqz5EB2y4JyDfBKkOKBdDQTZ
         SD3pk8tAtk/sgAc0ESNjE66/w4e9Ykdofegj07VTIEEPP/ly+s2n1S7rfrkK0CXXmCY8
         WaBUk/jI/hqrHP5i1e2BU7t6+IgEj0ilDyXXbxffE9v2AGL+yUDGX8q7ZUDAS+svTdjm
         ixlPuYhq5mWbixHiFUef/WoYOEMZyAXoh1KuuZA0FLvQsl9KpULqK5JuHm33hPHL/OrP
         V/aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769429517; x=1770034317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoHIYrOzAZ2W6G8laevw4V2lKg43ahjcfbTQK57idF8=;
        b=OuBm9zFtLf39PRBR+G8tdpTH+lbWJ13fbBg0HlchYrqci6+r11VCrEn4bmLiGBNRh5
         viEOwD/W/mcd3wXqIibSF/t2nDKVR2HV4CK87/k7vTz556S3Poq2i3VcwSUh+RBQu/RO
         VTzHHF8zqtvVnyG8mZDzbuTzAMrWpJfe9GLUETEn+V7cU1nuiC/O8Cncl9gFNUir0nP0
         wVJ0aROFWb/mU560rhXA8J6QM6flW0nlG2lovq+vbumXaQJ+qACBaUMtPSBdobNR7dHm
         tZ0j1tM1gwA9ErIwjWF/fNjcASCBT8at5jvOEeqDC98QprBpEQgSvVF639LSiWJrshIj
         X5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429517; x=1770034317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OoHIYrOzAZ2W6G8laevw4V2lKg43ahjcfbTQK57idF8=;
        b=dZhOL9n2c/zOp3QUltrWblPy3jcODFbBwlH6iiT9XlU8tcNgVQUNBrZiA0kOitm3qY
         Vk7TSnt7qDMntNHyzljpQoDTVuy6GP40TYzjYpZyRyR+WUcddZCRAznUsih3L1G3yk8F
         PbvtEM0eaopc0bumunGHaFplfIFxg4dHobCbbPcOS99Zoed6MVc2w7CupdoR1xt9dN1w
         YNRzvPhsF6pce59PQwyq/A+/6bhtTnFCXoNTsADNzLo0eLI4xJJ4UQTWkSkDskgIUnNV
         vVppB98IHfsTycLC6IRxMgY/RwFnphL73WIjurlL/gGB/np2ZpCUhCdvh+KgNkxzg870
         ydfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAurCNpkIiqhMJdzf7ZbSAb4i/jNub5upntSjM36iuTh/BJ2ej9z8TfvxwqXfKijQgDf1BkTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHjjI6+SfCoVvhapegx5Iz8gEMKQoCx9wEUN45CMcS4e81jMl
	OrIgorhVc89IPzN1V3bm9gE3/PatxR4bFcQVT0JIyJ6JNmRxzi7SjJrWojjFmdzUzMkYW8Bpfnc
	lcROkSKrxSOtwGICOwja79a/sLh6QiaU=
X-Gm-Gg: AZuq6aL+PETcu68ddgN1gCdy5A6BSKMJPAjuJ9IFhOTcjAO0jX10sDUsq/lbdyKWlD4
	+rwjS0lsMXjpPBJaxNjmsvczQTjOre0HqudNTeteJEFc7+0u0VIIPmlh2bpR5nl2eqAPxXrX6b2
	gqthPvwC8zxwtYrVp0dmBVqunPBqYDaQhvr5zIRFm4oOOQmeDJliFkfW4GOymOuuks657rKns+Z
	FJP2K51NvqmAvLTlxPTF14s9juDGbmwPdLEW3QV/XnUYnVA+Y2U2DozOfNCXwICmQsKKdQ1/X6i
	hLM8AjuuT7iWUHZKe68hD9dzQCaocvu8rg0RyA==
X-Received: by 2002:a17:90b:394a:b0:340:dd41:df7d with SMTP id
 98e67ed59e1d1-353c41625dbmr2997480a91.3.1769429517293; Mon, 26 Jan 2026
 04:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
 <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com> <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
In-Reply-To: <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com>
From: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Date: Mon, 26 Jan 2026 21:11:46 +0900
X-Gm-Features: AZwV_QjIK35OMKYUFT_P2Q4OFyno5TqBRTekEjGHoDNA9Bw3YELbcYZq_N0CmF0
Message-ID: <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmkim1503@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 71EDC880EA
X-Rspamd-Action: no action

I propose the following patch and would appreciate your review.

hoff is used as an offset argument to skb_header_pointer() in
u32_classify(), and negative values can cause out-of-bounds read. As
shown in the code below, offoff follows the same pattern and requires
the same validation.
```
TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
   const struct tcf_proto *tp,
   struct tcf_result *res)
{
...
if (n) {
...
if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
off2 =3D n->sel.off + 3;
if (n->sel.flags & TC_U32_VAROFFSET) {
__be16 *data, hdata;

data =3D skb_header_pointer(skb,
  off + n->sel.offoff,
  2, &hdata);
if (!data)
goto out;
off2 +=3D ntohs(n->sel.offmask & *data) >>
n->sel.offshift;
}
off2 &=3D ~3;
}
...
}
...
}
```
Therefore, I propose a patch that rejects negative hoff and offoff
values during u32 classifier configuration.

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, struct
sk_buff *in_skb,
  err =3D -EINVAL;
  goto erridr;
  }
+
+ if (s->hoff < 0 || s->offoff < 0) {
+ err =3D -EINVAL;
+ goto erridr;
+ }

  n =3D kzalloc(struct_size(n, sel.keys, s->nkeys), GFP_KERNEL);
  if (n =3D=3D NULL) {

2026=EB=85=84 1=EC=9B=94 26=EC=9D=BC (=EC=9B=94) PM 8:22, Eric Dumazet <edu=
mazet@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jan 26, 2026 at 10:51=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Mon, Jan 26, 2026 at 5:30=E2=80=AFAM =EA=B9=80=EA=B0=95=EB=AF=BC <km=
.kim1503@gmail.com> wrote:
> > >
> > > Apologies, I set the wrong title and KASAN report. The root cause is
> > > out-of-bounds, not use-after-free. Please find the correct KASAN
> > > report below.
> >
> > This is great, do you have a patch to fix the issue and get full
> > credit on the resolution ?
> >
> > Thank you
>
> Brute force patch is a bit expensive.
>
>  I think we should instead add new helpers when the offset can be user
> controlled.
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 86737076101d4a8452e90fe78adcdcfdefb79169..1ad8a3e17b995f5b934dfa214=
48580de4f201acd
> 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4285,8 +4285,13 @@ static inline void * __must_check
>  __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
>                      const void *data, int hlen, void *buffer)
>  {
> -       if (likely(hlen - offset >=3D len))
> -               return (void *)data + offset;
> +       if (likely(hlen - offset >=3D len)) {
> +               unsigned char *ptr =3D (unsigned char *)data + offset;
> +
> +               if (skb && unlikely(ptr < skb->head))
> +                       return NULL;
> +               return ptr;
> +       }
>
>
> scripts/bloat-o-meter -t vmlinux.old vmlinux
> add/remove: 2/0 grow/shrink: 56/1 up/down: 2539/-6 (2533)
> Function                                     old     new   delta
> __skb_flow_dissect                          7661    8315    +654
> ipv6_find_hdr                               1005    1127    +122
> br_multicast_rcv                            7973    8077    +104
> ip_tunnel_xmit                              2635    2719     +84
> __skb_header_pointer                           -      82     +82
> ipv6_skip_exthdr                             428     505     +77
>
>
>         if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < 0)=
)
>                 return NULL;

