Return-Path: <netdev+bounces-20730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E2760CA5
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BD82816CD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B113AC6;
	Tue, 25 Jul 2023 08:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBF134CC
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:08:04 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE227A4
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:08:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso836691566b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690272481; x=1690877281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiMiYo3qP01WupeBWwiFrDCmz1xS3zRXM9WAdt+5bjE=;
        b=X5Uc/4KovNaS8tMqEAJJjLNMr3hIKqJWo+KstM9SwLGr8bDjGcjQtPsAPdYTS1E/Ty
         8nfrQfduM0TIZnPcHWXoamp3/9B1cuXC66A3m9A/h3RmeDEtFs/SZxTaU2XPOUVKMVhv
         e8Sgdxa7eYSd04pajLatXRCP1xM7AZm1xJHYf9gZK0pf8qANs1dF+SPlFV8WheN6V2nG
         rIMBXqfFasPrvPe5z1xB75QB4/jM3vf6zDXLZnBepERq1V8wFJhA5FBTVCeUgM4keBbT
         OiK+XkcBpQT/7ZATaMnNc/Yl+bZPvgHXelScs10sJA4YzlChQiM9MWuv9RmqOGk6NluC
         Hemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272481; x=1690877281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiMiYo3qP01WupeBWwiFrDCmz1xS3zRXM9WAdt+5bjE=;
        b=TO5eMDg5vw/HckO4a7YWXoOponxPkQJP/94FuFk3Kgi2txoHPlwMyh+i+fZEwjB59H
         UifIvza+xXVRA/SkWlYJ6+APQNjGZx5FngTKt86OgStThFRV5V+Wf0cW75LO3JjgEmZh
         fW9qv7ZGhkhVSStoh9isvrYIRGkg3XQAeLgaJXbqfW21h3T80N7cJgvxM2zmJDfV0ueN
         lDkjv7Sf+N9r4ECKB5dJiNF8WMqRQkdNeFGSSPdVMwhCI4BmWYTiNxsPtQ/nDbvz3u/d
         3nRxUn3qQe7/G7LcRgtmaAEKF2Jvuzp4d0YOp/1cRuR32zculpXr2oc9oYypJelV4Yru
         kg2g==
X-Gm-Message-State: ABy/qLYs6w9ODsUJ70IZEmgrii7DNQMwHoRM41Ol4j2h5+MQUVTuSEf6
	9iyWf1eid95rm2MBMTqMwHPzngWSzY4oOc/vB14=
X-Google-Smtp-Source: APBJJlFUcj/ni7QDrtvoiXp9dr4Lw28gIBJSeWbEc16jK3O1l1jHeZ/JPAde2TQ8lJR82z6Q5/jUdw==
X-Received: by 2002:a17:906:15d:b0:991:b834:af83 with SMTP id 29-20020a170906015d00b00991b834af83mr9876565ejh.59.1690272480985;
        Tue, 25 Jul 2023 01:08:00 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id rv14-20020a17090710ce00b0099b921de301sm3114547ejb.159.2023.07.25.01.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:08:00 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:07:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 00/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZL+C3xMq3Er79qDD@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720121829.566974-1-jiri@resnulli.us>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I see that this patchset got moved to "changes requested" in patchwork.
Why exacly? There was no comment so far. Petr's splat is clearly not
caused by this patchset.

Should I resubmit?

Thanks!

Thu, Jul 20, 2023 at 02:18:18PM CEST, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>Motivation:
>
>For SFs, one devlink instance per SF is created. There might be
>thousands of these on a single host. When a user needs to know port
>handle for specific SF, he needs to dump all devlink ports on the host
>which does not scale good.
>
>Solution:
>
>Allow user to pass devlink handle alongside the dump command
>and dump only objects which are under selected devlink instance.
>
>Introduce new attr DEVLINK_ATTR_DUMP_SELECTOR to nest the selection
>attributes. This way the userspace can use maxattr to tell if dump
>selector is supported by kernel or not.
>
>Assemble netlink policy for selector attribute. If user passes attr
>unknown to kernel, netlink validation errors out.
>
>Example:
>$ devlink port show
>auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
>auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false
>
>$ devlink port show auxiliary/mlx5_core.eth.0
>auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
>
>$ devlink port show auxiliary/mlx5_core.eth.1
>auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false
>
>This is done in patch #10
>
>Dependency:
>
>The DEVLINK_ATTR_DUMP_SELECTOR parsing is very suitable to be done
>once at the beginning of the dumping. Unfortunatelly, it is not possible
>to define start() and done() callbacks for netlink small ops.
>So all commands that use instance iterator for dumpit are converted to
>split ops. This is done in patch #1-9
>
>Extension:
>
>patch #11 extends the selector by port index for health reporter
>dumping.
>
>v1->v2:
>- the original single patch (patch #10) was extended to a patchset
>
>Jiri Pirko (11):
>  devlink: parse linecard attr in doit() callbacks
>  devlink: parse rate attrs in doit() callbacks
>  devlink: introduce __devlink_nl_pre_doit() with internal flags as
>    function arg
>  devlink: convert port get command to split ops
>  devlink: convert health reporter get command to split ops
>  devlink: convert param get command to split ops
>  devlink: convert trap get command to split ops
>  devlink: introduce set of macros and use it for split ops definitions
>  devlink: convert rest of the iterator dumpit commands to split ops
>  devlink: introduce dump selector attr and use it for per-instance
>    dumps
>  devlink: extend health reporter dump selector by port index
>
> include/uapi/linux/devlink.h |   2 +
> net/devlink/devl_internal.h  |  42 +++---
> net/devlink/health.c         |  21 ++-
> net/devlink/leftover.c       | 211 ++++++++--------------------
> net/devlink/netlink.c        | 263 ++++++++++++++++++++++++++++++-----
> 5 files changed, 333 insertions(+), 206 deletions(-)
>
>-- 
>2.41.0
>

