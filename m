Return-Path: <netdev+bounces-304989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mnw0GmKsS2pMYQEAu9opvQ
	(envelope-from <netdev+bounces-304989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:23:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AB71136C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=q2yApZVs;
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304989-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304989-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E026530F332B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07AA417362;
	Mon,  6 Jul 2026 11:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89456414DE8;
	Mon,  6 Jul 2026 11:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337523; cv=none; b=gBeA56bJjx/Ag4n5NriGX9ailMBMLI499zsinynxkkgsWnfsM7ofnVhgaZzhCTk3YDqu9/XB8BExUIDH+4MJrlZdJ36Gsl9Rmr49wJ4Y5fikD54z5BCZiuOyu5YZ5ZRgo7yCGnKjikCakeM9CdkctqSP8bUl2Z7vfQQuLE0vSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337523; c=relaxed/simple;
	bh=BLYTU/FB02JaMt+a+NRBpjJbtGwQHXGUPpjml7VqeZQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GyhIylWVh+QHfaSRYGKg+j1vZD2F9mLkKknPkYUhrwTi5NvLa30PTXEIbrWRIGrXC/pifK6kQRpMkhyEksf3k30bM6hFeYX7jpaXshtuMK9UsIKxN5DByvveL7G7a3KKIjSOn9+xFAt7zfhiw7GmbBEb/HAQQiGknR3JaXpjFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q2yApZVs; arc=none smtp.client-ip=113.46.200.225
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T/ob3DPNtA2AANXo33FNblZ3kqyiNGk8sYmN47Kv6xQ=;
	b=q2yApZVsSaTwACej7DuIe47ztVE2QwyVXppO7aIhAc1MwY7D0/N/AWDGxjla8sUr+K5/XzNxC
	VdJBZsiCbAoQwaK4h+XpHNJJxgmFZ1qFpd4hLzWEE1H1/QTVKJqoqgsPzOb03uJjSzQp5T+JHNu
	HTnqix69dUijr7gIl1hxx2M=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gv25b1b0Mz1K9BV;
	Mon,  6 Jul 2026 19:22:43 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id CEE6E40565;
	Mon,  6 Jul 2026 19:31:54 +0800 (CST)
Received: from [10.174.177.15] (10.174.177.15) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 19:31:53 +0800
Message-ID: <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
Date: Mon, 6 Jul 2026 19:31:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>,
	<syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <stefanha@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kvm@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: <sgarzare@redhat.com>
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com>
 <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
 <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100016.china.huawei.com (7.202.194.10)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mawupeng1@huawei.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mawupeng1@huawei.com,m:syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:virtualization@lists.linux.dev,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:stefanha@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:sgarzare@redhat.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mawupeng1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,listbf7b8eeeb8dda31d6de1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B12AB71136C



On 周一 2026-7-6 17:24, Stefano Garzarella wrote:
> On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
>> On 周四 2026-6-25 04:32, syzbot wrote:
>>> Hello virt maintainers/developers,
>>>
>>> This is a 31-day syzbot report for the virt subsystem.
>>> All related reports/information can be found at:
>>> https://syzkaller.appspot.com/upstream/s/virt
>>>
>>> During the period, 0 new issues were detected and 0 were fixed.
>>> In total, 5 issues are still open and 61 have already been fixed.
>>> There are also 2 low-priority issues.
>>>
>>> Some of the still happening issues:
>>>
>>> Ref Crashes Repro Title
>>> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
>>>                   https://syzkaller.appspot.com/bug?extid=07dcf509f4c013e25dc5
>>> <2> 3       Yes   memory leak in __vsock_create (2)
>>>                   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>
>> Hi,
>>
>> This is regarding the still-open "memory leak in __vsock_create (2)"
>> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
>>   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>
>> I spent some time analyzing the root cause and the previous fix
>> attempt; below is a summary and a direction that tested out.
> 
> [...]
> 
>>
>> I'm not subscribed to follow the list at full volume; happy to send a
>> formal patch (with the af_vsock.h / pending_work changes folded in)
>> if the direction looks right to the maintainers.
> 
> Yes, please, a formal patch with a great commit message is much better
> than a long text to read IMO.

Thanks for replying.

As we conducted more thorough testing and further analysis of our own fix,
we found that it is not as comprehensive as the existing AI-generated fix
provided[1].

Could you please let us know if there are any issues with this AI-generated fix?

[1]: https://syzkaller.appspot.com/ai_job?id=cd978d21-2110-4f57-9525-d7d91c4a7e02

> 
> Thanks,
> Stefano
> 
> 


