Return-Path: <netdev+bounces-272590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOVhGDORxmkyMAUAu9opvQ
	(envelope-from <netdev+bounces-272590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:16:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDD345E45
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD18305E995
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E551FF7C7;
	Fri, 27 Mar 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2jx4+IZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F543F167E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620676; cv=pass; b=DxVg9KZWWfLL4rBoA8IWpR4qyQMbPljulZKzcfh1Ebd0aRwIvDzdizkxT889l3EAd9bZsG9RUhUzxLQlUFC3uizuLBKpnMtrE2X9ETttVvXW0r0uZlZ98c8F65hqv/Uh0DhjQyoD1uODf10sosdoZyFuw1OaZ4A2c90shTs/8Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620676; c=relaxed/simple;
	bh=1skoMMUxZeIg+2DTo8DX/uoQucNm0ReccKYku+/xwrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD4ovPuMia1ODeJQbGfBSK9U5m62jWzMq8SVXsORSsQtnsCg007BLMFf8j8tDfBvlupOnnyMA+o3UgK3brXTtRqG69lPKSW4jdiGQ5Svo7NQ1Qk0NKxSju0WGcBvaazubp2b2gzbGdP9MjycrJ2x90YfpfBqcoe0LmNWizmJIKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2jx4+IZr; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794719afcd4so24567847b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620672; cv=none;
        d=google.com; s=arc-20240605;
        b=ZIuzDBb3PFenQb9vqC9ZkFdGMMcZeQW5Htod40k3mlP6cWhz98lioJl16jLpj0ZecF
         BniASl65hAMwBfIMQ6QaiT9uQJaJhsLdn03DYOjlbCVLhDdO0+2RnbYfdBGFGzNJZQtS
         30e670punXg1wk6jCybWQ0ejHM9pxK4iMEMltGT8grzFBbXQo3LZiahT/W1JeIPM8EYR
         CAJneQFanA8UQOgwoZuEGdXr8N6NmC2WHuKuIB25cgvh0p9FJ6QhudhnSD1k5zkl7s4a
         jZFXRgezc5uYWJZch3MIE2vieSHJq/zCiPkA7iwTdo3laCGH1zDEkn/NuhM97lVoIcXO
         zGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBNu9CR0N8MX6k+jLTPo+hiaHyEDuNBx05s1oN+9VBM=;
        fh=nYVvRJn7C0FHwv+zL8foIgb8fRUFEmEj4NkKRgmpwPk=;
        b=k8kHSSDv8wWbCfk1nqi16NFm2grZLFtdXpoFdxS5rqNas3hZSytV4c0XM0mjHYrpi0
         1380pOdwycH4YVuOWdiCQWBVn2kYpZ66lAYMnOfpZ3bVEtnSsUwTLMbnfhvHQhruQNPm
         LxiErhPBeI04zDL+eeJu2RmHoBPYbeUDBUGCK0imMGthljCgBBF6gEfPAeUtiPjwPdgU
         gep+umjmetpgE+PFJpXwAbTIV40ojmRKD4RgpaNGzLJw4LvcF7EjMWj8mCZyvybzH4HE
         aAlRQVo4MNGVo7hYzbUmafFIyJSO0te+Epy7fDPi2BQrmA+e4LRxv+QYxJqFkKGgLQA3
         tf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774620672; x=1775225472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBNu9CR0N8MX6k+jLTPo+hiaHyEDuNBx05s1oN+9VBM=;
        b=2jx4+IZrGEaAOTGKeK1wnebSwczwnV0V1xwbEukBbB09zbLleyMd7rqeBSXkucql8V
         5q4W2r+zCcG8fyjttfM7M58jniTOSr9mdi+B/jcRcdoBIDD9+88IApisqpm8Ll9Fh2OG
         +Z0w0SohsD4j0IPbPj6Mt6EIKMyGd/v1AOFIpVQj92EqyntHkWwPflbIjFe1ByWvObch
         a87sGSjvdc4eB5sb111XnF6Q4V31oJ+hnV3dSxNYeBPX9Q/zLYf3i6z7ZC+278c9AYaA
         n13zHzhZOlHhkuLLMp7LyJRvnfPRG0Bey35RfTOYsra9oNa5kjOyO/u0Z8ENNGinay2w
         /VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620672; x=1775225472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBNu9CR0N8MX6k+jLTPo+hiaHyEDuNBx05s1oN+9VBM=;
        b=PrSIK4jNTQxJRNt7pW0LpUEhqWeCI5RMd4NkCHl6R7cUetRiJYCf3jLidGu7tKy8hs
         12+Xg+7B7RJSzqO8oQIOJ0p70q439+Zy8qc4XAsB7WJkm+tpjMAhNjUBQXuQXiaztJrW
         8UqsOnvnEj0r0MaebbQYQwgGtLsxDdsL0d7GAwzJAZMeOIALs2kzvDROc0GN1S4RHHEJ
         ipMJUlwTGM0onrgicxFDYXRz5nTORwYsoubKoq0itOmg4grkgxfDR7Y5uh/LVJTf0x6e
         BdImz6emnAAbe/eAjjEpO4ecBWZOPuI8gKnBMdPNPdwt0PGIWH32sZ3jur/gS4WsprJN
         E/tg==
X-Gm-Message-State: AOJu0YyWT+w4b+EAk8xqrnuvijCKPABrsbzSSIYMFYJYvJZD4T/9Y15A
	JjiXY6s7KrRnto7SLXwil21cPAO4SwIKDp7Oxr1TSBvukvwL+HBpdhdlqfKRvTqnixx4HI/4fVA
	ZbF3DUkm6XFZZVi/J8+mWXfENzUuPdsnbpxbpzzKl
X-Gm-Gg: ATEYQzyOSC2XkgdBpwBZBZLq7dHEOQZsZVQC16ho2RJtTrLqWE8zGKwyLdWivkLHDCk
	Z8qRr0hIpjfG6bsU5ld11MZ/eR9fLgRFSYs6tQYqlGwkwMvASU1xk8w4EhJdpTeFAA3VoU0S9Ce
	FtQsG88Ok1/tGA4z/EAPx8LN01v2Yyhu+50G+4C9Q00MnJsy/jTiqT8TlubugRCmfRR2zf6bk5U
	DmUrPMN1sEE1mPpPAH3bZ3cD1vPTLwXYCxEVePu7P62uVeP8N+L6ng+H8osFTkiSryqrZ2Z9Fep
	itNvCLBZViLfZfXQl24=
X-Received: by 2002:a05:690c:f14:b0:79b:d18b:9beb with SMTP id
 00721157ae682-79bddd220d6mr26020177b3.14.1774620671780; Fri, 27 Mar 2026
 07:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327061300.3066844-1-xmei5@asu.edu>
In-Reply-To: <20260327061300.3066844-1-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Mar 2026 10:11:00 -0400
X-Gm-Features: AQROBzDVoK6H9hX7fbkGa5Uy0qe-0l7o5f9K07_n6zsrOH0VX503o9S_PoPzyOY
Message-ID: <CAM0EoMkspiNjXpdwnG2HaPK3n+BJkjTRbA8k4TsV4fcVk7g_Zg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: cls_fw: fix NULL pointer dereference
 on shared blocks
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272590-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,asu.edu:email]
X-Rspamd-Queue-Id: B7BDD345E45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 2:13=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> The old-method path in fw_classify() calls tcf_block_q() and
> dereferences q->handle. Shared blocks leave block->q NULL, causing a
> NULL deref when an empty cls_fw filter is attached to a shared block
> and a packet with a nonzero major skb mark is classified.
>
> Check tcf_block_shared() before accessing block->q and return -1 (no
> match) for shared blocks, consistent with cls_u32's tc_u_common_ptr().
>
> The fixed null-ptr-deref calling stack:
>  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
>  RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
>  Call Trace:
>   tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 n=
et/sched/cls_api.c:1860)
>   tc_run (net/core/dev.c:4401)
>   __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)
>
> Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q help=
er to get struct Qdisc")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Thanks for also providing the tdc tests. Looks like a bizarre bug=E2=80=94a=
nd
in my mind the question is does fw or flow even factor into tc blocks?
Please give me time to review if the approach makes sense - perhaps
this weekend.

cheers,
jamal

> ---
>  net/sched/cls_fw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index be81c108179d..caf17ab3be87 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -74,9 +74,14 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
>                         }
>                 }
>         } else {
> -               struct Qdisc *q =3D tcf_block_q(tp->chain->block);
> +               struct tcf_block *block =3D tp->chain->block;
> +               struct Qdisc *q;
> +
> +               if (tcf_block_shared(block))
> +                       return -1;
>
>                 /* Old method: classify the packet using its skb mark. */
> +               q =3D tcf_block_q(block);
>                 if (id && (TC_H_MAJ(id) =3D=3D 0 ||
>                            !(TC_H_MAJ(id ^ q->handle)))) {
>                         res->classid =3D id;
> --
> 2.43.0
>

