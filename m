Return-Path: <netdev+bounces-161647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289DA22E3D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959443A47CE
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AA1D9320;
	Thu, 30 Jan 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="itNoMxTU"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790D1E522
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245140; cv=none; b=mT56vIwYoxM8mpznJgB7QFPN16I2OHjL0z0Ofk8D15lUVbGe1BuOUA0q9RVxxJT2W6yX49RXgR5G+KdxkajUIaglm+qKA1M06vVPnuBjes7qVCqCQcKLRFyrGOJDZxI07TNVcz3SI5HeDZ6aGX9aMpfB0DSZ4of6EhwhdFW5HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245140; c=relaxed/simple;
	bh=fVjb9yeMVsebXz+yPtSzwLPOp4bFcyc3u+qyD4HHACc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXTJgo95pdSGcdZV7MjM/X+8DT7UwCOOqWEsinMr8FYDDmlcAQFMT+XEB0rF2p54d8UEy6ESHTIJkRSNlBKzA4LFCdW8WcMytaeBh1T9TW6WlPu0Q/pVVK46TTR4qXzU1b7Ulw68ME9mQLUio7LwD63l5pm/EfyqTpNsd0pkCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=itNoMxTU; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 7DFEA2037D3F;
	Thu, 30 Jan 2025 14:52:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 7DFEA2037D3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738245134;
	bh=VJUa9xz0qtbPTaAWMiJ8Gt24o5V6NINA9pysCu/j/uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=itNoMxTUBFR8BFVPOdNDQgq+B9sN4pRocTlvsCAKKVJQUEWqWtc+6DeibKZJTPA/A
	 6bgnDzShdNDzRPFCHPxVHKpWVc1yKUt/P4UACDMeX9DaL6S7GFwxP4XOuSZfITXRef
	 5C1z6o5mT3hXduFXC2bMG3WQRqbx4F6F8P+TKI+dw7BzHJHSCfOoPFavyzAvW1uQxX
	 KNZkO2/61Za8oyuYqzFOEjKr/4hLOccy7EB+yaO35GxIn9HQ0ZoBHPDewGuQTB5shF
	 CMtwAglW4Y8uwIrbs8uuPctXMtP/X1TL3GppYdqs7InlEMY7cglhH+ZmYc902upFT9
	 zh6zNBtTHccrQ==
Message-ID: <cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
Date: Thu, 30 Jan 2025 14:52:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6 and
 ioam6 lwtunnels
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
References: <20250130031519.2716843-1-kuba@kernel.org>
 <20250130031519.2716843-2-kuba@kernel.org>
 <21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 12:34, Paolo Abeni wrote:
> 
> 
> On 1/30/25 4:15 AM, Jakub Kicinski wrote:
>> Some lwtunnels have a dst cache for post-transformation dst.
>> If the packet destination did not change we may end up recording
>> a reference to the lwtunnel in its own cache, and the lwtunnel
>> state will never be freed.
> 
> The series LGTM, but I'm wondering if we can't have a similar loop for
> input lwt?

Hmmm, I think Paolo is right. At least, I don't see a reason why it 
wouldn't be correct. We should also take care of input lwt for both 
seg6_iptunnel and rpl_iptunnel (ioam6_iptunnel does not implement input).

