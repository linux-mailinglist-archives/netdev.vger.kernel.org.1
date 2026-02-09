Return-Path: <netdev+bounces-257898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI4EGcOBiWkg+QQAu9opvQ
	(envelope-from <netdev+bounces-257898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:42:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957010C2E9
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 07:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09DA93002E74
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA152FE048;
	Mon,  9 Feb 2026 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VhQZO4GL"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9F2EBBB3;
	Mon,  9 Feb 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619326; cv=none; b=efer5neQ9q9XYlCLSCkZsByi8wQ4QJj/844f3L8c1xg1QUEx3jSXXrqVQM++7Jtb0HVJZ6ORM3bd8s1RbT+J3cXJxbzgWv6HkzE0sgoNLrcMlWTcBG5PyQm/6NvYktaKtTGzO4KFiY7TSRCBf6o6nCeEG5A+B8yC8nR5eZ9Gocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619326; c=relaxed/simple;
	bh=yTxUTZZ0I5gzEXgCLCY3iGfQeY4CJewx8hkq5B9LfHc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mGdR92BBtiCTRebAWLgL+fxz0e2LnT9dCuO8/KJhzOcN2kxzf+2LpSLYnVAXKR169kI89uEH5CtJsmvhLZbIr7cBIxobCl/I6NBdIvxzngF3yh2sUK5Sn+YlysSkEmzytgguUn1O3Vir/KPEuJInWRR4CyBpn0SzY+oNTG9Q3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VhQZO4GL; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GCTUH/1VMyKuNr5ynPnAW+lMNTHrZVMBFcHP1ysd2vo=;
	b=VhQZO4GLcoZW+CH43oB6Cfi6e+UiBd6O+Or6tZqUDUSR5ia5FNpr5LUGNOwxMeAR0+FTD5OBX
	KN1ukUBNHBINQxWo1IYP1J3FQqvXnD2X4EhualkwoSBz4NKC3L4yYmY3Dr18jLdGakR83e62TPy
	P51vyIyoOtPZsXrSVSUrOvY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f8Zk66Tz6z1K9CV;
	Mon,  9 Feb 2026 14:37:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BEF640561;
	Mon,  9 Feb 2026 14:41:53 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 9 Feb 2026 14:41:53 +0800
Message-ID: <39abbfbb-777e-4fe9-a8cf-38ab40863667@huawei.com>
Date: Mon, 9 Feb 2026 14:41:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-atm-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<3chas3@gmail.com>
Subject: Re: [PATCH net v2] atm: fore200e: fix use-after-free in tasklets
 during device removal
To: <duoming@zju.edu.cn>
References: <20260206094811.23431-1-duoming@zju.edu.cn>
 <41559748-63f2-49ea-9d94-433eeb0edb8b@huawei.com>
 <1ec5e02d.6d52a.19c337418d3.Coremail.duoming@zju.edu.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <1ec5e02d.6d52a.19c337418d3.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,lists.sourceforge.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257898-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3957010C2E9
X-Rspamd-Action: no action


on 2026/2/6 22:56, duoming@zju.edu.cn wrote:
> On Fri, 6 Feb 2026 18:48:38 +0800 Jijie Shao wrote:
>>> When the PCA-200E or SBA-200E adapter is being detached, the fore200e
>>> is deallocated. However, the tx_tasklet or rx_tasklet may still be running
>>> or pending, leading to use-after-free bug when the already freed fore200e
>>> is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().
>>>
>>> One of the race conditions can occur as follows:
>>>
>>> CPU 0 (cleanup)           | CPU 1 (tasklet)
>>> fore200e_pca_remove_one() | fore200e_interrupt()
>>>     fore200e_shutdown()     |   tasklet_schedule()
>>>       kfree(fore200e)       | fore200e_tx_tasklet()
>>>                             |   fore200e-> // UAF
>>>
>>> Fix this by ensuring tx_tasklet or rx_tasklet is properly canceled before
>>> the fore200e is released. Add tasklet_kill() in fore200e_shutdown() to
>>> synchronize with any pending or running tasklets. Moreover, since
>>> fore200e_reset() could prevent further interrupts or data transfers,
>>> the tasklet_kill() should be placed after fore200e_reset() to prevent
>>> the tasklet from being rescheduled in fore200e_interrupt().
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>> ---
>>> Changes in v2:
>>>     - Move tasklet_kill() after fore200e_reset().
>>>
>>>    drivers/atm/fore200e.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
>>> index f62e3857144..de04c407921 100644
>>> --- a/drivers/atm/fore200e.c
>>> +++ b/drivers/atm/fore200e.c
>>> @@ -362,6 +362,10 @@ fore200e_shutdown(struct fore200e* fore200e)
>>>        if (fore200e->state > FORE200E_STATE_RESET) {
>>>    	/* first, reset the board to prevent further interrupts or data transfers */
>>>    	fore200e_reset(fore200e, 0);
>>> +#ifdef FORE200E_USE_TASKLET
>>> +	tasklet_kill(&fore200e->tx_tasklet);
>>> +	tasklet_kill(&fore200e->rx_tasklet);
>>> +#endif
>>>        }
>> I'm sorry if I gave you a confusing comment.
>>
>> If (fore200e->state <= FORE200E_STATE_RESET), is there no need to do tasklet_kill()?
> The following four states that are preceding FORE200E_STATE_RESET are only set
> during device initialization: FORE200E_STATE_BLANK, FORE200E_STATE_REGISTER,
> FORE200E_STATE_CONFIGURE, and FORE200E_STATE_MAP.
>
> If the device is in any of these states, it means the initialization is
> not complete and interrupts have not been registered. Therefore, tasklet
> could not be scheduled through fore200e_interrupt().
>
> If the device is in FORE200E_STATE_RESET state, the fore200e_reset() has
> already reset the device, which could prevent further interrupts and
> tasklet scheduling.
>
> So there is no need to do tasklet_kill() if the state of fore200e is
> less than or equal to FORE200E_STATE_RESET.

Yeah, I agree.
But I reviewed the fore200e_init() again, and it only needs to do tasklet_kill()
when "fore200e->state >= fFORE200E_STATE_IRQ"(in fore200e_irq_request());
otherwise, "fore200e->tx_tasklet" has not been initialized.

Jijie Shao



