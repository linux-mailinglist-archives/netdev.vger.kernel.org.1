Return-Path: <netdev+bounces-28177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B677E7DD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91EC281B8D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C0174E7;
	Wed, 16 Aug 2023 17:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FE168B9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 17:46:33 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC6610C7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:46:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31757edd9edso5660870f8f.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207989; x=1692812789;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VkdVz4VtI3T06aEb4XsKX/2yavIWZdQ8aLlJXl/Pl4=;
        b=iV6/txkdvFknvA+0iwlbrvYA+Tn847iBCNv2vosYZzxd+m+Q+HxL9oOzEUDINLu4gO
         dQegrZTNu0qeQ9COiNs3WvCdXgzSpmxLMyYogBrITYoP5X7HW1YaebpHqIlWrie1ojgU
         ignTz77JbnBiIJDJqVi7/rxFoVPojj1qAvzykwMzvx2gN9zZMnnWXz1zX74JApYiwhs6
         SCa0URW/e/So7jkjOh4Bf4KxD/6Zhe1qGCmPhyJePqoKInncjnNaHOpCm811VQZzzIiR
         oPfwg4ypQTS3T8XmsAVqutgqyvl01VOn/6yLcJfrEdkNos0ZtYc3C6Kp21C2+LgNjFJG
         9WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207989; x=1692812789;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VkdVz4VtI3T06aEb4XsKX/2yavIWZdQ8aLlJXl/Pl4=;
        b=itmkzTZa0SkznJdagPpa5F9amUFwlR0RMVMMwSRtE3bqrCg38epsXHLnEsHryCBG7j
         oqZc1ikSfifLcAWwlbSRV6o6koUy1HtunProfJ7ikrnWvCcRfAbTrxek7Q51yJb3oJ1c
         QHIpka6szokC1F+qSyvej/CUUZGotPZE5wXWAGUQgtZeT0lH1HHC2Nb8ueueKlWY0xlj
         lHs4QugHindJ4Gf3vobJy+cVPPC0/SlicBrtHBbUW63nhtpzdwWLaN8sZClvZsITsHyX
         ZHjuriPoxGsB9pLFOvu8TXvOeJxsBF6yo+66b8w3VJm0CfFP+yV7FMmRsq7RWcpkklsh
         D5Nw==
X-Gm-Message-State: AOJu0Yyb1AAR3Yg8yt1Cz9FCBFxdtBrC5gCTuL/cjcABp8fKc7/6PcS5
	w5qsQsjEmP1tHqzdWxqQgC4=
X-Google-Smtp-Source: AGHT+IHQtPp7LJ1Fgah8pqNMkaVCWGwmV+BpEVv/6bykirKOE7+s/+1bov8lmClZ2ae77KLakSBwjA==
X-Received: by 2002:a5d:4ac5:0:b0:319:7bec:4f31 with SMTP id y5-20020a5d4ac5000000b003197bec4f31mr1801268wrs.10.1692207989161;
        Wed, 16 Aug 2023 10:46:29 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003fbcf032c55sm88084wmc.7.2023.08.16.10.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:46:28 -0700 (PDT)
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in
 napi_gro_frags
To: Eric Dumazet <edumazet@google.com>, edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, Martin Habets <habetsm.xilinx@gmail.com>
References: <20230802092340.9640-1-edward.cree@amd.com>
 <CANn89iK6MPMUiAoRQKo+qyKp4ia6q9oweMi5VSawYQHwv4+-ng@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <7b756e5e-d2f9-a6a9-cda6-bc047a3936ba@gmail.com>
Date: Wed, 16 Aug 2023 18:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iK6MPMUiAoRQKo+qyKp4ia6q9oweMi5VSawYQHwv4+-ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/08/2023 11:22, Eric Dumazet wrote:
> On Wed, Aug 2, 2023 at 11:42 AM <edward.cree@amd.com> wrote:
>> An sfc customer has encountered this panic in the wild; we're still
>>  investigating exactly how it happened (we have a reproducer) but it
>>  seems wise to have the core handle this check rather than requiring
>>  it in every driver.
> 
> An ethernet driver feeding non-ethernet packets to the upper stacks
> seems weird to me,
...
> Not sure why a napi_gro_frags() enabled driver would be allowed to
> cook arbitrary packets with length <  ETH_HLEN
...
> Mixed feelings here
Fwiw we now have some more understanding of what caused this: the
 device produced an RX descriptor with a zero in its buffer length
 field (there was actually data in the buffer, but a — we think —
 firmware bug caused the length to be stored in the wrong place).
And the driver, blithely trusting the device, attached the RX page
 to the skb from napi_get_frags, passing the buffer length it had
 straight to skb_fill_page_desc without checking it.  (After all,
 the device had told us through RX event flags that the packet was
 TCP, so it had to have seen a complete set of headers.)
This certainly can be fixed in the driver, by adding a length
 check before calling napi_gro_frags(), but I see two reasons to
 put it in the core instead.
1) The same issue is likely to be present in any napi_gro_frags()
   driver; I've just looked at e1000 and mlx4 (as examples) and it
   looks like they could both be susceptible if hw misbehaved in a
   similar way.
2) The core can recycle the SKB, but drivers can't because
   napi_reuse_skb is static.  Instead, if they've already called
   napi_get_frags when they discover the problem, they have to do
	kfree_skb(skb);
	napi->skb = NULL;
   which is not pretty.  Of course we could always export
   napi_reuse_skb...
Another open question is whether, if we do put this in the core,
 we should do the same for the other RX entry points
 (napi_gro_receive, eth_type_trans) that could see something
 similar.

Anyway, I'll post v2, with unlikely() per Tyler's analysis, and you
 can ack or nack as the mood takes you.

-ed

