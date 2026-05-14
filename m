Return-Path: <netdev+bounces-288003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAc6KhPiBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:54:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48E543886
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5138E30AA0AA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B017410D1F;
	Thu, 14 May 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="M2Z41gV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llZSehFa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C82D5A19
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769963; cv=none; b=WwqIkAPPb0mC67UulGSFanfOoqRmRbPOqNeJeGlnyXP1UI80T9fhP8xgTQCY+3fZt6o8WZMvxCiXENunY9FEk/W7at09A1IMfUEFTKrj7gWROOFFjkdW5ta8e+Rnu2kk61Vn+XVpcVs7KH3uK6mBOZb4tqI8gEO7lL9MvX11gUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769963; c=relaxed/simple;
	bh=D9T/ymrP1TFdnznpfGLkuwLPI0URxou8azZPyWAZ+6o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EvBaLSADy+BHhwzxk9fp4+dAZTIzIMgSvUK6SH2dG7slU4vpau7medtL584JPbVEMKCKJh0VU8Ya5UhVZGaA2+yKCHUo39ZF1QaMD/MOooWDV4YIhV+OmNFmwJvTeodIgybmNZTFb9ZXLxm/IdWUm2FxZFNli00cscmM4tgEobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=M2Z41gV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llZSehFa; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 586CD7A012B;
	Thu, 14 May 2026 10:45:59 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-10.internal (MEProxy); Thu, 14 May 2026 10:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778769959;
	 x=1778856359; bh=rkAFgTH/R30nUcrREWKv6FcDHDn1BD812za+dwCgBZU=; b=
	M2Z41gV4wHzdqDxjKfhT1nUhv4DyAvOrd/m8/L+6otxK6gBkp1iJz4ucwrVXxlzl
	dw+5ltYeXiTyW7Qc0JLys2IcNVFmVOGE0vTUAQqkvcjzoGb79h7oMY0nnAwrFgfY
	O7zFznnBwR2T2qpxcbICp6IJLMkzpLwqJ5jg67E9kz1AuxvgAvXbQ1bhLTdeROTG
	crX+uNcufDhTyAlsjiGeCTmRAsTEC+bE9BXZshpPlZuV9yPVIbQ1uVy4cIibs0X/
	7tOLtfd3+17jbOSmmQ/teswFGHOwob0AGqWwSIfsHaUnDPY5Jc1jkm8A0+h/CL2e
	kNsYVUg+4ByYQ88Hro3DaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778769959; x=
	1778856359; bh=rkAFgTH/R30nUcrREWKv6FcDHDn1BD812za+dwCgBZU=; b=l
	lZSehFawO7jNJrziiY8l581hZ+VffVGx2jsxoVSnEHvsX5TjFygBehUc6NaLChzB
	a2vdP9ZaRwD+GO7IHj48mpdGtSzdLqV9EiDlFiovHQwMNkNWp9grj1kWSLC1XVyd
	fMrenycPoJtipl915CXrNhphfgVsPsk1kQRzpVToYjWDbD4l2iv4fKzY6CfKdzNm
	7SkMgyrrrZ2d5U8/TuPl3WBE4viC3E99ZfBFidYZV0k3oB41F2N9DMNl5Yz1Qbn+
	Gp0OgsHyFXNf7G3r93MIp986S7bdxLcW1bnmg6lAqmmSU8hLfDtt/xbeu32qI4x+
	9iPTAQVLdpni4iwpKYoug==
X-ME-Sender: <xms:JuAFauv0JIQxqaM1ZRS5NA2FCNhYZ5hFQiNmHMnL_cBzwbeQFjnR7Q>
    <xme:JuAFauQ9-uUzCAyFkRjs6CxyY-IAVj6OZfuTtMq-s5RCRj_cqSFiS_9QssLIU97Q2
    niFo0nk6LNg5X1dCiVdgbVGLLZJdV9c9wfGhOWYXmn3SUZVMd6_bT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpefhgfevgeeljeegleeiffduheegieehtdff
    tdetvdffieelkedthfejleejgfeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgt
    vgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghtthhhvgifrdhstghhfigrrhhtiieslhhinhhugidruggvvhdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepug
    htrghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgrghlsehnvhhiughi
    rgdrtghomh
X-ME-Proxy: <xmx:JuAFauZevOD45uafhYF8zzdvzgEqeYZDItIqMAgkqjdEymxnReRqag>
    <xmx:JuAFavqR9z_IaDt2A5p-wBi76rjVURDZshim_xj2y5AAyLoWAKAjnA>
    <xmx:JuAFaiQHVv-puLXwr4_dyEuDr1jgdIleOQ7YM3NUJgbdmbC6e5mtZA>
    <xmx:JuAFajo1IMYQwFC95S60GSJs2anE9eRA6NRKTokzjD5d1Hp0ADoCLA>
    <xmx:J-AFarsDz2gTBKhdE8xE7k8DcVS_ki5DnxEhfG8rpl8EigUx-eeabXD5>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4B0CC4006E; Thu, 14 May 2026 10:45:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 May 2026 16:45:37 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <6702f4e4-cc0d-42ed-b11e-ba272018750a@app.fastmail.com>
