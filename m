Return-Path: <netdev+bounces-259061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHhMNSWAlGmwFAIAu9opvQ
	(envelope-from <netdev+bounces-259061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:50:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD514D4BB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F48301F481
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B9329395;
	Tue, 17 Feb 2026 14:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274F2D1931
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339778; cv=none; b=FafsB2/TGb/DhC04pheNgTNlce4pVdzyRq3Ihj7cV6zCF6pjINw9ulO4RqkHZ6I6kQb0TpLs1gHi4rPK7m0Sceap9Pk2eC4nAgdrXbNVaZs07KZJ2wkkCmukME5uGts7bG1yPw+O7Mlcd4XUBYjmZMoK2/1vd4gmd5UOoaEhf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339778; c=relaxed/simple;
	bh=rmGprQdnRvVbInvi+KAMQRKrfHAPgHr/4EIQWDhy1Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY7Ij15ZHCo6Hrjbtt6o1y1lCzL/trAmMxISmrhnNkrx3Nz9rBixrajgbZrUlnRRXGP0ONg3d/VD3HZrO/9kVvGHsDIEZqti98xTr6tPZJZR+qFaQFmDZsXYa+R1lEmz11Qp2Cb7bk9zuC21VZ3EORbDvYp8flkPvGhrtP9TkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4837634de51so14579895e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771339775; x=1771944575;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZLJb4azCNSY1cvYGl6rVMmrmCf9qVmHBDxsgwM4kdM=;
        b=KPFz0LJWvU/cBh0unSheYTIsmy7NZwSvyGT7Im0W48MDubM1QWCtpod1i2lJ2NIBGP
         elcN4T7tEo8G2gryIb067A/nzZZoQZEmnyraTIvhcvHKo0DTcy9XSOnRw8DZeOgtThDW
         9wThs5a0zSO4q1hUMUbsLqFuWVJeX86i+IGeejVBJMwgmWEK2lH6pbPalamvNpbSEm6Q
         GOqzydBd9sbln5vts/KjujcXOjrOteMzmMFvizzZYA60pDNLWILAsf/z8QgcMgg5MQb2
         e0jq5K1VytPQ+Hk7QaUFS3ewzw+oii5v5k7jcZd51AztxlVfhke72SUSLAERUQqQdFBK
         JH2g==
X-Forwarded-Encrypted: i=1; AJvYcCXd6NRx0tmVFKjDu0zJfvr8MPmbtmbw68RH9Hz6WPifaSPDNY3f88IplpRHs6FINRFLLmNrztA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Lfr2tJXDZ9VCi+t7RA1owq16HzZfgHbcQMTnvMwrY1N7KEZz
	/lkr2pecJ4UbEc2YBQaqmVJVFIQjn0ajj/FGfIKQkqYtcA0bmxUpEq1p
X-Gm-Gg: AZuq6aLgPA72q79wVx7BBbU3lPjzNB8FEgPA4YXxHmfvsD2rtSPVrqzXSXhLPbXZUy5
	IyOAs7ynCQ583xQhvrNJCTPFWroPIPHMsalzl8ge0on4ZxzbS0qZhMagkG2kv3ycB+KdfBf4wI6
	Ar9lXlCdjpd74dzZAwwmgX661RiW/PKkesA9wiyscrkuCTLzs4fYQ0IXNvtDDBC33qlCZq02gzC
	NbakkwMeNqdStqb8HTBf9bxuDMuN7xUlw/pftS6Vh7QhZInmeOslYaSsxNay7JDFanSp6Rl5uBG
	TumGb3XQQPE+rNjBZX2AJ/uF07G5UmNlHzzI3jsdJ6G2dgTB7fOCBjKsvxnhLcdB+IwqsUNyS+o
	efFFhMzbo/ySvkqCnWYINKenjU6kWV/mYhWSJ7kXM8wKa4MZAYydfGaIsRG86A3wqu+QFYjnScw
	vnROCUCSb4VIltnJE2fDjnKo+UF0ZRMpdv3V+zbIGEraMMeOYmlKPaqjYD5jE=
X-Received: by 2002:a05:600c:c16b:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-48371042fb1mr232710065e9.8.1771339774811;
        Tue, 17 Feb 2026 06:49:34 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm334420735e9.10.2026.02.17.06.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 06:49:34 -0800 (PST)
Message-ID: <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org>
Date: Tue, 17 Feb 2026 15:49:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Henrik Steen <henrist@henrist.net>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>,
 GangMin Kim <km.kim1503@gmail.com>, i.maximets@ovn.org,
 Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-259061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,ovn.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ovn.org:mid]
X-Rspamd-Queue-Id: 49DD514D4BB
X-Rspamd-Action: no action

On 2/17/26 10:38 AM, Paolo Abeni wrote:
> Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet.
> 
> act_ct was never meant to be used outside of the ingress path. Making
> defrag really works for act_ct outside such constraints range from very
> difficult to completely impossible.
> 
> Address the issue making act_ct drop any packet when not attached to the
> ingress path and additionally emit a warning about the bad
> configuration.
> 
> Reported-by: GangMin Kim <km.kim1503@gmail.com>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> CC: stable@vger.kernel.org
> Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442afa7.1770394932.git.pabeni@redhat.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Catching the bad configuration at runtime instead of init time to reduce
> complexity
> ---
>  net/sched/act_ct.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 81d488655793..e8eb0d195f4a 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
>  	tcf_lastuse_update(&c->tcf_tm);
>  	tcf_action_update_bstats(&c->common, skb);
>  
> +	if (!skb_at_tc_ingress(skb)) {
> +		pr_warn_once("act_CT should be attached at ingress!\n");

Hi, Paolo.  I didn't test this yet, but I'm a little concerned about this
change.  For TC offload of OVS tunnels, we create egress qdisc for internal
ports, a.k.a. bridge ports.  This is necessary for tunnels to work.
A typical setup looks like this:

    Bridge br-int (10.0.0.1)
        Port br-int
            Interface br-int
                type: internal
        Port vm
            Interface vm
        Port vxlan0
            Interface vxlan0
                type: vxlan
                options: {remote_ip="172.31.1.1"}

    Bridge br-phy (172.31.1.100)
        Port br-phy
            Interface br-phy
                type: internal
        Port eth0
            Interface eth0

When a VM sends a packet that supposed to go through the tunnel, it enters
from the vm port and OVS forwards it into vxlan0 LWT with an appropriate
tunnel metadata.  Then it gets encapsulated and put into kernel routing to
find the next hop, which is via br-phy bridge.  Packet enters br-phy and
OVS forwards the packet to eth0.  There can be stateful processing in the
br-phy bridge involving passing packets through conntrack.

With the TC offload enabled, OVS creates following filters:

1. Ingress filter on vm interface that forwards packets to vxlan0.
2. Egress filter on br-phy interface that forwards encapsulated packets
   to eth0 interface.

If some stateful processing is involved, both of those could have act_ct
in them.

AFAIU, we have to use Egress qdisc for the br-phy, because the packet is
egressing from the kernel routing via br-phy and the ingress qdisc is not
invoked.  Ingress will be at play when packets are flowing in the opposite
direction from eth0 to br-phy, as that's where they will ingress into
standard kernel routing.

If act_tc will not be allowed on Egress, then stateful processing will
not be possible in this case in br-phy bridge.

Thoughts?

Best regards, Ilya Maximets.

