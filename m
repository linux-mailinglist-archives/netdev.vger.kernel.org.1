Return-Path: <netdev+bounces-271820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DN7DfeoxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:33:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597232EDBA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DE2C3026D1D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139253932F0;
	Thu, 26 Mar 2026 03:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC8145355
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495987; cv=none; b=EXyJl7gItWVQ9DPzbccK/6K7+smgL0XEaUFxuZKZCSdrLr9bwmouU0x57Ef61jDPE5DSys28i2kdgaCYP/V4kQ7+7FYC5yRNxZYr6hFHiWrfndBXibvZOArnOV6DgibDbDNs6gIoH3xsApCTuIdJQUO53YC9DXcULhX6vmKHMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495987; c=relaxed/simple;
	bh=eTCp09iLw0CHxdDHmjC11mAWm6yDOvXu/pyfsvdgl+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS8LS14yFLA5j41dTmCqPLJB5psiA97GJxTwH48OArBX6fWZcgfWylRhMsJxck4hXr8gFzukjrWxRxv2mKJgNWY/bJOQr+nzkb1DbbCNkBKhslTsAxd2MkV5vqTPzLlqiROkDMZw+K14pKLEP7xeVHqlG7J1cZnK55JGPBU817A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62Q3Wmok020868;
	Thu, 26 Mar 2026 12:32:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62Q3WmS3020865
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Mar 2026 12:32:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2891dd1c-5c74-4ee3-bcff-64a42211593f@I-love.SAKURA.ne.jp>
Date: Thu, 26 Mar 2026 12:32:47 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can networking trees carry temporary patches?
To: Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>
References: <e0c7030b-261c-4ed1-b6b0-bf3b83a41d60@I-love.SAKURA.ne.jp>
 <20260325192214.133ffaaf@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260325192214.133ffaaf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271820-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: 4597232EDBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/03/26 11:22, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 19:55:18 +0900 Tetsuo Handa wrote:
>> I was carrying debug printk() patches [1][2] in linux-next tree via my tree
>> in order to debug "unregister_netdevice: waiting for DEV to become free"
>> problem [3].
>>
>> While these patches had been a lot helpful, now that easily reproducible cases
>> has been fixed, this problem is hardly reproduced in linux-next tree recently;
>> giving me no hints for debugging remaining cases. However, this problem is still
>> reproduced in networking trees.
>>
>> Therefore, I appreciate if networking trees can carry temporary patches
>> (patches which are not intended to be merged into the linux.git tree).
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=58b4f8f612187b0d9583b5549044734ecd7071eb
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=02fb7fbf5db47bf5c1736b692888232f5f6bf80e
>> [3] https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> 
> Have you see netdev_hold() / netdev_put() ?

Of course. I made these patches because netdev_hold() / netdev_put() are not
sufficient for debugging. There are many reports which contains only
"unregister_netdevice: waiting for DEV to become free" line.


