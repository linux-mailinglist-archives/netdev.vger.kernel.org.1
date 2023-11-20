Return-Path: <netdev+bounces-49432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA577F2046
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E07B219A2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55813A27C;
	Mon, 20 Nov 2023 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLIu+gp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785997
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:27:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2851967b945so1312634a91.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700519235; x=1701124035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkZn7/9xaD9lhKqZRgCZHMJ+9AmhLhUWRjNKhPhEeuM=;
        b=GLIu+gp0XbiRYzrnbr0Sumfec1Tk14fJDhXNRzkvJRqSHhQbNCv8TaSdSbyauKg0EP
         Ni4TAMMfLsHtttNYup1585Ja/uIrDxUj2y3QQPBSxVAN+fu0IJpPc26qYkP8deTZFP15
         nzKdDHMESADfoB+aMhSNhU69xy8JIvtwYPN/d8CXgbIeQBFc8gfg+oJnuJ299Jvr8jep
         agxq63EWFvTF0ebJnsViuDCje9ZX/7rHwcjyh7oTpxncFRnHgaBqSULN8NmtHdtOQs3l
         frNHG4Vyzbqfnv1rxy/N9mTAyA9gpSsVzdUN0JQuKbFvIFPwauNL9oyMkdN4Umykq50D
         nxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700519235; x=1701124035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkZn7/9xaD9lhKqZRgCZHMJ+9AmhLhUWRjNKhPhEeuM=;
        b=mnLvxlH5L1LhG0UKX3ssADiDcWXjyFY2ONpN/yX5ldGiWFV0kiQoqc6OllCAgMDt4R
         49NiZie0nUR0d8qLrBQw7aXzbbAYtNWwVTI0BoSNcjCSnnKvGYEQLCoX25ESfvFCGj2l
         RLX40iBaRlV/LxHAXszft0kAnp75IDnpMgN4r976RshH8D/DhD/dfRFPsTwJ6ShllVAP
         TLPJtKVhH3rr01qF2pYLbdFa3hM9kTDukpjk9W5xQs0Gq2YMRi9Wi0ajjCnAm8/NWXX3
         u6J0OOLJtVw6cPo78U2Iqaybv3VwK19XD8XccGC6KxatAfrCXjd+T+1iUlKJ2qXCaYGH
         s7sg==
X-Gm-Message-State: AOJu0Yw32JDjn1tJr0yAQRswrjcGOGSE+9jz0EQFNSPoOiNGXN1NASiZ
	wVm8YMBgPW0MClVVXND1x88=
X-Google-Smtp-Source: AGHT+IEZ/p9Qto7X9TKw6I7t8BDWB2Z4qytGs7gzKYf2iBcAJ1qvOTOyIXmKUMDexY4/7qC7HDAmBg==
X-Received: by 2002:a17:90a:fa03:b0:283:a384:5732 with SMTP id cm3-20020a17090afa0300b00283a3845732mr1257112pjb.9.1700519234644;
        Mon, 20 Nov 2023 14:27:14 -0800 (PST)
Received: from [192.168.1.125] ([204.98.74.34])
        by smtp.googlemail.com with ESMTPSA id z10-20020a17090a1fca00b0028514c397d7sm4112360pjz.17.2023.11.20.14.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 14:27:14 -0800 (PST)
Message-ID: <6d053928-fe27-4e6d-9850-d8f7587507ec@gmail.com>
Date: Mon, 20 Nov 2023 14:27:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 3/3] lib: utils: Add
 parse_one_of_deprecated(), parse_on_off_deprecated()
Content-Language: en-US
To: Petr Machata <petrm@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
 <8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
 <20231115075921.198fad24@hermes.local> <87pm0bvswu.fsf@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <87pm0bvswu.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/23 8:57 AM, Petr Machata wrote:
> 
> Stephen Hemminger <stephen@networkplumber.org> writes:
> 
>> On Wed, 15 Nov 2023 16:31:59 +0100
>> Petr Machata <petrm@nvidia.com> wrote:
>>
>>> The functions parse_on_off() and parse_one_of() currently use matches() for
>>> string comparison under the hood. This has some odd consequences. In
>>> particular, "o" can be used as a shorthand for "off", which is not obvious,
>>> because "o" is the prefix of both. By sheer luck, the end result actually
>>> makes some sense: "on" means on, anything else means off (or errors out).
>>> Similar issues are in principle also possible for parse_one_of() uses,
>>> though currently this does not come up.
>>
>> This was probably a bug, I am open to breaking shorthand usage in this case.
> 
> There were uses of matches() for on/off parsing even before adding
> parse_on_off(). The bug was converting _everyone_ to matches().
> 
> I figured you'd be against just s/matches/strcmp, but if you think it's
> OK, I have no problem with that. Shorthanding on/off just makes no
> sense to me, not even by mistake.

+1

> 
> How about the parse_one_of() users? E.g. the disabled/check/strict for
> macsec validate, I could see someone mistyping it as "disable", so now
> it lives in some deployment script, or testing harness, or whatever.
> 
> Maybe do the warning thing in this case? And retire it a couple releases
> down the line in favor of just accepting strcmp?

I think the macsec example needs to stay as is; it could be moved to a
parse_one_of_legacy() in ipmacsec to avoid copy-and-paste. The rest seem
safe to convert to your proposal.

