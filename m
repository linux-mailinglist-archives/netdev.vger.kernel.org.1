Return-Path: <netdev+bounces-31912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F037F7915E1
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F93280F6D
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E190620FD;
	Mon,  4 Sep 2023 10:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30611FAC
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:50:56 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D63E191;
	Mon,  4 Sep 2023 03:50:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007616b756so2207509e87.3;
        Mon, 04 Sep 2023 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693824653; x=1694429453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eV5JoTi0DCMOSsAGIml4QjVd10Eh9jcupgB9/8GBSPw=;
        b=N2D7c2FplaazPs4348WmyY6eGUvVNyvkyIwmpdfDhhK7CJ7YAL8D2FZaQTHSH7h8KY
         XCtN8JJn3lhwdNdo9GCI53O3wQZkSuBnSTAKjTDPgLfNd6EehkJ5xZC0HW6jHzeUYfqF
         PrJfZoZZPOMFbGpioEhApkyH2wpB9Mf7BobCMF8YLEoLC8ssxJxqAk4y3vxd6gyGSCJ7
         Ac1/vQFYs6K1W0UIskR46l4nJxW+4NPsqIIVTqHqPyZgr/FI4p9nECEoRS2EQhX26hLG
         77jPPjoclLO7B9iVfaF5x0vQwjvQ2FNXSxepZYA/52UjreZyUp4Y+c+aZPAaX/tO+OrE
         wBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693824653; x=1694429453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV5JoTi0DCMOSsAGIml4QjVd10Eh9jcupgB9/8GBSPw=;
        b=F5nwrpuHwJ2OafW7xSYsBNnfmkhz0hU0VtypkpEIN7XBJQQ0Yu6F/T2n/DISiga69k
         SwmZfkrZa12whu53bDhFR0OhSRGhZzxZVAveGiremw+9kggMXdlFH5A1NIoMs4R2Apv7
         3lOLwCl2Elqz/ijCR9i7NUkHKp+hcMWUEJ20ldng7tWEIoqMleZl4/EkfPfUSnbDPMgm
         2yiTuW6/70/8BkbnYXG3J924byBmBwZIkfhZgpDkhjg9QFf83oTtunUS6EL71Qpdeh9H
         wS7hbqriL1qgCuBn5GGWEk7Sb5HEEVTp6oARcCQ5wE4N/RvUcQWVMVZcKFjp9+GidcG2
         BblQ==
X-Gm-Message-State: AOJu0YyJ1cVpk9koSHcYWRiu/a03D89QSRILlx85YQl3NJfamfMc/Vy4
	uEhlAKdjHAPIZlHVmEsQQ/U=
X-Google-Smtp-Source: AGHT+IHjTygKuHa+wTdH3VEwFta6adO0Tlg6xJANZKH9z6sgiqSAQfoWvvKY2g8KJl2mPMkG3mPwEw==
X-Received: by 2002:a19:4f48:0:b0:500:8723:e457 with SMTP id a8-20020a194f48000000b005008723e457mr5812058lfk.30.1693824652953;
        Mon, 04 Sep 2023 03:50:52 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b00401b242e2e6sm16809585wme.47.2023.09.04.03.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 03:50:52 -0700 (PDT)
Date: Mon, 4 Sep 2023 11:50:51 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, rdunlap@infradead.org,
	laurent.pinchart@ideasonboard.com, sd@queasysnail.net
Subject: Re: [PATCH net v4] docs: netdev: document patchwork patch states
Message-ID: <20230904105051.GB8198@gmail.com>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, rdunlap@infradead.org,
	laurent.pinchart@ideasonboard.com, sd@queasysnail.net
References: <20230901142406.586042-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230901142406.586042-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 07:24:05AM -0700, Jakub Kicinski wrote:
> The patchwork states are largely self-explanatory but small
> ambiguities may still come up. Document how we interpret
> the states in networking.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
> v4:
>  - clarify that patches once set to Awaiting Upstream will stay there
> v3: no change
> v2: https://lore.kernel.org/all/20230830220659.170911-1-kuba@kernel.org/
>  - add a sentence about New vs Under Review
>  - s/maintainer/export/ for Needs ACK
>  - fix indent
> v1: https://lore.kernel.org/all/20230828184447.2142383-1-kuba@kernel.org/
> 
> CC: corbet@lwn.net
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> 
> CC: rdunlap@infradead.org
> CC: laurent.pinchart@ideasonboard.com
> CC: sd@queasysnail.net
> ---
>  Documentation/process/maintainer-netdev.rst | 32 ++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index c1c732e9748b..db1b81cfba9b 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -120,7 +120,37 @@ Status of a patch can be checked by looking at the main patchwork
>    https://patchwork.kernel.org/project/netdevbpf/list/
>  
>  The "State" field will tell you exactly where things are at with your
> -patch. Patches are indexed by the ``Message-ID`` header of the emails
> +patch:
> +
> +================== =============================================================
> +Patch state        Description
> +================== =============================================================
> +New, Under review  pending review, patch is in the maintainer’s queue for
> +                   review; the two states are used interchangeably (depending on
> +                   the exact co-maintainer handling patchwork at the time)
> +Accepted           patch was applied to the appropriate networking tree, this is
> +                   usually set automatically by the pw-bot
> +Needs ACK          waiting for an ack from an area expert or testing
> +Changes requested  patch has not passed the review, new revision is expected
> +                   with appropriate code and commit message changes
> +Rejected           patch has been rejected and new revision is not expected
> +Not applicable     patch is expected to be applied outside of the networking
> +                   subsystem
> +Awaiting upstream  patch should be reviewed and handled by appropriate
> +                   sub-maintainer, who will send it on to the networking trees;
> +                   patches set to ``Awaiting upstream`` in netdev's patchwork
> +                   will usually remain in this state, whether the sub-maintainer
> +                   requested changes, accepted or rejected the patch
> +Deferred           patch needs to be reposted later, usually due to dependency
> +                   or because it was posted for a closed tree
> +Superseded         new version of the patch was posted, usually set by the
> +                   pw-bot
> +RFC                not to be applied, usually not in maintainer’s review queue,
> +                   pw-bot can automatically set patches to this state based
> +                   on subject tags
> +================== =============================================================
> +
> +Patches are indexed by the ``Message-ID`` header of the emails
>  which carried them so if you have trouble finding your patch append
>  the value of ``Message-ID`` to the URL above.
>  
> -- 
> 2.41.0
> 

