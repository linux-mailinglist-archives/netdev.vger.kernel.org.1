Return-Path: <netdev+bounces-29038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FE7816F5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB071C20BE5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670710FD;
	Sat, 19 Aug 2023 03:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717CA57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:10:33 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3824215
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:10:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34bf0b97811so38535ab.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692414631; x=1693019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKp6btYT5XRVMc9aXFSlcjOs7uLPloeW2Zfo5kSwwzk=;
        b=wISqlkVDp4O/Y7uHtMLqMR2wlQfr5NI58scqALE+SkUUr+XPQmGoeIg7pfghR6rfJp
         WPEYt94qCp9uDF/jr2P3/KY/DipaVFGGaFi4fRvtSnlUIhdnkpVSd9u0REx9F7ZG7c3R
         15MTQ4GcUYIaxilL7Nvu67lveVevfCgk6xwyb7/1Q3K7THzW+b7Q7YMWDPVz0pm0RE/8
         ipt1J+IDUz9AUFXEZm6f0OFJcxY/69Cp7YS44LPpbIceB5B0QIobcb8NWmHQ1bp3oxPo
         oqdK6j4fzLSnYZVvDBqPcW88PFUB2R8ubnCrZMtfcKc05CbpQlNs1EbLNTcXI8OQgY8t
         heuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414631; x=1693019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKp6btYT5XRVMc9aXFSlcjOs7uLPloeW2Zfo5kSwwzk=;
        b=l3x8oG8gfuLcW5nnsxLi3yaMpw8aKzEW3Y/ro5IK+KPgyZK3YymvcqBrjJtWjBHlk+
         zYhmYWeKtk6WBhpOrLt5nUu+jXP4BlwwGOdu0PqL8ssiKGuB6aSNQCqKZiGQAz/70P0K
         tG9kD5RxeWNrDzrZCqWcZ323KwsuUUuZcUZLlcE75rbGVZXPBmXTmfBgjoBwzkm11nz+
         kJFv4np01MUdHzcbLud4U2kq7IW7o5SdwMU92huPbYsB8CYN0eDOErGxnN0PXXFl8JPf
         6pJKcYoTyrVlxpWre0EEwpm68/1ywImvN0gBtqLWql6V7SVPy8tLkchoePSTbw5AQoNH
         rOKQ==
X-Gm-Message-State: AOJu0YyNnRIUctuTdnMQrIUHIRDQ/rVzOhWYnYRrskviqqlJHJMIePmH
	Gsh58MWtkTjYflf6zDmGJvVeryBlVyRUdwZoQr5MHw==
X-Google-Smtp-Source: AGHT+IG4bP0F3BUXPOYYG3U0HFeiRW/UGwonFjwbc0HKd8EKeEBeFk0A4YxsVJ22ps5ELA7pZQdp9KpNLknXlv3x1QI=
X-Received: by 2002:a05:6e02:12ee:b0:32f:7831:dea5 with SMTP id
 l14-20020a056e0212ee00b0032f7831dea5mr377963iln.8.1692414631283; Fri, 18 Aug
 2023 20:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me> <20230818185156.5bb662db@kernel.org>
In-Reply-To: <20230818185156.5bb662db@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 19 Aug 2023 05:10:20 +0200
Message-ID: <CANn89iLYsfD0tFryzCn2GbhrX4n+e0CPTXB6Vc=_m=U9Qi_CzA@mail.gmail.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zheao Li <me@manjusaka.me>, bpf@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 3:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Aug 2023 20:12:50 +0000 Zheao Li wrote:
> > In normal use case, the tcp_ca_event would be changed in high frequency=
.
> >
> > The developer can monitor the network quality more easier by tracing
> > TCP stack with this TP event.
> >
> > So I propose to add a `tcp:tcp_ca_event` trace event
> > like `tcp:tcp_cong_state_set` to help the people to
> > trace the TCP connection status
>
> Ah, I completely missed v3 somehow and we got no ack from Eric so maybe
> he missed it, too. Could you please resend not as part of this thread
> but as a new thread?

I was waiting for a v4, because Steven asked for additional spaces in the m=
acros
for readability ?

