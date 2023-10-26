Return-Path: <netdev+bounces-44394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA407D7CD2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191E6B211FE
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF621172A;
	Thu, 26 Oct 2023 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QaL95mrp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D429A1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:22:47 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A0189
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:22:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a55302e0so569446e87.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698301365; x=1698906165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMs/lnDVBosAB87SvMFfqFQ68LKhkyMZWsGdReytLiw=;
        b=QaL95mrpxPrw3zA7mTXkgO5OG02BhLY5a9AbfitT4OvJWpC5oZQx+i04ssSgX5UGBO
         6ve9raAAVGiv7hFZB3vTkVeoKBQnAwn9/ddtitEhBsnXI61Q8/h0vcEI8zM9xaNpkbVn
         DSIEhZ6SLCcSqJJew8g43YQyr/RpbHlv9xftSM0yXOizHK3hVZVpArwg4uEMrJ0J+Nh9
         5SL/0vPASd6eB5bLkNYwwsW2gA2PBHwuTb1DxgKFqDq2sHVJGUj/0nUsPScIqUHKSFu5
         +A0UX+IdI8n6oDzlg7qzlYvECKJPxAEf4uyqCb02LAEor7yUm6n1tux7ItX+OXBHdntK
         S4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301365; x=1698906165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMs/lnDVBosAB87SvMFfqFQ68LKhkyMZWsGdReytLiw=;
        b=ZVbOrbp9S9p4b1dm3DA+HCvjSC0APq/ijkdGYr/jdedJ+C5uHDMClTpEnGv/khpNY/
         IXcJh5CJcG+4pgYKrZAP/vPn+hgv2fwh1o21QvFh83wWRa0deEbDmKObO4xghD8feTEv
         lPHoBHpmW231ivS12MIDCXqM/7tFC1QJhVUCAGbCmaJJHidGeBa++aV6XIsXx6+6uISi
         JuxGvVlNI5M2O0r641BW/G45xpZXYKW80N2MEDtOu3r2R6Hpl3e9ca53+elMgyLXJqvr
         2zfMEL18i6/1qy4jUfnHd4m2f8Du5ULV7637cGu1NRe063YIssHk1y+GIA76jRjJqPmf
         7nGw==
X-Gm-Message-State: AOJu0Yx8LCNaPewzZgQYdPuWMB8WmF551ZbrdRhXLx4NCJww3m6Gzdi6
	mtJXPx8jPYA4zoTbR3KzVwEFMevELV+Qau9Vtmx2Xg==
X-Google-Smtp-Source: AGHT+IE1vtXM3TiHv1a9F6ZOnwo0mWn9W2yM6p1bH9mZrKinEREfvo+2//4udq2k56A2T9knjWolDg==
X-Received: by 2002:a19:7509:0:b0:507:c763:27b7 with SMTP id y9-20020a197509000000b00507c76327b7mr12735192lfe.40.1698301364502;
        Wed, 25 Oct 2023 23:22:44 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4001000000b0032dc1fc84f2sm13634262wrp.46.2023.10.25.23.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 23:22:44 -0700 (PDT)
Message-ID: <debc87e7-f3b9-8f46-e496-cd96b0202047@blackwall.org>
Date: Thu, 26 Oct 2023 09:22:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v2 07/13] bridge: add MDB get uAPI attributes
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231025123020.788710-1-idosch@nvidia.com>
 <20231025123020.788710-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025123020.788710-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/23 15:30, Ido Schimmel wrote:
> Add MDB get attributes that correspond to the MDB set attributes used in
> RTM_NEWMDB messages. Specifically, add 'MDBA_GET_ENTRY' which will hold
> a 'struct br_mdb_entry' and 'MDBA_GET_ENTRY_ATTRS' which will hold
> 'MDBE_ATTR_*' attributes that are used as indexes (source IP and source
> VNI).
> 
> An example request will look as follows:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_GET_ENTRY ]
> 	struct br_mdb_entry
> [ MDBA_GET_ENTRY_ATTRS ]
> 	[ MDBE_ATTR_SOURCE ]
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_SRC_VNI ]
> 		u32
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      * Add comment.
> 
>   include/uapi/linux/if_bridge.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


