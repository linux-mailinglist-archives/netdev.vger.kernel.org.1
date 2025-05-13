Return-Path: <netdev+bounces-189934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E5AB48B4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB66B19E6E28
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A091146A66;
	Tue, 13 May 2025 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cELbEe6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9CEEA6
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099029; cv=none; b=ZcZfsykZ8UJ+dSxmA7TahEHNWM/uizlI5PukwkqNzcWkNHI6/B5DVoOTO+xeokpJaME9rfjgrvmxORB8mOgbQeMqiVZ/6i6k9j6S/X8YEAc/x8cDuezSN3xWaKSRaO0exkMLbmos/gBqPbO0ay7gdmBOQVNe6eld5eotp/3WbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099029; c=relaxed/simple;
	bh=tPIQJM+KGH9eyfaVIWmaSe1SjPpEc5FLRnCBQNHk9As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pADsWdmfv4j1Y1KlaHsP4StQSa8ALLzDRDCbCjV5amJr3SjDVPLoNO1w/q9rd+Iq/YXXSe1jIgM2AubeCEcpycnJJ259peJ+/bidbPHjJB0Sgt01cs9Cb7rgsd1Yai3sR/Ui3B4PmU3kk9ybIgA1bZN60Q3j9CCJnGETYZBIGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cELbEe6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4266BC4CEE7;
	Tue, 13 May 2025 01:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747099028;
	bh=tPIQJM+KGH9eyfaVIWmaSe1SjPpEc5FLRnCBQNHk9As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cELbEe6I/SGIufrn0/qlWkZmQ25QLGdSrK8CXYnx6qR9tXC+EuGl1H9fWqQKbuA0e
	 ogtEZUVjjhjt+T0rZsly8jP9vKrmFGI/kYQhTzPtTyXrhCsQvOzMlRHWdBIhEhZAKh
	 1WHjUzkUGjuiowQZFHXW7AeBxfKMDRj4REOYAfoDnqKpngi3wdISDveLeCQK9SwKV/
	 fWPVsWsBWZR3/ZtgqlEU7AH7YbB9v4MhrramnbbEgdWHGa8x/O/lMF4mu2f+kE+EYU
	 gkWBMww31a17CGLIQ5qyc6fXeJJvtw+Bn9cL8VPQ9ygbC0ASZ0jDETJ4Rz22zuzTC/
	 7WRjNK5KfaxNA==
Date: Mon, 12 May 2025 18:17:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca
 <sd@queasysnail.net>
Subject: Re: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official
 reviewer for ovpn
Message-ID: <20250512181707.1efe127f@kernel.org>
In-Reply-To: <b72564b3-6374-4a9a-9d3e-35d9d2742b52@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
	<20250509142630.6947-2-antonio@openvpn.net>
	<7ca63031-79a5-490d-b167-41cc5e53ff26@lunn.ch>
	<b72564b3-6374-4a9a-9d3e-35d9d2742b52@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 10:22:24 +0200 Antonio Quartulli wrote:
> should I edit the patch in my tree and append the Reviewed-by Andrew?

Not needed. Not being able to add review tags is just one of those
things we have to accept.

> While at it, should I add the "Link:" tag referencing patches on the 
> openvpn mailing list?

For the future patches this would be helpful.

