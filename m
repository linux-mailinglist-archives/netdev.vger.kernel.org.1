Return-Path: <netdev+bounces-24666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9D770F7D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296621C20ACE
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3D0BA32;
	Sat,  5 Aug 2023 11:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681D8F6F
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F94C433C7;
	Sat,  5 Aug 2023 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691236114;
	bh=yJsqQkipN4nUCRZZ+P6t1hjH6sdNsZq/yPGlXfyEOfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THW75Q4NTvkwQGiEIcTiUNLBzCCmQf1MqJe/Z9k4h0cUsRQP0TS9X8BwNwl1ELzGr
	 qIm3nDPj8KtlEZNqzsiXiPH4iOqiKRsQZ4agAFNobegqsFuqLTAu7dpSB9/+K5DDmh
	 q0VD5kdKyKTUFVNQSLJoxo5kMiRD2hEV9B7J+iuB2l1j6SOUzCyMHZFzjhgdul5eys
	 0LPvX8zSVuOM5hVSOFPD9tu6dlLk6s2wfvVRBfiyHfhQhiC3BRBaGgDYUVRoZ+Edhn
	 ZhAv5rAylW1aVLbxKDg3YWIV+JQspCGABTbNMWxd2VzdC9xwAeQ7azxRfamQJ9o0vg
	 kpmIbofk6pMFA==
Date: Sat, 5 Aug 2023 13:48:31 +0200
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] team: remove unreferenced header in
 activebackup/broadcast/roundrobin files
Message-ID: <ZM43D2GuL7lU0k4X@vergenet.net>
References: <20230804113035.1698118-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804113035.1698118-1-shaozhengchao@huawei.com>

On Fri, Aug 04, 2023 at 07:30:35PM +0800, Zhengchao Shao wrote:
> Because linux/errno.h is unreferenced in activebackup/broadcast/roundrobin
> files, so remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/team/team_mode_activebackup.c | 1 -
>  drivers/net/team/team_mode_broadcast.c    | 1 -
>  drivers/net/team/team_mode_roundrobin.c   | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
> index e0f599e2a51d..419b9083515e 100644
> --- a/drivers/net/team/team_mode_activebackup.c
> +++ b/drivers/net/team/team_mode_activebackup.c
> @@ -8,7 +8,6 @@
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/errno.h>
>  #include <linux/netdevice.h>
>  #include <net/rtnetlink.h>
>  #include <linux/if_team.h>

Hi Zhengchao Shao,

Removing the inclusion of errno.h from team_mode_activebackup.c doesn't
seem right to me, ENOENT is used in that file.

The other two below seem fine to me.

> diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
> index 313a3e2d68bf..61d7d79f0c36 100644
> --- a/drivers/net/team/team_mode_broadcast.c
> +++ b/drivers/net/team/team_mode_broadcast.c
> @@ -8,7 +8,6 @@
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/errno.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_team.h>
>  
> diff --git a/drivers/net/team/team_mode_roundrobin.c b/drivers/net/team/team_mode_roundrobin.c
> index 3ec63de97ae3..dd405d82c6ac 100644
> --- a/drivers/net/team/team_mode_roundrobin.c
> +++ b/drivers/net/team/team_mode_roundrobin.c
> @@ -8,7 +8,6 @@
>  #include <linux/types.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/errno.h>
>  #include <linux/netdevice.h>
>  #include <linux/if_team.h>

-- 
pw-bot: changes-requested

