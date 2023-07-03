Return-Path: <netdev+bounces-15090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E37459AF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3469A280C57
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E84430;
	Mon,  3 Jul 2023 10:08:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B93D9E
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:08:59 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8AE60
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 03:08:54 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f8680d8bf2so1032855e87.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 03:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378932; x=1690970932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIR8G9dzW/AHDz3A+/3A/KLqgX8fR2nJsyJYwvgO7jI=;
        b=ehqrc/SZSKYwNGwbWTQJqEc5zY5HfJPsuzk2Wew/cFmFOZeV6OwEfKoebmxZZt4TBN
         7e2cXSMfrK6e0dFgtlFRVbq1wbPNNDYBuD0O2jOr8aK6k0e0Ozu433iJyAz1roBvb6FX
         ZsT9itxv13WHE4BzJ9WIftwW9hlS380ub4HAbnKPuBWcO0GzIR5QWNlTtJTtMNIxVMtW
         2NAgjXczn4iH4uodLwF0HBt9B2Du9H5iHTqq4bUPk6HDq10N4buoib5ZnQfejeyKjHWM
         LamilwMkpzjKXKkdjJW1A2hJ3n+T8q6npU/+PS2o1yzyddw6Hwi2DX2ULmciCHxKFsJr
         gPPw==
X-Gm-Message-State: ABy/qLaC4pZfneGbUZOOK/HG2qt8UjXC92ms2BqhSjL4LkgqC3Z9dE8R
	SojvgL8Eq2uC/WNoVSgBjk0=
X-Google-Smtp-Source: APBJJlHK1xgbTuhYhj3/thCZfGiGdkoW0Qx43BOTsuwy7eDxRkdpEkSLp2kCh/wynItpDfIM9b96bg==
X-Received: by 2002:a19:7601:0:b0:4fb:9477:f713 with SMTP id c1-20020a197601000000b004fb9477f713mr3833933lff.6.1688378932063;
        Mon, 03 Jul 2023 03:08:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c024500b003fbb00599e4sm14651466wmj.2.2023.07.03.03.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:08:51 -0700 (PDT)
Message-ID: <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
Date: Mon, 3 Jul 2023 13:08:50 +0300
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
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230703090444.38734-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/3/23 12:04, Hannes Reinecke wrote:
> Hi all,
> 
> here are some small fixes to get NVMe-over-TLS up and running.
> The first three are just minor modifications to have MSG_EOR handled
> for TLS (and adding a test for it), but the last two implement the
> ->read_sock() callback for tls_sw and that, I guess, could do with
> some reviews.
> It does work with my NVMe-TLS test harness, but what do I know :-)

Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
david?

