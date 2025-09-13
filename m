Return-Path: <netdev+bounces-222811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4509B563B4
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3917FF57
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373F2C0F6D;
	Sat, 13 Sep 2025 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v+zyZQA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E012C08BE;
	Sat, 13 Sep 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805300; cv=none; b=mUHqq/ySaBJxv+SVtZV9Ll1EhF9nV2rP7i71/gLY8IMf47f4gjGQqol9ZoTHjy5IQqwXhJiMVrL/ayv8SVtttcc6VkDB3HSxaFMLueVYSg9ViCdXKYxAfOVnyCKAR1+JI+Vn7l09SU/KGz4cUBJGZacEaYKPW2/gfbXD67H4NAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805300; c=relaxed/simple;
	bh=hdvUQ1mYN4bd9lUCkvNBWXP9pwpsysgRgSzVxZsOjKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meXkP5COL4Z0YJOjqMEja0FHdHa0efIgYIO0BrCzQuW6HAIKZKQobFv28PhzwnRESDly03hVjee1YCsB/Ra5ARHEwrx+6jW1wNjykoRMSvvYU4/OCWDzcCvmmRzPdpo0iNMCsYl8rbzmnWK7S51SsiBnY4FJ8wcvgK7eWey6VBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v+zyZQA1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757805289;
	bh=hdvUQ1mYN4bd9lUCkvNBWXP9pwpsysgRgSzVxZsOjKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v+zyZQA1XpyrYDKPYVquDr3wzJSpMv6MVpylqIT9EIjBomM1zdQSaflKqiMY6SA09
	 CpqSn7ndm8yEBpWAUZLH8chwsd+9u6Geg/KkQFxI0cBAs6bBHGXvnhIS5Be2hZpPrn
	 dTSth+QMpUvAMlCXwlFWx4BHEXj1sHW16ED30MgQQDwhbzSJMwIR7Js/Q8SxX1eeeg
	 2eh11MlJW27R2MvdUCBDXgxvRtwcFcNjJSknUOUEMaCY57m3Y7iCMcbzwf7e20PAPO
	 RH8YS0wG9qOO8hVAWz9hd0cfa/6bUrgGmL+10kAO+55T8Q8+ujxrw+eEIYUo9lB5hj
	 YE1GF70r9zjYA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C68B66000C;
	Sat, 13 Sep 2025 23:14:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 8135920393F;
	Sat, 13 Sep 2025 23:14:40 +0000 (UTC)
Message-ID: <32fde530-f462-4ccf-99bf-7ee1e192b76a@fiberby.net>
Date: Sat, 13 Sep 2025 23:14:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/13] tools: ynl-gen: add
 CodeWriter.p_lines() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911200508.79341-1-ast@fiberby.net>
 <20250911200508.79341-6-ast@fiberby.net> <20250912172124.57f96054@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250912172124.57f96054@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/25 12:21 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 20:04:58 +0000 Asbjørn Sloth Tønnesen wrote:
>> Add a helper for writing an array of lines, and convert
>> all the existing loops doing that, to use the new helper.
>>
>> This is a trivial patch with no behavioural changes intended,
>> there are no changes to the generated code.
> 
> I don't see the need for this.

Ok, loop macros are only for C, not Python. :)

I have dropped this patch in v4, as it's not important for this
series.

