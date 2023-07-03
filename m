Return-Path: <netdev+bounces-15149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43B745F57
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C30280DB5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26100FC1F;
	Mon,  3 Jul 2023 15:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB8FBE1
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:01:43 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE5E72
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:01:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99384a80af7so3781966b.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688396495; x=1690988495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIdAV5V5KAnS+h+qxHS03r1FUQFpj/gJ3vvk0BEn92E=;
        b=ifmaivl4Z+J5L8F8MKx5XFkvPydvR4OFSmVCDYgNVzdBET5oxRjmyWnN2kndVisi4P
         lh0KEoEm0nCh+Ao5XN1cGX5wQaxlfgIqV77vEmp7203tbGymfBI0Rq7akosGTOmg8Wf8
         PmWQMd5NuMCt2/cyDk13+/PjRrrJWrMrXJShpcAI37eAsBCWmcKYJtNcJ5raUkOwtyAk
         Q35E7HeaXRJj7Jt9HW1ZVoD9ofYkcEmiBQGtfN6227PPbG9tO5Y4MLtEEOnLm1/6EuS2
         vZw7pZBeqXTIklfShbq6TVnnpRut4lKaShTbszCmBOV//5NapwMjQGtaJuGV2iVjzIQg
         bLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396495; x=1690988495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIdAV5V5KAnS+h+qxHS03r1FUQFpj/gJ3vvk0BEn92E=;
        b=QjHuojXiMX7sZgfYzRpufKOfBBUTDAb8ZUzWLNSamirtO0rYaN0udY/vIrXpA6U4ET
         RKj2F//yzOBkvZ4uQcR/8e20yUtgiX0pitL1LOwvKea1fyQvrS9Y4QhgIzgb7C2+dBcj
         E0tSKIGmkCc1PJaqOL3dnPOTysVWCMu5aYw/+4zmIeHOys2UW7F4MNPU0sm5pwAzWgFC
         tMUHCb78X7rI0KbBqrU2Z3ccC2ysQmJBzol+QJz9tTxDbfK+YpYL7PdlTjMo9Q3neqFF
         V5KbSMyIisc5IPNzifpbNaD0VAwG5X9akqZN/Ex4FeIfWefpCrsDbciW7c2vj1eIuTCo
         kOrQ==
X-Gm-Message-State: AC+VfDzInDp3wxWs+qDpEyq+ZOsDC9oqJJysNdouPhZdollQpGPPEr/1
	0vOcJ3KGiRHymyS57cWv24a3rA==
X-Google-Smtp-Source: APBJJlF4nZmviyLst8bq9ovVEqJK/HZkrp9/ry8hWn6K/xwqIxJjlmWLVSf2GEYdGeflLlSv7IOP3g==
X-Received: by 2002:a17:906:8699:b0:973:d06d:545f with SMTP id g25-20020a170906869900b00973d06d545fmr5693067ejx.24.1688396495465;
        Mon, 03 Jul 2023 08:01:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h22-20020a170906829600b009931a3adf64sm3751695ejx.17.2023.07.03.08.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:01:35 -0700 (PDT)
Message-ID: <56c0783b-59b4-0eda-5a9a-ceed53ebf41d@linaro.org>
Date: Mon, 3 Jul 2023 17:01:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] i3c: Add support for bus enumeration & notification
Content-Language: en-US
To: Matt Johnston <matt@codeconstruct.com.au>, linux-i3c@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
 <20230703053048.275709-3-matt@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703053048.275709-3-matt@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 03/07/2023 07:30, Matt Johnston wrote:
> From: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> This allows other drivers to be notified when new i3c busses are
> attached, referring to a whole i3c bus as opposed to individual
> devices.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Your SoB is missing.

Best regards,
Krzysztof


