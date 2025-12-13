Return-Path: <netdev+bounces-244605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF4CBB456
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 23:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E323008FAD
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0314F9FB;
	Sat, 13 Dec 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC4vO/3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829781CD15
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765663357; cv=none; b=exW+4ekzJFkY1qPIfb4CJTf1oi6B62nj0EBtE3qsq9n9qC6boDX12t30e8uFwghFajWzctAhzjrHq8Lf4FmEq3j3uEc6cSqZxmeG3TyXVp4+6j0oUhDYP5YA0o5JChCEhPBTDA0wD83EFMHB4Be7Ej4DafuKqWUuiDz4lgTS4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765663357; c=relaxed/simple;
	bh=QoogjRvJoA4lsuW7Esl/JJPzJ5Y/WKpughynwpUYoz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqtCJOxgu9WBYDsQUkSOjqVp0+CBBWHLuOihk8eMNXcz7mP/ncZh6ekzWaS0jaQhNeOkL8+jafg0imUGpImpyB7+fdbuFmlQkPl/sujn0ZoNgfNgpR4nCVcfk0wjhd/5WagrwkmSNCSpmLOEnCHiFaWPqp7UGe0a9gsz1ojJsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC4vO/3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854A8C4CEF7;
	Sat, 13 Dec 2025 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765663357;
	bh=QoogjRvJoA4lsuW7Esl/JJPzJ5Y/WKpughynwpUYoz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LC4vO/3Ue4aDtHC7UHuLX8yNj4nXyp40CdFWp7fD7hdPRqrimEDzHNfCEHGfxFrHs
	 SD9aBkxnJjwbLMEhmXVpHJoD9UgNpbbP0JMOhzYaQFyIHA83yEKA2bTctQlSvmP8Em
	 p+d0rDtpr82vBckUkBRY91fNM/rH99n2RcWuXsOym9mU+lM47KU4Arz39YBl0lpdDJ
	 IE6ZfkVuFmGTKIr/sb5hqNAwLvOFFpkN5R/qo5UrGGbeer7ZyEuq/dA3BNwcommBhO
	 GvQ9QLP3JuLJpmp22PtV1mos4ye1VPgRK7XHOVfXr2AWR/Vct1eLMW8iTdTCmiqBG8
	 Luh/hTz055Xfw==
Message-ID: <e5d23fd2-50f6-4a30-ad27-ac99a8874b37@kernel.org>
Date: Sat, 13 Dec 2025 15:02:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: fib_nexthops: Add test case for ipv4
 multi nexthops
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
References: <20251213135849.2054677-1-vadim.fedorenko@linux.dev>
 <20251213135849.2054677-2-vadim.fedorenko@linux.dev>
 <willemdebruijn.kernel.2568c56f18788@gmail.com>
 <8cd00280-08a0-457d-a7c6-a88670595ce8@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <8cd00280-08a0-457d-a7c6-a88670595ce8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/25 2:26 PM, Vadim Fedorenko wrote:
>> There is more going on than just not using the group feature.
>>
>> Would it make sense to split this into two test patches, a base test
>> and a follow-on that extends with the loopback special case?
> 
> Sounds reasonable, I'll split it in v2
> 

any test case for loopback needs another one with VRFs where the VRF
device is the loopback for that domain.


