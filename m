Return-Path: <netdev+bounces-258919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHtnD7ZAk2kg2wEAu9opvQ
	(envelope-from <netdev+bounces-258919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:07:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492BF145EE7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BE30300118F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102C328B56;
	Mon, 16 Feb 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6ao6Gqx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B03D544
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258032; cv=pass; b=ig20T05nIiptoxNeke3y/S+askXP55C+tM6MnXOc3ERIaFe+U878eVt1KRSH143s08ZhnhLXq1L7SGU3xUp5oY2bzzKpuWkubEY5INwT2yKLvtkrWYpR+Ey5OWoKb7vEXqpRDcivTJtuLSjIGPJcSpxOu06KR3/Oj/8VKnyM0Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258032; c=relaxed/simple;
	bh=6b8vDgPzIwdUh9Ok/QRRxDI8ecJcUWlWTQdW1Ycdenk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJnKSFNj67Ry4sSrfxIw4WCjkh3DYUeQMyWEADwlpIpNgFWicA99J0KU50G/J/Fr8JAFbplRxi7UJRMlDWFhysa6dK6VGQaX/76+pM4YS4xqJF0Fn9oInPEgkjNbGh8EwHBCVDqekvQxxpc3TIPDupqCIgyZm+tU6aj/Fc0kQsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6ao6Gqx; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506362ac5f7so31826331cf.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:07:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771258030; cv=none;
        d=google.com; s=arc-20240605;
        b=lN6+RFfQRbSEGgygSPxQXzMeKK6ClLDKp2TodZY46KazZGyb1GI1ybg442Hu/Vbzgc
         eaUrjqV6aL9lBr+PuGhBamSq40OCSxRYQP3j7OTJ04lXo6LrzjnxEFM9RHJTTD5VKMG3
         aZAqsucPVIIV4tlROP9382PEixqkeIHcU0dyLhrHd5iykJwwrdOvHDrgV4qM52vIdxrc
         Xmu3/6EJHLY2L6nsRn9cJwscCJnHk8ZlmCbitWxz/+wTiOG5HbToWzgK2wbNb0gf6fho
         aoTf2VWa6rextD9umY/Fsu+tgqgL/vt/cscteGaytJIw8UUzK1yEqi3YobHpL1il2XUl
         cY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zlDyvi4DRDOCouJ5+b6j+eu1S8NYnmHy0tgJik9WcE=;
        fh=feeEZj1iPSSNCcqWOeLob9QFyjBxWHPE7fnYFfrnRt8=;
        b=lMERrxHZAb4qYhnf4FMZ9CYgsCSINbwb/3JVkn/3CrRMr7N0G+XDCTpPwYFvniwU+x
         +Uq4w9amTUplMCaKc5wvFYZAZakQcPP8rwRgeQQjXrOgHvRdCaZ/FR58M6ivN+d2B3YO
         PZtJVg5NmsDFe7KZH0qVi7Am3d0aT3T6J4V4iCDECfpUqWitxYmi5dXaOTpoRnHuqbR1
         tR+bkBekVZuKeRfVUGfQtI7l3s2DXO9ayKJ7gQiyKIejd3GjdZ2tUDYJzWoOEvSwmEcj
         dAxAIreyHlQqeTeUhzb/fGjD7NvYm+ne7mLulLa+CGDHOH8xZ8ov9xFpvx0Uurc9VkY2
         b5Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771258030; x=1771862830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zlDyvi4DRDOCouJ5+b6j+eu1S8NYnmHy0tgJik9WcE=;
        b=C6ao6Gqxztd8QQXSkR6lMx5a9uwUdpej0Y41QCSPs2Mpv8oVq5WVoLchiLfsy9GMkk
         XnRxKFlmuIO5NVdI9eC7v4zwa8McMzyk/TbE2VTGhydYqGDchC1U5ggwOUoMC+znTKhj
         09wbZqrQzY7w5ebDGNRZBSC05jRuniZEiip6l+dcv3qVrE5Cl13j9QUJWnJyQu3TOQ2p
         En0zDmgQJbBDB8LrNb65PS0bKgROJX2dbjrmAIiT7AY3IMVYAym1/lyFRBbQdAvn/hNp
         wKKx8lB6XcdFcfU8JxzEM2vA9Ch2ai/ZABwXfTlf/bDOyJQMko9CrmRju2zrHOJejnwv
         CR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258030; x=1771862830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zlDyvi4DRDOCouJ5+b6j+eu1S8NYnmHy0tgJik9WcE=;
        b=Hpomedsjwj3+5pqGMEuziuWjWJ0j/1GEP1fqtT36+8g0SlJ3mnqmPObVWFc15HmoZR
         3XduuI+xFzMqb40oPSEFdbPE5E8KrlHSQN9NBwPZgNrJgseQ1wJhF6m7r9OA9rExNHnO
         qLSg15lSXv/vmpmk7dVEmfebOw8xb9wSIBxyWtQibZfUA3og8+n/vcjFXkVWNL01zRzv
         jseHwQaTvxiJpO4l+tkb3fYUzY1OGDrq3wy4fwxE8fnukIfs7YVHZiCdcja2bZkvkH1b
         il/AH927Rasc6THSO+AAnRXvWJ5O+CbUrPliZBJ8WH2aztJMLXqsGvTP1SsdHGX+5GsT
         AdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMAUjdFNpXeTxeY8G8mJae8mt1QkjAHDYmmuL+V3UNNtrwluhEvC/mOub5qghth48JknyD9+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/j8ZrvXrU9yFuQ8NUFQ4tGSIBus9sFOY9j2zLBamofszRSKY
	60+osh7K7TD507SDaogyo+aen/m2eIAFa6GquViFo9Z0N+2bVFg//EIqfZ7N9a2XNfjpObKaKxH
	mBsDT4OtUecMglHaE/nBO3GqnGjUhiDYGkOAIri5Y
X-Gm-Gg: AZuq6aLYg6N+R9kPRiu/DnWEhmmBz8MHbL6LdLoL2BL6VK6PO9LqK7MUYGH+vb9ROeX
	WZinKcJx1UAu/oO4ssDnoYeTwt0tWc8ZYVvLr4eZvB84sPkPGc4Jccwt7dRyNw7+g4tikRSVqei
	rjcNAYkEb4h62XMrs2H8Im69qpruEF4hijzkebUoz20kRbBcnkWGpJRjiBRFZJiyk0yj6CLuZvN
	fGMta/IDbajuBqLe0I1EFiUTyEOWDtpGwFN9sCL0FJxwCn+gst5h8zNj9+U/2vXs8xZTxZUXFVB
	Iapebg==
X-Received: by 2002:ac8:57d4:0:b0:501:17a1:4ccf with SMTP id
 d75a77b69052e-506b3f7e2b2mr114398501cf.3.1771258029713; Mon, 16 Feb 2026
 08:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org> <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
 <20260117150346.72265ac3@kernel.org> <CANn89iJ8+5OaWS2VzJqo4QVN6VY9zJvrJfP0TGRGv85mj09kjA@mail.gmail.com>
 <20260119090435.44b1da2d@kernel.org> <20260129150459.29419003@kernel.org>
In-Reply-To: <20260129150459.29419003@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 17:06:58 +0100
X-Gm-Features: AaiRm52zncSMWX3vevjblnq0W9e0cJALeB3fNX7GrYeCk6GXW9p-oUMomb8MVNI
Message-ID: <CANn89i+P86WVVUY-4WppUAH1TGix1Z3KhgX9vSHok5nXqQAiHQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258919-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 492BF145EE7
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 19 Jan 2026 09:04:35 -0800 Jakub Kicinski wrote:
> > > > Not sure if there's much we can do about that.. Perhaps we should h=
ave
> > > > a shrinker that flushes the defer queues? I chatted with Shakeel br=
iefly
> > > > and it sounded fairly straightforward.
> > >
> > > I was mostly concerned about latency spikes, I did some tests here an=
d
> > > this seems fine.
> >
> > Looks like selftests run into the zerocopy Tx latency issue.
> > I'll drop this version from patchwork..
>
> Delaying zero copy forever is a bit of an annoyance.
> I believe the same thing can happen in net-next with UDP
> but I haven't tested to confirm.
>
> I assume the attached patch is out of question since it came up before?

I think I totally missed your email :/

What about not attempting defer for zero copy skbs ?

It turns out existing patch e20dfbad8aab ("net: fix napi_consume_skb()
with alien skbs")
is already a problem for zcopy.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 699c401a5eae9c497a42b6bdd8593af7890529f4..dc47d3efc72ed86dce5e382d505=
eda7bc863669a
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7266,10 +7266,15 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 {
        struct skb_defer_node *sdn;
        unsigned long defer_count;
-       int cpu =3D skb->alloc_cpu;
        unsigned int defer_max;
        bool kick;
+       int cpu;

+       /* zero copy notifications should not be delayed. */
+       if (skb_zcopy(skb))
+               goto nodefer;
+
+       cpu =3D skb->alloc_cpu;
        if (cpu =3D=3D raw_smp_processor_id() ||
            WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
            !cpu_online(cpu)) {

