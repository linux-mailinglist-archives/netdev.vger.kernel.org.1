Return-Path: <netdev+bounces-257458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bz3JrFkhWl3BAQAu9opvQ
	(envelope-from <netdev+bounces-257458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:49:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABDF9D93
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0924A3004C9A
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBF332EBF;
	Fri,  6 Feb 2026 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UVJXQgf0"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3B2F8BF0;
	Fri,  6 Feb 2026 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349740; cv=none; b=ZCEnD1kfYLk1+GqTpN9mF32geBYH9z0/OyEhQAouJTeCxJ20fANkFBxmtTCVxScL82ndb5UX5NXrGW5CmyG5TVMuU34ytEOGZjn6+KVdSdX3U3mcsqgwgKt7qdLP5bO5c4W1JibmY4Puvx821wO8fRMEwle9N69qczn4O1yQZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349740; c=relaxed/simple;
	bh=87QQUl4e7HqZKhWMAtTEppCPMza5MRsdWsc6tiBnyho=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iMXutJr55Dz+eiM01vJe50CrIq4Vdz2u/+9iyTH0n3GfhM6jeY0VKpui+YIHPPJs15WrUoYcGphTWOpn0/d1dY8Xp8XSccLYMpg16pV8Z/xHB8IeAnlAUFVezSsyQdW4LG6RLhJNdOmxQZe5M8DvlpkM4A06qNP2xmsJ+nx24M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UVJXQgf0; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xHnlFeualg8bdHUJfaXz5HeXLvkuRU8CrON2r3xA68s=;
	b=UVJXQgf0+nXryyaoI1PHyZdIMY9mzQ18x2QsuHo+ss67EYViYkgQl457XOooRNzhI5eDNwis2
	c0eR8kF1dRBCXpHsacTJA5lm/xYb70pcJqhmh6OqODrNko5xW5JHwOjyuHpD4RWvCZHeiPMjzJQ
	7XVSXhcCj3r7MB4BQsl810E=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f6g1t1LBrz1K96f;
	Fri,  6 Feb 2026 11:44:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0973C40363;
	Fri,  6 Feb 2026 11:48:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 6 Feb 2026 11:48:50 +0800
Message-ID: <b68a6d51-a416-4252-848e-0f3a8a3216bd@huawei.com>
Date: Fri, 6 Feb 2026 11:48:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-atm-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <3chas3@gmail.com>
Subject: Re: [PATCH net] atm: fore200e: fix use-after-free in tasklets during
 device removal
To: Duoming Zhou <duoming@zju.edu.cn>, <netdev@vger.kernel.org>
References: <20260205030317.39190-1-duoming@zju.edu.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260205030317.39190-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,lists.sourceforge.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:email]
X-Rspamd-Queue-Id: 65ABDF9D93
X-Rspamd-Action: no action


on 2026/2/5 11:03, Duoming Zhou wrote:
> When the PCA-200E or SBA-200E adapters is being detached, the fore200e
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
> synchronize with any pending or running tasklets.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/atm/fore200e.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
> index f62e3857144..7470daf9469 100644
> --- a/drivers/atm/fore200e.c
> +++ b/drivers/atm/fore200e.c
> @@ -358,7 +358,12 @@ fore200e_shutdown(struct fore200e* fore200e)
>       printk(FORE200E "removing device %s at 0x%lx, IRQ %s\n",
>   	   fore200e->name, fore200e->phys_base,
>   	   fore200e_irq_itoa(fore200e->irq));
> -
> +
> +#ifdef FORE200E_USE_TASKLET
> +	tasklet_kill(&fore200e->tx_tasklet);
> +	tasklet_kill(&fore200e->rx_tasklet);
> +#endif
> +
>       if (fore200e->state > FORE200E_STATE_RESET) {
>   	/* first, reset the board to prevent further interrupts or data transfers */
>   	fore200e_reset(fore200e, 0);

Hi,

I personally think that tasklet_kill() should be moved here.
According to the code comments, there will be no data transfers or interrupts after fore200e_reset(),
otherwise fore200e->tx_tasklet may be rescheduled again in fore200e_interrupt().

Jijie Shao


