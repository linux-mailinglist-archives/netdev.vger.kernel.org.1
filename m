Return-Path: <netdev+bounces-259119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILx0NrGulGkPGgIAu9opvQ
	(envelope-from <netdev+bounces-259119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:08:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67614EEA1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA5A130107B1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C7293C4E;
	Tue, 17 Feb 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VsSJSaeR"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4C296BD0
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351726; cv=none; b=YLeE4H24VL6CwVG9WXRJ17g6eC1fss8JijBqi1RoBg8cL3V+pM2+CvKx7vdTyRaT62nuEAQvqb5ZGhhFfjYKOP3vutIWLbCwAQ9wc0RwW6yRRME4qgVdXo8BWvfSXfgyrDD7iTdssdxpFna+FtblqMtzJICWT3hWmesTxy/oDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351726; c=relaxed/simple;
	bh=ycF+7v42zRTnHi/GMd/x4i9qxB7SeD/1V8IUjeTQCxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6MvwSO3fNhoCvSuxqBMZlToaHu3iBEgqDhtGflv8SUOj4V7BVciCCRqxBEg/18c67/vJxSufTewnbwgwaxCcBWhxIwL3bPf2Rq8NeHJ2mTDzy/60ENUVysXD6mxy7tc4/tlKsJWST2xG2O7tgYxrs/005dk0hBBr1Y+5lFkDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VsSJSaeR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6528c028-1224-4737-b902-e631641ddb37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771351719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEE/Z1fbaRezKoZH3eRr6XBTIsw8MYEL8z8yb4RF9ZQ=;
	b=VsSJSaeRoYlY1pmRFMhKo2ybO1nHNgoDdYZuXdUGMb6LZeuvxLHT6OjoRaNZzhRWy35bYi
	Md0AW+wlfz1CZQCB4KkVDBXXI9tVaHZBj6CczumRCuIK43djV+t6HxETf8pGhPc+DUaX9L
	myyaZDRGiQCVv0/2uig/oaTf3Pq3fG0=
Date: Tue, 17 Feb 2026 10:08:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <249d6576-2259-4785-87b6-619052b4ce75@linux.dev>
 <20260211075240.70095-1-yangfeng59949@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260211075240.70095-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259119-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:email,kylinos.cn:email]
X-Rspamd-Queue-Id: 7D67614EEA1
X-Rspamd-Action: no action



