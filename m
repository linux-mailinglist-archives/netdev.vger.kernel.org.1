Return-Path: <netdev+bounces-22568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2021D768096
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 18:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB7C1C20A7E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DE171CE;
	Sat, 29 Jul 2023 16:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB403D60
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 16:26:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8020E1BC3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690647981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqEd0is1bp9afycFcvMTUYOsSo84nZqqhgYV9omeT5M=;
	b=dwgUzfRt9Bv0BFkGljKVRub2d30iQJlxdqUMnZMjDa5wvDCZQu+oe8SftaMXsfvDpi7t6g
	94cDya+SZ4dqJ4WIhTO+oNIE1uBBkAvkcaurwR9rHOMXpp5Y1QHQBNibUQGvWlTlPgkcnk
	eFmKj3VIl5EoF111M2qJm/1Mrns38zU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-eNGgiLg2MV66xoa42DhVXw-1; Sat, 29 Jul 2023 12:26:19 -0400
X-MC-Unique: eNGgiLg2MV66xoa42DhVXw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5219ceead33so2139393a12.2
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 09:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690647978; x=1691252778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqEd0is1bp9afycFcvMTUYOsSo84nZqqhgYV9omeT5M=;
        b=Suvu0/AK8EYuz9Sg5Iar8O8KGGv5/NGW/SkLLrPl9hideX1eVG+0LeOwwb2VNJyvVl
         oGfUHhJY30D+Bm95Dbvlts5wHvDW+MBobBQ/BmaRcLzo4V68/2Ha8S8C8u7xoW4/4feL
         vykrUjHaSSkq9srYfNXEUzFVk1+ZA0/k7FV7lqxOrHNeCQcSBJOA3gXD9Kn6zJ7/2KNk
         2fzaVVytpBusFUlv/iEtWSfYDpg4gJ3OPAo70DNkbuDNtL7jB0JCWxrATUB//c4z3S2h
         ceqj9wWRNmMOF5u/ZK6y/26zi3TyLYZFhqAJFIrN8d6ChA3kmNBU5I6okFoTOK5T3/nF
         bTlg==
X-Gm-Message-State: ABy/qLa4OE3f545s8evKDOJ1JaiE0xJBKb1vd/HpMf26n/Ythfr4Dp5/
	pKgOnuo0RG0C2TdG+gzitGakLuXZpr+rJAbOumGZicJCq3kG/sPtYOWgx/yfrhv7t55OW3XNWhq
	1R1bSVmxDK5Oos0+M
X-Received: by 2002:aa7:d312:0:b0:522:2b24:cf6 with SMTP id p18-20020aa7d312000000b005222b240cf6mr4788129edq.42.1690647978662;
        Sat, 29 Jul 2023 09:26:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEo7cq+SYfU7nf3OuPPc9L67wFH68OCxKgl2zfqbJtnzOR6jh90tCJZsuUrTqq14S8sZvPv4g==
X-Received: by 2002:aa7:d312:0:b0:522:2b24:cf6 with SMTP id p18-20020aa7d312000000b005222b240cf6mr4788118edq.42.1690647978397;
        Sat, 29 Jul 2023 09:26:18 -0700 (PDT)
Received: from ?IPV6:2001:1711:fa41:6a0a::628? ([2001:1711:fa41:6a0a::628])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c44a000000b0052238bc70ccsm3076330edr.89.2023.07.29.09.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 09:26:17 -0700 (PDT)
Message-ID: <872c6834-7344-5494-1094-806825fbb868@redhat.com>
Date: Sat, 29 Jul 2023 18:26:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] bonding: support balance-alb with openvswitch
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <19d45fbf-2d02-02e9-2906-69bf570e9c7f@redhat.com>
 <ZMT0GTGCv89P5m26@kernel.org>
From: Mat Kowalski <mko@redhat.com>
In-Reply-To: <ZMT0GTGCv89P5m26@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 29/07/2023 13:12, Simon Horman wrote:
> On Fri, Jul 28, 2023 at 02:24:32PM +0200, Mat Kowalski wrote:
>> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
>> vlan to bridge") introduced a support for balance-alb mode for
>> interfaces connected to the linux bridge by fixing missing matching of
>> MAC entry in FDB. In our testing we discovered that it still does not
>> work when the bond is connected to the OVS bridge as show in diagram
>> below:
>>
>> eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
>>                         |
>>                       bond0.150(mac:eth0_mac)
>>                                 |
>>                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)
>>
>> This patch fixes it by checking not only if the device is a bridge but
>> also if it is an openvswitch.
>>
>> Signed-off-by: Mateusz Kowalski <mko@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
Sorry for the mess, I just noticed in patchwork that it fails to apply not because of the code, but because I messed up with the line wrapping. I really hope it's the last time with such a stupid mistake; v2 is on its way


