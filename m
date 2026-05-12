Return-Path: <netdev+bounces-287329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKVIDmCdA2rm8AEAu9opvQ
	(envelope-from <netdev+bounces-287329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0052A60E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBD1C302CD3C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9D386C31;
	Tue, 12 May 2026 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Man6gt3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11062386575
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621775; cv=none; b=Qwdaxj40A8HRGxcheBbpLkvToyf70dlT0Lbr6cmAl4C9Tj1OQhkPSZkCu7EdXVqomIKKzlQpfVKPB1+ApfXwfMjDiZz2NEiDYyaVWvP9Q5+EmpL7Otmg88Lpu8LG+aS/yHLXiaY/2odnRI1BPqiQsAq1p8xRyjG0DmI0Mg+/SJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621775; c=relaxed/simple;
	bh=2CAQv7WlIuAn9ZzlbSWxK35EKEEcUTbGAVGhewVtMtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQHeKYoS8Q+LCUwUdcwm/+KYtb+ou04dgCxY3tBMI2YOtxIZK/oT4jedf5eRfvsD9ixpwLeeK9xVlt4rBf6C4GGXWPomP1FAjUkb412SYpnnvNDyav3DeIStHMWgiqryuaxjVkuaeNdAosO0q7dimvbkCzbZfvQG2Xo4mg/JQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Man6gt3H; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcc1459daddso557303866b.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621772; x=1779226572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AjtpQdf3BmRecSAJyeyKfM2fj5WACdiXZCkmVYfRjk=;
        b=Man6gt3HqG6GzEP1vSuEzftvOuWnSv16zXSzP6qL11GKFd3TdlLJNaShwgFMqswMKg
         D0omN2+Owj3Emb0iUoEl5E1kDgRVS5p2LqJQaoZSipbppgpw2HBV7tbx6FLO8xoTk5iQ
         H0980Js9f9AE79xQ3aflnZmkUHMZvvx7VjsPhwS+Qfm2HGII7k3ohC5O+GVrHh0plJZj
         JshrsjIkJ6mVts+YXQIpBifTVayW8ub4hE7W50ut0Zio4BnS4OI5JCBzGACH6mh8o4xR
         wByQ4/tiiPbf2TtofEsLljXmgO7DeDqNnAkNpQpNNZplV+hLn/FyMht1i453aCvnBnM1
         8MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621772; x=1779226572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AjtpQdf3BmRecSAJyeyKfM2fj5WACdiXZCkmVYfRjk=;
        b=ghhy3hMITVJovbYz5o4AuxqESX2dWXz4NFRqaC6DEMdIloABpR0u/hIY22TaYNJt6Q
         u98wtGHGcz8eKImAbbOLqebIrYpTpiv9YsvFKbehVMC/o1wXSW7pAPaCUWVXTXTcVplX
         ogLeg0qjn5FEzj8Cpo95N1jM28F17v0JNEHXNPE4oaEyh19b1EGF46lashXRVDl38yEM
         wHzV3Kqmudn7iWY2aa3qBrwkVCRfB+o78YAj8OF/wMAHN3RiluvcHkScj8IMzpMYsqG8
         mf204kq1kxsxkqlsbUfjztt1PRN/UdY7xy4RG1vEc9uKaxiEUjo4F4TqyEhsPTHerh0l
         MSvA==
X-Gm-Message-State: AOJu0YywRQ0Xn/Z/XD2yFBVk7K2jfVurtYRG+zxlpPZwp45lUV6CmuNE
	meRB7aUVrMuV7v4bKA6EM7Zyw2lSCbt6MkCCTcj7K/kjQgEO1nihitvL
X-Gm-Gg: Acq92OF1HBcc/bfNhINGxMsVjEbI6x2aO0BG5LzK8WXQzEbdu2yo67G/NMeOgQymn79
	mMnN7JUP3iaGgokgTqrFcrZmTCRx2tKkj6yX52ZHP4jlUBODEaudcY+St0Go5i5MJLKDtfq9mFH
	w9JxRblHsznaBVgJNLJMNnhlVoyHN+7hSDG1DMk+Waoh9G35JNUBbWynvknlkl9BEFeIDgK9IU7
	HWAPnw8al/xiXDsOnZC02hCUly3easV5960qy40SfrcGOdNB43NakxlfcheHRhZQAYlGk0Rl9Zm
	82QeTRiuvzTXUpyGVKZn82b+55tKec9A0C/dUY1b1lT3e8lGiYY3XKiccTndnRNpcb+o7Iix0BH
	y1fhYB05Qqj+ueloJfcPZjs/ZDHKrKaFlhK9o84Q/3AxVJCpo/MeE6x9BjESf7r8MIf5lNagI8U
	p4IpjBke50Px+1FBZe4n+ZiUv2Xe3wGMuAk10cRWBC3sUQa8gmRvfrzCbN5d8y
X-Received: by 2002:a17:907:801:b0:bc2:9733:9ecc with SMTP id a640c23a62f3a-bd3e27ef0famr8796166b.32.1778621772132;
        Tue, 12 May 2026 14:36:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd9decf173sm507580066b.43.2026.05.12.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:36:11 -0700 (PDT)
Date: Tue, 12 May 2026 22:36:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Jeffrey Altman
 <jaltman@auristor.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying
 data to buffer in recvmsg
Message-ID: <20260512223609.57150707@pumpkin>
In-Reply-To: <1072349.1778604723@warthog.procyon.org.uk>
References: <20260512143835.13af8bc4@pumpkin>
	<20260511160753.607296-1-dhowells@redhat.com>
	<20260511160753.607296-3-dhowells@redhat.com>
	<1072349.1778604723@warthog.procyon.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9EF0052A60E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287329-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 17:52:03 +0100
David Howells <dhowells@redhat.com> wrote:

> David Laight <david.laight.linux@gmail.com> wrote:
...
> > > +		size_t size = umin(round_up(sp->len, 32), 2048);  
> > 
> > Doesn't min() work?  
> 
> Actually, it should be umax() as I want the largest of the values (as Jeff
> pointed out).  I prefer using umin/umax for values that are known to be
> unsigned as you don't get casting errors (see the number of places we end up
> using min/max_t(<unsigned-type>, ...) when we should use umin/umax() instead)
> and the compiler may generate better code as we've told it that it doesn't
> have to worry about negatives.

