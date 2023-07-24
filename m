Return-Path: <netdev+bounces-20540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202A75FFEA
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC7A2813E2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E41101F5;
	Mon, 24 Jul 2023 19:44:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B5101CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 19:44:55 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1973170E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:44:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99b76201110so91582266b.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690227892; x=1690832692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh2sIOXiXBjnHrMA4Ac/X3uiwzQt0vlGqP8W0egXbw0=;
        b=OswQSUw2g0gHgbGv1PWmgaMtPTOLoe9eixfsZ4iizYFXo6Ia6laStnR89UYmsqhmWB
         EWYyNVZ/kmoiKIO366sSFSCFHa/beaiCGRq+A3RownNKzy5BYBuzJ6zAIPAtVOcCeoAi
         ReEg1F2PsBOU/L3p//EWq5r9Yd6e57KvLTGiCcoRrf9Coh/twVU3v5o4FVpSUWScDZai
         4vQAi0WEjUvkpeikhwJrPttpjB8lqJWC6nl70aNswiggYW/o+LPfSkO3jTbJCUYtpxT3
         1RtK8rUuRlkKnnAN5zYTeSqxwGnJDVXKr00ykQcbXIfrMdwFFUfT+7rKYo/5lU7E816X
         0wLQ==
X-Gm-Message-State: ABy/qLb1BDLbt4uLuijQxrL8e45oE7TgzEUGT+YyXQAvgQ9iGR9txvGb
	LwChW3gw8c575zSc6fsQKIs=
X-Google-Smtp-Source: APBJJlH7Tv4CBdcvg6bLHHef5fUwGk7QJ4PoctPnunUdUFOaRjx4uUiaNb6UN93ntB/ZkQ9GKFYr6A==
X-Received: by 2002:a17:906:518e:b0:974:5480:6270 with SMTP id y14-20020a170906518e00b0097454806270mr8691149ejk.0.1690227892110;
        Mon, 24 Jul 2023 12:44:52 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l24-20020a1709066b9800b009893f268b92sm7062624ejr.28.2023.07.24.12.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:44:51 -0700 (PDT)
Message-ID: <ad36e40b-65d9-b7ad-a72e-882fe7441e52@grimberg.me>
Date: Mon, 24 Jul 2023 22:44:49 +0300
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230721143523.56906-1-hare@suse.de>
 <20230721190026.25d2f0a5@kernel.org>
 <3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
 <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
 <20230724123546.70775e77@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230724123546.70775e77@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>>>
>>>> Sagi, I _think_ a stable branch with this should be doable,
>>>> would you like one, or no rush?
>>>
>>> I guess a stable branch would not be too bad; I've got another
>>> set of patches for the NVMe side, too.
>>> Sagi?
>>
>> I don't think there is a real need for this to go to stable, nothing
>> is using it. Perhaps the MSG_EOR patches can go to stable in case
>> there is some userspace code that wants to rely on it.
> 
> I'm probably using the wrong word. I mean a branch based on -rc3 that's
> not going to get rebased so the commits IDs match and we can both pull
> it in. Not stable as in Greg KH.

Are you aiming this for 6.5 ? We are unlikely to get the nvme bits in
this round. I also don't think there is a conflict so the nvme bits
can go in for 6.6 and later the nvme tree will pull the tls updates.

