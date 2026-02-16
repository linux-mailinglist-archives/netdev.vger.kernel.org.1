Return-Path: <netdev+bounces-258923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFbaF+JDk2kP3AEAu9opvQ
	(envelope-from <netdev+bounces-258923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:20:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4B1460A6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99895301704E
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E331AF3B;
	Mon, 16 Feb 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNe+fbHV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E235949
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258845; cv=none; b=HxiD/LI38yXbJWOCGUEig+3WpUpD58aqoCiSnc+bgavVyngMtuLEIiXXrC00HqEwS78jS1Ga1eqbf96GwnQWehEgLS8zICFohHca19OavfQLW553rQtV9onAilpwwGRq6sCPIfVfvN5rSa8wnKB6kr2zs7YpKSJedWUXCQ1Ngp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258845; c=relaxed/simple;
	bh=H3wWyJlIaxpptscyle5kQWbH/IEiSu0ZzxxSk9a+OF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXA3JCPyyyGI09mW6+tOR6kilA1LwiJsMdGI437h9rieeaPSLvC5WXQEdtuM6TKhCxVanmkhi1qviGJMa2iC25sx9ufd/Wr+07AUCOaSRb5VDKOmOF0nedVKePjQJo0Ivo06qRUxLuaJ9rwB9tROJNeuu2NOQc6zGqXmWxKBtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNe+fbHV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82311f4070cso1838345b3a.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258844; x=1771863644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SGfPAz3knY6jl8/p/kGnttqfA+WM5zadyjMOcVI2Qtg=;
        b=XNe+fbHVWmQ5SJglk4xlyFc0hfwS3sLsOxfzOH+Pjc5jdAJ0qDQ6m8xqvlq+8FGl4+
         pKE2WYIaa859hzUF7JGyPc92z1iAbXMsdCciIlwXKD8HYAq40G2zlCbHvbB6xevryZaO
         3ZPZ67TtZRKdCaJq1v9MonQdzeOU6480Rjsr1L2AKfPD75+g6+AkH12xWgt4LHasG5lA
         2cxBvAQDZ95Th1j4+xrQi3nvcwKt1AtXioioSZoiDudtHXqNmAQ150jzXWZHBi2iqudZ
         n1hXEIBvo2wPq33H9ZyhshG3wJR1egCclGA+WSrEKfOcr66qZxn2eMc3SUC15wryxfPH
         k1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258844; x=1771863644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGfPAz3knY6jl8/p/kGnttqfA+WM5zadyjMOcVI2Qtg=;
        b=RI/Im8wUR1HqVxSl9lELWO2KhVq6mu13c8AEC6HX+ekynTNjDGIooNAM+5DpRLwgMO
         UYXLmizoOxzfBzZ+TD4FxFhG4tIJT7LYm6rKC99vJZM5L2446CfPiokupzBeRW22TFiS
         gTbQadUG9ezZKFuksBVP1i+CYzKB2fSpL0j8HzJGWbxEy8pc+I7H2PUU1iqJpEFSied+
         Sh1gb1Yuwre8A8U7neQndw072yD4V+7VJyvc3X9WnuP8++nzpVb8XKJghdqTLaoFfNi2
         JXOewel6KPYSJMAnAyoWTebxeS5o3u4bUjAKgQG1AwzAQ2JgJxqNuAS1muzzSycA39p+
         V36A==
X-Forwarded-Encrypted: i=1; AJvYcCWnf0hvexAUX4k09hLldHnd0wLAygjrHwuB3S8F6hxAvTZuP7fwgtIkOGJBKqgaIAc3ePLqNtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7alPZl2jW+iI27ayNN4Pj+0ABTOiWpCZ0pnvvzA6j6Mw7pzk
	/8YaHxjRkKxRXNFgacIHdLzRXUJKnTF2LkSaJmsRg/DgC+wN9rOssRky
X-Gm-Gg: AZuq6aKmSyJZJNE1Y66HWv6HVeWDx2rEHxRvjBPqCDckBZZ0w/5yAnqUB3f1u9/zKWN
	96LeHl1ViRxNQuUh2lRxHBNtA3OxKJmNoT1Jq8tYF/0jfUC2X2m+Ud+DVTEW3I9qPSKNckPhT4l
	a+3IL6uL9kPmecsYbR/8ZyrIan13PcNS3In38aNFJ+NnOsvDTpQ4v8hn0+/OoXAYJyiHNujKOXc
	wGL0Me2q/mBIwKhj6MCSp+yUu1tvqwqgmKncqmBYzNFOs3uPsBm/BylPc51GYYV//p118GfKzqh
	GwRe8aY2xcErpA5A8F3r3rsSQzt3TMK+O4djMjEiG8jwhejCrZRGWsvKSjEL5xUK/0yihIriasf
	mdBBivEWeFHtrV2k8m4iHpvmU6zO9o6qMRMQCrMo9NAS+Xgn9w3k3xsN431/KliwIc2zVcN6tBz
	rEaDWhhe8cFkV3pPOvJ+5qojhEkmepO0o3tqsf0eQpI4yk0HBpb8AIZfZmIN9+kkr/hiCmNu5f
X-Received: by 2002:a05:6a00:810:b0:81f:c6d1:5608 with SMTP id d2e1a72fcca58-824d5c960efmr7231832b3a.1.1771258843594;
        Mon, 16 Feb 2026 08:20:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2c881sm11213782b3a.13.2026.02.16.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 08:20:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
Date: Mon, 16 Feb 2026 08:20:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
To: Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: A9B4B1460A6
X-Rspamd-Action: no action

On 2/16/26 07:34, Arnd Bergmann wrote:
> On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
>> On 2/16/26 04:15, Daniel Golle wrote:
>>
>> Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
>> on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
>> and with it MAXLINEAR_GPHY=y.
>>
>> Maybe it is time to implement dummy functions for hwmon API calls
>> to avoid all this.
> 
> I had considered this when I found the build failure, but
> I think removing the 'select' here is much better: this
> simplifies the dependencies, and allows a valid configuration
> with hwmon and gphy support in a loadable module that would
> otherwise be impossible.
> 

Makes sense. I think I'll move forward with the dummy functions anyway
because with that the #ifdefs in drivers are no longer necessary
and the "depends on HWMON || HWMON=n" becomes optional.

Guenter


