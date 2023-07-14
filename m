Return-Path: <netdev+bounces-17895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E731D75372E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E65282146
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25210947;
	Fri, 14 Jul 2023 09:56:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBDF514
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:56:16 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E71989;
	Fri, 14 Jul 2023 02:56:15 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso1607291276.2;
        Fri, 14 Jul 2023 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328574; x=1691920574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLc4IFOrSQMumdSS27cGww/H0solCQj99/m3cUx+za0=;
        b=U0+zCc7J47tgv3aokD+C9AbGUM0547IcCiSQEMzpBI+mYOOCtmzjv7TLV+15+Way2l
         uIapCaUXBbx/phM9GIB5BFOIQNEHzbA7jNpWh7+Q0iZmZlO65IBlPd0HnXlJWqMc85kk
         H5Q4LKdYKUNGqjL37XpunuGMoJ+Mtpl/BpDiZ03rfuXmWzrYel5MjIzmIiBpL+k04NA0
         kIairDRA5S1vy0oVMkSwlo7M5XJ/2BC54TEVtGPKe6UNZB69tMRoq1VkITMgaXFHnnev
         jeNCPG4T6jWGDnPKvbonN9yBfdH9GzBYSvFo4RyjgabhCFa4S3I4hdoNRXo1mIFSILk5
         15TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328574; x=1691920574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLc4IFOrSQMumdSS27cGww/H0solCQj99/m3cUx+za0=;
        b=CuG1wJK4rCKUeQrs4VmvNSzlLQlFVi2ZuQygDuSfZpeJW8pGKCbMpHRdVSJP8Db4oL
         56zM0z16dwhz9sA1lJL0osvIUQk6jzrJUgc3UzwKdFl9ta27kfGtWBTJB3UDp9CZBDDK
         +Reah7AcM+F7LfkoqsTWJ2RZgKO8WBkc/NzoA16W0iH++2SJwbCu36WCFdNiRdMABnXm
         XYSyXxUeRUldK3kvu4nqYFOdGt/lBiQBmwNUWiqtjvDjDqAyUlAedRRdkp6dXb3Dr58v
         LZXtKZcMgVglCczkvX7ce3tqGJtOYEMEufR6vZTlFVPz4aHztjjVkfUf1n+lF/gTYYEv
         03og==
X-Gm-Message-State: ABy/qLZi4k6YPzzIMNE21fHX7+iga9kPqaweKN0mrem0do0+WlJpi+6S
	BCPmf+ipdMuAcRyx7PmFtghOB9t/7S/wl4aChuI=
X-Google-Smtp-Source: APBJJlEP9rHYkKqqEeB1DAv7b3BU8yZcSQXF4+FqdKNDY/5pBH0h3wFr0gaoNioOqIHxzaGSE7p70VM3SMLPFrINvDs=
X-Received: by 2002:a25:32d8:0:b0:ba7:7664:916b with SMTP id
 y207-20020a2532d8000000b00ba77664916bmr3607425yby.20.1689328574374; Fri, 14
 Jul 2023 02:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713112404.2022373-1-imagedong@tencent.com> <04a96ba2-6952-e6de-93a2-dc2998ce519d@infradead.org>
In-Reply-To: <04a96ba2-6952-e6de-93a2-dc2998ce519d@infradead.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 14 Jul 2023 17:56:03 +0800
Message-ID: <CADxym3Y2f6-FfyG3RfvPDXLS3b3FqUfxaDPgju6OoQPy-0i9bQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
To: Randy Dunlap <rdunlap@infradead.org>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org, 
	kuniyu@amazon.com, morleyd@google.com, imagedong@tencent.com, 
	mfreemon@cloudflare.com, mubashirq@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:43=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 7/13/23 04:24, menglong8.dong@gmail.com wrote:
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 4a010a7cde7f..3de2dce74037 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -694,6 +694,20 @@ tcp_retries2 - INTEGER
> >       RFC 1122 recommends at least 100 seconds for the timeout,
> >       which corresponds to a value of at least 8.
> >
> > +tcp_oom_retries - INTEGER
> > +     RTO retransmissions count of the receiver is recognised as OOM.
> > +     Given a value N, a hypothetical TCP connection will enter probe
> > +     state if N times RTO retransmissions performed and every
> > +     retransmission gets a pure ack, who doesn't contain SACK block.
>
>                                    ACK
> > +
> > +     The default value is 0, which means disable the OOM detection.
> > +     If disabled, skb will be dropped directly, without sending an
> > +     ACK, when rmem schedule fails. The function is valid only if sack
>
>                                                                      SACK
>
> > +     is enabled.
> > +
> > +     3 is the suggested value to enable this function. Do't make it
>
>                                                           Don't
>
> > +     greater than tcp_retries2.
>

Thanks! I'll fix them in the next version.

> --
> ~Randy

