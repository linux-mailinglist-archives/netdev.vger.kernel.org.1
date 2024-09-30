Return-Path: <netdev+bounces-130536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB698ABE7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F241F215D5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA5198E93;
	Mon, 30 Sep 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbpp0W9S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF5198A32
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720298; cv=none; b=d+zxKRM4vxwgdEbKh/Nve1T/hEKkIFlzel4eNm82mZ0ACbonPiHFqIkW0C14gLqFc5ZUpF9pef1qoSa2oTkpYFHcgH4rqQDsUftmQL7rNUdvY2i3nGuWhWxpAhgiizV1JOSB/9lvjR9VP5/jmv1kt9tl6E8RFUP/O4v/yIpOd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720298; c=relaxed/simple;
	bh=ugAcFwF5Qf2sGF3Iziy+RozY7VSM4DsFL/LAIRiHLNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYlfN9RrF/pOG1iBXI/Kj0HQWGbyQQQeyUC9rjwwQ86U+gTD+o4RDEApLPsQKn+T+k92r4J368agFVEJpp7Z7nd5Z0fB1yGVUZu88a1Mxl7iIfkEb6cAUsopoI1ylvCV21hPL0mXvJ+Tg1h92WkYhZkQt9A0qK2v5/47Y6j2CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbpp0W9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B0C4CEC7;
	Mon, 30 Sep 2024 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727720297;
	bh=ugAcFwF5Qf2sGF3Iziy+RozY7VSM4DsFL/LAIRiHLNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vbpp0W9S4e0fp4Fv3Bw557WVgO9DXqv0CgyDcuGwyF4zQH4h/5knHXmHKHIcpDEMs
	 mg9U2NE+6RQFIkagDPpj4G+yENqmCixSxJhr0jkDFs+12OcmUq9VgvY3kynyBHdR9G
	 2rtLdKdh9cUI8CgQhhLz26psUax0w0EGZjv1TozMOLovh1smDlYu0ZWdKKnIneRQp7
	 6/V8+vlHDEsdNE0V+6tV4Yp4MWvn7zx13O3EH4CbynXRJblFEp9FzDezT3elwIy9JQ
	 uNMkDoUjzlW8/WpDRo16v6vnvwGb8JHNlVI5M5iz0Icd406vngKSCDclzcE4WIl/fh
	 Ro1vxc/XL9k9g==
Message-ID: <d3cd276a-b3b0-4ccc-9b51-dbedd841d7af@kernel.org>
Date: Mon, 30 Sep 2024 12:18:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <ZuQ5VNo/VUBWbqNl@debian> <Zvqrb3HYM3XogzOn@shredder.mtl.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Zvqrb3HYM3XogzOn@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/24 7:45 AM, Ido Schimmel wrote:
> So there is already inconsistency in iproute2. I chose the approach that
> seemed correct to me. I don't think much thought went into always
> printing strings in JSON output other than that it was easy to implement.

In general I agree with human strings unless -N is used.

While there might be inconsistencies across commands in iproute2
package, we can strive for consistency within a command such as ip.

