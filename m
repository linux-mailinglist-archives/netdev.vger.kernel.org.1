Return-Path: <netdev+bounces-303819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XfbBIyx6RWpeAwsAu9opvQ
	(envelope-from <netdev+bounces-303819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8A6F17F4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ssHKnqUD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303819-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3527430CEE5B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5F3A7582;
	Wed,  1 Jul 2026 20:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDD3A4F5E
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 20:32:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937951; cv=pass; b=beQJpYGIdUkFYhdGGfSzMnANPbLvCFd9mziaHssE8YND1nnYupQDWxdcJLG9g7gJeuTz4bqbZsvVdT1UYFS/pJcg0UUEc+IP/TkkRALy0I70+l2RZR02k+XFxqvF22a5O4nROaV5suMX+9ammktG6t7DdYzd5Bno2+j/e5JIFFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937951; c=relaxed/simple;
	bh=7/sHJHaXSYF+upxkU4mAxLjNkxjly/ZvWaONQwnzSIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvF9B8/x1T8B3qxH7wEDkSbzwXdnKGO3L7RB9wRdqczrmCFelszjKLmRQSF7vCZlVMYkNgw9cEZsrXVWJLA5R7a3eseXlcsSwXr/Ju5RYlf4WxSZ/AtpYyeri5fmN4j3Rwxar+kP5Rb62uZr1ww375HCXQaG3o5ijlj7Dt0RxDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssHKnqUD; arc=pass smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso999956a91.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 13:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782937949; cv=none;
        d=google.com; s=arc-20260327;
        b=KLsxnlmm6ehH5EQfkMvRLkFb06CovaYO8SsinvIO3InILJ0CyfxWqu4fSI/30c3Vgr
         lueZ/nL//ZCroCkMLLVguiahQwhjq52mRY5xmAVnjvkj2RoZ6l/W0uZjeTt7vB63+B9n
         cumv3wnjcMX7iGR3rllB47EmCDcC43oppj0ymJOXvN0dOclTbyTWhPLr/ncFtU/kyoHg
         EACEJbzhhvjthqPaXvIahNxQR4XT7Ol74RM5wnn1azOkC49x87ov6MwAlAJmA/rHbq4P
         cXdH3/xPveBvqNF0/vXgONhuDg5r6T3xWJiDfhV8NH9YlqwJSgh5zr0A+wzcqcUeDYev
         GYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        fh=imeVjz1KO+QXVvcDqihhF5QBrqCcmT+OgrwZ8dI1fiA=;
        b=QfEJ2+1fTUGUP4VeQsYyUjCpcbzvDqmUL7H6VdyiU6Un+8tkP/Us7f7CqyvUNtfWyM
         sL9Ku3EdKOOAsGVq1qM29TtJWJ5sCHLdzNShVPCiWoa5kg4XY2VBcI6HYWvFYi9R2DoZ
         ZiYjjpSICcCPlfIbm+mkHGm85/z828aAu/9XuN6p7dNYTaQf+jcxUt2sJxX5i/aK3hxP
         m5s1sEQonILR+nuqZL6r/2gLYK7ea1QIlq4jOGZIfrcRr77Ewz5AnastKmImsSc/jS2H
         KIcP2BF9WieDysFz60RkObAQS/ZI0ou54jiKcv8FAXFtWlDUGUpk1pMTFNTD6Tb4+H7b
         eLiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782937949; x=1783542749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        b=ssHKnqUDPxfs9qh230Lt760/9PO/pwSsAXaDlNJXgqodiYErQVkdf+pVsEvdESvT2X
         hKKLmuZQlMwRa79EuBEe8NsutlCcySVDgzGaGGdahzRuE+d5BjjsQrspOzLkAXJX0L5j
         E0wUyfewUOy1xpwFU1SBi7cDFW96Cd5YfmnnbEjvl9Zf6RlJ9ZY79RubBsHn4DNHeN7S
         8EDM15reCVe5anvxdUzURYH0/lr/PUlBz4jJ4f2q/vCY1Xi3rXNjhLXX0DPcyaAtEjmV
         NGrZKNVA5bdrOGQeg+jagcPQlrvzIM55sjiMGdqZa43G/CBOwjdm8SBLdzTbG68bT3wp
         nBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937949; x=1783542749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNRUwb98CGj20jMOUNCoIeWSRqWstmMnRVlQAu295kk=;
        b=FWd9Rc0+cK8UgnICVhoMckuctUEzU9lzI+/h6+4KgE5bDpdKuDOYZEmn0py8pjg4xy
         FgmMNMo8cOz3qVH7zoZ2yU8PF+ASGC3vSAF6zILd3bBBvltSHx8WkXEZyTkrV5TDf0XX
         4wS06f4P0X8ONHj+28wCzSf5zCVZEAz2HcbUBwbM947/C4TemCCluDv1wzClJWz4LW6N
         KzXd67FpHcuZhJZGfu21lidTaYwGpaoWaP2bIH7WK5EuyDhgvv/guJcnL4/aa4mrHr76
         DCA+XO4peYWthLhYPE6Z4dCkzPLkwHE2ELrBKyDenumvc/enwNX/mUhNjeKcR88EohKV
         QeLw==
X-Forwarded-Encrypted: i=1; AHgh+RoYko4mFCCwqcpOFGU2rW41U6PzHCaYcWt77asgipYtiMqDJI0BieY4ceb2KaumZkdg19IbQ60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bqejIl/vwtARjv9MZK45ddvjbjYbDo+L/3w7elI0aoaNFTLC
	cmBgxAj+GiLMFFV11i+9ywtUTFIQSD4CVPyU/9Pz638sYT6DhDVUimDt0h8RMADFiATc8zKVOgc
	s0amXDMiwPtavGiUJx9tzXVy2wQPP3rs=
X-Gm-Gg: AfdE7clWRTaOThkZnWK5L1mPnmb8E/G7qBVp25IvXvgr6UWl2kyj7l4YEShQ8GhsWxc
	EDy7Pl1DePpUl5GJpx6mgN1KiKkyY/9ekAgtvc/FYFx1TFglBjTp3fJCqQpdp5MQLc3z0gxuaq1
	ZtkMZqtiVGCK+ibbKoyPujqOfZKytLxFbwLOYsY1lda2M+XgirLhghMRZj+PdT5Rs1up+dbhqtB
	viGuAxAeHG4SrY+TWe/NiW4QmUdtyvqkMM2xG9VRdpchZWT7hJQ8dXJxTPdHy9CXnNuhaCfI5fG
	6Ycbt9we6gLPT48PjHsvxC8LFRVUKbHEX9Keh3zm7JHl3rLaRxAFGi8ymWzDLFAA
X-Received: by 2002:a17:90a:e7cd:b0:37f:133a:3e02 with SMTP id
 98e67ed59e1d1-380ba74883fmr2259236a91.0.1782937949401; Wed, 01 Jul 2026
 13:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-14-ameryhung@gmail.com>
In-Reply-To: <20260623175006.3136053-14-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 13:32:16 -0700
X-Gm-Features: AVVi8CfcQa6IBvQSgCXyIce6uAtzmIMLNbYaYjbp5x30Mu2NEKAwhZgDNROhdQw
Message-ID: <CAEf4BzZ9Mf7-o6JNnqbTDTDC4mYjRCNh8o6cfN=TKqe8D=Sz+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/15] libbpf: Support attaching struct_ops to
 a cgroup
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8C8A6F17F4

