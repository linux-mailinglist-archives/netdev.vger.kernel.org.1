Return-Path: <netdev+bounces-27336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50077B83C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4D4281076
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED1BA5D;
	Mon, 14 Aug 2023 12:08:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C823D0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:08:50 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5C10DB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:08:48 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so1032531a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014927; x=1692619727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=C7TQ+dW1IO3geLfQdpUbHfkBQoWonyVjolDQjO/dF/pImNrRdVLbQIS4EJYAs/Ty3L
         l8eidEQheKO9ktoL9RB/inPUzwOmIwwOK5As3I0yxOkAGs7B3jlU5RJIrf0GnjG0Jc2p
         idEYPkZHKfAEjKnLhHQLSB9+QwSy3tDf2epX4Fi0dlAS5W6chrtXK4gcLwtxnvV6Sj4B
         dyM2dq9pXjfz9/xt5H8vz/TKNUscNirDIUvIz86B7JiXc0N5vhhDLQeFZ90vB64cfG4D
         j9UbuwqMwATZAenmO8M3JnHEBYspJbDuHB98LAXfjcGndUFRnimwNYTjVwSqyyQADqEy
         XK+Q==
X-Gm-Message-State: AOJu0YyFbSuzhT0mcbFeow7Ar7YhU5woYpKrVE2aTj2+4iBSNQdpHiJs
	XF5k4k3zZ05Rkl1qBYfnd6Q=
X-Google-Smtp-Source: AGHT+IHZIzveksLz/lxJd0IdgUso5wkRIHbYFFY/QMlld0F17v4urnbMFYI0DVL2Np7uct7uJi3uKw==
X-Received: by 2002:a17:906:5354:b0:99d:a228:d0c7 with SMTP id j20-20020a170906535400b0099da228d0c7mr3298970ejo.6.1692014927064;
        Mon, 14 Aug 2023 05:08:47 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm5602465ejb.84.2023.08.14.05.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:08:46 -0700 (PDT)
Message-ID: <0d5ccbb5-669d-ed84-7f6c-a27ec4e32782@grimberg.me>
Date: Mon, 14 Aug 2023 15:08:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/17] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

