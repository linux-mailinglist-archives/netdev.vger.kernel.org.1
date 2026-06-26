Return-Path: <netdev+bounces-302270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhLTGRvqPmrLMwkAu9opvQ
	(envelope-from <netdev+bounces-302270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:07:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB46D02F0
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 23:07:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RQbAIVHV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302270-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE361309051B
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410BE3BFE3E;
	Fri, 26 Jun 2026 21:04:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49383B38BB
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 21:04:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507850; cv=pass; b=cuJUflYyeyHXO8ZOFhXUb7zbm0Nm9MZCHwI7lzsvv+3UTjHoLQul+eQz7dwVdTRlY0K8K62PSZ44P7exaW7h525DyqZYGr5dXwoz5Bshq0gt05JplKp51Ca9ciQXj86QhhTOAqBpFbj+cN8MxOTYxaa/tlY9m3y3R/bFFte2d64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507850; c=relaxed/simple;
	bh=Vwt5xW+F+uiSa1tQBJJ8nSM9E4LO58GodGc6uVU7V3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD2l3dxkBXIlvMOXlG+i4nLojR3bijdOHfnWN1Z7hWZQ2bgzf7a0V+E0OriEyiN3hmBFRywbRq9Ijl6UwkmyOlsY3zIFI07fclC8TEXlt6Mpigt9PeUuoB/8g0EJg3/XWh0LL6cmcE40CI3ZiJpcaawcono1by4TWX4Y1Q6wxow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQbAIVHV; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69532288224so3087611a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 14:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782507846; cv=none;
        d=google.com; s=arc-20260327;
        b=ovTdaqspqm14mUlYiduvo/5ahnqQORQx/eBR6CXFk5oALzxWYx8qhWP4LBlflDThmb
         RlG6rjaLRuk47mfJydVpCxwofvJ5ZonMXZFJ0zleHImB0fPMFmFVBxjoxF4/DKt6EXHO
         k5tyYvlATNqL93UsIwhYzSDtnlsqIf2VlvrTeJQfWGnG6lExIIkwn1SoSRFtYzqR2rqh
         XFVbLCQj06cfd25ytfKsKCXjLRMvq51jX/j3dEU7kMc2ml/rdq6QfhPadRf23deE8Ekp
         nm3+KcDDl7AwhMeBFU7vwViSS4DYOYrMMh3WUrh7DiMg11hkcHyI/NvkgNCS4zTr0YRm
         WoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        fh=7s4XeG5l0J/gIiFRPAUHmeZ2x4fITtiBXKH6xgM17ts=;
        b=EAu94i9CXAOcrP0I3Tso9jqGNGeiPqNEEvwAe1GJKECSK8XcMnlhI/v7AwB9yhAPaa
         tefmGp+qCHfrAEd0QVhyfaN1roqns/q4mClV3AqBISPPL0D2lh7ivSUvixCM0YoJSNei
         IcYOYbIfPka8l55ry6dPL3NEgrf7KNubA+9JatHHzLCngOKX9jVMeDsW/r357hAnfSk9
         xxQ7+pqpxoXgH2Sx9wcCTExuwSvx6QQQ3oNyiCVz5m1Ml3z6TjNUcgnVJvbGTpXjFLcg
         dk3EMYEs0oleJiRIroiyA0uY1Y6wZ9y2j11tsqFl8ilFlxzvz0VeCiJeUoY4XSgUseRr
         su1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782507846; x=1783112646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        b=RQbAIVHVzTu+u5DJwVg+56s5qoOktbvUMx+93V2Mj/kvl58IkMc0hFN9Ord4Mgn9yg
         bRjxKXSSkBzR99R6NuihGd9rJWlzc/8CpgN/qltnwnRgCl4WH2BG0GtEq/oMzNRgcgMA
         u34e1dFzklc9lyj627vBex6wkQMlIM/YjiTra6tonnka7/K2yY6bIm9hSnY9T0yQx2T1
         mzPq4iVh2SsQW2Ukg5qYnbYLr16q+0xjEmAR1ND4aajDhdYqRR822vOzQ883BjgeDtyf
         lsWxLKlhzAyYhQhKnO9urh+SyLd+qARQ2+4nlkmO8HdXtKPK505ICOTdxSdb1Uv+4j+B
         O0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507846; x=1783112646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvCC8HZmChXEnRo8N9gbNXNqVSfwU8t8eArZec9rkjI=;
        b=VSA2/TILlqnbw4uuM8657hWGLriJcD3ghggKqbPJFQjKUJ1sak04/qwrBZROP8xBo3
         KVPAMqyIXLwigjK2S8sg8UHacam0vKT/JVfvC8S8LxNFjGdMvITMI09vVKvuwamO0Ydp
         nCDaytyYWlccRAVRDngO6ZG8x4AoNGguvMol+hRUE6NaEWFOwzV5cMuSvMLLxKdT/3CR
         MVH0LLKZlw+Or7DNaQXly7YpRIuQymCWy0BuFDD1u9AEZhpR1f1aDVFg1fIFquXPcPyb
         yH/r4JT5SJWXqGJsP8aFg2xgyW/Vr85yyAA6we8U2mtCIh+uIQINxbgw9nOjH/Vl+z5g
         JjqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rofd+TEP1cuSlw90yBGXrTe2oj7JayT5/aBBaxty+xV7FLoOCDaNbzIUXUb1His8eFdP0S6YLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuxXaZ8nwFbZGJO5ouwUWevFYQ0cdfikhrflov+INW5h3wVZs
	eXrMZbJ8bB69rmGvGGzVgnpqmd82ianfYGW/ObJg70jE6/jO08pvUMGSZS1dY9BgJY0CCGoC9jx
	XA+AYwIDUMdlJrxVKqcXlPzNQk9dvwvpIHvELOPip
X-Gm-Gg: AfdE7cnK1owkpxriroycTKUbe56IwEXHfDdUEZNtD5CPAr3OyYAt99HbYjEoCMNu0J2
	Ef3d+VXIwLdl60BCGj0Xe8/jP777JcD7Dx6cQzImRf6kYtdNRf/I/dlwKk9U8sBT1KN7pQpnaTB
	wrahX1soAyQQAFk7hFqtMxCPnowKIc0Q4DHCRhfTBeEI/ohDN3GfDiPxueFUyRoU427TJy9i+9G
	j4TgWMyTIn7yQYVZ+MCEST4osuko5cJ+bkukywBj4kMKTZVvXAaWPBkxtVNc3utF+n894ROZYs6
	qMsAgSc7OK3svcMYwLB/BWve1nKnGWw56brIiF+WDHBITyylRfE85ElfEGx6W9++vwixmq2wUiS
	vhpQwOwFot6hsbWtGwczgPQJJQkvog++q7rSeSyM=
X-Received: by 2002:a05:6402:d0e:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69810a15744mr3008960a12.5.1782507845615; Fri, 26 Jun 2026
 14:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 14:03:50 -0700
X-Gm-Features: AVVi8CfI1JvVlmFD7FSw9WWO-q0ESRJAmfkw-4ZmG4UOIO4tf4PPeHZBhXKMPPU
Message-ID: <CAAVpQUAJYkOBEtgUpL5UgnwM9Hu3Y57a9xZWRy7zHg5XkGnW5w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Fail unbound UDP on sockmap update
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:edumazet@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,redhat.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8DB46D02F0

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> sockmap now rejects unbound UDP sockets. Adjust test_maps.
>
> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
> test_maps now that sockmap supports UDP").
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/test_maps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index c32da7bd8be2..81cd5d0d69c1 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -759,12 +759,12 @@ static void test_sockmap(unsigned int tasks, void *=
data)
>                 goto out_sockmap;
>         }
>
> -       /* Test update with unsupported UDP socket */
> +       /* Test update with unsupported unbound UDP socket */
>         udp =3D socket(AF_INET, SOCK_DGRAM, 0);
>         i =3D 0;
>         err =3D bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
> -       if (err) {
> -               printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
> +       if (!err) {
> +               printf("Failed allowed unbound SOCK_DGRAM socket update '=
%i:%i'\n",

nit: Maybe s/Failed/Unexpectedly succeeded/ ?

If we want to avoid breakage, this patch needs to be squashed to
the fix patch, but it's discouraged in netdev, not sure about bpf tree.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

