Return-Path: <netdev+bounces-213366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06992B24C27
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920823ABE9E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0822E172C;
	Wed, 13 Aug 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU+4ck74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CC1E22E9;
	Wed, 13 Aug 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095693; cv=none; b=Q+igYv/G+joTJV55rPiobcDwOrmFcRDZaByoXIxwKN7zSLefJJDZuhGRP0PrD2BJqvErGE41nJofv4aU22qwnSAw0Xj7y7PJbwIf/7Le0tFEDS3dwd+T/X7c0xPOmuwyYMRHu3E9MTxh1OAc8GpL8wnq+NixCTcGGQdg1PjGpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095693; c=relaxed/simple;
	bh=9KT4Ptd/LkLHSPZNthcxtGmb/B9hmXvuWaBRPjZOEg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6yHHFnNdZk3JTKWD7ugRyxxLWUwhbem9yOsLivvQ8FU6PqfHCGcvBQeaL5Ve0/g7cZYM8jAwV/I3mJvyA0bZMxybC9bBNFwierKBw7UXN9GQ/U5ufZc00r7kKGJTBEnDoLdwYRrgnnXEKdwpzOzBIEiyzXWuIbtUKLdBLhNOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU+4ck74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830E9C4CEEB;
	Wed, 13 Aug 2025 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095693;
	bh=9KT4Ptd/LkLHSPZNthcxtGmb/B9hmXvuWaBRPjZOEg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jU+4ck74Tqk3bbtZemE2sPvQ3JUQJlqTLjbz40tZM7Yf0mPlK+9GGjxHd5PG/c9Qn
	 Fk6J5vEQLOz+3GK8HKArPmjlsK3PVlIVs/xvVOzOuPLjHytaIXkyAf7w40fLz0/0VR
	 tgFyhlIeeROTYu/K7kDOW8W1NSx/KxEzFI5bsarZoddrur3loLvtYm7ALhSWeqYEzV
	 NCqnfg5+7QRw41WYZQEqKt469z+ARCAhq56fVIqX7c88RRlnFzvB8e367HdnfiEG5e
	 97MfkYhorkSxIQuuUdIh1Do0/VmIaMYGsRNmUCXG7E9vwE90FEAheC2ODLW3uJwsBl
	 LpcejhUBjb5pQ==
Date: Wed, 13 Aug 2025 07:34:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, dsahern@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, jacob.e.keller@intel.com, razor@blackwall.org,
 idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] selftests/net: add vxlan localbind
 selftest
Message-ID: <20250813073451.159c5904@kernel.org>
In-Reply-To: <20250812125155.3808-6-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
	<20250812125155.3808-6-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 14:51:55 +0200 Richard Gobert wrote:
> +ip link help vxlan 2>&1 | grep -q "localbind"
> +if [ $? -ne 0 ]; then
> +	echo "SKIP: iproute2 ip too old, missing VXLAN localbind support"
> +	exit $ksft_skip
> +fi

Could you add a link to a public GH with the iproute2 patches,
or co-post them?
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-posting-changes-to-user-space-components

