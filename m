Return-Path: <netdev+bounces-257523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HQmH4PHhWnAGAQAu9opvQ
	(envelope-from <netdev+bounces-257523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:50:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD9FCD1F
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139EF3012EBF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9555379982;
	Fri,  6 Feb 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rCdA4lMd"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072835FF6E;
	Fri,  6 Feb 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374922; cv=none; b=e7GcvDYw8Dqf7IEBxAPuxAcKSet3nGwlNTCSmvGkU0NNr4jvj7hJfCpikd9Hpf6MYkGZ5pLfTZhuVgmd/T8zODK5zGHLDjGslxk5Eyt8wotfPBwQU1pDATjgKDZs3dyX6CRQ52HcB78evw7jV8/Idjuq5W8OCjxZvuEk4MwjmUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374922; c=relaxed/simple;
	bh=2iUOBVUzj88/+VFZESe/CiEzYtzswisIg/X14nNbBRE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KHpf1AF0sN9O+e4L47yWqVbUzerRYjgzC1noN32CE7hJ2cXOkkuMkIgsTOEjXD3oUL+Z+4f3OaabWvZVxaxeL3aDy3yhbot5S7UD1JRGDe4KXPbuGuT3laS+YFCmJIhPuYgM/T8pGFexQImkJttlwULYQ4uwaCFeL7hK32dcZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rCdA4lMd; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=46F0ccvL8sFOVHSQ8/ZJVkPjEFdbSkDUDEV/XC8yyFM=;
	b=rCdA4lMdKYkpRHoWx24PeC3iDoDeID9uOHhgSY1797sCcJmc16/YwsVdAz0b+0geDcLoy/KHi
	iKJJelBT1c4XSNZE0Gmc6JT6HrNhNHlE2mNQj+VkdMay5ABkX0Mkw3titWjyyxtW9zwA7KD6iAs
	hY+GZIEEtB+rujhAYWj9RH8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f6rL90NFCz1prKJ;
	Fri,  6 Feb 2026 18:44:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EB3E44056A;
	Fri,  6 Feb 2026 18:48:38 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 18:48:38 +0800
Message-ID: <41559748-63f2-49ea-9d94-433eeb0edb8b@huawei.com>
Date: Fri, 6 Feb 2026 18:48:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-atm-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <3chas3@gmail.com>
Subject: Re: [PATCH net v2] atm: fore200e: fix use-after-free in tasklets
 during device removal
To: Duoming Zhou <duoming@zju.edu.cn>, <netdev@vger.kernel.org>
References: <20260206094811.23431-1-duoming@zju.edu.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260206094811.23431-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,lists.sourceforge.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257523-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zju.edu.cn:email]
X-Rspamd-Queue-Id: 95BD9FCD1F
X-Rspamd-Action: no action


on 2026/2/6 17:48, Duoming Zhou wrote:
> When the PCA-200E or SBA-200E adapter is being detached, the fore200e
> is deallocated. However, the tx_tasklet or rx_tasklet may still be running
> or pending, leading to use-after-free bug when the already freed fore200e
> is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().
>
> One of the race conditions can occur as follows:
>
> CPU 0 (cleanup)           | CPU 1 (tasklet)
> fore200e_pca_remove_one() | fore200e_interrupt()
>    fore200e_shutdown()     |   tasklet_schedule()
>      kfree(fore200e)       | fore200e_tx_tasklet()
>                            |   fore200e-> // UAF
>
> Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
> the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
> synchronize with any pending or running tasklets. Moreover, since
> fore200e_reset() could prevent further interrupts or data transfers,
> the tasklet_kill() should be placed after fore200e_reset() to prevent
> the tasklet from being rescheduled in fore200e_interrupt().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>    - Move tasklet_kill() after fore200e_reset().
>
>   drivers/atm/fore200e.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
> index f62e3857144..de04c407921 100644
> --- a/drivers/atm/fore200e.c
> +++ b/drivers/atm/fore200e.c
> @@ -362,6 +362,10 @@ fore200e_shutdown(struct fore200e* fore200e)
>       if (fore200e->state > FORE200E_STATE_RESET) {
>   	/* first, reset the board to prevent further interrupts or data transfers */
>   	fore200e_reset(fore200e, 0);
> +#ifdef FORE200E_USE_TASKLET
> +	tasklet_kill(&fore200e->tx_tasklet);
> +	tasklet_kill(&fore200e->rx_tasklet);
> +#endif
>       }

I'm sorry if I gave you a confusing comment.

If (fore200e->state <= FORE200E_STATE_RESET), is there no need to do tasklet_kill()?

Tips: If you need to send v3, please don’t repost your patche within one 24h period:
   https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

   Jijie Shao


