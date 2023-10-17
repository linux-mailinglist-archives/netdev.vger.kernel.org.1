Return-Path: <netdev+bounces-41815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE97CBF6C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4331C20A06
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B853FB23;
	Tue, 17 Oct 2023 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="GRELZfuz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E03FB1C
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:30:23 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2474186
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:30:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4054f790190so57823995e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535010; x=1698139810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqrKYPUPhr46HriX5Pvcq+Sh5npTGfsVC23Gye75nLU=;
        b=GRELZfuz2Tk/VBuIDCzsgU5Sq4Rn5FeDmbSL3m80j0WX4H8SysaP6pnIRa1ghtxXHY
         M9ppYBdOnSh4R+762C2rZ/bE6ArmKC7++5fPW5bEUj0CO3sqtwNHC7XwAEloNfQdrvnS
         snQeOndBI9Yps53vjeRpgkX1WCpPsWQW5an9syryKKl+KVEh/TqN+7qhDN3ja0AWeBJs
         qxUZOX19WOh2DzTNmc1CvgXtN9ClVAmZ1midz7N5EbwpMrkapR3lU2vVn00HBMvZB3b2
         Iv9hvgab50I9iqlOb3EUhCVHQ82h3GC/HtpXGsoToXB8cKjQR5o0nSFdiIiU2lzl2CYX
         jKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535010; x=1698139810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqrKYPUPhr46HriX5Pvcq+Sh5npTGfsVC23Gye75nLU=;
        b=vfqcmj+NNbA1k7IYh4LjFQbtrYIEKl1/1Hja2A4vzQbUU6JdByUevDvtV4cyYu1Iw9
         73G+lUQDYNtS34A4sLJ3eWEhxUfp/gINKPNSxE1bySn8bKTJhtaQsFxPkjkznv6YRbBL
         IWzw6uBJVfNkjud9XARMALzySEZMZMfIWjdjDGsQLPgk7fM66jMT69eC3PRjMForXDCE
         3lcHGanFILv1YKI55JH2FoN3LcC5fhTZcSmnzvVTHzP0Br0WUvE7m3qygKPpg6sakhyp
         PCN51KBJEpnvQmAQvHhEer1iIE4G2u5i+P91FkYWMD6wLhTErlTLmUCwM3Xmdw4BGxRa
         lnAg==
X-Gm-Message-State: AOJu0YwqGa3lOzJC6yWYucfeEO249k/XHR2pfku+yGuBiI+bQMdvvuqb
	6YZCzEAr6/lWQpihPB8rAU7uGw==
X-Google-Smtp-Source: AGHT+IEz0cSf9I9DG4JViRBG6/BP7CYJncZSGulHtHhouaCMKvLNfhqaxxANno1jAcx5xlsuPblu7A==
X-Received: by 2002:a05:600c:3b19:b0:406:44fe:7621 with SMTP id m25-20020a05600c3b1900b0040644fe7621mr1323993wms.25.1697535009869;
        Tue, 17 Oct 2023 02:30:09 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id q18-20020a056000137200b003143867d2ebsm1247954wrz.63.2023.10.17.02.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:30:09 -0700 (PDT)
Message-ID: <40dcbbde-3e3e-fd7e-a48c-0aa2ff3bf2db@blackwall.org>
Date: Tue, 17 Oct 2023 12:30:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 13/13] selftests: vxlan_mdb: Use MDB get instead
 of dump
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-14-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-14-idosch@nvidia.com>
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
>   tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++++++---------
>   1 file changed, 54 insertions(+), 54 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



