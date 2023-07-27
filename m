Return-Path: <netdev+bounces-21997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0047659C7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0085D1C21617
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E427145;
	Thu, 27 Jul 2023 17:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57F27124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:15:30 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17135AB;
	Thu, 27 Jul 2023 10:15:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so12869795e9.1;
        Thu, 27 Jul 2023 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690478121; x=1691082921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ul81gbrbgkGKJ2+qFPiiqGnP9CzSuQLVLhrE7rAfXM=;
        b=bE/jTuPbGDIJ5QQpYTdUKCr/g5ows59oesotT1Ng35PuTPYcSlO9SXTPRv+lRrG8tw
         yHRIHc5Jw4StnWp49Bb1bhfF/mRr6mVTrMGO9qTQniFh+6ObS/W+nIrq5V6hMZKbiccY
         pMiRLuZxmqnKHOl8y3FkafozWCqAsOutHw+DEiY7DIXnsteRXp9S7UzUlMjL/3avM/sA
         i5Bx4NFTKe7xcS6u/PMkUQljRE0mtiW+N6cQDfDAROzFxNuQKhnnGJfuFY6NjgyZI0J9
         pTiyCEinRo2UJvX/QveUqi0/KEE75uE0UJn2eUVSw5UIcO4Mdy+HHj9Zv5W+StL5m2ob
         /DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478121; x=1691082921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ul81gbrbgkGKJ2+qFPiiqGnP9CzSuQLVLhrE7rAfXM=;
        b=htcOD9lisGoQ08n388lZYeWdgIES54SRehblJZIp2VgloN75Nw1ccHGjIlBiV5eZ5Q
         4yv3b9T6dJnuCRoZGHb6X+HBk3d+Z+7DjP2ulR/1MpgCuSMTuW/IlWn70qYzT6cZLxQa
         MG+6HxcdHOsRxmw/155fyZoaJDGJrHS5ATacIAyvrSkuQujOy7iJkykT31PgjNHe8peM
         LygAaD/tn1hT2o0rhXWOmOrFtGpVzeYIB7/VtjwjZX4WwoOllcY/f7PCn6CUmgOxzLbq
         z6pighe/w9QWx38J9JC7z+PPM9v/+RAXANcfza6dWzIatZRNhx9l/JBnX0f9aa32+x93
         zNcw==
X-Gm-Message-State: ABy/qLZ0OofOngdFSu0r7yefwvRVokvQobRqJpUyuqaQoXbuhwZh6ojX
	HEKbP+987pK1N2unbvLg5Jg=
X-Google-Smtp-Source: APBJJlFfalNKGeBlyDEyCqk1kwpmohtze5EH9xcacpd1iXxviatja8R6TvIKwmchLUCoLZU6GSqTLg==
X-Received: by 2002:a05:600c:241:b0:3f8:f6fe:26bf with SMTP id 1-20020a05600c024100b003f8f6fe26bfmr2061603wmj.12.1690478121131;
        Thu, 27 Jul 2023 10:15:21 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id z15-20020a05600c114f00b003fbb5506e54sm2279020wmz.29.2023.07.27.10.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:15:20 -0700 (PDT)
Message-ID: <64213517-099b-e5a7-6cf3-2f78fa59ee99@gmail.com>
Date: Thu, 27 Jul 2023 18:15:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next] net: ethernet: slicoss: remove redundant increment
 of pointer data
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230726164522.369206-1-colin.i.king@gmail.com>
 <662ebbd2-b780-167d-ce57-cde1af636399@web.de>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <662ebbd2-b780-167d-ce57-cde1af636399@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/2023 21:05, Markus Elfring wrote:
>> The pointer data is being incremented but this change to the pointer
>> is not used afterwards. The increment is redundant and can be removed.
> 
> Are imperative change descriptions still preferred?

Hrm, I've used this style of commit message for a few thousand commits, 
I hope it's still fine.

> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94
> 
> Regards,
> Markus


