Return-Path: <netdev+bounces-280044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDs4BH0552no5QEAu9opvQ
	(envelope-from <netdev+bounces-280044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B3438578
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1794300B3D0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375C388E55;
	Tue, 21 Apr 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="JsO4HJzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80E386C16;
	Tue, 21 Apr 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761146; cv=none; b=WtU5HGvDX1GDzjCXD6TLjY7yv0TnphEZOsNHMU4kfq5wWpHBmlnWqm551aNm+qNYAbu8tyh5XNrI/PiSTvsIknOwyRgKh0QoHvTqw+bg4nykSYz09Gk2dgVPWxcqySEJRjoodWVE8idSGww/BX9xJ9HON0tTiJgGGPlgQLiqJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761146; c=relaxed/simple;
	bh=uWqpLpPUA/2U0n151BqflvB2GHsTuKdtVqfkcnL93iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxgRm4PS7zcL8MGCjH6Pg56Lkaq4fm07/s2fcHhKXzklrBgCVnt7aQ7cfDOGAOMuEB2+wt2K+OcScsFAH9TKiXI44YB80x4hcNCwFRBtUzUoD0gW66IlxIwQ93XymEK35S3TW2EyTbliIbumejHFnqRsjxbxIOPA8FXtuosp3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=JsO4HJzW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1776761141;
	bh=GQG6DCViS5FYxjhXoEZRxdgMX4C5Mt5Vy2R9R5ylsvI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JsO4HJzWzMzasrWoHmvRW/sJVrDh/cUGM4IZ323J4/7h3kAd8Z9S+1MamCBrwl5mN
	 C5oLqBODDSz9cm+4ohI8s/vPm+UU23jadlrrbARovDdbTA4wmJuUjWf9yW62+tP+Sc
	 Kzd+FVY4Ir76Swbtm2mefDr+Y0JWzFnfIAkaO18NXeR43AmWHLsg1uahUoJK9pnXl4
	 XV30R7KD/Laqsse5shuyiUp3WbosLmOVtjINrZrAUAC1P0LrbFkjirT/VfWIaSXTyq
	 HqfpMBbRGHNBz29IwykdxJmHXNjPyaSDaRb2gOFh81Q+yd20OSqfAvUDJosHqNANBx
	 ly624mAUs2gIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4g0GCS1h8hz4w1X;
	Tue, 21 Apr 2026 18:45:40 +1000 (AEST)
Message-ID: <e2a47378-9008-45a2-92e3-d1f374b5e766@blemings.org>
Date: Tue, 21 Apr 2026 18:45:39 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: hugh@blemings.id.au
Subject: Re: [PATCH v4 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
To: Paolo Abeni <pabeni@redhat.com>, Mashiro Chen <mashiro.chen@mailbox.org>,
 netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 davem@davemloft.net, edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
 <20260413204921.70463-1-mashiro.chen@mailbox.org>
 <805a8583-6a84-4dfb-a4d4-53f80f50effc@redhat.com>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <805a8583-6a84-4dfb-a4d4-53f80f50effc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blemings.org:s=202501];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280044-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blemings.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blemings.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugh@blemings.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_REPLYTO(0.00)[hugh@blemings.id.au];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:email,blemings.id.au:replyto,blemings.id.au:email]
X-Rspamd-Queue-Id: 797B3438578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo, All,

On 21/4/2026 17:29, Paolo Abeni wrote:
> On 4/13/26 10:49 PM, Mashiro Chen wrote:
>> ax25_rx_fragment() accumulates fragment lengths into ax25_cb->fraglen,
>> which is an unsigned short. When the total exceeds 65535, fraglen wraps
>> around to a small value. The subsequent alloc_skb(fraglen) allocates a
>> too-small buffer, and skb_put() in the copy loop triggers skb_over_panic().
>>
>> Add pskb_may_pull(skb, 1) at function entry to ensure the segmentation
>> header byte is in the linear data area before dereferencing skb->data.
>> This also rejects zero-length skbs, which the original code did not
>> check for.
>>
>> Two issues in the overflow error path are also fixed:
>> First, the current skb, after skb_pull(skb, 1), is neither enqueued
>> nor freed before returning 1, leaking it. Add kfree_skb(skb) before
>> the return.
>> Second, ax25->fraglen is not reset after skb_queue_purge(). Add
>> ax25->fraglen = 0 to restore a consistent state.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> we are moving ax25 out of tree:
>
> https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/
>
> please hold off until Thursday (after that our net PR will land into
> mainline), and eventually resend if the code still exists in Linus's
> tree at that point.

Is there any flexibility here ?

Jakubs (CC'd) patches to remove unfortunately weren't cross posted to 
linux-hams and so I'm not able to directly reply in netdev

We've had a thread ongoing in linux-hams around the future of 
AX25/ROSE/NETROM for the last week or so and believe we've a path 
towards an orderly exit from the mainline tree, probably towards a 
userspace implementation. This includes a couple of folks who have 
indicated they would be open to overseeing the maintenance of the code 
in the meantime.

We'd hoped to have a period of a few months to do an orderly exit from 
the tree to minimise the impact on the (admittedly small, but non-zero) 
users that build trees/make use of the in kernel support.

Apologies for my lack of familiarity with the process here to deprecate etc.

Cheers/73
Hugh


-- 
I am slowly moving to hugh@blemings.id.au as my main email address.
If you're using hugh@blemings.org please update your address book accordingly.
Thank you :)


