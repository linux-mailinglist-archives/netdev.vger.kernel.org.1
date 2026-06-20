Return-Path: <netdev+bounces-300814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PhfBHSuXNmouBgcAu9opvQ
	(envelope-from <netdev+bounces-300814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF57D6A8F2E
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:35:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=wwNZUTbH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300814-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F71D3019F1B
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB2367282;
	Sat, 20 Jun 2026 13:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2D346ADA
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:35:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962536; cv=pass; b=Op6J4P2j0yryYHYJ3ancKNvevnW0fwIDzf7p9e79cLRKtlvogzU+rPPgs/6Dhmmf/kLu0+btqxN6AqAmXE41xBE7Twv7VSUw16tXMJa50dzhn+aIWR4lzXKjZAQGCGs5it4CuKLX+jTHNhu7kVeOaG32Mv/FpuYNm4Sa1jGkdz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962536; c=relaxed/simple;
	bh=y3doYASW5ECQ4nHcNiLPC+9Ao8BMX93ek5uutFzUeIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugQK5olp+fPPHUrZ7MyD8IO4ELi+VNoIAqFFwOuXzOX32nguiTAdg452agixip+5WMQM1+uMp5Sg5KSFLOYpqhr8WK1TQm6sYgJ/XROrp3Di9FebAMx1m/g0l0Cr081rudXqRjjLykTEjx38zeifIdVkeUvdylOXTJkyug5Cc3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wwNZUTbH; arc=pass smtp.client-ip=74.125.224.47
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66043ecf6b3so2754831d50.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962534; cv=none;
        d=google.com; s=arc-20240605;
        b=C4vM5WY4jd6N78hh+I5ooi/pUIGQSeMBUn6GZB2V9+yz8oIpTDsCVTLymCpe9HXN7Z
         7R/bDw2DouoVCF8ZdaIcQf1AT9QjHQlYlVmhzBwXUeetHK4JtzLdZhmITb/1VMKlof3n
         DB4/O5e64Q/u/gxwXI2tD9ITl6tsj983qEdtlqvIuA77nlgJuMrXOlUA1jNr2ADMrNyZ
         ybVmUnhcJA59h4RB7m0+pUBBJePlfBSEUO01U6sNBQHtArmeJp23nKYr1/Dt/UzivbiU
         GpcWplx1eHAVOYxWtlCk+2m8VJhVpJU319gkelCs65weoHXb2Zw+6symg2WSDtAYsYa7
         mQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        fh=OaO+3kx0/721xRtdNa7POUbCKMzRu6bcovlF8EZJpek=;
        b=X6xibjY8T6yxbN0OPDrKpPaqH3YlZkIVjJLWWZx/tlJJKK/NO1xRR/fc0XkvR2rL79
         AjkePwjDS0iKTrwvpBNW9/klpY6fiB0BX9DkQCBASPkvRty6CJhiVQUQGxqQCyOsnZlq
         xnekhVxa75UEYrPitgF0RtnKMBwvFXHxWNMGP811Bq1AKNcxq3Wzc2193P4NhVU9+4EN
         y3ooyWEFbfeH5ESYQ32cM/jgFmtd39eBk14sZB74hvt0j+NnB9wHSIcGsE9tyrJWThxO
         ZZfK7uvqYsuhAAaoDCWP5TLUMY/qsOCRAExmvr8RtbKZdZPDKsg8j+v3AejBYESH3ZDB
         66Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962534; x=1782567334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        b=wwNZUTbH87bJdU8ccQ1ThL9vx+JKJo2SUgiGUpYF6iVOaPLs9AkfC1Ty9puMp8qBeM
         KTdKD17kJ+tGHUmscJmlGk5DZEgR01TIJoegXftJ7Ct8w6pe0s5j+gE5qHS8btcVCQdD
         C8f5o5y46K8ijk0OpsPK8Yw0avT1EwBQIMKEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962534; x=1782567334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        b=rPUxTQq5mabg0lkwZKy7dnoYmDi1Z2VLEY7+nkkAvLYjwwx/OZWSqHwCw7uOeKLnwz
         KkWyFQtM96NZe5AMRUebFKGFY02Rg0HxJfO7WtHDMpDNnAvT7/xpoNZgSseTeX7/p3j2
         +8PgYwpPI/6+BTj8Q+s7QVal4NBoV0H7AaFcvMTiB6gJoqVcZO3QEjCYEhdKlt1n93Z/
         G4DucF7jLabTwUrQJQw4r66ioOr3l8PDAHPKL3BGErs/qtEyvPz7vMp+OngeELqmArJ8
         ixAknL7lmqhFWQmhwtpsO43YjY0LmpHzW14axG27oRyV8mNoy+VKACoVoYwtEDIUnNe+
         lXRw==
X-Gm-Message-State: AOJu0YziIBqh+KVb9XfTKn1tojNIr3h2b5sqws6pDAorFMd4gum7fC/W
	TiIftkO/xMLA8m+6P3sDLrGwpAnYDZlrkyRzuaFkkhcE5Oqt8qXjKyzvAGupEqWbiJuGi9kTkB9
	CyWIPCtd0AD8BiXQDIrWOGiIA4d0NBo21NsyaLXil
X-Gm-Gg: AfdE7cmulKYIKA1dDbJddjzqG01eYcrJqHW1/KezpS49IHaNcjJ9aJ7kbNE/BomCCDJ
	q5n4FcwUX/G318G+XfHmmkx+CYgRb9POqLsAcQYTM1hmvZSfL7KsMjpCmOqhRWi0a8ziA9lXLGo
	yfyk6Ccl6m9jFt3hX2/LYvCWUkrAkBnsX7n0gjsKcBM/hwT0/M1Y1S+fBPjbK6n0zFptb1XRTa/
	iNar8B6yO+bEFQ05mXzvonR6USn2cLkBoSyrVtZ9g/ZH4gM4viBHgbkTY+PUb2tjovHsg==
X-Received: by 2002:a05:690e:168d:b0:662:c587:4351 with SMTP id
 956f58d0204a3-663033dbe71mr5581711d50.55.1781962534607; Sat, 20 Jun 2026
 06:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:35:22 -0400
X-Gm-Features: AVVi8CfaQz3apZiOvExxZflvS1CkQ5NK9ylZ237bnRCRWFgA4GQhV_B_m-t_Sps
Message-ID: <CAM0EoMk7Ev6oXZ0MzYEbR2Ld2_mHsXv6u6J84=TcSJv9WJn-0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:chia-yu.chang@nokia-bell-labs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300814-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF57D6A8F2E

On Fri, Jun 19, 2026 at 11:15=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
>
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
>
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
>
> Follow the same pattern used by tbf_segment() and taprio: count only
> successfully queued segments, propagate the difference between the
> original skb and those segments, and return NET_XMIT_SUCCESS whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v3:
> - Move the UDP GSO sender into tdc_gso.py.
>
> v2:
> - Change patch commit message.
> - Add tdc test.
>
>  net/sched/sch_dualpi2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index d7c3254ef800..5434df6ca8ef 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
>                 if (IS_ERR_OR_NULL(nskb))
>                         return qdisc_drop(skb, sch, to_free);
>
> -               cnt =3D 1;
> +               cnt =3D 0;
>                 byte_len =3D 0;
>                 orig_len =3D qdisc_pkt_len(skb);
>                 skb_list_walk_safe(nskb, nskb, next) {
> @@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
>                                 byte_len +=3D nskb->len;
>                         }
>                 }
> -               if (cnt > 1) {
> +               if (cnt > 0) {
>                         /* The caller will add the original skb stats to =
its
>                          * backlog, compensate this if any nskb is enqueu=
ed.
>                          */
> -                       --cnt;
> -                       byte_len -=3D orig_len;
> +                       qdisc_tree_reduce_backlog(sch, 1 - cnt,
> +                                                 orig_len - byte_len);
>                 }
> -               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
>                 consume_skb(skb);
> -               return err;
> +               return cnt > 0 ? NET_XMIT_SUCCESS : err;
>         }
>         return dualpi2_enqueue_skb(skb, sch, to_free);
>  }
>
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> --
> Xingquan Liu
>

