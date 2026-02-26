Return-Path: <netdev+bounces-261314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEOTM181oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:58:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEF1A5760
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBB2308A16A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7E337B3F4;
	Thu, 26 Feb 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8NwG2i3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="shpmifPT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61637A487
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106955; cv=none; b=UJ0rGGAueocEkQeNdKDC+zIXw0Qd3Z4v8QB/A2Bcea56NkwvQFuoeIXRbO3PXq4godMmdDxgTdTlWu9TXRC+aVV4JYPLaF/CxtIzskC7OUsEQ4dvHgWiu30GX1CbBAOHPy5cvhJiP9iMcEnxq6TQMRUU2kTDy5Hwn0WeKYZnenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106955; c=relaxed/simple;
	bh=ZEIFoitANPtwulIbNXF/2yg+hzs1jJsGnxSrJ2pHJVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npcj0qduTzTHhsRjov6L5hZfBZGiVJzRGdXQlQy+dbZ7M/flvBh1m8lBaQM3aVSvWw6Kdo7IQ9OfZVhEV9xVzY5WpeY5rQc9vKNDnoVPz7SkRQzgJSn0U3x6U4TI+QSlRBA8vOy2jRTknYiXM0DuQJbe8GRmReE4EpJaKRzvCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8NwG2i3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=shpmifPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772106953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMPGt0J++KNAhRXBcWxcdK49BwEppu2ya9w3VAKm/mg=;
	b=a8NwG2i35t2eH29ilrT5h9ypb2eYV2f8ulk8L4ZN45wNqoBTFpdL0qnmdSHrSzOIlxO8eY
	RzuHJT3cRi5WBjnwDLRQQRALaKDj1L+tiQDwI/g1Ok/PP8Sx62kJuVC7fq6o5iBiJ2+YB9
	SS5GVZuI80Ch5H0lo5Lvb1yjJhPc810=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-VHN7-Ts3PvSDkbfMzc_9YQ-1; Thu, 26 Feb 2026 06:55:52 -0500
X-MC-Unique: VHN7-Ts3PvSDkbfMzc_9YQ-1
X-Mimecast-MFC-AGG-ID: VHN7-Ts3PvSDkbfMzc_9YQ_1772106951
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so3854055e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772106951; x=1772711751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMPGt0J++KNAhRXBcWxcdK49BwEppu2ya9w3VAKm/mg=;
        b=shpmifPToUG29nZKqBKmEBVphlt6mesOyCoX4UaukpdSs2EdIOfJfJ4pPrk4foy0L4
         QQHRb9QA42FW2bzLUIenvnlnfYl6/XEUvv0oJlU1x9P5PDxLmunPr7xwrV9a2a4b3b3X
         g6Fy1x44OyG6M2FwTbJ7sXIfbVCOyjl+TQnp8pD+5trXk820yhEfs12xM+WyimYdzv6B
         jh6iY6x4w6DHv+dX2fVcdp8WTT5+9QqBtgV4J5+oPn2ABT+EAM2Ta5TkGXYQJtGWSv8a
         Yc6W63G7GCYoG8jr7poxEePsMr2lKKWg7BJ37hS6IOk6lMb41/TbT29nWLFh0WVNAdYl
         ERcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106951; x=1772711751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMPGt0J++KNAhRXBcWxcdK49BwEppu2ya9w3VAKm/mg=;
        b=fPPYmf0I/kNrmURrwf0YBPZyouDepbkRUdRTiqjDaoTZeyEzS4GqOpqystSR6kjNxM
         TxLIHUErq/3bsR0be/X6bBsxOE98bMBprc683YnK6FjUKEf8h/vCa6u3JVeLV1+/1og6
         VCxMSG6gix0Ju8ROHe/c7aKavCm56TnQcxVQaQYrYp6uhwblWYvZp7sRdh1JoVFoCtV7
         9DKXkU0In3OHpX73PgHgg4u2fK3LN6f37AxBmDUyfWTmof7idQrt146du5Rc2kGjqbX7
         TXUVgDhjN3wyXy/JlgvM+0WoR/9qeaeTSHTqnhlIen7GGnNBzR3cIp5CmuOy7jQJhhhs
         QLBw==
X-Forwarded-Encrypted: i=1; AJvYcCUobiQN50v3Ewc2b+QjI9s4HZl2z/conNwoeTJvWJnHr6Sb8flhplX+plCHREALMIxWx6b3Ekk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AJnxI4jpph4kxscGG3RfvMZ2tlCX89S9BPzuxsJuQK9hQ7Bz
	k2Ld36nXq+R96CNwDwd0qOUTBz5j/7JSWrXoQW4jgw657sGjVS5DCZ58+D8mNm6HXDQXMkZf15O
	jywatVpHEenCS2jlfiHTapsBEbLJh3ZGYP24C3Er6O01Wja/QRIdUI6PqPA==
X-Gm-Gg: ATEYQzxNP7N4aNj6XYhlOjnX8Gv7580wwzUyuCUSK2g/WbDMEEllxFZHp/Gt1CRPnZH
	/kXPostAngUbXfnDYkXY2HwJdgW0av2Xzz3jSSZtyD3IG0Hj/eEvlr0RyXb+zL2WxnFMhSGv27r
	mCxBGAJewWQcWQhqF5roW61MokEy47uk6jLSnVIQKi63EH0YUmH4f3e1yf6PQ3FzZqS8Lt0F1i8
	YfZBtImJlPeC79Oqq7dn4I8YwfcHOKzeejUFJhjv2kCVHd2HsltfGZPRuzNiaJ5hilRg4/Hwige
	8KRBa5tuFP/9blEpLY1lmxrv8tneLA52P1EDZ6uv0LlFY1kpljBwdeXmsHZ2aNhqiJ64tNRxelx
	PreHCi1hCfyXcpBrNelwPYS0Oqw==
X-Received: by 2002:a05:600c:6296:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-483c3df7964mr30951345e9.33.1772106951091;
        Thu, 26 Feb 2026 03:55:51 -0800 (PST)
X-Received: by 2002:a05:600c:6296:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-483c3df7964mr30950955e9.33.1772106950671;
        Thu, 26 Feb 2026 03:55:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb9b97sm57567165e9.7.2026.02.26.03.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:55:50 -0800 (PST)
Message-ID: <4f497c2f-d086-46ae-bad7-44285bc34a2a@redhat.com>
Date: Thu, 26 Feb 2026 12:55:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 0/3] bonding: fix 802.3ad churn machine and
 port state issues
To: Hangbin Liu <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <aX_6jyAQaDoqsR3G@fedora> <39c1b386-e6ee-46fc-a653-f86fa21e9e9e@redhat.com>
 <aZuzn-6vFrcoD9RW@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aZuzn-6vFrcoD9RW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-261314-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73AEF1A5760
X-Rspamd-Action: no action

On 2/23/26 2:55 AM, Hangbin Liu wrote:
> I'm not sure what I should do for this patch set. Should I re-post to net-next or net?

Jakub and me discussed the topic off-list and the current agreement is
repost for  'net', with fixes tag.

Thanks for your patience.

/P


