Return-Path: <netdev+bounces-106799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6927917AD0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA7F1F22254
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0115FA60;
	Wed, 26 Jun 2024 08:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2413AD33
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390188; cv=none; b=heNjcWx766TFs/Vcw90oR+Z7acZZ2S4wNvva2J63CqTbYKaj4OrlvMsxtVsjL4MirutnaJNjnEJgCYkIdco2PndmP8cWefeWFWtpM2Vnhy8IPfKbaq8DwPK48DWEwxwllo46BVpZAE9Q0ffVIJWaoXwG0WmUyN7fy72QQ0NNvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390188; c=relaxed/simple;
	bh=BZpIv5NFPSbo1fjboWWveVCi7XFZLrk/y8dZsUW/DAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axOc3EiVzy0EFztgZCNtRxJOSaFO2FYhU5e+MIIE7br9bv61gXp0Ta+rjzvCnGG5jZ0CN5lu1YMVJIYelfmgI04NYwUS3pXwerjfodfXKmPw40RLqDOZVbaTkkpsKIumgziknNoHsiQRQXR48qrPDHguxL8J39+/UBRz7oS5Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4212b102935so5721115e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390185; x=1719994985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp8SFUyPb6tjaTKpsSX01iKUiJtDkZPkpZXAjqu5MM0=;
        b=mrXrZq1/faFa+RIyTFIElPmoiriYWOk3Fl7SKi20yk/5KVwIQF6Lzg/I+FrbhtFKGg
         cHn4zQD/FaxFDvC4CU0oDa6XOmRAHkBtKFmKsYFPDHIJw5DviYCtLpJMjZnmdVSUX4Th
         vFSCK4Lqt4XQ9dMcw+5ZXa8/QbAFq4M8YedKNkygJwTXW1ibC+0V8eIT8Hlfgrugof3h
         krb0956Mks5hy3uu620wcRIW448mHP6BWdqsJIYBH5E4+x5unh5yBGhg50U1sxpj0vNf
         ZG/NWvXZGJ01NaREk7Zw7xrUlKfbgwu6cDvRbKzWs5kvJjEpeyVBycPRpjIf9APSi1oT
         u98g==
X-Gm-Message-State: AOJu0YypwrLAbDlxtfc2Vo2MkR3t2FIG17RIa5JTLKJjSKWtajuGccKa
	IYmlcY3OL/u/QEMCNoT0fjj6mtQtYo80azCKv+vdwQ+b/+pwXjZ1
X-Google-Smtp-Source: AGHT+IEuk7BPEFNNpCosRFPK2RMsKYffTG7GI8Vk2Phbd9jn0wE/fanVE9VdlDtVKg1ILlpqVjFJRg==
X-Received: by 2002:a05:600c:1c99:b0:424:8acb:7d55 with SMTP id 5b1f17b1804b1-4248acb81e8mr78932695e9.2.1719390184549;
        Wed, 26 Jun 2024 01:23:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8280a87sm16341605e9.24.2024.06.26.01.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:23:04 -0700 (PDT)
Message-ID: <a1b5edbd-29a4-493d-9aed-4bddfbf95c66@grimberg.me>
Date: Wed, 26 Jun 2024 11:23:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: allow skb_datagram_iter to be called from any
 context
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
References: <20240626070037.758538-1-sagi@grimberg.me>
 <CANn89iLA-0Vo=9b4SSJP=9BhnLOTKz2khdq6TG+tJpey8DpKCg@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CANn89iLA-0Vo=9b4SSJP=9BhnLOTKz2khdq6TG+tJpey8DpKCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/06/2024 10:40, Eric Dumazet wrote:
> On Wed, Jun 26, 2024 at 9:00 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>> We only use the mapping in a single context, so kmap_local is sufficient
>> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
>> contain highmem compound pages and we need to map page by page.
>>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Thanks for working on this !
>
> A patch targeting net tree would need a Fixes: tag, so that stable
> teams do not have
> to do archeological digging to find which trees need this fix.

The BUG complaint was exposed by the reverted patch in net-next.

TBH, its hard to tell when this actually was introduced, could skb_frags 
always
have contained high-order pages? or was this introduced with the 
introduction
of skb_copy_datagram_iter? or did it originate in the base implementation it
was copied from skb_copy_datagram_const_iovec?

Its hard for me to tell, and I don't have enough knowledge of the stack.
could use some help here.

>
> If the bug is too old, then maybe this patch should use kmap() instead
> of  kmap_local_page() ?

I honestly don't know.

>
> Then in net-next, (after this fix is merged), perform the conversion
> to kmap_local_page()
>
> Fact that the bug never showed up is a bit strange, are 32bit systems
> still used today ? (apart from bots)...

Not sure.

>
> Do we have a reproducer to test this?

Aside from the robot not that I know of...

