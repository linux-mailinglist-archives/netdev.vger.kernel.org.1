Return-Path: <netdev+bounces-54616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA5807A3C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B625282481
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4C36F60D;
	Wed,  6 Dec 2023 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l64y8tNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E68ED5B
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:19:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77dcf6330f3so8972185a.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701897560; x=1702502360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Elwiqko9sbyKNIAs5tE4r8jqstg8OoAY6A4v3Cn2hwo=;
        b=l64y8tNelthJGKJ3xo1xFS/FClFhDwYqSyzQScrqOEhelUnDT/reM3jrlG8st2ohRj
         C0QLV0P+YVmsSyPsMtaCtAyhgXAgLn2RTJNj9ryB7MGf9NP/siCDbSxvzj28LddWegdT
         1nEa9/HQu3Eu4l5ijpO1J1NUkz/4tCVTHKJ9WoM+OoQS1EfbYx3R4by+usRFfHUYI09q
         5JYhMlR+G9izOApJjX9iE9hDsguebWyf2v7cRlamApKR9TCIf0gj/7s7WNqHhV4671Bs
         eBGGPnm+dz/lDJ5xn4t1EMh/SRgdzvL+pbv3WHnfK147ccHk7Nh5ngCUH9nCc+Fqnc4W
         pWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897560; x=1702502360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elwiqko9sbyKNIAs5tE4r8jqstg8OoAY6A4v3Cn2hwo=;
        b=P8dz6prX2wd3SMEJXA4iY5G8GFPICNU8Y0os8EABsqVcjUCfS/tl+mrVKx7sUZL3Yo
         /Wdga844RohBtStEtdee5XOQUsiu/7y8uub4TYAOY6A+L8zRny9Wy4ADvurIm5C+D/TN
         xWLE+s66R6Hj+nQWksPk28jhqyDxXLXxxg9GSAzHMi+Gnpo6qPMVnAefa9ZdRL8a0TUQ
         tDch7ThTkVmzlxsm5kB8uGxXs0iTw2xF1JA3LTazlqiosDAHyneCEKs7xKOrDLtjNjD6
         7MbUXOteZTvi00l/uEbt++2+rjaVKs4YAgCobuSGVXQXmF2/S4gPF7m8oBZOoAIDvdtU
         fTkA==
X-Gm-Message-State: AOJu0YzW9We7UK1MfS4BqoVaL5F60GC6xSj6Hfg9FUQtEJMw0+rHIr9l
	64tEZFBX049TQfFgwQLOOKg=
X-Google-Smtp-Source: AGHT+IH4ybZPhNbBhPd6I9odNxSGhhKiPbgYpcT45Gq8EQpYjX6ITx2nyqNr/urSPHEEArB2qmyvnQ==
X-Received: by 2002:a05:620a:8a8b:b0:77f:1827:a9b6 with SMTP id qu11-20020a05620a8a8b00b0077f1827a9b6mr94967qkn.138.1701897560385;
        Wed, 06 Dec 2023 13:19:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c19-20020ae9e213000000b0077589913a8bsm234684qkc.132.2023.12.06.13.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 13:19:19 -0800 (PST)
Message-ID: <7913de53-3ee8-489a-910d-94ded7a77848@gmail.com>
Date: Wed, 6 Dec 2023 13:19:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Restore USXGMII support for
 6393X
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, linux@armlinux.org.uk,
 michal.smulski@ooma.com, netdev@vger.kernel.org
References: <20231205221359.3926018-1-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205221359.3926018-1-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 14:13, Tobias Waldekranz wrote:
> In 4a56212774ac, USXGMII support was added for 6393X, but this was
> lost in the PCS conversion (the blamed commit), most likely because
> these efforts where more or less done in parallel.
> 
> Restore this feature by porting Michal's patch to fit the new
> implementation.
> 
> Fixes: e5b732a275f5 ("net: dsa: mv88e6xxx: convert 88e639x to phylink_pcs")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


