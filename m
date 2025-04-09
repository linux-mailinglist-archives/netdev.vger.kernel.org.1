Return-Path: <netdev+bounces-180824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A609DA82A5F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EBC9A05AB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70326B976;
	Wed,  9 Apr 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwmtdt3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61B26B978
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211013; cv=none; b=E4boUwA1RkmLacp2MCJp77/L3wRiGOcj4orhNMK0lKdl8MK5ZpSBso8ePXxX0EdtyQRuQO6wCvVD3Re1REnL3O2KakzZG1Zh5rV1rkj87uUawxezm0NSWSaG8nu07aPkanjfyFJx0pMrn8tmFOmgY+ixrsKSSI9hHzGBrDwRtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211013; c=relaxed/simple;
	bh=McySGIyKWlh7uBb2g8qlk+fHMYPcoozB+NZalYKPQhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWI4beNGH0oPYj2lRt1qO+JfoM6k0m3e9dsRIFXOTi9IHnVVyhcfyq4jnHIiB69L/ncKpXqwGrK0ppAzTzPVF7EYGXHoUFWI0/gV+yuAJXxiHI90XZtjKqU8Jc2H5W0FZ8xQDWNf8yjExLHAXWRzW82GTz+OpM4xnZ/SMFH+59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwmtdt3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C62C4CEE2;
	Wed,  9 Apr 2025 15:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211012;
	bh=McySGIyKWlh7uBb2g8qlk+fHMYPcoozB+NZalYKPQhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dwmtdt3P/I/4RU94KDiEw8QOgSqSdqoa3MBwBEJ7bjpQkJm1pF6aT84hX6nahyR03
	 bC5rqpIrr/R/N+fcw1R+/8u9nzhX0h/44zySTAZr6WiCCdLVTNY183zLz+EDJTYxFB
	 ob8osbIHs3m/6bbEpTjxQN4pevaM2Vpp2FU/DL6FI4K7PAY56btljXTDbrVLiuqaut
	 EA0CH1e5+UGvrCzARzmoo8ynI+s4a9fAFuGYLEt7CXAYeeF0WidMSL3GyiI9BAeacq
	 hV4ADwVKWLc5UtfyIPtQ095d/o+yz5Mz9QL6hCEEzcBPNh6fxOF+9snhvJnC4tKp0Q
	 bcpNaN1WkUjjg==
Message-ID: <a8742abb-2732-4866-9bf2-4d42410648b1@kernel.org>
Date: Wed, 9 Apr 2025 09:03:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: remove unnecessary judgment in
 ip_route_output_key_hash_rcu
Content-Language: en-US
To: shaozhengchao@163.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org
References: <20250409033321.108244-1-shaozhengchao@163.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250409033321.108244-1-shaozhengchao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 9:33 PM, shaozhengchao@163.com wrote:
> From: Zhengchao Shao <shaozhengchao@163.com>
> 
> In the ip_route_output_key_cash_rcu function, the input fl4 member saddr is
> first checked to be non-zero before entering multicast, broadcast and
> arbitrary IP address checks. However, the fact that the IP address is not
> 0 has already ruled out the possibility of any address, so remove
> unnecessary judgment.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>
> ---
>  net/ipv4/route.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


