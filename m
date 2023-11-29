Return-Path: <netdev+bounces-51996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1D7FCDBB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA928320A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3863C5;
	Wed, 29 Nov 2023 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duwsaZeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14731998
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:12:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfd04a6e49so3915945ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701231169; x=1701835969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqyH6u+rSS6UxVT/fS9i4OwteVKi5lJdiU0NIup2wB8=;
        b=duwsaZeJwonmqN9syhxR2QSCpTe2p9HC8yiWWgvGyj3Y4dZq2QPWmkyF45GMQ5CJyd
         5PC1JazbqX/npoZeNKd/YX0W3BITWQQEA/oSvmAYl+fjX+4udEEz60aSlTl5LxDscA8W
         prwYqvx1LAXweWgb0LpUMUNGy3XDD8M8+BukPJL81XVbmxDhoZP7hT++2YIxOr+mc8fq
         FVq7sbjDFjrptl7FS99Q4Dy9xFAjw97uefYhcVq157Hu3mtXKtB3KbkeKAG1PTujRSUc
         X0/zsaaMkSpH990Ei9FrgSGYFoQhTYGrVid4kWbo0wsyu352PoqqKZTqbmtW5DeTwjmL
         Xq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231169; x=1701835969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqyH6u+rSS6UxVT/fS9i4OwteVKi5lJdiU0NIup2wB8=;
        b=chP7C+FNedc5EtE4LdGdSlUZtzEBlJAz/e/GkaPfPKdwDfdmjGW3KZXqKoo33baI4v
         V0ZH9wjD/56vus6SdbeyTtCiCtjHTU6pMbAbYRAhRcDkkRhAluH98gZ3yn/WXM+UP0Mb
         L5erOfa10xAOqj82JkuIwx4VSH2/0EcQaozQpWKxuF0xgO+EvWR6c6vxXo2VY0uFOIxS
         3Smv4f19HUZXYfdIoybRuzHKVbUlMOisVw5n7aU4ZW4utRAS57DyaceW+fzTx5kwayp9
         kMj6Uh8wHj3XJ8zmWrplf4gqdLcOJ0gMHB1ZXjMlDMpWHGcV/Dajy6iZFhM+JbF0QohX
         HiBg==
X-Gm-Message-State: AOJu0Yzq9+e3iWEjtfjYOtrPt7cSC34uCBfMwSDd0eQtfdTQC87EvUHe
	GgFROuQp/PMhnHUks2sNgow=
X-Google-Smtp-Source: AGHT+IGDfPPVaj+9E9AacbkS71Opln4nIg/KYyGhBJSGKuFtEtcqsy+9UVn8YxzwhUi4ATD7OIxz0A==
X-Received: by 2002:a17:902:9a82:b0:1cf:c618:adc8 with SMTP id w2-20020a1709029a8200b001cfc618adc8mr13234403plp.7.1701231169258;
        Tue, 28 Nov 2023 20:12:49 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id je12-20020a170903264c00b001cfe2031843sm3040802plb.269.2023.11.28.20.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:12:48 -0800 (PST)
Message-ID: <cb29499c-0b97-47eb-9dd6-afdb38d2d8e2@gmail.com>
Date: Tue, 28 Nov 2023 20:12:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-7-liuhangbin@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231128084943.637091-7-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/2023 12:49 AM, Hangbin Liu wrote:
> Add VLAN part for bridge document.
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

