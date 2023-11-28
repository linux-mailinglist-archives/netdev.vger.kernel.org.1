Return-Path: <netdev+bounces-51515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AA7FAF92
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEB81C20B0A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BE4A28;
	Tue, 28 Nov 2023 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ehl7wSFx"
X-Original-To: netdev@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDBBD
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 17:33:45 -0800 (PST)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id 7je9r6jZmL9Ag7myvriOfW; Tue, 28 Nov 2023 01:33:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 7mytrajFLhDny7myurBAWR; Tue, 28 Nov 2023 01:33:44 +0000
X-Authority-Analysis: v=2.4 cv=fda+dmcF c=1 sm=1 tr=0 ts=65654378
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=HVNVOb/M/amC2CTWMSx8Ww==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=cm27Pg_UAAAA:8 a=aWmxygetOS5ii7RLA1gA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lxeUuAdRv0cewlSQL8H3OIc5kjQQHP1pS/0W9XhmLDM=; b=ehl7wSFxUV0Q82yli+Bbxifr8P
	Q8KEfVl2kswV5NRFtqxnuTM89wZzGqbTXiq3zF1PlH2DluLrBAEs4XZfkzSA6kAPfd6fRdgD3oLbb
	eCTR+MJQRMzabs4H90nNWaRBF4dcAAYmwfIsUwsVdQhcctjUf2YxyTJRYcX2u0r3SV7GIuxbyE1le
	l44Mr1oJ96542f220yu6i5DBcT2ZETrwf+SCWe+8ShBtm7Qv1bjNR6wTAW1W9qoTAVTtht8ZH19rz
	xjlVH6351zsHDeuQooxTfFqfhMzl6K59UGc/f3GgGgkR3D5KP6ndVuRZVaJ57b0j5mebzIsgKOhU8
	FHbG2c5w==;
Received: from 189.215.210.122.cable.dyn.cableonline.com.mx ([189.215.210.122]:40189 helo=[192.168.0.9])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r7myt-002rhf-0O;
	Mon, 27 Nov 2023 19:33:43 -0600
Message-ID: <a6dc78b1-8ae4-4530-acf6-2931e1863e77@embeddedor.com>
Date: Mon, 27 Nov 2023 19:33:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bill Wendling <morbo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZWJoRsJGnCPdJ3+2@work> <202311271628.E5EED48@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202311271628.E5EED48@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.215.210.122
X-Source-L: No
X-Exim-ID: 1r7myt-002rhf-0O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.215.210.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [189.215.210.122]:40189
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLkcj3b+Q5QWyloeUcfjOTfT0S/Gxvwpc3ZpXirebzWVew/eeQ52wPemYCr+nOWtydDllGTdKFBnKA+1mNKSDCmK+kNUXGGucOE3ieyrjBDZQgWPL2ia
 Q0aRTDBDafiU/FntqsOqQnsYgbEAdGrGluQ1+9m09s+DEQ3gCwmSjBnrwjbHbOplgfHBAB6NTtiNGH/7Uw7aFfBTKz3sDo+ZOgk=



On 11/27/23 18:29, Kees Cook wrote:
> On Sat, Nov 25, 2023 at 03:33:58PM -0600, Gustavo A. R. Silva wrote:
>> Previously, one-element and zero-length arrays were treated as true
>> flexible arrays, even though they are actually "fake" flex arrays.
>> The __randomize_layout would leave them untouched at the end of the
>> struct, similarly to proper C99 flex-array members.
>>
>> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
>> randstruct: Only warn about true flexible arrays"). Now, only C99
>> flexible-array members will remain untouched at the end of the struct,
>> while one-element and zero-length arrays will be subject to randomization.
>>
>> Fix a `__randomize_layout` crash in `struct neighbour` by transforming
>> zero-length array `primary_key` into a proper C99 flexible-array member.
>>
>> Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
>> Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Yes, please. Do we have any other 0-sized arrays hiding out in the
> kernel? We need to get these all cleared...

I've found 27 instances of zero-length fake-flex arrays in next-20231127.

I'll send a patch series to transform all of them.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo

