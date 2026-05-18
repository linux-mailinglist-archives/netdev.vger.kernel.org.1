Return-Path: <netdev+bounces-289123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBn9ID9CC2qsFAUAu9opvQ
	(envelope-from <netdev+bounces-289123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8596571246
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564A43038C64
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53AA48A2D1;
	Mon, 18 May 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFJPUjZo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B13750AD;
	Mon, 18 May 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122416; cv=none; b=RVH24UHciInluzd3y3hzSOrMh8mpZAUirW7biGF23lx3jj6Ie0iPJ8FqDEu0lu1QDbjBd5QOiUnhkYhPXSsGR0dgCpdUzGZdd+3db6duoFXGTI9l5A+GEEq4M3ZcLLTjou6LJsI1V8rlE4CMTXvqSj20WG2iPFfKEiuqiZEdAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122416; c=relaxed/simple;
	bh=RWbSGhrUoxks6TUNT0l3dkNYX/kJcbAy1x32QYTlojc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDp8o9zYDdalRLpQGEALBTHXM0XphuSnsqNEJijpU8hm9Tm0gUnfnnsp56tx9zCqi+ivKBvUfBp035wI3xfJVLpFbWBX6MKG4PQ1PLS29oMruJV9ojlR9TMlVlu0gzJmYWTlWcjvB6Hmt3soxIGiF5JHnhqzg/RbDEUJMxbJbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFJPUjZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D2CC2BCB7;
	Mon, 18 May 2026 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779122416;
	bh=RWbSGhrUoxks6TUNT0l3dkNYX/kJcbAy1x32QYTlojc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFJPUjZo3fNGJji9ooyatZr64YtYbDBFkxER8fi7UOmKQGNRVphRXjzZAn4py+f02
	 J9Ou9jCwZ/wxnXTUEefMmegqPN8zf5khMs8oF9f4HrJXXhRbtXPrQkZSSwqyuEvPfY
	 u/pu21y+OizjubAkcwZDYItgV5pLX2gtdRMoNEhwxfcd0NHY6Cz42tnyGw7xyPf2SC
	 rV8DYkdW/BwViTjXxAcEkqcJi6jGJcU6htwuoVtjv9anumHzA+Oo84z7muqsWel7Kw
	 /boAQaJDbCQI9vUgQ0qAC3LGST7kx4HGYnSns0kmDvmpMa5wwvBXgRbYfPJFrshA3c
	 lAz+qkVVCqq0A==
Message-ID: <2942dd24-3b6f-4e88-acb2-67d35ea8938b@kernel.org>
Date: Mon, 18 May 2026 18:40:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Simon Sundberg <Simon.Sundberg@kau.se>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
 <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
 <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,kau.se,toke.dk,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,doi.org:url,diva-portal.org:url,tencent.com:email]
X-Rspamd-Queue-Id: E8596571246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 18/05/2026 15.53, Jason Xing wrote:
> On Mon, May 18, 2026 at 9:01 PM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 18/05/2026 10.23, Jason Xing wrote:
>>> From: Jason Xing <kernelxing@tencent.com>
>>>
>>> Add two if statements to accurately isolate bpf timestamping and so
>>> timestamping. They can work respectively.
>>>
>>> As to so_timestamping, only add a loose condition via report flags
>>> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
>>> and performance impact. If the loose condition is hit,
>>> tcp_recv_timestamp() is able to handle the exact case and doesn't
>>> hamper the existing timestamping feature.
>>>
>>> Make it work in TCP protocol.
>>>
>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>>> ---
>>>    net/ipv4/tcp.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 21ece4c71612..64c69bb3578a 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>>>        release_sock(sk);
>>>
>>>        if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
>>> -             if (cmsg_flags & TCP_CMSG_TS)
>>> -                     tcp_recv_timestamp(msg, sk, &tss);
>>> +             if (cmsg_flags & TCP_CMSG_TS) {
>>> +                     u32 tsflags = READ_ONCE(sk->sk_tsflags);
>>> +
>>> +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
>>> +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
>>> +                             bpf_skops_rx_timestamping(sk, &tss,
>>> +                                                       BPF_SOCK_OPS_TSTAMP_RCV_CB);
>>
>> Does this mean I can enable timestamp reading per cgroup?
> 
> Yes, I think so, but I didn't try. One of the natures of sockopt
> feature is supporting cgroup attach.
> cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
> something that you're looking for.
> 

Sound good

> IIUC, you can attach the prog onto the cgroup where all the sockets
> are set using the bpf timestamping function. So the current impl is
> cleaner and has better isolation (to filter out those unmatched
> flows).
> 
>>
>> In Simon's netstacklat[1] tool we are forced process all RX timestamp
>> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] on
>> the cgroup IDs that we are interested in (which is a significant
>> overhead, as this is deployed at Cloudflare production scale).
> 
> I can feel the pain when filtering in this kind of relatively hot
> path, which is what I'm trying to avoid internally. What I've done in
> production (to cover those old kernels) is to just let the kernel
> print the information, that's it, and there is an agent continuously
> gathering the data, doing the match and computing latency. But it's
> overall complicated.
> 

I hope you don't mean your internal/old approach was using printk and 
then analyzing this data.

> Many thanks here, I'm always interested in hearing more useful and
> real requirements and fancy ideas on how to monitor the latency :) Now

Simon Sundberg <Simon.Sundberg@kau.se> have many more fancy ideas on how 
to monitor the latency.
The netstacklat tool is part of Simon's PhD thesis:
- https://doi.org/10.59217/qklv6836

And we even gotten a paper accepted on netstacklat:
- 
https://kau.diva-portal.org/smash/record.jsf?pid=diva2%3A2034009&dswid=3032


> I'm still struggling to port the internal functions to bpf
> timestamping.
> 

Good luck, feel free to get inspired by our netstacklat tool.
Key point is to let BPF store latency histograms and then let userspace
periodically consume these - as heatmaps.

We are proposing to add 'netstacklat' as a new libbpf-tools utility
- https://github.com/iovisor/bcc/issues/5510


>>
>>
>> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat
>>
>> [2]
>> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/netstacklat.bpf.c#L484-L488
>>
>>
>>> +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
>>> +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
>>> +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
>>> +                             tcp_recv_timestamp(msg, sk, &tss);
>>> +             }
>>>                if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
>>>                        msg->msg_inq = tcp_inq_hint(sk);
>>>                        if (cmsg_flags & TCP_CMSG_INQ)
>>


