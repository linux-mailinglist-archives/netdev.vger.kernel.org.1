Return-Path: <netdev+bounces-32272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C13793C5A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864992813AE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD89101F7;
	Wed,  6 Sep 2023 12:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15DFED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 12:10:29 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175DE6B
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:10:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso220291cf.1
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694002227; x=1694607027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzpHQf+mGoHPzHCO81lnNai9VS234FR5seRfGQ95fZ8=;
        b=FMC7moAqzB5jWy1jJre6TjYp9SJCjLzWVRz50RVOo1Cn33/EIjppPGGRiiLzsyAuL1
         2i/KhoRnuVUF+dLNBVCdKR4w0+MrG2o+LSYDBNSekEVx0GMD5Z3o4aRXdoEIIlh5jEph
         0jn9ir40Mh2ykMu/wzfYveJjD1JFql5ns3GnOg15o8PA7q3LQBjTXtgCVtZqCtgGrK4p
         6OzsybCI2Q7fyszy4lAvkA1itLAzQPRxx8WvEit68rRaZxzRoDObH0Ix4av0yhf9UZxq
         wqFLiPIqswNKsPoag7bSw6UIT8gakUQyXetH9Dp3PAsFHUrX9fSYJaKBAalVBwtLo48e
         5QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002227; x=1694607027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzpHQf+mGoHPzHCO81lnNai9VS234FR5seRfGQ95fZ8=;
        b=ZAlILgiUmSihxJ8o9+YcqGR9BXw024bFE/kSnQDmyA2kNmbZqpxBeTRdVIYuhC55tD
         waazzaENeuNH1fDwH4Gs/qYAiPkZ5afAuGUBmTdyy7rrTq0UMFMn3fFIaVE/6tryZFww
         4NVw1vb5yLnxZRCl28j48R5FLGbnnZFJ+ATWWwGNOpzCA+qLqaIRzxzbQ9m9ujAY34JB
         VxJVPc3WMbf5cJikyaJYZeoyFn1iG6swx7XI6KA5oHt4BJbzlxPO2hCNPpMWrXHoiTss
         gldcphBI23qDZppncbWfjNVVYDJs0JHXVUo9HKXnIZnBjVAM5qyyj6uj/ipevxsqbVrO
         TnJA==
X-Gm-Message-State: AOJu0YyEnWeR8NPyWAdF3X+z2RpEUBlyMJR9/pit+R6xXwsqydYUOtKm
	C/cfMc2Ths8qUeuIfbo10Kz9yvCHs7trwVNuPGx95/9dPmPst3JT3idP9g==
X-Google-Smtp-Source: AGHT+IHRXgWgSo6cz6W5xPaolS5qAt/vQ98dA72JmwsOvEv8pqdqQUJaFUHCM0dnrf+DxgYN/IrKy+fyWRf3Xso/FQQ=
X-Received: by 2002:a05:622a:110:b0:3fa:3c8f:3435 with SMTP id
 u16-20020a05622a011000b003fa3c8f3435mr156232qtw.27.1694002226865; Wed, 06 Sep
 2023 05:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
In-Reply-To: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Sep 2023 14:10:15 +0200
Message-ID: <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
Subject: Re: Question on tw_timer TIMER_PINNED
To: Juri Lelli <juri.lelli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev <netdev@vger.kernel.org>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 1:58=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> w=
rote:
>
> Hi Eric,
>
> I'm bothering you with a question about timewait_sock tw_timer, as I
> believe you are one of the last persons touching it sometime ago. Please
> feel free to redirect if I failed to git blame it correctly.
>
> At my end, latency spikes (entering the kernel) have been reported when
> running latency sensitive applications in the field (essentially a
> polling userspace application that doesn't want any interruption at
> all). I think I've been able to track down one of such interruptions to
> the servicing of tw_timer_handler. This system isolates application CPUs
> dynamically, so what I think it happens is that at some point tw_timer
> is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
> 60s timeout) such CPU is 'isolated' and the latency sensitive app
> started on it. After 60s the timer fires and interrupts the app
> generating a spike.
>
> I'm not very familiar with this part of the kernel and from staring
> at code for a while I had mixed feeling about the need to keep tw_timer
> as TIMER_PINNED. Could you please shed some light on it? Is it a strict
> functional requirement or maybe a nice to have performance (locality I'd
> guess) improvement? Could we in principle make it !PINNED (so that it
> can be moved/queued away and prevent interruptions)?
>

It is a functional requirement in current implementation.

cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
changelog has some details about it.

Can this be changed to non pinned ? Probably, but with some care.

You could simply disable tw completely, it is a best effort mechanism.


> Thanks a lot in advance!
> Juri
>

