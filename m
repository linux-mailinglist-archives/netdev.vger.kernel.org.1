Return-Path: <netdev+bounces-158233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5EEA1129C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA8F1614EC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5C20A5D2;
	Tue, 14 Jan 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="onRPpZX/"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B18493
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888318; cv=none; b=ncOMIuYBnQsonwbCXPBJEOrPwZOxLtxeQg8E/Xgh+tQXyfANXK9pVzbryXDaGkEQ6rfmPm8YHv6GacbzR3jP3m7qSJF9P44ipMSpjLmOU4ADu3nb/1v9ipwcTS4vAM6m2PC9Nkat1uA7Jhkx5BpYemJPqrNv9zn6hgKfVGCTF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888318; c=relaxed/simple;
	bh=OUi0lX2e6gO5Kt7Bjit8x8TE07I6n5KYT/bojzuEN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/XA9QyIyIZDBja1y2uyuq6y6MSs2EXwOydf0gngG1riT+ebDuM/z1I0hdG/YEi+dBkBU7fD7s7RbPzmX8ipQvmUaDHXVVaPAevApaFG/f45Esa40C0X8AX0w3JUPy7ulipjkawDTSQ40qnTzxY0bis6PnRhDNs4GqcorzCJpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=onRPpZX/; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5m5pN36IYEDBasqiks1GekDtp65vm+4a8cuKemKZq9M=; b=onRPpZX/ziaaRYEZpy+cNxkkDZ
	pyTfRBbyzKdthGlunGx1ADV41Jg44zoGOwVoZ/do+ZrM0XSMDlGd+5MZTnaH1ZjcM0iMh4ziTFP7r
	PM3maIUGQ7DvXt/6ee4twffBT/wdR9F9GcVonCJO9Yit9Z/JQPzmcAooM0bolastWkis=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXnzV-000000007YR-44xH;
	Tue, 14 Jan 2025 21:58:26 +0100
Message-ID: <fa737740-7cd0-4109-8712-09f2cb8dbef0@engleder-embedded.com>
Date: Tue, 14 Jan 2025 21:58:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
Cc: magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
 <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
 <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
 <Z4WKHnDG9VSMe5OD@LQ3V64L9R2> <20250113135609.13883897@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250113135609.13883897@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.01.25 22:56, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 13:48:14 -0800 Joe Damato wrote:
>>>> The changes generally look OK to me (it seems RTNL is held on all
>>>> paths where this code can be called from as far as I can tell), but
>>>> there was one thing that stood out to me.
>>>>
>>>> AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
>>>> or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
>>>> understanding and I submit patches to several drivers with this
>>>> assumption.
>>>>
>>>> For example, in commit b65969856d4f ("igc: Link queues to NAPI
>>>> instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
>>>> enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
>>>> NAPI instances to queues and IRQs"), I avoided the XDP queues.
>>>>
>>>> If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
>>>> or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
>>>> similarly?
>>>
>>> With 5ef44b3cb4 ("xsk: Bring back busy polling support") the linking of
>>> the NAPIs is required for XDP/XSK. So it is strange to me if for XDP/XSK
>>> the NAPIs should be unlinked. But I'm not an expert, so maybe there is
>>> a reason why.
>>>
>>> I added Magnus, maybe he knows if XSK queues shall still be linked to
>>> NAPIs.
>>
>> OK, so I think I was probably just wrong?
>>
>> I looked at bnxt and it seems to mark XDP queues, which means
>> probably my patches for igc, ena, and mlx4 need to be fixed and the
>> proposed patch I have for virtio_net needs to be adjusted.
>>
>> I can't remember now why I thought XDP queues should be avoided. I
>> feel like I read that or got that as feedback at some point, but I
>> can't remember now. Maybe it was just one driver or something I was
>> working on and I accidentally thought it should be avoided
>> everywhere? Not sure.
>>
>> Hopefully some one can give a definitive answer on this one before I
>> go through and try to fix all the drivers I modified :|
> 
> XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
> extent for advertising purposes :) If memory serves me well:
> 
> XDP Tx -> these are additional queues automatically allocated for
>            in-kernel XDP, allocated when XDP is attached on Rx.
>            These should _not_ be listed in netlink queue, or NAPI;
>            IOW should not be linked to NAPI instances.
> XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
>            dedicated XDP Rx queues
> AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
>            I don't recall if we made a call on these being linked, but
>            they could probably be listed like devmem as a queue with
>            an extra attribute, not a completely separate queue type.

For tsnep if have no additional XDP Tx queues, only the netdev queues
are used. For AF_XDP/XSK I would keep the linking, as the stack queues
still exist and are operated still with NAPI. Maybe queues taken over
by AF_XDP/XSK get an extra attribute in the future. So I can keep the
permanent linking to NAPI while interface is up no matter if XDP or
AF_XDP/XSK is used or not. Did I understand it right?

Gerhard


