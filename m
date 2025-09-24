Return-Path: <netdev+bounces-225739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48FB97D87
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696ED4A2ABB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCDF1C27;
	Wed, 24 Sep 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui9kzHvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE21186A
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672366; cv=none; b=X2K2tGwf1ayIK6NM3zZZisWH1J7gT2X+8ANyjpbGiFYokyqtQUVNH5a0l7QutemiZdaRuhJmj8sLtLaDcYhXJU32zpQj+UgozHYal+qTpfC0CdPvXxyF3QwEjdVScGvmjDxvZMTW8CgJP797ZYfmbcqXLfZr8FyYsR85sIdxoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672366; c=relaxed/simple;
	bh=U9dA5sjT9U0JU/XHQm084guSqdXH8ZcqHi/ZZ0NUPss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCV8Dg3Wz6d3tgyzERz79sVCk5BXMQFMPFCpfhek7KBc9DdElpBtHMw70ZXpNTL4DfovIP3NPaedzTMal6PfdGBLdxs4z460/bHGP/vdpL9wCATTA+JRUzYxelN8+/52TTyuZ/QUe3y9lnjJQbyHgp+qU8Z7mx2ejFd4/N3EyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui9kzHvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF16C4CEF5;
	Wed, 24 Sep 2025 00:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672366;
	bh=U9dA5sjT9U0JU/XHQm084guSqdXH8ZcqHi/ZZ0NUPss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ui9kzHvshmStAyFZRtR65BGU7ytR1HIzYRx4RXGdlu8XDH+vjjHnbULpIa1dCZv4U
	 MNiUDKV6eILuZ0rzed8Dfwcu6RvyGvod0t6Y3kpfb2PMVeNvApFsAZQDcT/jBheCXY
	 6aZlM8gUyhApLFoAhih7l7F03pYW+hh/6bh36eHuI1f7qroNzFYeucK4l/WW09npGV
	 L/2qRlvv/wfiZI+NZR8EyikySiwLk6SWJwf1Q0uSvvW5BNHZH6GMbZhxyowvK/gid+
	 IKSb3jmSUZD1QpgMTJ5wWAWhaZXeT7wAA1+Oc1j79cn+mL22WuXUtah61dGIpgoEqZ
	 Ap09lsDrMIiYw==
Date: Tue, 23 Sep 2025 17:06:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <20250923170604.6c629d90@kernel.org>
In-Reply-To: <20250922093743.1347351-3-jvaclav@redhat.com>
References: <20250922093743.1347351-3-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 11:37:45 +0200 Jan Vaclav wrote:
>  	if (hsr->prot_version == PRP_V1)
>  		proto = HSR_PROTOCOL_PRP;
> +	if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
> +		goto nla_put_failure;

Looks like configuration path does not allow setting version if proto
is PRP. Should we add an else before the if? since previous if is
checking for PRP already

