Return-Path: <netdev+bounces-39532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9217BF9D0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC1D1C20B3A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747118C25;
	Tue, 10 Oct 2023 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yw5iwLcf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1712182AC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:34:29 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10129E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:34:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so920703266b.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696937662; x=1697542462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdj1Jv8ipycxFfm0d2o148DIp4n9qBijNMZpCrz6nxA=;
        b=Yw5iwLcfVTtRZcGrrLabFAWtRdxwyAG5ee1jVupJoZLIhimv3HvU7LK21NQ55lJnJm
         WAan5dGeQ6dRFIQXljLitrdNUVa7SjlYbCzmXq1IMciae2SVqCUv55UGvsWVWohC+Txh
         xDv5iOK9P8YGO+KazPvzz46fEp3txPeUs/CyrmkPIl/MZrYIA5XecH+0cmRKkaSTYFBu
         hA09nMoD7aiadm+KhSFFvtFFmFrNXvOsp2DLDnaJWQZiw2pnOsVi6p8SN/7rSQP6s5Ru
         V0W10v87I34I5QTOrZyvVAI2XK0pjihKX9F4Hj7ihinBj7GDCRDdPBxSHS9VDdH2kVLX
         +S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937662; x=1697542462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdj1Jv8ipycxFfm0d2o148DIp4n9qBijNMZpCrz6nxA=;
        b=pczBhW2F/P4qWlelYhKJM4Hehz2yUJMrOWXJRZDicqhXw/R0/4QpW1wzGyCt1XsjaM
         /7YXym5wAFh3v5vub9Itt7wYmm1b8jgm1rHLr9/S2dGr4PlTj4pht1ab3fQ60BDGtEpN
         fh62SG02b2w2JyusK3bqM0CSImIQMR2XRmxmIuIVTotAhgwTzscqffP3+4aF5ENlwbX+
         LTfcB6WgXwwz+IEpBVeOfVLV5tU36cvJ2rNQzWTLMYVVZ50aUxqc3JSvLDehXVNCGlWo
         9c0bMNmNeNlouXTBvxFYlz53IC3MaL/dC3ZfmGo7RcwBD5ZcwYIKGcL08w4aA/WR8ZTu
         72/g==
X-Gm-Message-State: AOJu0YwwZ7QqhSSU0fOInYwU4AiDZICwOJqlaHxKnjCTvwY66e5vMYiN
	FB3cQQKfbOEH/Q56NZKbkqrbTA==
X-Google-Smtp-Source: AGHT+IE7ay/G2ljEgBL6ZpLymD7bUgB//POQLxKOHHISzT4e2Zu6o7hA5lFMRYuC0yBS9Td5JAOjog==
X-Received: by 2002:a17:906:3282:b0:9a5:846d:d81f with SMTP id 2-20020a170906328200b009a5846dd81fmr14793159ejw.17.1696937662606;
        Tue, 10 Oct 2023 04:34:22 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009a198078c53sm8275797ejk.214.2023.10.10.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:34:22 -0700 (PDT)
Date: Tue, 10 Oct 2023 13:34:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>, Luo bin <luobin9@huawei.com>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v1 1/8] devlink: retain error in struct
 devlink_fmsg
Message-ID: <ZSU2vH/As7RIcH7W@nanopsycho>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
 <20231010104318.3571791-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010104318.3571791-2-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 12:43:11PM CEST, przemyslaw.kitszel@intel.com wrote:
>Retain error value in struct devlink_fmsg, to relieve drivers from
>checking it after each call.
>Note that fmsg is an in-memory builder/buffer of formatted message,
>so it's not the case that half baked message was sent somewhere.
>
>We could find following scheme in multiple drivers:
>  err = devlink_fmsg_obj_nest_start(fmsg);
>  if (err)
>  	return err;
>  err = devlink_fmsg_string_pair_put(fmsg, "src", src);
>  if (err)
>  	return err;
>  err = devlink_fmsg_something(fmsg, foo, bar);
>  if (err)
>	return err;
>  // and so on...
>  err = devlink_fmsg_obj_nest_end(fmsg);
>
>With retaining error API that translates to:
>  devlink_fmsg_obj_nest_start(fmsg);
>  devlink_fmsg_string_pair_put(fmsg, "src", src);
>  devlink_fmsg_something(fmsg, foo, bar);
>  // and so on...
>  err = devlink_fmsg_obj_nest_end(fmsg);

I like this approach. But it looks a bit odd that you store error and
return it as well, leaving the caller to decide what to do in his code.
It is not desirable to leave the caller wondering.

Also, it is customary to check the return value if the function returns
it. This approach confuses the customs.

Also, eventually, the fmsg is getting send. That is the point where the
error could be checked and handled properly, for example by filling nice
extack message.

What I'm saying is, please convert them all to return void, store the
error and check that before fmsg send. That makes the approach unified
for all callers, code nicer. Even the custom in-driver put functions
would return void. The callbacks (e. g. dump) would also return void.

+ a small nit below:


>
>What means we check error just at the end
>(one could return it directly of course).
>
>Possible error scenarios are developer error (API misuse) and memory
>exhaustion, both cases are good candidates to choose readability
>over fastest possible exit.
>
>This commit itself is an illustration of benefits for the dev-user,
>more of it will be in separate commits of the series.
>
>Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>add/remove: 2/4 grow/shrink: 11/9 up/down: 325/-646 (-321)
>---
> net/devlink/health.c | 255 ++++++++++++++++---------------------------
> 1 file changed, 92 insertions(+), 163 deletions(-)
>
>diff --git a/net/devlink/health.c b/net/devlink/health.c
>index 638cad8d5c65..2d26479e9dbe 100644
>--- a/net/devlink/health.c
>+++ b/net/devlink/health.c
>@@ -19,6 +19,7 @@ struct devlink_fmsg_item {
> 
> struct devlink_fmsg {
> 	struct list_head item_list;
>+	int err; /* first error encountered on some devlink_fmsg_XXX() call */
> 	bool putting_binary; /* This flag forces enclosing of binary data
> 			      * in an array brackets. It forces using
> 			      * of designated API:
>@@ -565,10 +566,8 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
> 		return 0;
> 
> 	reporter->dump_fmsg = devlink_fmsg_alloc();
>-	if (!reporter->dump_fmsg) {
>-		err = -ENOMEM;
>-		return err;
>-	}
>+	if (!reporter->dump_fmsg)
>+		return -ENOMEM;
> 
> 	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
> 	if (err)
>@@ -673,43 +672,59 @@ int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
> 	return devlink_health_reporter_recover(reporter, NULL, info->extack);
> }
> 
>-static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg,
>-				    int attrtype)
>+static bool _devlink_fmsg_err_or_binary(struct devlink_fmsg *fmsg)

No need for "_" here. Drop it.


>+{
>+	if (!fmsg->err && fmsg->putting_binary)
>+		fmsg->err = -EINVAL;
>+
>+	return fmsg->err;
>+}
>+

[...]

