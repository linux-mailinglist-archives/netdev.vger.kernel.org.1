Return-Path: <netdev+bounces-22272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868AC766D0D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720701C20EB6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0E12B87;
	Fri, 28 Jul 2023 12:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517C107B3
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:21:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E294EEC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690546818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5HfwoOjrNy1RUgRMJFEsNL6n3UtrIhg7p3HHrsgJDg=;
	b=EUnxlJPUdgyEgQxthQejKTHqcL2T5yS/jjZDpmwvFdFrnf69WxuluVKFUCs3Mz7WqFn/ET
	RgWEHhDQU2v9Zml7cbKdE+CRtB8IQbP2laaapDTYk5uI3phDEw5DoNz+IaUQyEXBZpSVqg
	g4KTRMKHDnWCM7H6xOtuL9+TkFd50IE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-iw6pVbCnPUy6HF_-o3O6Gg-1; Fri, 28 Jul 2023 08:17:06 -0400
X-MC-Unique: iw6pVbCnPUy6HF_-o3O6Gg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fdde27470aso1946611e87.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 05:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690546625; x=1691151425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5HfwoOjrNy1RUgRMJFEsNL6n3UtrIhg7p3HHrsgJDg=;
        b=DAKmgjFkVd460FdxBvdQycjYWzvlZm+dVLvbinitpaOi0Z9lP4hqG8yo7/0Qc963jq
         Resjxvg9IE3J8ht9O1ctwBkgzxgC3xXqk56nPEt1ZbPRHWY0PniLz2VUZT/97/p9aEF0
         MvycmIPWI7v4uq1JqHkC45jAXrTKY1Swc55HGdTSdQIvDL7TcVKNB1JBLLTvZXjliVzL
         2epzpkxulaiy+aoM42ypC/K/CtVBVF1TesqtUZPD4YznDcZA25/xUp4Rp4WMVuunLTQX
         42/ljR5FPcOxqsR5LUWQfTfDjqqlApFVZEFO4bGoyt8QCAQjYA6v6Tv90kln67qOqwYs
         Zhzg==
X-Gm-Message-State: ABy/qLbC2bPuk/aEIuIiKMCPgx6PVIIy8Xa/+N6lVby+W6KFXEvdR0Dm
	YsU2RSqRrIMcc5B09TTFNI9dVNDVKFC3KkX5c4Qw4M1HWDL3nQmXCrtFVwtgkSm70y5iWYZ8/xX
	DlXUzSXkDfFSF/9H1uRBgOCTE
X-Received: by 2002:ac2:4bca:0:b0:4fe:1ecf:8ab4 with SMTP id o10-20020ac24bca000000b004fe1ecf8ab4mr1982171lfq.18.1690546625327;
        Fri, 28 Jul 2023 05:17:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7nMdAdugyUS7qCkWXujeT5YU5zHrpieox58jSbBEFzciIsjuwAjMNHa7WYbA927DJ2HuWBA==
X-Received: by 2002:ac2:4bca:0:b0:4fe:1ecf:8ab4 with SMTP id o10-20020ac24bca000000b004fe1ecf8ab4mr1982152lfq.18.1690546624980;
        Fri, 28 Jul 2023 05:17:04 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7cf01000000b005221fd1103esm1751857edy.41.2023.07.28.05.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:17:04 -0700 (PDT)
Message-ID: <1bfe95c4-80f0-4163-6717-947c37d4f569@redhat.com>
Date: Fri, 28 Jul 2023 14:17:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net:bonding:support balance-alb with openvswitch
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>
 <ZMOusD1BnLXqiUEE@kernel.org>
From: Mat Kowalski <mko@redhat.com>
In-Reply-To: <ZMOusD1BnLXqiUEE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Thanks a lot for the pointers, not much experienced with contributing 
here so I really appreciate. Just a question inline regarding the net vs 
net-next

On 28/07/2023 14:04, Simon Horman wrote:
> Hi Mat,
>
> + Jay Vosburgh <j.vosburgh@gmail.com>
>    Andy Gospodarek <andy@greyhouse.net>
>    "David S. Miller" <davem@davemloft.net>
>    Eric Dumazet <edumazet@google.com>
>    Jakub Kicinski <kuba@kernel.org>
>    Paolo Abeni <pabeni@redhat.com>
>    netdev@vger.kernel.org
>
>    As per the output of
>    ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
>    which is the preferred method to determine the CC list for
>    Networking patches. LKML can, in general, be excluded.
>
>> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
>> vlan to bridge") introduced a support for balance-alb mode for
>> interfaces connected to the linux bridge by fixing missing matching of
>> MAC entry in FDB. In our testing we discovered that it still does not
>> work when the bond is connected to the OVS bridge as show in diagram
>> below:
>>
>> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>>                        |
>>                      bond0.150(mac:eth0_mac)
>>                                |
>>                      ovs_bridge(ip:bridge_ip,mac:eth0_mac)
>>
>> This patch fixes it by checking not only if the device is a bridge but
>> also if it is an openvswitch.
>>
>> Signed-off-by: Mateusz Kowalski <mko@redhat.com>
> Hi,
>
> unfortunately this does not seem to apply to net-next.
> Perhaps it needs to be rebased.
>
> Also.
>
> 1. For Networking patches, please include the target tree, in this case
>     net-next, as opposed to net, which is for fixes, in the subject.
>
> 	Subject: [PATCH net-next] ...
It makes me wonder as in my view this is a fix for something that 
doesn't work today, not necessarily a new feature. Is net-next still a 
preferred target?
>
> 2. Perhaps 'bonding; ' is a more appropriate prefix.
>
> 	Subject: [PATCH net-next] bonding: ...
>
> ...
>


