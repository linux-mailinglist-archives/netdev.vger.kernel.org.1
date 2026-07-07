Return-Path: <netdev+bounces-305315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jRfGD3CwTGq6oAEAu9opvQ
	(envelope-from <netdev+bounces-305315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:53:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E98718B73
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 09:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=natn7o+g;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305315-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305315-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E5783003D0F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56336A367;
	Tue,  7 Jul 2026 07:53:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275430C168
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 07:53:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410786; cv=pass; b=sYQVxtSF7E9JZKSU5zNUPSo8R1ROI+q7HMqQlcS3zlR4VTrKpHxx/e6qN/RUtq+LZtp9ldAX/aiYZlPO02q4HncSw79ur+Ir2z3uKsJlBMjLGnfy77U4nOsvmryOHcFpPiyLino2MrVCl7altIkLugF8eZDMMqdRg9c4gGb9xes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410786; c=relaxed/simple;
	bh=ZQUk0UfnaGyun+ByKFQ6mKbppq2aWwvLE1JvvXQvFow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYLF88rT0c3mNjw306cmBGhY7A9TfC0cH7eJ2bQaix6D7af/czAeFac8g/t0ZuhAYbM3te+o0L894DK8nTZGzC6g1vF4snASSsEk6wJEhn0y3UM7DYTK0zboo9uiVg8g9YfdObzbUUaY93TIYeRDVb9iS96Bnwru7oHpNGp4A0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=natn7o+g; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c4436d02cso15473371cf.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 00:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783410784; cv=none;
        d=google.com; s=arc-20260327;
        b=X0zHZsdksQoOrLdK7+nLvZbUSuqI6cECHaaxJV/1/QZgFKu30YEpSdFFimJy5HLJJ9
         +2SE+vmCTEfiWn+7A3Wg6l+2CwJgxnpMJnO3Hja5CDxSqMXRTpSH/LGLLqRY0ijIx4XM
         wZj5Ll8sa1l3Sx8y0ISFLhY9m/pTuBWPYaltprDi0Tx8Hkjyyq7pQX/OkeS4RLM4DYd/
         dVYLwYgXpqESYAe/b+AkitDqLLVFWl/AFgYZM0du1kotGh/XhOsxGihrCX5oT5rDH8L6
         FngYteDMP6rEVb4rpLT/drMprVPIxfw3ttpZojRH303g8aGIulNzJUj3D0XcAG2OgZyr
         bDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        fh=Asy9N+G0dbxQrDjK3WV5XeKifKYIg48Ww1NkcLaXnEQ=;
        b=jI1EcSk0IH/AdnfeSfreD5cAailqL7Of8dNF8ftqBH43G1phSxjHQPRehjXJV5tko2
         zXC1jEU+wORWoQ4tRYy2BEBhfYPJW7N+A2uN4RBrONoXQXWaG7CL6zmarn1wauvtTxZq
         Zss9HjD8pFXAgV5ftNYtDyHjk9jAYx7SoH3lo6Zuvm8wnUYvBRqZtVEJ+f5EpPrgLbcc
         VcVOnYkqGXhM4Wl90ZQSOREdW5ZiIn823jOteDRIiq7kG1FVE9ZKFtrpQntfCquziTX8
         UJCtq+BIZk6Fgu3ZaB79RYIA/7G8Us8/a6u83EZlgQcDKxe+qP0jk7H2IZ23fGNf62+O
         pkRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783410784; x=1784015584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        b=natn7o+gIOW99MXMYhK1tfYirzMc5os6QLnT+UbYPTTJPmcEjPPv17B7PzvM9X+gDf
         V64YxSZg+8zeDGQyeKMpIVzzDmHDaRoQdmjh2pJ7RG+grp3sRNZei81r3B5M/Pq/Gdax
         UddPQ2hglpSrF4+TVntdNsnoEpWtKp8not/XE80iHZrZTWfUQRKicEUc/kwVA9+TSpoD
         ELN6NbirQtzWSh47RDQDSJXxvee4Y3t67wmIUuz1I1FyNfU3L+uSghMn2nAnGk3LxTpe
         /pSkRP6HMf1nYhc0TvnDwE0Id7O+EmMkyYdSgNfuVldQwMjiC7dOlsV3puqc2paalnb/
         WfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410784; x=1784015584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9y+HGLwWZHe82cGq92fBiAG8Z2PP+p562QyKY550vmc=;
        b=q+3fI1bkp9b02vwDhcx59qdMfKkG0uvTlRdIJDHf14a7UTyxkpUVz3N1AGP3LHuSS7
         qYhQjLDBnJhluCob3iz9C8n5qIcXPfLpqwOzExSqt//0/18aJIOWK1BxRPTZhCKhXqRn
         F0pK0U3RhrcTI7wO1YbeJPUnyzXcKK2jIA/0X9QR5L6ai5/5yx/tTRal21e+HH5y9tJx
         sHiAPYNIPwRHK8FojTXFoMOOUeqSVvH+sgTws+dDTYWqOx4G+wltfRBjbtJbOKYQ9e36
         tFoxh83KavSJon9zh/xBiS7CMdS8hoY9v1ZnouNTpc9eUKOBqfey1qdKGTqO4dw0WVHX
         bF1w==
X-Gm-Message-State: AOJu0YxjvL2wwt10uSOQO46sHMxJMfFqZxOBhfFTksdPXXctxUfa6DeC
	+OFUE2mJn6ohmBmh7CQDK2IMTkKdxEz3tz0gYfJuiATBxvK7XVUicFsqn/EhbbSo8ShESIAW7pn
	whgPy7CtcQhYlbWlEmR609xtAQX7+D5xCrCvAQ25G
X-Gm-Gg: AfdE7cmHm53Aa3Sb2RyTEOC0cp+DpFFTWS8VMOfitmQQHaC5wUdRP5/oIGI5Jc+fXnA
	1y/96/8C8nhsKlyEVdOWeQN3aX+KHBKkplNBytShlD4ENf67RwhAyTUlowbss+Xywll/X+M768Q
	0jpbJ9sjMxxuvJjF7dmgOWXojEgeNTwcJl8vfvgd9Gh4RvljQGGRV+HA9Mz/lOhaevKJyA94UbY
	BUKw0CYn7nugvKKY42WSaCsFnEgJIc1bblg6n3O7+ubUIerzvifFCpMTF98qGqWeHC2v3MkIlFS
	vt7tKyEN8ZYBkpiL+foLX70oqkbv9VDEoRYWvi1w/unyqx5QYX+HtTehDuP2cADhlQtxWa9FSaV
	WkxFFiwDpYQ==
X-Received: by 2002:a05:622a:5a10:b0:51b:f340:d2be with SMTP id
 d75a77b69052e-51c7487e0cfmr46160941cf.53.1783410781438; Tue, 07 Jul 2026
 00:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707010151.43976-1-emil@etsalapatis.com>
In-Reply-To: <20260707010151.43976-1-emil@etsalapatis.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jul 2026 00:52:50 -0700
X-Gm-Features: AVVi8Cc2_RGmZHcnmBvpweCTGkIVDH5IqtiixKASATcFwOxN0G0PE2Ov00rUo4g
Message-ID: <CANn89iL23Rsu3iGXxhw4pAnCB-JgU7fnrryDLXKj4jHqSs=HOw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: Add explicit tracepoint for tcp_syn_ack_timeout()
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ncardwell@google.com, kuniyu@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7E98718B73

On Mon, Jul 6, 2026 at 6:01=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Clang can inline the tcp_syn_ack_timeout() function during compilation,
> making it impossible to use kprobes for tracing without preventing
> inlining. Add an explicit tracepoint to it instead.

So much copy/pasting for a very small issue :/

>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_timer.c       |  3 ++
>  2 files changed, 75 insertions(+)
>

tcp_syn_ack_timeout() is hardly a fast path, so you can instead:

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..ab2c3de19e46 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
        sock_put(sk);
 }

-void tcp_syn_ack_timeout(const struct request_sock *req)
+noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *r=
eq)
 {
        struct net *net =3D read_pnet(&inet_rsk(req)->ireq_net);

