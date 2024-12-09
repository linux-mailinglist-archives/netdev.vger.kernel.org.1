Return-Path: <netdev+bounces-150391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3A9EA14E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1DF282996
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8319ABB6;
	Mon,  9 Dec 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="izStOIzB"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1E197A7F
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780395; cv=none; b=e7Uod6VyyxnOzJvM0SI3c/lITz5nvII2mD0n34BX3J0Hqi6GsmoXMsubhcHpLEscpIHjiAP6vBG+u1Y7lK37XbwkD7Pdn64G4T+c3JHOh7VMQ3BcIsuzfZFP38KPfZmAHC2aSghCSDVfXt9bezVg01UZcFqiT3YIBPgtmm2857w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780395; c=relaxed/simple;
	bh=YLmWJA9o+SyfJrnsdv3qTnFur5RGm681ZsZPsb16fn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ligRGPAWQYDuKdr2T9Cjj+LSSE4vC56wYtlKC2fcefYpBYQhYN3SbFN17kKGFrp0Yw+EOdJEm7aa9dkM+kB5QXhX60ZAJgqjtR2aeo1I58Nr990ph/4YmwJDd1SyWhUqOKhVxsaqECp0wGspWkANpLMm55iOG/MPz1j0EIb+H1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=izStOIzB; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id KWaDtUcZKWxaEKlTmtbFSy; Mon, 09 Dec 2024 21:39:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KlTltacmjw1r6KlTmtfvHG; Mon, 09 Dec 2024 21:39:46 +0000
X-Authority-Analysis: v=2.4 cv=KOBcDkFo c=1 sm=1 tr=0 ts=675763a2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=ZZYOhiE48yz2bGTex4UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QXn0rrOsSXBUaE1ElIYAdbgM/h1YcKYu0JLlnH7xefI=; b=izStOIzB6N6/xFw0N+2qQdShuL
	D/hpq9yZOIc8Px+kLiCyLq7YZ3ojdVacVJjpR4y4gK1a3c4v033UBaoaE1uwNJJz5GL376n4EqLS6
	DCNDGeodGuB6l5FmSdJn1i9zNPs3v33Zr0pdU48E+tDi6NlF+4fOEkpGpBePe9LYuAouIXRJ3zh0a
	ODkNsvUdrZWdwgmBFpK+rE6b0I7XDHdGW0TStUtqRN3qi5zHiVVljvqhjUpEp31zjpNpgBvBUuLNm
	mAVORWCT/f16e/pfCpoRhZn0TAE/7+INvzXJNc8m2OzjthkFuiPWVf7d1C7qsVMdAJ5H9Xglef9HN
	UNuwtw+g==;
Received: from [177.238.21.80] (port=46320 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tKlTi-0030CU-23;
	Mon, 09 Dec 2024 15:39:43 -0600
Message-ID: <0e336341-9575-436f-8e41-df190f67bdd7@embeddedor.com>
Date: Mon, 9 Dec 2024 15:39:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
To: Christopher Ferris <cferris@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 android-llvm-dev@google.com
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
 <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
 <55d62419-3a0c-4f26-a260-06cf2dc44ec1@embeddedor.com>
 <202411151215.B56D49E36@keescook> <Z1HZpe3WE5As8UAz@google.com>
 <CANtHk4mnjE5aATk2r8uOsyLKm+7-tbEv5AaXVWGP_unhLNEvsg@mail.gmail.com>
 <20241209131032.6af473f4@kernel.org>
 <CANtHk4kM-9BDCm69+z3hS58uCrjCmma0aQ+nOqFUROaFhLAkDg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CANtHk4kM-9BDCm69+z3hS58uCrjCmma0aQ+nOqFUROaFhLAkDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tKlTi-0030CU-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:46320
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKHdVKP83S1ogM2iIcpUABRBebzfCw8ok8bUTppyie5e+v+ltd8vHkmJBSm8TroTlH7yt99zDjhgVoUEmDY8hX4QhG+Ws0GEzOyTyIlyH+Q2v9eMd2xu
 B4DkoRR35F2/LVWEe10wFpdJbp+QvrO+JDcSXT96tqVCaJNZWtfBGEYKjlu/Egprw1eJBpY1qyO2gzuiKpFI5geM0aneNAznJr4=



On 09/12/24 15:14, Christopher Ferris wrote:
> Yes, when compiling Android, we have a C++ file that includes the pkt_cls.h
> directly to get access to some of the structures from that file. It
> currently gets the "types cannot be declared in an anonymous union" error
> due to the TAG part of the __struct_group usage not being empty in that
> file.

(sigh) this should be reverted:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9c60712d71ff07197b2982899b9db28ed548ded

--
Gustavo

> 
> Christopher
> 
> On Mon, Dec 9, 2024 at 1:10 PM Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Mon, 9 Dec 2024 12:59:40 -0800 Christopher Ferris wrote:
>>> It looks like the way this was fixed in the ethtool.h uapi header was to
>>> revert the usage of __struct_group. Should something similar happen for
>>> pkt_cls.h? Or would it be easier to simply remove the usage of the TAG in
>>> the _struct_group macro?
>>
>> Just to state it explicitly - are you running into a compilation issue
>> with existing user space after updating pkt_cls.h?
>>
> 


