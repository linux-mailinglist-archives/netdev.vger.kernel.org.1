Return-Path: <netdev+bounces-257158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJWHBg+ShGk43gMAu9opvQ
	(envelope-from <netdev+bounces-257158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A227F2CF8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60379303C293
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532363D413D;
	Thu,  5 Feb 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c++inlcP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtYGY4GN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D3D412C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295710; cv=none; b=jLRnawHdzKtcrDL/nBuaAZXpc6kGdUEmH9HilCvvpiAlV21UJ6bMD54DTmxCRyOL+h9Q/cy22cgldjwW/bcSKyFe2WDUyyk9l+hxoJCyc7z4kmu4F0nkuSS8QnHe+rgp5KA0w36/caePmez/BJs7mLX4FHhqDgVsOu8AjXilCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295710; c=relaxed/simple;
	bh=mIAhPyVOqRDwJMq/L+Fm+xDHGGiSnfR1mZdXuRd6K0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHC4Af/ITV3l4gSj4Px42AMpVhPko2XVzpQIb9LoZjIb3nwZeIYnZMCtG7O6VH8JNooqt+BOp/5jIm0gD3BqjcbaJ6whZ5yp8NETbYqoF3TnlhH2J1kUWoea0APl3l8+OMywTqgZBioQcJ9EpuiGhr4G1+TSkJfUMvyRgQB6ZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c++inlcP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtYGY4GN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770295709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWd7quC0GtIREsRfL2ubD1yE2knY7YDhEMVXNy1vPWY=;
	b=c++inlcPZOJlMp5kZxO2TsNpPRYsmsWzxnGfPAiTQIJ+l47yKN5JdMkbRWOwFtilsD31M6
	XK00fpoYl2W3051c3kxb1Q3bZg4tTTieB+8faIaJBBHRkMJoHRVy4VZ7umrTFRpYHN9enC
	ah0DazBN+xxxkGgf40ltzwq/SoeNDdE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-QvSuqJD-P_OynyYXP_IPZA-1; Thu, 05 Feb 2026 07:48:28 -0500
X-MC-Unique: QvSuqJD-P_OynyYXP_IPZA-1
X-Mimecast-MFC-AGG-ID: QvSuqJD-P_OynyYXP_IPZA_1770295707
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4358f90fe8dso644205f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 04:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770295707; x=1770900507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWd7quC0GtIREsRfL2ubD1yE2knY7YDhEMVXNy1vPWY=;
        b=HtYGY4GNsFbSF29QOp2wuL0c2JFLgmU4F+nR64qRuTU6EqzFkPCQK3rlmG0UKasv2V
         Im8MS1Zk4iEFi6Pw+YjrrLkO/0BEaELp/NSsha3BNwG3SIytVzXA0rMxSd+Sq+gg/aeP
         rBBTwU8SaGpPolSUWZXXxP5SgHUGQ+lSX+Kt49Oh9dO/ut+CZalwm5SczO86BqUyM0mr
         wbJPgcZB8JqMSVPjSGzZPUmDTZOUqj2aGfXLbDHj28hNVrW7peMM1Dlz7vLSjWyk89Lz
         BPMv+eLHCy4LyGepFe4+ub4CWVN2t+2dcADozWscBr4PJCbe4VGfhzJ/DllECuD9Fbbr
         pE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770295707; x=1770900507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWd7quC0GtIREsRfL2ubD1yE2knY7YDhEMVXNy1vPWY=;
        b=mhwXfSAOkMCV6JOHiUtLON/D2cbtzx/PlbuTRr2OrTv5c4jJn5/tvAR3jAdBEljQ/B
         StfdYSf8tVESpISIGH47XlKZXJ6JsM3VrOqFU8psBmoCIRsKWsnm++1IjlLGCY9Vhkts
         W+TDS8BJFsIPUo9Z3poz8ZO6dN9JczqouwI+NudDDkre5YBxDpVDlXUplx+i5TUDn6wH
         FSMWWjQzZvFlhAfu3j9JQMguZeAtkrivfrJkBwz7jb2iyr563K9BdEb91u076a9Rx3vu
         qpZWFNzlk5XtVcLGCL3r4dr8/qfOkVMNpcG1jX/LCsoOgGMfI7Op4iRfvZH1wD1mcGK/
         JHFw==
X-Forwarded-Encrypted: i=1; AJvYcCUAJWzqcCRqbldNZU3f0GysfIqX7pms+CUbm2vzody7pXenohJXOToB9sFWwUnMtkycx1TyVuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvZsCXac+zWbYmdfb1IdL+q6iTGfP9OZocrZoVzwKrgryX0kp
	pAd2TwCPSCpUsNypXoZbO/NEQ27371xLCESy8ZA3zJSvds2VpbHh9I4UvKzdlkEHRXFncMdDBIg
	ufVqlSYwmXr0ERv/GTkti1Fh73195tqgBbt/5Z6gJ0S3VmV1fnFQFMM95Jw==
X-Gm-Gg: AZuq6aKImiTVvDmr7XiQUtUeDPoUHl9/C0fDJQtiIiF7rr9yNshyiHkEepbtitqmfPA
	GShN1Ui4p5doQMEC2/k65zEjlj9LXmyG0s2FFKu2yPKvHXZgGGE3mUAhb+UHDZIr4sxkMnlVmdO
	kw/rGI5oviTSbGNSXTGbVTWUYFy2q/EqoRk1NY+n2ym6Qu2gaSPYd9/thdYHw8t0dHQzPmRa1tj
	db7szxcG+SlTSOL8dpgQ+c3iMrG23bS/Kk2C/akfxa70O+ZgkTk2Spxwy7STg8rFcuw2lXqL4fw
	lDJVFggrJcsV67OpGWuAVaCjRMDoBjLDTxhLOjjAxzdJYiPTftesXA/zHfHMXR0WjOCvHb0h+Ue
	EVfpWS/xSoTU7
X-Received: by 2002:a05:6000:4212:b0:435:dbbb:992a with SMTP id ffacd0b85a97d-43620987791mr4703637f8f.6.1770295706641;
        Thu, 05 Feb 2026 04:48:26 -0800 (PST)
X-Received: by 2002:a05:6000:4212:b0:435:dbbb:992a with SMTP id ffacd0b85a97d-43620987791mr4703595f8f.6.1770295706171;
        Thu, 05 Feb 2026 04:48:26 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25cefsm14701496f8f.9.2026.02.05.04.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:48:25 -0800 (PST)
Message-ID: <e9b073b0-60b7-4a45-9b6d-85c15b51fb4f@redhat.com>
Date: Thu, 5 Feb 2026 13:48:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v9,02/15] net: build socket infrastructure for QUIC
 protocol
