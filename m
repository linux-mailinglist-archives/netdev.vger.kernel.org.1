Return-Path: <netdev+bounces-120976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9395B570
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F91C20A79
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00FC1C9429;
	Thu, 22 Aug 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="PIs7uBBE"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA81DFF0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331190; cv=none; b=IDqlRay4kpAkmeeCDWfxlL5qX0GvyXbZbPORCWrdq5a7S02o1z07unUg8I7Q3CUgwWzi/9znlf0YWPPz27QKlSAljglPaK+99O2w1OEKlsGr0sOZigs4S450XPr/Li9OMnhKy1HORZEFBdLtWl4HeY/PpEk8joaqbgSMhkEVaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331190; c=relaxed/simple;
	bh=1mW6WINSSOiYsPator0FZLhv869rqNEWBydZVTQAhMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjOAPd/CxSqXiPxTnv/t+9QsWK1OG5A0cn52t5zR8fSpWoYCy5I569AxuBNEL1i3meZfi2ni008oBS1ZD6EnRVQ/Tb4IO1z2ss2YWMMgAYwqVBkwaQI9+ur/+52zQfSxlxYGKtyrm8rB8hR7UDyXsLg9rYw689XGGeycF8XC9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=PIs7uBBE; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D3EEA200BFE9;
	Thu, 22 Aug 2024 14:53:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D3EEA200BFE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724331186;
	bh=eiPBYzokVNyq721g8x+SMm6qLnz/b5uV4l+NaL+SWyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PIs7uBBEbHmc6FVGvSi2Uk40E8qtZ6rdTcfpaZi3lSBU9D2tqVyb9kTX9SSKzo54c
	 Di/MaP2+z8lqVQPc5fDwBD4GTbZtGJeAllRo57DCxJZUx7eNql4Z7f9Pc6W1RqTTAq
	 RdSB2EmUdmmzmsJLGgzyRTbd1EIrMDCPtV+XRcq9ve0HJCcQjS+oMX1csmUrFiTeyV
	 +SAaam6/mIgGdRa4cbFYuq4snkqW22obNQYjJOBFi+l3YBZhiwGcvXofuDDfnXbFTY
	 JEDA8n3d/omqCbYKLV4+4lCE3vpafzq9JPSOIuinNrA8NBT4e6DudHWTzouDouwlZn
	 ByQeNUt4fCZ3A==
Message-ID: <16dab47f-cf52-480f-89d0-df5ca474ae57@uliege.be>
Date: Thu, 22 Aug 2024 14:53:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/3] add support for tunsrc
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org, justin.iurman@uliege.be
References: <20240809131419.30732-1-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240809131419.30732-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 15:14, Justin Iurman wrote:
> This patchset provides support for the new ioam6 feature called
> "tunsrc".
> 
> Justin Iurman (3):
>    uapi: tunsrc support
>    ip: lwtunnel: tunsrc support
>    man8: ip-route: update documentation
> 
>   include/uapi/linux/ioam6_iptunnel.h |  7 +++++
>   ip/iproute_lwtunnel.c               | 40 ++++++++++++++++++++++++-----
>   man/man8/ip-route.8.in              |  8 ++++++
>   3 files changed, 49 insertions(+), 6 deletions(-)
> 

Hi David,

Apologies for sending this series early. Its associated net-next series 
has just been merged (thanks for waiting!), so this one is now ready to fly.

Cheers,
Justin

