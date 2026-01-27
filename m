Return-Path: <netdev+bounces-253738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOe8HJ5reGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544890C56
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EABF63005159
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE532D0E7;
	Tue, 27 Jan 2026 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dSLfuDft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227D26D4DF
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499544; cv=none; b=V2n2KTknlHWWV10HHzXWW2ZsYk5GHj7K2lLB/xxNZ8eXpaA56c/RUi72qGEaUcicjLFEkhgsSNpplEP2+7TfECjl6JAG7N8qXyGwrtla8wLDGTIgqtM+0qFLv/6c1au1ofsfW7/AAiO/YJoOLoTNIVJyMfc10B+yW1lc5xJQT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499544; c=relaxed/simple;
	bh=NnfvhaNKr2OmRbeEL5EmAmYjxeBRpEZUEB1FxWjXWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVjdasCrRJBLnrVKfNzxtgR5N3cY4TzrQS4ntd7ksxv+3QdGGj3Zcphc2OIOww4xNuK/nvtYQ3EyQ43ltwcmt75fBxwkUm56zvpumss6X+2cTl8/Jj/EtUmxWt7Otkxn3HKHlwj6oRyZ8LyqZo1kFZYPbVeeykc046JzkI6KUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dSLfuDft; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359a316d89so3917047f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769499537; x=1770104337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyuTTNr2spFqmFV/zO2K68kfqAedtpsxTyfOseaQWng=;
        b=dSLfuDftazio6ZsXRP9TM9HBVKNo4sk05ODuv6rXZAjBqD66TIkxRr/85J4EPPvgwf
         lflXKNpwgHyfqnYZCed7hJeLxURuKYQ6WjHZwAFTjpLBKBXWcCtiA7HqVXhojmW0ymvX
         qNwik9yVSljqLEcPX+aPwercfiSs6XTK5ui1nZ8o2m3wPRmBxb9t9ghWObRqSWww+twJ
         8ZmJrMrrXfb16RQJo46M7GXEKss/MW0WSmb8dgP4NE94EHCeyVGrBlAALuHrTJKKYOmC
         xpvPH6jFZDLfw/CKUYGj+NTKS8zwcAhIS025+/Ed72JroLAMEm3RBAKRMGrCgIeslp+b
         f1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769499537; x=1770104337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyuTTNr2spFqmFV/zO2K68kfqAedtpsxTyfOseaQWng=;
        b=HyAYLs8VID6hHqfHiYygvMyWE5Z/GQ+sA78aKgE1FWMtlySlmpUrRLOt15bwUht3te
         Oo/OreKQjKI76zuf1UioDML+kq6qm95hjT5iN7Hg4t/L45ORbiGm0VRjDSViNHkoZvEC
         qdf+NUgAyZ1vKQJjdcgvPFrDowxJOHZMW05VaIYj+IwgvY7/qveQ0YqPjFhBUI0udyni
         url7Ui9OjwXTWKfYe/v5UW4BD27Fq/hwIq1vzfOAn/zC58/ehjBarU11vFnReIG8IRPK
         RFAGXqPtwuO1rF6kHMEvfoKRWupJMz3mV5Rtlbj4NGudGYfaJ84AHQgX3itPTgBCSsbY
         IQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ5xidG+YTD168m9OXZvmalpGpM0ct3j1tQVhrGI8hsWWnoDM28rjEfGDMCSs10B81F4J2Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Y1xPUYngUK4YF0Sv1Zsp9+cX4WOC6w3YmU3V8KInqXZau2ij
	yPADUybyUHm7Fds+SId2g7Z+bC/P/SHroRr2ugkbFJfzUVzXIAuRFylZw5bcaiMUccY=
X-Gm-Gg: AZuq6aItsFWmVt1sF47u+E91NdXBnDo+sFqcW6IN2UcJiwF8lEaP6H9fM3QtaunKXi+
	jdTR1XrXWs2rIhiXJEGAv0uGJDGUQ0Flba7nNvLlpLB8G10MQpjDNRJx+MRqrqwllM7+90NnJJ3
	gBrOPHRq9wM4+Zgi24HSlHKwtKLwkIp5TfbQBJAwIdMwTPkVfpm1zyf/Q1Y5GpYWTDU94lwMAa3
	cP5Qk+MR6JMmXhkaiY8lg16+IK2IhQQu3hn2CMlwpAcm2HVac/eDQoYqkmHoXePRQHUlayHhg0K
	ED9R98f4vGc5+GmecpdWog1/y0mJw3D+krntrsPsSyTQWnbr62UHK9Wwc7UiuO5EFpmugz6Q09i
	4LxjiQebN3ZpAbSqUcwwb1OrZEHmXGe9Y1t3kmjkGofSHz8ZLQHpitXFadHKyGICeuNjXW1dU1q
	ptX8p0Uftle2YS/y3rLVL55uE=
X-Received: by 2002:a05:6000:2483:b0:42f:b707:56dd with SMTP id ffacd0b85a97d-435dd1c1d4emr980421f8f.33.1769499537396;
        Mon, 26 Jan 2026 23:38:57 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71503sm40023764f8f.25.2026.01.26.23.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:38:56 -0800 (PST)
Date: Tue, 27 Jan 2026 08:38:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Ido Schimmel <idosch@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] team: avoid NETDEV_CHANGEMTU event when unregistering
 slave
Message-ID: <4mtehfz7kbb7xcygrcb4rbmmy7clr7qomnrd3wv6byfd7muwf2@5qgpxozmi3ja>
References: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
 <20260125085835.GA54633@shredder>
 <29ffd5ac-07b1-4424-ad3f-8304a28d2946@I-love.SAKURA.ne.jp>
 <20260125121551.GA83275@shredder>
 <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece4365f-906c-44e2-80c9-ab73f91f7fb5@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-253738-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5544890C56
X-Rspamd-Action: no action

Sun, Jan 25, 2026 at 03:35:28PM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>syzbot is reporting
>
>  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
>  ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
>       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>       netdev_hold include/linux/netdevice.h:4429 [inline]
>       inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
>       inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
>       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>       call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
>       netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
>       netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
>       dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
>       team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
>       team_del_slave drivers/net/team/team_core.c:1936 [inline]
>       team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
>       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>       call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
>       call_netdevice_notifiers net/core/dev.c:2295 [inline]
>       __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
>       do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
>       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
>       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
>       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
>       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
>
>problem. Ido Schimmel found steps to reproduce
>
>  ip link add name team1 type team
>  ip link add name dummy1 mtu 1499 master team1 type dummy
>  ip netns add ns1
>  ip link set dev dummy1 netns ns1
>  ip -n ns1 link del dev dummy1
>
>and also found that the same issue was fixed in the bond driver in
>commit f51048c3e07b ("bonding: avoid NETDEV_CHANGEMTU event when
>unregistering slave").
>
>Let's do similar thing for the team driver, with commit ad7c7b2172c3 ("net:
>hold netdev instance lock during sysfs operations") and commit 303a8487a657
>("net: s/__dev_set_mtu/__netif_set_mtu/") also applied.
>
>Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
>Suggested-by: Ido Schimmel <idosch@nvidia.com>
>Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

