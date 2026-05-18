Return-Path: <netdev+bounces-289077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLOTOfUXC2o5/wQAu9opvQ
	(envelope-from <netdev+bounces-289077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:45:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163A56DE8A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 800943013621
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988FB185B48;
	Mon, 18 May 2026 13:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AC43634B
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111914; cv=none; b=WIcGZKX/6M06wRJyBIXuKSCv5PpfYJ986WYbZqF9NhLThdZWiQXDkn5C9dZhFwya6dpM+rx/ejVaktNLdmwGtPcUDNWR6pePbwd5lYF1RMgNKTSnaOJeTVGisuLW9Sa0rdX7vnd/pwTCoQN9t786sdXliYGJOCXjg2vIQyGChDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111914; c=relaxed/simple;
	bh=kCwLOhF+YTC+tTRQkORlL4SJtUPM4oJsy0ZyzyF2QOE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VgYF851PvNEYeeJy+0lDEYDUqpxLA6AS91kP9uzH+mECQYUvnxDI1R2uuQrQlgJQx+CVNmFO9Y/oBA2nWOPqI8ifWz2nNWMDkG0GRH6C/Os04HFVIw9ASGrpxBIvrXBNVcSdAx3T8rRGxvkdzekBhOgBFT8YE5r8Aup4NymzgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so18235855e9.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111911; x=1779716711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmdAw2WRzVLabqXPx3TFlY1NHUTLm/6QXgxYmBIrZBU=;
        b=tRJLIcfGifn6HYyi1gi5HPu9eVjkwCTc87/CIBj2Pmo++imgrIwa2qOCDVdniaxTkl
         0z4aki/m0uESbSDDCCGFZTMVoX/+DmhTBQ+HN2dhwulBpb4vjzWCQa4nmtS+5JKB9iNf
         ypDVoEqatXkk2kS9Z4WEYFdIoSRqXkRsrDAfz+Xm+f34I1YCK7zpSbslEjGuhylAJn7y
         u/nmgtbX0rmYK+f/ZF1t4YgyVKsZzKWIp81XoVxhfGhCjyUDDCih1ZiGW7kUKCB2iuq0
         Bea0P4NKeOVcV9bSx29gUTAuTej8YOx7vNwSgfm3wWL4mEK5y7CHDYprR3u7TNxgoNFk
         CVwg==
X-Forwarded-Encrypted: i=1; AFNElJ87mnGqqVjtWdBBqHLpTd/L3+NBRkTPZknougemK8j+6gUqukKJMCG2JE3u+aA9cLXGEHRJ1AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtwSgrnJ9VxCxg90HDrQLyV3qGE9DDGmvEDUZW7BB5Y/M9Dnd
	awZgAM/FMlmn1FIRUo/DFYlmUoNtwXmHgqo+cvp7C13B9XpjisLjw7cY
X-Gm-Gg: Acq92OGY879YgKEaswSqo6sKdqhvJ2+cMQwDruZjbB422Fiq4W6gGyy3omgc6Q88UF2
	raQhVlv/W6fpjFrAstGofKlzL8uYdw6NUcFicqu0GhasES9qWhLV7Lry7g3TcuXYc599chYGL6l
	ntMOAGZglqqoF17RfzO4eK3m3W64AYO+LfgCqvKCUmiMxDL5JScDDTB9YQW8ZTpL/1zXM5tNKyr
	jkQkAKrz4Amf0SRrkyrTGoOIRudItoYLhZIjUDrIKKHk88ekTQC4V61Y21WeIhMu0Piyzxn5yTw
	X/5SdKCZf83UUjpui3/5CDlzrtIDcbOScCl+G5tNVyk0RZkyuJZD0is9PBWJZO/5wpV8gL/kfNd
	hUCpTFi1fHZQoz/QZPRQub4ZKyVheKb35NRssmXzvZD5VbztZ4Bj5oK3CprLVWzv5EcyRH6oYha
	nOv9OImcaoGS5QViyQrRHkpbSAMVIdOZRf1KNcVim9
X-Received: by 2002:a05:600c:c0d0:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48fe53774b4mr175297185e9.8.1779111911342;
        Mon, 18 May 2026 06:45:11 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fbfsm447019315e9.6.2026.05.18.06.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:45:10 -0700 (PDT)
Message-ID: <25337119-17d3-456b-b5e7-a60565737b27@ovn.org>
Date: Mon, 18 May 2026 15:45:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Adrian Moreno <amorenoz@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: nicolas.dichtel@6wind.com, Jiri Benc <jbenc@redhat.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
 <596094fa-4e41-4ffe-9261-47089ff92f74@6wind.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <596094fa-4e41-4ffe-9261-47089ff92f74@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	TAGGED_FROM(0.00)[bounces-289077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9163A56DE8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:26 PM, Nicolas Dichtel wrote:
> Le 18/05/2026 à 08:21, Jiri Benc a écrit :
>> Hi Ilya,
>>
>> IIRC this was added because Open vSwitch needed it. I'd expect most
>> users that need to deal with cross-namespace detection to just switch
>> to the given netns prior to issuing RTM_GETLINK; at least, that's what
>> I'm doing in the tools I wrote.
>>
>> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>>> requests.  For some reason the code checks if the original device
>>> and the link are in the same namespace and not if the querier's
>>> namespace is the same as the link's.  So the logic becomes:
>>>
>>> - if NSID is not reported, then the link is in the same namespace
>>>   as the queried device.
>>> - if NSID is reported, then the link is not in the same namespace
>>>   with the queried device.
> 
> I don't agree. The expected behavior is to have a IFLA_LINK_NETNSID if the link
> part is not in the same netns as the netdev, see d37512a277df ("rtnl: add link
> netns id to interface messages")
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d37512a277df

This patch predates the cross-namespace requests by quite some time,
so I'm not sure it can be used as a source of truth, since the netdev
namespace and the caller's namespace can be interchangeable in the
description.  It's hard to argue about what was the intended behavior
for the scenario that didn't exist at a time.  The semantics decision
had to be made along with the introduction of the cross-namespace
request support.

>>> A research across open-source projects doesn't show any projects that
>>> rely on the things that are being changed.  I couldn't find any
>>> project that uses the reported LINK_NSID with cross-namespace requests.
>>> And no projects that use cross-namespace requests seem to even parse
>>> the reported LINK_NSID.
> We (6WIND) are using this behavior. It's part of the netlink API.

OK.  Thanks for the info.

The man page for rtnetlink doesn't mention IFLA_LINK_NETNSID at all, so
we don't really have a documented behavior for it.  Which practically
means that the code is the source of truth here, and so be it.  Though
it would be nice to have the man pages updated.

As I said in the other thread, I'll be dropping this one patch for now,
the way forward if necessary would be yet another flag, but it's not
needed at the moment, so no need to further complicate the API.

Best regards, Ilya Maximets.