On 2/10/26 11:52 PM, Feng Yang wrote:
> On Tue, 10 Feb 2026 11:10:03 -0800 Martin KaFai Lau <martin.lau@linux.dev> wrote:
> 
>> On 2/10/26 1:06 AM, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>> The bpf_lwt_xmit_push_encap helper needs to access skb_dst(skb)->dev to
>>> calculate the needed headroom:
>>>
>>> 	err = skb_cow_head(skb,
>>> 			   len + LL_RESERVED_SPACE(skb_dst(skb)->dev));
>>>
>>> But skb->_skb_refdst may not be initialized when the skb is set up by
>>> bpf_prog_test_run_skb function. Executing bpf_lwt_push_ip_encap function
>>> in this scenario will trigger null pointer dereference, causing a kernel
>>> crash as Yinhao reported:
>>>
>>> [  105.186365] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> [  105.186382] #PF: supervisor read access in kernel mode
>>> [  105.186388] #PF: error_code(0x0000) - not-present page
>>> [  105.186393] PGD 121d3d067 P4D 121d3d067 PUD 106c83067 PMD 0
>>> [  105.186404] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>> [  105.186412] CPU: 3 PID: 3250 Comm: poc Kdump: loaded Not tainted 6.19.0-rc5 #1
>>> [  105.186423] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>> [  105.186427] RIP: 0010:bpf_lwt_push_ip_encap+0x1eb/0x520
>>> [  105.186443] Code: 0f 84 de 01 00 00 0f b7 4a 04 66 85 c9 0f 85 47 01 00 00 31 c0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 8b 73 58 48 83 e6 fe <48> 8b 36 0f > b7 be ec 00 00 00 0f b7 b6 e6 00 00 00 01 fe 83 e6 f0
>>> [  105.186449] RSP: 0018:ffffbb0e0387bc50 EFLAGS: 00010246
>>> [  105.186455] RAX: 000000000000004e RBX: ffff94c74e036500 RCX: ffff94c74874da00
>>> [  105.186460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff94c74e036500
>>> [  105.186463] RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000000000
>>> [  105.186467] R10: ffffbb0e0387bd50 R11: 0000000000000000 R12: ffffbb0e0387bc98
>>> [  105.186471] R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000002
>>> [  105.186484] FS:  00007f166aa4d680(0000) GS:ffff94c8b7780000(0000) knlGS:0000000000000000
>>> [  105.186490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  105.186494] CR2: 0000000000000000 CR3: 000000015eade001 CR4: 0000000000770ee0
>>> [  105.186499] PKRU: 55555554
>>> [  105.186502] Call Trace:
>>> [  105.186507]  <TASK>
>>> [  105.186513]  bpf_lwt_xmit_push_encap+0x2b/0x40
>>> [  105.186522]  bpf_prog_a75eaad51e517912+0x41/0x49
>>> [  105.186536]  ? kvm_clock_get_cycles+0x18/0x30
>>> [  105.186547]  ? ktime_get+0x3c/0xa0
>>> [  105.186554]  bpf_test_run+0x195/0x320
>>> [  105.186563]  ? bpf_test_run+0x10f/0x320
>>> [  105.186579]  bpf_prog_test_run_skb+0x2f5/0x4f0
>>> [  105.186590]  __sys_bpf+0x69c/0xa40
>>> [  105.186603]  __x64_sys_bpf+0x1e/0x30
>>> [  105.186611]  do_syscall_64+0x59/0x110
>>> [  105.186620]  entry_SYSCALL_64_after_hwframe+0x76/0xe0
>>> [  105.186649] RIP: 0033:0x7f166a97455d
>>>
>>> Temporarily add the setting of skb->_skb_refdst before bpf_test_run to resolve the issue.
>>>
>>> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
>>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>>> Closes: https://groups.google.com/g/hust-os-kernel-patches/c/8-a0kPpBW2s
>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>>> Tested-by: syzbot@syzkaller.appspotmail.com
>>> ---
>>> Changes in v5:
>>> - Refer to the bpf_lwt_xmit_reroute function to configure the dst parameter.
>>> - Link to v4: https://lore.kernel.org/all/20260209015111.28144-1-yangfeng59949@163.com/
>>> Changes in v4:
>>> - add rcu lock
>>> - Link to v3: https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com/
>>> Changes in v3:
>>> - use dst_init
>>> - Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
>>> Changes in v2:
>>> - Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/
>>
>> The earlier syzbot reports are crying for a selftest which is still
>> missing in v5.
>>
>> The CI has also reported errors in the test_progs. Did you run any test
>> before posting ?
> 
> My apologies. I only tested whether a crash would occur
> when using `bpf_prog_test_run_skb` to execute `bpf_lwt_push_ip_encap` without a dst entry.
> I will include a selftest in my next submission.
> 
>> pw-bot: cr
>>
>>> ---
>>>    net/bpf/test_run.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>
>>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>>> index 178c4738e63b..dbd2c44da7e5 100644
>>> --- a/net/bpf/test_run.c
>>> +++ b/net/bpf/test_run.c
>>> @@ -24,6 +24,7 @@
>>>    #include <net/netdev_rx_queue.h>
>>>    #include <net/xdp.h>
>>>    #include <net/netfilter/nf_bpf_link.h>
>>> +#include <net/ip6_route.h>
>>>    
>>>    #define CREATE_TRACE_POINTS
>>>    #include <trace/events/bpf_test_run.h>
>>> @@ -992,6 +993,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>    	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
>>>    	u32 linear_sz = kattr->test.data_size_in;
>>>    	u32 repeat = kattr->test.repeat;
>>> +	struct dst_entry *dst = NULL;
>>>    	struct __sk_buff *ctx = NULL;
>>>    	struct sk_buff *skb = NULL;
>>>    	struct sock *sk = NULL;
>>> @@ -1156,6 +1158,51 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>    		skb->ip_summed = CHECKSUM_COMPLETE;
>>>    	}
>>>    
>>> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT && !skb_dst(skb)) {
>>> +		struct flowi4 fl4 = {};
>>> +		struct flowi6 fl6 = {};
>>> +		struct rtable *rt;
>>> +
>>> +		switch (skb->protocol) {
>>> +		case htons(ETH_P_IP):
>>> +			if (sizeof(struct iphdr) <= skb_headlen(skb)) {
>>> +				fl4.saddr = ip_hdr(skb)->saddr;
>>> +				fl4.daddr = ip_hdr(skb)->daddr;
>>> +			}
>>> +
>>> +			rt = ip_route_output_key(net, &fl4);
>>
>> What can be expected from the return value rt if fl4 is 0.
> 
> If it is empty, `ip_route_output_key_hash_rcu` will assign the loopback address,
> and the returned `rt` is valid, not an error value.
> 
>>> +			if (IS_ERR(rt)) {
>>> +				ret = PTR_ERR(rt);
>>
>> I suspect this is probably what failed in CI. Add a NULL check in
>> bpf_lwt_push_ip_encap instead. No change is needed in the
>> bpf_prog_test_run_skb.
> 
> The root cause of the CI failure is that the default path was taken, resulting in a return value of -EINVAL.
> So, is your suggestion to modify the bpf_lwt_push_ip_encap function as in the v1(https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/) version?
> However, the previous suggestion was to make changes to the bpf_prog_test_run_skb function instead.
> 
> Thank you very much for your reply.
> 
>>> +				goto out;
>>> +			}
>>> +			dst = &rt->dst;
>>> +			break;
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +		case htons(ETH_P_IPV6):
>>> +			if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
>>> +				fl6.saddr = ipv6_hdr(skb)->saddr;
>>> +				fl6.daddr = ipv6_hdr(skb)->daddr;
>>> +			}
>>> +
>>> +			dst = ip6_route_output(net, NULL, &fl6);
>>> +			if (IS_ERR(dst)) {
>>> +				ret = PTR_ERR(dst);
>>> +				goto out;
>>> +			}
>>> +			break;
>>> +#endif
>>> +		default:
>>> +			ret = -EINVAL;
> 
> The reason for the CI test failure.

Make sense, but the early point stays the same: the user-provided skb 
can have unexpected data. Either an skb->protocol is not handled here, 
or the earlier dst lookup has an error. I don't know what the current 
active users left in lwt are. Unless there is an issue with missing 
skb_dst() in other mainstream program types (e.g., tc), I would prefer 
to add a check in bpf_lwt_push_ip_encap() instead of complicating 
bpf_prog_test_run_skb() further.

> 
>>> +			goto out;
>>> +		}
>>> +
>>> +		if (unlikely(dst->error)) {
>>> +			ret = dst->error;
>>> +			dst_release(dst);
>>> +			goto out;
>>> +		}
>>> +		skb_dst_set(skb, dst);
>>> +	}
>>>    	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
>>>    	if (ret)
>>>    		goto out;
> 


