Return-Path: <netdev+bounces-31901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11797914CB
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2691A280F76
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5617C9;
	Mon,  4 Sep 2023 09:33:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA07E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 09:33:38 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B690B3
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:33:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aeedbb264so1175006f8f.0
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1693820014; x=1694424814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5xdxJTWd1ELsUMCPEhUQXw/VnqUp7otoxDsLv0lTms=;
        b=ItnlhSs6sybVMLl+Ko9cPFI1MJcFqguhDSoqslFU0ROMmF1TpD5A4l27I1Dq0vunPr
         mdIgCFIdk3pSqEuYzaGtQZD1N4GriSkCYuzHQohZnQh1qXxCnIi4AsAuJIjU6W6F8c+7
         kjzemZN84sgpzXjPH3Nm+4Bq+zVLVqvKZYwh8QatfV4iQGn3tGVw+jJhMzFgFbhHKW3/
         WzhLyBymFHyEJX68i5x7CG7z6RVsfJw51+i45rm0VcmaQaqx8emkFfjP7+LEvGGeUU23
         bpvL0+XcUdOjn6MokUEAlU6sGkyAkqqiTOLlGIoptJ+6pa+fcUtOMwYYuVAyLbiPXiPc
         vXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820014; x=1694424814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5xdxJTWd1ELsUMCPEhUQXw/VnqUp7otoxDsLv0lTms=;
        b=CrOE+NaD34a1/cYY870fyM2tGiIjfL6EBkD0PYSJ/uE3oI+rDR7zWBSp78ZfeNJmFN
         VHobp5Lgz04hPJxEDWfDjkrONL6YN3KHCk6tPgkpwbhTiYXWpPL7XUJYqrVlFxJd0dPM
         LIBtTHkfQq97z7/PNj3988Dc0fNz1JODR5nDoA7rUAKO1Cn0j25m3+Tw1ZCUjjf0+t3L
         Qdy/93+DV5Xorh/+eeDAoPIeSv5uAoyNowxiN5prSM5NNabRi5ZJDAU0Y+lk/QrjVrY9
         7lucB3PX/peEbYSm6LpWFRYf9n7HtcNiZMiZ7TKn5pJOkNMwXm2zruJH6u0yRREM3H+K
         JZqw==
X-Gm-Message-State: AOJu0YyPAPJgGFHpCo4KZr2uo3FFxVLgOJuHrVtyUEqXxW+9rugT06t8
	98fWciUTivfgrpotxYduFWsF9YjqUUfFtqfDlrc=
X-Google-Smtp-Source: AGHT+IEShIAe4bvzKXRiTM8Pwxy6e5XlyKteDUO+ndNUWI8JxUrnPavdORw6g2/6zvTm3Rbn9RhC5w==
X-Received: by 2002:adf:ebcd:0:b0:317:61af:d64a with SMTP id v13-20020adfebcd000000b0031761afd64amr6392029wrn.3.1693820014154;
        Mon, 04 Sep 2023 02:33:34 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b003143c6e09ccsm14102997wro.16.2023.09.04.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:33:33 -0700 (PDT)
Date: Mon, 4 Sep 2023 11:33:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org, dsahern@gmail.com
Subject: Re: [patch iproute2-next 0/6] devlink: implement dump selector for
 devlink objects show commands
Message-ID: <ZPWkbOHuqBm13A7t@nanopsycho>
References: <20230831132229.471693-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831132229.471693-1-jiri@resnulli.us>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 31, 2023 at 03:22:23PM CEST, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>First 5 patches are preparations for the last one.
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
>Allow user to pass devlink handle (and possibly other attributes)
>alongside the dump command and dump only objects which are matching
>the selection.
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
>Jiri Pirko (6):
>  devlink: move DL_OPT_SB into required options
>  devlink: make parsing of handle non-destructive to argv
>  devlink: implement command line args dry parsing
>  devlink: return -ENOENT if argument is missing
>  mnl_utils: introduce a helper to check if dump policy exists for
>    command
>  devlink: implement dump selector for devlink objects show commands
>
> devlink/devlink.c   | 376 ++++++++++++++++++++++++++------------------
> include/mnl_utils.h |   1 +
> lib/mnl_utils.c     | 121 +++++++++++++-
> 3 files changed, 342 insertions(+), 156 deletions(-)
>
>-- 
>2.41.0
>

There is an issue with the first patch, fixing and sending v2.

pw-bot: changes-requested

