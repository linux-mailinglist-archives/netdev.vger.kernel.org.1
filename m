Return-Path: <netdev+bounces-306801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7slPCXcZUmr1LwMAu9opvQ
	(envelope-from <netdev+bounces-306801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2C2741366
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BgKBgmA2;
	dkim=pass header.d=redhat.com header.s=google header.b="jUO1/yDs";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306801-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306801-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF81301159D
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8F3AE18A;
	Sat, 11 Jul 2026 10:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384333ABD91
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765292; cv=none; b=PlSM9UYuSFTO8at5wCV8i7QrmikpwpOHYOc111GqRI8H/JLhjYyjqIKjg7IkKeDRmG7b45zjR7ZV78bjPcD/D7notY4Vi5t5IUk2xLe0kbDiwVsIKVvS7N8cwl2FBZ2k5WmKY/T3c/Uo1YA9OaTFy5M6HjsX0QxEiAxHAuoveKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765292; c=relaxed/simple;
	bh=UQB/hpyjg0fkQEqF4vmD7lOhkY9VP7eUZBHDfc2wfb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoXO9gSYFnjkiLAWE6SBST4NO7uq3zpVwstOt8BiVOSJ+qdkfn69l3Kke6ybTt/iAonsOTekgJtbKKozot7L1/TCyJ/U7Pfsw7fLNOmgD5YCt8Q5ucN7Ft9G2ItD6B89y5sYFeMx0k4BlXnksGCjeFWNZYc9rbN2zDhSJK0xFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgKBgmA2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUO1/yDs; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783765287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqOWMNobt5ZaR1dGNykes+ERauAl9+tAeFvEcMLSsq0=;
	b=BgKBgmA2WbWJUeoyaiU06rX1uh2LHUEib4Io9FIKLyypP5dP30D8nnUvW1bcXWhRpA/cFU
	qr2RJ8qSwuTnBm6RCjeTu8jiGLak6/9NdnxSWC34WQ497y3lZlhHW0pAMlhpg15xjIyNhg
	0Xxjedak+OPQEW543UP6Ex6DogK0PJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-y_X_bVQIMtCySbnOVVcuig-1; Sat, 11 Jul 2026 06:21:25 -0400
X-MC-Unique: y_X_bVQIMtCySbnOVVcuig-1
X-Mimecast-MFC-AGG-ID: y_X_bVQIMtCySbnOVVcuig_1783765285
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b54823bdso13627185e9.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783765284; x=1784370084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqOWMNobt5ZaR1dGNykes+ERauAl9+tAeFvEcMLSsq0=;
        b=jUO1/yDshoFqfPHwo/YQE+nLCAX/fFpAHuJS8Qb0Jv9kjyDaZbW6w5LGm8nIcu5+3o
         uK9+KxjCiC+sGYtzWIGzft8WfGGOzpx2X7ZBbYI6A7wgk+YuNmeAcAO2y+4aYUZZjQjV
         LHE2f416L4Uku8gw1MxSOeWfYJDG7JNogzBi43tro7MT1nQJOKLcKuW9fgR3ObVVGV22
         MbwFF0XhTULpHhxJcDFC3CbTiMUmCnuaUtkdl2tO4FLDSmQrc90inLFRsrP2oHHuaOPT
         2xAAKiTK+mKxrSgR0P8kfI9K9L7qPb1Vw1/EKHtTMW6UOzq9LeRtn0ZUEIxJPNBioM1U
         iMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783765284; x=1784370084;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqOWMNobt5ZaR1dGNykes+ERauAl9+tAeFvEcMLSsq0=;
        b=k6hGLps4Ga2P9FdPsx82J/JOwS2zHE5YUyu7YmHGvA//bcCChev4bcAgXmmRyHVORD
         WrXTb+IPma6V4ZdeoEXluT53ArpQuTYXRtgBMhYiOR9/4BLIY92dUb/lqKB6nNcT1XnM
         7Wn6gZKsKKNtwo+qrqabn88FiRKQyNAGZzuVOj8RJttzur8OU4YDFZheewq/gYvByCkU
         Zif0ZmTt2eFojUwRAKbFB+hPzXn5szfmjOuBU8wLa8vEwMCCVIw20NVXhfUOwAbmW5KK
         H58EOiD/hmNvpmtK/UHaBYn9bvt3EOOVsH1xFejV8zXeluuvCx8/O3yNSE6HcwZu9558
         xAsA==
X-Forwarded-Encrypted: i=1; AHgh+RqZ/bv9KJk0wmOXSrs3s6KaDA/okZ+0fA0Bl++71wyoq9Omv7VJ6hxKG5lAFQWPG4h5TSG5ins=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdTVWhTaEG/IR45RpjYMrhcm72qSM0ceH2wxre+amoMXEHIZt
	v/N+e/UwENLudvwpCPCrzlcAHAqpskDX+7TYNrvTBEXOZDY4MbeuQtAH8hUFEtdtnu6ci9dBpyp
	R0UqHuXE3TpIy0JF1AGM08IhYkYptSK9pu5ltPGvN/vH3CWYypVC0m4VWPQ==
X-Gm-Gg: AfdE7cnLPx5lg04b2dVHCKyGqdbFiPXl78T/F6Emi4kKzcAHLbVvpZoTjT17cezwCyE
	CRSCBEyrmxV3Atn6+wz7P1c4V9hqpZnlBpEAmTfM9qTUpuAZoRNN/j/myHcnzmM50OcUrvD7esG
	RecXNJJV/kCZmwae9j3WdaKytucUK4+cgrJB2GByU4MK8gV8d1dV+MSyKFo8Gisz028L8WXYiAt
	4Fv90h3X/uu3ut2nXHZH/FPtnYkPxEum+uXJwFoL9N8lsKx7tQoE/5voqK+p+W7VCKQr5EE09sO
	c9DeDm7Y0KL9CB57qlbjY7tPUCZuhxvrWelEeWcnmQQme8zyx9Bb13uR0gMfgAvcVA/QxXfkJYF
	Yi/cy+jACF80xD2hQhuhac+4aF7/4VdosLeqQF4lCk9U2urQ2/VoW/Fxo/0guZZtwTwoc9BZVn0
	My/TLs
X-Received: by 2002:a05:600c:1391:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493f88bd849mr23242685e9.9.1783765284605;
        Sat, 11 Jul 2026 03:21:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1391:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493f88bd849mr23242515e9.9.1783765284207;
        Sat, 11 Jul 2026 03:21:24 -0700 (PDT)
Received: from [192.168.0.115] (ip90-44-231-195.pool-bba.aruba.it. [195.231.44.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f49755f9sm116063285e9.8.2026.07.11.03.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 03:21:23 -0700 (PDT)
Message-ID: <9576dd12-9b68-443c-be53-486516bdf801@redhat.com>
Date: Sat, 11 Jul 2026 12:21:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] ipvlan: Protect ipvl_port.ipvlans with
 mutex.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20260703001009.1572444-1-kuniyu@google.com>
 <20260703001009.1572444-14-kuniyu@google.com>
 <71f1aba1-78b6-4e7b-8dc9-092b50402e07@redhat.com>
 <CAAVpQUDwa4cqLf9RJg2o25oN+xKyP+gv+asW4aK7LMNgpE3o2A@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAAVpQUDwa4cqLf9RJg2o25oN+xKyP+gv+asW4aK7LMNgpE3o2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306801-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D2C2741366

On 7/10/26 6:15 PM, Kuniyuki Iwashima wrote:
> On Fri, Jul 10, 2026 at 4:08 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/3/26 2:09 AM, Kuniyuki Iwashima wrote:
>>> @@ -800,9 +831,15 @@ static int ipvlan_device_event(struct notifier_block *unused,
>>>               if (dev->reg_state != NETREG_UNREGISTERING)
>>>                       break;
>>>
>>> -             list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode)
>>> -                     ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
>>> -                                                         &lst_kill);
>>> +             list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode) {
>>> +#if IS_ENABLED(CONFIG_IPVTAP)
>>> +                     if (ipvlan->dev->rtnl_link_ops != &ipvlan_link_ops)
>>> +                             __ipvtap_dellink_ptr(ipvlan->dev, &lst_kill);
>>> +                     else
>>> +#endif
>>> +                             __ipvlan_link_delete(ipvlan->dev, &lst_kill);
>>
>> I'm not sure if it's worthy a repost, but what about adding a
>> link_delete_unlocked() cb to `struct ipvl_dev *`? IMHO should make this
>> code more straight forward.
> 
> Since port is allocated in ndo_init(), ipvtap needs to wrap it
> and overwrite port->ops everytime for one time (or at ->newlink),
> but I don't have strong opinion here.
> 
> It would be nicer if I could follow up since this series gets 5-days
> penalty on Suie due to too many Sashiko false-positive, get_net(),
> and a build warning due to xchg() for veth, and we will likely lose
> context next week :)

FTR, I'm not strictly following Suie order - it's more a mix of Suie,
FIFO and common sense. What impact most in series processing is the
sheer amount of patches in PW vs avail time.

/P


