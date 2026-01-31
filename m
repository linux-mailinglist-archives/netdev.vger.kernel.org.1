Return-Path: <netdev+bounces-255368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bJo+O5mafWlvSwIAu9opvQ
	(envelope-from <netdev+bounces-255368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:00:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E998FC0E83
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F3273003D1E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2B2C21FE;
	Sat, 31 Jan 2026 06:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54072618
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769839254; cv=none; b=teNGoNgvuHdT4tWxmNdFmxnTUGdFASmujo6p6V/1AINR7ITu3XAJhqGiF2XOTfT7ZUS15SLzVbee11oW2HsG+RJsPe1MqAvf7woukASw9I4celQKzqSX0uYFyEtJvSIMa5hP28ALWhYpQXUDj79t7z1v4rPyyfnNpOS8vb/fU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769839254; c=relaxed/simple;
	bh=XFSqGcQf7wlZVW5B2uLPHbg7lW5PULw1g7x8Zd6FuU4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gh2eomRJwEAQ5ZoA0JSDyPE1IyFHrc6v650QN4efLO6C5NtBLJAP6hQ0GzTKKNmGmIVhXv4Tzn9bPUTqUUV2Vd7kmYWYcppUW/cleq3AlWUC4yMZ23DfqYHl4RdGCi8/4q7rnTlCVt7XCo6KsTRESJkmZxM1Qxu39EAw6hf66tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60V60mrC015045;
	Sat, 31 Jan 2026 15:00:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60V60mJZ015041
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 31 Jan 2026 15:00:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
Date: Sat, 31 Jan 2026 15:00:47 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-255368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,i-love.sakura.ne.jp:email,I-love.SAKURA.ne.jp:mid]
X-Rspamd-Queue-Id: E998FC0E83
X-Rspamd-Action: no action

On 2026/01/31 6:56, Paul Moore wrote:
> On Wed, Jan 28, 2026 at 5:28 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2026/01/28 6:59, Paul Moore wrote:
>>> It sounds like we either need to confirm that
>>> security_xfrm_{policy,state}_delete() is already present in all code
>>> paths that result in SPD/SAD deletions (in a place that can safely
>>> fail and return an error),
>>
>> Yes.
> 
> To clarify, do you mean "yes, I agree", or "yes, I've already checked
> this and can confirm that the LSM hooks are already being called"?

I mean "yes, I agree".

> 
>>>                            or we need to place
>>> xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
>>> safely fail.
>>
>> Did you mean xfrm_{policy,state}_flush_secctx_check() ?
> 
> They both call into the security_xfrm_policy_delete() LSM hook which
> is what I care about as that hook is what authorizes the operation.

I can't understand what your authorization is.
No authorization can be placed during must-not-fail operation.

For example, please consider the following sequence.

  mkdir /mnt/tmpfs
  unshare -m
  mount -t tmpfs none /mnt/tmpfs
  touch /mnt/tmpfs/file1
  mkdir /mnt/tmpfs/dir1
  exit

Although there are LSM hooks for deleting a file/directory and LSM hook for
unmounting, no LSM hook is called before deleting file1, deleting dir1,
and unmounting /mnt/tmpfs because operations that happen during tear-down of
a namespace must not fail.

What "[PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()" is doing
is the same thing for a network device. NETDEV_UNREGISTER is a must-not-fail
operation that happens during tear-down of a network device. LSM hooks are not
allowed to veto must-not-fail operations.

> 
>> Regarding xfrm_policy_flush() as an example, we can observe that we are
>> calling LSM hooks for must-not-fail callers ...
> 
> We need to make sure the LSM hooks are being called to authorize the
> removal of SPD and SAD entries.  If you are going to remove LSM hooks
> from the existing code, please document how that code path you are
> changing is still subject to authorization by the LSM hooks or explain
> in great detail how that authorization is not necessary.

Again, LSM hooks are not allowed to veto operations that happen during
NETDEV_UNREGISTER event. Current XFRM code for NETDEV_UNREGISTER event is broken
because the behavior is

  while (security_xfrm_state_delete() != 0) {
    schedule_timeout_uninterruptible(10 * HZ);
    pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
             dev->name, netdev_refcnt_read(dev));
  }
  while (security_xfrm_policy_delete() != 0) {
    schedule_timeout_uninterruptible(10 * HZ);
    pr_emerg("unregister_netdevice: waiting for %s to become free. Usage count = %d\n",
             dev->name, netdev_refcnt_read(dev));
  }

which is a denial-of-service kernel bug.

No room for debating "authorize the removal of SPD and SAD entries".
This path is a must-not-fail operation. Removal of SPD and SAD entries has to be done
without authorization when NETDEV_UNREGISTER event fired.

Though, you could argue whether removal of SPD and SAD entries is really what they want
when NETDEV_DOWN event fired. I don't know what the authors of commit d77e38e612a0
("xfrm: Add an IPsec hardware offloading API") are expecting because deleted entries
are not automatically revived when NETDEV_UP event fires
( https://lkml.kernel.org/r/cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp ).

Hmm, does
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/netdevice.h#L3142 mean that
LSM hooks are as well not allowed to veto operations that happen during
NETDEV_UP/NETDEV_DOWN events?

