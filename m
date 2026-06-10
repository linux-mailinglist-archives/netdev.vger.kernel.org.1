Return-Path: <netdev+bounces-297794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rs1JLV6mKWqObQMAu9opvQ
	(envelope-from <netdev+bounces-297794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:01:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EC66C1D8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297794-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C68123036A25
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E93537D2;
	Wed, 10 Jun 2026 18:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F94348898
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114458; cv=none; b=oVg8x/SLcICq8/QO6hltclx7F7BASYcQFqca2a8iK6ZtS/lKlsvBcNs/YyHdPddJFD7lsUreGc0gAa+HmM98xb+BM4EGOoxEPyYBBAT9DFybI2elUbN/jmDX5rnYMp/i2WLscnuMzRVDhbw+eQ3ofKLVMl0UI5yWhk+JaPqCE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114458; c=relaxed/simple;
	bh=MniXYQb4do2iIVzJ9DELQKdgyPMMIuCicatH0dDVXyI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LMEQ+z9vRPxYoZgZjCJZ40k84zBombvqxmQ6RqdFHo0AWn6YXmhxYA2W6Pv7grswjBknyaguFfiUPrOO/fgBZBm55197XsO8J+2+PNq/KzzxjmEzUClgIpyN9iEV+Yv1ThvWli+xrgkq+eAWEV7BxT7bvhJwwFBn7VhHgeVZCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so48695755e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 11:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114455; x=1781719255;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+84T65v4YYHIMc3PaDYOWdR8FcKLeBIHIqUF/c5BsI=;
        b=Uyj54TcLCrbBMECheWMyNtL4xUmcIzIbNE5phoGcE9ljCc7GBUxNCkBMEwOQsyWg9S
         7J/ramBUGj/ymG6P9xmudWEvmvRMghj/H27vZ/zgPlzbNz1ZBsdfH6Ma/O/gKgZSzQPe
         PfIDwa9vq5OiBNOcUiH8Fevcag14eEiWbXCSOmBSuAV+1lSoGfUlNWoKtmtqbIENG4KW
         lCyUJudFUSl34iZhyzrnfjbF0zFrwF+Qc67yAMJzoW3wGMEubo9fOjgqmSg1ACidr25g
         Wcs0SwoKMX/gt5w6dOR6Dr/p1orruzAwgWy+eoZVo41zNri4/KYSl8M9HBDqpiZ0gZAh
         eEEg==
X-Forwarded-Encrypted: i=1; AFNElJ9gOTB+CdZ27qK2Nwi2UXkbaQ325aBJxQ/gWGhV9lDIiA8XrpULjx3Rel3a2oraYp1CS+lfmWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1mK6FD0Nnr/SYoQYe16iL5Ymev6D4VIwnhNdel8QqupgfkKA
	d+7cHkOdN5XhVS8myV33dbGolt2tLm2s3/D3mf/ogBbfAf5xnMUHimNT
X-Gm-Gg: Acq92OEFuJq/jERbLs24q0Y+vnZ/NLeE2GrDgQHdBbcX4LA2jYrxS90c6YQ4WxgvTXh
	PYPbDCIbSHHRFNdHGJeZjPcf2OXnUB+jwGklfCfjb5Ykg8ukG2ywsGxU0XGrJ2oYblOzcaOdhEL
	qZgOgJ9fdTDunlZSIyz2rXYFMP3QMnvTshSeQA0G5AgVr5UDu4nFgwVEESv7m+0R/VaJJHVyBNB
	f8mFerHkBRZ6aZWajFMCSz59ReHnPUmgyLsczWC16rHDtlkxL5gFA2+q2yc9oNFR9ShyhejK8Ca
	XpI4YrfMbqUB6eSCI8Z3tvbI6TetU7CfNYbWXAEYu7ihaBMhi2lirXivRIljM0nCPZYroGcScE0
	iUkpdGIh1UxXlx9s0ilwZJojnQ5WLZr6z2aQsQ2qc+TtyoD0SQwi6Xux/on3sYIecPT96EQ554+
	3XhII59mnTCt/UzRJYCpWN/hSFgANJgRhDNQr8KTUac+8Mf/1/0620MXHi0i0ueDw=
X-Received: by 2002:a05:600c:818c:b0:490:6237:521d with SMTP id 5b1f17b1804b1-490c25b3ca5mr450206065e9.13.1781114455050;
        Wed, 10 Jun 2026 11:00:55 -0700 (PDT)
Received: from [192.168.88.241] (37-48-44-84.nat.epc.tmcz.cz. [37.48.44.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dcaa924bsm152446625e9.1.2026.06.10.11.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 11:00:54 -0700 (PDT)
Message-ID: <6831f6a7-7321-4657-8255-28252b1a3176@ovn.org>
Date: Wed, 10 Jun 2026 20:00:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 Kees Cook <kees@kernel.org>
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from
 geneve_xmit()
To: Johan Thomsen <write@ownrisk.dk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
 <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
 <CAKv6aAPoo98bZ-oRk34huUtD3=j7EuGcL2sOLBB_rwzf4vpj3A@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAKv6aAPoo98bZ-oRk34huUtD3=j7EuGcL2sOLBB_rwzf4vpj3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297794-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:kees@kernel.org,m:write@ownrisk.dk,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 578EC66C1D8

On 6/10/26 3:10 PM, Johan Thomsen wrote:
> Hi Ilya,
> 
> Sorry for the late follow-up.
> Your patch has now run without crashes in my setup for 36 hours and
> I'm unable to re-trigger a panic.
> 
>> But the operation in the diff above is kind of pointless as the memcpy
>> itself will copy the value again.
> 
> Right. So it would probably need at least a comment, if that ends up
> becoming the final fix.
> I'm not a kernel dev and I don't know what is the right thing to do here.
> 
> Happy to test alternative patches if needed.

OK.  Thanks for testing.

> 
> BR
> Johan
> 
> Den man. 8. jun. 2026 kl. 11.41 skrev Ilya Maximets <i.maximets@ovn.org>:
>>
>> On 6/8/26 10:25 AM, Johan Thomsen wrote:
>>> Hello,
>>>
>>> I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
>>> transmit path on a Talos Linux node running Kube-ovn with Geneve
>>> overlay and KubeVirt VM traffic.
>>>
>>> Environment:
>>>
>>> Kernel: 6.18.33-talos
>>> Distro: Talos v1.13.3
>>>
>>> Compiler/config:
>>>
>>> CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
>>> CONFIG_CC_IS_CLANG=y
>>> CONFIG_LTO=y
>>> CONFIG_LTO_CLANG=y
>>> CONFIG_LTO_CLANG_THIN=y
>>> CONFIG_FORTIFY_SOURCE=y
>>>
>>> Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
>>>
>>> NIC driver: bnxt_en
>>>
>>> Workload/network:
>>>
>>> Kube-OVN, Geneve overlay
>>> Open vSwitch datapath
>>> KubeVirt/QEMU VM traffic via vhost/tap
>>>
>>> Relevant console output:
>>>
>>> [  648.742603] memcpy: detected buffer overflow: 104 byte write of
>>> buffer size 96
>>> [  648.749907] WARNING: CPU: 61 PID: 27020 at
>>> lib/string_helpers.c:1036 __fortify_report+0x45/0x60
>>> [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
>>> nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
>>> nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
>>> [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
>>> tainted 6.18.29-talos #1 PREEMPT(none)
>>> [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
>>> Gen11, BIOS 2.84 11/05/2025
>>> [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
>>> [  648.895152]  geneve_xmit+0x7fe/0xe00
>>> [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
>>> [  648.911479]  __dev_queue_xmit+0x864/0xf40
>>> [  648.919688]  do_execute_actions+0x9b9/0x1be0
>>> [  648.927727]  ovs_execute_actions+0x58/0x170
>>> [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
>>> [  648.936370]  ovs_vport_receive+0x90/0x100
>>> [  648.940428]  netdev_frame_hook+0x146/0x1a0
>>> [  648.954093]  __netif_receive_skb+0x3f/0x160
>>> [  648.958324]  process_backlog+0x10c/0x210
>>> [  648.962295]  __napi_poll+0x2f/0x190
>>> [  648.965832]  net_rx_action+0x2e3/0x500
>>> [  648.969632]  handle_softirqs+0xe7/0x310
>>> [  648.985387]  tun_get_user+0x137e/0x1510
>>> [  649.005878]  handle_tx+0x41f/0xd30
>>> [  649.029014]  vhost_run_work_list+0x52/0x90
>>> [  649.033162]  vhost_task_fn+0xc2/0x140
>>> [  649.064145] ---[ end trace 0000000000000000 ]---
>>> [  649.068820] ------------[ cut here ]------------
>>> [  649.073489] kernel BUG at lib/string_helpers.c:1043!
>>>
>>> I don't know whether this is a real overflow or a FORTIFY false-positive.
>>
>> Looks like a false-positive from the __counted_by fortification.
>>
>> I'd guess something like this would fit it:
>>
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 1fc2fb03ce3f9..e51c3795da474 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>         if (!new_md)
>>                 return ERR_PTR(-ENOMEM);
>>
>> +       new_md->u.tun_info.options_len = md_size;
>>         memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>>                sizeof(struct ip_tunnel_info) + md_size);
>>  #ifdef CONFIG_DST_CACHE
>> ---
>>
>> Johan, could you try this in your setup?
>>
>> The memory was actually allocated for the options, but the structure
>> is zeroed out on allocation, so the __counted_by check doesn't work
>> properly for the initial initialization copy.
>>
>> But the operation in the diff above is kind of pointless as the memcpy
>> itself will copy the value again.  So, I'm not sure if that's the right
>> solution here.
>>
>> Alternative might be to revert the kmalloc_flex back to the simple
>> kmalloc in metadata_dst_alloc.

A little less icky alternative might be to just split the copy in two:

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f9..996ae8350360a 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -164,8 +164,12 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
 
+	/* Copy in two stages to keep the __counted_by happy. */
 	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
-	       sizeof(struct ip_tunnel_info) + md_size);
+	       sizeof(struct ip_tunnel_info));
+	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
+	       ip_tunnel_info_opts(&md_dst->u.tun_info),
+	       md_size);
 #ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
---

Adding netdev maintainers for more opinions.

>>
>> CC: Kees
>>
>> Best regards, Ilya Maximets.
>>
>>>
>>> I cannot reproduce the issue on Talos v1.12.X which uses a gcc built
>>> kernel, whereas the affected kernel is built with clang. Don't know
>>> whether this is relevant here.
>>>
>>> I am currently trying to make a reliable reproducer, but I can almost
>>> always trigger the issue when iperf stressing the VM-network.
>>>
>>> Please let me know if this should go to a more specific
>>> maintainer/list or further info is needed. I am able to test candidate
>>> patches if provided.
>>>
>>> Downstream bug reports:
>>> https://github.com/siderolabs/talos/issues/13440
>>> https://github.com/kubeovn/kube-ovn/issues/6767
>>>
>>> Thanks,
>>> Johan
>>


