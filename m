Return-Path: <netdev+bounces-278291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DjvkI83R3WkqjwkAu9opvQ
	(envelope-from <netdev+bounces-278291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:34:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D23023F5BCB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A342530177A0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E825332E;
	Tue, 14 Apr 2026 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi0i4DnK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AC42AA9
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776144835; cv=pass; b=e+IqHnwGPJx3vRBBQ36nV3GsDsApkJV0bYoML9MHvItg/DOCDbhWj1Pr/waje+uZaftt62b37vw7Wjk0tWEzJ0zFnBdfiaDmuPW70saCEJ6LrbSYbJTKxG/+fJLLlCXIe5Q/fTe0rikMvh6cn5mLjSu5MHTs9gbdh73tpCINCII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776144835; c=relaxed/simple;
	bh=8q1N11Zn5pADNoSqxogqX2MmUvfgKEsXUjPofD5CHOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q70PxSE4kw1yMfeMsd+eHz4kHxCGLoqIdok0bnT0Kr6FhffFPPq5IfkKCq6ceAGqD1MTJ8HiNui0ipS4laTdhccsUbV1bQMZfVkcbc/PbrsFntSp0wYuXrpc+sGXIcF4ay7ncQPWW9+LAw4Ii0TW2C5kyTxNMDA4oAS+dzDerNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi0i4DnK; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732165d1eso15399629c88.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776144833; cv=none;
        d=google.com; s=arc-20240605;
        b=axThl7TAfpkLESwqkXBGcqUvs3VyUw3DTy5u5sPSEScrASdNrx9Gfng5frlzOgTB74
         8gZzvH1khkImKzMGJTw5MDnxgmsdWBiZccCwo53qd0tR+mb58zmIqP3dKDXxEtea60KE
         gjlItLs+sNEChEPJDSGHKQELc68biy9/CsZcutd3Nd4fsFaH+ArHtSGZ7mNmrudrgvGy
         pOGOjTrqnAsHTa5j5UMT2Wq+iQMcxrDB0ojv6z60QmKEPa5x6A5b3cOUpCLZjHTS2EQU
         ZoP6Jt+4sjl7LhLl5O6soj23+6ymL/qaiXsGXzam5Uv1qyYhPJ5wZgqG4VdtthqYRwMS
         X2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVouDeougk3wDFZacqPVGf/m2OYe+F7np3+CAuZPX+o=;
        fh=LlrRZG3cvgog7lgryL7BiFVnqYXQ6x7JDlIcoXrx/W4=;
        b=d8Sbs+6fLKk1mE23zriJuCne6VfjgXFUIf7/9M+i+MHJfy9sN9TbHzl2NLV5VWhUMh
         NmGC2aR8tT3PTfzQvz38oeQpnbtKHGOkDS3TR+oT68Hrufo5qFcmgw+x0E11zuyduV2d
         AI5i3vnN7L2689HaC8wLWIZd9w5lOfzi8A5iNu+O/bF5GCQb1aHMcnHP99mziDkM2fr8
         ZNu4hO54mmIR8SX1TH9CZGcls/ID+JyMYB4lkIevsrkdUgD9yKctEE0xLIyglanSnecv
         iT9aySQ2bFhcCyoaaznLEe5kzY3zbWzabl32o+yPENMheqQQyWXg/cQqLzBs68nWVrAS
         ONcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776144833; x=1776749633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVouDeougk3wDFZacqPVGf/m2OYe+F7np3+CAuZPX+o=;
        b=pi0i4DnKgYF5ds/rCSW/Y7eqQNd+XrKQ/xVICpcajJQJSP1f2sExrKVsn4AFarYG2U
         D/tHSGDdVj0ElRyBy3hun32wFew/6fVTKrGs6jAE3eXxhu1NYP6Amgp/3JEFnJ8hjrep
         x7xSiVXlo1F4L4MWd5GF6Lsyk3tBwSbMDd8xzSsp7LcwUcF28UeSfE9PX1XAEukxzCJ1
         4oLqsiz8iRjM2HZqNjBrsZGOfgS02Lzij9lN9CP4v7ryDBKyVSPnxhT8cc9m9TtGiS2l
         4tlvkxtR+Pw6vBE2aVjEHea7cDFinOd95LIchOrnzf/jCuh4Ac9/MMy2xGD7Q/UpSzub
         A9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776144833; x=1776749633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVouDeougk3wDFZacqPVGf/m2OYe+F7np3+CAuZPX+o=;
        b=eRr68X3QnSF/HOvoS2gVOYjWe2SP+onlJVkB0vcWQWZdVF1WX/DYGNs1uTbQqWExIV
         fAa1xqqXBiXOJTcKD0delkX7NkX5+v4VKzYFUeSroc3bUnWaWQ5mkZVmAbFdPeoQnrMN
         z3Kq0rerGVUpra/P017MH6xKWGl+WonMaiO4u81v3SDhZshN1ZQmXU1eKFXHJo4/U8Sy
         A2qj8DWvfMLjto9zF1fC1++9HOW+TcMQkUtmo02vSBqUL3t7L3cKAYvbR0thO8H1xKpy
         LwC2HNuTCvzYUWFrSUYcKhz4Ih6TmI9qEXU2IqYJlmgBP3NRsXWI11Ek/MliHIiKxGnV
         bnTA==
X-Gm-Message-State: AOJu0YxxzF/VskBJpb44xkxdCO3Y/aWW+9FDmudirJJOQPjBkOlM0K8+
	llYU5kyjPtervzoTjgEL+65GKZn61BxuYMuGFYDMoG1ZQC5W7fUkLm4l2DeeREz2DcYuvJyWyM9
	cx9tcM0UxIcNuztOlWbr8bjj2unTfBYr3v6Mz2zhP
X-Gm-Gg: AeBDiesdYYGdoE5tJEjdyejpa28eMZvm4dRV1WMsoe9faTUEh8/60ip7tO5r+9p/eIW
	3CRzdQKlW3s2SM+ht9/sCao7xOymKq9mQtmpiGY6aWDO6AXfpSUTSn/tIIvE5/cgDfA9ZNZD7D8
	gYGV/aXP0uYbXbQ6tji1020LRnmF7kYtGOISmhkvOS4xQXNFvOqAP+il48g2RzjWrqaQDEeC1HW
	N8Yb1qA/Q2WS55mqFTYXRJFbSwQh9JYSBmLNxplyHnsgqz9qIFcSapbY1Dw1ywkPSiefN8VFeeg
	xtzYdQJNCDHNcWLtBQoVuoNX4LhrtFjBbKiFgVxffDn9dVjmNv1Pnj1Jg1y4kJYVvb+2CxTd/28
	UeIOqdxi9uiLBTAUDs6856+d712m5xKfhHymfNkzDhRaUGNBspxxMQQ50xmCOSb8+IOIK9Xhh5A
	==
X-Received: by 2002:a05:7022:2213:b0:128:d494:a1ab with SMTP id
 a92af1059eb24-12c34e7c3d2mr8886081c88.15.1776144832852; Mon, 13 Apr 2026
 22:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413122916.1479959-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260413122916.1479959-1-n05ec@lzu.edu.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 13 Apr 2026 22:33:41 -0700
X-Gm-Features: AQROBzBMLhEZNAShZGviiCV33iyDZxEIUGtFCj-1H8XNRRNVGzg3bWP31f04OQI
Message-ID: <CAAVpQUC--TT0M1+xd096CPw881tzHX-MddmT8sZs4sjoatVeLQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] af_unix: Reject SIOCATMARK on non-stream sockets
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, rao.shoaib@oracle.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, enjou1224z@gmail.com, wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: D23023F5BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 5:29=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> SIOCATMARK reports whether the receive queue is at the urgent mark for
> MSG_OOB.
>
> In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
> SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
> so they should not support SIOCATMARK either.
>
> Return -EOPNOTSUPP for non-stream sockets before checking the receive
> queue.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>

