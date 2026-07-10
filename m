Return-Path: <netdev+bounces-306616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wk27M0gOUWoA+wIAu9opvQ
	(envelope-from <netdev+bounces-306616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AFF73C2FF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OafPM210;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306616-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245DB3058732
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6336405A;
	Fri, 10 Jul 2026 15:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3E363C43
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:16:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696610; cv=none; b=S0D2IdDZ2UO4rCD3fFLSVXAmI95AQwTU4y+76qJnuz4YWWgyr7911SS06kngew9kBJ0pzQnm+s79x0hG1u9Dk2dCAFyEXgOvC6D91vrn2aNNwMuerDtGjRHvq8IWbRlgUrDM57405Y2CdrevlVMsEl1xoRwhcEHWPqjzWZ7O2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696610; c=relaxed/simple;
	bh=1JtLlpRRACfvKsroXlBPtY0Dc9Plol0JKs7d++0dOtM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P48TfFkpKm3+DjTyWvT0g/L3c4T3wWVns3kcY0VWz/XzTQVUCPd4pHiBRqvlpSl8OwKjE32DuR5l1kJQtIEKBB5x9WPwoInNQ0awSp6rPGJeQG5dNcviPA+zODkSZUZ+jQ6Qh2TC1zjNWhiV4epB/4AFUGbIo+nYCUL7m0ARhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OafPM210; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so1851426a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696607; x=1784301407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzG2aZr0GYhbw005TMkhGo2BjpwTfepBU/AvlO3Dhu0=;
        b=OafPM210nDaTDDA0Jg3x2Z8y87YzQc3bg8n/ui5vv5NunACoDuAUzdf6Yvu6oao8SF
         VNddYkFKarHiSMzNaCKTArgnXBeJfXOfTnz2/qcbV9BCRMMToNVw5y4f6mszoLZo2BkC
         F4mZIXAKijH/M226GGDS92ln3iQN5OVmAsWS0yy9KrKSM25lXDQIa5v8aDNRVdBa5JVj
         M9pxdyF7sgtfjYYA6VdP+iu9ssd4m9+NM+9ekd09xVpUh2lcZ6/Kmq1b2UoVK/FHWlxA
         +OdMAlcia2875nCE7howYpYa/CAIc4kmZTlPJkbag4RCp4lDYh506M0m/+KUXfzDX/cj
         OvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696607; x=1784301407;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzG2aZr0GYhbw005TMkhGo2BjpwTfepBU/AvlO3Dhu0=;
        b=lmsBwkmWzxto1i5Z5QYzPEQB/2zL3t3A/UOjC+JLEjNRDLwXRXwwXy1GQNgaa+/7tR
         sCNL66KKkxzRGkU8N6tVxFzffyzwE/zxmXVFNp9Bey4cXHnE8zQ4wTtTsx5m8w6Lyqqw
         9EAHuDwsvjto4x1BYvAGNfXTUNvyOjSXGiouQj3jeENtUuPKQoalO9cy2WXahVbRta4A
         vYaQnq4Er4WHuzxCy/Kn+vRMfDci4WysuZKZaZXgVvJObsOU0OiLAjoT3cPORbgWgPb/
         YRpr11dcmbkcBMV4ZdANo6SEzgxGbuFOVx5RdaVBuY73eudEf8GHIchyqOBTzItoBXAF
         XCNw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9kAVG0/WNklDoZASNiVauBmPVT+zLin5vaRx0ow5rCA4aaQ3NKTCo2r1/QNVyBF6rRJoMkzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDMIQ8FT/IpNsbCiKhqswGoJHxBIRRejCvK5LY3jfhYvOL6vU
	XebCXXOUp1C+EOmPGCCNSYh5RCOwjk0ruocDUDpDjfjxkoAHAKKCJcxC
X-Gm-Gg: AfdE7clpyQChkrAVgzjJFn384I8gHvBkQyThn0Vu/lUdxz9Cpl/Xg67NvlafTx7paBQ
	ad8e9p88P59QztUf66FIC9EHQf/+lXBUhwOYza27WWEEOAhaFnF+7JsYoYd/jbegb15SlZD0IJS
	qjGzG+iYNh+YFz6ispDV3YIU3gfF+v4Y+WZ6fq95i7Mr+jmkCMCv01LxBqpsTyt2/5lGkNXmkAv
	BuYDtTvARGUzYhB8fQ0jK3o/RVizEvCOcUoKbBZ2C2bBso+Gtq3apqdKH+387dqEvP45OgOvOef
	uTTXrTLD0nWhQ3KrPDXZ/ns5/S+WCnNcZdvVBW2c4yNqJe8wPa3KgguXwDvEnrpdSfj0dqAhNqI
	iUuBT8uvyJ/QVVszcBPC5e40tGbVi7el8SbH1WKVLfwMC1PvJ7+NbEpQVf3o+93G2mVrUvMTNSt
	UvELlk3yYqXcUzToTfue/jQtXAGkTsYU8/Eg4qHQrxVau8k7g8BeYCHuuGiDj3NjYVtdDh32x09
	jYIB7kgn41w4FpCn3fg3NvpXIkZ86Hy2jPQ/ruDxgR2/PrDO5gm3NdvOweyMbuCZs4RU4YiEBTD
	xF2jaWgR7mG/LWSSJqjaQg0=
X-Received: by 2002:a17:906:4fcf:b0:c15:b96f:c3d1 with SMTP id a640c23a62f3a-c15ce06ed7emr537056666b.41.1783696606976;
        Fri, 10 Jul 2026 08:16:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15f272141dsm204948866b.59.2026.07.10.08.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:16:46 -0700 (PDT)
Message-ID: <12451f0d-7e5b-4697-a734-8200944b204f@gmail.com>
Date: Fri, 10 Jul 2026 17:16:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add
 nf_flow_rule_bridge()
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-4-ericwouds@gmail.com> <ak4dAXHDmTDRr7-b@chamomile>
 <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com> <alC64Vg_xihR-huW@chamomile>
Content-Language: en-US
In-Reply-To: <alC64Vg_xihR-huW@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,bridge_fastpath.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29AFF73C2FF



On 7/10/26 11:26 AM, Pablo Neira Ayuso wrote:
> Hi Eric,
> 
> On Wed, Jul 08, 2026 at 08:36:11PM +0200, Eric Woudstra wrote:
>> On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
>>> On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
>>>> Add nf_flow_rule_bridge().
>>>>
>>>> It only calls the common rule and adds the redirect.
>>>
>>> I decided to use the new _unsupp() function, so we don't pretend
>>> bridge hw offload is already supported. We will need a driver before
>>> we can add this, this stub does not provide much. I guess your goal
>>> was just to avoid a crash here.
>>
>> No, I am already using hw_offload between bridged interfaces
>> on the mt7986 succesfully for almost 2 years.
>> It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
>> between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)
> 
> Do you utilize the existing mt7986 driver in-tree without changes to
> achive this hardware offload? Or you have still have out-of-tree
> patches that need to be merged to achive this?
> 

