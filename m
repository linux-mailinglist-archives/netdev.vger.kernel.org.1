Return-Path: <netdev+bounces-154600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3579FEC0E
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8C3A1583
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41CCDDDC;
	Tue, 31 Dec 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1V/gddp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EE17C60;
	Tue, 31 Dec 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735607329; cv=none; b=lA/wXebMTo4FDY2EGeGXjZFpy8TVVBlwhF19jCjpp3+slpHEiUSe34RZu0pP9hZjkcvItf5uFx11GPJfwaWm0zGEWBTkxWDjQ/PD5KA/DtOBWgWjxj7c3HG8N00FeQIfr4xUWkOl2BFd9W62bUbAevMw/pssWthhWB0ewk/3BT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735607329; c=relaxed/simple;
	bh=qlNJ02Wp2FHMpnlDjXdEMsGLDWhCfKLot6zdaDs++70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbGwbxUlpE24TAQz4VZ1PwPJcJQJq+43GZkY5tAs26uYNcnDHO5HKE6eal5pfe7EdsnxWaJVHjPZKMVkEk/sQwwUILfER0Tu4yKD2wRiBgI3jKkNR7Bsz/XaK5lbj6oMIn1CEo0x6i3PLhdD44DQ62dFXwcBkSOCnJLwUuQnEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1V/gddp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F173C4CED0;
	Tue, 31 Dec 2024 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735607329;
	bh=qlNJ02Wp2FHMpnlDjXdEMsGLDWhCfKLot6zdaDs++70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p1V/gddpPTRP+4APpBQ5q6r957wR6BObdzrSDPE4TcXtssyqrW2qcIvcuCz0+DTsz
	 0laqVoByhRFOzdu3ZVldcsoF6VL3Tduszd9x8VE0qvCdmyqTvKokM+XI6k8+M960c3
	 pTuut02s6IZRp3xlOPz7LrLKX5599yaql1Ygf37S11auOtJjHZD+DeL9xn9z1/uHDE
	 Gry5iYPK4AQGbrxe9HmmAd9xGCKvfhXlysuCoY3koU1pXcaE1j7FeXWa4D3JqO4rUt
	 KQ/flPsdtBnj2JP3QHTpxLHwraIO05FnptdNk5nkNntsAGpgkqoQTi++P/JzaxST6T
	 iDSUHCu0uedzQ==
Date: Mon, 30 Dec 2024 17:08:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v7 0/6] CN20K silicon with mbox support
Message-ID: <20241230170847.5d37ef29@kernel.org>
In-Reply-To: <20241227195427.185178-1-saikrishnag@marvell.com>
References: <20241227195427.185178-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Dec 2024 01:24:21 +0530 Sai Krishna wrote:
> CN20K is the next generation silicon in the Octeon series with various
> improvements and new features.

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

