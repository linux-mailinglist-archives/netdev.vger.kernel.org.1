Return-Path: <netdev+bounces-202406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B813AEDC8D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496787A327B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F963257449;
	Mon, 30 Jun 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="C1E34arl"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BE242905
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285949; cv=none; b=UoSXE0BThATZWa7Mk5uUpcbTPJVEPzTG2BEtnXzV0EzGBHBk0kqF5kSvQsPX+sti9NFQBGboNho9mB2DWg1USvcL6vRPDM31FA233FwloLbeRiIIQ5cAFTaZ/hFfhYSVUbL9+j7rW68mcXXWZ/1fB0N4qh2Ju4uBAWt30/PFuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285949; c=relaxed/simple;
	bh=MfDak7qmsWfjx5D0h57kQeKOIrwh95ynZdEYOuMJA0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKER2ZGWjvio9A7Ozh8zGTJwcL99taaMf7A4ITL+ckxX1v2jq9gN4X6O1gI7LjcFsnmJKLkpZwKVKCJBc59yFBjot5hINrvBZDh6Ath2I54w86Uf9tnoXfSKGBse7VaNXqDHafgUPJekZ6RT2XhnU3CZYFHcmvO0kyrx0MHBXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=C1E34arl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qOXT5Qli8buRRmG80FBn9S5C6ZVxAGSJZybeyxUw7SA=; b=C1E34arlz+8fMTf/qvrGyLAVRM
	yp+lVAgQb48mR3H3m5h8RG2RmPLilA/JeTOg59o46h7ThItdnZi3AYZfdQMGJIugl2RemYQJliXQb
	rpiD6IfxVufwjJ00quwLdCZZmHy0BI16UJHD0eO9iIudJRoC3m2qmeYQuGKt0+9y7+XAIukhhsx3U
	54LImdPU8l8l+0VVo0LBepZJlX/+/oVjfj8oshh5R9WGxwOOnPe2PHMRwrSUkQ+zP0MUyNSvw6O7d
	b1Iz9HR63mFauRKxNURBLEkVLZHhKrJXulwGxSOzn7h+lnRZtBZK+EtdxmoTgY+I+vSooYgvmFBd3
	LZgpZy5w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uWDTD-000Pxo-0M;
	Mon, 30 Jun 2025 14:18:47 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uWDTC-0008FE-14;
	Mon, 30 Jun 2025 14:18:46 +0200
Message-ID: <cb0e8fac-b7fa-4187-bb4f-b171e466ee06@iogearbox.net>
Date: Mon, 30 Jun 2025 14:18:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] neighbor: Add NTF_EXT_VALIDATED flag for
 externally validated entries
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, donald.hunter@gmail.com,
 petrm@nvidia.com, razor@blackwall.org
References: <20250626073111.244534-1-idosch@nvidia.com>
 <20250626073111.244534-2-idosch@nvidia.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250626073111.244534-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27685/Mon Jun 30 10:36:44 2025)

On 6/26/25 9:31 AM, Ido Schimmel wrote:
[...]
> However, these flags can be used together with "extern_valid" after the
> neighbor was created with a valid state:
> 
>   # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
> 
> One consequence of preventing the kernel from invalidating a neighbor
> entry is that by default it will only try to determine reachability
> using unicast probes. This can be changed using the "mcast_resolicit"
> sysctl:
> 
>   # sysctl net.ipv4.neigh.br0/10.mcast_resolicit
>   0
>   # tcpdump -nn -e -i br0.10 -Q out arp &
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   # sysctl -wq net.ipv4.neigh.br0/10.mcast_resolicit=3
>   # ip neigh replace 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid use
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > 00:11:22:33:44:55, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
>   62:50:1d:11:93:6f > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 192.0.2.1 tell 192.0.2.2, length 28
> 
> iproute2 patches can be found here [2].
> 
> [1] https://datatracker.ietf.org/doc/html/draft-rbickhart-evpn-ip-mac-proxy-adv-03
> [2] https://github.com/idosch/iproute2/tree/submit/extern_valid_v1
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

lgtm

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

