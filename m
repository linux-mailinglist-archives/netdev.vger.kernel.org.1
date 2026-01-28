Return-Path: <netdev+bounces-254190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCp7L8DkeWl60wEAu9opvQ
	(envelope-from <netdev+bounces-254190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:28:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEB9F732
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D169300DA7E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7492EDD70;
	Wed, 28 Jan 2026 10:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E22DA75C
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596092; cv=none; b=Zq9441xByDrxZfvg03YAIy8MAL9ft6Qw1WmXcotX/cwpg0SwujbqkvN1EqIsA5udK5zZtvfUag0UFFe59lbJQSwcXXDlQP2a9Xzvd5+RhxXv+0EG+hCLGfyTGar2WOorzTQOX18yPDui1nTUhZzLljsRbsgcmLFizLdcpM8nAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596092; c=relaxed/simple;
	bh=pbVl0ODL9OzExgUwxrbIhZ3mNab1RLmbIY3owANW0Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu5i7ICXGPbGEneK/SrO9MGoab6urJeSXHiJ0OSo5JawGgPY6uZg0g7/TDo/JalTkPDSCSgyxdgAI4E8xVOH+H2m4aa1s4ct3WMzqg4Pcofi2778/N4/hWT9pjg+caZbJMOS+VX+NZGMea+JUMizHry40PR/YAYwpEl/nS2yFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60SAS7W1005303;
	Wed, 28 Jan 2026 19:28:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60SAS78j005299
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 19:28:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 19:28:05 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[I-love.SAKURA.ne.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254190-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 9CCEB9F732
X-Rspamd-Action: no action

On 2026/01/28 6:59, Paul Moore wrote:
> It sounds like we either need to confirm that
> security_xfrm_{policy,state}_delete() is already present in all code
> paths that result in SPD/SAD deletions (in a place that can safely
> fail and return an error),

Yes.

>                            or we need to place
> xfrm_dev_{policy,state}_flush_secctx_check() in a location that can
> safely fail.

Did you mean xfrm_{policy,state}_flush_secctx_check() ?

Regarding xfrm_policy_flush() as an example, we can observe that we are
calling LSM hooks for must-not-fail callers. If the task_valid argument was
meant to be interpreted as whether to call LSM hooks, xfrm_policy_flush() needs
below change.

 int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 {
 (...snipped...)
-	err = xfrm_policy_flush_secctx_check(net, type, task_valid);
+	err = task_valid ? xfrm_policy_flush_secctx_check(net, type, task_valid) : 0;
 (...snipped...)
 }

>               The patch doesn't relocate
> xfrm_dev_{policy,state}_flush_secctx_check() and I don't really see
> any mention about security_xfrm_{policy,state}_delete() in the patch
> or description;
>                 have you verified that the LSM xfrm hooks are still
> being called to authorize the removals?

Please distinguish caller for "delete" and caller for "release".
LSM xfrm hooks need to be called for "delete" callers, but
LSM xfrm hooks need to be bypassed for "release" callers.

Maybe task_valid == true is for "delete" callers and task_valid == false is
for "release" callers; though it seems that some locations are passing wrong
task_valid flag (e.g. xfrm_dev_down() is passing task_valid == true despite
it is a "release" caller).

If 'task_valid == true is for "delete" callers and task_valid == false is for
"release" callers' does not hold, we might need to add a "forced" flag
(which is interpreted as whether LSM hooks must be bypassed) like
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?h=next-20260123&id=fc0f090e41e652d158f946c616cdd82baed3c8f4
does.

Anyway, this patch which kills xfrm_dev_{state,policy}_flush_secctx_check()
can be applied as-is because all callers are "release" callers.


