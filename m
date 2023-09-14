Return-Path: <netdev+bounces-33949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982A7A0CAD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88786B20ABE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A38266B6;
	Thu, 14 Sep 2023 18:22:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB9FBE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:22:21 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68C1FD5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fba57030fso1197549b3a.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694715741; x=1695320541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xmu9uXIxEuhqpcbFad3BugLvTcXDnysHKBGb0Cd96/w=;
        b=keh50AyYPvUJRjLjeAeq9I/u07IXA7NoAToRD/01rHha27shinHadGx7tvt4xPrlsC
         pFnM4g5XND+pdr2Pty2tRS0NO426dM82foDkxmZbY/blRcD4bfUwHMZcesM4i31ydDfs
         4Mz6ImnP1kCYbxlearzSbWBayPY6Av84JHt7OnesFCs68KN+CD/HwVzq6m9HPQzThkD5
         apZS8YtEya+QJuhaMAQJWYlDbiv0WRYhcjcz0hHuoOdxnRYoCVXPiMGAgPlS5NltE4v0
         4VenyRfiQw/AvgSfzNY0zmn7HHola1K0DBkdpl0f/vtQG7Gz8NyD7ecTAO8ogDelSzlx
         +Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694715741; x=1695320541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmu9uXIxEuhqpcbFad3BugLvTcXDnysHKBGb0Cd96/w=;
        b=pJcAFE0ykHYXqGMe/6tRaKVc9l6k6nM6+qaPexQzqaT2U6IdNfdy8nnSyp9w9Tuxhe
         G+WotljNGcHT/37jEEn7c8/3B7+r5DEWUMk+f/94rg/im8ZiYvfr/Jcw6oNvHHXPm16p
         KaIJnoK41TUs1hJDx2nItKMNc5P2dbvSFlMF6YhCEk/D74dsiLfRZ8J+Dv9YdZOgnWtl
         0YZXOMqz3deauWOrOI4hh32wfOGPE89SwiBcAkcZsRxFxF4Z4slIKJyMvdm5sKWk9WLg
         2UoTBvxJztPgDkOG1ec+DF+nU4R/DfUU7SRF47+hsIE5YQlyptoLGYDJ2MpF7ZCWTTYi
         /cHQ==
X-Gm-Message-State: AOJu0YwKSeWD5t8V2uDeDgybJ+Ojz/cyrSohD5DShe4mSk3Jj49U2pFP
	rRmKhHUVZt2FfQ+jqtRDXlw=
X-Google-Smtp-Source: AGHT+IHKMj1Tgpiajko7qvbShZqoDoMbH5drFnQS9PO07BHrnu4/OC2c2CF6C631IxptXm03TUiqLw==
X-Received: by 2002:a05:6a00:188b:b0:68e:3fe9:5d35 with SMTP id x11-20020a056a00188b00b0068e3fe95d35mr8199948pfh.0.1694715740842;
        Thu, 14 Sep 2023 11:22:20 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z24-20020aa791d8000000b006887be16675sm1618720pfa.205.2023.09.14.11.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:22:20 -0700 (PDT)
Message-ID: <5a8047e0-11a2-1564-d6b5-08ed3f5f91bf@gmail.com>
Date: Thu, 14 Sep 2023 11:22:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 3/7] net: phy: move call to start aneg
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jijie Shao <shaojijie@huawei.com>, lanhao@huawei.com,
 liuyonglong@huawei.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, shenjian15@huawei.com,
 wangjie125@huawei.com, wangpeiyang1@huawei.com
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
 <E1qgoNZ-007a4I-W1@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qgoNZ-007a4I-W1@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/23 08:35, Russell King (Oracle) wrote:
> Move the call to start auto-negotiation inside the lock in the PHYLIB
> state machine, calling the locked variant _phy_start_aneg(). This
> avoids unnecessarily releasing and re-acquiring the lock.
> 
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


