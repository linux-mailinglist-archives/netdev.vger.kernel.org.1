Return-Path: <netdev+bounces-302230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/phMOupPmq4JwkAu9opvQ
	(envelope-from <netdev+bounces-302230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 660856CF219
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fCNMDZ8L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302230-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302230-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D9F30B7994
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE33F9F5C;
	Fri, 26 Jun 2026 16:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA23F928E;
	Fri, 26 Jun 2026 16:25:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491128; cv=none; b=q1HpKcPwmxh/PSLstMcQeyDr1WNbv0WnawPxRY2hygFPVRIZcpGBskJgeU4qchCCEuTB+KX9WOlycw9U3TmRPBC/n7cEprP7U0pMv1g++qK5yZHa8a37OL1/fyhCLHce+taX5VTJdskTfbL5vXtkrkiWZQjnSUAVNLGxWKL63Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491128; c=relaxed/simple;
	bh=3KXriWTm2ItE45nHEMNaIyMG0lB1n9W8V05lNe5JJFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT/iH6HVIrhOehhWxE6S/s3ioytTynf5xBigP8d3ap76GgIfBf0RsMikJajbz0hYnEGe10/pKpB3KeaFYKKaqgSMB4n2rDww2Skn6KopIjN6iR/mNHPcuVFIKF/+eXjZHMKFG6Um6UOGd8nBxqXDWrxqJruobPii645AY0LuF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCNMDZ8L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0EF1F000E9;
	Fri, 26 Jun 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491127;
	bh=4BSSfz87ODDfFMwFWNy+I/fCJ15UtLSdQaLTscysvj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fCNMDZ8LLCHYAohaYSo3PRInAhAqfi99vvhXhVZQ+aBLnlcOyTa1kankbxgxIRCFo
	 tfXaphB0BfalE1u9/dMZeCA7HtG6XkTeN/TQ63cyHTutVw7tj9OSh9Su2ZYGuljg3b
	 hZ56n1Ksfdt4wgQ9As9+BGCk397fbKXCD8lFzvw4nGV6lEM4d/7RRvF0IYpCB1Q+PE
	 Ts9KTaF89pcTjlOUIWC8SQizlAtXqJN9TUKFI8HXUXGv1DKoVR1zDKQQwJlqySj5g1
	 9NboGixNjxgi/78f85JGPWu6f48Tt3EQy88C2ju35T4DbV5OFQ4A2teulFXdN+FOi4
	 dn/YexJKhYi3Q==
Message-ID: <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org>
Date: Fri, 26 Jun 2026 10:25:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Content-Language: en-US
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 toke@redhat.com
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260624030530.3342884-2-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	TAGGED_FROM(0.00)[bounces-302230-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 660856CF219

On 6/23/26 9:05 PM, Avinash Duduskar wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..e00f0392e728 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3532,6 +3532,29 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**

This flag should not be needed. Patches for vlan support were never
submitted (I have them in some old branch). Since the vlan params are
initialized to 0, no new flag should be needed. Besides, these are
output parameters.

> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. *params*->h_vlan_TCI carries the VID
> + *			only, with PCP and DEI bits zero; a consumer wanting to
> + *			set egress priority writes PCP itself. *params*->smac is
> + *			the VLAN device's own address, which can differ from the
> + *			parent's. Only the immediate parent is resolved; if it
> + *			is itself a VLAN device (QinQ) or in another namespace,
> + *			the egress cannot be reduced to a physical device plus
> + *			one tag and the lookup returns
> + *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
> + *			left at the input. Re-issue without
> + *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
> + *			ifindex. The swap and the vlan fields
> + *			are written only on success; other output fields keep
> + *			the helper's existing behaviour, so a frag-needed result
> + *			still reports the route mtu in *params*->mtu_result.
> + *			This flag is only valid for XDP programs; tc programs
> + *			receive -EINVAL since they can redirect to the VLAN
> + *			device directly.


