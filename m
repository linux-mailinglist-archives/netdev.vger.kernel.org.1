Return-Path: <netdev+bounces-162893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED14A28500
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921777A1D60
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63E21773C;
	Wed,  5 Feb 2025 07:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-09.21cn.com [182.42.152.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BDA25A649
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.152.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741028; cv=none; b=YfARlhMk4ZJbiEBVAJc0KSwltUGGEXbrxBSZJZwBx/pGU26DQq+POwndjwcSQ8VTwfNhQSCWK1GgZTW0kfBT6XO3HeKUsL5PwUEyiNS8wr0jwCPlla0KMGnlb493F49BVbOXwH8MNsFb7SG4hLo7CwAziw+4dHmZJehZVTPrH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741028; c=relaxed/simple;
	bh=ho0NXURDL77T+dgu2a0+uk7wR4lwCiwMAWQcxWGSGVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITXMUlXzi8UgksX4x4sjymbUP/AC8XIyL9o/eOTq89U47NRgC4ALma6nmhKZHDTemtOdzJ/T+e2vYjOf/ldC7u9uqshOqsNc6WWthBJTdoiBssknyvOwTs0K+FWc6TN0QoLLzJPQlknWzspdaZINbKcFEVaC1X6OJ/dmL4Tkfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.152.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.461118916
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.71 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 679C81100019C;
	Wed,  5 Feb 2025 15:25:22 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.71])
	by gateway-ssl-dep-84dfd8c7d7-g6c8d with ESMTP id 976b27694c1244948071f19fd834903e for kuba@kernel.org;
	Wed, 05 Feb 2025 15:25:29 CST
X-Transaction-ID: 976b27694c1244948071f19fd834903e
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.71
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <c0ccfff2-3995-430b-b762-e055861c4247@chinatelecom.cn>
Date: Wed, 5 Feb 2025 15:25:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seg6: inherit inner IPv4 TTL on ip4ip6 encapsulation
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, liyonglong@chiantelecom.cn
References: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
 <20250120145144.3e072efe@kernel.org>
 <CAAvhMUmdse_8GJtn_dD0psRmSA_BCy-fv6eYj9CorpaeVm-H3g@mail.gmail.com>
 <20250123074824.5c3567e9@kernel.org>
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <20250123074824.5c3567e9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/2025 23:48, 【外部账号】 Jakub Kicinski wrote:
> On Wed, 22 Jan 2025 11:20:05 +0100 Ahmed Abdelsalam wrote:
>> This patch is not RFC complaint. Section 6.3 of RFC 2473 (Generic Packet
>> Tunneling in IPv6 Specification) discussed IPv6 Tunnel Hop Limit.
>> The hop limit field of the tunnel IPv6 header of each packet encapsulated
>> is set to the hop limit default value of the tunnel entry-point ode.
>> The SRv6 RFC (RFC 8986) inherits the tunnel behavior from RFC2473l
> 
> I see. I think this information would be good to have in the commit
> message. IIRC we do inherit already in other tunnel implementations, 
> ideally we should elaborate on precedents in Linux behavior in the
> commit message, too.
> 
> reminder: please don't top post on the list
> 

Sorry for the late relay. And thanks for your review.

Is it ok that copying inner hop limit(TTL) on SRv6 encapsulation just
like what ip/ip6 tunnel does in Linux implementation?
if it is ok, I will send v2 which will add more detailed commit message.

-- 
Li YongLong

