Return-Path: <netdev+bounces-51607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC27FB545
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E646F1C21065
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329703A8E4;
	Tue, 28 Nov 2023 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWu24fWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254421B8;
	Tue, 28 Nov 2023 01:10:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c876e44157so63887871fa.2;
        Tue, 28 Nov 2023 01:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701162655; x=1701767455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+2SmPS9U4mYzKjdHj/aE3sE8OsQ2MA1a3hMP9BMnz0=;
        b=MWu24fWxgjcjKwRWxfIZI8ByKQ5OZE+gDT9uOtcWvLfeleqnorsKln1PXGJgvf5j2G
         lQ/ubQtHdSOp07IkQMhWOIGKQNKYO77wPwxm8tdVIkjG4/Zab32LNd80WA+SCkO0vAUy
         E3VcYfvJ9Ob48LNl4N23Th6a0mNslbkwu7KUlSPWubVZJaj7BgyneKRmr5OauUSwrTaB
         uYZxlbQjYURJPwJLMK1Us0cJP+mddQ0Hq+tUHny0OYrS0mMGRjjRczXQRzvvlZjf77GI
         m5x1AF0wTj/iJOjmtuJQoXuITp24udoWbo49+/X5QWinLt/o8caCGQsOmpQv0bJ26agt
         05EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162655; x=1701767455;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+2SmPS9U4mYzKjdHj/aE3sE8OsQ2MA1a3hMP9BMnz0=;
        b=YS+qD7R/ItKnVlOx8QahHFD/cTqDNSQhUQMMOIiUL2tFpESA9mh/GzgUNZW4GrWojF
         uwROBqcVNs6PAEvnY83tYEzfV/b6Seun/WEE9r2f2c3TiF4+FxQaDRwU/yjAJ3HA1DiF
         qlHIYUR6zsxyaYd2MCZlc1xy38F0+UzlZ4I4nNYF5Ic18Y/5+gyOZNyn+a9Pq6GAdfKJ
         bSSLNmlRrIfkhidFeP8IAMXwIOH+5k+SvqGuIjhhggt7bWRUZKBa4vNOLdsLdcFbVOCl
         Em6CQcJyCoUjdTzlnPWeHZmnOnoOMbulK1UiikJi6eZvuZ6B73WyqcM6LmvZhZNd47L/
         VpQA==
X-Gm-Message-State: AOJu0Yy10x71y6Ktzj9bjtHxPu9u5kyeCzKkPKb5XdWe1/uL7BKte8sa
	QOVDAWxjZM4xMig5iSmlBmWoFVIOJjw=
X-Google-Smtp-Source: AGHT+IE3xsnhcRhZW7XgyitZrkpas0M0zSrRBpkFMoMI1uII8hgXYSNSci/uaRvRido3fYFxxZ370w==
X-Received: by 2002:a2e:8503:0:b0:2c8:34e7:b902 with SMTP id j3-20020a2e8503000000b002c834e7b902mr9422008lji.38.1701162654525;
        Tue, 28 Nov 2023 01:10:54 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.137])
        by smtp.gmail.com with ESMTPSA id y11-20020a05651c106b00b002c83b0bd971sm1680336ljm.2.2023.11.28.01.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:10:54 -0800 (PST)
Subject: Re: [PATCH net-next 5/9] net: rswitch: Add a setting ext descriptor
 function
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, s.shtylyov@omp.ru,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20231127115334.3670790-1-yoshihiro.shimoda.uh@renesas.com>
 <20231127115334.3670790-6-yoshihiro.shimoda.uh@renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <739b5444-0bd5-153c-d43c-fa94a27c7efc@gmail.com>
Date: Tue, 28 Nov 2023 12:10:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127115334.3670790-6-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11/27/23 2:53 PM, Yoshihiro Shimoda wrote:

> If the driver would like to transmit a jumbo frame like 2KiB or more,
> it should be split into multiple queues. In near the future, to support

   In the near future, you mean?

> this, add a setting ext descriptor function to improve code readability.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[...]

MBR, Sergey

