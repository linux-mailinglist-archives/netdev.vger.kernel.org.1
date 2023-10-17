Return-Path: <netdev+bounces-41796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432A7CBE86
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175FBB210A8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43713E49C;
	Tue, 17 Oct 2023 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Ea1PW5wI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316A3E480
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:08:35 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E25113
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:08:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4425617f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533712; x=1698138512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTB0PMaH81cPxzWaC0ockKjG/083eP/4X9lYMUVdtT8=;
        b=Ea1PW5wIYUzgfzJaBXNZ7Ij6Ud6pew8YqIkVJHDgNJukgL1CuRyvwrMNg4n7Mw0hp0
         g46NLWAeAE2CgeqR4Br0OSatUq29+keWA5Tlc55mDbaGZ1VzuiI9kb6l+FAt6Oey3Gh0
         sS8CY3ATOGz2O4A60aFGgqpi0pIuZbywptnnrurAZr1uqWa24HHu4WsHvpXHx64db96K
         /t5G9riKHUI7rPv8BrcXbBA9K/IlVWvdxVRg4uxlG1ejSmwpYx+i98ik032jVdgOobp0
         EmfHhjsShQ5CJLQ6ZwBYSR+lQWUzg/MoXDVrrs2CjxKLU4af8xfDM+1+l8WBUudrAVFw
         iPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533712; x=1698138512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTB0PMaH81cPxzWaC0ockKjG/083eP/4X9lYMUVdtT8=;
        b=NnU+OITY5xrY4vIcZIb9+4NdSVXEGnf2Rs2EqAk8YK7jrr6SvG9XpCyx322v5iHxux
         /SErSVEfTk7MwZ9jSrd6VgIIvHp1d3d02fJ1vyOjpzTLjxNvRWS2f4o8LR3+OgJVOXlb
         aLxOlSpHlO6Cas8ZNDJcUyFOddG5ETm/wuBvWKPS1QylpLQRxd/nMgj68dI60CFa2SFr
         yiteSBCbF/2yK62rkASB2NFMaIOIm507AwNg8KCjYd6J3RxbkYAr/MhX/ZJdRJ2iuxEJ
         UaS0HDAz/pM/ino+NJlqG+aZbZO/pXRa+OJ4Hn15bYNROKlBAxoxvgVSfLtmBtl45uJk
         FoAg==
X-Gm-Message-State: AOJu0Yzfbxd0m8hjCuuwnV+BYDWC+2aLd/1PGncCPRuVxyZFzoS036eK
	mv/WstsSZEq3xM1bXUgIP3yTAw==
X-Google-Smtp-Source: AGHT+IEKlKUjAzEYYG9bMLZQN2BDOsUYVxWI1cNAYo4pvWcT5Cpe/y+SIVSa1+2HJShKv/WHKr20Hg==
X-Received: by 2002:adf:e908:0:b0:31f:f99c:6009 with SMTP id f8-20020adfe908000000b0031ff99c6009mr1487116wrm.22.1697533712286;
        Tue, 17 Oct 2023 02:08:32 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d50c5000000b003140f47224csm1213811wrt.15.2023.10.17.02.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:31 -0700 (PDT)
Message-ID: <b3e0d656-cb25-3ac8-6391-8fb27217470b@blackwall.org>
Date: Tue, 17 Oct 2023 12:08:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 07/13] bridge: add MDB get uAPI attributes
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
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

Could you please add this info as a comment above the enum?
Similar to the enum below it. It'd be nice to have an example
of what's expected.

> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/uapi/linux/if_bridge.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index f95326fce6bb..7e1bf080b414 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -723,6 +723,14 @@ enum {
>   };
>   #define MDBA_SET_ENTRY_MAX (__MDBA_SET_ENTRY_MAX - 1)
>   
> +enum {
> +	MDBA_GET_ENTRY_UNSPEC,
> +	MDBA_GET_ENTRY,
> +	MDBA_GET_ENTRY_ATTRS,
> +	__MDBA_GET_ENTRY_MAX,
> +};
> +#define MDBA_GET_ENTRY_MAX (__MDBA_GET_ENTRY_MAX - 1)
> +
>   /* [MDBA_SET_ENTRY_ATTRS] = {
>    *    [MDBE_ATTR_xxx]
>    *    ...


