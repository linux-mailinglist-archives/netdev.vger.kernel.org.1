Return-Path: <netdev+bounces-15120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB199745C48
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751CB280DF2
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96AC2115;
	Mon,  3 Jul 2023 12:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89D1FA6
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:33:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27120194
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:33:08 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso12056555e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 05:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688387586; x=1690979586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0PUdrTV9JSlB4itt4V7/IvaI6ZLS2ukRynlxQ8p298=;
        b=Pr4FFXzJqPGkre2YDvS+tnoOwtVvBRilQDD3fBdmkgmXphz+XQf8RTNbyikO2jHxzs
         yGrc5t89IKLnglALtzuPpXQQfoR+Y5VI3FxduFEPs3/uwDeirUwOUX27IbD39isXaNVn
         KQVkcsaeHs9Mon1gMFDvlMqZnn6PaomzxM6A+VjX6Evg13IHLijuFASr5LwSV+7RA0SA
         QyNpnsb0kv5o8T66y2SxtK67h5KIfmvQtcXqUEEQ6iYoZgFz4UQyleNVExSRF7Neu6qz
         v2d1fhSdA4MLm6tchnBCk1WZznbsuFci/Yq0piV8d+Kst+azAY0U9SOtJWBYt9qvNyYn
         LQWA==
X-Gm-Message-State: ABy/qLZqj7c1dVf14sxwl1LO3CeUDx8txacD4PnO1BUJzaekACaRXG97
	XF+wdTaLuAVsvjFJD3a4V9+FjqbjP3U=
X-Google-Smtp-Source: APBJJlEY5kLZN8dU3O1mOnZemT4WcPab4YtHfjkBNhV0Ml3v2n0l++DGvcTaCwSRgnI0nbqPrjlZvw==
X-Received: by 2002:a05:600c:4f49:b0:3fb:dde9:1de8 with SMTP id m9-20020a05600c4f4900b003fbdde91de8mr125665wmq.2.1688387586411;
        Mon, 03 Jul 2023 05:33:06 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fbc2c0addbsm10150089wmg.42.2023.07.03.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:33:06 -0700 (PDT)
Message-ID: <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
Date: Mon, 3 Jul 2023 15:33:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <873545.1688387166@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Hannes Reinecke <hare@suse.de> wrote:
> 
>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>> sock_sendmsg() as it's trying to access invalid pages :-(
> 
> Can you be more specific about the crash?

Hannes,

See:
[PATCH net] nvme-tcp: Fix comma-related oops

