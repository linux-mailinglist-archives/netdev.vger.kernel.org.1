Return-Path: <netdev+bounces-27335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA0277B835
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181311C20A83
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F4BA58;
	Mon, 14 Aug 2023 12:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE88AD47
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:07:51 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710CF5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:07:49 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so1343212a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 05:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014868; x=1692619668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Wlv8x8Q8sv4ngSnC87D1x+1mNUASRQRQc4c9jin5BAE9Ekl5pggofoXU5/yXgK3B9w
         lsPRg/cQVm9bEIFJZ1iOwx5eD02YE+cRpMeugivRPEIQxDJANVPb0yVZSKv7bodXwgLe
         z8KkwDLdXxttTwGsD9dq7l26xLEY+nvAQD4gESe9fZ3ksfxJkRLwjnzAvknWfu6gKuy1
         7qyE8YU0/W6CfF+v00AjkvMivCOgDaiTjxdmrNQlzjnf75wYaHa7NODpo8d84VpDL+aF
         Ko8H9rFdwv4W4I0GyD8SjDViUtI1dpYqEjyLmNVVMVp4+GiiTLWnQsr2SX4koQQ8aRXl
         YNww==
X-Gm-Message-State: AOJu0YwyyEUtflr9+mDO5vLF/gVItXsgK3ITtUA2x6F0Z/FJ5xRRK+0r
	wXWqaRwc3idt/g0GoQLUcRM=
X-Google-Smtp-Source: AGHT+IGcelZsJE4I1ve4SYii4MRlYCXgkAdzgvdIliZCGpeDWyVhjZJpryR1khJ+Rs/PQxpkjDkPVQ==
X-Received: by 2002:a17:906:116:b0:99b:d594:8f89 with SMTP id 22-20020a170906011600b0099bd5948f89mr6886195eje.0.1692014867980;
        Mon, 14 Aug 2023 05:07:47 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b00988f168811bsm5635390ejb.135.2023.08.14.05.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:07:46 -0700 (PDT)
Message-ID: <4eca46c0-7fca-f4b6-78d2-21b523e748ed@grimberg.me>
Date: Mon, 14 Aug 2023 15:07:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

