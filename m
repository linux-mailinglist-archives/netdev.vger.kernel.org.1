Return-Path: <netdev+bounces-266396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPWrFby7sGlXmgIAu9opvQ
	(envelope-from <netdev+bounces-266396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:47:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59625A24D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7416C3058E3C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809036894D;
	Wed, 11 Mar 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWTIu7B5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFB367F49
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190073; cv=none; b=iN8eKW9ZmRb1Jk2anDoZpE7yd30XqFCAQ1pfPOUgRqCDqo6lOFRbHa1MwgrNL14VvMFQR/cRQORYZOFe9C0h9lud3Mw9LI8TMwucwABdNFQ3AqjMI64jYv9MLnORxhXXO/wMxeYDfRE0kvBYc2QVZvRo28tH8EQ4VTAuXaQ3sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190073; c=relaxed/simple;
	bh=0NOikj0F4XRAl27fF0T51r1cDQUQLoSd+Y7hpcI8wOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMuj0Ac5GN+L3uy/KMFkqgFJmpDv53EtS6pwrbE86C4rr4/WlNU0VPwezGkq/EhvGzC1uRUE8BV18/PuA3jLPvXQy3D8gVv9UnO9NqnYR3pUfwxt0VEpJ/JVnVgsnnZg8XXvHtf7nT2xPqD6cDW+AfUd1Z0D/aPfvJdR5kTgtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWTIu7B5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bde0f62464cso5178322a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773190072; x=1773794872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D87ZdyQZ4IabAndi5c77q4G/EVeuF8jpmWClRpdBIok=;
        b=LWTIu7B5OoWEORAT/02hO5BHbXHKQOCYLsuU3xobAkU4SponXkdaOPupVcWtTPaXpd
         y4N2k3tJNFeWPDrnkWmXMOp2l1JlyXTZW+8xbDTnyxesys84LPXwpHcFl06eNkLQE4ok
         QNy2JeKSL90VcTjYaUj1fuBoejEFjDXsQsE5+dZY82COwwVwxnCC1KfCL6bCdKmUxWD/
         IRe7FgMf+QR5tW/zzVoo7Nz3TnD148G5T5vW/nDw+4bKnXhurGx0SKxiwrJwn0mTRQLk
         UMgPIwCvA+yfyZeLuf9xBIPSCA/cUw9iYgmc4f338S2QaHsLaTwd8Qdct9qaWFDZRzfW
         tuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773190072; x=1773794872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D87ZdyQZ4IabAndi5c77q4G/EVeuF8jpmWClRpdBIok=;
        b=SJdrA+T4L6CA97zSJ811qw+cRAm9BP4Gc9WziTpz38cxpmSMFLiPJvnvb4z/6dNCye
         XpnB2UeGQ7uhnhWUIt4BLP8CVDieHWk949+NJjrljVKPbzGmBX7H1hodVCbPYybZAShK
         O9wteMobPeR5f+OC9G/MlW5oh6EHFR+U4f0id2VGMYtsBWmDlc3uoWzYe5zMhDkDtGP1
         gExJLau0hEWiAs0DdqFe42ULugI83fcCSmbETNojQncF/YOnA/m6ox2dijAifiqG7aLQ
         NBVBqYw4SBpQU8l6tudmAryMfzEXKWzbdPyF8e0Hx7Vy8CT3UVaPtG7DnD/4wm3PHA1G
         hK2g==
X-Forwarded-Encrypted: i=1; AJvYcCWOEU3UVmzFTKCNA9Yb0cbXyoaVwWqr8XpdkKaBEr8umXp1cQD7bIHWkEhSTx3MK8CJdaY3qME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJNxFYxPAEH/3sdoZg/RY3aeCAGL+bSCJO8nnkzTYSJ0zOjuh
	9pRVsglA3ykTqokoMoMMU/7FrKXiHiSA01jJ7lwxfzk6cDNiNVtinL7Y
X-Gm-Gg: ATEYQzwGN8RZzWSjAiSLHcGAhNIHssQCJdtX3/4lNYkMo0jGyTpVAmi/leeJhnQb+2C
	C+6U8JZIyEgi45yovZUwoNdS13vqNmwY0VNs69MJ/Rtbxa0KQTxUyLbEy7omBj0iyFVEhf28SxZ
	hzcoDrPxqZrBJ6ioDzMmIqiEmGoBYI8j0dpT3Na2zBMqierbdiav7V6fu76t4aEVKLmae4C40fE
	vwmRLhKbaIqDGgOXT1aAFiYlJspEvPZbjb/DpKJ0AnH8egwcgWHi+Y9XUIiEBrL+AXpUmNMBfJv
	4o8i2eOtddHLSsJYnczvoP/u2R5aVsCO3rItXRnakmnEb3dhANwR8JrcRg2wxRrjKqqgRu8aESg
	llexjpxQmNEPIkv15P2c6lnDom19sxcOxaFpvFxwm8PXzpghapyUJFTT1FayOfQB3i9MRkderYn
	bAFtgc/lp6wlhCAIFgnoNrBcGHcJA=
X-Received: by 2002:a17:902:db06:b0:2ae:5005:a26e with SMTP id d9443c01a7336-2aeae78cb97mr7226095ad.2.1773190071971;
        Tue, 10 Mar 2026 17:47:51 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378974sm4231175ad.82.2026.03.10.17.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:47:51 -0700 (PDT)
Date: Wed, 11 Mar 2026 00:47:41 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
	andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
	jiri@resnulli.us, jv@jvosburgh.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, razor@blackwall.org, sridhar.samudrala@intel.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features
 to ndo_set_features
Message-ID: <abC7rdjxv9ENw-tA@fedora>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com>
 <abBuLV3P6aTzUg3W@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBuLV3P6aTzUg3W@krikkit>
X-Rspamd-Queue-Id: CD59625A24D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 08:17:01PM +0100, Sabrina Dubroca wrote:
> 2026-03-10, 10:02:09 -0700, syzbot ci wrote:
> > batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
> > hsr_slave_0: entered promiscuous mode
> > hsr_slave_1: entered promiscuous mode
> > ------------[ cut here ]------------
> > err == -EMSGSIZE
> > WARNING: net/core/rtnetlink.c:4421 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: syz-executor/6496
> 
> I'm not sure this one is caused by this series, but either way,


 rtnetlink_event+0x1b7/0x270
 notifier_call_chain+0x1be/0x400
 netdev_change_features+0x95/0xe0
 __netdev_upper_dev_link+0xb20/0xc80
 netdev_upper_dev_link+0xb0/0x100


This patch calls netdev_change_features() after __netdev_upper_dev_link(),
Which trigger a NETDEV_FEAT_CHANGE notify and calls rtmsg_ifinfo_event()
to fill the new link info. Maybe the event is a bit early and macsec has
data not ready?

Thanks
Hangbin

> reviewing if_nlmsg_size/rtnl_fill_ifinfo for mismatches is really
> unpleasant :/
> 
> Things I see in rtnl_fill_ifinfo but don't find in if_nlmsg_size:
>  - IFLA_PARENT_DEV_NAME
>  - IFLA_PARENT_DEV_BUS_NAME
>    (both from 00e77ed8e64d ("rtnetlink: add
>    IFLA_PARENT_[DEV|DEV_BUS]_NAME"), which doesn't include a change to
>    if_nlmsg_size)
>  - rtnl_link_slave_info_fill also outputs IFLA_INFO_SLAVE_KIND + the
>    IFLA_INFO_SLAVE_DATA nest, but rtnl_link_get_slave_info_data_size
>    only counts the nest, and its caller (rtnl_link_get_size) doesn't
>    have anything more about the slave info. This may be what syzbot is
>    tripping on here.
> 
> 
> But there's a
> 
>     + nla_total_size(4) /* IFLA_WEIGHT */
> 
> that doesn't get filled anywhere.
> 
> 
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6496 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > RIP: 0010:rtmsg_ifinfo_build_skb+0x218/0x260
> > Code: f6 ba 01 00 00 00 89 e9 e8 25 15 3a 00 4c 89 f0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 7f 3a 2e 02 cc e8 49 3b 42 f8 90 <0f> 0b 90 eb 90 89 d9 80 e1 07 fe c1 38 c1 0f 8c 95 fe ff ff 48 89
> > RSP: 0018:ffffc9000637e9a0 EFLAGS: 00010293
> > RAX: ffffffff89835e27 RBX: 0000000000000000 RCX: ffff8881b80a57c0
> > RDX: 0000000000000000 RSI: 00000000ffffffa6 RDI: 00000000ffffffa6
> > RBP: 00000000ffffffa6 R08: 0000000000000004 R09: 0000000000000004
> > R10: fffff52000c6fcdc R11: 0000000000000000 R12: 1ffff110235ddc21
> > R13: 0000000000000000 R14: ffff8881133dc780 R15: ffff88811aeee000
> > FS:  0000555557c4a500(0000) GS:ffff88818de65000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055555e1838c8 CR3: 0000000168b80000 CR4: 00000000000006f0
> > Call Trace:
> >  <TASK>
> >  rtnetlink_event+0x1b7/0x270
> >  notifier_call_chain+0x1be/0x400
> >  netdev_change_features+0x95/0xe0
> >  __netdev_upper_dev_link+0xb20/0xc80
> >  netdev_upper_dev_link+0xb0/0x100
> >  macsec_newlink+0xb11/0x1200
> >  rtnl_newlink_create+0x329/0xb70
> >  rtnl_newlink+0x1666/0x1be0
> 
> -- 
> Sabrina

