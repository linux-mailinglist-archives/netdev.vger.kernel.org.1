Return-Path: <netdev+bounces-45836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550D7DFD3B
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 00:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41E31C20F55
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577C224D1;
	Thu,  2 Nov 2023 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WHiTrOzb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BF224CA
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 23:12:22 +0000 (UTC)
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F3A1A8;
	Thu,  2 Nov 2023 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698966729; bh=UYgiV3kDQvNhdJuIIAC0WmDVYjGsyq5maK2QWju/Aqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WHiTrOzbDrgl0lSAnGxDAowQozRrC90b3+405bfQ5U2wmeEVA2dZv+Jnaxl6lfra8
	 OEGV7p/S0CMVKRie/CwoM5PBDXl+oY4aKKeR3JOuIWKMDVH0WyYryzZtjCUPNJEMcR
	 zsi9v/8jxVJVRBdJ78pNFRsxtwdPFT59YjjI3gKQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 3062ECDD; Fri, 03 Nov 2023 07:12:06 +0800
X-QQ-mid: xmsmtpt1698966726tduk86oje
Message-ID: <tencent_66A4C45E9778B760C6C3D36AE37509600305@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtDsSJJtgLNyGQJASOPSiqxqF5hCwxi3KR2iRxGsfw6go/ewnJfj
	 jI/72sIPJUrAFkl06ZIzVmHZs3qXZNXQK3cPDEbLkgvJrcCyREeFV1913sUPEG6ha2Gs5mINMElE
	 jSFu/KKpxSJVV8uKAzD8ulvQxb5tqibzke8q1O1v+gzFbHepb2dUig7GJyknNykNgWHPbhKm09cx
	 yD4QM36yv17uDLWkusYtm/QGmJ9eVg4++eiouzsVud2bqA7HipvAT731H7KEl5Qjmd9rJ80uZlj8
	 TPUuurONyWaVkb46R7zZ/EpUTwK+Qul2IX9WJIKEDouCci/FBkaEMDUx34EgLdVjG1JXR5y7ouyI
	 olMkSKTiyqNo4tTHTveF+2ZKq6SOukyqSXTna1aLeK960zP4T+Okha8P8UYnRwS7EqLzaYUR18o3
	 DM5SgarLvqRLIZObTKok1XdSzO/K+o960ROzg+sySBT/f++EFDI/aYzmNOirnu8IYsbgU76XcKiY
	 JmPML07c9pkNyOzRHn1AmPMUDYhiG4wU2Xy5vnwnmP0yXadc0gLCWa/uiuXqXRdnKOOGcDyLkfs9
	 3ar5tEGbduENjwEAmkT2EMz9ZyBnPzHA4/tuDz/YXp8NK71gkRce1xQJ/2lGJGB7Q00T8DDg+g07
	 o85vbwWoaVpuQVJTz77JIh1kMW+1bqXYTUkrHO4uQaaLvITiUOww3aQT9M0QEr78yAERtx4PNZ5h
	 lcWnNTdJ5LwNqyBOOTSbXq6xUuEfldyiYTJW6qNE71tKaE0sMS3PHVbIVptipynuEtGgveN4ac5U
	 g0WqmtKrwLeX87S7GmTt9Mo6DnZ2XiNJZKmLiwi4z/DvVdXJqrtQ9hqyuuKovzCCEvf82+EqUF1N
	 6sA1TcqTAvN0AlhqTaDVgrRiQYYNqxOqjP0keIC+IK2tcS/azkSZPY0atEQm5DVnwFeBB1T8iVOl
	 8zMUxU98E=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: jeremy@jcline.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	habetsm.xilinx@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Date: Fri,  3 Nov 2023 07:12:07 +0800
X-OQ-MSGID: <20231102231206.358053-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZUPnlsm91R72MBs7@dev>
References: <ZUPnlsm91R72MBs7@dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeremy,

On Thu, 2 Nov 2023 14:16:54 -0400 Jeremy Cline wrote:
>> There is no lock protection when writing ptp->tsevqs in ptp_open(),
>> ptp_release(), which can cause data corruption, use mutex lock to avoid this 
>> issue.
>> 
>> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
>> and it should be deleted together.
>> 
>> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
>> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  drivers/ptp/ptp_chardev.c | 11 +++++++++--
>>  drivers/ptp/ptp_clock.c   |  3 +++
>>  drivers/ptp/ptp_private.h |  1 +
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
>> index 282cd7d24077..e31551d2697d 100644
>> --- a/drivers/ptp/ptp_chardev.c
>> +++ b/drivers/ptp/ptp_chardev.c
>> @@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>>  	struct timestamp_event_queue *queue;
>>  	char debugfsname[32];
>>  
>> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
>> +		return -ERESTARTSYS;
>> +
>>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>>  	if (!queue)
>>  		return -EINVAL;
>> @@ -132,15 +135,20 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>>  	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
>>  				 &queue->dfs_bitmap);
>>  
>> +	mutex_unlock(&ptp->tsevq_mux);
>
>The lock doesn't need to be held so long here. Doing so causes a bit of
>an issue, actually, because the memory allocation for the queue can fail
>which will cause the function to return early without releasing the
>mutex.
>
>The lock only needs to be held for the list_add_tail() call.
>
>>  	return 0;
>>  }
>>  
>>  int ptp_release(struct posix_clock_context *pccontext)
>>  {
>>  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
>> +	struct ptp_clock *ptp =
>> +		container_of(pccontext->clk, struct ptp_clock, clock);
>>  	unsigned long flags;
>>  
>>  	if (queue) {
>> +		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
>> +			return -ERESTARTSYS;
>>  		debugfs_remove(queue->debugfs_instance);
>>  		pccontext->private_clkdata = NULL;
>>  		spin_lock_irqsave(&queue->lock, flags);
>> @@ -148,6 +156,7 @@ int ptp_release(struct posix_clock_context *pccontext)
>>  		spin_unlock_irqrestore(&queue->lock, flags);
>>  		bitmap_free(queue->mask);
>>  		kfree(queue);
>> +		mutex_unlock(&ptp->tsevq_mux);
>
>Similar to the above note, you don't want to hold the lock any longer
>than you must.
>
>While this patch looks to cover adding and removing items from the list,
>the code that iterates over the list isn't covered which can be
>problematic. If the list is modified while it is being iterated, the
>iterating code could chase an invalid pointer.
Thanks for your opinions, I will double check it.

Thanks,
edward


