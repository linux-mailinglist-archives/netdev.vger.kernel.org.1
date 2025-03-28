Return-Path: <netdev+bounces-178134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C3A74D9A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8715A189CAD6
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A91C860C;
	Fri, 28 Mar 2025 15:18:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61263171092;
	Fri, 28 Mar 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175102; cv=none; b=pNqqQa4N4bVT2A+NeLIEpC9RMpZxwDE98UVjNbh+FJhTakIYQjJ94yZIaanXE0idZyny+fNSDNzlXZQVFuDBS2ZLKNkVlNqo/+nmISNSUbSUalAqBn/o6uVvyP15SPy2aTZIM01Clol9nmM0KM7LtFPolaFYrhwt/rvdT0QnJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175102; c=relaxed/simple;
	bh=I2diJ459zHAbnnXSfI/pe1+iVztBYA6fJv1PmJ0w2F0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=jke+AZEUXe555Fm+FbJ5TdhIQOfyWDW9dqfMPjB0uo57teAVaIhuFO9ynq82tE2JKUZhyymuTw1l2kwhGFj2gqSN8LDrp0o7YDthE/+8jiYKWx2yeagHV/uyIN7Yj/EML5aGY4Tu5jqK8L4jRJw7tGj/7MngguOvwyFNvcFsTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:38962)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tyAXL-000vaD-9v; Fri, 28 Mar 2025 08:18:19 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:32850 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tyAXK-00AuMC-5N; Fri, 28 Mar 2025 08:18:18 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <i.abramov@mt-integration.ru>,  <aleksander.lobakin@intel.com>,
  <davem@davemloft.net>,  <edumazet@google.com>,  <horms@kernel.org>,
  <jdamato@fastly.com>,  <kuba@kernel.org>,  <leitao@debian.org>,
  <linux-kernel@vger.kernel.org>,  <lvc-project@linuxtesting.org>,
  <netdev@vger.kernel.org>,  <pabeni@redhat.com>,
  <syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com>
References: <20250328011302.743860-1-i.abramov@mt-integration.ru>
	<20250328022204.12804-1-kuniyu@amazon.com>
Date: Fri, 28 Mar 2025 09:17:42 -0500
In-Reply-To: <20250328022204.12804-1-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Thu, 27 Mar 2025 19:15:00 -0700")
Message-ID: <875xjtb5o9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tyAXK-00AuMC-5N;;;mid=<875xjtb5o9.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18L2PoLqjUlh8oy7IsTTArm4NLnXlSHfRs=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4810]
	*  0.7 XMSubLong Long Subject
	*  1.0 XMSlimDrugH Weight loss drug headers
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kuniyuki Iwashima <kuniyu@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 411 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 9 (2.2%), b_tie_ro: 8 (1.9%), parse: 0.89 (0.2%),
	extract_message_metadata: 12 (3.0%), get_uri_detail_list: 1.35 (0.3%),
	tests_pri_-2000: 24 (5.9%), tests_pri_-1000: 2.6 (0.6%),
	tests_pri_-950: 1.26 (0.3%), tests_pri_-900: 1.01 (0.2%),
	tests_pri_-90: 101 (24.5%), check_bayes: 99 (24.0%), b_tokenize: 7
	(1.7%), b_tok_get_all: 7 (1.8%), b_comp_prob: 2.5 (0.6%),
	b_tok_touch_all: 78 (18.9%), b_finish: 0.96 (0.2%), tests_pri_0: 245
	(59.5%), check_dkim_signature: 0.75 (0.2%), check_dkim_adsp: 3.4
	(0.8%), poll_dns_idle: 1.29 (0.3%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in
 __dev_change_net_namespace()
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com, pabeni@redhat.com, netdev@vger.kernel.org, lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org, leitao@debian.org, kuba@kernel.org, jdamato@fastly.com, horms@kernel.org, edumazet@google.com, davem@davemloft.net, aleksander.lobakin@intel.com, i.abramov@mt-integration.ru, kuniyu@amazon.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

>> Subject: [PATCH] net: Avoid calling WARN_ON() on -ENOMEM in __dev_change_net_namespace()
>
> s/__dev_change_net_namespace/netif_change_net_namespace/
>
> Also, please specify the target tree: [PATCH v2 net]
>
>
> From: Ivan Abramov <i.abramov@mt-integration.ru>
> Date: Fri, 28 Mar 2025 04:12:57 +0300
>> It's pointless to call WARN_ON() in case of an allocation failure in
>> device_rename(), since it only leads to useless splats caused by deliberate
>> fault injections, so avoid it.

No.  It is not pointless.  The WARN_ON is there because the code can not
rollback if device_rename fails in
__dev_change_net_namespace/netif_change_net_namespace.

If device_rename fails it means that the kernel's device tree
are inconsistent with the actual network devices.

If anything we need a way to guarantee that the device_rename will
succeed, so that all of the parts that may fail may be performed
before we commit ourselves by notifying userspace that the device
is being renamed.

As for Breno Leitao <leitao@debian.org>'s question should we fail
immediately.  That will put us in a far worse state.

As I recall the WARN_ON exists there because someone at the last minute
stuffed network devices into sysfs, and no one has taken the time to
handle the practically impossible case of a device_rename failure.

If you are going to do something with this logic please figure out how
to handle a failure instead just shutting up the error message that
let's you know something bad is wrong in the kernel.

Eric


