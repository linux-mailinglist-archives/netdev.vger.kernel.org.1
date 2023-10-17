Return-Path: <netdev+bounces-41998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B67CC918
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC63281580
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C92D04C;
	Tue, 17 Oct 2023 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBUoxu/s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718302D02B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:51:00 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ABAA4
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:50:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso303a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697561456; x=1698166256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEKT6MX+UaNCGyuiFAYaPDm0nI3z2ixnQkxzEZ8Nrrw=;
        b=qBUoxu/s7SXI03IVaqt0vMpCeiriN3Ysil15SIhJNM5ynM+g8aystU7XIjfbm5y3l9
         cHzbusGNwM+rcuoobR6Uh4JlR/aeL0QgbOAnHSeFJf5ApK91a+bGUomReB9lZaz3wi6l
         xlwVWu1VFm+x+wyZa/Qgm4zgszdNbLUt52mYXivdigcdj5wFYMt8eC9WZ0a6S1tzJzmu
         zSz75ZkOocRLwAZ1G838hpYZ409UL5sE06z3EkXqTx5iS0MjtE4GsYOtzfhqUaNbZTto
         OWk8YOD6Bqev6PADwj+EDlK5lTEs1nTI8kTJ//YcOkr3ocsqCI5fWbqvJ/v9MFcys9kE
         DC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561456; x=1698166256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEKT6MX+UaNCGyuiFAYaPDm0nI3z2ixnQkxzEZ8Nrrw=;
        b=DuNrZ0wQGErxhNBuV7q3lUKGys/Ilg7HzlnaEuRegC0Zy1s1mQBdVd+MjQxNi4raYM
         m40D6NwSxj81MJmUL6Fv5cS/UKGi95npsQsGPnHIT+hDyiI4wec3GC6Cl0kfhOCh9WL2
         Iobxmwl00gqRDuQYbtey1sogBAuXHApCYiAbyeisPbkSJ4KGdCvv+zZNZYTStWsp2juM
         ek/cbGWyRrNtFAvpLKU27i6CQ4vMBPMSqzwm3ol2GqZ1YuRCJNOJ91t7HgINlv/BUGjn
         Sm4OEaEoCHe2JauEbIqdmWZHzK6UKXpIP9lq4ZS6fkOabP67iSvkO0/Wq1MjZWycoCZM
         dz5A==
X-Gm-Message-State: AOJu0YwSKeLzMr/iJHV5pDyAGGjLY07g+NxXOpcUP9ao+7h4vLjxGs4J
	88BOBRV/OkMctcS/oXmj5qNN3S4bH6QxcFnVHy6+dg==
X-Google-Smtp-Source: AGHT+IH7qGmUH3UDlSwPDk+Cd3XFJ4f5CDLoMnQj+t8j8of7HE6RjoCwcVGKGjhNAMJnjicyo0Jt4JurPoMX9RLo5tg=
X-Received: by 2002:a50:8d04:0:b0:53e:7ad7:6d47 with SMTP id
 s4-20020a508d04000000b0053e7ad76d47mr562eds.5.1697561456063; Tue, 17 Oct 2023
 09:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <0807165f-3805-4f45-b4f6-893cf8480508@gmail.com> <2d2f76b5-6af6-b6f0-5c05-cc24cb355fe8@iogearbox.net>
In-Reply-To: <2d2f76b5-6af6-b6f0-5c05-cc24cb355fe8@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Oct 2023 18:50:42 +0200
Message-ID: <CANn89iKmpFN74Zu7_Ot_entm8_ryRbi7sENZXo=KJuiD4HAyDQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Coco Li <lixiaoyan@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 11:06=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 10/17/23 5:46 AM, Florian Fainelli wrote:
> > On 10/16/2023 6:47 PM, Coco Li wrote:
> >> Currently, variable-heavy structs in the networking stack is organized
> >> chronologically, logically and sometimes by cache line access.
> >>
> >> This patch series attempts to reorganize the core networking stack
> >> variables to minimize cacheline consumption during the phase of data
> >> transfer. Specifically, we looked at the TCP/IP stack and the fast
> >> path definition in TCP.
> >>
> >> For documentation purposes, we also added new files for each core data
> >> structure we considered, although not all ended up being modified due
> >> to the amount of existing cache line they span in the fast path. In
> >> the documentation, we recorded all variables we identified on the
> >> fast path and the reasons. We also hope that in the future when
> >> variables are added/modified, the document can be referred to and
> >> updated accordingly to reflect the latest variable organization.
> >
> > This is great stuff, while Eric mentioned this work during Netconf'23 o=
ne concern that came up however is how can we make sure that a future chang=
e which adds/removes/shuffles members in those structures is not going to b=
e detrimental to the work you just did? Is there a way to "lock" the struct=
ure layout to avoid causing performance drops?
> >
> > I suppose we could use pahole before/after for these structures and ens=
ure that the layout on a cacheline basis remains preserved, but that means =
adding custom scripts to CI.
>
> It should be possible without extra CI. We could probably have zero-sized=
 markers
> as we have in sk_buff e.g. __cloned_offset[0], and use some macros to for=
ce grouping.
>
> ASSERT_CACHELINE_GROUP() could then throw a build error for example if th=
e member is
> not within __begin_cacheline_group and __end_cacheline_group :
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 9ea3ec906b57..c664e0594da4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2059,6 +2059,7 @@ struct net_device {
>           */
>
>          /* TX read-mostly hotpath */
> +       __begin_cacheline_group(tx_read_mostly);
>          unsigned long long      priv_flags;
>          const struct net_device_ops *netdev_ops;
>          const struct header_ops *header_ops;
> @@ -2085,6 +2086,7 @@ struct net_device {
>   #ifdef CONFIG_NET_XGRESS
>          struct bpf_mprog_entry __rcu *tcx_egress;
>   #endif
> +       __end_cacheline_group(tx_read_mostly);
>
>          /* TXRX read-mostly hotpath */
>          unsigned int            flags;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 97e7b9833db9..2a91bd4077ad 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11523,6 +11523,9 @@ static int __init net_dev_init(void)
>
>          BUG_ON(!dev_boot_phase);
>
> +       ASSERT_CACHELINE_GROUP(tx_read_mostly, priv_flags);
> +       ASSERT_CACHELINE_GROUP(tx_read_mostly, netdev_ops);

Great idea, we only need to generate these automatically from the file
describing the fields (currently in Documentation/ )

I think the initial intent was to find a way to generate the layout of
the structure itself, but this looked a bit tricky.

