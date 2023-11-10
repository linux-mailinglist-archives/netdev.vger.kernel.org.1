Return-Path: <netdev+bounces-47114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9D17E7D1A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DC3280FDD
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF21A5AB;
	Fri, 10 Nov 2023 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ReeLltEy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F11C283
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:43:13 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40339777
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:43:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e5dd91b0acso167933566b.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699627390; x=1700232190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gobI40BPKK+96YpOKnQSTXJZCsxZiafQGj1gJsPnJSs=;
        b=ReeLltEy2ujSVJCfGNqCzCoTg7HY7rFFmoleB4g4qIx4G8nq1H3h9ck93mMFq3QGin
         LZ8MR0SihhAHxZWeb6UBzmIBXz+/5XP78HT8kliAzN2Yet0nqv0wgcVmkMJaCUZgzJA1
         qRd6wY8nvUQq6xDrUyE+3jz222MLK4ZR6v2Eag9+7LwkQabQhXB+mPloWXkizq9kH4Mm
         rPEv60dmtj5PA+5+0PK+axtISXFoPkuJf4nVeDGujM/+Ehp9lDz2n6lnaTYkYn0TBgBa
         /LCl2q+edAqsiJ7MiAnP0coEmOCWFqPAer8flH3BXQ53ckgbV/yGnZGHkBoWyM4cQXHh
         VAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627390; x=1700232190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gobI40BPKK+96YpOKnQSTXJZCsxZiafQGj1gJsPnJSs=;
        b=jSSiG1pHD5EhbN3kHqlZsYZDtlGfImpR/LWk+ijhgngu9+8NNOC4MHw2Ci2b3ianJ+
         kEVUA7hXmU5QhDnaYsox5z9aRvt574nhf5Mo7qSEclvyV9X60PfsCL7Yn91NW94n4xMn
         jGZvUGrJnveDWr1P7wnJ76WCzkzNPPNkBkSzhsOYA37YtUZtygOs0d3CF7yvedT74eaQ
         oU2EWwEPJwFh4efQhCzXdCKDcct9mI/94WBrH26kMIEApC6YkP3p7VZacA6umw6mJcK1
         /uos/nr+8UJOJxlcW8cBfC/gijIX6ogT4TH5iLkPY/kbaPvP2O0ihB1wd9tNdOrF7GXO
         7iMQ==
X-Gm-Message-State: AOJu0YzIxKRu1z9YFQMm0j7mZCo+YydYD4ef37sVu1SFZibOs8ziiufJ
	LV+34uIa5otyWLMP1MyJMWnf0UEBbxf3Lf0Tw2FdfA==
X-Google-Smtp-Source: AGHT+IG5XrEFOjydF0/48AablD1bWhoB+SxENpryj3/dCn49GuCQ2BcmRtFttvt8r8S+EtFSK2by6UsymintHZPdiPs=
X-Received: by 2002:a17:907:a44:b0:9e0:eb06:2047 with SMTP id
 be4-20020a1709070a4400b009e0eb062047mr8033584ejc.34.1699627390623; Fri, 10
 Nov 2023 06:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian> <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
 <ZU4CLCk1APrD3Yzi@nanopsycho>
In-Reply-To: <ZU4CLCk1APrD3Yzi@nanopsycho>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 10 Nov 2023 08:42:59 -0600
Message-ID: <CAO3-PbpdayZGWMwEyDYi3b47OEACQRzdy38YdOJiDq0ee55iBg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weongyo Jeong <weongyo.linux@gmail.com>, 
	Ivan Babrou <ivan@cloudflare.com>, David Ahern <dsahern@kernel.org>, 
	Jesper Brouer <jesper@cloudflare.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:13=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 10, 2023 at 10:30:49AM CET, edumazet@google.com wrote:
> >On Fri, Nov 10, 2023 at 6:49=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wr=
ote:
>
> [..]
>
> >1) Note that net-next is currently closed.
>
> I wonder, can't some bot be easily set up to warn about
> this automatically?
>

It's funny that I actually got notified about an individual recipient
mailbox being full.. Side channel :)

