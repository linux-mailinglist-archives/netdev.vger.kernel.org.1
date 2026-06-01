Return-Path: <netdev+bounces-293795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C6x0KFObHWpucgkAu9opvQ
	(envelope-from <netdev+bounces-293795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A576211E0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A7623004C3E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00A3BC687;
	Mon,  1 Jun 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1RLGMpM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IftaV4Bf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD83B9956
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324739; cv=none; b=sPvOQqY+YZHhlVl//hh3RJTk+bsapk0J2T6yNoKzFOIlNg7bjE/lwAPqhLaY2O69Zeju9OQZC9L+lmaou/IRUMQEPobLHUWjp4/clMNss0WIL6iNCPOt6k8wfw+6JyFwnCnXPavhOqZbZcqTd88dHnyAN2ECfbQBULhGgHo8eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324739; c=relaxed/simple;
	bh=+CnGQ9TO70FOcTY4MRKaNNO36huxITPaBaCyxApkKOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKxKj8OR8qmrHB6rlAKTmVKgO5ZTDCDjAKRNKUtQMhKY5xFuMhNnWPxgwyTptmcWwhp+NL9kxPN0KHGr/qSx1j1GgXqBi85IXuIXX9ZIpaIJ4CwJZMajrspkN2bmUsNZKJGvTWQsq5wcx7e+ViJZqZ3VW3XpBrm+g+QScqh5tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1RLGMpM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IftaV4Bf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780324737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etk1wl0EQA40zfC85KF843N3y3SYchLVXHGTkLkJ2Ts=;
	b=M1RLGMpMWRdzIF81mbSq8KJvXXvV4544vwjQbWYW4mcrjFNrcz37/Rqwmk1uaUWpZRYB/D
	32MEbM+xg2I82LAQ4lExlsXe9WAyZD6pql/js0rGBIJU2X8Xc3y7W8EYJQX+gg+BB1VtRU
	7kM2l+zaW1cKZZYmQTRZHvQhs5PU8BE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-GqOaj06eNICv7yG6kP9oMQ-1; Mon, 01 Jun 2026 10:38:54 -0400
X-MC-Unique: GqOaj06eNICv7yG6kP9oMQ-1
X-Mimecast-MFC-AGG-ID: GqOaj06eNICv7yG6kP9oMQ_1780324733
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so1223861f8f.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780324733; x=1780929533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etk1wl0EQA40zfC85KF843N3y3SYchLVXHGTkLkJ2Ts=;
        b=IftaV4BftOHOO2bTtbGhg7BuqHHojqHftmlx+gMBI8ylke0LCFlSPkkrd7uudSZz+p
         RqdSzCuXwn7sXSwTQ15MUv9TMpzkymBD9SvARYgC2U/jKx05L1IYhVnrggsveqcZveRc
         K4//BawgTIQS7f4lMKWF6rMnx1+x11lGibALNopYLJ5o9tBYsQ4hnTBlw8CZYEzOTH5g
         roDSWQuSqLBBJ3AgLg50pzBysQ+xxkYsCZjf+wwIQRym/JguGurO26BiHiOobMP2beqE
         gNQlLyzG+PExw+qP3XvfmSnzHfuz9M42kw5fLnXU4UiK+s0AsJz1taHhS3Ouax6Eb5pu
         bQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324733; x=1780929533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etk1wl0EQA40zfC85KF843N3y3SYchLVXHGTkLkJ2Ts=;
        b=Eq7+u3/5wWFxh4VNWZXT3dMoIn1LqDTuiyniudLKElA8DiaSZa+SzLunczWJhypJhr
         b49E45YJgFRZnchAoQD90HzeGeGP293WpL4b7BY2raeagL5Qj8djfu8rzN7c+m+k6tfZ
         gUBxQTTnWOZPMvrzJAFnqtXiy9eLEF3msTPps1ovOhTRNmfwX0V2+2DaVeoF5cmrv03n
         8XMfNK0i62wHtSFQH2qXte/Qi0msUns8zIJ+Bd90RMJ9u0bEKMBkKKmWlm3P15Qg0TpG
         WRMjRijMHXvu8liDCMtNH5mwLWnn9oe8LNXWyvk9jMyWMvnWNEknJ5oXGp+LoQrSjlSG
         eRNA==
X-Forwarded-Encrypted: i=1; AFNElJ8UaLwxPoSxGZglpdJCDwiuQEJ1b32x13Q0lWn++6Hn4TYHWCocDCzibEnkCT8bwk547OSTaCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwi+Zu3g+BkBSQman7X59ALzvYGHjSOC+xmkEb/j2M/Ua3m3A
	tnlx9FoFYUK30FMRz2EYqzK9CYuiVUgp9XcopZ6AfdiGXJ6LM34HLRz+ZOyxcyMmTzDXTBFapsX
	C4HZWDoyLAO+fgeVsqqjVSwW03m4z9aEzM5ESUpZdL973a1WO1lB7vrKQhg==
X-Gm-Gg: Acq92OFOdTu0MfXrWiWP5rWN7iCFwGh4iM6qg+7Cr1CCdOx3ERjtDgnmSQb9ifsJrqh
	c/lEGFiaW3p/uNvaxIoBbvOhlCet31lq/cd6U9o7c9VDMHyy4f2G3jkdaEMo9h4G+CQSqeWC1Mc
	fDvdQspxmNStb6VkL83HeWPzNRNuau/+7NKu37HpVW4jHBGFUvxZ1gpTNZ7iOJypYmqLqLXkNCX
	oiL8f9vFT4RfreMJwcgsZsSOFmjn2vAaNatd12lvyqr+OSTqib2KMVmdQKGFrj5jkWkkhBpIoMn
	UWeZPals4s9HSmphMWdOEFfY+O2Ns+lmSdUPCWgm9epCRUCoM1uDLXlXWrfkbZzxnCeJQQlbssa
	m4Xt2D63RA12zBVzSslZ517bWYGlwsuEq/ZltIMRqfZJpI+ST3a5LNMN9cyKunmQueq6F
X-Received: by 2002:a05:6000:26cf:b0:460:1695:89be with SMTP id ffacd0b85a97d-46016958be4mr2527484f8f.17.1780324732798;
        Mon, 01 Jun 2026 07:38:52 -0700 (PDT)
X-Received: by 2002:a05:6000:26cf:b0:460:1695:89be with SMTP id ffacd0b85a97d-46016958be4mr2527437f8f.17.1780324732403;
        Mon, 01 Jun 2026 07:38:52 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25549035f8f.18.2026.06.01.07.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 07:38:51 -0700 (PDT)
Message-ID: <4bf036ed-cf48-49ef-94df-8d7a03b0cda4@redhat.com>
Date: Mon, 1 Jun 2026 16:38:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] net: dsa: ks8995: Delete surplus driver
To: Linus Walleij <linusw@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260526-ks8995-to-ksz8-v3-5-c530f651989f@kernel.org>
 <20260530004902.BCC381F00898@smtp.kernel.org>
 <CAD++jLmZoGh+o5YKfjoUCWhwiRaO+Lm-9DFUdUzd9KpydWK27g@mail.gmail.com>
 <69dfe2a0-ce0f-4a92-98b5-c4cefd30ce49@redhat.com>
 <CAD++jLnZ1h4MpDEZn5FzX7yzGLYGCpt794zNf0OXQmgKnFPWew@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAD++jLnZ1h4MpDEZn5FzX7yzGLYGCpt794zNf0OXQmgKnFPWew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17A576211E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm re-adding netdev to the CC-list which was stripped by the sashiko
bot. I should have checked better in my first reply.
On 6/1/26 3:12 PM, Linus Walleij wrote:
> On Mon, Jun 1, 2026 at 12:41 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/1/26 10:09 AM, Linus Walleij wrote:
>>> On Sat, May 30, 2026 at 2:49 AM <sashiko-bot@kernel.org> wrote:
> 
>>>> - [Medium] Silent loss of switch driver functionality on kernel upgrade due to missing Kconfig migration.
>>>
>>> No-one cares.
>>
>> Uhm... I have quite mixed opinion WRT to the above points as try to
>> avoid breaking users in any way. I'd love to ear a 2nd opinion from the
>> DSA crew.
> 
> OK then, I can be less cowboy-coding and try to play it nice.
> 
> Would a phase-over Kconfig option making
> CONFIG_NET_DSA_KS8995 just select NET_DSA_MICROCHIP_KSZ_SPI
> cut it? (Sashiko suggest this I think.)

Yes, will do for me.

Just wait a bit for Andrew's or other DSA maintainer feedback for
confirmation.

Thanks,

Paolo


