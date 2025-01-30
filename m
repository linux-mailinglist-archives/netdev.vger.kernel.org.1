Return-Path: <netdev+bounces-161654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70707A230E0
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA83A6CCE
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787F1E9B2A;
	Thu, 30 Jan 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Bm3nWnc3"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F81E98E7
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249948; cv=none; b=aVRoGD3bUiRtM72pTp2qmJzdVuQuzbvJrTykDjSPdyZFpopKM1yjanVm+FV66D8DYmrteA+ZqV+qMSMJ39YzzV2LHtJg2hAv06u7UkdOQpz3EBDlqsSwW3gV0A4NIYT13tkO7ifUTYXrE7snRoL8lvaf4GNvhlpUb8HcsXtSofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249948; c=relaxed/simple;
	bh=nif4wB4y/qzE2wni3GYV/h4+8/p5NS5VPsDgiux12Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQk3rHgnJ/3JfC2IQv62s6BMqWqzp+y1zVMTUMYLEMiHijUaZfyMuRhXrArkWx3+VM18UFQp+5SV3HcypwjjOnBIPfH7t+Wc6GgZ0gSbpEQaGWNVuFt9KQBkyNRfj1vw8dpmZUPGebEGC2A5//9zsYhudK8FGHbk0lAPSy7Os2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Bm3nWnc3; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 37F9E200E2B9;
	Thu, 30 Jan 2025 16:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 37F9E200E2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738249944;
	bh=tM2ZriC32/SfoOJpT2SXMIQO8un/LyqDVwXNOuePRh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bm3nWnc3/RFF00zHJOP13vGTCNGMiDT7sGIeX0jQj8MMAxanAhr9rSoE6ylxcd+ZL
	 bGP0jzYjZxdx5jZ8BmFdMaMfyvtkp6MotxRwRsrWX2YvIul/bl7mpMebmo+sNFlnZj
	 nLmWGG9ZABlUgN8JKl4tDl/0DoJwo4QOrpzsUOc2Y6LBZp/U6NFk/Ll1MKUabb7+Qm
	 gHBdUQ0dtWZRGbFTImWHagFY4GY5kp7tErFATbCK45vYgCeCOLLxmsViV4BMwbR9lT
	 askOLMQURDRGtOBiuva1iuP9Zf2wpWF8kqmIAZZjfsgukif/MYhyWQQ5XFtjxFm/py
	 jkf8pohlbNw6w==
Message-ID: <59f99151-b1ca-456f-9e87-85dcac5db797@uliege.be>
Date: Thu, 30 Jan 2025 16:12:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
 <21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
 <cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
 <20250130065518.5872bbfa@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250130065518.5872bbfa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/30/25 15:55, Jakub Kicinski wrote:
> On Thu, 30 Jan 2025 14:52:14 +0100 Justin Iurman wrote:
>>> On 1/30/25 4:15 AM, Jakub Kicinski wrote:
>>>> Some lwtunnels have a dst cache for post-transformation dst.
>>>> If the packet destination did not change we may end up recording
>>>> a reference to the lwtunnel in its own cache, and the lwtunnel
>>>> state will never be freed.
>>>
>>> The series LGTM, but I'm wondering if we can't have a similar loop for
>>> input lwt?
>>
>> Hmmm, I think Paolo is right. At least, I don't see a reason why it
>> wouldn't be correct. We should also take care of input lwt for both
>> seg6_iptunnel and rpl_iptunnel (ioam6_iptunnel does not implement input).
> 
> Would you be able to take care of that?

Sure, I'll send a patch as soon as this patchset is merged to net.

> And perhaps add a selftest at least for the looped cases?

ioam6.sh already triggers the looped cases in both inline and encap 
tests. Not sure about seg6 though, and there is no selftest for rpl.

