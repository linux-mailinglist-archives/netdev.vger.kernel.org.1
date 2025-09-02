Return-Path: <netdev+bounces-218980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6BBB3F276
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 611744E1137
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3562848AF;
	Tue,  2 Sep 2025 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg4Kvjrd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945994CB5B;
	Tue,  2 Sep 2025 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780822; cv=none; b=QW0a7hwuixOf+qy57YmUiYiDjRpM1dukA0hAWj/A8NPcY9brKPUwobm1C7uTgPrax53Ci5ziSD1vdrFEk/qqcNEBoeBqXGees4RLxcJLVdjJdxXNyjc1gAg1PwmsM01xnFwl+MW3N3usjqrWCQ9a4GZ3Lr0qOVq4kW0or1g9hWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780822; c=relaxed/simple;
	bh=aI/Pn6uTIFqm4lMlSMH2SfMPTfj4NYGwZGF027PIO/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHVfOCWAT8hn3hdVRqkcN6T+nKyS6EwWy9sx5PxiZ+rJyaLZmXtoiAHUA3bQ6F0a/NWaKJU5GQ11MDOmKv1SRKVyAmY6+YP8MF0Edaqhq9Fo0c1GekUKqIAp4dfRlqxXjl7CNNv59pmfX3BtKa11p6+O8DrLvyeTmS/vwxIwlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg4Kvjrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C778BC4CEF0;
	Tue,  2 Sep 2025 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780821;
	bh=aI/Pn6uTIFqm4lMlSMH2SfMPTfj4NYGwZGF027PIO/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jg4KvjrdX63r/8TPjPNsI6BZsHTcta5C3UZvyAI2x7Gc5XeQ7nS2L3y+ABj4oUlGh
	 aklHzWd+dTQX0A9qYEiuNRdFzDV+DqDeiEaIuDu7VVfsoQPmcsJfo/P2IRcndlmW6S
	 mK5IoPWMhb1ULA3OZH+LBiY++Apo88grUavTd7Zc9EU08BrMWLRzNtvLfU6CRke2Y9
	 KaRBPcvqYZu8x6Z1+y026uqb64Q0f6Q27GmQ8Wb3ddUBT1B3Gy3Hd74c92WDVZ8RTe
	 GIwewNH6tfTXQ2aX88U4oJscgTGsl2Z+kVznf9BqZhmB4paieftCB1D1Y735ZIbRSk
	 4S9f4O1kuxcOA==
Message-ID: <19603dd8-54ab-419a-9d6f-b85155f22468@kernel.org>
Date: Mon, 1 Sep 2025 20:40:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] selftests: traceroute: Add VRF tests
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-9-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> Create versions of the existing test cases where the routers generating
> the ICMP error messages are using VRFs. Check that the source IPs of
> these messages do not change in the presence of VRFs.
> 
> IPv6 always behaved correctly, but IPv4 fails when reverting "ipv4:
> icmp: Fix source IP derivation in presence of VRFs".
> 
> Without IPv4 change:
> 
>  # ./traceroute.sh
>  TEST: IPv6 traceroute                                               [ OK ]
>  TEST: IPv6 traceroute with VRF                                      [ OK ]
>  TEST: IPv4 traceroute                                               [ OK ]
>  TEST: IPv4 traceroute with VRF                                      [FAIL]
>          traceroute did not return 1.0.3.1
>  $ echo $?
>  1
> 
> The test fails because the ICMP error message is sent with the VRF
> device's IP (1.0.4.1):
> 
>  # traceroute -n -s 1.0.1.3 1.0.2.4
>  traceroute to 1.0.2.4 (1.0.2.4), 30 hops max, 60 byte packets
>   1  1.0.4.1  0.165 ms  0.110 ms  0.103 ms
>   2  1.0.2.4  0.098 ms  0.085 ms  0.078 ms
>  # traceroute -n -s 1.0.3.3 1.0.2.4
>  traceroute to 1.0.2.4 (1.0.2.4), 30 hops max, 60 byte packets
>   1  1.0.4.1  0.201 ms  0.138 ms  0.129 ms
>   2  1.0.2.4  0.123 ms  0.105 ms  0.098 ms
> 
> With IPv4 change:
> 
>  # ./traceroute.sh
>  TEST: IPv6 traceroute                                               [ OK ]
>  TEST: IPv6 traceroute with VRF                                      [ OK ]
>  TEST: IPv4 traceroute                                               [ OK ]
>  TEST: IPv4 traceroute with VRF                                      [ OK ]
>  $ echo $?
>  0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/traceroute.sh | 178 ++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



