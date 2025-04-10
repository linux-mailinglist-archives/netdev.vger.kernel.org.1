Return-Path: <netdev+bounces-181348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB6A84966
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11773BA707
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94981EDA2C;
	Thu, 10 Apr 2025 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="DM1rEQOJ"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8981DEFC6
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301808; cv=none; b=rCksA4qEFSQo6OAagbnAir/ak+uiZ9XKm9CFUgvmsIR6ftLKAhSYsZENwsZsldLnsqpi5VtemU+s74gGuenhkWHuYD8W3qr0DS8yuQZIyBfTS8Tv9OaXPQu4w3TGHUdToU5r3KZjBKuKvRygok0d49ifayuKvdisVC+sWZuK7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301808; c=relaxed/simple;
	bh=rOcp5slA1igBxXP65k4QkhGet9n8Z5i2uP+Zgc+uwR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkyaOWYtY9iVVLAHFFsPc4wfph42IjxsrCaAKgDEf0RmHFaGxzrwxMRbSMeqEi6Xx4BH4hI9Gy4xS+5tHWuitRIy37vGfCCHNwDStPHcr6u3JikNZuZy3XU3Q1lSa2bjNxmkxKmlbfKgZBCwXvSoeDwFOhjLH1d8IBJiH287XL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=DM1rEQOJ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 710E6200A730;
	Thu, 10 Apr 2025 18:16:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 710E6200A730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744301802;
	bh=+t4YwfglD6ojBVFuopgO9uS3BQoi0GCZe4jx2qHfoH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DM1rEQOJ3wXROOmAIiGpnFc61YSvFb9au/YPXy4KVigz8WAP8uE/VQxefkqroMaXT
	 /PNpSU8J39zzyrLKzcwCXSezfxOBDiLCON8t5Q9T76zuWUuj5FJb5TiANtul7oIRw7
	 y2LuQsZw8iScv3zJOZeDOV5tg8CuNl+8bGGRoLqJmVhiRl8RP1CuD9bTfKG3jo+KLW
	 skFAg+0NJJcNOeSnAQjOf52RmVsbRHJXrlQupGkVhAj4TNoQsrbYg+JBtxVRODtuN2
	 OHLwjmtc4Ild32bx7gIzdgwjyJHtBE3cZlyKAgmkp7CG6aKST1JlBcOHrPQ2N/W2ja
	 zrgIJaHdK8ExQ==
Message-ID: <046af9bf-6693-414b-9c65-1a1f982a66a6@uliege.be>
Date: Thu, 10 Apr 2025 18:16:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ipv6: ioam6: fix double reallocation
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
References: <20250410152432.30246-1-justin.iurman@uliege.be>
 <20250410152432.30246-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250410152432.30246-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/25 17:24, Justin Iurman wrote:
> If the dst_entry is the same post transformation (which is a valid use
> case for IOAM), we don't add it to the cache to avoid a reference loop.
> Instead, we use a "fake" dst_entry and add it to the cache as a signal.
> When we read the cache, we compare it with our "fake" dst_entry and
> therefore detect if we're in the special case.

FYI: double reallocation also happens in seg6_iptunnel and rpl_iptunnel 
and was fixed previously. However, they don't need this patch, since 
it's for the case "dst_entry is the same post transformation", which is 
due to pathological configurations in their cases.

