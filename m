Return-Path: <netdev+bounces-256943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N66NPwShGkTyAMAu9opvQ
	(envelope-from <netdev+bounces-256943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:48:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB43EE65C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 04:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 224D03012C76
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 03:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365002E7BB5;
	Thu,  5 Feb 2026 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zvUqzBm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDF2E7167
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263287; cv=none; b=BXM1vWTHaMW3xGZIr7XQfBRePKx5XY1LGlBqmLlV/C2t4wBqOxKTQvtJNjDkxnpEjGJx3Q7yJwBi5kUGx9sMJTFQjsLbLdp8TRIUy+qZm4WwBivE3DWfZZRUjhc8uwtw5YZ92T5mX5oID7BSmSzllttYp/lEJg3ONvHExb4Iio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263287; c=relaxed/simple;
	bh=7y9Hk6JlXCrERWliXg/TQZ3X+/C2SnPJyTWz26+wDdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFyRNFlonyCoKzwRr3YVIPZ18M102e2phEedUFFh/GuXAiAJWQzFdoKyAIeH/jEI2IJQepu8PuOcapcwNyYBkzGvvf3M5jnRTH6ydXtReXc4xxaGprMIKrzCk3jmIdQGsQ8W0q55AHKnxVRjQiWGI+tNlvhMyWuATV+tMCyYA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zvUqzBm6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d18dd2adf7so292406a34.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 19:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770263286; x=1770868086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QofIONG1uzBkxrXk9BfqK0VXCGMliXskB+p+bTvurvE=;
        b=zvUqzBm65B1vzoarWWF4Hxh+tJQomRWyeL860QlOQlGrnN/7L+9aIlgHt4+Sgo9fTx
         UWH+VUahrhmzC9uaMgmDQfwygwkwV4UniCDkBKe1Ygew4kd9vx5olhGa1ZUBLsODQlR2
         hMP1Yxan/By/ZSoDM6zpDN0U1FxG8xC+pYUHjWqWv2b/fnxnAzfFM/dnc1+G9rwwZrTN
         gS7chibU+9uS460RhWb24oo6nueO4nb1QNmjtDVM9u5Jswqf+3edpgqmpu03/QlWk2ky
         j5F/AHTIP1fRAmnqU2C+skRTeH2g8GDRkcjcdY6yfWynkly5XpowYGk3bz10aV6drc9q
         lsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263286; x=1770868086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QofIONG1uzBkxrXk9BfqK0VXCGMliXskB+p+bTvurvE=;
        b=jcna7138RLQZm3MXvRD0DAuFE58vo2NEq33BKNqaDaBwwcFkE097BvGO1mY72EnpJ9
         gezpmn9mpjIDKQMEiRfkwpd/ZrbXaiCB9WoWDL8EMgKZ5vxPr8ynuiJ/0HLULfEKrcar
         1d3EciUtr8+HTLBTTJl4BYQ9tIfE4juHHoHsoS6EY4drLucLqiazwILG79yC6g9XIMVa
         g3p9UiE9ffPRMe1nMokJG5RKR/xnPe8hivWm8UGasJb1mjyE6zhXu4I8fiTs1OHmlHxt
         0AWyF8jqI4ghrKzzdKmgNTs+It7B3MYBnAqV1dYtcZjZ+WiYVxvEYVvA/VK2ycgFPj7P
         yiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDuY4EDECBioiIqe4MgjbckmbGTsMWOv2Df6kFvhhhu4iXWe8mGMm0IM00xF52KuElXHp11g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWbGo8pMgShCW5o7YisxAWnsDLeTWl+zFcyT1kIhXNlLVReww
	VWpKO3GnJh1yYaq877NExtnqXf7HVtTjPz4YaAwD6fzNApyW5qNhn4xa651prsqpaGI=
X-Gm-Gg: AZuq6aJvejIopAJ8EyydO8e/1TDzkeyDHPT41PhHw/UGZ5sQYL/bWo3u4uQJnGX4g4T
	mC465yu4FiHY2DEiLFw3VJpYhLttzJtoCAOJO+ioJBrZRH2pu/X/+jGzaz3NbxCMkL9eD+L/84I
	3CiYyIB7DTNGzr2ycwNnqGvrq/bwm5HRq+nVDf+9DJsgZQQWL42Fia22UNbUVG2nsA7vcXtKgtf
	NmNC/tl1/cGcuNYaRD6asGt7E7ED8vL17MsCH6j8uxA2A+5mZLsMSWhn/91uV4bxe+aS6R2am0H
	YHLSFptfXUGxH3uR+j8jMYfnHuyxyOvOXdshnNzQ8w63Oxrjh2WhN7xoKYc7aSReFTO7cQcyi2X
	8kUdhUlo9qAHvdBRl9FArEuNH10F3wVb9Mg2rrS1ZCaxYrLGb2XZQIg2s8dtb+lLE6CvCsR0tqs
	Ovbbwr6qITacnssIDjCD09ZaJ1Es+0ZY/S2xDWNiW0llk0N0HNQILlsQKeI2KvQXftFnb1wA==
X-Received: by 2002:a05:6830:6181:b0:7c6:cd24:6392 with SMTP id 46e09a7af769-7d448c1fffemr3274000a34.34.1770263285661;
        Wed, 04 Feb 2026 19:48:05 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d44922a33csm2799317a34.25.2026.02.04.19.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 19:48:05 -0800 (PST)
Message-ID: <55108bac-9edf-439c-ba54-ee25a1901d6c@kernel.dk>
Date: Wed, 4 Feb 2026 20:48:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Pavel Begunkov <asml.silence@gmail.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 matttbe@kernel.org, skhawaja@google.com,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
 <20260126173124.1f0bb98e@kernel.org> <aXhUfC7ZyYge1jti@mini-arch>
 <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
 <c37ae03d-2b0e-4179-ac22-7d0c01ff601d@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c37ae03d-2b0e-4179-ac22-7d0c01ff601d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: 7CB43EE65C
X-Rspamd-Action: no action

On 1/30/26 4:13 AM, Pavel Begunkov wrote:
> On 1/27/26 06:48, Bobby Eshleman wrote:
>> On Mon, Jan 26, 2026 at 10:00?PM Stanislav Fomichev
>> <stfomichev@gmail.com> wrote:
>>>
>>> On 01/26, Jakub Kicinski wrote:
>>>> On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
>>>>> I'm onboard with improving what we have since it helps all of us
>>>>> currently using this API, though I'm not opposed to discussing a
>>>>> redesign in another thread/RFC. I do see the attraction to locating the
>>>>> core logic in one place and possibly reducing some complexity around
>>>>> socket/binding relationships.
>>>>>
>>>>> FWIW regarding nl, I do see it supports rtnl lock-free operations via
>>>>> '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
>>>>> recently made lockless with that. I don't see / know of any fast path
>>>>> precedent. I'm aware there are some things I'm not sure about being
>>>>> relevant performance-wise, like hitting skb alloc an additional time
>>>>> every release batch. I'd want to do some minimal latency comparisons
>>>>> between that path and sockopt before diving head-first.
>>>>
>>>> FTR I'm not really pushing Netlink specifically, it may work it
>>>> may not. Perhaps some other ioctl-y thing exists. Just in general
>>>> setsockopt() on a specific socket feels increasingly awkward for
>>>> buffer flow. Maybe y'all disagree.
>>>>
>>>> I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
>>>
>>>  From my side, if we do a completely new uapi, my preference would be on
>>> an af_xdp like mapped rings (presumably on a netlink socket?) to completely
>>> avoid the user-kernel copies.
>>
>> I second liking that approach. No put_cmsg() and or token alloc
>> overhead (both jump up in my profiling).
> 
> Hmm, makes me wonder why not use zcrx instead of reinventing it? It

Was thinking the same throughout most of this later discussion... We
already have an API for this.

-- 
Jens Axboe

