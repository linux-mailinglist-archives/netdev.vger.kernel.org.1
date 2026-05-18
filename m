Return-Path: <netdev+bounces-289085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCjpFqkfC2q8DgUAu9opvQ
	(envelope-from <netdev+bounces-289085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:18:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC856E919
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08358300EC4C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24846AF24;
	Mon, 18 May 2026 14:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DE339875
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113185; cv=none; b=Mf3oWo9I/8bMWmroXLYCM2g4L6WeGV4RrcAGng8mFSagBxKGKjL/siPK8IwBIzKPx5BrHKGseOl+ww3tAvZJRLncrHxlE6JU0M7Z/fbz+AqdrnjaxWYrN98DBzZ7ibVi70jWO0Ho5rfo1h1kMk+yCMRnnBocrWQLl4vfJLT0qXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113185; c=relaxed/simple;
	bh=QfKnN2J0Z1rSedjGD8iI/RcRJYl6sXvZznvqvCG85Pk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tj+LuuioLIzldpdp5UhqNsOqDdcqqNSCBKPsFJgt8skusYF1IMI0YndVbc1iBK/JrZ+mahb5Ca3LSgaR4sO9ZE4RBwaRYW72z0wYjilwbAk2w02+SELaSUFAN+7kJrItCd3xxg6uZJkxqoVuhu6zaPKuAMNtjP8oLBrOvRWFDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1270483f8f.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113183; x=1779717983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Epw+sI4gJgw8udXSjjb8W2kNl8WHV3YE3hirzW370nU=;
        b=sMVkaEOeUoxNPi2wq6SlkmBqSjlutVGw7/opgef67AIV2iY0SDj9v/YmZugtjh78kn
         vSAPgDGxHrTbqJG+FfUSVY3FuPsOSsAC1+Tj4I/sBdia4BFuf7sui4Qr1u5dnW4u0nNo
         FUpsPbrLleedgFt2m6wghkJ40z4EykVzGWJcjXHCCybm/ujp/C2KEn7k5I6pGyk4IYPW
         CakZxxt3VUB9wF5jHfS5ZdKVgm5c/ogAkYEa9b3rzuIopdPwPdiyiYvP1KrbKhEwNeb1
         h9Np/yTOdGj3HfnXdw6fHz/aQFNsoSW/mpZl98zYFrREfhMQf208D/Xe7/y/dp2grnj0
         8KhQ==
X-Forwarded-Encrypted: i=1; AFNElJ98JubZJxwzGL8yEGwABxWEcZwoxKNX9C0I36jqZN0hMKxIeW8ijz0fFNJkAX6m5O2Soe2ZvLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/HCtzLVW7WW0var/RyyXTaDyD8HnnXxkne2M6Xf5y9G+Abjr
	CYPBxyS7xLDAUaKGyBCIA74nTxhKpgzBxPWOQAmB4YTFv+ugxlR6apU+
X-Gm-Gg: Acq92OFQFJtiW2944lAqnNf2yNbmI4JCNMotp5HJwniXneTEEAM9WMUcCH0urmtUZQz
	f5+47eMHsn0I1TVLbfuM+PNyQeB5wzMxQU+mzeVRTPf8iunLna1PebeYRp55YGG26F2h+J5CuEX
	DMiderpjrRFctSOwJxwVKwLMrSWGZsHZugCdushhPS2xVqQVSdtb/hYaVLH5xshGpVa9s7kPpmP
	9YUsyRu/+a8WiiG/+EtEQUVg0p/WA5lg7obDHwBAP2iGt4xdyswMUXztdZ8xgMsa0Z+yvykgTOS
	5ZUnATysu1tFSVRhf+oDqrIWManRQU/SNXJ9oizwSXq9bV8CkFdv+1oqpyBsr0ROSb5uXBFhWDk
	NdELKbUzLEw5RXtrjj54LpICwyzbbVGdvT1lYxweqwf4gpalmaDhs8biChVnaqX8IhHIbgzpViX
	2f1Iqzg9kxNKXmbO76ojN8g6CrGUIZ/UIYyek/OZarwZ9kQt6eRn8Rze5O3f/3T/KuZQ==
X-Received: by 2002:a05:6000:2313:b0:448:7049:a6c9 with SMTP id ffacd0b85a97d-45e5c5b387bmr22786592f8f.5.1779113182360;
        Mon, 18 May 2026 07:06:22 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm41266679f8f.13.2026.05.18.07.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:06:21 -0700 (PDT)
Message-ID: <f695ac3a-aec9-41fd-a3d3-9537ea4c50f1@ovn.org>
Date: Mon, 18 May 2026 16:06:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
Subject: Re: [PATCH net 3/5] net: netlink: don't set nsid on local
 notifications
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-4-i.maximets@ovn.org>
 <40603dce-f801-42ad-96ec-c8c0a57e5aae@6wind.com>
 <5344852f-e920-4232-9b54-5b22f6c8a1d3@ovn.org>
 <5d19e543-ac3b-4d32-a464-377d03cde500@6wind.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <5d19e543-ac3b-4d32-a464-377d03cde500@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-289085-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ovn.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ovn.org:mid]
