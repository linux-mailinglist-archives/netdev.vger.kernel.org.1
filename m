Return-Path: <netdev+bounces-120975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4995B55F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E26A1F237CA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469221C9EAB;
	Thu, 22 Aug 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="L3gcHwfF"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7661FF6;
	Thu, 22 Aug 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330776; cv=none; b=hB5/uYxAY19rIsnaG164dVfsJJTX5/DVpl15iYWY9evOHqWE8KmminlYgaqSko87tLQV56jaGDqxRa4u94Bov+3vrb21fwB8b+RA7dBBiURv2psg5vDjk4WhbhI0NYYv9Vaex4uq1dqW/GsM02lTDG1jnkBdcIbVeZkc3DFWLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330776; c=relaxed/simple;
	bh=MBQxF+DA51H+560sgY7YI1YLAME3qquHIcCPVM8paLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VifjqMoZPaS/5IulaLCDyfwf9jFdK+APVYMCLxQTDYmm3LIoZ37YAxW5Oj6pUtIC1tylnDgIkLGsaB5xSoDWXmaaEqnH5MAKo32PS+Z5unndphZ6JLdzxD02wNU3+a2ua0884YIx/eJ2DAvuwhvpZrbh+BuWNN/v4EmoBbTqZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=L3gcHwfF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6C92D200CCF7;
	Thu, 22 Aug 2024 14:46:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6C92D200CCF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724330765;
	bh=U/Xs2IEh2Q8wbUfwhGGZ5/O1phI2v8h68ade9wrF70c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L3gcHwfFu/QGDepdrjzJGKIW03nnagGMCqQd+Yn6VpQQkNnXhhdGWcOzqpY5aPNPq
	 QcuhXKmTRf+oy+eu5I/Ff5X4FqEE+uwfuLbFj12HRjAqrYdUdnqI4Dc865mXC/NfQQ
	 OZq5inQ7bB8t68WNpi2PsFfFnJQshpEBmmB8dNWbfvzj7pkqn/h4wfCCND6BMatqVe
	 SUcMd6n39UceWm/0CYWaliXTc+WawKy0obfE4zF23IsICUsA5txqTgecUizm8SMJAG
	 TooI8d1EKVVzsVya7tj5T8y+mp9n5oa2K6tNWQimewSvQzg6OYhiHh3ahSEUG2I7pI
	 aFjXAaFUM8g+g==
Message-ID: <1856afd3-ba8b-4043-b332-7c6c797a760a@uliege.be>
Date: Thu, 22 Aug 2024 14:46:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: ipv6: ioam6: new feature tunsrc
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20240817131818.11834-1-justin.iurman@uliege.be>
 <20240817131818.11834-3-justin.iurman@uliege.be>
 <e15e5b9e-e392-4cf4-8620-9bcc375711b1@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <e15e5b9e-e392-4cf4-8620-9bcc375711b1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/22/24 10:44, Paolo Abeni wrote:
> On 8/17/24 15:18, Justin Iurman wrote:
>> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
>> "encap") mode of ioam6. Just like seg6 already does, except it is
>> attached to a route. The "tunsrc" is optional: when not provided (by
>> default), the automatic resolution is applied. Using "tunsrc" when
>> possible has a benefit: performance. See the comparison:
>>   - before (= "encap" mode): https://ibb.co/bNCzvf7
>>   - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq
> 
> Please note that Jakub's question about self-tests still stands off.
> 
> I think the easier path for that goal is to have this patch merged, and 
> than the iproute counter-part, and finally adds the related functional 
> tests (you will need to probe the kernel and iproute features), but 
> please follow-up on that, thanks!

+1, that was also my plan (see my answer to Jakub in -v2). It's on my 
todo list ;-)

> Paolo
> 

