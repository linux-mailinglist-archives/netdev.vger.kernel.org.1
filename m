Return-Path: <netdev+bounces-28387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42677F46A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C63281EAF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAA125C8;
	Thu, 17 Aug 2023 10:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C261C38
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:44:49 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627012D54
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:44:48 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9cb0bb04bso20585781fa.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269086; x=1692873886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bHuM2bItvGnKg6IwfgyyY29CAqAV5Ov35ZNmahj8mnp90El6K6wC2cnAVl7edCXNiV
         /0bcdJfLB0HBjuo93I5Z3VaDHn2Kb7o/dt1fqOtQmCZCJEK6Oy8nqSUyikDULjrrESF1
         jCAZkOS/wYgWjfCcNJrewtiCORNfHoAVx0SIZoJjHnSHm536+Y3t+y1ldKFjBYS9PS3B
         31NlpxGjVtfr99kQS7dIBT4Z7DiY1Qr7W4g3JMtI32PPci7RPtl7h70KabNw4P1caMtA
         +vzqM8rcTbBZdFc92rNtFmvvymbHwgGFyGNHd9jzkBX30LSYrzRbfZky/40gxVbSNMnf
         ayLw==
X-Gm-Message-State: AOJu0YwtaQDo9vjorxOewohRnZk70QIdkO4dPZgpc8ZvBHUEkIUi5ldf
	7PACbntUmJbXquSSIjlK0BM=
X-Google-Smtp-Source: AGHT+IHQhPAimqm2S3tsqWSnyRt48WBkAnyb8t7usGqYa91blIE3h5md4AHUCXHn5TR/x3fgKh6RaQ==
X-Received: by 2002:a2e:bc88:0:b0:2b6:9969:d0ab with SMTP id h8-20020a2ebc88000000b002b69969d0abmr3404304ljf.4.1692269086359;
        Thu, 17 Aug 2023 03:44:46 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b0099315454e76sm9956545ejp.211.2023.08.17.03.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:44:45 -0700 (PDT)
Message-ID: <15ef9677-0bec-84d0-07e5-770c8a1f1e47@grimberg.me>
Date: Thu, 17 Aug 2023 13:44:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/18] nvme-tcp: improve icreq/icresp logging
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230816120608.37135-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

