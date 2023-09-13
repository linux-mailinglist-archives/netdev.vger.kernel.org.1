Return-Path: <netdev+bounces-33591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61479EBAF
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAFB1C20BC4
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D771F175;
	Wed, 13 Sep 2023 14:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED988639
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 14:53:48 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D61AF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:53:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4018af103bcso7159375e9.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694616826; x=1695221626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vPY/W/H3Oplgi8r6AJclJ5yFg444X+6a75Zvk9owULY=;
        b=BKNfPnvqkFI47pNNppX+CPFc3AhTIfKrUQVgfn/QtgFSaR3XiVz6Bm5iIJi8IDAJA5
         hArm6cpPsUtDAxwXkTNnlcnXIwSm2BeT5svnb7XPVDdaFsCHyzuGdLhMux52MhNMJs4k
         /6+MgaENQrNdU5Y+R0cri9RnkAijv1FcFNjVWQKhfPXgQnQ8FS8I5a9lLSv5SvkcyjcU
         QgAxA5fkwsOLMfWuKelmDAU+nLeL+TlYXQGAbneyrF3e5iIIByPhqAMiOM5yVlcpAiAo
         jKAPv++8MjgYFiKJUrKyCrq4KL1YqsKJMm5ULvEqZktqYnKUTpUIo47Usony/b0oZyaP
         /gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616826; x=1695221626;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPY/W/H3Oplgi8r6AJclJ5yFg444X+6a75Zvk9owULY=;
        b=w3cyBNDkJcbhG92sFx3w/2icL+pz6XIxSYM1NrMTTD403afNFzNXkyBWAYDs9qmhJw
         99rk15HMIUxUnWzYYFBAaq8Adr4x3CnyoulBo92Ug21XVw3RaS4Wa4tW/2h6dh0yH83a
         lEAS1Ow38NSsJt3R4HVtkAC1W3PsQTDov6LToDkdSUVz0P+wEheVTUhluVEyADva6Aa9
         Z2MSUF5Twyc5StnSCF+HDMp54GbYEjDMmnwa/upDJlmsSCocpCsETbTAUvnW3qdyCYiQ
         S9A/wk/v9ug74YQgd5HpX++jTI47cffgsIistH0QMiNReHjRZVlTwGncsnCk2OQiYvPq
         lWgQ==
X-Gm-Message-State: AOJu0YwSAx3I5ra2PwAdtNZTTVkrRLlqyGyPmm2Rn7AUcEAQNelKN47D
	/YoVewiWyypvuVP2Im0yBx8E+XTIlZWwN7Z7Gwc=
X-Google-Smtp-Source: AGHT+IFOPnDghV7tdFwNZajhr2AvxlioqMOdzfq5Lro/LpTAjsv9RO9X9iXGNlWbMKoC7B+T1411sg==
X-Received: by 2002:a7b:cb99:0:b0:3fe:1b5e:82 with SMTP id m25-20020a7bcb99000000b003fe1b5e0082mr1966211wmi.20.1694616826609;
        Wed, 13 Sep 2023 07:53:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fde6:545:ec1d:c8f4? ([2a01:e0a:b41:c160:fde6:545:ec1d:c8f4])
        by smtp.gmail.com with ESMTPSA id w11-20020a05600c014b00b003fbca942499sm2264976wmm.14.2023.09.13.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 07:53:45 -0700 (PDT)
Message-ID: <a4003473-6809-db97-3d06-cec8e08c6ed6@6wind.com>
Date: Wed, 13 Sep 2023 16:53:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com> <ZQGG8xqt8m3IHS4z@Laptop-X1>
 <e2b57bea-fb14-cef4-315a-406f0d3a7e4f@6wind.com>
 <767a9486-6734-6113-9346-f4bef04370f0@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <767a9486-6734-6113-9346-f4bef04370f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 13/09/2023 à 16:43, David Ahern a écrit :
> On 9/13/23 8:11 AM, Nicolas Dichtel wrote:
>> The compat_mode was introduced for daemons that doesn't support the nexthop
>> framework. There must be a notification (RTM_DELROUTE) when a route is deleted
>> due to a carrier down event. Right now, the backward compat is broken.
> 
> The compat_mode is for daemons that do not understand the nexthop id
> attribute, and need the legacy set of attributes for the route - i.e,
Yes, it's my point.
On my system, one daemon understands and configures nexthop id and another one
doesn't understand nexthop id. This last daemon removes routes when an interface
is put down but not when the carrier is lost.
The kernel doc [1] says:
	Further, updates or deletes of a nexthop configuration generate route
	notifications for each fib entry using the nexthop.
So, my understanding is that a RTM_DELROUTE msg should be sent when a nexthop is
removed due to a carrier lost event.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/ip-sysctl.rst#n2116


Regards,
Nicolas

> expand the nexthop information when sending messages to userspace.

