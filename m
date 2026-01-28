Return-Path: <netdev+bounces-254088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN99CDx/eWmTxQEAu9opvQ
	(envelope-from <netdev+bounces-254088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:15:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2919C88B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F30A30055F0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184613093BC;
	Wed, 28 Jan 2026 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5FMIh8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AF61FFE
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570103; cv=none; b=EVTcn3odixNgl9DnndImoJ9MOk8KOmStAHCk74EC9IocisF504miBH4sSuD2xxL2KW/BGs7IkxoBJd4a7/vcew4FaWwMJqyckbZf7oXY1wochgstUlTrvrdwvrhpbFB99dU0VOA5ISOGBrEWCpfYBwowZLm8PY7tBMMpPHKGqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570103; c=relaxed/simple;
	bh=rDWYiobtTrvG4VPZFSoXQYOXyysSjXGFegV/GOl0DVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYPe6foCMd+wosY+CSRLylyryLBFZvLg36vXB1ruKrBy/187JupDJSS6AAWv5JwxmzFaFTKREAXNvgShU/3wa1p/rN8xZK0u7cZMN/Y23qIf3utdx5P6rc52LjvhEyfWx7pKlh6ku4cyB7pTALOPGu3DiBsrS2PBYupuy97tF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5FMIh8j; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b720e4dcb4so6833378eec.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769570101; x=1770174901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSi5Nr8W4u3aBcHrUiwp5H26M1F8rKoRGCzdgXjfJK0=;
        b=E5FMIh8j//zyiZJY9DhNxjpuBf4FddqQ2Dg26okwU5uFZcX6NeXlhW5eheEec8zSPN
         WFp2soWoFZKaA4zXhnTfJ7jUsC0/mWMMGE99j4Bw9dKwmxAoIQSVX/IzPhQHl2KCnaan
         0IT2z/Sp/bpnjjhNp2xGnY7u5b6UgfLym1/m2AfZkcLps/t4U71oBaezIcmsg6INGzox
         Qu/BbxZAwsf2eH9610dJKzSFFxHzyKfvufdpRdD3h6jCmPaHgL1CSOScwz2iHhihcTIV
         /5njv3AtXyqskkkbO869Ec32PISQHtf8zbZZ2s8XI9OxeUY7OdwE7vPYbBmSL008egob
         8Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570101; x=1770174901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSi5Nr8W4u3aBcHrUiwp5H26M1F8rKoRGCzdgXjfJK0=;
        b=aslCT1QE+FvL/ndoPxGpkJpaP7M9sVrezzDQO3k8QUG7mg/bnkhrYOJwvNnJB3w7yW
         uHi9FkKAHtLsImAJr2gKOQSO+QcUNPeVgz9MOpM4Wv4SYVLUhgWfQbli7Q2NqpRJp7pl
         8xN5wIqP5Ji03JH8DMgkgUDtMsBuxexy3dLXE1b46asGOc81gaIi5rlZFRJmoq8OjHph
         uyHb+yAmpuGt+yaxP0ebdAz2s1hGT1L8JhMRFInDJlpUYKvzJcJD95apWdT04JMCvF9E
         84IRf+HJkee+1psgFn/WTtLyZRi6s4qAHbF2OrzF6lv6GHicfurfq+uozZP3598KzBLn
         Akuw==
X-Forwarded-Encrypted: i=1; AJvYcCVnD3gJHg2agLX6yXkHND19LxxW3vz2qvqkDstQrci00HLcRsZEU4wtatgwlcURrl7ZB+79KXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOk60Lc2wJZC/LCsyT50qtepQY2ynmWoZviaQqU8EN57nPvczQ
	ghmoGPt8zEoMZKMD/kVtdGefCXY4uVGpoYwB4YugV0PqxtCXxDCGlFs=
X-Gm-Gg: AZuq6aJQyO3pcb/E2FcuSyCNXL7qRlsPD2s+NyYQ7a7EJizbnwzhKljnOhCcUUFKOKm
	UXbzByg9+UoiEAPwE/+TX4RFGNO1V0r1FfNhY7DCsNR5Yl4DpvfaLSojGJXjO8pYnMF2T8+fD6E
	uo8Z483jPAFCri5IhZucu5CR99itNBVMhtQSU+o5WMBMznQxVdAMZaPqEjNpeBScBhiVGqGtwzN
	JCOBIpNSXB+Agbt8YMV3dodhx+Haio5ljEeZp+euhFAVV2ozf+HdE1sP5cKQPDt4oPbVjB3OpCs
	FGT6zPoEvz+Qq9O/J/iNsugrNmSpkaDAjKvSJ/7YHoMMhlFLfJHXVs5WcqJ77GZeJs2gi63O/fx
	t+hANQkTdv+6JJe7t4I4gm66KFVNaWOujCWJMvRDF3pYRfb3oy/oo0TmiqhO8bb4TDBQVi7XfIC
	O+1ZV7YfEfhYanWZZKBmAbDXDSUERGYxTczw/iLtXH+MxjeNSbKagIqSE1QyZ20N+LYFOESTtHB
	SfSlQ==
X-Received: by 2002:a05:7300:dc14:b0:2a4:3592:c60b with SMTP id 5a478bee46e88-2b78d9fdb94mr2305844eec.28.1769570100638;
        Tue, 27 Jan 2026 19:15:00 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af8ac0sm866686eec.35.2026.01.27.19.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 19:15:00 -0800 (PST)
Date: Tue, 27 Jan 2026 19:14:59 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Network Development <netdev@vger.kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v2] team: avoid NETDEV_CHANGEMTU event when
 unregistering slave
Message-ID: <aXl_MwhS9AJXTYi4@mini-arch>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254088-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ffff88807dcf8618:email]
X-Rspamd-Queue-Id: 2F2919C88B
X-Rspamd-Action: no action

On 01/27, Tetsuo Handa wrote:
> syzbot is reporting
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
>   ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>        netdev_hold include/linux/netdevice.h:4429 [inline]
>        inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
>        inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
>        notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>        call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
>        netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
>        netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
>        dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
>        team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
>        team_del_slave drivers/net/team/team_core.c:1936 [inline]
>        team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
>        notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
>        call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
>        call_netdevice_notifiers net/core/dev.c:2295 [inline]
>        __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
>        do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
>        rtnl_changelink net/core/rtnetlink.c:3776 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
>        rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
>        rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
>        netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
> 
> problem. Ido Schimmel found steps to reproduce
> 
>   ip link add name team1 type team
>   ip link add name dummy1 mtu 1499 master team1 type dummy
>   ip netns add ns1
>   ip link set dev dummy1 netns ns1
>   ip -n ns1 link del dev dummy1

Can we add the above as a selftest to
tools/testing/selftests/net/rtnetlink.sh? I was adding the quirky ones
(like kci_test_macsec_vlan) over there.. Or maybe something under
selftests/drivers/net/team/ ?