X-Rspamd-Queue-Id: 8FFC856E919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:56 PM, Nicolas Dichtel wrote:
> Le 18/05/2026 à 14:46, Ilya Maximets a écrit :
> 
> [snip]
> 
>> True and also not really.  The main problem is that ID can be allocated
>> at any point in time, so the application needs to listen for NEW messages
>> on the same socket that it is listening for the events that are interesting
>> to it (to avoid races), if it doesn't want to make a separate GET request
>> per notification or track all the IDs that were previously checked.  It's a
>> non-trivial amount of code depending on the application structure.
> iproute2 handles it ;-)

I don't think it does.  If I run this in one terminal:

ip netns add test-ns
ip netns exec test-ns ip monitor link all-nsid

And then in the other terminal:

ip -n test-ns link add dummy1 type dummy
ip netns exec test-ns ip netns set test-ns 100
ip -n test-ns link add dummy2 type dummy
ip netns del test-ns

I see the following events:

[nsid current]2: dummy1: <BROADCAST,NOARP> ...
[nsid 100]3: dummy2: <BROADCAST,NOARP> ...

Which is confusing to the user (myself) and shows that iproute2 doesn't
know or doesn't care (which may be fine for this particular command) that
100 is the ID of the current namespace.

> You certainly need to maintain a cache, but once a nsid is allocated, it never
> changes until the netns is deleted.
> 
>>
>> Alternative is to always try and allocate the self-referential mapping on
>> the application startup and remember it, and then check that no-id, -1 and
>> the allocated one all mean 'current'.Yep.
> 
>>
>>>
>>>>
>>>> A search though open-source projects doesn't reveal any projects
>>>> that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
>>>> self-referential NSIDs.  Quite the opposite, ovs-vswitchd relies
>>>> on the metadata to not be present to separate local and remote
>>>> events.  And the 'ip monitor' relies on the metadata to not be present
>>>> to show '[nsid current]', though this is more like "print 'current'
>>>> if there is nothing to print" situation, but still can be a little
>>>> confusing for the user to see an ID for a local event.
>>>
>>> We (6WIND) are using NETLINK_LISTEN_ALL_NSID. Like iproute2, 'current' is
>>> assumed if there is no nsid, else the corresponding netns is checked (which may
>>> match the current netns).
>>
>> OK.  It sounds like this one patch will not affect your use case than,
>> which is good to know.  Thanks!
> Probably not, but I didn't say this ;-)
> I need to make some tests with your series.

Note: sashiko points out that it may be possible to have stale values reported, so
re-setting the nsid_is_set flag unconditionally before the check may be required,
e.g.:

+  NETLINK_CB(p->skb2).nsid_is_set = false;
   if (!net_eq(sock_net(sk), p->net)) {
       NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
       if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
           NETLINK_CB(p->skb2).nsid_is_set = true;
   }

I'll include that in v2.

This appears to be a missed case of the earlier fix:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7212462fa6fd
But made worse by my patch.

Best regards, Ilya Maximets.

