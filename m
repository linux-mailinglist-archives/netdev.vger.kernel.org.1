Return-Path: <netdev+bounces-277609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN+DDDp/2WmjqAgAu9opvQ
	(envelope-from <netdev+bounces-277609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF273DD557
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABAA1304BC90
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524CA340260;
	Fri, 10 Apr 2026 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM5ZA21M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2734107A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861504; cv=none; b=XHRceJrRVGdde40OFHTomJEMeXruVnA6x2kWX00GPAwEwVImzDnTtAM5m+534a3zI7HxrV6AY1rAsD4+2rsi4su+mTZgh/kU9nsoj0V2IUIgFxO0qIQgUGkiSDY5ssJNUlD+CKmt2BBfBG5vaiJG77DSSZDIHkUivph2jZIF5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861504; c=relaxed/simple;
	bh=Di4tu/kMFuGh2vl/5dJ4nd1Q5pkVKTyy3dHQxra9kns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHJVcliMqur+cJIs1tURqZdYdgvMUAMqlb/pon+DXW+CKppC7lTdwDzjzO9BJIOkyNjVoCMCcnrKyXnZcU4AJp3xywI5ybT9vRdoxnzDgah6zVaoHouJ0GprZ2oLNZyb1yW9gbfS3vLYK/ul/QEGcnLR6L5HMcQbMdk3vyyEXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IM5ZA21M; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3762953eec.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861502; x=1776466302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PrC7kkvkuprqe14U4AY2VBeTVieL7bWJ3KB9Z6fo1Gs=;
        b=IM5ZA21MH6EFRXx9nO5hXyCzT8rSFEQQB65TbwpAftrKNQOhgBNyqRAKaFHFPqd/5k
         plDQSs+0AlEyWub1MsAbQetS/kox6OeZikmDcrfDfEZW0ng4MCqn73hFt5BiTq5bozJD
         V1bEuwC8Htpa3d19shB6usck99ShmiYZ+z/CQxwWOaYC4BnksZoVaMY3Nk/RO9HOQsX6
         gJ078zF0xG9FZv/z4NQ4NQYqzQxu6wZJCUC6eAf9LN10gYCpRwz7+ENt91ovO1G+RUI5
         0ijc8FN4HMGGyhsgVVxxu+/tpNSGzAMyPsMSiKS9mg6tHBB3PABCwvLbneG+88A5hFZR
         GhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861502; x=1776466302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrC7kkvkuprqe14U4AY2VBeTVieL7bWJ3KB9Z6fo1Gs=;
        b=QmU3BdGpEtVTGcVu0J6CnSBWLtrZ/7KofMycU0/o24pgudBqEhqaUOAjsEBPKxn0H/
         eXVIIUucD2hTMpFL1xH3W1qB4+2JrtUzPUycozArRZX+2TQlCFI12kVxoph3LtUQcxtQ
         l5TfsO4WS+0kocwkZekv2X2JUYsHm++JXNO5tI2h3mqsOjac7qip/vEzJ/5N3TSz/ctE
         g4PJwaBme+2ztDwCRD4FhRgHgxZ592+oQt4tIs3jzyclCSfcjaozybdYakGZA2fGQGkl
         FBjXJtE3UIjC3IsB5SmZ4J/g4ba+6LURQyNuJ2BDeWYj73tGB9lcdRzvxTPZUI7SEhE1
         br1w==
X-Forwarded-Encrypted: i=1; AJvYcCU5m3G+CGMCQO1jAXm17G4YKDQICn8hOXFp5+xigE/r+QduKk/Wrqe+S25EaevruSvzL5qYL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGNr7bGD7wFWCcDp4ZYL1yY31e0xPknvahUw5j16jfpCAa+bL
	w2g1U0RZ+gY0tCygfYwW0kxKQe1T0zUNTMfxlvP92QJcW0ukpAsi32/l
X-Gm-Gg: AeBDietJ1K4IpSq8T4ZYyTPsamL86MOiJ4YDv32qR5ZE4yL6gXshnHU4EsZgt5O931Z
	4bSFOki8pz5lT2X+PjAUqcM3YSP7RPomD+WpXrzHw2JqXh8PCfOtrYVD6waNbp4V6K76uomyTME
	LYr0vBNiHWAlZWgJ5/6AEPNNSDMyMzu9PkvW+s2T+hDu1TyuO2UeweMQg0N1evOpZx74cWE+fWY
	eeoVzwKTkZmnR7RZRVM/BInPQg+hl/rk14AVVcOQ2NHDnHQkNXcorMBi6h20qM94N4wARg7aeFD
	ekhc5vVvbbDhlsXCx9AbmjrE2VqAQJq2al98AvgsaYIFhc7qnzyeLOYF5xnwh1MLa481l9r4TPy
	XPi5+B4++8W7iYPDvN1zOPiRG0a7cGZi9MPdu2SK3FZg5x2hIGLn+KXtT4QZm+3eudm9AoeT90g
	r2MP3jWs2qIrcycambu834QktTADDgag58Z5HIy9zE6lcT+L0KlgbtV9KT0RO3VZt54PuRDxDuv
	kdJ/1U=
X-Received: by 2002:a05:693c:2c85:b0:2d2:cf9b:ee6e with SMTP id 5a478bee46e88-2d5895690b4mr2925275eec.22.1775861502242;
        Fri, 10 Apr 2026 15:51:42 -0700 (PDT)
Received: from [192.168.1.113] (c-73-151-174-35.hsd1.ca.comcast.net. [73.151.174.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c6b10sm6249959eec.5.2026.04.10.15.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:51:41 -0700 (PDT)
Message-ID: <761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
Date: Fri, 10 Apr 2026 15:51:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: hugh@blemings.id.au, Kuniyuki Iwashima <kuniyu@google.com>,
 kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
Content-Language: en-US
From: Craig <edfardos@gmail.com>
In-Reply-To: <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edfardos@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,winlink.org:url,easymapmaker.com:url,digipi.org:url,qsl.net:url]
X-Rspamd-Queue-Id: 9FF273DD557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> If the main concern here is ongoing maintenance of these Ham Radio 
> related protocols/drivers, can we pause for a moment on anything as 
> dramatic as removing from the tree entirely ?
>
> There is a good cohort of capable kernel folks that either are or were 
> ham radio operators who I believe, upon realising that things have got 
> to this point, will be happy to redouble efforts to ensure this code 
> maintained and tested to a satisfactory standard.
>
> Or, alternatively, as a technical community it may be that the Ham 
> Radio interested folks conclude that out of tree or user space 
> solutions are a better way forward as others have proposed.
>
> Give us a few days, please, for the word to be put around that we need 
> to pull ourselves together a bit as a technical group :)
>

I, for one, really can't imagine pulling an entire network subsytem out 
of the kernel without any
knowledge of how/if/when it's used.  Like intercontinental radio 
networks, global email, ax.25
keyboard-to-keyboard, BBS and other emergency-communication systems 
throughout the
world.  If you're sure the Internet will never fail, I guess it makes 
sense removing all of this
since it's inconvenient to maintain.

Global AX.25 keyboard-to-keyboard on 14.105Mhz

    https://qsl.net/kb9pvh/105.html

AX.25/netrom VHF routed networks spanning from Oregon to Los Angeles.

    https://www.easymapmaker.com/map/80666c4898ec6e8fa0c35add5d03282d

Global radio email using AX.25

   https://winlink.org/RMSChannels (1,336 AX.25 email packet nodes on 
the Earth and Space)

This is all in operation by Amateur Radio ARES emergency 
protocols/technologies.  This
will not pass the headline test when it comes to Linux detractors.

Most of this is running on Raspberry Pi / Linux 24/7.

If we want to kill all these apps and somehow force them into user space,
it's akin to just switching to Windows - and flounder with the Microsoft 
folks
trying to do the same thing.


-craig
https://digipi.org/


