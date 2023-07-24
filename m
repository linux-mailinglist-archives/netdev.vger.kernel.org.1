Return-Path: <netdev+bounces-20261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAF375EC62
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA021C209BC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA717FE;
	Mon, 24 Jul 2023 07:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125F1848
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 07:21:59 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8090
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 00:21:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b83c673ab5so10946631fa.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 00:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183316; x=1690788116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csHOlK60oFtyoKK55DCid0LNEQDIrrzyZU/pUX0ng1M=;
        b=V0lzUd1T2WcWCoGcnnLL8OG6e4xwnFiSVT3aJZ34xCD0c8yTSpWPcFMBkbvQpH9JXk
         7+sExRyWzVSna53soT3HVy/9FgWdDLHWSl0wxxdYCXE8X3EHrajF21LyGwbQ8jhgBxkq
         LPUQBfCp3HZZYYZLS/p3rfOl0ef0fBs9aQ927Y5jEfDjgf396qruvAcVOJPnxNq92aL1
         rYhZjtA2Ltd65VoC7HArJbe3wY9HtyI2w3qrWuOJD/Nfg+E61jq5IUSh7R/Zk2LDalzq
         HEU6rV4a34yUsj5uvh4V3rdWxhYX5pVe1tpiEv2SxDckIXjYa5LPl952HvPwzPo4rKM3
         N3ew==
X-Gm-Message-State: ABy/qLad0yNudHqvdeuCPYe9IrRNiQMl21yUqgbXuV6a6+8ULgo0ChIp
	Pj34s+AUZqKosxkGHA9xcr0=
X-Google-Smtp-Source: APBJJlGL3OVo/tghx+lWn9HITaXRKTzvnR6vR/lieEMtbY0b49/X5EaR0GjTv5+BSbsIXBNaE13nMg==
X-Received: by 2002:a2e:a98b:0:b0:2b6:99a7:2fb4 with SMTP id x11-20020a2ea98b000000b002b699a72fb4mr4787194ljq.0.1690183315690;
        Mon, 24 Jul 2023 00:21:55 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b003fc3b03e41esm12385411wmg.1.2023.07.24.00.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:21:54 -0700 (PDT)
Message-ID: <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
Date: Mon, 24 Jul 2023 10:21:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
 <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> here are some small fixes to get NVMe-over-TLS up and running.
>>> The first set are just minor modifications to have MSG_EOR handled
>>> for TLS, but the second set implements the ->read_sock() callback for 
>>> tls_sw
>>> which I guess could do with some reviews.
>>
>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>
>> Sagi, I _think_ a stable branch with this should be doable,
>> would you like one, or no rush?
> 
> I guess a stable branch would not be too bad; I've got another
> set of patches for the NVMe side, too.
> Sagi?

I don't think there is a real need for this to go to stable, nothing
is using it. Perhaps the MSG_EOR patches can go to stable in case
there is some userspace code that wants to rely on it.

