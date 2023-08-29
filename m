Return-Path: <netdev+bounces-31166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E777A78C0C3
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FD01C209C3
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6F14AB7;
	Tue, 29 Aug 2023 08:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125C14AAB
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:48:31 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9327AD
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:48:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500b0f06136so4304046e87.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693298909; x=1693903709;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YXdOGDykBkWrDe9LhA3KST1ecPwiTVNrhZVk3kwu7I=;
        b=m6wNYOofpz8oiHCdZJSHiiLzywpBTz7Rtu/44VCCjF7yTvB3imQ0+bdxZC0xvnlqcs
         FP6qmJ4bXJb0eJ1f688Y+g2pFrzkUPz3b+GOeO5EgPxFNjxf5+Qp4A4PfXR1t4eAH2tN
         tZ3MaGDaxhMPyVzzESFoz/SlNAHZkTgGfiMBWDR3jGVKkylHgSX+Ewk3YW7ebzohsqAh
         0jJs1W4Vfwh3s+mV50kcqtzC9UEx6UknXKFZiSGN5ih+GHsNbcCjpVzGohKM7m/0ucRQ
         HjAh9wJs+PmUnQuHGJwRAZ+6jvsocVucjuZQXMxjvL2nVMpKgRpOhCVk/83345CsOQ66
         aQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298909; x=1693903709;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YXdOGDykBkWrDe9LhA3KST1ecPwiTVNrhZVk3kwu7I=;
        b=C4vwRam55vHk+TVIk+peZSbw/3XxuhjWv2RXSOY2YZSL1JfDOIDs2Go7DanddTII3R
         wnWhI0wGFj4xPrXlKlhMWZuo7RXh+vJw37R74fUjNgnUthgJHqrYUi5N2u2Io0VghB7g
         8ViNzrjB3VNzTjZJUyJrjZ4Sd8cxywJiueNBWMqQxOcJiCLC80HHs3VhqQMrDykqs8Vl
         i2i+9wNXlpIhI35tLzWkobFVEleFreE5z/CnOhksgor8lgaIRF6YNCE32CV55VAQcB5a
         ND1YDfvWrgYHioDhiwHHAZspq5FDoDZ0Y/GuPxKM2WLFFHnvYwdYlNIhAiTTPdzuv8v6
         rLVw==
X-Gm-Message-State: AOJu0Yz6naBOwsBBuHvo/lJVqC1sM878ox935oj5aFbD47ihvNlXTQyv
	Ju/g+UxhIGRT7UBs/G1zsWb6CvS0vsSZIHYyqFU=
X-Google-Smtp-Source: AGHT+IFzKFcZWIfBVpNWaPOscZzLITz/STRm3BBqiTn05syOt5TxHvRprcBJpzP/Gmyu6k8hXXVq3A==
X-Received: by 2002:ac2:58e5:0:b0:500:ae85:726a with SMTP id v5-20020ac258e5000000b00500ae85726amr5688761lfo.50.1693298908985;
        Tue, 29 Aug 2023 01:48:28 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0052574ef0da1sm5413878edt.28.2023.08.29.01.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 01:48:28 -0700 (PDT)
Message-ID: <5068fa2d-4509-8609-1d5f-2802bd03762b@linaro.org>
Date: Tue, 29 Aug 2023 10:48:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] NFC: nxp: add NXP1002
Content-Language: en-US
To: Oliver Neukum <oneukum@suse.com>, u.kleine-koenig@pengutronix.de,
 sridhar.samudrala@intel.com, horms@kernel.org, netdev@vger.kernel.org
References: <20230829084717.961-1-oneukum@suse.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829084717.961-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/08/2023 10:47, Oliver Neukum wrote:
> It is backwards compatible
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


