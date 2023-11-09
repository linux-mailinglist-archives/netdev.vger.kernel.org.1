Return-Path: <netdev+bounces-46868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D06C7E6D3E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38419280F93
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 15:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FA2031B;
	Thu,  9 Nov 2023 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQvPBQPL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84B2030E
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:21:45 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF81530E5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 07:21:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so11678a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699543303; x=1700148103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqhljzTmyyfNCUJQiOX+wvfktS/JxULrH0/ohES2TiE=;
        b=KQvPBQPLxs4GazDKwsxcF7v/e5PuI5VVWzuFfBB+hvipjXxnx1UlhPrl1c6gWbeTjK
         pGxQB9+OPzk1CTwvvs47zdhv41vV0iz5/w429A5gIGMDOxggKxF/ODHjmHTiYnL8xDN+
         b2E0/0EFisoi0uZY7sNIiVWF8paphJ9KXbk/R3lpukoJrSa985MQLu2L524mfZP3YORC
         346JYxq4N9BXZRRcvFsneErm4iR+OLJTQnHX9JhFM+PNp84WUFaFoBmOukDUnvd/VtDK
         naHCkKQLkuExg192nlWuBXfEy80DfTTu9cnLbcQHUDkTaRl3mI0g0312TsID2kmcRJ52
         fU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543303; x=1700148103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqhljzTmyyfNCUJQiOX+wvfktS/JxULrH0/ohES2TiE=;
        b=Fr3QIFoWevnXZim4xIYFB5Zdy0dzJWNPj47z3QwYy7Ou0Hk7+IJx3L0Bx2v46OPldp
         PDlWxvoLVtAy9aobhIGxEvicbmrDREfUMDMdDZdraY/TG2kAe+7kicQxVj1OB6mtUFBM
         v/cyWOJ//pa/+0p7QHeOSeRzaVe1BqxR/OEDKeWXK1rERtKuTnBLMe+0hJ6nQ6s/LoKK
         6OF8I8LsEYKesE83XMW40pvUkZHty55Jw2Jqm62HwfgBnSWugg+V4aWhCjQCxsN61ayS
         kNNIVMQyWJMsMIsUCvk9ASH4UOaXiWfZOlUIvjGiXXFFIv5cQCmm7Qvamx8n4hnbziwB
         13EQ==
X-Gm-Message-State: AOJu0YzfLDGfRiav6Cm8ko7YOwFbjHISvsjFCen14kkeCo3wHj9bfk1l
	jo7pXwPXCi3mdalx+/cxPuyhmz4sgCYnLinRyOyWy6PSDd6UjfjDTLo=
X-Google-Smtp-Source: AGHT+IEc8AjuOXT+o20lLjbTJZpnISpx9kkTgfW68DVXDmZq1ijVnGjE1trXVrNycSQ5EFjpjArhSpE5TeKu4PIVewY=
X-Received: by 2002:a05:6402:497:b0:545:94d:7b with SMTP id
 k23-20020a056402049700b00545094d007bmr145442edv.4.1699543303146; Thu, 09 Nov
 2023 07:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109000901.949152-1-kuba@kernel.org>
In-Reply-To: <20231109000901.949152-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Nov 2023 16:21:32 +0100
Message-ID: <CANn89iJLG6pdkoCWQM1fifkK+OASD5DcNMq+uSv4N9cncFan3A@mail.gmail.com>
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> The top syzbot report for networking (#14 for the entire kernel)
> is the queue timeout splat. We kept it around for a long time,
> because in real life it provides pretty strong signal that
> something is wrong with the driver or the device.
>
> Removing it is also likely to break monitoring for those who
> track it as a kernel warning.
>
> Nevertheless, WARN()ings are best suited for catching kernel
> programming bugs. If a Tx queue gets starved due to a pause
> storm, priority configuration, or other weirdness - that's
> obviously a problem, but not a problem we can fix at
> the kernel level.
>
> Bite the bullet and convert the WARN() to a print.
>
> Before:
>
>   NETDEV WATCHDOG: eni1np1 (netdevsim): transmit queue 0 timed out 1975 m=
s
>   WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x39=
e/0x3b0
>   [... completely pointless stack trace of a timer follows ...]
>
> Now:
>
>   netdevsim netdevsim1 eni1np1: NETDEV WATCHDOG: CPU: 0: transmit queue 0=
 timed out 1769 ms
>
> Alternatively we could mark the drivers which syzbot has
> learned to abuse as "print-instead-of-WARN" selectively.
>
> Reported-by: syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

SGTM !
Reviewed-by: Eric Dumazet <edumazet@google.com>