Please read this guideline again.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when=
-to-use-acked-by-cc-and-co-developed-by

Co-developed-by is not where you mention someone who
developed a tool to find a bug, and Suggested-by is not where
you mention someone who funds your research.
https://lore.kernel.org/netdev/7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.c=
om/

When you just copy my fix and modify the commit message,
the two tags are inappropriate.


> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> Changes in v2:
> - Rework the fix based on maintainer feedback.
> - Drop the receive-queue locking approach and reject SIOCATMARK on
>   non-stream sockets instead, since it is only meaningful for MSG_OOB.
> - V1 link: https://lore.kernel.org/netdev/f6cbbc8da90e95584847b5ceb60aae8=
30d1631c2.1775731983.git.wangjiexun2025@gmail.com/
>
>  net/unix/af_unix.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index b23c33df8b46..09d43b4813b1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3300,6 +3300,9 @@ static int unix_ioctl(struct socket *sock, unsigned=
 int cmd, unsigned long arg)
>                         struct sk_buff *skb;
>                         int answ =3D 0;
>
> +                       if (sk->sk_type !=3D SOCK_STREAM)
> +                               return -EOPNOTSUPP;
> +
>                         mutex_lock(&u->iolock);
>
>                         skb =3D skb_peek(&sk->sk_receive_queue);
> --
> 2.34.1
>

