Return-Path: <netdev+bounces-38737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A597BC4CC
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 07:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF81F1C2093C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF553AE;
	Sat,  7 Oct 2023 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiAMtXJ6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BA39D
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 05:29:38 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD32BD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:29:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso3182a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696656576; x=1697261376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehXIAL9COr2p+SJpJYVkLUs7bLNsHpyoys6ti/OmwOI=;
        b=OiAMtXJ6tynmtPbNf0oVtLtakB4w672tZqGGFGc20uXHn8lXontrHzK4qP1tuSYiUH
         tLyVfpdQWpzYGzwjZLup748DMmHPLUY0ksXcxOjj6dbos+c/jnmf5EkjJbwz3Gu3KWHH
         AVIyMbQpxnTa7TxQTI48+P0ceptkAh4J9DuF5UzwMMQYVEa5StYB1tzsJPk89rOkYKit
         zMgtXb8LXQpzPCbwS5oZc+e3lFxRdXQIypFnvypgIbmnBl2YN8AGc6Rrt3m13xzJswBu
         6fCc/bjDt1sg5eUX7Eg1qQodtZkXA/rdY85AK+AP++rpClTfNPyuKDek3KS1PlhruFt+
         +NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696656576; x=1697261376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehXIAL9COr2p+SJpJYVkLUs7bLNsHpyoys6ti/OmwOI=;
        b=g9yy+R1n+B9v5YfJfaliePcxx4074oZQY18ezr5pP6wJ3LAMS06se0Ai0LJgtL09PZ
         YHPTs/TF4WM1HkuaY3DvMqVHScmXi2WAbAWUxSAIHm3Jj56M3vydtKG9prBx2DSDb4ws
         I9Cj0EoBrWBHHM79dLPE/tQCAekYbIpkKKsJeEXFKx9GmFTNxo2TTJdQxrUTOvFoiRsY
         f3xQpl7I7Ebb/hAfwALVz3bbqVE+6ywTtKNmmnqsBgGm3TOMP1guxiyOLCyt+XJH9cbg
         rGwQHjl/UICKbYjxkZP9i56aSsjIXjyeMyX4AlUAyXE2CYYjUvArz4mkvcrNE3IZnZI3
         Ko3Q==
X-Gm-Message-State: AOJu0YxfY70okHNAbNbrOQPlq0vU+8lmQ3NTPObM23byIO+zpgmyPkiC
	Deuo4frvoxY+i4Oo5+e5MTMg3H4KikT7roDuY4Nn1Q==
X-Google-Smtp-Source: AGHT+IE/hTkf8AkZ8ITlkwNVi2PQWbMg9VbCiFwnsi2YbVc9094IqpEkM9HeLWBd/UWOs4drgL5TpFtxUxnWyQHg7ME=
X-Received: by 2002:a50:bb67:0:b0:519:7d2:e256 with SMTP id
 y94-20020a50bb67000000b0051907d2e256mr268054ede.0.1696656575664; Fri, 06 Oct
 2023 22:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
In-Reply-To: <20231007050621.1706331-1-yajun.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Oct 2023 07:29:24 +0200
Message-ID: <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
...

> +
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +       unsigned long *field;
> +
> +       if (unlikely(!p))
> +               p =3D netdev_core_stats_alloc(dev);
> +
> +       if (p) {
> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + off=
set);
> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);

This is broken...

As I explained earlier, dev_core_stats_xxxx(dev) can be called from
many different contexts:

1) process contexts, where preemption and migration are allowed.
2) interrupt contexts.

Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.

I _think_ I already gave you how to deal with this ?

Please try instead:

+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc=
() */
+       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_st=
ats);
+       unsigned long __percpu *field;
+
+       if (unlikely(!p)) {
+               p =3D netdev_core_stats_alloc(dev);
+               if (!p)
+                       return;
+       }
+       field =3D (__force unsigned long __percpu *)((__force void *)p + of=
fset);
+       this_cpu_inc(*field);
+}

