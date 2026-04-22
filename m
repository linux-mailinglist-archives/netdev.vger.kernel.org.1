Return-Path: <netdev+bounces-280423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFlnLhfL6GmZQQIAu9opvQ
	(envelope-from <netdev+bounces-280423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E401446A2A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A1630DE50B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F13CB2E6;
	Wed, 22 Apr 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="wpGb2251"
X-Original-To: netdev@vger.kernel.org
Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38293CD8A2
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863480; cv=none; b=oX4kCrzNYEHgSsaVFgJ7LoyZAH3HVe8/Haa+8rw0xXwO5uOTWTwBNsCf8ZXAGomv9fro5k/2P8D0GzR9Ww0eFxfIutHofuo2sUGCOUROj4dNmuYjTXF0xZTHScrcBX9bTshV66mB40HFNuDK1+UsuNJiP2tLtoClgVAPELwwnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863480; c=relaxed/simple;
	bh=I2zUHJZLY9Sr+zs7ftcgpnPGO9myiHKfvcmZcgHRNuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tY0qErMwMel7v9LY4X6sQKYdDWssPhLROF8GDeaY5CMc+JCQ62J+qmW/7HTql4mxtJsstbrLtX7Hs+rTgyS0rjZ5WoN4S2J8rIKf5Qzk1mE7GaEbcwGIujGh3FJqG8PZinnRKuoCXHjzv5aOM+ijPRQNB4VyeU8WW65CAuzj5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=wpGb2251; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.88.125.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 9D21F5340114;
	Wed, 22 Apr 2026 15:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1776863476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UfqfD7bBrj0jQzM/seMyiVF/r76mP4w+YsZiXZrCe3Q=;
	b=wpGb2251bGj9iDoRYdNAa4/p3O7tLO55D4yE6dR03kW434HnLsV5S3ApTL967bWygWL7bd
	hdSFeVqDRwn7lr6jsb7nMPTskWntyA5NaEbQiuYMUSIg1j65vWngr7VMjbqIsDBCcni3/O
	68fw1WAxRvwLv5YCMQuK0DlgFP3MXZ4=
Message-ID: <938496c6-84c1-4d53-bb56-73bbd7b2bdd7@ixit.cz>
Date: Wed, 22 Apr 2026 15:11:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Path forward for NFC in the kernel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Michael Thalmeier <michael.thalmeier@hale.at>,
 Raymond Hackley <raymondhackley@protonmail.com>,
 Michael Walle <michael@walle.cc>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 Mark Greer <mgreer@animalcreek.com>, netdev@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev
References: <20260416101041.4c533306@kernel.org>
 <9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
 <1725ea8d-ac1f-49d2-8d8c-2e09721454c2@ixit.cz>
 <20260421071044.67a3cee1@kernel.org>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260421071044.67a3cee1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ixit.cz,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ixit.cz:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,hale.at,protonmail.com,walle.cc,samsung.com,animalcreek.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280423-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ixit.cz:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@ixit.cz,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:dkim,ixit.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E401446A2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/04/2026 16:10, Jakub Kicinski wrote:
> On Fri, 17 Apr 2026 10:12:22 +0200 David Heidelberg wrote:
>>> +Cc David Heidelberg recently trying to use Linux NFC stack,
>>>
>>> Just "collecting" patches is not a big deal, I could do this, but
>>> actually reviewing the patches with necessary due diligence is the
>>> effort I could not provide in a reasonable time frame. And picking up
>>> patches without proper review feels risky...
>>
>> Hello Krzystof, Jakub,
>>
>> thanks for putting me into loop.
>>
>> I can do limited reviews and basic maintenance. My knowledge about NFC is for
>> now somehow limited (but I'm willing to invest my limited time into learning more).
>>
>> As "I & LLM" wrote [1] userspace very basic reader for GNOME and planning to do
>> more tight integration into GNOME, so would make sense to keep the kernel stack
>> alive.
> 
> Hi David!
> 
> Sorry for the delay, we (core maintainers) discussed the situation
> off-list and since our choices are either delete all this code or give
> you a chance, everyone agreed that the latter is strictly better :)
> It's a little unusual to designate someone who doesn't have a proven
> track record acting as a de facto maintainer, but such are the times...
> 
> Our expectation would be that:
>   - you'd create your own tree to gather NFC patches and send us
>     periodic pull requests every 2 or 3 weeks, with what you gathered
>   - act upon submissions within 48h of posting (excluding weekends)
> 
> Of course we'll happy to provide any support and guidance you need,
> specially for the first few months.
> 
> Is this what you had in mind? The phrase "limited reviews and basic
> maintenance" is slightly worrying, we assumed it's an expression of
> modesty rather than commitment? :)

Hi,

thanks for giving me the opportunity - I appreciate the trust, especially given 
the circumstances.

Yes, this is broadly in line with what I had in mind. To clarify the “limited 
reviews and basic maintenance” phrasing: that was more an attempt to set 
expectations conservatively. I’m prepared to take on the responsibilities you 
outlined — maintaining a tree, collecting and triaging patches, and sending 
regular pull requests.

Regarding reviews and responsiveness: I can do the 48h turnaround for initial 
feedback on submissions (excluding weekends, and occasional travel), and I’ll 
make sure no patch sits unattended. For more complex changes where my current 
NFC-specific knowledge may be a limiting factor, I’ll seek input rather than let 
things stall.

I’m also planning to ramp up my familiarity with the NFC stack as I go, so I 
expect both the quality and depth of my reviews to improve over time.

If that works for you, I’ll proceed with setting up a public tree and start 
tracking incoming patches.

Thanks again for the support - I’ll likely take you up on that, especially early on.

Best regards,
David

