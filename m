Return-Path: <netdev+bounces-24475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20335770424
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C53F1C20CBC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F081134B3;
	Fri,  4 Aug 2023 15:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E0BE6D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:12:33 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665294C2D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:12:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77acb04309dso81744139f.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691161942; x=1691766742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BOM74jU/KbF167AwOA+fEbbdk7lDc2mmscknjQbeKM=;
        b=E0DIoCW9JJsZMuzUHZ3XcqnhtBmJ1TXfmUCNyNiPEkbS6OHAwqb/aFfomvWcSfccO1
         KVyrz3/MqK8ZnJ8suontEuS85RgdhtUi5Q/4AdR+ZJi1RPLIcoAr3lkPoJLW3Eqn2cOR
         UIXJczc30qQBmKg6tzJHN74KqfsTyEub9P25/glGQaMUphNOsLrdacEEaKs54wCkJwlY
         GLqG/MmRZzIufv8TAcjMJ02+OzU2uCz1lyDeK923PohqwXpR77sT2fDEhvtlATJz6K87
         u1aL3hf18OytkXj4DvD0ak4oEuUz9OrYb5ncvFa2wWCZkyqO+Wuxmq2zh+iiaWm3ICMd
         t7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161942; x=1691766742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BOM74jU/KbF167AwOA+fEbbdk7lDc2mmscknjQbeKM=;
        b=OrhrhwxO+5qi9kjVO6OLea8BfeZKtp51yOLK5K9mEAEbhfu3+vhsHQymUc5idLuhdg
         eUWVvcWPMyEH5oihWgqegAE6IenQbbQVJZbHW/WXyueJgfnV5bQs3sr4TWNkHNNjpC20
         BiOdiNV481rGkhsUJKG65szCXX1RQn29xXj1uUFb3mlDDIzvi1wzGkedQFw1GipzNFQX
         MEWfIN/fmQcEJDKvYSbsczkxd5qFQkV8tdpCqM+kFDvyBlMNaWSH91YrjdLBW5E7jv6R
         h4oXerVRy0ayE2ol2ZttWYZC98QnHm9eVBMSY+4AdmyMs+RAZoBXU6lQLt7UP/EabUcM
         SUmw==
X-Gm-Message-State: AOJu0YxIbBE0j1IpUe20jdP/AlNb3roVZ1kkUg+G+PeAMZA2ZX4gIU0Y
	KciZzSt4zHBMznxzbcnj80Gis0BUJ996XQ==
X-Google-Smtp-Source: AGHT+IHL7nrNqp9o2+6yGCi1ESQszF03wWqdmh2xmoU0QvJdcX/CSGAV9/1iowh6ymNt0hTNOtpBxQ==
X-Received: by 2002:a5e:d904:0:b0:77e:249e:d84 with SMTP id n4-20020a5ed904000000b0077e249e0d84mr2727039iop.5.1691161942650;
        Fri, 04 Aug 2023 08:12:22 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:c9bc:cf8:7eab:d7f? ([2601:282:800:7ed0:c9bc:cf8:7eab:d7f])
        by smtp.googlemail.com with ESMTPSA id y18-20020a6bd812000000b0078702f4894asm700515iob.9.2023.08.04.08.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 08:12:22 -0700 (PDT)
Message-ID: <cef683df-ad3f-7c91-7b06-8a528fad1cb3@gmail.com>
Date: Fri, 4 Aug 2023 09:12:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 iproute2-next] tc: Classifier support for SPI field
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org
References: <20230802154941.3743680-1-rkannoth@marvell.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230802154941.3743680-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 9:49 AM, Ratheesh Kannoth wrote:
> tc flower support for SPI field in ESP and AH packets.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLog
> 
> v0 -> v1 : Rebased the patch
> ---
>  tc/f_flower.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 

applied; please followup with an update to man/man8/tc-flower.8 for the
new options.

