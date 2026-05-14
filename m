Return-Path: <netdev+bounces-287883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AGUJhiaBWqJYwIAu9opvQ
	(envelope-from <netdev+bounces-287883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EA653FF94
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12526302411E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E13ADB8F;
	Thu, 14 May 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gfcL+qfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A335E529;
	Thu, 14 May 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751909; cv=none; b=BZM7BU7Sy8+n62A4/CemlJJph+uNifeVbW5rZ1tWYyOl/HluulbYtWd38mTWUIspOtkOAg7wPCu2tLoem5kPKQB/yDZYqtsvauPbPDQiIk/qeWje66+EuBObh3UHzeRLfhYNkyGUzDj75vUmnX0Q8UFkCH6B2e4F3d0w8m2B7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751909; c=relaxed/simple;
	bh=6R6H6lzmBrj1FVCMIqwJDCwFNEbTa/JRPrHEsL6rJkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA5ToUTgyh+gTy8RPbZysOtgcxppORSVvZdVKT/ow0jEF/nNKh6u7LD+Mdq7mp4sh9/w5znzx0g0i/qWbG62PcgLNf0nC3/EqjERlTT58WPMsGZQa0mljrL6gY5aqiKzXr7g7hpqEcnn34OaFWKVt1BmVMvb+4IQ4yp4tT2jhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gfcL+qfU; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778751895;
	bh=bUkOYv+xdQqslTPCYeG2m2MwzmalrbJ+MB0cr5TCMME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gfcL+qfUvMIYXARxVagY5RoLRo41dakVNCzgJHe0zm4db2NX+pAaca/IQXbQOKhOO
	 J84CfELDW1zfFSef/JzSQGw9zzfJrFmnVC15YhtaCq0C5cJZOV1xvpqB0KRsIfKzNQ
	 nRnJflN/KHgfijKVLSal3uM2LkQ5IZAIvY4O4FAk=
X-QQ-mid: zesmtpsz9t1778751881t10bacff5
X-QQ-Originating-IP: 76wr0ZChEcTJMOtxswo+SVUpq+DtfnDY+5hXNjLAp5E=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 17:44:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1662633885266725282
EX-QQ-RecipientCnt: 13
From: Xu Rao <raoxu@uniontech.com>
To: idosch@nvidia.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	raoxu@uniontech.com,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
	willemb@google.com
Subject: Re: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering devices
Date: Thu, 14 May 2026 17:44:12 +0800
Message-ID: <16DB33EB3B04B258+20260514094412.1497787-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513073031.GA344043@shredder>
References: <20260513073031.GA344043@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NFQMG86uACrUl5CHwzwg0SBS+2daVpq5ImR3AGQUNdjiW3KPc43jFehF
	IXPhYP4wvif1UhKE7obHNyC9uxezSyaZ3Cezc2E2IHpJYjfmHuus28BmbzIv6rKfWB60CoT
	YLYcu7a/0kzUEuOx2/PRhxOX8SmqwZsfJHHGsig0Yi8D1xIPtnX9d3ahjN6FdC2x+/1fAH8
	25txtvuZmEi2ScTPZyuxnJYQiMScVpnUuCE001umpffiaZ3dBMl3jbB2uPu42+Be/tZyEc6
	yvr/4cCTAH2Zj4PHQSZBCSA7XRaKMACj0eFuMxUOVWjw1iZM2PqiRls73ImXhiBEUgmUsLl
	fBcrbX/rKg1OIaAX21hG1mqljipBCjSKZhtvGEIN0C46qoPTTi57glAyAy+kBdvPViE/mqr
	PMlnOew/CzIFEL4Pyqe7a1a/NfLOR0F0NY2NG4Q7T57BD7Aa2mHf9KGdl4Z5tBJ7Bhh5RGM
	tG3m51ICUNxuCPazCGu4ra4+gLwBsxTBmD2U5mKlecrUfr+ipFhgZyHVjKj8cK3G9MtN044
	AuWBDJ209W5auVakHpREE5lxjE/6rp0W4z2mewXM3RyjXGhpZhn8RT5U8buMfcOSTGIoDYl
	8IuAtCH91R0En9PU6vcvg9XL5U+yO6PKUTdiVcdF4tOlu9UTlLHebIC60L5lInX651lJY8T
	krixy+6LNbj5bJVLISmwqIe+dRSvMnr1B9cLI+xLG9tmvn7Eu6zBctr3yJ563rln6DREMKP
	PzK1LvlS2kOynMRKt7Hre2MuojdrIR9jz4F7CMk/w1gF5LP0cdy9TmCd3GlBXykchZR1wQY
	qtcYUjJ2uzqaNO5Ze/f+yEQPtlcGrsDALa8o51Ck3hW9/n8/7Dct/6ZVrgygKaMDqC8/vSS
	4RVfDdLqy1jO50sq3ExzXb4+xynQpg+jypugeULl2+FpAIaM0OvqiDMHhsj99Fv3KE4dFTr
	qK5VFijnUEsyVGl2du6zyEyh7fNP9r79s8ZvuzNZ/GK9lcSLC3KewPQ+bq4zUtD/yntJ3aR
	Q3nJBmogdDZpSBfIQ9TvxM52HEZDQYT5iOoT3f81c1RcAa32/Z
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: F3EA653FF94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287883-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hi Ido,

> > The leaked reference is held by an IPv6 local route created from
> > addrconf.  A late NETDEV_CHANGE notification can still reach
> > addrconf_notify() after the device has entered NETREG_UNREGISTERING.
> > The handler can then run automatic address configuration, add a
> > link-local address and install its host route after unregister teardown
> > has already started.  The route nexthop takes a netdev reference in
> > fib6_nh_init(), and there might not be a later ifdown pass to remove
> > the newly created address and route.
>
> Do you have a reproducer?

The reproducer is the syz repro from the syzbot report:

https://syzkaller.appspot.com/x/repro.syz?x=103f3dba580000

I don't have a standalone C reproducer. I asked syzbot to test the patch
against the original report tree:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

The reproducer did not trigger the issue with this patch applied:

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Tested-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com

Tested on:

commit:         5cbb61bf arm64/fpsimd: ptrace: zero target's fpsimd_st..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=147a20ec580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
dashboard link: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12255636580000

> The kernel repeatedly sends NETDEV_UNREGISTER notifications when it's
> waiting for the reference count to drop.

Yes, and this patch intentionally keeps NETDEV_DOWN and NETDEV_UNREGISTER
handling unchanged so addrconf_ifdown() can still remove existing IPv6
state during teardown.

The guard only affects the MTU / UP / CHANGE paths. The problem I was
trying to avoid is creating new IPv6 state once the device is already in
NETREG_UNREGISTERING. In the syzbot trace, addrconf_notify() is reached
from a NETDEV_CHANGE path and then creates a link-local address and its
route while unregister is already in progress. The route then holds a
netdev reference via fib6_nh_init().

So the patch does not rely on suppressing unregister processing; it only
prevents late autoconf from adding new state during unregister.

Thanks,
Xu Rao

