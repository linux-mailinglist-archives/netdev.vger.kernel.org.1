Return-Path: <netdev+bounces-262915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEm1JkETpmnlJgAAu9opvQ
	(envelope-from <netdev+bounces-262915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:46:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C61E5E1F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA6F372732D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D73750CA;
	Mon,  2 Mar 2026 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0ub3PW+"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72A3750C5
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486854; cv=none; b=OQPRXzYNstRK+xQHsqpTa0FqHLsffVuKUJJmBvf4RlhAeV7MLmxKOXkN2tUs9PV2+6qKU8ksdbmC0wYDKa3gg+Xc58A7g9BWOM+u7paoGRz63j+MfbCGc4YhVhLJqKpQ8O4/UjfVhj0rtsT9Q9IgxWcEdtv5PW3sMMIXdchW3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486854; c=relaxed/simple;
	bh=lEtrREFEG/Uon0huTrzfsotF+dsO3lDntbJMVcBUgYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7eom87UFziAM/YYaMHlFqq00oO4wj/+vBYVjpBs+IeE1bXJh3UJ4xOdeQepvovQbt7BICPHP7ffGpE0cWhpfeSZ824kOGCgScXIGWGl/RlCs1zSwIPwNPFfHxo/1ZpBEiYAIXddeH8jTX2aefGSGNrhnVP51u25l8uslZUOD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0ub3PW+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54077b01-7411-439a-a9fe-e38c3c244c6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772486840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYEoBKn0dLabxl3YbJ7cS4O37WwmA5ZZkk+R8UMZ3aU=;
	b=p0ub3PW+taRrnUNbLqwgCio0WgrH9lu6WMep9DnDpDu+5KLunErdgnYobJxGocUl1//Ei6
	Riyg0HV7iexHpGprrn5fwkhCUN8dGrIEjWhmaooRNE2wTe/YA/D2Shjo03PHE21lMd2dit
	EzTofaxxev73DJPkthcRS24G7vMFQOs=
Date: Mon, 2 Mar 2026 13:26:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next 1/2] bpf: test_run: Fix the null pointer
 dereference issue in bpf_lwt_xmit_push_encap
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260227082133.96951-1-yangfeng59949@163.com>
 <20260227082133.96951-2-yangfeng59949@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260227082133.96951-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 610C61E5E1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262915-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hust.edu.cn:email,appspotmail.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action



On 2/27/26 12:21 AM, Feng Yang wrote:
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
>   net/bpf/test_run.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..54dbda2f6329 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1156,6 +1156,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		skb->ip_summed = CHECKSUM_COMPLETE;
>   	}
>   
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT && !skb_dst(skb)) {

Has skb_dst ever been set earlier?
If not, can the "!skb_dst" test be skipped?

> +		if (!ipv6_bpf_stub) {
> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +#if IS_ENABLED(CONFIG_IPV6)
> +		rcu_read_lock();
> +		skb_dst_set_noref(skb, &net->ipv6.ip6_null_entry->dst);
> +		rcu_read_unlock();
> +#endif

Although ip6_null_entry will not be freed, this still does not
look right to use it after rcu_read_unlock(). Does it have issue to
just take the dst_hold() first and then skb_dst_set()?

Also move all changes into the IS_ENABLED(CONFIG_IPV6). Something like this:

	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
		if (IS_ENABLED(CONFIG_IPV6) && ipv6_bpf_struct) {
			dst_hold(&net->ipv6.ip6_null_entry->dst);
			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
		} else {
			pr_warn_once("Please test this program with the IPv6 module enabled\n");
			ret = -EOPNOTSUPP;
			goto out;
		}
	}

pw-bot: cr

> +	}
> +
>   	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
>   	if (ret)
>   		goto out;


