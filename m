Return-Path: <netdev+bounces-277604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gqchBSZ72WlyqAgAu9opvQ
	(envelope-from <netdev+bounces-277604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:35:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5E3DD414
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5588A3017C39
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED43DEAE5;
	Fri, 10 Apr 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="k7yuMwNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850F37EFFB;
	Fri, 10 Apr 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860448; cv=none; b=fzUCqJTLYa2/tbYpyiVgTPHhrBL4z5f8ZlZ9i0mIaQBr63firmfzeyi26ozeyW7u3jscezQq0U3r6jFg8JStr06FWQSxDZGcE269N77KMdVB13MXNaFdnbBsEG5TbJ/NNbyxPK9d0V/HWr0vvyCOy4NZlTA0mLqk0Ijb/rGE2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860448; c=relaxed/simple;
	bh=ZKxZ4njLYnfL7S8OY+6Nyg/oNaGyFz+nROkAWiP7ulE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwtiBhgSIsYevVpJ6ShWfy1etc7q02FLmGT57l4OsudXmv1wEmOrSfoV8fj2Q2nn1fij6q3hafgiQiraHnNzflbHXGucxBardkpEN3tP9JPgqdvCxLaa3ksS/EgVQ6lwbclFZa7/NdtJWFae2XAsH2MWqXtN1/ukn9bUdAORGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=k7yuMwNY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1775859922;
	bh=Ml2NiUFr3OBP/pDdG9YSyFIyDdWC84XGS41hKvRh/5A=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k7yuMwNY8iuPYduMVX9FKYKQyR+IavrAee2JzubjYxosX4REhf5usgDYN//XZdPxo
	 /7bG+Vbipno4s5i4m3TsvXaxhGX2rijp75dNJuTALAfefW4lY9RQGkWq5uKAE1hvXZ
	 9E2EDAtrxIbOxGUUpMipgg5CIb2S7dmsVE3vfdpMrNTSpGTqi1kFKwl7EZuTNukgCX
	 gMpDmnlNBLfbNM9+iN76uVWPiXsKKPIbBYfV/DwuAzgzCyh5wYHIK548MvmdIrkbKR
	 ukcf6Oo24C/6xyI8uo9VfP8/XeQq+9z+kHbs6aO+gTBJ8FaNu/uU+yTN18+3CqZFMp
	 hnZkGYXBovNow==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4fsrwJ682mz4wpy;
	Sat, 11 Apr 2026 08:25:20 +1000 (AEST)
Message-ID: <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
Date: Sat, 11 Apr 2026 08:25:19 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: hugh@blemings.id.au
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <20260410221220.1708137-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blemings.org:s=202501];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277604-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[blemings.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blemings.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugh@blemings.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[hugh@blemings.id.au];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blemings.org:dkim,blemings.org:email,blemings.org:mid]
X-Rspamd-Queue-Id: D9E5E3DD414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 10 Apr 2026 14:54:48 -0700
>> On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
>>> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
>>>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
>>>>> Or for simplicity we could also be testing against skb_headlen()
>>>>> since we don't expect any legit non-linear frames here? Dunno.
>>>> I'll be glad to change this either way, your call.  Given that this is
>>>> an obsolete protocol that seems to only be a target for drive-by fuzzers
>>>> to attack, whatever the simplest thing to do to quiet them up I'll be
>>>> glad to implement.
>>>>
>>>> Or can we just delete this stuff entirely?  :)
>>> Yes.
>>>
>>> My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
>>> Create GH repos which provide them as OOT modules.
>>> Hopefully we can convince any existing users to switch to that.
>>>
>>> The only thing stopping me is the concern that this is just the softest
>>> target and the LLMs will find something else to focus on which we can't
>>> delete. I suspect any PCIe driver can be flooded with "aren't you
>>> trusting the HW to provide valid responses here?" bullshit.
>>>
>>> But hey, let's try. I'll post a patch nuking all of hamradio later
>>> today.
>> Well, either we "expunge" this code to OOT repos, or we mark it
>> as broken and tell everyone that we don't take security fixes
>> for anything that depends on BROKEN. I'd personally rather expunge.
> +1 for "expunge" to prevent LLM-based patch flood.
>
> IIRC, we did that recently for one driver only used by OpenWRT ?
>
>
If the main concern here is ongoing maintenance of these Ham Radio 
related protocols/drivers, can we pause for a moment on anything as 
dramatic as removing from the tree entirely ?

There is a good cohort of capable kernel folks that either are or were 
ham radio operators who I believe, upon realising that things have got 
to this point, will be happy to redouble efforts to ensure this code 
maintained and tested to a satisfactory standard.

Or, alternatively, as a technical community it may be that the Ham Radio 
interested folks conclude that out of tree or user space solutions are a 
better way forward as others have proposed.

Give us a few days, please, for the word to be put around that we need 
to pull ourselves together a bit as a technical group :)

Cheers/73
Hugh
VK3YYZ/AD5RV/Lapsed Kernel Maintainer... ;)


>> cc: workflows, we can't be the only ones still nursing Linux 2.2 code

-- 
I am slowly moving to hugh@blemings.id.au as my main email address.
If you're using hugh@blemings.org please update your address book accordingly.
Thank you :)


