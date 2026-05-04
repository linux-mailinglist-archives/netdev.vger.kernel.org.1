Return-Path: <netdev+bounces-283771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L9QJdNv+GkYuwIAu9opvQ
	(envelope-from <netdev+bounces-283771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:07:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9DE4BB6B9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A68FB3013EDD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C30390C8C;
	Mon,  4 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muz9aXvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5538F957
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889226; cv=pass; b=WR4EE8tJ18gMDtYb07MROPq9x0d63W3Fs/MmcqSMhTd2boMLj3MRnc85zUH0uBU7OxzL4dNRb0il67H5UK5sMzMaaDiSoWUYGKzgmDsKBHLI19WzavLqu7iVsOko1Dhx36ZtfAznIGPoEyXoBqslWOeXVt3pNZJYmgFnQNbt0DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889226; c=relaxed/simple;
	bh=A8j2uAak57KcKUqXH317uowDb7PaTwJP49rr/2FSGxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE94l5KbIr2SeTrFD/s3vT3DBtMcAOy6pUNlOXPRtgtb/EbUA6R2fsdtOBiMxuu+1zWuZyz6Wg9svTxVI0utW5q+EyQQAe7AgbOPdPEG79svqg3UWK+f/8LjEv/igCymkBtnwLjePBvEkFMpCvj9/1Sblmz7kh/8wRNfkpXIO3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muz9aXvS; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6b9bca48so58113231cf.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777889221; cv=none;
        d=google.com; s=arc-20240605;
        b=c4M0u/+4TxQyiN29CYjH73u8gwVUoknWp4SR+8cDCg08CWTS8QM9NFVpCfQWzBgzDz
         vPq0XZZlkVCHKyLbC0B3StxokyzhFCBwxQ3cgW/1HkRFUO90sERdrO5PuEr5r1jsnZ7j
         6akkQ5jXqHZ1GIla//9IJW92ZHbAU8NENVDLZypHs0mW3XvkwWG4/ahoqAJzpxwXXhkK
         bs6EcoypQJ1+UbSigwO/jpYAf+DGoKiWiWjdLto+Mw1gbhuZ2hL89ZRpBxbmZ7fO83fv
         yO4Nia72sVzfEDVxsAvsGVzkZqGfvj8Z3gQbrlb/F5sHp9O7EXs2IxtroYgknGqeeopW
         MgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28TX/MhhEQJejGX5c2OZbC5NJrccgjPFgxvWmNQ6nGY=;
        fh=1QAkXB1jIQMbhONOcIh7TtysnfeXU1AsXd5Z/I/Bad8=;
        b=B6n3hZbnE8kQi3cf4YpDWgkg4NGR9u9YIoKUDFHrvr9M2XzllKzqb5dncXeVrEbWmU
         8VPbiD1Af5Ll30psZM66InjWsdDbzqohPk6vfSgeBlwELtU4guf3fC4dpSm5RkEnFMog
         TkzEzuRcWud5mM9ggaJ3EBYnyYZis/zFd6sn5V36d5pjeY4SIYyhnpbA629lWFxaRlMN
         Bty/svCBxBdS3+pI/InE4zLyqdmh9gYMXEzZccumnOR7+gT879Na9ivvvloRsr3WoIDh
         /H7M9z46Aamrq1TXm6/o0n7lHl4NPev6RsLZ0rDJN0GZVnTWUHBBJ6cTiJDfwzmnwa6A
         re3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777889221; x=1778494021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28TX/MhhEQJejGX5c2OZbC5NJrccgjPFgxvWmNQ6nGY=;
        b=muz9aXvS/2468QvCeG5PkXJuN8u9phwkoAUqk/pqY/Ibycl/+cs2e4DVCUt6W22OpJ
         1f80Ke4XqxPMvBCWQY8gc7lT9R2ruRpoRcTxVeQ/iuJTkET+6FtexQ3QUchB95SGEkjY
         1iNpfMThGVk3qX1DuUaTOEfaqmftEYMeA9PyUm3TW5VSUGlIClOvqFm32HR4LISYK24F
         +4Flx6/VwEn3p1zR5jo5p29dVOJz8McoalWCm2exKNVrG48htu2AQ/DCmiuqcNZmnPBz
         kAatQf+1jYzss3mmEctsJKEefFS0H91yDfS/VH3HfV4NlwMVew2PfUPWasbopt2lbTqA
         UV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889221; x=1778494021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28TX/MhhEQJejGX5c2OZbC5NJrccgjPFgxvWmNQ6nGY=;
        b=rNkWtwkhZnv66/+8a8dDYZaL8QLejddKMim50Zd9cCY2J5eSF5BpGj8cx4BruFn4sH
         vy0NPCphEkAbjyZAkqjIGhyo79s8SC85jdHO1GcgRsVb/U1W4PRRrL4loWjjbO5pQOuQ
         tpscKf7WB0EJPKcH9SRYwbPRSOOLncitCx5F/eYKgLMVdTBXlkSHYS9HSVPAAKipbDlK
         yEly3QYHiHarTFKsVo8S1DNB6t2LsWhFm6ckKqX1DV3EPy8vt/ytYpOhGNXUHuymuZ4K
         VHNlmfCF96dlDx8Vf3ujTbVIdsKcIFbB9oa/2UkDc0EEKO2pSPRxaPK3+t+lBOoQNQkO
         U7rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2ZrXuP2CMITL+il5ECPv/c/BNWhAHMFxJ6njoRcpQIfiYJAxDQNIPIEAXT+iZTv73ZePFP8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR07UYH1wi2MYl9HVPIYguvR/PSCE54jC95NDbR+diSr/hV6FE
	P6G9Y35+alDBFXuCIBQ58ZTRdAnK2NtpEnPoZY4JXLbHruAMSTJUQvmVZunPNgq6LRUEOGh3ijo
	SzaibAflozBgEZr+tP21hY0ZpmrOLuYx8nemJY8SW
X-Gm-Gg: AeBDievnT2yN2ndEdf79nPfcFyU8KiL0o+BGoErdz1aGuQnssT7Nl+S67OwEC0uo27u
	HzTHPEhmazis1blNozcpgNvCF0dFW+o464jr9ZmndhyEZuDYkWi4jXAB35DsBjhtrngUWc7AJM4
	ILBkTMDsaJ8ZxTsXj39hzIW01vQthHreR1puMt04guCJhluXHH4UHtJtK+AMRZg8BxTbXCwYBgB
	H87Fw9bhc6DNDTfRHw2lMmSz4/49myGvecB5V1R4C7j0pRIiyJ2XCzEeHGGYiPNnRh4yY04Cc+q
	R5b8sTs8txgQbXtDxb3pgMRQYGhT1h+AIji9qketBbgnlDrZS9ZC/m/YXU6j7UnJ5D0UPmSICS6
	hTw23My+JsivrD35S318ymRGt9Xo7mAMNAIGwIio=
X-Received: by 2002:a05:622a:4805:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-5104be06a0cmr127767591cf.7.1777889221074; Mon, 04 May 2026
 03:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503170257.2782962-1-edumazet@google.com>
In-Reply-To: <20260503170257.2782962-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 03:06:49 -0700
X-Gm-Features: AVHnY4K8l1Xzn_Yy7FVzYG7WTKdwgY0paavy9AjmY2tQB54bdwR2YanOizjc--I
Message-ID: <CANn89iJdT09YJ5fRnwxV_hHS25DrCLM1J-8FmgRA=bgenp_Hvg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D9DE4BB6B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283771-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Sun, May 3, 2026 at 10:02=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> fq_codel_dump_class_stats() acquires qdisc spinlock only when requested
> to follow flow->head chain.
>
> As we did in sch_cake recently, add the missing READ_ONCE()/WRITE_ONCE()
> annotations.
>
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/=
class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_fq_codel.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 0664b2f2d6f28041e5250a44fc92311116ae0cf1..f52198ea849b0cc966b455905=
a62d6c413441260 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -117,7 +117,7 @@ static inline struct sk_buff *dequeue_head(struct fq_=
codel_flow *flow)
>  {
>         struct sk_buff *skb =3D flow->head;
>
> -       flow->head =3D skb->next;
> +       WRITE_ONCE(flow->head, skb->next);
>         skb_mark_not_on_list(skb);
>         return skb;
>  }
> @@ -127,7 +127,7 @@ static inline void flow_queue_add(struct fq_codel_flo=
w *flow,
>                                   struct sk_buff *skb)
>  {
>         if (flow->head =3D=3D NULL)
> -               flow->head =3D skb;
> +               WRITE_ONCE(flow->head, skb);
>         else
>                 flow->tail->next =3D skb;
>         flow->tail =3D skb;
> @@ -174,7 +174,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, =
unsigned int max_packets,
>
>         /* Tell codel to increase its signal strength also */
>         flow->cvars.count +=3D i;

I missed this also needs:

WRITE_ONCE(flow->cvars.count, flow->cvars.count + i);

I will fix this in a V2

pw-bot: cr