To: Simon Horman <horms@kernel.org>, lucien.xin@gmail.com
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com,
 alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org,
 tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se,
 quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com,
 dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com,
 pc@manguebit.com, kernel-tls-handshake@lists.linux.dev,
 illiliti@protonmail.com, xiyou.wangcong@gmail.com,
 andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com,
 matttbe@kernel.org, netdev@vger.kernel.org, smfrench@gmail.com,
 metze@samba.org, mbuhl@openbsd.org, chuck.lever@oracle.com,
 dreibh@simula.no, davem@davemloft.net, sd@queasysnail.net
References: <28a1e36188b1a84193ef2d78f12ecbc0e43ae7f1.1770042461.git.lucien.xin@gmail.com>
 <20260205115423.2195277-1-horms@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205115423.2195277-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A227F2CF8
X-Rspamd-Action: no action

On 2/5/26 12:54 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: build socket infrastructure for QUIC protocol
> 
> This patch lays the groundwork for QUIC socket support in the kernel.
> It defines the core structures and protocol hooks needed to create
> QUIC sockets, without implementing any protocol behavior at this stage.
> Basic integration is included to allow building the module via
> CONFIG_IP_QUIC=m. This provides the scaffolding necessary for adding
> actual QUIC socket behavior in follow-up patches.
> 
>> diff --git a/net/quic/protocol.c b/net/quic/protocol.c
>> new file mode 100644
>> index 000000000000..6ab81f1c50cc
>> --- /dev/null
>> +++ b/net/quic/protocol.c
> 
> [ ... ]
> 
>> @@ -0,0 +1,369 @@
> 
> [ ... ]
> 
>> +static int quic_protosw_init(void)
>> +{
>> +	int err;
>> +
>> +	err = proto_register(&quic_prot, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	err = proto_register(&quicv6_prot, 1);
>> +	if (err) {
>> +		proto_unregister(&quic_prot);
>> +		return err;
>> +	}
>> +
>> +	inet_register_protosw(&quic_stream_protosw);
>> +	inet_register_protosw(&quic_dgram_protosw);
>> +	inet6_register_protosw(&quicv6_stream_protosw);
>> +	inet6_register_protosw(&quicv6_dgram_protosw);
>> +
>> +	return 0;
>> +}
> 
> Can the return values from inet6_register_protosw() be checked?
> 
> Looking at the implementation, inet6_register_protosw() returns int and
> can fail with -EINVAL (if p->type >= SOCK_MAX) or -EPERM (if trying to
> override a permanent protocol). The calls at lines 234-235 don't check
> these return values, so if registration fails, quic_protosw_init() still
> returns 0 (success).
> 
> More critically, quic_protosw_exit() unconditionally calls
> inet6_unregister_protosw() on both structures:
> 
> static void quic_protosw_exit(void)
> {
> 	inet_unregister_protosw(&quic_dgram_protosw);
> 	inet_unregister_protosw(&quic_stream_protosw);
> 	proto_unregister(&quic_prot);
> 
> 	inet6_unregister_protosw(&quicv6_dgram_protosw);
> 	inet6_unregister_protosw(&quicv6_stream_protosw);
> 	proto_unregister(&quicv6_prot);
> }
> 
> If a protosw was never successfully registered, its list field remains
> zero-initialized (NULL pointers). inet6_unregister_protosw() calls
> list_del_rcu(&p->list), which with NULL pointers will dereference NULL
> in __list_del_entry() -> __list_del(NULL, NULL), causing a kernel crash.
> 
> Note that inet_register_protosw() returns void (cannot fail from caller's
> perspective), but inet6_register_protosw() returns int (can fail). The
> code correctly checks errors from proto_register() but not from
> inet6_register_protosw().
> 
> Should the return values from inet6_register_protosw() be checked, and
> should the cleanup path track which registrations succeeded so only those
> are unregistered?

I think it's easy to infer that that such failures are impossible, but
since a repost is needed please drop some sentence in the commit message
to help AI see the point.

Thanks,

Paolo


