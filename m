Return-Path: <netdev+bounces-224129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2CB8107E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4931C80DEB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8EF2F6167;
	Wed, 17 Sep 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw0CuCSh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B034BA44;
	Wed, 17 Sep 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126797; cv=none; b=JlDFyKN20i5bWJK1dyD3Kk/pKEU6IFMlbupDjzdH5l/l6RB3uMsIo08efvF5hdCFRMvCDBwQSS+O0+WdJJsWa0mufQ5TcjE0HALsGsDbqBdAmPr+I9nbF4kFD6DdV5WzD7ZpyuEKlmJIccrMigvIVD3c8zdl7VDwXuoAD+hGj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126797; c=relaxed/simple;
	bh=7Pq9Vkn3LvpDfUXp2KGV1ju+VyMgWYB99kGQLNzsa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E32qQ+84UIbX7sIQdTAtrEwnrXNSpsKjS9HVHCIOZ8aAa8h2euKh66SYTBkzG0cFI+o+kAloibkhQeaETBjW2QQOdH6sJgWqSbANd8fN3wbe5StYtp7IsqTzlUNtQ5/AosXpaVtionLqLe7t28GHmOFEGogW9KFfzRP8jV0QEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw0CuCSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D545C4CEE7;
	Wed, 17 Sep 2025 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126795;
	bh=7Pq9Vkn3LvpDfUXp2KGV1ju+VyMgWYB99kGQLNzsa7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw0CuCShDgulrp/D72QEtJJrtp/7HCHobvtz3nP34cdNcKz78+rCq/LA1AdZNMmAU
	 AZr1L+mUy7IZzl7kuXF9ueS2eyEszYspMtBDvnZ2O95Sk47zYWyNG+cZrvnBnRI97O
	 LniWxysAZbbBdZpEY/5/A0PeDCHv7V6ErC8YPik1RA4zGytNX7Ndgu4JJkZG6oUedi
	 /U/mMk77WzaFjsse4tmm0AHnqjPfbsDW1eZXlp3ocH3ikphHCKtVkEN76J7P33YOLn
	 Lq/MpuxceyhlViB0G+K0R/V9mgdEy6feN3smLXr0zHIXLkLPc5/i3CiqDyryfbm47o
	 5n5pg+nOixcNQ==
Date: Wed, 17 Sep 2025 17:33:11 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: wan: framer: Add version sysfs
 attribute for the Lantiq PEF2256 framer
Message-ID: <20250917163311.GS394836@horms.kernel.org>
References: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>

On Wed, Sep 17, 2025 at 08:24:01AM +0200, Christophe Leroy wrote:
> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2:
> - Make DEVICE_ATTR_RO(version) static
> - Split version_show() prototype into 2 lines to remain under 80 chars

Thanks for these updates. Sparse and checkpatch are happy now.

> 
> v1: https://lore.kernel.org/all/f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu/

...

