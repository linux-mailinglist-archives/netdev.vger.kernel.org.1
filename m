Return-Path: <netdev+bounces-46266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5907E2F1B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036EEB20A2A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188962E65F;
	Mon,  6 Nov 2023 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MXQj+08N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C72E65C
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 21:48:22 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEA134
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 13:48:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839807e82so30687655e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699307299; x=1699912099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az7ExxO94n7Tzege6R79RlIuC0dJHugUw3dOV0fKG+I=;
        b=MXQj+08NoMF0P0C5A49vtHDtDrdkx6m+IkUM84MQnBdcIrIf49OHvxw9XOL2p+exTQ
         48bbLGruV3UR61+fH4zwv3rUeMtFU41Q69rs3ztwq8Q66vlGG3qAcTJQ9Bz5NQZQYLH0
         Cxfm8NKc/4NEgChzjRdG7KzsIbsclhKnE20Smvp9q2pKj3Tq/cTwRUcnT3CYunDPM8uw
         p/msOAfYl40OLdZozyZ9onDd336M+wAZ7bHzBDhZ/P8Aclc1tiEG3vVYx0Yv10NjRHmq
         KtXoZ0oQ1sZ3qnfplOYq3hO0hM5ulC7SUVjIsuhvu0Jl61nd1cw2F1XuhWXvt2n+71GN
         m5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307299; x=1699912099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az7ExxO94n7Tzege6R79RlIuC0dJHugUw3dOV0fKG+I=;
        b=bRr3I+yvv5/1YU6LPdnmXdHMNJIA6qbsAlIbU0/qrXWyuhKj7qESIu9YdZjPNMDeoM
         wqmIG9Jo1KHs9hmB6RbtE1gEF7etPxxRFNH1VDtRT0tC0GlBmhp7o9ENNBYj0pqpeYzd
         Cqmy64ZaAW0maZMDNxvJNmgSICS624t4HQAueQhpFvGxG/VLTJ/U7mfI7uzhMWghp4G1
         I/er5cwNClQ6HlHhGAP/M6JPXZXhBBmLoi5pacJdONT2BYAlRLSZ/+ntq/AIKi8UlG3x
         tHfdW6zSf0X96sozoJn5so54Zk2gohbPD4aCgbmL+uNPrZvSH+3r6c7YwD5MT7jth/Gm
         sodg==
X-Gm-Message-State: AOJu0YyxtRNd8HWIPsWr+X+LKTswsJb9wa18RF3eUdvGuIi6P/LEg2gr
	I71bAeDsIxQIPgzPZd88R1R84A==
X-Google-Smtp-Source: AGHT+IEF4p80QoTLDD4KV3JQ2AnS0F8rRoHPd1/kCN+tYAzVUsjYELpEmJ4GHmO0V+YDLmjBPSTWBw==
X-Received: by 2002:a05:600c:2483:b0:407:73fc:6818 with SMTP id 3-20020a05600c248300b0040773fc6818mr1095597wms.2.1699307299346;
        Mon, 06 Nov 2023 13:48:19 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b003140f47224csm617514wro.15.2023.11.06.13.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:48:18 -0800 (PST)
Message-ID: <7be96bfd-7e79-4b13-87fa-0e3d06ead30b@arista.com>
Date: Mon, 6 Nov 2023 21:48:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: ndesaulniers@google.com, trix@redhat.com, noureddine@arista.com,
 hch@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
 <a8cc305d-0ab8-4ff7-b11a-94f51f33ec92@arista.com>
 <20231106213408.GA1841794@dev-arch.thelio-3990X>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231106213408.GA1841794@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/23 21:34, Nathan Chancellor wrote:
> On Mon, Nov 06, 2023 at 09:26:48PM +0000, Dmitry Safonov wrote:
>> Seems like exactly the fix that my git testing tree had, with an
>> exception to naming the helper tcp_ao_options_write().
> 
> Heh, not sure why I never considered that as an option... I am guessing
> it does not matter enough for a v4 at this point but I could send a
> net-next change later to update it if you so desire!

It doesn't matter really, not worth another patch :-)

>> But then I found* your patch-v1 and decided not to send an alternative
>> patch.
>>
>> Thanks for fixing this,
> 
> Thanks for taking a look!
> 
>> Reviewed-by: Dmitry Safonov <dima@arista.com>
>>
>> *had to fix my Gmail lkml filter to label not only emails with cc/to my
>> name, but also the raw email address (usually, I got them to/cc "Dmitry
>> Safonov", but this one didn't have the name and got lost in the lkml pile).
> 
> Sorry about that, b4 used to have some interesting behavior around names
> at one point (don't remember the details at the moment) and just using
> emails avoided those issues. Maybe I should go back to names and emails
> to see if I notice any problems again.

No worries, should be fixed now. I preferred previously filtering by
full name, rather than email address as I send patches from both work
and home emails, but also sometimes people send patches/questions to
emails from the companies I previously worked for, regardless .mailmap
entries.

Probably, they look for author in lkml/mail archive, rather than use git
to get the current/proper email address.

Thanks,
             Dmitry


