Return-Path: <netdev+bounces-253691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIaTDUo2eGl+owEAu9opvQ
	(envelope-from <netdev+bounces-253691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:51:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3528FBE3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A57F9300A330
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7E314D0C;
	Tue, 27 Jan 2026 03:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0430E0D3
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485894; cv=none; b=sXhKxMPBL9N6SfnJ4dPM8beLBcfV3y87QxhvJyn5fU1UO2cneNFx7FrAWKRmtYKq4lWLCCrCzF1tGb8wQ1d26KmEu7WaasYRSaa5GAcVJsYGhh24AUMapaoeGgFLU6WVv5UAdHBJBIwTQF3DQNMZV+zFzHmAhUFLzF1y302Gr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485894; c=relaxed/simple;
	bh=bRkobea5ohiwWDKJh9IQ7cjBDH3Erht57kFyuuUvxww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyicQgyYmjZqVazncfuPfLdlYb5kstZpPlobUnTRSYcMTxOgIY/WuQUdcDLd/PpEuF8zzqWKeoqomV+jnuf9Mz7FuInmFI180cEDhVipNEYPrh3KwT3j5C9jIWJ+7aUGW8aeMdwVkSi+RuPBr4V9Bbef2Sls/3HDJKMtoAysNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60R3pUI5089632;
	Tue, 27 Jan 2026 12:51:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60R3pT3q089629
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Jan 2026 12:51:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
Date: Tue, 27 Jan 2026 12:51:29 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-253691-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 4C3528FBE3
X-Rspamd-Action: no action

On 2026/01/27 7:33, Paul Moore wrote:
> On Fri, Jan 23, 2026 at 5:13 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN and
>> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
>> returning an error value from xfrm_dev_{state,policy}_flush_secctx_check()
>> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
>> returned an error value upon NETDEV_UNREGISTER event, the system will hung
>> up with
>>
>>   unregister_netdevice: waiting for $dev to become free. Usage count = $count
>>
>> message because the reference to $dev acquired by
>> xfrm_dev_{state,policy}_add() cannot be released.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
>>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
>>  2 files changed, 68 deletions(-)
> 
> I didn't make it very far into reviewing this patch, because it looks
> like xfrm_dev_state_flush() is called by the bonding driver's
> notification handler, and I don't see that reflected in this patch?

xfrm_dev_{state,policy}_flush() are called from only the bonding driver's NETDEV_UNREGISTER
event notification handler and the xfrm module's NETDEV_DOWN event / NETDEV_UNREGISTER event
notification handler ( https://elixir.bootlin.com/linux/v6.19-rc5/A/ident/xfrm_dev_state_flush ).

What this patch kills is not xfrm_dev_{state,policy}_flush() but
xfrm_dev_{state,policy}_flush_secctx_check(). No need to touch the bonding driver.

LSM hook for checking whether to allow deleting a file in tmpfs which is still mounted
makes sense, LSM hook for checking whether to allow starting unmount of tmpfs makes sense,
but LSM hook for checking whether to allow releasing memory in tmpfs while unmount operation
is already in progress causes nothing but a resource leak / denial-of-service kernel bug.

What xfrm_dev_{state,policy}_flush_secctx_check() are causing is something like
"LSM policy is refusing release of memory used by a file in tmpfs which is already under
unmount operation".
xfrm_dev_{state,policy}_flush_secctx_check() are too late to make LSM policy decision.
A must-not-fail operation has already started before LSM hooks are called.


