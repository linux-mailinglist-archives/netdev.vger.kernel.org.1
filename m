Return-Path: <netdev+bounces-298478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1lVAY2tK2oUBwQAu9opvQ
	(envelope-from <netdev+bounces-298478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD16770B8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:56:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tDnnLq66;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298478-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D01A93001A78
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBED3BA24E;
	Fri, 12 Jun 2026 06:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CC39656D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:56:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247367; cv=pass; b=eXkSws0DdkSCDinZ/REYpzVfGv0O+fib67W18qyWW75pKB3QWFy3ZLmrOYb0APhVk6qRNNh3MI99s96eLiSCAVv5Uqur15kOQyXE1sUd/ZE50APSb3/PBkchW5ktoJFrltuFoTxS0tAJaNYzxmFwtKgkB1lKu9ZEK+OpvM4+UpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247367; c=relaxed/simple;
	bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsQKn/iU5k/C9Qgfdb8RrnHix84FMBgEMB+ehAlL/4UmQH4GbBv4rY+jzuh03PyhjbhFjEs3zabfCfUNfhiZQyJT1A/Km1avcABXhORX6Zpb6Y7Ki6kIrv7aghgEvz+QizGsbrx5R2mFJUv7vREGqdtjodS/byFLc9yWYaYA+QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDnnLq66; arc=pass smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137dd523634so970208c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247365; cv=none;
        d=google.com; s=arc-20240605;
        b=hpzhxTjq1zpxiGkIz6X3l1TZrjX7yZCo7tF/qWELfW6NCroweIZbNBb7h00QGiEmco
         LlnHrTXdWRFvDcu0HnO3guDaEeyrVY8RqpfP7tnlb30/Cm/hLHtgfLvb/lBwVKPQ6xGt
         zeECmtusLK6uiMe9MHOVburqp3BEyaRUZ9WiJObZ2YE93n2F8FSNyhVkkAkdcFAmx5S0
         TB99JB1b/i/SiFqQIIdi7TTc95DPfq8y03foUlb1wHuOmF0qiuSm+3ByEoiWj+cyVN4V
         zSIpG9n7K1NyJq3ZJKN/LtnfVuwk7jPKIvk/BWfMpSM4pWigDjdVBiuiFb5L4e8DTMJX
         q7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        fh=69FFy+uZLiviY5xCGG8kfCnzY6e729gACIWSaYdK1nY=;
        b=jkxBcM/pL79vAp7a8ECz7jaxOMPR7+aI25feeIQaj6an0Rj5d5iNFrBhtXQTv8s46d
         ShCFPmLda0hAcbiJU3He2MlzaVPnfHwJMCrsgdFNlWqstt1JQP7dtpsMwGx4I0/V0zOn
         XggmsebMutBbCzHKLbCozMSUULP3ZB1DAX48hg1wks7H7NQs5o8b80ozuu9PXObbOSbh
         64TqPHcP77G3RES+EJwq9l9whd8NBzXAiggk0Ga122XKaXyG56gBeCu6I6SowUnSD2y2
         RPxv1wwlxiFjaHmRtN8c572xcr5UaJYy5t1atv2g55keAbEU1Zedy3oVNqLAjgOH9llH
         KOuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247365; x=1781852165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=tDnnLq66U/7YriXO/p3hf0xPPUBvccDxaEvLMPzkHpgINh1BfVj8jd9tniKdCjQ00O
         bpHWoby/guzin1dGMSWfGjdqN9xcP7DUFcS7wMDaEuMPms6XTQ0fESFvGBr2GYHPDofX
         10/tBTgDBflQxktWRoBjSGOxXtFNLTx4zEeQFWD8x5e6UqbR1fOygVVWcFi9IjDBulh4
         hvYiRePGKLZoemC1huqsCRQv5551AkWyRH/b69I+XQbAMY1tWkgtfw5fQ+Y2BaRIgfTy
         TcEh+0dn3C76VLk0oDfr61KI8OkznPfPOM+JFJHavCoOj+K0YyAUxp18ewG0uguteNg3
         c2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247365; x=1781852165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f68noOVQF9KBVckuaYO+e95KRcHb+O67gDqXNyDwwDQ=;
        b=CBS+zQXNfDyitu/fLbqXwDqIfjZhdT2e3hAlwhczbnf+jOQ5iBuBMle0rs53x/UZ0w
         UCY3xSQjImSLtXULr5c6OpGdPZWbrzMH/gWhiol0JN8QKecqyaeYk9JXIhm8g2tmzsqW
         lQGcLLf6+Kfk4AYus40m8ioBplKc2KkMq9m2RNWUciiKEwpc1nEnRH3CvRywCX9z+sob
         sY3/qp8JUm2hB17vMhKtQ2jRrWSCj7ROSqJ4IE/WKleKYZCq//iKhDGE8x6lNsc8Ir8u
         yBcVo6xZpRzsZAPDqCR+TaZChuuvreScH1G0PC23Venog2FsgXnC866vvmgTIUHpWMme
         SfIg==
X-Forwarded-Encrypted: i=1; AFNElJ+HwWSzXLHdOK5Rs9BINbhDEWW0aNxjzTrmCK7olxrSZBwxYz2B6Ye+VTO54KCHg8wABnXAAz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOALd27758WKIGzJB0F7dbyK/TjDxC4gjPqCshyll5W2qN0uen
	aOT406o96Eu1XE0ltUgVrHuyIYOGU4P7x1EwOqzsAbzKNypxQx/jw8a/2pVLfXojmQtrL7xdWni
	4r3a2QyNbGyn92/uNKfJAZTngFB7VMRZVfqT+Koh7
X-Gm-Gg: Acq92OHBe7bQAGY9+9/9wDjeYnQFhrY0y5AHi2ZO59oEg+JVPd62o9i9n8iBm6Fehjs
	xuH50nl1Y9Ft4UGtBdYsRloAoU6y13RaSfSowBhM4BTy8duM/NUl3UdIl8NOqpE8gWBT1EYEyUe
	5Denk0i0UXAjIyNPU9wo6wcdKoIYaLPoftPsllzhWbQa/tb2zyz4BvVAYmAOmCT1lZRAlnLRCJ5
	09aol9cJ9vW+nqsVyJdjIWKTnGIMBjx/X4KEyheMZqDyk20mFHkAGKhsRQQOM1FZC0F7kfeFr5Y
	9l5Ymd5H7Pe9gdVFnJlRNEKcuhDeSQY+7nuaGK+BExRW+kIsrwYNH2bJG8amKTOmZdJeCx8f9yw
	dkJf5eUIgcs/+Je162OtOLEUVjLWpA26VTwxyIvvnNMU5HGxPkvWC
X-Received: by 2002:a05:7022:799:b0:138:407c:1d0e with SMTP id
 a92af1059eb24-1384bafed35mr979348c88.9.1781247364686; Thu, 11 Jun 2026
 23:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-6-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-6-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:55:53 -0700
X-Gm-Features: AVVi8Cf1GPdShmUPANLnqMFhkLhcgfZz7kJnzsrHhuMtqU_Vi6lWkaFdf4-H8sw
Message-ID: <CAAVpQUDgZuLGpY1UisY1inkiage1m_Yw_FEtLzxq=yFK3oi8gg@mail.gmail.com>
Subject: Re: [PATCH net v5 5/7] net: ip6_gre: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298478-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFCD16770B8

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ip6gre_changelink() and ip6erspan_changelink() operate on at most two
> netns, dev_net(dev) and the tunnel link netns t->net. They differ once
> the device is created in or moved to a netns other than the one the
> request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
> against dev_net(dev), so a caller privileged there but not in t->net can
> rewrite a tunnel that lives in t->net.
>
> Gate both ops on rtnl_dev_link_net_capable() at their top, before any
> attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

