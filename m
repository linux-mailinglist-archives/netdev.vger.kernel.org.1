Return-Path: <netdev+bounces-44663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E97D8FFB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0541C20972
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF3BE65;
	Fri, 27 Oct 2023 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP4eHa3U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E718C0B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:37:36 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688D194
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:37:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2800259527dso971413a91.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698392255; x=1698997055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8MUzNKWLTaPTg4n+SdehfihfEkGzhjKXvlCr0P/w/E=;
        b=YP4eHa3U6ptP3LWMN0JxgtLZVNnr9FFUkr7DOmVvxOv1oRhnxSafRY79+rUI20Hw6N
         Oqz05Y9limZFSzfKlc5LAelxOWbMMm9ihh5IWhnEWBElVOrJGMLD9q/EineEyY1K06z7
         jIf6oeoHl0QMM9FcpmRNZL10AADegC4pE6/DnAdUXbMlzKinemX0e9gAY3tRbhFJ4EhO
         z4Afrylo0WB47T1vTxDCpePt7Yp2g9CskufgjRoorTH2sBfAUeCBDLGjIZodOkVbdPu/
         O+Go3H5qNZErPxE3QZPyQ+KvNjU0ZTsNjOYcaoIunTpJA3w309ZoumNQiLTKEvHFnI/g
         ToBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698392255; x=1698997055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8MUzNKWLTaPTg4n+SdehfihfEkGzhjKXvlCr0P/w/E=;
        b=qSdB8mI3OrHNpVXq1cgeoeDUTAOLve4HudZQ8S94lOlNYIMyv0MGCNa7/v2RbozZO6
         DddXTrfZCqyzDUSwC7QeXCVciRP2ZMMZ+TVAJLMaCiDdaHCRzjMQO1MTJHFH7GbpJYGM
         Aq1y4RahmToDdsM/b1jb4i8Et1DHGyxqe6RrAQvXOdzhSw166lhBxj+Yz93bIq1c3F7q
         Qx5S5/06AwGYtjEChfkRaMeL8a+jNyKyNEP3BDbOlkDAfUDHavDq7k198bFqnUj9sHBy
         NzIMFC6DFV5i/Rd9VPJyaEcEXmQQmkefTyEuB2SuDVX1ETaQqIStOt1JK/2pCRRSv1ZG
         YHEg==
X-Gm-Message-State: AOJu0Yy2CBaq7yZlI6sDH5+kRpVjH59637OR7IJbyFhFByBm7y8G3fyk
	OlqRpvnMUPe049ByXK2hEks=
X-Google-Smtp-Source: AGHT+IHvl0yJ9jVnasmj9occpqM8bDbsgsNQoLuEVpBTnyApRND+KeM59OMiDWxUrXvKjMpLFCVpoA==
X-Received: by 2002:a17:90a:188:b0:280:44d:637c with SMTP id 8-20020a17090a018800b00280044d637cmr1815950pjc.34.1698392255170;
        Fri, 27 Oct 2023 00:37:35 -0700 (PDT)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b00276e8e4f1fbsm2722874pjv.1.2023.10.27.00.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 00:37:34 -0700 (PDT)
Message-ID: <c18bb733-9ce5-ad32-acfa-370f72cf5efc@gmail.com>
Date: Fri, 27 Oct 2023 16:37:31 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under
 drivers/net/
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, arnd@arndb.de, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com
References: <20231026190101.1413939-1-kuba@kernel.org>
 <20231026190101.1413939-5-kuba@kernel.org>
Content-Language: en-US
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20231026190101.1413939-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/23 04:01, Jakub Kicinski wrote:
 > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
 >
 > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
 > ---

Acked-by: Taehee Yoo <ap420073@gmail.com>

