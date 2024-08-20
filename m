Return-Path: <netdev+bounces-119958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD6957AB6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40011F21879
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D54DDA6;
	Tue, 20 Aug 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANUkiwad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893017BA4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115926; cv=none; b=rrDMes/bQkWaQ8a32ISpdtuz3qeoBxJbKr2R4Zn+YLH/DBpZK5UcDNEBwqQlEthjgAxvkoX46ZAzYoyBhgHFJ72UrbMREXYnEorhPtV45EOQU3m0eTPGajbG0VqSG70T2pZhcS/uP6A9dePPNrpvoBcsgaORY9hlWMJFYK9v/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115926; c=relaxed/simple;
	bh=hCGv++3PuwgAJQvKZoyoHkVU1uPxuJg8NmJSiTDFgB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atINJbLrudG0bByQsPfq6/GqhC8WTcW43O0qwrFsLnF/oQUu//o6CqPAAk7rvGB9Exh/reDjJ0hjYDvbto/4tSJahlBEybZXrPnG9xUt18MaFxtawfnkKpmvWoPFPEAk2/l0oMRDZ6EIyu1jvcGyCk+4Vzr3XJyu1iHryB+gOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANUkiwad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51373C32782;
	Tue, 20 Aug 2024 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115926;
	bh=hCGv++3PuwgAJQvKZoyoHkVU1uPxuJg8NmJSiTDFgB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANUkiwadbewg959FyvgXvP8d5RNaDa3kxOkvO3+Mlou0WU8hUtdPp8twZcLPskAD8
	 02qcFNkclL4+7Gawsq+3T/QmoWAQJhUeknqI5D7g90tUdll0K74aqvCzmU0k5nL9HH
	 9KdBmHtHQXz/PyzFfMuhRUL1urH4HRdzTgT8BAJXDm5Xm+53gfoEb2LtgxmmdHPx9a
	 kJKdfvBN1rVRuMRDDQ4UNSgiCmgYC+0Cd/Dc2v8jIpPdXScH3SVbcwSqVgigK2mG4L
	 4+kPLLzIaMJbuLTwKa1M0mp0ty8D1RZHzZv7Y0GMg7fKcMMabAnLbKfoE5qTs8f9J5
	 2/5NRxv8dvEHg==
Date: Mon, 19 Aug 2024 18:05:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Subject: Re: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <20240819180525.5996de13@kernel.org>
In-Reply-To: <ZsPqS6oFNpRmadxZ@Laptop-X1>
References: <ZsPXnKv6t4JjvFD9@Laptop-X1>
	<20240819172232.34bf6e9d@kernel.org>
	<ZsPqS6oFNpRmadxZ@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 08:58:51 +0800 Hangbin Liu wrote:
> > It's a hidden config option, not directly controlled by the user.
> > You should enable INET_ESP_OFFLOAD and INET6_ESP_OFFLOAD instead
> > (which "select" it)  
> 
> Thanks for your reply. How to know if an option is hide other than review all
> `make menuconfig` result?

If it has no description after bool or tristate -- it will be hidden

> Should we add a "depends on" for XFRM_OFFLOAD?

You need it in bonding? You should use select (but not that select
doesn't resolve dependencies, it only enables that single option).

