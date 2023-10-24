Return-Path: <netdev+bounces-43725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789907D44FB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D1A1F224E6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8D5CB5;
	Tue, 24 Oct 2023 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfFJ1moj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124432103;
	Tue, 24 Oct 2023 01:27:16 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F113ADF;
	Mon, 23 Oct 2023 18:27:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so3829665b3a.2;
        Mon, 23 Oct 2023 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110835; x=1698715635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM1CeNLw8L77vrhtQf8LKN5yHFEm1SLkIaPJ3SSl+Hw=;
        b=nfFJ1mojgiWpHjrTE+0pm1PVLbpRT2zuiyJSuGOxXVEclzN1C2ceVfypAj8CVbb4p6
         PzCqUCAtVZaOPhKsZxtD/335x+CMyJ3Ig1HDEscuqKUPDLWYWW68BVGYqvBMNSuKqdEt
         QIZfWNEZCfoAv1iQXKOV30zpXkRIhiOUcQUD9Bu3lRufjANtRLGLQSR2QAI4evfEpgbj
         LGPpe8j7Vtqlj8XHdePcI5Y8G3LXlnFqRAM5Ohllkqq5NhVo2vQ9akjD7XmOYzzla8zT
         h5HbGiq04KhUp7hBuCTIoEHvOYCl3e8q6qHAJ1WqCM69813OWr5Amr926ws4ZdDTLScN
         UzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110835; x=1698715635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM1CeNLw8L77vrhtQf8LKN5yHFEm1SLkIaPJ3SSl+Hw=;
        b=bBVdh1X41irPmhB+QhnhDL7dmvdV30VYUSQwrdAjL5o+vn1Z7hOocbBym+FBOAoaV+
         3V0anzlN0Hk8Rxx9w0aHf0VCJfDAIEaWZckp1bQy/94FdTDCh7yIu9a+Rvvu8RTqtcBd
         UHPTnlmuxA4GwaWMepTehGreJCWd35zD0fFJD/WqQ2y6r/rvaQFkOaD6MB8UMJHKJUv4
         rHIfgkjWg36p83ELj55p1eSA3xOMaqk1RORXnnzn3qovNVo23bR6q1QbACYYciGFOP/h
         IvKONK/2YXVw3724cIkW4me3d25s19NAgd9A5GbcvuSLTnPl54V+MDGswYgatizHXj+K
         DT3A==
X-Gm-Message-State: AOJu0YyRGCJtO/gdN4oBEyrlJjPZ0IOEg+Mk5iFar41pF4wG6DwIOKkT
	a8z2vB1O93XTbYhGKimWX+w=
X-Google-Smtp-Source: AGHT+IFXWWD7chmQ42QH3diOEz+0bOlvHVgq4mVkr79m6iJF8iWePzh9ECvPJHd2KOVftWHFMPaKfQ==
X-Received: by 2002:aa7:888b:0:b0:6bd:9281:9446 with SMTP id z11-20020aa7888b000000b006bd92819446mr13055839pfe.10.1698110835338;
        Mon, 23 Oct 2023 18:27:15 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm6757110pfp.56.2023.10.23.18.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:27:14 -0700 (PDT)
Message-ID: <acc63cea-5b51-4837-91ad-988d1a00e796@gmail.com>
Date: Mon, 23 Oct 2023 18:27:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] r8152: Avoid writing garbage to the adapter's
 registers
Content-Language: en-US
To: patchwork-bot+netdevbpf@kernel.org, Doug Anderson <dianders@chromium.org>
Cc: kuba@kernel.org, hayeswang@realtek.com, davem@davemloft.net,
 ecgh@chromium.org, laura.nao@collabora.com, stern@rowland.harvard.edu,
 horms@kernel.org, linux-usb@vger.kernel.org, grundler@chromium.org,
 bjorn@mork.no, edumazet@google.com, pabeni@redhat.com, pmalani@chromium.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231020210751.3415723-1-dianders@chromium.org>
 <169797182424.5465.9720701078350268924.git-patchwork-notify@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <169797182424.5465.9720701078350268924.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/2023 3:50 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Fri, 20 Oct 2023 14:06:51 -0700 you wrote:
>> This series is the result of a cooperative debug effort between
>> Realtek and the ChromeOS team. On ChromeOS, we've noticed that Realtek
>> Ethernet adapters can sometimes get so wedged that even a reboot of
>> the host can't get them to enumerate again, assuming that the adapter
>> was on a powered hub and din't lose power when the host rebooted. This
>> is sometimes seen in the ChromeOS automated testing lab. The only way
>> to recover adapters in this state is to manually power cycle them.
>>
>> [...]

Oh well, late to the party, but this looks great, thanks!
-- 
Florian

