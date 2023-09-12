Return-Path: <netdev+bounces-33198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA579D007
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3C6281C5F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1C514F90;
	Tue, 12 Sep 2023 11:32:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB0A13FEA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:32:59 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B537213D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:32:59 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31f8ddc349bso358476f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518377; x=1695123177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZXP38riNq/RMj6QmFF2WUhv+ow3GuTMETHb3JsZAHo=;
        b=f1w5hSL0utrQ2uBirLdr6nKQIuHhKUfeeqWDpJkHoH3lNXRmGLtGB7Zcj9bSmFhTPd
         MUQTq46ZhamPlbcsgHj2z8kIf+XGcdtycBCtOOzt/x9vmYrDGOaUeKlnRmrhwwkIc0Rq
         biU8BUQbLfkAAwmmTl+UA8GT0hRbxgXIPkYxkExkQ8arj8U2c3AwfTyhiXI7tdPcFel1
         nOAXy5gI7o/mZGT5JpRf9FegVpoHvYlkr+9lJeawhnicoXEbsJm9BuajmcUd7Ph2BbP4
         QIPUkbX77iLqDymTdPu79ME/9S2HOw6hbTGxWy/riBZBavFXx9NjgJ9xjpi6EWVg2Fyu
         HYnA==
X-Gm-Message-State: AOJu0Yz9OPvpPwUhSmVru4BZFWxsOJLWzhnjqI+0+YuhRWxC+HiwP9oQ
	R31POt9fQPlkPtj6sp40rqg=
X-Google-Smtp-Source: AGHT+IGQRqKdl4AyyF+OPdGe7Fm7NS5fIoeHX0DPiNMDXdoPudnl6N85noWCVOOMid/VESR08ZOgEg==
X-Received: by 2002:a5d:43d0:0:b0:316:ef5f:7d8f with SMTP id v16-20020a5d43d0000000b00316ef5f7d8fmr10716819wrr.3.1694518377177;
        Tue, 12 Sep 2023 04:32:57 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a05640207c700b0052889d090bfsm5755892edy.79.2023.09.12.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:32:56 -0700 (PDT)
Message-ID: <01b61651-5750-30b3-d980-3b97c3907a1a@grimberg.me>
Date: Tue, 12 Sep 2023 14:32:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 16/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230824143925.9098-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This looks sensible to me at this point.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

