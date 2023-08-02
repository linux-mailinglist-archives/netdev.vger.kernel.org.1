Return-Path: <netdev+bounces-23692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341576D1F6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21982819AB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F98C1A;
	Wed,  2 Aug 2023 15:30:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA879FF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:30:38 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF623AA8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:30:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3493967982aso5228285ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990232; x=1691595032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouKbZSWzH+zKNStkTPRZYR+ObqZKgJBDyHvZHkG2gsc=;
        b=WjZ5vo6pdeoxVXh7UJhdZ+UAR2IzYnfZvyv/ofxGNwpk7BzhRpGruL/kch9+OYCwzh
         4/KLID7LSrKLtvRkBVlQ72IotvX1GWSAz/jIiJOdvhdedJlYzxJtYWHeyegz2FlSPqXU
         QPsx48BBZ0vwtEVzEQ9GVBWt6/4Gs9uy/yvO1DGGj8kZ0GxLtsJs3jN4z4WYayb8s7zd
         8pi2oAiuGv8yR5HciYqAuEHJLM6gLJLrFLHh6lklEAa81MJGJBbfuTTZpXKxhBOV3eLG
         94uwiECdyj519ZuqvG+l+CG9i/MHx2FpPXaMPOddbQz6TbJqxtyHJh1d128yAQ1kHgD0
         JM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990232; x=1691595032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouKbZSWzH+zKNStkTPRZYR+ObqZKgJBDyHvZHkG2gsc=;
        b=kShuDx6mrdLZ/J2vxvEPwDDT6slnQ+KU2KRgissirXxr4gsH6Hx5nTuzCmVGVzlVtJ
         sqPlVpFrKc6SdA4iPd5fXKHmWsr1Vb2fcPk1q9BwqA1/sWLyI/HMDUvqNc1R1eDwMaba
         Oc4MRwqUVdG4V0QprOxZPJjGIOPN4IKgtKYV5cYKKHqWZWyWt9xW0rA9kSTzs7Ff63BS
         tQUYnHvaUNc7k1D92g7vFsb+/lGr7qyANitlLpO5oa7QfvFYAUALxoUVVqbMcpq/KLHS
         YYe0y7LSw7fUHtNuO9gGC+nhsP0WIrOnkr3lRTuDEYaClWVFbR6wc6GySAc+MOZIuOKk
         lA0A==
X-Gm-Message-State: ABy/qLb511zP9QnMz+bN8i+p8QxQrzPC3WwYesNi7Q/VcCOZAVBLmNsh
	vdlSUM79AKnmYkn2BbEb6ng=
X-Google-Smtp-Source: APBJJlFXLFjG3o4sqMGv/Agae4FX0axC44EzavRECEwBvr8WMdipWT9VvLzFnHViG7q7RnwkGe5dFw==
X-Received: by 2002:a05:6e02:ca1:b0:348:bb23:da0 with SMTP id 1-20020a056e020ca100b00348bb230da0mr14618948ilg.11.1690990232558;
        Wed, 02 Aug 2023 08:30:32 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:211e:b7c4:92fe:76f4? ([2601:282:800:7ed0:211e:b7c4:92fe:76f4])
        by smtp.googlemail.com with ESMTPSA id c14-20020a92cf4e000000b00345e3a04f2dsm4625172ilr.62.2023.08.02.08.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:30:32 -0700 (PDT)
Message-ID: <9be77251-8ad7-c4b3-0830-450e907fc3e6@gmail.com>
Date: Wed, 2 Aug 2023 09:30:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next] tc: Classifier support for SPI field
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
References: <20230725035016.505386-1-rkannoth@marvell.com>
 <MWHPR1801MB19182545B1FEB05CAC9F7371D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <5222d4e2-dd19-fc77-23f0-ce96684e9470@gmail.com>
 <MWHPR1801MB191863234AD01108DD846F88D30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <079104c9-0076-568b-85b7-ff0d88af76ab@gmail.com>
 <MWHPR1801MB1918FF429D8E360EE0C3D3FFD30AA@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <MWHPR1801MB1918C7804430B157CDE578C3D30BA@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <MWHPR1801MB1918C7804430B157CDE578C3D30BA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 3:30 AM, Ratheesh Kannoth wrote:
>> From: Ratheesh Kannoth
>> Sent: Tuesday, August 1, 2023 8:20 AM
>> To: David Ahern <dsahern@gmail.com>; stephen@networkplumber.org
>> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
>> Leon Romanovsky <leon@kernel.org>; edumazet@google.com;
>> pabeni@redhat.com
>> Subject: RE: Re: [PATCH iproute2-next] tc: Classifier support for SPI field
>> Got it. Thanks a lot !!
> 
> Linux kernel patches merged to net-next. 
> Should I repush iproute2-next patch ?  https://patchwork.kernel.org/project/netdevbpf/patch/20230725035016.505386-1-rkannoth@marvell.com/ 
> I could not find the above patch in the live patches being tracked https://patchwork.kernel.org/project/netdevbpf/list/ 
> 
> -Ratheesh

I just merged header update. pull latest -next repo and update your patch

