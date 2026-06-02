Return-Path: <netdev+bounces-294249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BYqRAXvkHmrtYgAAu9opvQ
	(envelope-from <netdev+bounces-294249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:11:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 544ED62F2CD
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=njI9CGiB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294249-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142BB301C3FF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF63E8665;
	Tue,  2 Jun 2026 14:03:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F913223DC6;
	Tue,  2 Jun 2026 14:03:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409024; cv=none; b=M1OOU5cVcxKUUo16rbyYVfVJCK4/pa7X0857nxCJNBfcCmBjDBD1y+OHLvaWB+e2XIUXcmtZ0MeO41nYAxb1pIuh/s+sjcdQOM/+hhzyffvzK8Pz2E/kzJ+jX0LK/Y7shv12PKtO//N0isrpXW18JAjPh+tj1gZNM/SOBCpl+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409024; c=relaxed/simple;
	bh=SJsTKp3UIReLNT2wF9nK0KalhCTuK35UU2f9TUqsEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGeobLToAs8EabTPt8HAdyM0+HAyKEZMTeymsPyXgxwSSTr+BtkZ1swviHqouzLcJ5Chq8H0mRFwOR/fQvGxARuq7rXQ3BGvH6uEtzfLqk4+fv6pHtbF92MCJapoaX/vxcahjHEAPGHkd52XysRrTLY3ZDjlVL0mfGlwBQ5Z7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=njI9CGiB; arc=none smtp.client-ip=115.124.30.132
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780409018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Nvf37ttJYqmi2dkqkEls2w7tX2JxLi4QoRnmtPx2/ZE=;
	b=njI9CGiBRnqdG8SdJQAjnW+nUutM/49n3scvxMMnGU3XifRPo92wD2OvG4NCeyGXO0jE/xfqgFjwfk2rmAn5KWm2ljIF5qNRrne8n7MqydZWp4meXGXSgRBvhnVvgBfhM2YKiHy2Rt91z4dG1DVgjJBT5FgzaPl8gi70YGLe660=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X44kgbj_1780409015;
Received: from 30.221.129.226(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X44kgbj_1780409015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 22:03:36 +0800
Message-ID: <335ae01a-20aa-439e-996c-d35ffd8d476a@linux.alibaba.com>
Date: Tue, 2 Jun 2026 22:03:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] MAINTAINERS: update PTP maintainer entries after
 directory split
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: tglx@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jstultz@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, daniel.lezcano@kernel.org, sboyd@kernel.org,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
References: <20260412084704.743482ad@kernel.org>
 <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
 <20260412095301.4fe1fe65@kernel.org>
 <ebf19246-91af-4887-b2aa-d9007921f7b2@linux.alibaba.com>
 <1088b07d760491deb461d6d01abca631e8f8d86c.camel@infradead.org>
 <ahzQZg_v4bxFfGdj@hoboy.vegasvil.org>
 <3908843460c4864eef79cced40d897f793c7ae2a.camel@infradead.org>
 <ah2jIt2DqI1ZZJx8@hoboy.vegasvil.org>
 <0e023f951c102fe2ee7070e490c579783b2817d5.camel@infradead.org>
 <20260601185226.7f43fa75@kernel.org> <ah5aGMIxA418sxoj@hoboy.vegasvil.org>
 <0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0b3f00bbfa6bcc3badb4d1bb7845326e2dbaa1d4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:kuba@kernel.org,m:tglx@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jstultz@google.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:daniel.lezcano@kernel.org,m:sboyd@kernel.org,m:vladimir.oltean@nxp.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:jonathan.lemon@gmail.com,m:vadim.fedorenko@linux.dev,m:yangbo.lu@nxp.com,m:svens@linux.ibm.com,m:nick.shi@broadcom.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:linux-fpga@vger.kernel.org,m:imx@lists.linux.dev,m:linux-s390@vger.kernel.org,m:dust.li@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:mani@kernel.org,m:imran.shaik@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:andrew@lunn.ch,m:jonathanlemon@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-294249-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,gmail.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 544ED62F2CD



On 2026/6/2 16:04, David Woodhouse wrote:
> On Mon, 2026-06-01 at 21:20 -0700, Richard Cochran wrote:
>>
>> Still, I don't understand why these new (non-network related ) device
>> drivers can't be implemented in their own class using
>> posix_clock_register()
>> etc.
>>
>> Any of the useful bits (like sysfs interfaces) can be refactored out
>> of ptp_clock.c and shared as a common layer.
> 
> The key is that userspace wants to get snapshots of the reference clock
> either precisely synchronized with the system clock where possible, or
> sandwiched as closely together as possible with ABA readings of the
> system, reference, system clock.
> 
> Those *are* the PTP_SYS_OFFSET* ioctls, which tools like chrony already
> support with 'refclock PHC /dev/ptp…'.
> 
> I'm not sure how factoring those out into separate POSIX AUX clocks
> would help? I think they do want to present as /dev/ptp*.
> 

I agree. Both [1] and [2] independently support the same point:
chrony's PHC refclock relies on ptp-specific ioctls (in sys_linux.c [3]),
not just clock_gettime(), so the ioctl interface needs to stay.
A posix_clock-based class wouldn't provide that.

[1] https://lore.kernel.org/netdev/2a4c9a00-45f5-4f6a-90c4-492ea1d50b79@linux.alibaba.com/
[2] https://lore.kernel.org/all/vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67/
[3] https://gitlab.com/chrony/chrony/-/blob/master/sys_linux.c

> There is some extra stuff we want to do for "Precision RTCs" or
> whatever we're going to call them. They might actually have a known TAI
> offset, they might convey leap second indications, we might want to set
> the kernel's CLOCK_REALTIME from them at boot. And in the case of
> VMClock, I'm working on being able to clamp the kernel's timekeeping to
> it directly².
> 
> So maybe what we want is linux/drivers/phc, to host those read-only
> devices which know real time. They can provide a simplified
> implementation; maybe *only* a function like vmclock_get_crosststamp(),
> which is just called in various different permutations by the various
> different PTP methods.
> 
> The core linux/drivers/phc code would then handle the interface to the
> kernel's core timekeeping *and* wrap them to register a PTP device that
> existing userspace can understand. And deal with the kvmclock/TSC
> awfulness where needed.
> 
> How does that sound?
> 

I think a dedicated phc core would make the classification of read-only
clocks clearer, reducing ambiguity around where they belong. I assume
direct timekeeping integration would be optional, drivers providing
only a snapshot-based crosststamp would use /dev/ptpX alone, while the
timekeeping path would require additional capability (as vmclock provides)?

> 
> ² https://lore.kernel.org/all/20260520135207.37826-9-dwmw2@infradead.org/
> 
> 
> 
> 
> 


