Return-Path: <netdev+bounces-23956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876276E4A3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5896282088
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB3156FD;
	Thu,  3 Aug 2023 09:37:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4F7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:37:22 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144C49C6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:37:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so11305161fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1691055422; x=1691660222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gxxp4r3SLmVXwd7QLESwzGmLVMkeoSmrpwS9UI/62t0=;
        b=acEQPoObNLR7tVSVXXSQ555mxs8lxpcIuwtpflobSdEj//y/UjbxT7u7RqLVm9Nv5R
         svvVCLf67TqVuxI/XmGs7SVYWEOxye2vpfsairjf+RHTiQyTKSviu5Cz4gHwu28imxYj
         YaIfm6Qc0Q96ToFQNd0mIb7o5eavaiCarDLXIzaqScTeyem5wPXI556/Jkxp+zfCkx1t
         74iQpVKtBvrr45QgQBFOgUwu3VjnT/xmyS8NNPUv1qifkHq98NbivLvO3fc2rtWVvP1s
         nVkJOtzIdIhhRd8ZVR1ciIrIIPwCpEpku4o1olb58Ute8EImuuet+KaCOosMGyz0/Gnm
         tiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055422; x=1691660222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxxp4r3SLmVXwd7QLESwzGmLVMkeoSmrpwS9UI/62t0=;
        b=NKqCYj8M+W3n0bxh2QCgn65bWOCI6gxKPK3zMjQUZA3jtqfDxA2d/1UhAFxXtf8Rvb
         L8LEKzwlVOQxtymvnHCpQWnTYkQaQ4hRWkso2nsOaA8apO78IGONJixV0oOTUl1R9Av1
         CmeWT4dTMfoDe/1WH7S8euyW9Er4j32EabnxHhIJOvc/8EQHTQo1zTgS1pfQFjxa5q2N
         O4eT57S8dQ30Z+5Y+p9B0ZWMEok7JLflA0BQOJwsGtDxU2I0b6TeNrNadUerR0qwDoBJ
         Q+7NUF5QrP7LkM4rNqJ9AZvDcDytdOUp1BNMKw+6/ywSJd0hZKuyn86RfLsPjfmmjWCr
         2EAw==
X-Gm-Message-State: ABy/qLbfxzuz8YpwJC7eRrGcpnX6J42nOvCoohI4pzI6eesVAlQrr/jw
	Om0LJ+gtNpmOSUSU+2D2TdnmCQ==
X-Google-Smtp-Source: APBJJlEs8YzTQttp3hUrbLEDyf9NAMl6vSv/PbMAAFVYnpx1fJeaxkw7Fehwg6kpmFFPc3sx7x40aA==
X-Received: by 2002:a05:651c:106:b0:2b5:80e0:f18e with SMTP id a6-20020a05651c010600b002b580e0f18emr6697660ljb.3.1691055422157;
        Thu, 03 Aug 2023 02:37:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:715:a86c:f2f5:a28? ([2a01:e0a:b41:c160:715:a86c:f2f5:a28])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b003fbc9b9699dsm3760781wmc.45.2023.08.03.02.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:37:01 -0700 (PDT)
Message-ID: <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
Date: Thu, 3 Aug 2023 11:37:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org,
 Siwar Zitouni <siwar.zitouni@6wind.com>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
 <ZMtpSdLUQx2A6bdx@debian>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZMtpSdLUQx2A6bdx@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
>> This kind of interface doesn't have a mac header.
> 
> Well, PPP does have a link layer header.
It has a link layer, but not an ethernet header.

> Do you instead mean that PPP automatically adds it?
> 
>> This patch fixes bpf_redirect() to a ppp interface.
> 
> Can you give more details? Which kind of packets are you trying to
> redirect to PPP interfaces?
My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
at ingress to a ppp device at egress. In this case, the bpf_redirect() function
should remove the ethernet header from the packet before calling the xmit ppp
function. Before my patch, the ppp xmit function adds a ppp header (protocol IP
/ 0x0021) before the ethernet header. It results to a corrupted packet. After
the patch, the ppp xmit function encapsulates the IP packet, as expected.

> 
> To me this looks like a hack to work around the fact that
> ppp_start_xmit() automatically adds a PPP header. Maybe that's the
It's not an hack, it works like for other kind of devices managed by the
function bpf_redirect() / dev_is_mac_header_xmit().

Hope it's more clear.


Regards,
Nicolas

> best we can do given the current state of ppp_generic.c, but the
> commit message should be clear about what the real problem is and
> why the patch takes this approach to fix or work around it.
> 
>> CC: stable@vger.kernel.org
>> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
>> ---
>>
>> v1 -> v2:
>>  - I forgot the 'Tested-by' tag in the v1 :/
>>
>>  include/linux/if_arp.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
>> index 1ed52441972f..8efbe29a6f0c 100644
>> --- a/include/linux/if_arp.h
>> +++ b/include/linux/if_arp.h
>> @@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>>  	case ARPHRD_NONE:
>>  	case ARPHRD_RAWIP:
>>  	case ARPHRD_PIMREG:
>> +	case ARPHRD_PPP:
>>  		return false;
>>  	default:
>>  		return true;
>> -- 
>> 2.39.2
>>
>>
> 

