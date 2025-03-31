Return-Path: <netdev+bounces-178268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE7A7630F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B9F1885EFF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3E1D514E;
	Mon, 31 Mar 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="f/gyGRfj"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887518F5B;
	Mon, 31 Mar 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412627; cv=none; b=DDti0MmSh1egqNmb2xkZGpkKxj1fY3RLvNbmuEPgk5DtjsKX4RDqlRibDJhm8QREbqmxPbXD2uND4+QyHu88DL45UU0wCDk6wK/8GxPl1gpA9HlpnDj5u6MVyfvWF7VgMFVWG9Bnw6hMUrigWpJgmzctO/jXJNj8Lr0oivsYjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412627; c=relaxed/simple;
	bh=8kxyGR/ALBwR79HqLnezj+mUMnJfHNpRH1xsTTPiYwg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpDGa4YgDQMeKdkGMfvbDgO4usGZYRAytobkSjnNNZJ9yyLMUgpg2EuW1oGdVpWQoRHLZN45ltkCteRm2mNb2THMXcU+bzZqzVmqxWJBkUmRvn8iHk8oWJwVLZRcCKMdmhinIQm+zRCRUZ7oYNWDiGucW9V9FNEwxg1VbZHXuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=f/gyGRfj; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id 52E50C0003;
	Mon, 31 Mar 2025 12:16:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru 52E50C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743412613; bh=aa+0Ow3pdQVvuCdmcpUG2+fTL+6z0OP1WtnTcfFt9dA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=f/gyGRfjIYax9ZDP3V5GCHnvh+YGc+2705kZc3FEbgNN49uIgSjMnhjJOFb1jR/Ne
	 c1iZEc+G4uDNzg6ftcqvZp9NC9Y7vtVT4bdBUkdDBjA0puTtQyN57kqk11+UQMY5C5
	 X/EQK9j4j8TvkrfOVXJCB0rbhxH00tXdzxBiHOLZsjP47CAOQcY3YcNDQtInT9Wh1p
	 s2XCB43DLcjaGRa2QttfWFRJRrdStDSNG+uvLzALwP58QYFbdYeCyHiPYcqCm7e7Uy
	 spBfHN1pZ1P+wSGNlpVLI63zCLbVS8tLooZ+ky3iDu8vIKz2/odaBcIaB+1WeDZ2Wu
	 dFnvDwB7N1D9g==
Received: from ksmg01.maxima.ru (mail.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 12:16:53 +0300 (MSK)
Received: from ws-8313-abramov.mti-lab.com (172.25.5.19) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 31 Mar 2025 12:16:52 +0300
Date: Mon, 31 Mar 2025 12:17:07 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, <aleksander.lobakin@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jdamato@fastly.com>, <kuba@kernel.org>, <leitao@debian.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
Subject: Re: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in
 __dev_change_net_namespace()
Message-ID: <20250331121707.5fcc75e026c2f3d0233abcd5@mt-integration.ru>
In-Reply-To: <875xjtb5o9.fsf@email.froward.int.ebiederm.org>
References: <20250328011302.743860-1-i.abramov@mt-integration.ru>
	<20250328022204.12804-1-kuniyu@amazon.com>
	<875xjtb5o9.fsf@email.froward.int.ebiederm.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Prob_CN_TRASH_MAILERS}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;127.0.0.199:7.1.2;ksmg01.maxima.ru:7.1.1;mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192233 [Mar 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 40
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/03/31 06:14:00 #27842604
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

On Fri, 28 Mar 2025 09:17:42 -0500, Eric W. Biederman wrote:
> Kuniyuki Iwashima <kuniyu@amazon.com> writes:

>>> Subject: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in __dev_change_net_namespace()
>>
>> s/__dev_change_net_namespace/netif_change_net_namespace/
>>
>> Also, please specify the target tree: [PATCH v2 net]
>>
>>
>> From: Ivan Abramov <i.abramov@mt-integration.ru>
>> Date: Fri, 28 Mar 2025 04:12:57 +0300
>>> It's pointless to call WARN_ON() in case of an allocation failure in
>>> device_rename(), since it only leads to useless splats caused by deliberate
>>> fault injections, so avoid it.

> No.  It is not pointless.  The WARN_ON is there because the code can not
> rollback if device_rename fails in
> __dev_change_net_namespace/netif_change_net_namespace.

It's pointless in the sense that failure to allocate a few hundred bytes is
practically impossible and can only happen due to deliberate fault
injection during testing/fuzzing. The proposition is to avoid just that,
not to remove WARN_ON() altogether.

> If device_rename fails it means that the kernel's device tree
> are inconsistent with the actual network devices.

> If anything we need a way to guarantee that the device_rename will
> succeed, so that all of the parts that may fail may be performed
> before we commit ourselves by notifying userspace that the device
> is being renamed.
 
> As for Breno Leitao <leitao@debian.org>'s question should we fail
> immediately.  That will put us in a far worse state.

> As I recall the WARN_ON exists there because someone at the last minute
> stuffed network devices into sysfs, and no one has taken the time to
> handle the practically impossible case of a device_rename failure.

> If you are going to do something with this logic please figure out how
> to handle a failure instead just shutting up the error message that
> let's you know something bad is wrong in the kernel.

Although the issue of properly handling failure of device_rename deserves
a good thought and another patch/series, it's a much bigger problem to
solve, compared to what I try to achieve here.

> Eric

Thank you for detailed response! 

-- 
Ivan Abramov <i.abramov@mt-integration.ru>

