Return-Path: <netdev+bounces-23034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365F76A72A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B011C20DF1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41881F;
	Tue,  1 Aug 2023 02:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B57E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:46:03 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FA1FC3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:45:58 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-348db491d0eso27653515ab.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690857958; x=1691462758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cez3b/e7u1tF03jEm2BDnWzOV6zcioIbGotfvB0upxI=;
        b=iu1baqGRBaoN3T3Vjt/iX809kGT8obe8qQ9aUgeIAX5E/k2+7Sq5Iivh7oChcVmA95
         wK+qLYMBHLpaZiVxNojZL3sgVJEGseC0Vn6lsbV0m/3Yqr4GXTw80H7dIANjvlhhUZ6W
         ch7NnxfuN3TKQF6YKZuXeycz4oiUNdS0BmsT+2m3LaG5GhHwIDc/7X5bHQ5Bo8vmtnx4
         +rC2yJSmrkxX78/dcFurf0Ga+Z47Z+Nay1g3AuFJvLTP9UADhA4tbYnukgL6HyCNKT8e
         vPIpWJRBr0TW12e/BTb6qJRIOYv7Du2l99y+0O6falk0ENCG7Y7oaACu6cDfavPFfGe8
         qRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690857958; x=1691462758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cez3b/e7u1tF03jEm2BDnWzOV6zcioIbGotfvB0upxI=;
        b=Zo++IYlOPDT8u490dX8VfgnPgWiMohis2Ha1AtGIkVal3WzsTXwKtDVkvn8TWGnzr/
         /sY1UohKiW3LCgKZFkcBhhaZZV4mwkcO4PvHq/srq3LyXnx0DBgKKRIepEbR02gx3pzY
         CLPHa+Dv5M9hab8a8TwTzgXbaiPx/DMKxRW9JKwlXL1U1CldoQyZnJ1hKVC2hn6feJpx
         tW6tCp4WLR66c7CiprXMzq3gAMf19QgKOsPWJfMh1ROn5TY7qqEvRlKdRXE1mssnJqJl
         EjyZJovH7N2NKU3tq4l7fneI8UVuBKlID0a5lT3o57BYq3ktnVYSs2UusyMz5lCxGvcN
         YycA==
X-Gm-Message-State: ABy/qLYG0y20kapPkbwaVkn51nPO6uHg55ygN12uxTReIwVUoyO/sALp
	AzD/FzkRqV0dD2TAGby0EFU=
X-Google-Smtp-Source: APBJJlFhn4RoHWSQZ5wp0jsd6U0tfkYKABqO80pbkhBbz5ET6Q5mv/oiHT804wj4Oik8XOVIK08fVg==
X-Received: by 2002:a92:c5c5:0:b0:349:1d60:f038 with SMTP id s5-20020a92c5c5000000b003491d60f038mr4728129ilt.27.1690857957993;
        Mon, 31 Jul 2023 19:45:57 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:211e:b7c4:92fe:76f4? ([2601:282:800:7ed0:211e:b7c4:92fe:76f4])
        by smtp.googlemail.com with ESMTPSA id m4-20020a924a04000000b0034628814e66sm3583465ilf.40.2023.07.31.19.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 19:45:57 -0700 (PDT)
Message-ID: <079104c9-0076-568b-85b7-ff0d88af76ab@gmail.com>
Date: Mon, 31 Jul 2023 20:45:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next] tc: Classifier support for SPI field
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230725035016.505386-1-rkannoth@marvell.com>
 <MWHPR1801MB19182545B1FEB05CAC9F7371D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <5222d4e2-dd19-fc77-23f0-ce96684e9470@gmail.com>
 <MWHPR1801MB191863234AD01108DD846F88D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <MWHPR1801MB191863234AD01108DD846F88D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/23 8:43 PM, Ratheesh Kannoth wrote:
> Thanks, but if user is compiling ip-route2 package in  a different linux machine ?
> This is what I did. Not compiled against the kernel that I use.  
> Backward compatibility will also break in this case, right ?  correct me. 

See `git log` on your git clone.