In-Reply-To: <c4279000-dd9a-4e59-ae0d-6dcc5c7b03a2@nvidia.com>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
 <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
 <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
 <23e6e0f4-29ee-4f86-b02d-8c8d881c51f7@app.fastmail.com>
 <c4279000-dd9a-4e59-ae0d-6dcc5c7b03a2@nvidia.com>
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C48E543886
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-288003-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[fastmail.im];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,isovalent.com:email,fastmail.im:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026, at 14:01, Gal Pressman wrote:
> On 13/05/2026 14:48, Alice Mikityanska wrote:
>> On Wed, May 13, 2026, at 13:28, Gal Pressman wrote:
>>> On 13/05/2026 13:08, Alice Mikityanska wrote:
>>>> On Wed, May 13, 2026, at 11:43, Gal Pressman wrote:
>>>>> On 13/05/2026 12:17, Alice Mikityanska wrote:
>>>>>> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>>>>>>> Following the cited commit, __udp_gso_segment() writes single MSS length
>>>>>>> in the UDP header.
>>>>>>> The cited patch doesn't account for the fact that the last segment could
>>>>>>> be a GSO skb by itself. This could happen when the size of the packet is
>>>>>>> a multiple of MSS, hence the first segment is also the last one (there
>>>>>>> is no need for a remainder skb).
>>>>>>>
>>>>>>> When the post-loop segment is a GSO skb, assign the single MSS length in
>>>>>>> the UDP header.
>>>>>>>
>>>>>>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>>>>>>> GSO_PARTIAL")
>>>>>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>>>> Closes: 
>>>>>>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>>>>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>>>>>>> ---
>>>>>>>  net/ipv4/udp_offload.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>>>>> index a0813d425b71..71df45f9488a 100644
>>>>>>> --- a/net/ipv4/udp_offload.c
>>>>>>> +++ b/net/ipv4/udp_offload.c
>>>>>>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>>>>  		       seg->data_len);
>>>>>>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>>>>
>>>>>>> -	uh->len = newlen;
>>>>>>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>>>>>>  	uh->check = check;
>>>>>>
>>>>>> This is going to have the same checksum bug as your first commit, which
>>>>>> I'm fixing in [1]. You should use the right value of either msslen or
>>>>>> newlen when modifying check a couple of lines above.
>>>>>
>>>>> I tend to agree that the checksum seems to have the wrong value, the
>>>>> reason I chose not to change it is because my work only moved the UDP
>>>>> length assignment from the drivers to the stack.
>>>>>
>>>>> The "wrong" checksum value was used regardless of my change,
>>>>
>>>> The wrong checksum was visible only inside the driver, and since the
>>>> hardware didn't care (due to the offload), it worked well. It was the
>>>> driver business to make sure the corresponding hardware likes the
>>>> packet. After commit b10b446ce7ad ("udp: gso: Use single MSS length in
>>>> UDP header for GSO_PARTIAL"), however, the wrong checksum moved one
>>>> abstraction layer higher - to the networking stack, which attempts to
>>>> keep the checksum correct for a more generic case. It's not the same,
>>>> and while I'm trying to fix one occurrence, I'd prefer not to
>>>> introduce more.
>>>>
>>>>> and I
>>>>> prefer not to change it as part of this work.
>>>>>
>>>>>>
>>>>>> That said, maybe you can base your patch on top of my checksum fix? For
>>>>>> the last packet, it will then be:
>>>>>>
>>>>>> if (!skb_is_gso(seg))
>>>>>>         newlen = /* the new value */;
>>>>>> /* keep newlen as is otherwise: my newlen is your msslen */
>>>>>> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>>> uh->len = newlen;
>>>>>> uh->check = check;
>>>>>>
>>>>>> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/
>>>>>
>>>>> As I mentioned in the other thread, this fix goes to net, I can't take
>>>>> your patch.
>>>>
>>>> Ah, that's right. Still, I guess you can take mine to net for the
>>>> checksum fix.
>>>
>>> Do you think it is suitable for net?
>> 
>> This is always a mystery to me... I've had different experiences:
>> sometimes I am asked to resubmit less important fixes to -next,
>> sometimes a fix is a fix and must go to net. This one is a refactoring
>> useful for my further patches + the checksum fix, which we get for free
>> and which I considered not important enough to submit to net (hardware
>> offload fixes the checksum in most cases anyway). Following the "a fix
>> is a fix" logic, we may try sending it to net. What do you think?
>
> IMHO, the motivation you provided in your previous message for the
> checksum fix is convincing, but as I said, I think the commit message
> should be phrased to explain the bug rather than the refactoring (and
> add a Fixes tag).

I can put it like this:

udp: gso: Fix handling checksum in __udp_gso_segment

The cited commit started using msslen for uh->len, but still uses newlen
to adjust uh->check. Although the checksum is ignored in most cases due
to the hardware offload, __udp_gso_segment attempts to maintain the
correct one. Fix uh->check and adjust it by the right value.

Additionally, after the fix, newlen becomes assigned and unused before
the loop. The code can be simplified a bit if mss adjustment is dropped,
so that newlen becomes equal to msslen before the loop, and msslen can
be also dropped, saving a few lines of code.

This brings us back to one variable, drops an unneeded arithmetic for
mss, and fixes the UDP checksum.

Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for GSO_PARTIAL")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>

