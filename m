Return-Path: <netdev+bounces-231702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DABFCC0F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E374EECA3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E58337100;
	Wed, 22 Oct 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAkYQlP7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCF20298D;
	Wed, 22 Oct 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145400; cv=none; b=iXD/MjeIZrkvWNnJLmbtoMmW3yBY9b3A7cL2Qwj/1uBVocULpYUO8XNJYRz+9NiZOs3vleJ3RsolmVtnYAg8Ukj1j8Ein6TjdCY+DCo3iie864facgGde2UVqRQmD6VuABW+/5tnwx9O1s/hRS3Awv6HLG+ftJRJHs9TeC+10FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145400; c=relaxed/simple;
	bh=43PE8M0hzAWJMhoJ7ln8LYZH7q1OfoO3v1seJXEgqYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvvfXIDRHtwst3HLH13o+EFph8q9bjrhgeulSUC3SXQtpFCTAT/SawDmmDmQYu2ekeM8OmHsxdjTD5n6TCiArfMMTsmAfl+HZMBpnewvFZXtuPLFDiVQt3ijtkS/kX7Za6T757naQVkngMJv/0rJG2FssPyTSGovJVDKZjqo3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAkYQlP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E8AC4CEE7;
	Wed, 22 Oct 2025 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761145399;
	bh=43PE8M0hzAWJMhoJ7ln8LYZH7q1OfoO3v1seJXEgqYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sAkYQlP7aXnsQmHfTw+e9pfJ1eCaCG5QjFRNy0Dhc0ns+j2Be9aKYEbKyE9rpNuKX
	 7eKU5nT7EXMtu3tmwKXFOpFue7Og6E3ts7cZ8r+J0wcx6PtFby/zllI/Vxy9myExz9
	 FhblmjfBwzKPbp8IN3UliGSu1SZwRW/6f27xsQuC7iSYEclenJDSNNnC8PxVD/jp4M
	 84yfOZm3k9d3ASaf7naWMswRiaU+k/VNM/3+3Q0yJ7e5L8loy9yNxqeA6IXxhR6ZxV
	 Emz6pXitApDPKGAC/0VBGubOjCw29vAAQjf5fVT3zEK3AuD/nln8SSuFEZ6DoauKIq
	 b3f+iLmN1TFaw==
Message-ID: <aa392bf5-c3c4-4a24-b8ed-a513f0ac093a@kernel.org>
Date: Wed, 22 Oct 2025 09:03:18 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip mptcp'
 inline help
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>, Andrea Claudi <aclaudi@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>
References: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
 <946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 8:49 AM, Matthieu Baerts wrote:
> @Stephen: while at it, would it be OK if I also add an entry for files
> linked related to MPTCP in the MAINTAINERS file?

please do

