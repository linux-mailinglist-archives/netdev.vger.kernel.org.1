Return-Path: <netdev+bounces-44611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755487D8C54
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C634B21213
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D023FE4C;
	Thu, 26 Oct 2023 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzd62/Wd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AC18050
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:50:29 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33BF1B9
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:50:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a085efa7so1357e87.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698364224; x=1698969024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7NRdiqha9ywxzG052Y1KfU3qF8Y+2HgFsdm1GuxYs=;
        b=pzd62/WdVDiGKYbe7AOlZJPr6arMBIUAJrnAnPFVGht/cqgalwTjDmTHZLexFT7oXw
         jUOdQ6p2bi9umLfJr6i3sE9ktisV7j6+wBewLU/1mdbGDOwCvIyok4iOObUmczr+HLzV
         AWMB3RE2gcr9m/EkyU/SPdM9ilhX6czBhIsGAb/mxDQ7OrwGkJn2t1NHe5At2hQRitlU
         tsRpZtbW+YpJGJdeeClVYMlpE5zM8x17wYwFsqj3PH+q+uJvGNv7AARrlP/zR0qG72Wc
         yqPQRdrfJz88aIYLMnT3ejSwI4KkDS1Q1ZJgsOy5uMutBFJ4cL2Y73THXzFi3sqeUpM1
         Fuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364224; x=1698969024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl7NRdiqha9ywxzG052Y1KfU3qF8Y+2HgFsdm1GuxYs=;
        b=kIetTR5NeimHTK0IwfbUhTg9yDNLWH2RecDYE7vdvot5yBN04PdDc0K44e652JpdP0
         SozL39ZYD3Yj1a3s2PzfwD80eZHvxqYSbp9KBG5DeBwK8NmTEZPxO0i8SLmJ4jT9TtJn
         z0BS2s9gxfu/qUoNTtP/6UHFWJRBKlCkTcOXfY/1DuPjbBkTgSRcsebefQZ+CjGdd0gP
         Tu9lNwMEd7ti4qSyx7t9wF5xExauMzlwEcg5aLcE4yDrGolfhzk2h43gZe3j80dEwMjd
         ooNajhVOjPa+YxsVZx3dIpY/39RnCM0b7fcTyt2zL0mwRKtmrqdwWvgT7NhJZ8X/eiAi
         P4vg==
X-Gm-Message-State: AOJu0YwDoDixq+ZF06VzVIw6lWxAWRahXdEKIqNE570X8TK60d6f7H/t
	V5P9IJh974NI2TrIWLshMm2aYkcxaC+SR5G0GKRntA==
X-Google-Smtp-Source: AGHT+IHeLVrRJh24Ltzv5nbUUPwvwnPK835auZZjb9g2RDScbHWUFryofWVjQC6/7KmgzJawCDDzqkG9ws1xH0NaG/I=
X-Received: by 2002:a05:6512:3490:b0:504:7b50:ec9a with SMTP id
 v16-20020a056512349000b005047b50ec9amr20107lfr.1.1698364223546; Thu, 26 Oct
 2023 16:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026071701.62237118@kernel.org> <20231026233914.57439-1-kuniyu@amazon.com>
In-Reply-To: <20231026233914.57439-1-kuniyu@amazon.com>
From: Coco Li <lixiaoyan@google.com>
Date: Thu, 26 Oct 2023 16:50:12 -0700
Message-ID: <CADjXwjiUGOOYOL3jKCWpH49ZVSUPk6mWMvFe5W09GX+n7Zk-DA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, andrew@lunn.ch, corbet@lwn.net, daniel@iogearbox.net, 
	dsahern@kernel.org, edumazet@google.com, mubashirq@google.com, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pnemavat@google.com, weiwan@google.com, wwchao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 4:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 26 Oct 2023 07:17:01 -0700
> > On Thu, 26 Oct 2023 08:19:55 +0000 Coco Li wrote:
> > > Set up build time warnings to safegaurd against future header changes
> > > of organized structs.
> >
> > TBH I had some doubts about the value of these asserts, I thought
> > it was just me but I was talking to Vadim F and he brought up
> > the same question.
> >
> > IIUC these markings will protect us from people moving the members
> > out of the cache lines. Does that actually happen?
> >
> > It'd be less typing to assert the _size_ of each group, which protects
> > from both moving out, and adding stuff haphazardly, which I'd guess is
> > more common. Perhaps we should do that in addition?

SGTM, will add in next patch.

>
> Also, we could assert the size of the struct itself and further
> add ____cacheline_aligned_in_smp to __cacheline_group_begin() ?
>
> If someone adds/removes a member before __cacheline_group_begin(),
> two groups could share the same cacheline.
>
>

I think we shouldn't add
____cacheline_aligned_in_smp/____cacheline_aligned together with
cacheline_group_begin, because especially for read-only cache lines
that are side by side, enforcing them to be in separate cache lines
will result in more total cache lines when we don't care about the
same cache line being shared by multiple cpus.

An example would be tx_read_only group vs rx_read_only group vs
txrx_read_only groups, since there were suggestions that we mark these
cache groups separately.

For cache line separations that we care about (i.e. tcp_sock in tcp.h)
where read and write might potentially be mixed, the
____cacheline_aligned should probably still be only the in header file
only.

