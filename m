Return-Path: <netdev+bounces-305812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DS3hColMTmqQKQIAu9opvQ
	(envelope-from <netdev+bounces-305812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:11:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F11726A5B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:11:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=YI5qyFe7;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305812-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305812-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E323066B7D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2701246770;
	Wed,  8 Jul 2026 13:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A883231A41
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 13:04:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515876; cv=none; b=ctWX6GkUam65O6oBEpKCZZx+C0vWVRBqH7zUmjxxs2GhEj633+4SmX5lS1a5AdUpe/95oyHpd7iBtqI2StmnkT4WAKBsjOUntzj8U8em3nYrhzPNxdzPg76BBRcfk0Rb3lE6t0B1Sq/d6kUZfqyBzCxU8Es/2rYYuXSrNNIc0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515876; c=relaxed/simple;
	bh=TPmuL1ero5zv+WHjvwHCf1loe950mWpRMqA8MpPKYCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/4pFbBKuHtjzhXPpMVECsn/bI5sg0hEPSAEdSAuJVwe9564rpJDfjnctUqA2wh611+Uzz+Bbav08L1OToiVPcFpzx+0X7bwZ4I2vPkbyWz0qr0BIdtgey7n7C4aCJwg2vDfWtEwbsPRdwMZmeuDYWWTP8IAFgwGO62n4/w/FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YI5qyFe7; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso2596775e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783515874; x=1784120674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/x6FSTkcJjBlea16+XEShOIorxoX9U0UFrtSrJcffgE=;
        b=YI5qyFe7tEZCsTz+ih+tFtd+C3xTfwWeqycM/atEgEyS4s3WQrW1tcxy2wWjQiAnyC
         DVAmhSUTaATJhG3Xamh6PbUYXiNIfpiJSLubeZgNA6DL6pRWX50q2PH6N30QWYwK+6ck
         YdKmwW7rlplvz4gDEaNdNQkJMA5RZ96NttJcgrvjGAkS1TUsVsis9HNQBu0hTHYR4Bqw
         pxWoLy1ymZsRqVNq90byKnqIHs7P81KZsdbX23mcR74L7nOhnf1ZPqiPnTK+vYe4yixN
         Fo3QuZyYWpq/Hry7rA/ahUiL7o6p9CY3LR1tfPDdx9ZJO/szkd0SLw7zYmNPBFpzfiZ9
         isNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515874; x=1784120674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/x6FSTkcJjBlea16+XEShOIorxoX9U0UFrtSrJcffgE=;
        b=DiFv3eDZwdLv9ReR/I60w/yWdsi4cz1Vl1s6tA2Y7oyVrQPNDW14w/YPEyYpFb+5gu
         PsC2EWs2Ck7gkGsfJQM2jSInlsyTt5zfWAtdcza5PajTxNgojhiJH2bSloaxDZmyzd4Q
         E0Y0jf5MSbl6NtuoMVXVItA7D2gOIprnUeA0SNIbIS5+g7rU9P/bGMPSqbrCGUxg8NRW
         xzK9I7GxTMMHm+znU7juDARw0zF/eJ15vtXNmdWFZ22LkQZfl+tgUHFuNc/smHqXVtJN
         4A7eIWu0tZdu8cc/AHjjfwNicnJmEe0A2BVW2Uze7ZY1XraprSYNv4KgyGdeaoxSO0Wa
         J9gQ==
X-Forwarded-Encrypted: i=1; AHgh+RomelHmZuZ1TiCWFgEExrzVjbs89fCsVJ9I5bWeynFg3d/LGi0JxELlKht2eH/Tg7VgZYJTxts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LsnaP7D4wKXYFrNbxMPLuOjDrSTR0uThyytDoQNEgp20KjWS
	cPorlHJOXo6ZKmQcxu0za6/Tp6JU1bkKfWy2F1XFfZJHqD05kbRhCDbl0dv2LrHftRE=
X-Gm-Gg: AfdE7ck6nOh+X65e/OsvAhf9p5WZE5K9ZEfengw8S63/fDaVzVomcI6UDVkNbCLq9cU
	DT08yHcquHUfwX98j7eeP/RuOH/llzvy7kZ6ZzViWEPUVAz9Vpn7OpXV5gI427yMI9ZfvzAV38X
	coeDb/6253bylNLwqJqSTaWWwL4t4ZnmKtm92NTLUqOIMKeTsQvn4rrFkc/qfK2drFPbBlngZeh
	V0+yk2REvulAL+FfrmeOEVzEbgbgEYD9twDPWkP1eFxqcm7K6I6gMMpGOSm5q0wKx9ItiabViOO
	9RSIRbv+NftXwR3LTtjltxFZvWrLJIttzxoeCNHJHb8rfSlz/LvkGWoujuJqF0vZ8T5wBhE+kLs
	YwSejvzRkOy8LrgcsM2tXAejzZoBwLSKq4PXufp4k8vsa4tIxn2Ssy4uLM2xrbBacekuPmrezFb
	MtcI4OEVLJGUQzdQFsg77qrMFVYXqvCJw+yswQH0Ckt0W6
X-Received: by 2002:a05:600c:1da8:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-493e687cb4amr21521735e9.35.1783515873732;
        Wed, 08 Jul 2026 06:04:33 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm158975915e9.7.2026.07.08.06.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:04:33 -0700 (PDT)
Message-ID: <bef05178-4856-4b62-9c3b-62bf636c239d@suse.com>
Date: Wed, 8 Jul 2026 15:04:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qingfang Deng <qingfang.deng@linux.dev>, Breno Leitao
 <leitao@debian.org>, Norbert Szetei <norbert@doyensec.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev> <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
 <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
 <20260708074904.xnpi0mlh@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260708074904.xnpi0mlh@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,debian.org,doyensec.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,atomlin.com];
	TAGGED_FROM(0.00)[bounces-305812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:qingfang.deng@linux.dev,m:leitao@debian.org,m:norbert@doyensec.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnault@redhat.com,m:netdev@vger.kernel.org,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:linux-modules@vger.kernel.org,m:paulmck@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5F11726A5B

On 7/8/26 9:49 AM, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 17:32:10 [+0200], Petr Pavlu wrote:
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -858,6 +858,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>>  		goto out;
>>>  
>>>  	mutex_unlock(&module_mutex);
>>> +
>>> +	/* Ensure all rcu callbacks issued by the module have completed */
>>> +	rcu_barrier();
>>>  	/* Final destruction now no one is using it. */
>>>  	if (mod->exit != NULL)
>>>  		mod->exit();
>>>
>>> make sense?
>>
>> This is discussed in Documentation/RCU/rcubarrier.rst and
>> Documentation/RCU/Design/Requirements/Requirements.rst. The latter
>> contains:
> 
> I am aware of this. It is just not the first time I stumble about this.
> But maybe with the AI review these days there won't be a miss.
> 
>> I don't know if the last part about unacceptable latencies is still
>> relevant. I haven't done any measurements myself.
> 
> There is a synchronize_rcu() later on. I think I could replace it with a
> call_rcu() so we might end up even. I was thinking about about it last
> time I was touching modules but somehow I stopped where I stopped.
> The question is just, is it worth doing it or is it reasonable to expect
> that it is done correctly.

As RCU usage in modules is now more common, I see an argument for the
module loader to invoke rcu_barrier() during module unload to make RCU
usage easier. In general, module unloading is a rare operation, so even
if it becomes somewhat slower, I don't expect it to be a significant
issue.

One problem is that I'm not sure where the new rcu_barrier() call should
be placed. The prototype adds it before calling the module's exit
function. Would this actually fit all modules? From a quick look, I can
see that various modules call it at different points during their exit.

-- 
Thanks,
Petr

