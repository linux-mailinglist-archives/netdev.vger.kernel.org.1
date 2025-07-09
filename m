Return-Path: <netdev+bounces-205351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBBAFE3C4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124E34855C8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BB283FC8;
	Wed,  9 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx1eYhhl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A3280CEA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052331; cv=none; b=hUXsMRTE0842EhgPT/pBBB4/x9GHjt+Gn4VkDqEEFCpYiGryRr1aJJUJ4BKMZdLjFcrjVKt0bUWLmRWxd8rhTorKCDB94jLBrlWJoTbJx1fKQuYMDAfv4iwJLT8Ig+gkCBjekAlg0i3lL+Mfb9h6U4jq4eIa9BIDttaORDfb/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052331; c=relaxed/simple;
	bh=iCMreI1P58on6yLzfq+d06jpOSmWxTc08g3IBBkN/zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRUC7oz9BZMCNDa5IZTLrBrZFpLPGF+pJi327/qNsJ/l2IyyS0UuItl+buwLpqlka34wnpVkWhJvGqan/40Y3IT6kgQysoly9GEt5G8caiaCw5I9tRMVprEe0v6jZ6Cnao0t7kUOcyLrQ3zOemiPlS4jlRHBsDDZPVvsqVXvgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx1eYhhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD9BC4CEEF;
	Wed,  9 Jul 2025 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052331;
	bh=iCMreI1P58on6yLzfq+d06jpOSmWxTc08g3IBBkN/zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vx1eYhhl3EAKY7vKxnuZ/j3yomjUhqau27LBDMUHS9AbLMJAWj9ebkghcJ6fpQzcw
	 qBuSUsUmx97HaLlmwCF2TfckiZLwRyMSaplj7Q8vjFkiCBZASI38SYv85s+0P3P8yF
	 YHwyB5bryRSx3Lm86yF5H/129MNQUoAZS3YJsycysrVBfV0uWWn/rLgs2SDJvomNOb
	 q066+rhBemM2c6ekfGpaeXjB5QOy7rChmsUxPbOt1LbJ8X9FZHnHLJ19Lgy3xXyMyC
	 lvVbIBrM7npULfjMy6d1ObPxGmz7mvgInVjgGIoSJgyfnH+qVo5plFlMhBG1vBkNDE
	 J9OTjglPeVpnQ==
Date: Wed, 9 Jul 2025 10:12:07 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] net: mctp: mctp_test_route_extaddr_input
 cleanup
Message-ID: <20250709091207.GR452973@horms.kernel.org>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
 <20250709-mctp-bind-v3-1-eac98bbf5e95@codeconstruct.com.au>
 <20250709090311.GP452973@horms.kernel.org>
 <b6f1f50490db59454bca1cbe8edbf4ead85c7383.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f1f50490db59454bca1cbe8edbf4ead85c7383.camel@codeconstruct.com.au>

On Wed, Jul 09, 2025 at 05:06:44PM +0800, Matt Johnston wrote:
> Hi Simon,
> 
> On Wed, 2025-07-09 at 10:03 +0100, Simon Horman wrote:
> > > 
> > > Fixes: 11b67f6f22d6 ("net: mctp: test: Add extaddr routing output test")
> > 
> > Hi Matt,
> > 
> > What I assume is that commit seems to have a different hash in net-next.
> > 
> > Fixes: 46ee16462fed ("net: mctp: test: Add extaddr routing output test")
> 
> Yes that's correct, sorry I missed updating that.
> I'll fix it in v4.

Thanks. Stuff happens.

