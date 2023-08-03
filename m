Return-Path: <netdev+bounces-23910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787676E214
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D131C214B1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207613AC4;
	Thu,  3 Aug 2023 07:47:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0869440
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:47:57 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8974ED2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:47:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso157411cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691048875; x=1691653675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX2QjhAjm1VtIJ7aq9ETcIbROYuaT4rznxqM4xCkPNc=;
        b=fsKM8DoTuZOfwAzvF0ApPYf/k3QnUZq6zjoVqUZ66DKlTqfk9ykOVtIpCTWOAmTvGx
         GzUI4DgtRAELLR5d/EA5m9OQRDHAL9mu5XIB+hjPL5HYyjlxVqWFFM+GaVQ0PIt/ptW9
         9+u4+TX2wnOxcAybwVOGP4xLrCwNTMgiYJBYqqEpQf+1jVVqHFEgpc80mUBCbWk0aWsd
         6uyGbu3RiHdpJFAoQ0y5brfpm6PCsRZrKVk6xGnNpA/3CJ9llTZ7KqYOGsSHGEx+J8cu
         Q12sYbRU6HcARk3EZYUQy8vF0cp0IdnVyNbt0lq9XLQcYI+BV2BBo2DPme4IyShYZ115
         gQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048875; x=1691653675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX2QjhAjm1VtIJ7aq9ETcIbROYuaT4rznxqM4xCkPNc=;
        b=k4hHVR3csos+RTVI9FbvrSGQc8fCbLQny1JkQ/64cEssLdZByGQJdGq6SqbLMBw37Z
         jHubqL5XP/i8bUeKFaLoPge1+ESDaxI2SllY9VPkTFirjzk0THGf36XW82dGgSTIiUNv
         OEGIqyVAkrV0uC37r36Fd8mxWd2qV8A8PqjSRua8I98PCyOE/a15TgkmWIU5PI4oRUKM
         cdn35djCCv4bHnLm6K7s2p0LkKwd6TPB8b1b8dmBMi52mDVFI0x/CyzsL/LfzNHX72T7
         39OV3pXTbxDm/P9ghXR1HxPR9bAkwC5QmZEF6VuHnQV3+0J9e7oSCMQFw6gSqJG+JFS9
         QVWg==
X-Gm-Message-State: ABy/qLY63faSMmSEU8UWiYm+R7GqzO0ksqL2/QWhzGgUyA1WgPAT6Iyf
	WjxMfoYDZ4cSOLGszwElTbz7wuyjRNhY7F2Vjc8lLg==
X-Google-Smtp-Source: APBJJlEvSoUL4BFDEsByLxH9z9PduXUo16Ko724GHnU1ikgKnpUSJIYzWcxXfB79sgXW5CD3nvoFVi7DjptAMpL6xTE=
X-Received: by 2002:a05:622a:1aa2:b0:405:3a65:b3d6 with SMTP id
 s34-20020a05622a1aa200b004053a65b3d6mr1183790qtc.13.1691048874911; Thu, 03
 Aug 2023 00:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801100533.3350037-1-leitao@debian.org>
In-Reply-To: <20230801100533.3350037-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Aug 2023 09:47:43 +0200
Message-ID: <CANn89iKuHxUGphhDkKz2ZWS3YR3-BkieTb4b4gKMR9B7jxKpWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netconsole: Enable compile time configuration
To: Breno Leitao <leitao@debian.org>
Cc: rdunlap@infradead.org, benjamin.poirier@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	leit@meta.com, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 12:06=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Enable netconsole features to be set at compilation time. Create two
> Kconfig options that allow users to set extended logs and release
> prepending features at compilation time.
>
> Right now, the user needs to pass command line parameters to netconsole,
> such as "+"/"r" to enable extended logs and version prepending features.
>
> With these two options, the user could set the default values for the
> features at compile time, and don't need to pass it in the command line
> to get them enabled, simplifying the command line.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   v1 -> v2:
>         * Improvements in the Kconfig help section.
>   v2 -> v3:
>         * Honour the Kconfig settings when creating sysfs targets
>         * Add "by default" in a Kconfig help.
> ---
>  drivers/net/Kconfig      | 22 ++++++++++++++++++++++
>  drivers/net/netconsole.c | 10 ++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 368c6f5b327e..55fb9509bcae 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
>           at runtime through a userspace interface exported using configf=
s.
>           See <file:Documentation/networking/netconsole.rst> for details.
>
> +config NETCONSOLE_EXTENDED_LOG
> +       bool "Set kernel extended message by default"
> +       depends on NETCONSOLE
> +       default n
> +       help
> +         Set extended log support for netconsole message. If this option=
 is
