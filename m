Return-Path: <netdev+bounces-23885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DA76DF8F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 07:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F101C21439
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 05:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803163D8E;
	Thu,  3 Aug 2023 05:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADC23D3
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 05:08:12 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DB09B;
	Wed,  2 Aug 2023 22:08:10 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31792ac0fefso437636f8f.2;
        Wed, 02 Aug 2023 22:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039289; x=1691644089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SX9ntrLJV/kdBv0dEu2PYDIqC3ArssiACUgrlWgmu38=;
        b=j/51yOVEpLFyCPEgIGuismIyO76hfkTWDJm4WuJ8GE+CyxasgBHNwC/ijEdm67ARVY
         RaBPzaDsU0a0ltZlZ+zp1gLClmzQlc9THVDg7QPHnSvyZN3BG9QpcuK8/sieCblzVJjz
         lZ3YVbp0D4feCktxrUjljplhdfiJXPZ61PsgcFa6UZNITbEbsSKInU4ala7IgqH3Da3f
         g92ibT3neEq1dOi8aofT1t+ixG4jnxSaGGjiH/90NfWGd/S376GhxeCafqsAIypNWimr
         8foQ9UWtrt/OaodA4/Fp6RKwDNgt3wvzVldOXzkd/rsees2J0RagL++pnGjCACyIoCAP
         mHtw==
X-Gm-Message-State: ABy/qLbtQUjNmL/LCP2Y2YV8C5eYVakn2y2hDRtOfst4fdfvTeSgzdAQ
	BVM3N60w7d98SipP/gsqDqw=
X-Google-Smtp-Source: APBJJlFGK05xKr5kgiQuhfZEeaHfYOC+R2n278bG3Giy5r4TIqwnklypZtNl06OPuv39L0x4dV5Z7w==
X-Received: by 2002:a5d:4c43:0:b0:317:60ae:2ef5 with SMTP id n3-20020a5d4c43000000b0031760ae2ef5mr6347351wrt.31.1691039289025;
        Wed, 02 Aug 2023 22:08:09 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id r6-20020adfce86000000b003179b3fd837sm13528311wrn.33.2023.08.02.22.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:08:08 -0700 (PDT)
Message-ID: <6808de4a-6002-e8bc-5921-06b5938dc69e@kernel.org>
Date: Thu, 3 Aug 2023 07:08:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
 <20230802120755.10849c9a@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230802120755.10849c9a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02. 08. 23, 21:07, Jakub Kicinski wrote:
> On Tue,  1 Aug 2023 08:22:37 +0200 Jiri Slaby (SUSE) wrote:
>> tty->disc_data is 'void *', so there is no need to cast from that.
>> Therefore remove the casts and assign the pointer directly.
> 
> Which tree are these expected to flow thru?

The intention was through the tty tree. But I don't mind either way -- 
it's up to you Greg.

thanks,
-- 
js
suse labs


