Return-Path: <netdev+bounces-306521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vtmrAdfTUGpx5gIAu9opvQ
	(envelope-from <netdev+bounces-306521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E073A03B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BotuWdHA;
	dkim=pass header.d=redhat.com header.s=google header.b=gQzTb83C;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306521-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9C73002773
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684E3FADE8;
	Fri, 10 Jul 2026 11:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87C3242B0
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681883; cv=none; b=bLUngrLEc5bDst8ItcmFtgsww4jwid1eJNP0eHrMf+1fzLMQchUhwJXS8iml4Mhxv+MQn7B9DqGTChDSWN+Gx9KnM9T8Mzb5ux7Bk+JIgK+hnJg9lSKIh9vXlG3SGubCLGSwtxGP5kcNqDfyiUz1MfvJxkdhDtb5d+cN/4gTI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681883; c=relaxed/simple;
	bh=IjwYcTEUmviI2uzN9C6VmQsKSRoMhAtF2iZWcHvltfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG7PWW9GsWspz1QRXjPjiU8R1yzYzvM1QLjrmMqTPhuhfPrB/9fLcU4sWrK58By3XcWDc9qCxaBPcpzVMlNWTTPxVuUPmvR1qXjKUHYsfrXF61WRTI1LnbuK2nyX9Tdu3UJxRpDmv3WD513nUvga6PBht6Tz6rIRDS++TGzZsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BotuWdHA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQzTb83C; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783681881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVcLc6UZlaNd75973r5+79VoMznRwSRrsQ5aYsbl16s=;
	b=BotuWdHAGWMawONSEgqPnAnZpZJhN6+hlPW7z/WZUC2yxP89iP0i0/BQPJW8KzF/5JKEoL
	AcgBiFxoTeGd8oba1Q2SDpu1pqPdHwUyJkBLe/UdjYfaMsXXDTNl6pZODzyHN6j78o+Sdf
	6r6imyrG+Cbl2WrH2nk6ry5mtEqeVs4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-DDViNrzyPrGJEWNHSnctTQ-1; Fri, 10 Jul 2026 07:11:20 -0400
X-MC-Unique: DDViNrzyPrGJEWNHSnctTQ-1
X-Mimecast-MFC-AGG-ID: DDViNrzyPrGJEWNHSnctTQ_1783681877
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bd1716b4so4032905e9.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783681877; x=1784286677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bVcLc6UZlaNd75973r5+79VoMznRwSRrsQ5aYsbl16s=;
        b=gQzTb83CzAIkiZgiOfvCnkQLVBBvo8nw58SeIz0UTztbKA7HQv7GxRuQ1paLYraEG7
         Yn+RRC4hVNYirgIiTG6K69N36kIcu4gUaGqEKadshWZm0GwoQWA/xZ2edcnQiOuvLoj7
         PyFTEJ37LEvIhbrjEdj0WJLXvRG992Bl5WaL65hEJdKOFPeqY/cN3O9DicUcF6SQhUGX
         vesAMUtfr7e/GmuZAOQ9p9Pfp4V8ECO2JQ9/ZRXVWR+7RF2EIgGnFYfv1panjCuqE2tf
         +4wAhK70FhOdreeQPtiT37T11mVnVB3S3K4dvHJRnqlXEirF57KzNgNMRU/zgVVIMOAb
         KrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681877; x=1784286677;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bVcLc6UZlaNd75973r5+79VoMznRwSRrsQ5aYsbl16s=;
        b=J4DLJ5EO9nCZiQQ2W3FbmSC42UB9T9saZfijerGPOzgx5Cdn3jm5H8vb0SlAZ1lt5A
         PxKetDJLlZmuXYjLrDAjPq88fY8inERZMMu1Byqko+1cviHA6tYOeVO91VOADFk+Zko2
         LoylnfMcxcv0rHVm1e4lF78RdEicjPKD/qrtYdr1Sf+UVQVCA3dBtLj2MAPpo+5Nrpcz
         CRdrhLbGvgAmpGxYualUmco//EAsc2bgNKQxKjUdqOF7jqPL+u2yBwFX0ESSXuRtBWMC
         i9Q6zYR0EsgqJXpGD1wW8j8dM36YGlyFJybSMLv3v30TpgXHUu+iNULJmweYaf7Xqx6y
         dHsg==
X-Forwarded-Encrypted: i=1; AHgh+RpyZhBHZteho4fH/BlKue24noCNGLt5iF+o96u/ArYksZFPrXoiIR83u7BA+8B47socT2FpVvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Mnez8cFWx38MdVm06lE7AUu6lu7djTWIzf5Iea1vQSRTRq41
	4NmNwNqb1j2W2zDMIdjPIWmkMgO+SautzkRE9o6QhHXjs4HZcBpYVcU1DBvM9HJ4hPEaTQVlVWb
	KFFYOi8/NHvhLtHUy4G79Qf6RSKOx+GxmMMULFCQuht0os/ZN3bMvwc/qpQ==
X-Gm-Gg: AfdE7cm2lyd2Rx/kddqyidbMqiF+V5G+YtPyxGYUnvHMd1yekAEr1wmGObbAY2lx1Ex
	Qnn0HX33z1ywzclFE454sUi+/YegZd4UnbWVmngpgMJPHIAxeDIn2gAMiiEgJ/J2kgLnOVhPg6q
	mkGklYjfnaCmzvKr6d9nhvhTPJbqRsHnJKcqlw0iLXzjUlQ3nK9Ji2dagMxTxy9wGUC0lOxD81L
	V97beJSMmhJFhDb116tEFWz4UbLqDBhUqZ6guDCBZdYEImWVoF7O9h4qfcFT5U5+Y3smZHzIJ8y
	TLKNSyFWbOq927ZWVgZiQZlvhbZrgQTR7RBKyEvH/ybviEyfJ+Wu7zl9bVJPCo9fiWX5ZsaIdR6
	XBjSKzI3FQwYFMhe5HFOur4SaiUbPslELGh4EuIpJsmA+n+fqiVqDPvdozD+vv33nIe6ARGdD4D
	9iIKM+c9qg4tSS
X-Received: by 2002:a05:600c:4ed3:b0:493:e49e:f58 with SMTP id 5b1f17b1804b1-493eaf4b6e3mr68981605e9.4.1783681877078;
        Fri, 10 Jul 2026 04:11:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed3:b0:493:e49e:f58 with SMTP id 5b1f17b1804b1-493eaf4b6e3mr68981235e9.4.1783681876590;
        Fri, 10 Jul 2026 04:11:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm63287327f8f.7.2026.07.10.04.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:11:16 -0700 (PDT)
Message-ID: <29350bdd-d351-478d-a036-34e4279d36f2@redhat.com>
Date: Fri, 10 Jul 2026 13:11:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] net: Add per-netns netdev
 unregistration infra.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260703001009.1572444-1-kuniyu@google.com>
 <20260703001009.1572444-7-kuniyu@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260703001009.1572444-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D5E073A03B

On 7/3/26 2:09 AM, Kuniyuki Iwashima wrote:
> When we need to unregister a netdev in a different netns, we will
> delegate its unregistration to per-netns work.
> 
> There are three types of such cross-netns devices:
> 
>   1. Paired devices (e.g., netkit, veth, vxcan)
>      -> Unregistering one device also deletes its peer, which
>         may reside in another netns.
> 
>   2. Tunnel devices (e.g., bareudp, geneve, etc)
>      -> Destroying a netns removes devices in another netns if
>         their backend sockets reside in the dying netns
> 
>   3. Stacked devices (e.g., ipvlan, macvlan, etc)
>      -> Removing the lower device also removes multiple upper
>         devices, each of which may reside in different namespaces.
> 
> In these cases, we will use unregister_netdevice_queue_net() to
> queue such potential cross-netns devices for destruction.
> 
> Each driver must not call both unregister_netdevice_queue_net()
> and unregister_netdevice_queue() for the same device.  See the
> subsequent veth/bareudp/ipvlan patches for how they avoid double
> queueing.

Only if a repost is needed, possibly avoid the double negation above?

"""
Each driver must exactly call either unregister_netdevice_queue_net() or
unregister_netdevice_queue()...
"""

/P


