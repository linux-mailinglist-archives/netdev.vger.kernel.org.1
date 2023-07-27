Return-Path: <netdev+bounces-21844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E7764FF5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526D01C21597
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D11079B;
	Thu, 27 Jul 2023 09:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E57FBEF
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:39:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FF1738
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690450743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dKBbXLRLWA65Igs72uq6lumYBq2ad5JA0b9vnY0xvE=;
	b=TuOwDVHuDmy8OBHo1LwPZgUKg6gqfvTuoWjEcXLNgvH9w20EhSU1C3BbJNk3sCQk/vcetg
	LDOqmKarM7+Q+3L9OGKBt880VPN0LcERym/i2N1h6D/xfR8DNHSKy/9vJ6NiVAZQo8yKF/
	r3vH8Cy2E7j60+tyJWQ/OL+RIQzcm34=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-aoFIT28pPtmqFJfbYZs-YA-1; Thu, 27 Jul 2023 05:39:01 -0400
X-MC-Unique: aoFIT28pPtmqFJfbYZs-YA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so4521135e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 02:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690450740; x=1691055540;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dKBbXLRLWA65Igs72uq6lumYBq2ad5JA0b9vnY0xvE=;
        b=aZS8QGgpkDWWqmh1ENzNVHtR2vEJZ4fdSE2h8Wx0AtUnK602gyUQfkxRQ3iO8RjGtW
         RaIXfkXT+xhzM4IWaXjATMIyQbHdGTtuNoFAJtomtNTngaTdc+o9Os4c8G1nLUktWhLm
         wAygJUeEGvnSKDncLOLH4vb31hddgtBxuotb/7E8/88Xkr0gICc/EkQOKOGsCtrlryu6
         /lh8fFGeOXMUbntor1ua+z8PfBnl2XURZC/KOKw3ph/Ea1Yw0bv1dtCJBcqY2bWAB4iZ
         /ZE9CbyCpM6HGfsGpMf0L5kvAdpAamOQGzRwprtRdx62QcEYu2sml4oCnr3tJ4Q6Jonk
         t6Uw==
X-Gm-Message-State: ABy/qLbvLiBnrL76XndnkQldrBh7VBHGSuWzSX7Fg7j/w3DYJBX9TgPc
	bzAqdQkdjj0PhMJ6M0gAhlmn7fdE8x0ZXceGSsrfyl6CsBzvKwTd770mLyv77Mr73XxGRgLvXXt
	aFjPAaHYxy3iEbiJhnIUu4IuwAJlS17JXNS08oQFoWCUPELnN4KqS5Ge+INBo/m5REzsMd6tuJr
	cnqA==
X-Received: by 2002:a7b:c40d:0:b0:3fb:dd9c:72c8 with SMTP id k13-20020a7bc40d000000b003fbdd9c72c8mr1263912wmi.22.1690450740103;
        Thu, 27 Jul 2023 02:39:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMvjyYVmiyExMw3OgPKu4lDRR+gpZRe8uzbh7uzYLNQN3kRbYYvW0aTeLyQA1CdzII3jeUkQ==
X-Received: by 2002:a7b:c40d:0:b0:3fb:dd9c:72c8 with SMTP id k13-20020a7bc40d000000b003fbdd9c72c8mr1263898wmi.22.1690450739683;
        Thu, 27 Jul 2023 02:38:59 -0700 (PDT)
Received: from [192.168.0.12] ([78.19.108.164])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b003f7f475c3bcsm15185975wms.1.2023.07.27.02.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:38:59 -0700 (PDT)
Message-ID: <2fc68437-e7fa-9dae-ac23-649f32b8b686@redhat.com>
Date: Thu, 27 Jul 2023 10:38:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [net-next,v1 0/2] tools/net/ynl: enable json configuration
Content-Language: en-US
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
References: <cover.1690447762.git.mtahhan@redhat.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <cover.1690447762.git.mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/07/2023 09:55, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Use a json configuration file to pass parameters to ynl to allow
> for operations on multiple specs in one go. Additionally, check
> this new configuration against a schema to validate it in the cli
> module before parsing it and passing info to the ynl module.

Apologies all. I didn't notice format patch inserting my email address 
at the start of the commits in the patch files
I will respin...

...


