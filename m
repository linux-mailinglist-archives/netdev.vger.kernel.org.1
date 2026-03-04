Return-Path: <netdev+bounces-263740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOfwL50KqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE31FE66E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3DE930351F2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F83A4515;
	Wed,  4 Mar 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iDe3i1Nx"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB63A256F
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620443; cv=none; b=gj1TCMlAKTsBWbY2gR7mp0EgYD2XEqEGLroEPnOYdmKSgxNRqZNq38LzPQ/w4a6tkW1hC4EzgCc4haXxy6FTs6l+EiE92Xrom57xAKOuYSzITxuMETQkZcRfPYiKlVa/QTBKzzZEk8a6mT4GrMR1fez7eMy+v0P+ad7ylQfzcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620443; c=relaxed/simple;
	bh=T7qbApDTh/+BPFcIJWbS+VwEIwLQbwVVV3rCXDU+yZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUDagga2dxHEZw1v9HEA4xMCOO0eqoJ4Ji5txAHBNzHi0TdecffTO9TAsUwxeNlTREeqDWaLIN0V4QukIbXnysnmTPudeA1W2OGta7i3LurEbMxqn8RZ5E0EVDx5n+FO4EWvfgKPa/TFzpwvoP8Zs7m3y3N+HAGlQSCbDlqW52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iDe3i1Nx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cc7b7d2a-9f7e-41ba-9010-dfbf592a0bbd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772620428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLw1Y61P+1OHK0lZCCdzjxduRGAuzbcMcVh9BWRhWW0=;
	b=iDe3i1Nx8r2NHSxC3qmvCnF11Vif3K/1N3bkZ+yrY6ZhNWrEio5F4731RtCrn4HYshB6yG
	8NqRrXC/tz+UkvjRqIwVl5iP5Httt9ix1p2+QOt/Jsrsn3WXPHQVZyg37+4M2uB3nxSsoO
	uSbdt4gxqduq7VbryWsjFjfwHU85Xds=
Date: Wed, 4 Mar 2026 18:33:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 1/2] bpf: test_run: Fix the null pointer
 dereference issue in bpf_lwt_xmit_push_encap
Content-Language: en-US
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 posk@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-2-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260304094429.168521-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 65CE31FE66E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263740-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Action: no action

On 4/3/26 17:44, Feng Yang wrote:
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
>  net/bpf/test_run.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..565fe8cbcdc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1156,6 +1156,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		skb->ip_summed = CHECKSUM_COMPLETE;
>  	}
>  
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> +		if (ipv6_bpf_stub) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +			dst_hold(&net->ipv6.ip6_null_entry->dst);
> +			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
> +#endif
> +		} else {
> +			/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL */
> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +	}
> +

NIT: it would be more readable to handle the error path first.

if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
	if (!ipv6_bpf_stub) {
		pr_warn_once("...");
		ret = -EOPNOTSUPP;
		goto out;
	}
#if IS_ENABLED(CONFIG_IPV6)
	dst_hold();
	skb_dst_set();
#endif
}

Thanks,
Leon

>  	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
>  	if (ret)
>  		goto out;


