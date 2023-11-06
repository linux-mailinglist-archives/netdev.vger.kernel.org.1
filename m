Return-Path: <netdev+bounces-46162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39257E1CCF
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46974B20C92
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65D156D4;
	Mon,  6 Nov 2023 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="pYN/Nujv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2AAD35
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:59:53 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E4AF
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 00:59:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a98517f3so5191843e87.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1699261190; x=1699865990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aypV7mLvbDAZeh5nBCa8xfdYAz42GegtC5Ieo6iBXzQ=;
        b=pYN/Nujv4bUjScDhpaO8ACPfYELWMnufbyhSaulW8Ust1pW4Pd8nyJKeWulJHwUxJc
         kYRNhOzFCMMI2nwJ4hSx86FmeJRi7ZNP7IkVThwbx3qCYSPMP4T+MZFVbneNJYIM3cHa
         oRNGcfTpArNaTzKLUSYFoFM1kMhmFaWru/+zixQIyxoVhweB2NlytbpcksFuhbEeM4Yi
         XkNs4pIhVejWnhfFhQp0kr4fP6ijVn0VGcFw5IOyBuWzFyUGuTYtunI82qhyVObvis3k
         jm5vl8sHBOW5He2ew0Xy04UAd2mo3JhMz3gMFATJBeWoC7Q40mb7PkQGiiR7unse0Mim
         KJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261190; x=1699865990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aypV7mLvbDAZeh5nBCa8xfdYAz42GegtC5Ieo6iBXzQ=;
        b=tTbMY/l4iJCx5fV//tjDkFCLVsgy1g8cn0XG4K3ZXk0/1pbuAiZctgJY/nBq88AlT5
         rTTlkV6+7gfS3MIl1nZO67Hb3b3dt7fDI05Rv8Lv+P/dX0CcsxCoQG/REwofY4E9myML
         OzNrf69v9r/DVzGXj1w0qkCN71pLJQxReeUrSku6Cq+glZYgqMTQbXImARWWDi83Ze3h
         WiF5wEiFjHaqVPdRU3XTTNGqTtBKSYVPoN6b2TklVtWY8CZrw2FNCu/zg7Ew6Xy4+NQ4
         ZcaiGxGC+XKU1hZaTCwv6ULgDi8yBC6HHevnqB3g7Uf41/5bjdCRSt49pjKa9fv1yiXk
         j6DA==
X-Gm-Message-State: AOJu0YxCfnDooGEaVSpAIF7ilikT6XaNiULr/4hpd8J9K7RFjVTfZSmz
	iP3X622GkvEfgtOBcF1m9TYBzg==
X-Google-Smtp-Source: AGHT+IG3Cna/LlnMuAYULkcn1Mo/PI9szbO58Pc5YOQN/aE33Cm+GjVDfxyc/hIwpG6p77cqtp0yZA==
X-Received: by 2002:a05:6512:688:b0:507:9a13:27bd with SMTP id t8-20020a056512068800b005079a1327bdmr27380714lfe.7.1699261189709;
        Mon, 06 Nov 2023 00:59:49 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id y36-20020a0565123f2400b00507a8789b43sm1080387lfa.269.2023.11.06.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:59:48 -0800 (PST)
Date: Mon, 6 Nov 2023 09:59:46 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, Steen.Hegelund@microchip.com, rdunlap@infradead.org,
	horms@kernel.org, casper.casan@gmail.com, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
	Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <ZUirAkfDahc50Oti@debian>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <ZUOUGf-PMGo8z1s-@debian>
 <aa175902-560c-4fad-9e0b-aa4efa0482c2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa175902-560c-4fad-9e0b-aa4efa0482c2@microchip.com>

> I understand that you are using two LAN8650, isn't it? if so are they 
> both running simultaneously? or you are doing the testing with one alone?

Currently we've only got one running, hopefully we've wrapped up the
board bring up in the next few days and will be able to run the second
mac/phy as well.

> > With this setup I'm getting a maximum throughput of about 90kB/s.
> > If I increase the chunk size / oa-cps to 64 I get a might higher
> > throughput ~900kB/s, but after 0-2s I get dump below (or similar).
> Did you or possible to try a test case with below configuration?
> 
> - Single LAN8650 enabled
> - UDP
> - oa_cps = 64
> - spi-max-frequency = 15000000,

I'll set that up and will get back to you, all testing I have performed
has been with tcp.

> 
> Did you run iperf3 test? or any other tool?
> If iperf3 then can you share the configuration you used?

I just tried copying a file over the network with rsync, but I'll run some
udp tests with iperf.
I'll do my best to get back to you with results today.

> 
> I don't know whether these may audiences are needed in the CC for this 
> thread. Let's see what's Andrew Lunn thinks about it?

No opinions on my end at least.

BR
Ramón

