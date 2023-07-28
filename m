Return-Path: <netdev+bounces-22253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828D766B9D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7549328258E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBE125D3;
	Fri, 28 Jul 2023 11:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A811CBA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:23:20 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ADB2D67
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:23:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9922d6f003cso291267966b.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690543397; x=1691148197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4LTDxQ4pixt383DZuso0/tLAJcxN+Vr2TJLYhxvDho=;
        b=pzBPYWRi4XYtx14TIx7V0ARGbT2HX/iDRtRm+N6alpkse3dHhdaeE+JgOt8k9fD8ou
         0qnaLPBbvS6MuO1UmrxMmxAJZpNM7u4x/SFXPsiDhMIGjyq2sqOIuxi2eUvndCG52Zg/
         /fWOdNTqUl36Iuhthsb1avsetc9eIPoXr7wz7bvsE1nfaUgXv+e6Qm/j04xVVJSRpqRZ
         hFue0Y8ZR1Zy9nO0CJHn7q9F4BVUKsL5TzKKSmLVi9wclBR6IL27JC90zsfywCzfTOiw
         6Tt2zqdWExXfxmTRZqdkLlaU7K8NZ0PbtMbf40HGRKh93tckDk+AhA8U8f6NRNprCDXh
         Dl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543397; x=1691148197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4LTDxQ4pixt383DZuso0/tLAJcxN+Vr2TJLYhxvDho=;
        b=PeOWdfKEV6ydyVp1rU2vvTdqAvxlKVll92wmtVUU37y9rki48swoWMEVvfBykjquiD
         SlRSDmO4c8SguESr2Py4L46YgtTZp2ndUz0vddMjKFFGhtOVXoLtugq59ypfkiJVcKWg
         gf72khhJ0Fe+W/hyhsEo2EruKtOWp+GBsHH2ZkikmTjyYbTRJnrQ0wYoogC9QQcXH0r4
         B2RPWQiizwG4FDKdPtUS/wmOaKEsTipKmPYX96ETnzY/KpCsNyNNHF57hTsBZEmA6/ed
         sORAqhTDAXzu//2tZZielCA53DYmOrctnVSX1kG6wrcVUnD4sTz+4sF/Odi+nlDIwU5v
         FOOg==
X-Gm-Message-State: ABy/qLZui2DaYRk0/jX34B2dF5PY2Z//CRo3M1SR8fENaAaGtRrsv21m
	BQzNY+JTpmXemKfs77p1+/FZMw==
X-Google-Smtp-Source: APBJJlHo69ZbyCZ8zRZC0iv3EojWteAcwCt1O+mC/jVNlpR7/StwUJy2m7xN/dLUxQhwsatF/zDnSA==
X-Received: by 2002:a17:907:2cd2:b0:99b:605b:1f49 with SMTP id hg18-20020a1709072cd200b0099b605b1f49mr2083475ejc.36.1690543397266;
        Fri, 28 Jul 2023 04:23:17 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090616ca00b0098d486d2bdfsm1978416ejd.177.2023.07.28.04.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:23:16 -0700 (PDT)
Message-ID: <506eca29-9785-e580-91d2-9b7f8f26cdfc@tessares.net>
Date: Fri, 28 Jul 2023 13:23:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink -
 manual merge
Content-Language: en-GB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
 <5d240ea8-3fd9-5e43-1bcf-2923bfddee72@tessares.net>
 <ZMOaZdDVkN4bq66C@shell.armlinux.org.uk>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZMOaZdDVkN4bq66C@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On 28/07/2023 12:37, Russell King (Oracle) wrote:
> On Fri, Jul 28, 2023 at 12:23:25PM +0200, Matthieu Baerts wrote:
>> Hi Russell,
>>
>> On 26/07/2023 16:45, Russell King (Oracle) wrote:
>>> Older DSA drivers that do not provide an dsa_ops adjust_link method end
>>> up using phylink. Unfortunately, a recent phylink change that requires
>>> its supported_interfaces bitmap to be filled breaks these drivers
>>> because the bitmap remains empty.
>>>
>>> Rather than fixing each driver individually, fix it in the core code so
>>> we have a sensible set of defaults.
>>>
>>> Reported-by: Sergei Antonov <saproj@gmail.com>
>>> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>
>> FYI, we got a small conflict when merging 'net' in 'net-next' in the
>> MPTCP tree due to this patch applied in 'net':
>>
>>   9945c1fb03a3 ("net: dsa: fix older DSA drivers using phylink")
>>
>> and this one from 'net-next':
>>
>>   a88dd7538461 ("net: dsa: remove legacy_pre_march2020 detection")
> 
> It was unavoidable.
> 
>> ----- Generic Message -----
>> The best is to avoid conflicts between 'net' and 'net-next' trees but if
>> they cannot be avoided when preparing patches, a note about how to fix
>> them is much appreciated.
> 
> Given that this is a trivial context-based conflict, it wasn't worth it.
> If it was a conflict that actually involved two changes touching the
> same lines of code, then yes, that would be sensible.

Sorry, it was a generic message from a template I used, mainly for
occasional devs reading this, not for you then. I didn't know you were
not mentioning anything for trivial patches. Noted now.

> Note that I don't get these messages from the netdev maintainers when
> they update net-next (as they did last night.)

Your patch is not in net-next from what I can see, nor in linux-next.
That's why I sent this message because usually it helps Net maintainers
(and maybe Stephen). I thought it would be helpful to share that even
with trivial conflicts because it requires a manual operation, looking
at the different patches causing conflicts, etc. but if such message
does the opposite than helping, I don't mind not sending them when the
conflicts are "trivial".

>> - 	if (ds->ops->phylink_get_caps)
>>  -	/* Presence of phylink_mac_link_state or phylink_mac_an_restart is
>>  -	 * an indicator of a legacy phylink driver.
>>  -	 */
>>  -	if (ds->ops->phylink_mac_link_state ||
>>  -	    ds->ops->phylink_mac_an_restart)
>>  -		dp->pl_config.legacy_pre_march2020 = true;
>>  -
>> + 	if (ds->ops->phylink_get_caps) {
>>   		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
>> + 	} else {
>> + 		/* For legacy drivers */
>> + 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
>> + 			  dp->pl_config.supported_interfaces);
>> + 		__set_bit(PHY_INTERFACE_MODE_GMII,
>> + 			  dp->pl_config.supported_interfaces);
>> + 	}
> 
> Of course, being a purely context-based conflict, that is correct.

Thank you for having checked and again sorry for having taken some of
your time for that.

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

