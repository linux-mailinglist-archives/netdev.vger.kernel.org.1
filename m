Return-Path: <netdev+bounces-305128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PdkfBpTSS2qlawEAu9opvQ
	(envelope-from <netdev+bounces-305128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD9713025
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:06:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=m1i2jSKS;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305128-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305128-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9334D31A2B31
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE0842E000;
	Mon,  6 Jul 2026 15:37:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAD3976B2;
	Mon,  6 Jul 2026 15:37:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352224; cv=none; b=TeuJLvuiNvoW2/urdnrHHjGEhPx5BScWtfMx96UlHgCYIGRZ9vh7FgKD/cmAYbg7dY4WzJJxqnsgFJzis00il3BdiqhMqew2e9rlJa5wfMYeOBk9QP7EZ1yktCskA/pZnANuqpv5YBhB9jsmA/BHc9NBfk1VZilJxy3w6Sg032o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352224; c=relaxed/simple;
	bh=/gLU1ZYIoBZNDWpqrT3SqMshBw/xL7i3z8xLVloSYAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdpAMASFDMkQiNCBDsCKKw2yWAvpJNMAFnVQ2v9aUl0WKoW8G789uuNDvvEsAJQ36iJ0WKYTVF84/tJlVFpFGD3t9L3cEH6w1p5XuNE3DatlnrLYR7KvCxlFnnXFc4MVjPOcPjSGD3hreYKEKHqaGS1cWWQyUUF9i2CbjSgkKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=m1i2jSKS; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783352020;
	bh=LcT8nSRPPRwrKXE781yHHNVxYxj3ib/wKkBEPXxseS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m1i2jSKS9nvyY5iUatK2T5uv4V0M85q0KcXiSWCes3Y7qiOJod8A7BVHwUm++zcO9
	 CRaeZtbEd8uTeRI1rju6xjUS0AEMRyS+Mgm9ZR+zEetvEtuiJzA6bGGM7zMbRAKC1d
	 7koO4jd+j+IMPRAkpazTV3VedhGWX6y24MtzuLeM=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 666FXc6A027333
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 Jul 2026 17:33:38 +0200 (CEST)
Message-ID: <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
Date: Mon, 6 Jul 2026 17:33:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Brett A C Sheffield <bacs@librecast.net>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260706091706-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:bacs@librecast.net,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:from_mime,tu-dortmund.de:dkim,tu-dortmund.de:mid,brettsheffield.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70BD9713025

On 7/6/26 15:23, Michael S. Tsirkin wrote:
> On Mon, Jul 06, 2026 at 12:11:15PM +0200, Brett A C Sheffield wrote:
>> On 2026-07-06 11:42, Simon Schippers wrote:
>>> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
>>> when a qdisc is present") did not show a relevant performance regression
>>> in my testing but on Brett Sheffield's librecast testbed it shows a
>>> significant performance drop in a IPv6 multicast testcase. The regression
>>> can be pinpointed when multiple iperf3 UDP threads are sending. For 8
>>> threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
>>> the reason why this patch makes the qdisc backpressure behavior opt-in.
>>
>> Your v1 commit message was correct.  The iperf3 tests were TCP, not UDP.
>>
>> The original failing test that alerted me to the problem was IPv6 multicast
>> (UDP), but the reproducer tests I provided stats for in the regression report
>> were TCP "To eliminate my code and any multicast weirdness" and also to verify
>> that this also affected TCP.
>>
>> Sorry for the confusion. The command lines used are in the regression report.
>>
>> I've tested the v2 patch (with IPv6 multicast), and verified the
>> previously failing test passes.
>>
>> Tested-by: Brett A C Sheffield <bacs@librecast.net>
>>
>> Cheers,
> 
> 
> Just to clarify, it's more of a work-around, not a fix.
> 
> It's not really great to have a flag that says "change something
> opaque in the internals of the device, it affects performance
> in some way, we can't predict how".

Yes, I agree, but in the end I am just using netif_tx_stop_queue() and
netif_tx_wake_queue()...

> 
> So maybe we really should revert for now, and work on something
> more coherent for the next linux.

But even if we could perfectly fix the performance issues, maybe users
even users rely on the dropping behavior. From Brett [1]:

"In our multicast use case data is sent by multiple threads to multiple
groups simultaneously, this just breaks things to the extent that a 
<2 second test times out after 5 minutes."

We are *not* factor 5min * 60sec/min / 2s = 150 times slower than without
the patchset. My theory is that the sender sends a fixed amount of data
of which most is dropped without backpressure, which is much faster then
the real processing, and so the test *relies* on the tail-dropping to
work.

@Brett can you maybe support this theory?

Thank you both very much! :)

[1] Link: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/

> 
> 
>>
>> Brett
>> -- 
>> Brett Sheffield (he/him)
>> Librecast - Decentralising the Internet with Multicast
>> https://librecast.net/
>> https://blog.brettsheffield.com/
> 

