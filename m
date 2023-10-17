Return-Path: <netdev+bounces-41814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F537CBF67
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BA1F22C27
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7D3FB23;
	Tue, 17 Oct 2023 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CGcZmMy9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BC381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:30:09 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2519A9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:29:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d569e73acso4894823f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534993; x=1698139793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YMg9UDth1zyfm6+o4IfDJ/TtjJPGuDHzs8URdUI/W4=;
        b=CGcZmMy9eMEjsCS+qBYpCnFsqh8rFWciCnYQ0C0e+1uQ1+KyG8qO9vYKMGjkhv14Eh
         TkbbuMC/TVfPLML6IWy/6uFTRTnkbUSQXCD/e5RQ9rdljgaxsoI9yjDBCf35iSkGV5NQ
         3W/WCRAecudbvRymI3VjcJfgSn4wckAZgv3U2ZNZNZf7RjfTB5yIL/hx9pfb/E5Z++oI
         GDU8/0Qc1utHzbU9IOMwprf3cLVUagjaE80diZ7DpjZ4kLaz8GTxoisya/hIECRJAkrz
         o0eOyNntiKPLt8Naaa/wfooAYTNcUOeHVdMdw5AzQZqv46ID9rYFa6JZ+iieiz9//F0E
         VCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534993; x=1698139793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YMg9UDth1zyfm6+o4IfDJ/TtjJPGuDHzs8URdUI/W4=;
        b=hzwBnGEEtRzyUxpMlZwEo+Buvjmum51XONgdNZHc6vamahjrUPVg5rAB4zpM2glELs
         3YGNyjbViFPdidL47UjiJf9trzwa+85m/i+DxC98cuHoyNwq/VwjyWyVuiBfFTqwwwy6
         nHMiPS/SJIlNcMCxUSgQALQtUXHCj99Xpw4aikBs5pTSu2LoIIhucwHdmKgBwpbQ0G4O
         KIHHCYaBWiUkm7MfHfgLxLxAE2c6gTlLACLMX11nBGkDfx3xwZxxXknUw9eOkw8KLxsw
         U2DZFarTC4OMPJPV9jJmN+poLeReIc7P5MVeF6Xthu4KzKh479JJB38sHFllayO+cs3s
         iZjA==
X-Gm-Message-State: AOJu0Yy0BSPPDIKZSxh0swpboIIZcu5FhFbgxWSVrxdBi9RbExtEMBas
	WPrTKmzRFnLk0Paglfl1NMy9Mw==
X-Google-Smtp-Source: AGHT+IFDsjZx+xcrBdb/YKN8Q0pNK2MaviWpf1SGOQsJO3HnQW1ezvnUPi6p3f8EiCsJqnKZPvxa7A==
X-Received: by 2002:a5d:6a0b:0:b0:31f:ef77:67e4 with SMTP id m11-20020a5d6a0b000000b0031fef7767e4mr1309578wru.37.1697534993225;
        Tue, 17 Oct 2023 02:29:53 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d658c000000b003198a9d758dsm1249471wru.78.2023.10.17.02.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:29:52 -0700 (PDT)
Message-ID: <4427a9f5-551d-db41-025e-6854c89628aa@blackwall.org>
Date: Tue, 17 Oct 2023 12:29:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 12/13] selftests: bridge_mdb: Use MDB get instead
 of dump
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-13-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-13-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Test the new MDB get functionality by converting dump and grep to MDB
> get.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++-----------
>   1 file changed, 71 insertions(+), 113 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



