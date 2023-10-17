Return-Path: <netdev+bounces-41794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E941B7CBE73
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264BF1C209C3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B493D99D;
	Tue, 17 Oct 2023 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="v3nTqXsd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A938FA0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:06:33 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946368E
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:06:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso2853695e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533591; x=1698138391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWV3SWcCMqz8NeHwgmjx+5Uh5vS0Y0jqzWLdMkGI8SI=;
        b=v3nTqXsd9O5IrxgZE5cTSWM+6GTjT+sSlhgHToR8V6+pMhexj+3akELzuIjTCctjyg
         wumbRCqmYG9ro4u8DkoItpPAhIlKf6BcQuBCIX3TFm12jYX0qh95oh3JdFjE31iTaVEX
         IL98/Qg5nnbIOB0R2DOIzd7w2D+oZxm0VpSMQnfYG8DkJjyxoTK8rqJKAJuQYm952mqK
         fFcN08SmchtRaRlDI9I+t/8tdyKEcoWn3XN2DDCmUEnRYl8+xopVS0iYwkqVxY7botn2
         RNpa5iAUc3f2O1kGrwMcwN8Ft+eZ/rBdlrJagX+CMmRMsQLtJEFjzaoyloHMsnresyYv
         G0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533591; x=1698138391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWV3SWcCMqz8NeHwgmjx+5Uh5vS0Y0jqzWLdMkGI8SI=;
        b=sfCx2urbVNkIKBwDctzoCTUyoIyvY9aq5gsrhLomrDsC1A/zS6mmm72qr8vYVmg8cd
         xndB50HXahn4DoVgLoYvbwDBgfSkC31EecBz3PLHjHp6gwbJ4Nw+pbr8ecvaXBy6jmob
         R4P5EoXkOL6J++DiJ89cUjcVHXgwuY9C35sboeNrhUty/WYWhHVlJbCYmAF7A1bmjriX
         VdBX+StZSCBKyQSiywGkFVBWac6tq/9byr7oPX3QL6DxBIcw573B3FsrOHiRXOwE/9pi
         BELKkuty55JuLMMURaGr4cY621unH3iT/CxDq3UlrFJQSnx3aX11EP5FAdcPiYH+J65Z
         d2pw==
X-Gm-Message-State: AOJu0YwpXve6xzvyjcJA/1ZFl3NYsMziCv5EvmDw9rVS5BZ72gAJWJXa
	sUx+tuLFKDZfC1xr2ZRgS+WWyfvVs83NWDja2d6t63SRjI0=
X-Google-Smtp-Source: AGHT+IEcc02lzjoAuUXNxLswoGGq9H0UfDrTQUK8UqjBifsYS1wClZ3SEpcSD1oDYzOOawMf9pFPDQ==
X-Received: by 2002:a05:600c:4686:b0:401:be5a:989 with SMTP id p6-20020a05600c468600b00401be5a0989mr1201587wmo.23.1697533591034;
        Tue, 17 Oct 2023 02:06:31 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b00402ff8d6086sm1330215wms.18.2023.10.17.02.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:06:30 -0700 (PDT)
Message-ID: <c3d6c123-229c-ede6-d859-d9b66be5e392@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 05/13] vxlan: mdb: Adjust function arguments
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Adjust the function's arguments and rename it to allow it to be reused
> by future call sites that only have access to 'struct
> vxlan_mdb_entry_key', but not to 'struct vxlan_mdb_config'.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



