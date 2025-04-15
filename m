Return-Path: <netdev+bounces-182955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581BA8A70C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068C93A859D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CA221F02;
	Tue, 15 Apr 2025 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfeQupmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB62192F3;
	Tue, 15 Apr 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742694; cv=none; b=Rd4+K1tX+RJUe1n5e4x/nGsigwEMGuorgezE0GEltuEBC/WetnmsUg5HXHB6TFSaiJsMHdnnFHgjIyUCjDMD8fkiLo2ZkZxYGqSMtGvjV8Wu+FHy8kccuyrXtFAQevdSPOl+6whZLWZcudifjk0nyxv/jRXhHQcF1YEnmjF4S0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742694; c=relaxed/simple;
	bh=E9hxgTivB2lkgn4JdYd3GSlHepTasd32t0xeZ8qKIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajIstyxYI1LBwGmD9IXz64C/rTpRU2zZyDeLpEWX+qQlkWTucxImPRTzqkCPV/QuksuXEqbM9I/8E8V5sFMWEI4HCQePdWajz7OmmudvGvSTjOGHL+F7eifaF834s9JqpZS+/zQkTUPe156gPtikbDVmYeGFEL5dd1YXzODXvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfeQupmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63930C4CEE9;
	Tue, 15 Apr 2025 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744742693;
	bh=E9hxgTivB2lkgn4JdYd3GSlHepTasd32t0xeZ8qKIs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfeQupmYXxgBECCWF7MnIl+V8XmbleYC9JERkr6jy5eTuKmNFMV3jamdJP5mGIGfD
	 u/u2rlX66zM06Lpmmm+LVkiT63SNsv9ocw5BMl3bGFsshSNFxhTt9OWIjpIZZIVncC
	 wg+auG33IJ2TPmBupzju+H/P2j9AWU5ZzXN8CBKzZues5FSduCbBMXIKFLJN0HYBFZ
	 M/tkjMkz5vHvzy19T7jxWlgbdBHnhlUT2+u8mgYDu70Yk7U11qDFaXf23q7Vadz+0J
	 8vZEWvxCKK1zxqt5FD3Xa5VWnUivoHmte8T3M1ELwWP3ZRTiLMW18Og5P5g1MwTZJm
	 bEKhdQdoeQd+g==
Date: Tue, 15 Apr 2025 19:44:48 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, Veerasenareddy Burru <vburru@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2] octeon_ep_vf: Resolve netdevice usage count issue
Message-ID: <20250415184448.GF395307@horms.kernel.org>
References: <20250414091856.18765-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414091856.18765-1-sedara@marvell.com>

On Mon, Apr 14, 2025 at 02:18:55AM -0700, Sathesh B Edara wrote:
> Address the netdevice usage count problem in the following scenarios:
> - When the interface is down
> - During transmit queue timeouts

Hi Sathesh,

I think it would be useful to include a bit more information in
the commit message describing:

1. Why these references were added / why they are not needed there
2. Why this can lead to incorrect reference counts end up being incorrect
   in the two scenarios you mention above

Thanks!

> 
> Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>

...

-- 
pw-bot: changes-requested