I do not change anything about the mediatek drivers to achieve hardware
offload. No patch needed to fix hardware offload.

However I do have a small fix for the offloading towards the mediatek
wifi interface. This is a fix for the software fastpath already.
Also with hardware offload to wifi interface, once the software fastpath
is setup correctly (needs this patch), then the hardware offload functions
correctly without any further patch. See patch:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101525.358016-1-ericwouds@gmail.com/

It is not reviewed yet.

>> It can also be tested with my bridge_fastpath.sh selftest script.
>> This script uses veth-device pairs to test the software fastpath.
>> It can also use 2 real interfaces interconnected in a loop of copper,
>> when chosen with commandline arguments. Then it tests software- and
>> hardware-fastpath. It also tests many different scenarios.
>>
>> So this is why I've added it, as it is already functional. If a software
>> fastpath is setup correctly, the hardware fastpath is also functional.
> 
> Thanks for explaining.
> 
> I am targetting at a minimal subset of the flowtable bridge support at
> this stage. There is a need to make progress with the
> nf_conntrack_bridge counterpart before the flowtable bridge can get
> more features (namely, bridge vlan filtering support).

I did send a newer version of my patch-set for nf_conntrack_bridge,
last version also adding support to defrag/refrag. See:

https://patchwork.ozlabs.org/project/netfilter-devel/cover/20260512103347.102746-1-ericwouds@gmail.com/

I've added testcases for defrag/refrag to the bridge_fastpath.sh selftest
script (v5), so I know it is functional.

For proper vlan filtering support, I do also believe you will need to
introduce DEV_PATH_BR_VLAN_KEEP_HW, or do something similar. See:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101722.358640-1-ericwouds@gmail.com/


