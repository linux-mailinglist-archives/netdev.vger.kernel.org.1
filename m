Return-Path: <netdev+bounces-27408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7877BD81
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977DD281100
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E3C2FC;
	Mon, 14 Aug 2023 15:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B7C139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:56:12 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C010F7
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:56:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so3859225f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692028567; x=1692633367;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cs4idELn0auFS4/RHoyt/nYk7YUnx3bv9cAZ0EVFgw=;
        b=Rfp4bprJdH+fcMvX1Wu7mvwIHhr0NBlf5wLs8CzieoFnePYfmq921iTdnQBPIlsWjz
         5iCrRauFJNRdxTcO4NaizUyIJR9UT6/s58df5hwZVStQpJp1FesDBCtwM5xsRE8gc6st
         1wO9fsBdrTmz0uvtpI7O+YWZYB3dSrVizyVGFJ4JMTKtBgKMsS/8+ZJyS2CapVVGTGyx
         7yKI0VOWEa39IUarc50fC7c7sitlbGRGOp3D46pfVCpe9QyMuFCPW5ShdX2fE4Atcmkr
         okHwSfr8KXgSeskl7I0J2DVrsjT/xUUB+4Pe2syWIXxTuazN88qmJBzyMJhY4dwyexz4
         xr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028567; x=1692633367;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cs4idELn0auFS4/RHoyt/nYk7YUnx3bv9cAZ0EVFgw=;
        b=bKninrOrlwhAZ/XhlM/Xk0A58hOUXcmk3qZLsqfvjWGDGpSlmMnNmxwtYfF0+3GLiH
         S90UL3aBMMJ34QuqBNNJgkg8zh+9/o79p83GSS+zfGNWHp7t6lpul78uRH6ATUXNkyNY
         ziix/OB8N702rqdw8Lmn21XBz0PdoLSQSdLuLs43kLLXw2tzksni0dHjlJCK/a1R2Izl
         HGA6/5TkWsaygBmzbuR9M0kotzutSFQrBvOIo3oCWA/DhcWRlsZALp77MQyDiu+uYaNQ
         920olSDEXaRjUehvBzZ8WBYKdJVls6bu8v7G/uuw3aIiYp825Y99s/bQM48/4RSIDrcV
         X2Dg==
X-Gm-Message-State: AOJu0Yyjb58Vnc5iSiCvcq7KMxdZMEi1x7Lc55HP+5E8zQeUQoiHzUPq
	3bDifZM5ZCesCY6/7cFWVTc=
X-Google-Smtp-Source: AGHT+IHXg7wPRgbQ19ASDAqc9foeCBAPev/ksPfyW3qf841bCA+QfYb7yaV0Zd+WNhVC4Nb8ilzZew==
X-Received: by 2002:a5d:4d8d:0:b0:319:6b6c:dd01 with SMTP id b13-20020a5d4d8d000000b003196b6cdd01mr5370239wru.17.1692028567392;
        Mon, 14 Aug 2023 08:56:07 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c210a00b003fc02e8ea68sm17549986wml.13.2023.08.14.08.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 08:56:06 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 1/3] sfc: use padding to fix alignment in
 loopback test
To: Arnd Bergmann <arnd@arndb.de>, "edward.cree" <edward.cree@amd.com>,
 linux-net-drivers@amd.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Martin Habets
 <habetsm.xilinx@gmail.com>, Kees Cook <keescook@chromium.org>
References: <cover.1687545312.git.ecree.xilinx@gmail.com>
 <dfe2eb3d6ad3204079df63ae123b82d49b0c90e2.1687545312.git.ecree.xilinx@gmail.com>
 <ceec28d4-48e2-4de1-9f26-bfd3c61fde45@app.fastmail.com>
 <90e83021-49f3-2b0e-bb9c-01539229c50b@gmail.com>
 <d5d4ae40-047c-4913-9e6f-16093e150e40@app.fastmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d7925076-2747-821b-bc5b-4b18b85d2937@gmail.com>
Date: Mon, 14 Aug 2023 16:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d5d4ae40-047c-4913-9e6f-16093e150e40@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/08/2023 14:45, Arnd Bergmann wrote:
> I think overall this is still a useful warning, in the sense that
> it can spot incorrect code elsewhere.

It's a valid concept for a warning, but it's badly implemented, because
 it fires on 'defining a type' rather than 'declaring an object'.
At no point is an object of the inner (anonymous) struct type declared
 (or a pointer to such constructed) without being (4n+2)-aligned, but
 the compiler isn't smart enough to figure that out.

And as Linus once said[1]:
    If you cannot distinguish it from incorrect uses, you shouldn't be
    warning the user, because the compiler obviously doesn't know
    enough to make a sufficiently educated guess.
(among other remarks on a theme of 'warnings with false positives are
 worse than useless'.  Especially when there's no way to shut them up
 without making the code objectively worse).

-e

[1]: https://yarchive.net/comp/linux/gcc.html#11

