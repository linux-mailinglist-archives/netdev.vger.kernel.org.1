Return-Path: <netdev+bounces-218979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF801B3F274
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7964E07D4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7C1EE7C6;
	Tue,  2 Sep 2025 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYKCYMqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6E1FBC92;
	Tue,  2 Sep 2025 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780777; cv=none; b=AX7k4IyDXoNh2QpL2ArJRb3YEBqpb8i15dgzc+AszL7vDtCp7xECsWBRLzN0/Y21hzVuyqZXiXYm4xBLHrhsxsyloEtGXP9ztq/ggM65yvDsLFWFd07VUsi3ZejzpDUyyCp9RfSd7NWDcFVSzhN663Dn2RC6HWJiVMUF1QSnKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780777; c=relaxed/simple;
	bh=mHSgMB9hwtLMKBhBkQD/GZrUxZ3D7Td68ADn8lIzCvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzsleg8WLmb3/AuMEOrTRuMeM2uhDM/JCNMhNGsVdud4qCTRdDY87UgoW8ukP3sdaaGulFCVd78jer28WdpO/FvP0/WN5waEugKwp3WdMdh8XySWJNZDZ4eogypF9Lw3duF++BIfeyb85sNQ4p41lKMj458EY1/jzLacWhfg5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYKCYMqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBF9C4CEF0;
	Tue,  2 Sep 2025 02:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780777;
	bh=mHSgMB9hwtLMKBhBkQD/GZrUxZ3D7Td68ADn8lIzCvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eYKCYMqE41yABS5qwnQ2JQKCw8oTdn0n/ufejGACb5klkyRv4HD3eVpiKe45NJUpD
	 tcKeiyGQSFcJy/e/fbtDQVgk0UhIK5bHmDMYTNymnFpyZAIBb+dFLzazOHmNu0eX+O
	 Ng3eQPuNy7qfpV2ts+tD9JQLAClSh1DBvFlCOLMXHL3mDilGShEzeHnslXXzKgqHSe
	 oHSFUpLBy7iZ6GAlPyT95Yed3VGjxcj7f0WBv2IbfSCos4ssnav3repDH9HijXbY4Z
	 dWdJzYLdhcJ+OKUsoZq3noXFlYO78PXnuijHPuN9yG5v3IMm/WVXO6UgbuRyDrJXQW
	 rrbmPmjn8/+bw==
Message-ID: <7ceb47ab-81fe-4cde-a829-b7fd50d641a5@kernel.org>
Date: Mon, 1 Sep 2025 20:39:36 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] selftests: traceroute: Test traceroute with
 different source IPs
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, paul@paul-moore.com,
 petrm@nvidia.com, linux-security-module@vger.kernel.org
References: <20250901083027.183468-1-idosch@nvidia.com>
 <20250901083027.183468-8-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250901083027.183468-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:30 AM, Ido Schimmel wrote:
> When generating ICMP error messages, the kernel will prefer a source IP
> that is on the same subnet as the destination IP (see
> inet_select_addr()). Test this behavior by invoking traceroute with
> different source IPs and checking that the ICMP error message is
> generated with a source IP in the same subnet.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/traceroute.sh | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



