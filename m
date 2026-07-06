Return-Path: <netdev+bounces-304907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9QlK7p2S2p7RwEAu9opvQ
	(envelope-from <netdev+bounces-304907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9170EA69
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=W0FBt5s7;
	dkim=pass header.d=redhat.com header.s=google header.b="S/GdIGhK";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304907-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304907-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1AEB3084762
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B943F9F32;
	Mon,  6 Jul 2026 09:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B147ECF0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328514; cv=none; b=cf4LymBx5RI77mmKeF7CDIacjhFVD4/m7Wgw1/rI7Xye0vEd/sYeayiLAcdJyoQ4GT8Q18UDFhOxety50Kld/BFvYWeLzhN/7/0Nqrwv3rdfuv0oOmsXWAhBTjFCxTFbmaLYC2wfXBux9OM1k8U9dgFwAR/RO3sMO9B1B+87XXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328514; c=relaxed/simple;
	bh=m8GIGSsnH1qHWVBzg3/OAbWR9kYTaq+n6KfKIsKhZbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcIVvcGAxEv3a0lG1PdQQFvxFHt/EKR2Tqf9kv2DV2jzpYw1eLJguTCcI59ZPR+UCmy3aiQNBYCZtMg0XKbe0NsRjQTDZWR8X1/40JaStg/7TvTcqTcVpO/5Yv6c2zVVcmWCGJhKXvaMXluE1FYZQILRYFD+iHc2WNjKqR5su2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0FBt5s7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/GdIGhK; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783328505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
	b=W0FBt5s7YlMRCiBo8teBi+D3CyozF32hPj3YNQRKtCXnSuLgP4+VHEfBaY7fhjZ1mlRtVK
	KKFmjnda7MMLOTZNs/cx6CGixSUCadeDtlZoNINvPXOxccCJAQZTu+t8S+SCxUgqNC37cp
	u656XMjTsUebzYmH/bACN3C/vZIrCXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-yaejAzWrNMCpd1UXtpfHLw-1; Mon, 06 Jul 2026 05:01:44 -0400
X-MC-Unique: yaejAzWrNMCpd1UXtpfHLw-1
X-Mimecast-MFC-AGG-ID: yaejAzWrNMCpd1UXtpfHLw_1783328503
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493a6fe9ebdso13039115e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783328503; x=1783933303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
        b=S/GdIGhKXvbJnLAbg0Hqa2QLbZfkxxV4uukXWcNVu4yjhHLtjhGco5sl4RKxUjvu/R
         KxJYek3vWmZshn5gxLRvl96nTnLh1SnCJNE2hsgbE2WdPwgPwHscmmgWjmaWiOMUVZzn
         te1S/1pkLEl73yyIPPCbqa+NOZn4lFhZSibXm2gessnloQfVpVgiQZHx6Pyp/KUZo0Uf
         rmICP/lOKvXaEm/UVR1VpSVMS/qu4zvW6VzXMomVkbtps7VZgea4JO5joLfRMGNKVUBp
         mu5P430Di+FSqffOaDDifGs/Nyb77o9QqSd1Y3oy9xgbohWHJNkw58n9Gb72v3LwSsAH
         TjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328503; x=1783933303;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqWYV25RKvq0b7ohsITiNfXnDbPI0PkgLTXYoW15CpI=;
        b=mkuKcKT7yW8iEwJCCX4UVgh1Pr6GZbBIWtRofr7SbeDHvyFf+mzxr4UK2lWRRiEDLJ
         0q+mHqrTsAh3ByjVf9V/0CJ6IlF+L/cIaI6NyPdV9S8gZrYMAWfatNFM3Sh5ImuowNm8
         M5YO/XVmtSeiQdhYzLX4B/R2osq3BNoStxtxuPuOcA/dSfyvIOvryL4p5hmyuu1kW4rz
         NdFfUiL0EX/5O9LCpmJ+YoyXyXgTzSrHIejpOJPJd62nYj8ylcamfo9JRiIgmq3XJH0Y
         GPxxwXXZldKrYjoPmMBtdng75XAOmrdjvtwNhAQ/1APwMFvgOGHefL4dsRnBsJx8oAtf
         BsXw==
X-Forwarded-Encrypted: i=1; AHgh+RoTV8Gxe2kZCvak93VDtpqqH5WrrbJqOIf6Gik0ZQ87QFSFIrPorEhLuAww2Is5S8tUMgJOfgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE6AYUj3GAfybJdH08iEi0JmMxSjAIhoCYWihC+HnZyhQ7ClB
	deseww8QgiEJNhlxKG5WpBw+gTDExfilu4mD3cSdw/jk/15CepXm4u6hUxQ8p44LFa/hMs8kbxq
	Tdg8LNQXYtb5aF8DRY8qpSYwuinOv8hfa0QU8TdAdEobDW8W9U+41l1WpOkYP7ON59Q==
X-Gm-Gg: AfdE7cmQYvoq/WB9+Lv+XhgMy19GkMK0AzVSxkxK+ontywTxUcHdfAqUQ9MjjKLBIZ7
	Y6dPToIQ6xrNHQVV8dYv+KUhxbY4lVC/ds02cZvUQ/8k9HxNyjIcAMx7d+TaN1xIHVuSikfG38T
	+KZqxVwH3b17ITXUVi1kiY1ZiKSaUPejgYA//5kEHzDEvOJBF9elq9B3gA+pGYpv1IJtidlRb5h
	TNuMj0FfnplloUUqRj2gjNDN2liN1ZG02B9enGPF0n9NvLIoKJsoFypQ08xKFrjwGYWV57cAbUj
	ciKp/6gjsZIcopWHW2DZOTCiNYPZwG9f3kFCObUfPBigMDDyxz5ww9vxuQMiyCubNc94Et9kDog
	fOnXFh85uCQDVIsuWhUKNr83FPF+g0jM5g/cceZBpx4t0LyYjf7WlACtgQ7z/vinTVs40xuYh3J
	QgXarblRtzo/5W
X-Received: by 2002:a05:600c:a00a:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493d11d68b8mr112191375e9.15.1783328502821;
        Mon, 06 Jul 2026 02:01:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:493:c389:d434 with SMTP id 5b1f17b1804b1-493d11d68b8mr112190765e9.15.1783328502258;
        Mon, 06 Jul 2026 02:01:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm406103625e9.15.2026.07.06.02.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:01:41 -0700 (PDT)
Message-ID: <43c79a50-eea1-47b4-9a4c-5c61e611c059@redhat.com>
Date: Mon, 6 Jul 2026 11:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: jhs@mojatatu.com, bigeasy@linutronix.de, andrii@kernel.org,
 memxor@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Victor Nogueira <victor@mojatatu.com>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630123331.186840-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,linutronix.de,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:jhs@mojatatu.com,m:bigeasy@linutronix.de,m:andrii@kernel.org,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33C9170EA69

On 6/30/26 2:33 PM, Daniel Borkmann wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> When a TC filter attached to a qdisc filter chain returns
> TC_ACT_REDIRECT (ex: via an eBPF program calling bpf_redirect() or an
> act_bpf action), the redirect was silently lost i.e no qdisc classify
> function handled TC_ACT_REDIRECT, so the packet fell through the
> switch and was enqueued normally instead of being redirected.
> 
> This has been broken since bpf_redirect() was introduced for TC in
> commit 27b29f63058d ("bpf: add bpf_redirect() helper"). We got lucky
> for a long time because bpf_net_context was a per-CPU variable that
> was always available.
> 
> commit 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct
> on PREEMPT_RT.") turned bpf_net_context into a task_struct member that
> is only set up by explicit callers. Without a caller setting it up,
> bpf_redirect() itself crashes with a NULL pointer dereference in
> bpf_net_ctx_get_ri(). However, even with bpf_net_context available,
> TC_ACT_REDIRECT from qdisc filter chains cannot be honored without
> adding skb_do_redirect() calls to every qdisc classify function, which
> would require changes across net/sched/. Isolate it to ebpf core where
> it belongs.
> 
> Instead, add a tcf_classify_qdisc() inline helper in pkt_cls.h, as a
> wrapper around tcf_classify() for use by qdisc classify functions and
> tcf_qevent_handle(). When the classify verdict is TC_ACT_REDIRECT,
> the wrapper converts it to TC_ACT_SHOT, dropping the packet rather
> than letting it continue silently. Dropping is preferred over
> letting the packet through because the user immediately sees packet
> loss. Silently passing the packet through would hide the problem and
> leave the user wondering why their redirect is not working.
> 
> The clsact fast path, tc_run() continues to call tcf_classify() directly
> and is unaffected: TC_ACT_REDIRECT is returned as-is and handled by
> sch_handle_egress/ingress() calling skb_do_redirect() as before.
> 
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

I'm sorry, this does not apply cleanly anymore.

Could you please rebase and repost?

Thanks!

Paolo


