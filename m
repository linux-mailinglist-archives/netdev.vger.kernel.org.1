Return-Path: <netdev+bounces-56533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AB80F3CE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A834C1C20A96
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82067B3AE;
	Tue, 12 Dec 2023 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaS58RMi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7BA172B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:57:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso13851a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702400263; x=1703005063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwudvX5vfK23B4UQIeq9h7dkxNvLHif10IbZjPRn0ng=;
        b=NaS58RMiCzCqKPiWTlLWs+qHJDFdSH0PzSw69ELDqb75xpBkCub8YxlU0L5T8HSaM8
         TZ0TSoyP/U2jHg1TEZANu+3ZrGSYUqZ1xffvf2vgyokEUUSLx/sWpIRMMlB/x/7bwAGY
         jNQ+5p1bKsUVwjNXoxnCpXhSMTSUkg4tJ/GX6KUkloPuUj0saCOmJOpTKb8mUMxwG+BR
         VlM5IY9UYU7f0a9kdnZmux9lVwEDWkpefsaZ54OO/J3WALXPJWuFajARTGAN0NlY56Js
         rAqlvnnl4ZY7Wfd18hmno5WMH0pGSukP+FAHak6lclEuHSFSy86sTOM5wF/g1YH5YStu
         rXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400263; x=1703005063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwudvX5vfK23B4UQIeq9h7dkxNvLHif10IbZjPRn0ng=;
        b=RjBPh0+rRHNDicBp++nYJXFPNOoFbqm+Lp0nO9oWIcUlPEINDrpy6G4dk7h+ozfaqJ
         Gxgl7AUL993OHIfY0MOBL58zLcv7ZKTIYHZg8DHii71WDj8uIU73onTjyMy/YjGO5t8c
         wGBAHY3wiQjZOadPvyBwBEA41fY/axFt+1ioD+pGbA6/W9OvCzTYm1/rpxbn7EaUqD9J
         M331ZnzRCXv5iGgXnaMKV3JOwmlGF+ENzHp/b9Qb/lIeF/hPnTcN/3DEUUX9w5jhghk0
         u+JBdwR19Pt8zTcNMbjZBe0CdEQC6i1QIVLcVDvMmy0vk14gRuW8DJRZiW0BgVBWv5tH
         TJww==
X-Gm-Message-State: AOJu0YwIlLjI3t4240LmJsk2IyI/IU0DCD89QVJB92DKQ47pXaVy5T8V
	19kCHPQffMVD/6hEwDpNFu6m6Pq2YM4aLbHHgryHXw==
X-Google-Smtp-Source: AGHT+IEUrGLbyIxVjcxYXRKZ8o9x73q2VNkOCq1Qk5CHYcL+/o7Avu/zTmXgwJg6kvcb47I6J7rpJJULjxaKBr7V62g=
X-Received: by 2002:a50:c192:0:b0:54c:f4fd:3427 with SMTP id
 m18-20020a50c192000000b0054cf4fd3427mr370617edf.7.1702400262453; Tue, 12 Dec
 2023 08:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org> <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
In-Reply-To: <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Dec 2023 17:57:28 +0100
Message-ID: <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, pabeni@redhat.com, 
	daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:28=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>

>
> So when we looked at this code there was some mystery. It wasnt clear
> how to_free could have more than one skb.

Some qdisc can free skbs at enqueue() time in  a batch for performance
reason (fq_codel_drop() is such an instance)

I agree that all skbs in this list have probably the same drop_reason ?

