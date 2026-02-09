Return-Path: <netdev+bounces-257984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePsuF5M7imlvIgAAu9opvQ
	(envelope-from <netdev+bounces-257984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE111445F
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 20:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED233029E7F
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825D3876B6;
	Mon,  9 Feb 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OMd92If2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZ5VLX4j"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D638757A;
	Mon,  9 Feb 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666822; cv=none; b=lzlYg0bfLx7q3f8Sz2N/6oH+PV3oW0TP6rbDoXW8xyv7vavw2SwDmkCJ3iRjH8IFqD0H8XSH9VDmziB+cfablfcKySU7kdY+WN/3aJOFkkgNJrs98q1U9ipNyDef3igQuWVVrxpTQta05hbLvhqJHBvXaAywak5VkYcCp4U14Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666822; c=relaxed/simple;
	bh=h0N4hKt/oOVF1pCBswxft03HCIK4S5TWf26g5vT6F9o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HaXZ3tt2mPtcBfr7nm8uBWHulSdWALQNgF/fTy1/47m1cdD8xyLqCjvjliBEGMHXRAcc/C2zLh8P6L7MhaeKycBQqcKB6Dn8TiSYPlTopeSHO8lNwOh5Z4uoQNxOKsBh4OljZMqmAD48p5OJwbAurUm1z3FhFFvF8sik61TTASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OMd92If2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZ5VLX4j; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B19EEEC054C;
	Mon,  9 Feb 2026 14:53:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 14:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770666820;
	 x=1770753220; bh=fEmrFeYzPmAoJMA6RFUhUAHKfR6T4W1zM+BFUQbcxIs=; b=
	OMd92If2qRnr0LO/tvlzEbxnvQOJ8JruHRFCvt1GxEPHY5gavgAh/+O+x+MrWKAR
	12m4dXFuhLrI7pS81JX9boSGNbVmRBJaxeg+0qXWcjSxYnaBkHRsS7mZaF10jWlF
	XCWailBJneCFalSnZZ4bxZBrT3zpS6yFU3GTdEBBhKJyXKftEm8UUaKfTPH9bYQ0
	taKWO/pdPcfpKm1SY2sdJV9SzhV4kpPSWz92M0W07GgBvZBTEOsi+oA5FXCvsuL8
	ne6xN07CNY/OXKpy3ba/YbvI6pNouKezMS9Geho31zRr3tCieocn3CNpuT3YkYOU
	Y6OXDMGHkditBSrhpZ9UhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770666820; x=
	1770753220; bh=fEmrFeYzPmAoJMA6RFUhUAHKfR6T4W1zM+BFUQbcxIs=; b=r
	Z5VLX4jwyy032OsrOXnSQWDdt4ytbx7mqyAYugiwYaDEwJVzqiBTfoLlz6pRTOsu
	M5w52BDh+l6tx6Kp3rDM5SJzGJljQLhTa5sklbZU07eNGmJWq1jO9YVBSnefLjcS
	TSeCvjMj8OZ2pFh47Efr6UDNY/4JvmQX+7o04pmdFHKb6hepVbMK5sI7XXCghvWA
	5v6pPtA5cxZf0dNgnIW+qyMNaTAM3YtMlIe738Dzg4zOXppSR4nXZeOb/ZHWoybc
	+jvG8th+YQMKXElYnQOfx4/fcy117sWjEKeo0YEYDGqYDsuH9m0H87yaH5cod+dm
	6cnB9C8aXRta0UVF5ToFQ==
X-ME-Sender: <xms:QjuKaRFKgQDxxwMbj-6vONoU_CIy24Felqf4spWJn8zEjaebPX5YZA>
    <xme:QjuKaSMeR0Hk_hx6lRlbe79Avr_LSydz_3LBavok_Koqu2sMpCkYvdkTciwuQJBVd
    4qRUVusUkIw4XHUCYeV060J73O8R8i_39yn4aAVlUrUCRG499hdKjQ>
X-ME-Received: <xmr:QjuKaeots9vkKpff7kCAkoznvR87iFWa5HmzbMtuvbGmgzt53L_YXE4oMYa0YWj0AG7g7yIzin0FxdXt9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepue
    ekveehtdetleduieeuhfdufffgtefhffetteehieeiheejtdeigeetjedtledunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    vddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurd
    hnvghtpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgnhhorggtkheftddttdesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhhnhdrjhhohhgrnhhsvghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtohep
    phgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehjmhhorhhrihhsse
    hnrghmvghirdhorhhgpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsrghmrghsthhhrdhnohhrfigrhidrrghnrghn
    uggrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:QjuKabCytRn5O1ITBbmrVXKqwpKOIPKasWuSttzil27JMyPQZf2nrQ>
    <xmx:QzuKafPtkgZ0gazMjsOYmwZsSYUhqRrSNdztnmDu949wjpkLqLLm1w>
    <xmx:QzuKaRA5t6S9nBEOOLAY2y2QH1fDTHQ8ya7-_ID_QfWb_hn-VcF3jA>
    <xmx:QzuKaV_N0UPK8CtSaWk8uv4vevoAeXCVTKA9Q0aCSwNhZ8Li3N41rg>
    <xmx:RDuKaffrLCPALmjzwSf3XT_Lu67oliAqzYJ7KnTBczr9WLLU9knU9fy9>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 14:53:36 -0500 (EST)
Message-ID: <aefadd4b-0a72-4125-af3c-a3454d535ad7@maowtm.org>
Date: Mon, 9 Feb 2026 19:53:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] lsm: Add LSM hook security_unix_find
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-2-gnoack3000@gmail.com>
 <20260209.yeeh3ieDuz9u@digikod.net>
 <a0ae82d6-8c9f-4b6d-9f7b-a6d38efbf80f@maowtm.org>
Content-Language: en-US
In-Reply-To: <a0ae82d6-8c9f-4b6d-9f7b-a6d38efbf80f@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[maowtm.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[maowtm.org:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257984-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[digikod.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,gmail.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@maowtm.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[maowtm.org:+,messagingengine.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: AEEE111445F
X-Rspamd-Action: no action

On 2/9/26 18:33, Tingmao Wang wrote:
> On 2/9/26 17:51, Mickaël Salaün wrote:
>> On Mon, Feb 09, 2026 at 12:10:11AM +0100, Günther Noack wrote:
>>> [...]
>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>> index d0511225799b..db9d279b3883 100644
>>> --- a/net/unix/af_unix.c
>>> +++ b/net/unix/af_unix.c
>>> @@ -1226,10 +1226,19 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>>>  	if (!S_ISSOCK(inode->i_mode))
>>>  		goto path_put;
>>>  
>>> +	err = -ECONNREFUSED;
>>
>> We don't see it in this patch but err is already set to -ECONNREFUSED.
>> This line might be confusing, and unrelated to the goal of this patch,
>> so we should remove it.
> 
> I will confess that in a side conversation with Justin previously I
> suggested that for blocks like these it might be better to always assign
> to err, and let the compiler optimize it away, so that when this block is
> moved there is less chances of mistake.  (This was relevant in the
> previous context where a move of this hook caused err to be reset,
> resulting in a NULL deference from syzbot)
> 
> But of course if the convention in this file is to not do it, or if I have
> missed some reason against doing this, then that's also fine (even though,
> IMHO, personally I think this is better).
> 

Actually, looking at this more carefully, Mickaël is right that this
single line addition doesn't have anything to do with the patch itself
(unlike in the diff in the other thread [1] where it is part of a moved
block), so I guess it makes sense to not add this in this patch.

Apologies for any conversation derailment caused here :)

[1]: https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/

