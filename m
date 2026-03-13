Return-Path: <netdev+bounces-267519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNf+A+UstGkEigAAu9opvQ
	(envelope-from <netdev+bounces-267519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:27:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259E285F13
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F773013A55
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC9392C50;
	Fri, 13 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqLfArxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8E3AD503
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415407; cv=pass; b=eRA11E32TdUkAOm8cDLr3acwEK0U4V+QWCyWAT0arPfjBMffrPUxtZWqg0yCtf7iAxZ8W2j3pdvueiroqY4/+m7OZAewk9IByB6xG+rrEOOpnuUdoz8ZsAm319tF4skuvKZnmhJYYP1fslUgloJhnvd06sgQBTcrnGiHi1OgZuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415407; c=relaxed/simple;
	bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0Wep8NmdSt/h0EUSlqZwhhBMl/VrTA1ytjBOF6zN4LL3UmlbC8ka4Xw7CxJHU0S2ukdtm4S+QDVaif0FZWwHi3/bgXNNvmS18TNjJUv7Ygp8DFgDQ0HE4ilb/2xpQnOx3vLpUWucqlSYTUq2SRmedet0LcBw+LYgAIMuyYmbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqLfArxx; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79885f4a8ffso21027837b3.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415404; cv=none;
        d=google.com; s=arc-20240605;
        b=YkIrYVqFvmfs9sVd1cNxPCYLnoWs+2IAFomjj/6QZWJ78iu3y7WrF6DXjEAHJjh9/3
         Nw+M0+L0pEmARDWaTLWuUwtR4uSMkcCjJTwxbr/hBY17xkuHB36bhafZMGPB6apW8Adm
         q0KoMgkoMX1XFmYv+xq5LQp/JfN/UCV+7kwnqouenkNzb63iC5McQhwylQRjM3ftXu17
         Ec0tsYzCoW+arlws7AZ+XbhsS8lR1G+RM668HPYfuTB+708BmQuGHxAOvnuABYbK8Vp2
         MJ2R3Uxe2ZKbvPGZbypK5cXrCdhdqGkmyWaq7S0lDGsR2+jTygBnuQN2JHEiCUnIRxb5
         OSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        fh=hi2rcLox9y5rxAOfqc/IyYsCp01kmKZcC5oXjGNggvA=;
        b=YFQ3cal6MkktBdYKy++oxf/HqfJ2m9TVmqxPBbhsH6kF6ZEbBZiriBfx3gHn8oeOOZ
         45inNE7ksOkhEa+TEclxSEKB3s6Br2o4jrQnJQBX0M45kVB2gGj0lt3QgAUxk1Hk2XOb
         ozszmsii3g9N3TABi3sKlLMdyUU1/OQOOGuqnTikCvpJLH4Q0tgwTxqehXrIUGpjv5Xd
         WUWUycBpieuQBPoMK/RE9Plup8CBx5gD9+7Mcg24CXIJ6VObwjAeLkEaGg+Yws+XIOvq
         eXPT5BXRzhInDN/V4ZdLv36M1AEjWwrsEoo7d/1OI6kln2ZIRd9gTIp5HzXpBn6H/QTx
         EDtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773415404; x=1774020204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=MqLfArxx9WavGOVcNbQ/YuikDXr8zrfI9pMe0VvodHyONDK2YYVYs7IpP9apEBlypP
         Ez6x5SRvTBvRGER2SNjESUQ2YXaxRkjQa69ErILkq9lg4oHuwOyIL+mUnetUkw9uOzYD
         MiNQGv/iuGVu5xzhi9l0MzUJFHUjEXVss35CJIubve1CgfqOR7/bJatkpPifQV8jtq39
         z5LPpzeg3WjOQQOtcpHzolhS44W/kpZ/pYSIe9J5CSvPfJpcfM1Z4hKi9rJHYuuATXZs
         br8HVDqKkQ8FPlUFhN9asfKCUmWAvofbONWOra37GZQizZfJj70IkNZk13GKLj/AGvGp
         dRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415404; x=1774020204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=I7hkqyliopv9tuIqZASGCj2RHcnNStbGcw4PpC/Vy2bUxy7UDkO9K5pgqpwYQ4bQqI
         lgIKEr0D1SrEWfoZapBGm5X/FFM1tptXKo8W4+KNDesEellzX11dzMK7+EvhEjvjbVux
         +qOXzADc5h86LRwja3fXoUFKosSMp8D0NaGgNqY45v6IljectPhtWgMhRzVTSNLNbx+c
         GZVkitADoEk+ZXgZQLHbJd/lcGRZ6GvhQzXoXNqrgpFLZaI82I2i8Ad7w+ludjODoZ97
         GnhaqCOmV3IsOPokHYG0OVLId3jqc496awku5Ca1qpuMfIwvZqEFIE/jOXXh+8AGBd94
         JHuA==
X-Gm-Message-State: AOJu0YyF47xWh1IGQu4SYfRtPPZ+jpYQD3PcCf1u1py0nDchd9Uqyyiv
	3gftJDUcEG22YUTNBJ/oljf4tHtqGOZkoRNrC9sLkN8rfL64YVONqBoGlJAP456hSyORKLNrFtT
	p5fOnl3hDu6holS/d4LLZjHiVQU/8ja+ICY6QXVdv
X-Gm-Gg: ATEYQzwtCViul1wqjqVJSS1RFhZPM8+mMXvnzg/fqkz+E0n6BJXHQjXlaB72MvPK0wB
	VMbDuH3dOKPucGcuq3xkZUkm+ARfaOUwzHE1kvHvKnl7XHcOkN4FmREBvxOOQfyyC+rRnT82FsU
	+cjttcmaXwfMWVYyu1Uql9pVc+5QDx+a8kcdeX/ulBtt0NOiRon0OE28f47gGWR8RwI2hZmlils
	6KHMclFlvIRiljWpXllQuIXRSNPnBDqe+U2dLbqP2a2l+yLHOG0zs9x13aVL8jbkUryC84Ue2Gr
	t+SyCp1f
X-Received: by 2002:a05:690c:d8d:b0:798:240:dc with SMTP id
 00721157ae682-79a1c1ff74fmr39519447b3.44.1773415403629; Fri, 13 Mar 2026
 08:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Mar 2026 16:23:08 +0100
X-Gm-Features: AaiRm52KxJMaf1ydBJZ_jjLOyjV7GYRKOtKNeJuwOG2OEoR0W86DQ9uF5UWnY0Q
Message-ID: <CANn89iJSyAb+hrNEoGrum_W0Tfd_QY82dW4Y+YrvVqkPzdK=qA@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: bsdhenrymartin@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-267519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6259E285F13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 4:16=E2=80=AFPM <bsdhenrymartin@gmail.com> wrote:
>
> From: Henry Martin <bsdhenrymartin@gmail.com>
>
> smc_tcp_syn_recv_sock() gets the SMC listener through
> smc_clcsock_user_data(sk), but then dereferences it unconditionally.
>
> During concurrent teardown, sk_user_data can already be cleared while the
> hooked syn_recv_sock path is still reached, leaving smc as NULL. This
> causes a NULL pointer dereference at atomic_read(&smc->queued_smc_hs).

https://lkml.org/lkml/2026/3/11/173

