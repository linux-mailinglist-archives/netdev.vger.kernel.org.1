Return-Path: <netdev+bounces-32427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61187977F3
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F85281759
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6459212B8D;
	Thu,  7 Sep 2023 16:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B42C80
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:38:32 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4F4EEC
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:38:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500d13a8fafso1955948e87.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104604; x=1694709404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avnDsHqUUU8nyVyXtMluY3OgsN1wqY/4LcZavOrvsJU=;
        b=yyUTQ2vE+GjPAkZ9QxsgnolNVoH5axFzop3GuXnaLFDncGtc6KXK5Jef9UVRHZj/mf
         nLqs+AGcdIwEghn1Eq4ya0ukntYKjEjuuOU6bFsCy5A4G3AB8nNvqiSMQWjXHH1JN0TV
         +E8g36yU69PErmzwwi5jqDMtiQnuVMz6m0mo5AOYR5kNvbU8rAABf8oOhabdOa8QAIj4
         I2K81jpJxTHtbnD32RPJajxMjXzpe8FHkg9y+v3gpmMHvFCMVkSc83bpTfGybIhRfs9S
         OM8s8Aasw9n0vEauX+ZYb9yMMVYom8a9jp0OlaBx5ikCYYLFMuS1DymzpQkz80q3H//V
         H54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104604; x=1694709404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avnDsHqUUU8nyVyXtMluY3OgsN1wqY/4LcZavOrvsJU=;
        b=FtOnqfUZ6+UmUS7kcyBP4RQf58OhsdeMeH0yjfFmfVKpzvlI6xOkdhAgadkiZGJIvj
         7pMY6W7uikbGvOeAFRA3UVpt1xw95gbQ5TIg/OdXg+p7yklmU4UmZ3sTPUc5qToGNpJP
         SUsGm1gg8EPK29ucKZIhPWSVektVV196c8ycf0P23oMO6439xpzPNbMn0teZQWSud64P
         xw2y+UBjntKiRBC5Asv8ATJmkaZ/8eQb2vEE0HuBuQgb1vrdvDoV5X1IS1sQ27mmPN0r
         WJ1WRlJxcbJx60N4FUd5EZGM6g6LFL0GCrrhMEwWsM8YCKpF/D++kmux0QKGzPI9zeaE
         imZg==
X-Gm-Message-State: AOJu0YyDIW9i5vOx3xrFjHl7VA8e0M1efYIpwyReDe02ICcwB48nqnCT
	StL77aR8YcFzybugTnbzJxwKlz9xwq5gk1I+qhSvCw==
X-Google-Smtp-Source: AGHT+IGQOLrWJEjGdkCr3Uovctlsb1sNon+44j0+R+x4O42FhjDtR6v0GBKKLVG6mZLLz1c6Fl+Q5Q==
X-Received: by 2002:a2e:9044:0:b0:2bd:10b4:c3e1 with SMTP id n4-20020a2e9044000000b002bd10b4c3e1mr4375344ljg.19.1694067859321;
        Wed, 06 Sep 2023 23:24:19 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id lo6-20020a170906fa0600b0099bd1ce18fesm10060916ejb.10.2023.09.06.23.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:24:18 -0700 (PDT)
Message-ID: <ccf7072c-cebb-0491-f07e-8c781a2f4664@linaro.org>
Date: Thu, 7 Sep 2023 08:24:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nfc: nci: assert requested protocol is valid
Content-Language: en-US
To: Jeremy Cline <jeremy@jcline.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com,
 Hillf Danton <hdanton@sina.com>
References: <20230906233347.823171-1-jeremy@jcline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906233347.823171-1-jeremy@jcline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09/2023 01:33, Jeremy Cline wrote:
> The protocol is used in a bit mask to determine if the protocol is
> supported. Assert the provided protocol is less than the maximum
> defined so it doesn't potentially perform a shift-out-of-bounds and
> provide a clearer error for undefined protocols vs unsupported ones.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> ---
>  net/nfc/nci/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index fff755dde30d..6c9592d05120 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
>  		return -EINVAL;
>  	}
>  
> +	if (protocol >= NFC_PROTO_MAX) {
> +		pr_err("the requested nfc protocol is invalid\n");
> +		return -EINVAL;
> +	}

This looks OK, but I wonder if protocol 0 (so BIT(0) in the
supported_protocols) is a valid protocol. I looked at the code and it
was nowhere handled.

Original patch from Hilf Danton was also handling it (I wonder why Hilf
did not send his patch...)

https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78

Best regards,
Krzysztof


