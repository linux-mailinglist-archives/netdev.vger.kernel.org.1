Return-Path: <netdev+bounces-36117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADC7AD62B
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97202282463
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2B14267;
	Mon, 25 Sep 2023 10:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7326FCF
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 10:38:01 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8426E9B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 03:38:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6769so22487105e9.1
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695638279; x=1696243079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NNRcMwuERaBl25L7UoycFy039dxy5njWGLf4VQsv18E=;
        b=BLaKS4LyCkTgyxPd8aJtVuydZ4js/vd0YLE2HbaANsFl3kca9Cuvko4Q5rstcY7yw7
         wWf6WGAR5/RUj+rvYwzL1Sfd8sW4eExG3TGbLfXrslISMq4OS8vxVxVZ87WMV5bQHDP7
         Q4GUaQoIZQN7+Akmd6a4bWqz/J2lQxw7yBjX72FTcUzSLp4W0bVhx8jl/6a+tM6Zm5SN
         2ifZH59WLvPpRChFrHWiZHCneONVt5rcuG3YedzaL4fjPIXH25HGMOczDpCZ5azgkxpp
         RTk8W6MmdvQwEFM88XLNR4bdUNoRpVD1zjzP60QGl1Rb92QL1KHPJuFiYuIrb6UpSJpR
         bnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695638279; x=1696243079;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNRcMwuERaBl25L7UoycFy039dxy5njWGLf4VQsv18E=;
        b=mixZbDFmPpLvAt7Xpl2WGJhiHUwd59oNYigua5wVyXjV98iXKLsnsi8r6nStWD9bO2
         EL5joFrK1j7flfvmifAPpWEIRBogYMT6B7OsV/tSm6avRux0G2hW6v1Yn/fUOoFTfl2J
         WO/c4vc+QQJw9OiaiUMXJAhSIna1jolz3ZZuvW1kfm0UX31x3CNx7+pER7/f6Gtd+xpt
         AWomvAIg2dRw/JReaKckYYktjBcp64tVgMJSImpSliElIwgUYmffJmlQdSGob8Omk32K
         vmjFyiFf0WA5xDcoldJ+6RNoQIpoEfYVQZh7odRKn/U8iZkRY5CLvG9SRt6Rn81dUMqI
         If2Q==
X-Gm-Message-State: AOJu0YxnHZPigDLfYB5zyobmbH5/rzJ9t4jhXO0htim9gVmhu14GjNLm
	l9wnV7v+xU5SE6vNPHa+O6c=
X-Google-Smtp-Source: AGHT+IE5AQhHAI8/TvNxOM3sRp2pbeXe307DqlEQHWBIe0zPxzuD2kspgrU5qEmow/vqxgK3aHlFZw==
X-Received: by 2002:a05:600c:246:b0:3fb:c075:b308 with SMTP id 6-20020a05600c024600b003fbc075b308mr4957800wmj.12.1695638278655;
        Mon, 25 Sep 2023 03:37:58 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc3d:b00:d4bc:f1ab:d54d:4af1? (dynamic-2a01-0c23-bc3d-0b00-d4bc-f1ab-d54d-4af1.c23.pool.telefonica.de. [2a01:c23:bc3d:b00:d4bc:f1ab:d54d:4af1])
        by smtp.googlemail.com with ESMTPSA id l18-20020a1c7912000000b003fef3180e7asm14829733wme.44.2023.09.25.03.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:37:58 -0700 (PDT)
Message-ID: <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
Date: Mon, 25 Sep 2023 12:37:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 link up but no traffic, and watchdog error
To: =?UTF-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <87a5taabs9.fsf@mkjws.danelec-net.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25.09.2023 10:36, Martin Kjær Jørgensen wrote:
> 
> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> CC: Heiner
>>
>> On Wed, 09 Aug 2023 13:50:31 +0200 Martin Kjær Jørgensen wrote:
>>
>> There were some fix in r8169 for power management changes recently.
>> Could you try the latest stable kernel? 6.4.9 ?
>>
> 
> Well, neither 6.4.11 nor current debian 'testing' kernel 6.5.3 solved the problem.

You can test with latest 5.15 and 6.1 LTS kernels. If either doesn't show the error,
please bisect. And you could test with vendor driver r8168 or r8125, depending on NIC
version.
The tx timeout error is very generic, based on just this info there's not much we can
do. According to the following log snippet you have 4 NIC's in your system.

[    0.750649] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.771525] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.791797] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
[    0.807683] r8169 0000:09:00.0: can't disable ASPM; OS doesn't have ASPM control

Are some on PCIe extension cards? And does the problem occur with all of your NICs?
The exact NIC type might provide a hint, best provide a full dmesg log.


