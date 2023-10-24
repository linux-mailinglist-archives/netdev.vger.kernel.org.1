Return-Path: <netdev+bounces-43723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A257D44F4
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E0DB20D60
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0D5678;
	Tue, 24 Oct 2023 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzSDETPi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761975399;
	Tue, 24 Oct 2023 01:25:50 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B298DE;
	Mon, 23 Oct 2023 18:25:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so3828833b3a.2;
        Mon, 23 Oct 2023 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110748; x=1698715548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFWDBFPcsetvScGtpbuAVby+9Wg9s996ooC10t7jxrQ=;
        b=VzSDETPiQhGX0wY+giqdpVF6EJk+uSYb0vuUJap/xxoJbl51awhDXWWU38QN/EdkUP
         BXp03Dtnki6R28548eFlZ7DsXPkB+UnUoMkkkNfNFfEOvMUvTM3CzDuT8hmcgfEl5Mzt
         GcGu1gvR/lom+y1woGbBEhHSvXbQaifOD/4yyaTV6R1us5gIY/TGyV32xQfaw55t+idQ
         JcIAJpt7AZPpcd1PaZYDi4MOKvZFzyAuNAWwP6em5Os0udOFh+2MtEJoSOfFBl0b5lVJ
         RaFd2KOwmsQzjO/vmsVqN6ctQ3P7W0Z/Re+UAjl5s8Pmo8/dWwBtlBfZac9RMSyK3oN6
         NpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110748; x=1698715548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFWDBFPcsetvScGtpbuAVby+9Wg9s996ooC10t7jxrQ=;
        b=p9gd2J5wGqYhEXg5Y5DhrS1b8pssHtEIcfBVgXzv87tv+ypuafCESrGqlvuJ9+Erfi
         /rjqfLfyS3LpLSguQU77EpAkSKp18aDBNWlzNLmAqWTx6weguSTZ0/AscyehGbHnPyvd
         LcgmsTM7WE1FNNEy2OGh+3OHK2p4RxTbVmePZPlTj5v+FIbHbEpDip7MlCIvsbjGGQn3
         VkUhcjsNgt3OwQhC+Nirqny803jbrECQJ99xvNciC/yw/PrUlyIrKioBB5DJCrdvCXSm
         nL4jfuJmXdiGTiZSuUAEmp0p4MuU1bfPpU/1GerZANsOrIu4/hHCV0GN8yGa2UkJIcYY
         go4g==
X-Gm-Message-State: AOJu0Yz04o9Bl1QGB/SvHzAa6km3cDzAabmdvJwLdT0Z+rjjNxwXVwNA
	wCCC+YWekzGF3fyWap2HwZ8=
X-Google-Smtp-Source: AGHT+IH53mfwQH1g7SOxu509UzXWkjYNbNoeilqRmzhJGPpjvhbQxp16Sb0xVMUMlHSpsoC7HXQrzw==
X-Received: by 2002:a05:6a20:8e0f:b0:16b:e89b:fb18 with SMTP id y15-20020a056a208e0f00b0016be89bfb18mr1607328pzj.26.1698110748642;
        Mon, 23 Oct 2023 18:25:48 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm6757110pfp.56.2023.10.23.18.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:25:48 -0700 (PDT)
Message-ID: <b120e95f-16e5-4590-80a7-1d825f581f77@gmail.com>
Date: Mon, 23 Oct 2023 18:25:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] r8152: Check for unplug in r8153b_ups_en() /
 r8153c_ups_en()
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>, Jakub Kicinski
 <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Edward Hill <ecgh@chromium.org>, Laura Nao <laura.nao@collabora.com>,
 Alan Stern <stern@rowland.harvard.edu>, Simon Horman <horms@kernel.org>,
 linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/2023 2:06 PM, Douglas Anderson wrote:
> If the adapter is unplugged while we're looping in r8153b_ups_en() /
> r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
> loops). Add code similar to what's done in other places in the driver
> to check for unplug and bail.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

