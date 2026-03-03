Return-Path: <netdev+bounces-263423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCGZLDpTp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F991F78E1
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FC2E3014A2B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04447DF8B;
	Tue,  3 Mar 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNB0BUye"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B53EFD1A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573491; cv=none; b=DC1zBT0U6BjmGwHMaf68zzbNQiuxAD1CX+OwgLo0w7phoc3cYc1cUVqNToz44MQWEtdGR/Vdsf8eQfzdkPJstWvG36XS5znEbnhpHRV0s2iG8RjW4U74+EFnRIZLr2jh7virUKWNmAS7QtI9uGpj92qYszGqya5Y+IegHa49PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573491; c=relaxed/simple;
	bh=IYi2FaI3pPWjNklnUlNqJcj/43ObrhojhL4TT/JzaqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaXLQbQO45QrOlJ832se15LPJoHqR3BmNxUpouSP+TAxmBNyn3YSsqL3XzDulpD9VRkqD3GDLBeDOBL+AW7e9me4+nPowXW8q5nXSjTHyR0GthdI+RwgD9oMd3HWe1XH+Xb9hEJ7wmX+2g95CSFDcmKv6RqQyRHocEBOR6/PFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNB0BUye; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e88a3ea-9424-40eb-96ea-2d3d1cccac7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772573488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwM+J7r+WxoB1IGtdnCcEAiD9AH7ZEGe+QIBFok2+8w=;
	b=XNB0BUyeV22MKJT1rVbaJ+QYK25urtP86FWN/WE6LhIfOVJMJJhCMyIdd9BZh+Ue1mTx5+
	+Mv+n4wwQ8KAUtJSPNJHq6eL/MgAo+dP1NEWrC9fJaclgrUWQg851nZgtHL/Tt3OTHw0LL
	q+91E84hYEA9p6QTcSb76PPaQNXlo+Y=
Date: Tue, 3 Mar 2026 13:31:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 bpf-next 1/2] bpf: test_run: Fix the null pointer
 dereference issue in bpf_lwt_xmit_push_encap
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260303074423.172680-1-yangfeng59949@163.com>
 <20260303074423.172680-2-yangfeng59949@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260303074423.172680-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B9F991F78E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:dkim,linux.dev:mid,kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,hust.edu.cn:email]
X-Rspamd-Action: no action



On 3/2/26 11:44 PM, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> The bpf_lwt_xmit_push_encap helper needs to access skb_dst(skb)->dev to
> calculate the needed headroom:
> 
> 	err = skb_cow_head(skb,
> 			   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));
> 
> But skb->_skb_refdst may not be initialized when the skb is set up by
> bpf_prog_test_run_skb function. Executing bpf_lwt_push_ip_encap function
> in this scenario will trigger null pointer dereference, causing a kernel
> crash as Yinhao reported:
> 
> [  105.186365] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  105.186382] #PF: supervisor read access in kernel mode
> [  105.186388] #PF: error_code(0x0000) - not-present page
> [  105.186393] PGD 121d3d067 P4D 121d3d067 PUD 106c83067 PMD 0
> [  105.186404] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  105.186412] CPU: 3 PID: 3250 Comm: poc Kdump: loaded Not tainted 6.19.0-rc5 #1
> [  105.186423] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  105.186427] RIP: 0010:bpf_lwt_push_ip_encap+0x1eb/0x520
> [  105.186443] Code: 0f 84 de 01 00 00 0f b7 4a 04 66 85 c9 0f 85 47 01 00 00 31 c0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8b 73 58 48 83 e6 fe <48> 8b 36 0f b7 be ec 00 00 00 0f b7 b6 e6 00 00 00 01 fe 83 e6 f0
> [  105.186449] RSP: 0018:ffffbb0e0387bc50 EFLAGS: 00010246
> [  105.186455] RAX: 000000000000004e RBX: ffff94c74e036500 RCX: ffff94c74874da00
> [  105.186460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94c74e036500
> [  105.186463] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000000
> [  105.186467] R10: ffffbb0e0387bd50 R11: 0000000000000000 R12: ffffbb0e0387bc98
> [  105.186471] R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000002
> [  105.186484] FS:  00007f166aa4d680(0000) GS:ffff94c8b7780000(0000) knlGS:0000000000000000
> [  105.186490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  105.186494] CR2: 0000000000000000 CR3: 000000015eade001 CR4: 0000000000770ee0
> [  105.186499] PKRU: 55555554
> [  105.186502] Call Trace:
> [  105.186507]  <TASK>
> [  105.186513]  bpf_lwt_xmit_push_encap+0x2b/0x40
> [  105.186522]  bpf_prog_a75eaad51e517912+0x41/0x49
> [  105.186536]  ? kvm_clock_get_cycles+0x18/0x30
> [  105.186547]  ? ktime_get+0x3c/0xa0
> [  105.186554]  bpf_test_run+0x195/0x320
> [  105.186563]  ? bpf_test_run+0x10f/0x320
> [  105.186579]  bpf_prog_test_run_skb+0x2f5/0x4f0
> [  105.186590]  __sys_bpf+0x69c/0xa40
> [  105.186603]  __x64_sys_bpf+0x1e/0x30
> [  105.186611]  do_syscall_64+0x59/0x110
> [  105.186620]  entry_SYSCALL_64_after_hwframe+0x76/0xe0
> [  105.186649] RIP: 0033:0x7f166a97455d
> 
> Temporarily add the setting of skb->_skb_refdst before bpf_test_run to resolve the issue.
> 
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://groups.google.com/g/hust-os-kernel-patches/c/8-a0kPpBW2s
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---
>   net/bpf/test_run.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..a086cee1ac6a 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1156,6 +1156,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		skb->ip_summed = CHECKSUM_COMPLETE;
>   	}
>   
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> +		ret = -EOPNOTSUPP;
> +
> +#if IS_ENABLED(CONFIG_IPV6)

It is needed for the "net->ipv6"?

> +		if (ipv6_bpf_stub) {

> +			dst_hold(&net->ipv6.ip6_null_entry->dst);
> +			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
> +		} else {
> +			pr_warn_once("Please test this program with the IPv6 module loaded\n");
> +			goto out;
> +		}
> +#else
> +		pr_warn_once("Please test this program with the IPv6 module enabled\n");

This is almost the same as the previous pr_warn_once.
Since it needs a respin, lets see if it can be simplified.

> +		goto out;
> +#endif

Like this:

	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
		if (ipv6_bpf_stub) {
#if IS_ENABLED(CONFIG_IPV6)
			dst_hold(&net->ipv6.ip6_null_entry->dst);
			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
#endif
		} else {
			/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL */
			pr_err_once("Please test this program with the IPv6 module loaded\n");
			ret = -EOPNOTSUPP;
			goto out;
		}
	}

> +	}
> +
>   	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
>   	if (ret)
>   		goto out;