umin() and umax() are better than min_t() and max_t() (which is why I added
them); but you lose the compile-time check in min() and max() that rejects
comparisons where one side is unsigned and the compiler doesn't know that the 
other is always non-negative.

Basically if you compare a signed 32bit value and an unsigned 64bit one
with umin() the 32bit one is zero-extended to 64 bits.
OTOH min_t(u64) will sign-extend the 32bit value and then treat it as unsigned.
In both cases the onus is on the programmer to ensure the 32bit value isn't
negative.
For valid non-negative values the result is the same.
Zero-extending is usually free, sign-extending is particularly horrid on 32bit.

But it is better to use min() or max().
The compile-time tests will reject any cases where the integer promotion
rules could convert a negative value to a large positive one.
Note that the types no longer have to match.
Code like this is (usually) ok:
	unsigned int blk_len = ...;
	int rval = fun(...);
	while (rval > 0) {
		u32 len = min(rval, blk_len);
		// process len bytes;
		rval -= len;
	}
even though the types passed to min() differ in signedness the compiler's
value tracking means it knows that rval can never become a large unsigned
value - and min() uses that to allow it all through.
	
-- David

> 
> > That doesn't look right.
> > If sp->len is bigger than 2048 the you keep allocating a new buffer
> > and the call below overruns the allocated buffer.  
> 
> Yep - see the aforementioned umax comment.
> 
> David
> 


