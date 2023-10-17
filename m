Return-Path: <netdev+bounces-41887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705B47CC1A6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C282819A6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449B41A93;
	Tue, 17 Oct 2023 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y++WcQGh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBABE69
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:17:31 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20138A2
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:17:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so9425489a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697541448; x=1698146248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoNZj4QGVuc+WTAjqvHZThErSmETA5UdZcMfunvG2xw=;
        b=y++WcQGhv+NzejORDVSg4AJ7pLNm+hM+IukC4gz7MmHloEhVJDPM9u7Ie5cyNclwvu
         n39k1NKWso5+nWg+PuSVWefPV60/rzutIg5CHeHGvg8PbLU+UKeIt3jx0uvan9BHf73j
         AzyR8f3hV5EjBYzZsn/GsfK7JDZ+fhroWphu4FDZdgqYo7nQ4is9ZPcZ6Vj8O/IGvRZg
         I5F4oUR3tJPMyTt2CSNJ43q2wj87LXUvpEggQ7xBkpAWBOLC50n4hPxhLAkbMT86WC9A
         CswC/yMHHb+GodM5O24P2U+1dmTZud+D9YcoWeujQMlNBWEuZeyLI/S3jQOGWI4aDwHm
         uc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697541448; x=1698146248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoNZj4QGVuc+WTAjqvHZThErSmETA5UdZcMfunvG2xw=;
        b=t5P5ysee4N1cKJyj7AuY7Nm8tppaHCL3H6KEnF963RC8fIqNF2iEdANM50h8p5Xqag
         Vak5S8iX+ZsKkAq0ilm2FCA7Xf7wCJU5/++LMMe7+lsogU0K2vEXwpNPKiHYCdB5D9HB
         f06KX9lzm9JSBECgSHKM6PWOTddQfVii82pF6JePrCi/iMcMqWkSmlrla13XCBopeMnJ
         h/s4rxcmeZ00kvXCkM8ILrHqVd3YChtWT8mUykk8SV6DoMHXL9TBvTm9tXCDU3AUwe9a
         SvZO858kiUHVIuWqYTfwaWmfhyEJicI8jMCX/MgoTI0OGViH2yJ2K6LFHDJ8dRsLOK07
         AZiA==
X-Gm-Message-State: AOJu0YxOXNReoa1XnMI4K8rWHdDdChNr0oHQSuQlL1MKbtKOIGUP0jDU
	GPkXNwmjL3QDO+p7FI18x7xvDQ==
X-Google-Smtp-Source: AGHT+IG3/KAVejqxiHDYDaU+1mr0h2tuN+RNmnmZBjgu6istFJeg5VFePILcc1tKt7ebGNBy1JPcUg==
X-Received: by 2002:a05:6402:4303:b0:534:78a6:36c4 with SMTP id m3-20020a056402430300b0053478a636c4mr1585706edc.36.1697541448551;
        Tue, 17 Oct 2023 04:17:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cq23-20020a056402221700b00533dd4d2947sm1017926edb.74.2023.10.17.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:17:28 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:17:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <ZS5tR1z5rHuD8BFD@nanopsycho>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 12:53:30PM CEST, przemyslaw.kitszel@intel.com wrote:
>Extend devlink fmsg to retain error (patch 1),
>so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
>and finally enforce future uses to follow this practice by change to
>return void (patch 11)
>
>Note that it was compile tested only.
>
>bloat-o-meter for whole series:
>add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)
>
>changelog:
>v2: extend series by two more drivers (qed, qlge);
>    add final cleanup patch, since now whole series should be merged in
>    one part (thanks Jiri for encouragement here);
>
>v1:
>https://lore.kernel.org/netdev/20231010104318.3571791-3-przemyslaw.kitszel@intel.com
>
>Przemek Kitszel (11):
>  devlink: retain error in struct devlink_fmsg
>  netdevsim: devlink health: use retained error fmsg API
>  pds_core: devlink health: use retained error fmsg API
>  bnxt_en: devlink health: use retained error fmsg API
>  hinic: devlink health: use retained error fmsg API
>  octeontx2-af: devlink health: use retained error fmsg API
>  mlxsw: core: devlink health: use retained error fmsg API
>  net/mlx5: devlink health: use retained error fmsg API
>  qed: devlink health: use retained error fmsg API
>  staging: qlge: devlink health: use retained error fmsg API
>  devlink: convert most of devlink_fmsg_*() to return void

Looks great.

Thanks!

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