> +         set, log messages are transmitted with extended metadata header=
 in a
> +         format similar to /dev/kmsg.  See
> +         <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_PREPEND_RELEASE
> +       bool "Prepend kernel release version in the message by default"
> +       depends on NETCONSOLE_EXTENDED_LOG
> +       default n
> +       help
> +         Set kernel release to be prepended to each netconsole message b=
y
> +         default. If this option is set, the kernel release is prepended=
 into
> +         the first field of every netconsole message, so, the netconsole
> +         server/peer can easily identify what kernel release is logging =
each
> +         message.  See <file:Documentation/networking/netconsole.rst> fo=
r
> +         details.
> +
>  config NETPOLL
>         def_bool NETCONSOLE
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 87f18aedd3bd..e3b6155f4529 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(=
char *target_config)
>         if (!nt)
>                 goto fail;
>
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> +               nt->extended =3D true;
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> +               nt->release =3D true;
> +
>         nt->np.name =3D "netconsole";
>         strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
>         nt->np.local_port =3D 6665;
> @@ -681,6 +686,11 @@ static struct config_item *make_netconsole_target(st=
ruct config_group *group,
>         nt->np.remote_port =3D 6666;
>         eth_broadcast_addr(nt->np.remote_mac);
>
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> +               nt->extended =3D true;
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> +               nt->release =3D true;
> +

Instead of duplicating these, what about adding a preliminary helper
in a separate patch ?

Something like this:

 drivers/net/netconsole.c |   45 ++++++++++++++++++++----------------------=
---
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd7b3da9d2481dc9898e94dd75917b..a022ceaa2e3c4783ca0ea61c1c7=
b9f911d087abc
100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -167,26 +167,32 @@ static void netconsole_target_put(struct
netconsole_target *nt)

 #endif /* CONFIG_NETCONSOLE_DYNAMIC */

+/*
+ * Allocate and initialize with defaults.
+ * Note that these targets get their config_item fields zeroed-out.
+ */
+static struct netconsole_target *alloc_and_init(void)
+{
+       struct netconsole_target *nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
+
+       if (nt) {
+               nt->np.name =3D "netconsole";
+               strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
+               nt->np.local_port =3D 6665;
+               nt->np.remote_port =3D 6666;
+               eth_broadcast_addr(nt->np.remote_mac);
+       }
+       return nt;
+}
+
 /* Allocate new target (from boot/module param) and setup netpoll for it *=
/
 static struct netconsole_target *alloc_param_target(char *target_config)
 {
+       struct netconsole_target *nt =3D alloc_and_init();
        int err =3D -ENOMEM;
-       struct netconsole_target *nt;

-       /*
-        * Allocate and initialize with defaults.
-        * Note that these targets get their config_item fields zeroed-out.
-        */
-       nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
        if (!nt)
                goto fail;
-
-       nt->np.name =3D "netconsole";
-       strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-       nt->np.local_port =3D 6665;
-       nt->np.remote_port =3D 6666;
-       eth_broadcast_addr(nt->np.remote_mac);
-
        if (*target_config =3D=3D '+') {
                nt->extended =3D true;
                target_config++;
@@ -664,23 +670,12 @@ static const struct config_item_type
netconsole_target_type =3D {
 static struct config_item *make_netconsole_target(struct config_group *gro=
up,
                                                  const char *name)
 {
+       struct netconsole_target *nt =3D alloc_and_init();
        unsigned long flags;
-       struct netconsole_target *nt;

-       /*
-        * Allocate and initialize with defaults.
-        * Target is disabled at creation (!enabled).
-        */
-       nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
        if (!nt)
                return ERR_PTR(-ENOMEM);

-       nt->np.name =3D "netconsole";
-       strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-       nt->np.local_port =3D 6665;
-       nt->np.remote_port =3D 6666;
-       eth_broadcast_addr(nt->np.remote_mac);
-
        /* Initialize the config_item member */
        config_item_init_type_name(&nt->item, name, &netconsole_target_type=
);

