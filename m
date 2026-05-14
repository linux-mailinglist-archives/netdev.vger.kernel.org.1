Return-Path: <netdev+bounces-287962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLiPCvfLBWocbgIAu9opvQ
	(envelope-from <netdev+bounces-287962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445645423AE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3BD03021BBC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB13BB102;
	Thu, 14 May 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="extpvvTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E83845C0;
	Thu, 14 May 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764783; cv=none; b=KBjjUvMwPs9UwXLWHepOiDYpuUJoCGkPg5gH3UKpLj2+0kT0/Goo59vzVxiGL0rKySOUxaIN8veAy7jnxeDcYEhBZQLX0QmEclfc6ohw7/M7fMdtp5XupQSTv1Ex3OU6ZSDdX1d+so8ZHltsIzkI94lzY6JlLLzJmghRYb5iCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764783; c=relaxed/simple;
	bh=cso4Y6sCLkhbf1B61Ik5w8+k+8JdXMYqXvauXIpRLxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDSi1CWmYHnMJkJr8k1M+rk/9iUuxAgkMFFF0HGUkr5CfDxrhm6KIVBE9PnaG2BCmPy0CeOcxUSnAJ17EiUNpYoZMx1s631gk6jLPzW1VGWZ0RTJyLZnfu0yqX/1ctHvSLkK3udjUotwug9bsLBImaevat/sfbTesMP1MhZ4u58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=extpvvTC; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778764752;
	bh=jCHQ+edTvyF2tOiHXH4CFRe0RGXkEcyEIIk/ffK04QY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=extpvvTCsok7SeeRKSxzi9cgSU9IBzD11lrolHkFCgQFTi4pzh2yccfNxxgO2uAsw
	 9lgRyIBEDGIcPl52GBxtB1c8gRdm2sfnFY0Lejqm/lvoDU1WhpzBVONRJd532eMEei
	 zcZpo1fiUxR6+3HcC3eWYrhLOsJBoBD6CVVz9dyY=
X-QQ-mid: zesmtpgz8t1778764736ta82c5792
X-QQ-Originating-IP: szOAruv/Mcg9MvZDm929IM9PzQLdpAJYu+/NftWQ3lA=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 21:18:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17632782849712745212
EX-QQ-RecipientCnt: 14
From: Xu Rao <raoxu@uniontech.com>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	idosch@nvidia.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	raoxu@uniontech.com,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
	willemb@google.com
Subject: Re: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering devices
Date: Thu, 14 May 2026 21:18:54 +0800
Message-ID: <B2E03D908A12A79A+20260514131854.1752183-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <260a0064-0fa2-40cc-bb8c-1ee29f12dd1d@I-love.SAKURA.ne.jp>
References: <260a0064-0fa2-40cc-bb8c-1ee29f12dd1d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OaNPNQWBi+inSIyHYEQ2Sh+twqYtJKS+bLrFUi9ZoITrVOAn89p0i0My
	iLx9w1ACJQXDrdQx+28cs9+cH5BxoXgFutFQaboOTsR4br7dX2RSwABwJO6hxGahwNVyqRw
	ahUDyePbEZJJ85TgUSoWn4a8wjsdcBwhX1QU/LGxsff+JWM4HJfECLjYO57C76WaD15Y7jJ
	9kHrXFCImFxNoL+6tmSJlPaOyyv5u8uMJUr1uk96MuyjbnqAhGDKLTkrab2KJNpes8At6I+
	trTCb3TB+Vkd2ubRdcivpGzkExKkH/X+vxwtoznQ1XQlidJndF/ameLQGjfVeDACCQcjH2l
	Bojc9T3YGPWd21HF86oSwMRMC1MOVzgendxRy0l172FkvRdKolp2VZDCYj/8I4arjZ16cQh
	vSrOKFyVx5GoG5I3mxqTB742QQJYyVHaQgiUwylk7Lb/wy32nBVB5d0a8TOSF1a3CchvtB8
	wb2XF+T6EDZu3RLOPsNtvzSXJ8MZETlta9dLHwy8pKWoUYi5zFLfqnEgs+VsrFt9zjwz/gN
	WpF/GtdriCQOTtrtdgJ3uDATCF/uI8bPTrxykW2N7KJ3DAqqpTsOGTTceXXmHw91VSFokOg
	msRipOq83KrL7AoQhMTTbC1LycnhWsd/XdVQpbwNMSQRats2gzkGC4BsVk6qMHBPKboEk0i
	mcgGbqs1vV3xdVYIiSbh0pfGZs+CRNb2PMm5SoRUvknVwqYDG98qhzIn0fkQqoFVdm7VeMl
	kyWh3eYWhVh6sH0ytQMiEFSejJK/9Isd5u65lHtUialTI1vU8EGCppeqYjRKilKVE/r+NBs
	1H4Qfpko/FJtCHqceEi/sjUzWz5wjj9/8VTJud0S+rhBGDpai11wp4Lu8y/whlm66kwKPvy
	UBtXHTglN3DyVXKKP/5TxvXE19wGlC3zTbqEM0LU+2zyMuBXbtMs58WqP7lV+B+VM9gxMZW
	uKT+7NzCR1Appx4wRh0FIZHrue0zgLViSrPuAwCNPNnf8AVoTv8EAc/1vGyiBAUcZbFUB2n
	b5pGLgot07jShhhkkw2iX94fPlaSqHjJwFwDkgpwY/61rYvZwb82Y807hVxCs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 445645423AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287962-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

Hi Tetsuo,

> Will you test your patch with
>
> - if (dev->reg_state == NETREG_UNREGISTERING)
> - break;
> -
> + WARN_ON(dev->reg_state == NETREG_UNREGISTERING);
>
> and confirm that WARN_ON() fires, for nobody knows whether this refcount
> was obtained after dev->reg_state became NETREG_UNREGISTERING ?

> Please be aware that the stack traces that follow

I ran the additional syzbot tests on the same tree.

First, the proposed v2 patch did not reproduce the issue:

  commit:         5cbb61bf4168
  git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
  result:         OK
  console:        https://syzkaller.appspot.com/x/log.txt?x=147a20ec580000
  patch:          https://syzkaller.appspot.com/x/patch.diff?x=12255636580000

Second, I tested the diagnostic WARN_ON() patch suggested in this
thread.  That patch adds WARN_ON(dev->reg_state == NETREG_UNREGISTERING)
at the NETDEV_CHANGEMTU and NETDEV_UP/NETDEV_CHANGE paths.  syzbot also
reported OK for that diagnostic patch:

  commit:         5cbb61bf4168
  git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
  result:         OK
  console:        https://syzkaller.appspot.com/x/log.txt?x=10eae996580000
  patch:          https://syzkaller.appspot.com/x/patch.diff?x=1182da73980000

I checked the console log and did not find a WARN_ON() splat.

Finally, I ran the same tree without any patch, as a baseline.  That run
did reproduce the problem:

  commit:         5cbb61bf4168
  git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
  result:         report
  report:         https://syzkaller.appspot.com/x/report.txt?x=13f620ec580000
  console:        https://syzkaller.appspot.com/x/log.txt?x=15f620ec580000

So the no-patch baseline still triggers the leak in the same environment
where both the proposed patch and the WARN_ON() diagnostic patch returned
OK.

I agree that the WARN_ON() result does not prove the exact
NETREG_UNREGISTERING hypothesis, because it did not trigger.  I also do
not think this negative result is strong enough to disprove the race:
this bug is timing-sensitive, and even adding the reg_state load, branch
and WARN_ON() site can perturb the execution enough for a best-effort
syzbot run not to hit the same interleaving.

Thanks,
Xu Rao

