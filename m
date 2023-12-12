Return-Path: <netdev+bounces-56154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7080DFDF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D046E1F210AC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96D625;
	Tue, 12 Dec 2023 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz1lYfhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B98AD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:13:51 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so4959455a91.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702340031; x=1702944831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScQZLhcNPTzdV1j1C4hAKQFBwcpgFYv9Fvct2PilQKA=;
        b=hz1lYfhfQPhHWibO4VKADqS5MnvhJBAOGwfEH4vr6+FYYF8jTiA32AMiyIL+3sLWsv
         r43Sdz6eLrXeTf7WgQuvjA44Er3e3IVSRp9JR4M+H4HM3SS+0KrYWwASA1LSYuBKsnCZ
         m0XSAZv52azoviuiPTUqUH3UtcJK9cn6cse6VMiD/kFLNd5KlVq7+124ia8KIT7UDn8y
         LGOLfxQD7RVLtlO5lNa62xecjDls9SicNt95Q8rA7Kz/tUY6DurGy3tg+Qrd5yPaZJ1X
         KVxLziMoPwBqbJnZNwKOMJVlKf498J7KgH413j0jxLK6eO1bWrzDtERCuGs1065Dv7cp
         x/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702340031; x=1702944831;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScQZLhcNPTzdV1j1C4hAKQFBwcpgFYv9Fvct2PilQKA=;
        b=HxasVCqBFl8bpjUG5Mt5Hf9p1zYq0BH4ayCHBGnAqXXoR3mCMizBfd6GhnCsTdOLgg
         klAooa77kYorR74dfHrGU32WE7Jbf35eJnDIV8v4+YHXNJilOcWYdStdwjpOHgMwgSeW
         dgtf4gHf537PXiAa7n2QRg8GsoB0YUa4orPLynpcsEAUeLqPID0udelKdhfTVzDtJZbn
         ighy194sKGXeGcmKNdtcgG6/JZwgiBwRYn/xlPwDnq4c1bkCdgzb8daRznF2mWsBcr6F
         YQsuhAk6HtOcDpGfGgvoZIWibfDR7jOQLi7EGKHJ9yuaZ6BgMDpRRBtZt8bDvicqjaiu
         Hbog==
X-Gm-Message-State: AOJu0YwfpXUUUsZ0zTCwJnq6WQRzABjDiLEPMJsok8gFYdGQeNsAhn0u
	S6mIyjNXeaSSkNf5SBvWYxQ=
X-Google-Smtp-Source: AGHT+IHzrT8T21hiUAMqxZOPG2c1TfHWIGcZVGsu2Rz6Ho/2dw9d5PeVoKorCt+0OMAgMt7Fs5DLDg==
X-Received: by 2002:a17:90a:744a:b0:286:9b7a:93c8 with SMTP id o10-20020a17090a744a00b002869b7a93c8mr3718488pjk.53.1702340030585;
        Mon, 11 Dec 2023 16:13:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gg9-20020a17090b0a0900b0028679f2ee38sm94537pjb.0.2023.12.11.16.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 16:13:49 -0800 (PST)
Message-ID: <a82b3ba5-6c1b-44de-ba27-4b5f49c67bc3@gmail.com>
Date: Mon, 11 Dec 2023 16:13:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
 <aeac0d23-26e3-4415-9a77-f649d3d48536@gmail.com>
 <87plzc8g9f.fsf@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87plzc8g9f.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 15:35, Tobias Waldekranz wrote:
> On mon, dec 11, 2023 at 15:03, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 12/11/23 14:33, Tobias Waldekranz wrote:
>>> Chips in this family only has one set of histogram counters, which can
>>> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
>>> up until this point, kept the hardware default of counting both
>>> directions.
>>
>> s/has/have/
>>
>>>
>>> In the mean time, standard counter group support has been added to
>>> ethtool. Via that interface, drivers may report ingress-only and
>>> egress-only histograms separately - but not combined.
>>>
>>> In order for mv88e6xxx to maximalize amount of diagnostic information
>>> that can be exported via standard interfaces, we opt to limit the
>>> histogram counters to ingress traffic only. Which will allow us to
>>> export them via the standard "rmon" group in an upcoming commit.
>>
>> s/maximalize/maximize/
>>
>>>
>>> The reason for choosing ingress-only over egress-only, is to be
>>> compatible with RFC2819 (RMON MIB).
>>>
>>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>>
>> Out of curiosity: does this commit and the next one need to be swapped
>> in order to surprises if someone happened to be bisecting across this
>> patch series?
> 
> I'm not sure I follow. This commit only changes the behavior of the
> existing counters (ethtool -S). If it was swapped with the next one,
> then there would be one commit in the history in which the "rmon"
> histogram counters would report the wrong values (the bug pointed out by
> Vladimir on v2)

Right, somehow I thought there was provision for reporting the TX 
histograms through the rmon interface which your subsequent patch would 
do, but it does not appear so, never mind then.

> 
>> Unless there is something else that needs to be addressed, please
>> address the two typos above, regardless:
> 
> s/Unless/If/?

Yes, the latter!
-- 
Florian


