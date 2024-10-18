Return-Path: <netdev+bounces-137118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 022329A46AA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA64B23F26
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23300205ACC;
	Fri, 18 Oct 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPLh6WML"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D7204F67
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278855; cv=none; b=iYilnC5hef1ty2D1xXhD3HGdPMz0qxWZiDfXBpO1JY8rlZucVQfUTW+uy0EDOkQQEilKkDZWc65s3nO6An4ofMuk20Bh5qQvFB+PiwgBMHNFF0ukWmEO26ZSXwtPe9LqS7oj3ckBFjJzxGErIH5iIIliY0Ezg+0fUh9MM/Go0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278855; c=relaxed/simple;
	bh=0+qGrMf7S7EPRsJyFWnS5LEBEOo8FLK2sRP+XYy5S1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVOMKiJHShz1/In8PO8aHI9/eB7NNSkXa6sSFWmmcBeOqWuAQlcoZ5hWp2OQbpDdm9kPOk4BWMumPZd29aHmIg1en8IkQVDn06D0AQxcj/TzUhZqFt602O02gZEi+MrjL/FaLuh4nD080LUV7MRiB7pBB76RQ3yyfsCQhN6LqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPLh6WML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1648C4CEC3;
	Fri, 18 Oct 2024 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278854;
	bh=0+qGrMf7S7EPRsJyFWnS5LEBEOo8FLK2sRP+XYy5S1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPLh6WMLUkTmhlixixs1CCU1ccICGEJrhLvnHmlw0DGC4srkdOVnfmV0dkk+4QIVU
	 jKj9WAod9XHB7mBIbUxjoVAIk1euyfaxsXX0juN+oafy92j9mf6N4HZTUDMjDidGWs
	 KwkshWvI3xaT3MDXP30uPvJAXu2Vt6Rfkz7sRIrcOVcfZsw5MFurG8G3XRDQmLMuzz
	 TXRLjSBQQt0peAJpR81Ve7rUOKA+h1RCOW8yLo54iftKyUTl4gIwcdqNevUMr6eSBJ
	 yqA16vYe2GA90B4KlZA5rpZ3MqVoZaqGPvatUconKeUbL2Uz12kn2rNtAm+Jq8iKV4
	 KPkN8fGqW8BIA==
Date: Fri, 18 Oct 2024 20:14:10 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: enable EEE at 2.5G per default on
 RTL8125B
Message-ID: <20241018191410.GY1697@kernel.org>
References: <95dd5a0c-09ea-4847-94d9-b7aa3063e8ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95dd5a0c-09ea-4847-94d9-b7aa3063e8ff@gmail.com>

On Thu, Oct 17, 2024 at 10:27:44PM +0200, Heiner Kallweit wrote:
> Register a6d/12 is shadowing register MDIO_AN_EEE_ADV2. So this line
> disables advertisement of EEE at 2.5G. Latest vendor driver r8125
> doesn't do this (any longer?), so this mode seems to be safe.
> EEE saves quite some energy, therefore enable this mode per default.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


