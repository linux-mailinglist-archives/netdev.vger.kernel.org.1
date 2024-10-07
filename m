Return-Path: <netdev+bounces-132809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BB99341E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB21C2344B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA21DBB3E;
	Mon,  7 Oct 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RugleReU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD071D9673;
	Mon,  7 Oct 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320053; cv=none; b=KQ6z4N/l8zD/fBaHO+CfDXDY9l0SSWex97fAfDabz32HpE93yeIfejnr5GI5heLHyPjv2Acfu6NZ49XjbzufjkTWS2OuvdYQuoz1XTS7kg4Y9SWamgDhSNxIfPfjK7Qtl7/ypYg8iuVDXhl7n6vJLZ9U5zCyMUlfDzZS2nHO6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320053; c=relaxed/simple;
	bh=Z55+alHHbN75NJWr2PUTisn4u0T5tliMseWxml0Kkis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2d/xSW8/UvW7B/cHQ5otXVOPvDnTfwZeJfR/u5jR8Z6pFuHcypwk4C94vCwxO0H1RFAvWv9fQ5PGErZKkeof/zP4hX/EpeB0gB9d0ELUKwgsMW82cUbUv6qI++YZvE7maCDCxteR19tULLpu4BdaE4wRclWyIRenClWC51tvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RugleReU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E6C4CEC6;
	Mon,  7 Oct 2024 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320053;
	bh=Z55+alHHbN75NJWr2PUTisn4u0T5tliMseWxml0Kkis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RugleReUCcPaIBW6jMPb3QzJw6yIz+PPaz8YuCS7xqA3FSP1J6BG7vMaa8QQGkAo8
	 umXBPeAJr3M2+XOF6dg3UE4anqoP/B4ofUpaeY+Z/eXzx3C6iPdp38UHiKa7RfZ77h
	 NmPcS4xYTjrxPuIAF/PEM9hW7jPEJoA+7B6vEXNX07Oio7e6YoAx+N4M7eHTJRNGZW
	 aCR7CEkU9NBKBlufd6Wd14bmmyZa+vjIcW6eps7LUiNc/Hlh6ZPUvE9TzWEZ5FTvwU
	 4LWRIZIlg7547A7OEvJjRAgsvQkpkjPktPa0Nj549kh0lCpKlF6Xb7RjMADFGP15cF
	 p/7WjScPOJEvw==
Date: Mon, 7 Oct 2024 09:54:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241007095412.5a2a6e2c@kernel.org>
In-Reply-To: <20241007161501.GJ32733@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
	<20241007082430.21de3848@kernel.org>
	<20241007155521.GI32733@kernel.org>
	<20241007090828.05c3f0da@kernel.org>
	<20241007161501.GJ32733@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 17:15:01 +0100 Simon Horman wrote:
> > > We could merge or otherwise rearrange that section with the one proposed by
> > > this patch. But I didn't feel it was necessary last week.  
> > 
> > Somewhat, we don't push back on correct use of device-managed APIs.
> > But converting ancient drivers to be device-managed just to save 
> > 2 or 3 LoC is pointless churn. Which in my mind falls squarely
> > under the new section, the new section is intended for people sending
> > trivial patches.  
> 
> Thanks, I can try and work with that. Do you want to call out older drivers
> too? I was intentionally skipping that for now. But I do agree it should
> be mentioned at some point.

What is and isn't considered old may be hard to determine. I hope that
your existing "not part of other work" phrasing will give us the same
effect, as there's usually no other work for old drivers.