On Tue, Jun 23, 2026 at 10:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to a cgroup
> through a BPF link.
>
> Also extend struct bpf_prog_query_opts with a type_id field so a
> BPF_STRUCT_OPS query on a cgroup can select the struct_ops type to
> enumerate.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c            |  2 ++
>  tools/lib/bpf/bpf.h            |  3 +-
>  tools/lib/bpf/libbpf.c         | 59 ++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h         |  3 ++
>  tools/lib/bpf/libbpf.map       |  5 +++
>  tools/lib/bpf/libbpf_version.h |  2 +-
>  6 files changed, 72 insertions(+), 2 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..0e5f4e9bba41 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -960,6 +960,9 @@ bpf_program__attach_cgroup_opts(const struct bpf_prog=
ram *prog, int cgroup_fd,
>  struct bpf_map;
>
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
> +LIBBPF_API struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf=
_map *map,
> +                                                       int cgroup_fd,
> +                                                       const struct bpf_=
cgroup_opts *opts);
>  LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
>
>  struct bpf_iter_attach_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b731df19ae69..1b01d49e58eb 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -462,3 +462,8 @@ LIBBPF_1.8.0 {
>                 bpf_program__clone;
>                 btf__new_empty_opts;
>  } LIBBPF_1.7.0;
> +
> +LIBBPF_1.9.0 {
> +       global:
> +               bpf_map__attach_cgroup_opts;
> +} LIBBPF_1.8.0;

v1.8 hasn't been released yet, this new API should go into LIBBPF_1.8.0 sec=
tion

> diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_versio=
n.h
> index c446c0cd8cf9..57b74ef3618c 100644
> --- a/tools/lib/bpf/libbpf_version.h
> +++ b/tools/lib/bpf/libbpf_version.h
> @@ -4,6 +4,6 @@
>  #define __LIBBPF_VERSION_H
>
>  #define LIBBPF_MAJOR_VERSION 1
> -#define LIBBPF_MINOR_VERSION 8
> +#define LIBBPF_MINOR_VERSION 9
>
>  #endif /* __LIBBPF_VERSION_H */
> --
> 2.53.0-Meta
>

