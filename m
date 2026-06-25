Return-Path: <netdev+bounces-301946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFEgNbETPWrHwggAu9opvQ
	(envelope-from <netdev+bounces-301946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:40:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8516C5338
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=K1fCw4Xo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301946-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301946-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312B53058891
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA23DC84C;
	Thu, 25 Jun 2026 11:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7883CDBD3
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:37:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387473; cv=none; b=uJX/U56bdpJ3dXwSpYB/fUKD7nT6ya2DZH0HJ8lpV7IEA0bY+gq1Qo+abLQX0hbjIqMuWJBtYecWvdKkuiw4FaiSyyxuLYgJjt/J52xS+8bteDSsnqDfvWAJVQRgRLdYD4JjpUNYTUZZgiCnHabvG+AbZvPe17te2exCxv79RAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387473; c=relaxed/simple;
	bh=cF8ABWT+HMyamWTf0qy0N9g3VZHpF7rJcGUwn8QT1es=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p30x0FFMNgmTz2aACdI9fNhLmZyevbBEiJI83unjPohCW2OQbkWsQLir5HUizU1VzRC9ahN1Ayx2CBqNm1rECTzMqbZxzLADG+9VdR9WgFUmXMM4v7I0qk22L8oIf9AbvJ9j2U51P63ZpZN3m0m6zX3zwJB5tUELYAKyieX0FOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=K1fCw4Xo; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3680FA3ED1;
	Thu, 25 Jun 2026 13:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782387460; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3PsuiJMX7K0gsO2erZaFsQtKtSASmz0tXod/eQxJiNA=;
	b=K1fCw4XoVm3oQCCSsns1TpAbGjNOfeGyoNBziKlyQKKP8jHItPc+ppMXf5WDBG6z4vQbbe
	g6KItTkbr+igQeQr2IfR5iHpmPBMlX3H/MqMsHvCOwkqwEP7xj6GL7UEcVMy0r3O2xSJsd
	+xKahdP3opVG/BDwpJF7MOVnpMToQxVGpxJOjXzsDvcZ59ol3L1F4rbe/pEPqgQgvgPJGM
	1VeBz/rEf15oMgq3yZPlims2NOjyDzOgJXfMpGb2j4Su1ZSggFOW27+x5h/ny2qWHA9Dxs
	paPK3wz1ok4Y5B9ZAGNxqT4x/nsS4+yLVP5eR8bAYmr7t98f6UHZuPHlHpLNfg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 13:37:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jv@jvosburgh.net, sdf@fomichev.me, dongchenchen2@huawei.com,
 idosch@nvidia.com, n05ec@lzu.edu.cn, yuantan098@gmail.com,
 kuniyu@google.com, aleksandr.loktionov@intel.com, dtatulea@nvidia.com,
 syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,
 syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,
 syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Subject: Re: [PATCH net 3/4] vlan: defer real device state propagation to
 netdev_work
In-Reply-To: <20260624182018.2445732-4-kuba@kernel.org>
References: <20260624182018.2445732-1-kuba@kernel.org>
 <20260624182018.2445732-4-kuba@kernel.org>
Message-ID: <dd271c70bbcdedf79940e013523451b7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jv@jvosburgh.net,m:sdf@fomichev.me,m:dongchenchen2@huawei.com,m:idosch@nvidia.com,m:n05ec@lzu.edu.cn,m:yuantan098@gmail.com,m:kuniyu@google.com,m:aleksandr.loktionov@intel.com,m:dtatulea@nvidia.com,m:syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,m:syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,m:syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-301946-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,jvosburgh.net,fomichev.me,huawei.com,nvidia.com,lzu.edu.cn,gmail.com,intel.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,09da62a8b78959ceb8bb,cb67c392b0b8f0fd0fc1,9bb8bd77f3966641f298];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C8516C5338

On 24.6.2026 20:20, Jakub Kicinski wrote:
> vlan_device_event() generates nested UP/DOWN, MTU and feature
> change events. It executes an event for the VLAN device directly
> from the notifier - while the locks of the lower device are held.
> 
> This causes deadlocks, for example:
> 
>   bond    (3) bond_update_speed_duplex(vlan)
>     |           ^                v
>   vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
>     |           ^                v
>   dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()
> 
> The dummy device is ops locked, vlan creates a nested event (2),
> then bond wants to ask vlan for link state (3). bond uses the
> "I'm already holding the instance lock" flavor of API. But in
> this case the lock held refers to vlan itself. We hit vlan's
> link settings trampoline (4) and call __ethtool_get_link_ksettings()
> which tries to lock dummy. Deadlock. There's no clean way for us
> to tell the vlan_ethtool_get_link_ksettings() that the caller
> is already in lower device's critical section.
> 
> Defer the propagation to the per-netdev work facility instead:
> the notifier only schedules netdev_work_sched(vlandev, VLAN_WORK_*),
> and ndo_work (vlan_dev_work) applies the change later. Hopefully
> nobody expects the VLAN state changes to be instantaneous.
> 
> If someone does expect the changes to be instantaneous we will
> have to do the same thing Stan did for rx_mode and "strategically"
> place sync calls, to make sure such delayed works are executed
> after we drop the ops lock but before we drop rtnl_lock.
> 
> Stan suggests that if we need that down the line we may
> consider reshaping the mechanism into "async notifications".
> AFAICT only vlan does this sort of netdev open chaining,
> so as a first try I think that sticking the complexity into
> the vlan code makes sense.
> 
> One corner case is that we need to cancel the event if user
> explicitly changes the state before work could run. Consider
> the following operations with vlan0 on top of dummy0:
> 
>   ip link set dev dummy0 up    # queues work to up vlan0
>   ip link set dev vlan0 down   # user explicitly downs the vlan
>   ndo_work                     # acts on the stale event
> 
> Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com
> Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com
> Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
> Fixes: 9f275c2e9020 ("net: ethtool: make sure 
> __ethtool_get_link_ksettings() is ops-locked")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

