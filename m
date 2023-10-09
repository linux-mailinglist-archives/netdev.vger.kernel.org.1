Return-Path: <netdev+bounces-39301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F048B7BEBAF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01A1C20ADB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6641F19D;
	Mon,  9 Oct 2023 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV2YeAkv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D61E503
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:36:04 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02253AF
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:36:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-693375d2028so4414865b3a.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883760; x=1697488560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SMs8i5LVUTa4pgBhAudEdd9Dkrp3jILKBZQKD277WA=;
        b=UV2YeAkvliSywf6yh+1QlqMTBVlAem0G9x5kMFOr0Pn0hOt7nHYV2RVI3rmdRU+tMY
         vh1CCH8TGFRNsoN5b2mIl6V6uzOvYoBESElZw47h+e3yn6UvbTXif3LSaU55L5sGxZ6s
         +R1WOKks9Kd6VN9k2oTqVhZXb/k+9PPMj0aWena4yF1Bt1WeW3uMHZyx0tg2N8Xv87pT
         23rJwuQPKCjLcacP9cD3kN4YSp9ATcvorV+CQ2Fcy9Xjo9Lcsyduf5XCUhLa/pW7mlrV
         IthBl/f+mxvra9hk1STEZBM7R6y4aci4dRJD2o8ygucDoiYQBs8zssl6rs2sy++mgYZ6
         pqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883760; x=1697488560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SMs8i5LVUTa4pgBhAudEdd9Dkrp3jILKBZQKD277WA=;
        b=F9fd2ywZMeGjkWE7QQ/u9e9gXLwzoRa66qlFQo/JVI05oruVB/5p1trxYOyHH0JbTM
         5GRfKfEzVXy2d/qrgBPaeVTKgsLKeVZlMAORZuiD6VRGqAHXnyEBiFlFOyrAXFPN6zQC
         mCpEMb/blONsJsdjCjxOIpBmHUa1deklPxLfpi4WaK31q/mwPOmOz8Ebrpjj3v5xEL6D
         PIY4004X6iM9elM9Ha97/94aIxoqTbj5oQm346FwcYZ15K4buP5uj9L/oNv3i5i5ib+q
         OMPjEBC2wI4qPN+EobpwLG/ahmSeb9/iHPim2pTSOmZ9N7fkVTY57sQSVpNyUkBkIedj
         osVg==
X-Gm-Message-State: AOJu0Ywc6F7yCz266uiZVuzj6PAdLjcZFow21FLdAvNRgl1s/3eydLiT
	RDkquyP46Rs10MJeIM/cKSA=
X-Google-Smtp-Source: AGHT+IGQoYwOzRX+xGntz/xjV9m31HPqxTnTFa9W8otrpAFP7QazR45IRG1WU3b+lG1UAYdAeN7S+Q==
X-Received: by 2002:a05:6a21:a58d:b0:132:ff57:7fab with SMTP id gd13-20020a056a21a58d00b00132ff577fabmr22083388pzc.2.1696883760263;
        Mon, 09 Oct 2023 13:36:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gu19-20020a056a004e5300b0068fbad48817sm6833974pfb.123.2023.10.09.13.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:35:59 -0700 (PDT)
Message-ID: <66dbb4e5-39bc-4b61-b80e-483516b3beae@gmail.com>
Date: Mon, 9 Oct 2023 13:35:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: dsa: remove dsa_port_phylink_validate()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
References: <ZSPOV+GhEQkwhoz9@shell.armlinux.org.uk>
 <E1qpng3-009Ncs-EC@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qpng3-009Ncs-EC@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 03:39, Russell King (Oracle) wrote:
> As all drivers now provide phylink capabilities (including MAC), the
> if() condition in dsa_port_phylink_validate() will always be true. We
> will always use the generic validator, which phylink will call itself
> if the .validate method isn't populated. Thus, there is now no need to
> implement the .validate method, so this implementation can be removed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


