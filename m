Return-Path: <netdev+bounces-243070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9DC99308
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A274E21A9
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB82773EE;
	Mon,  1 Dec 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="C0rKoo9Y"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7391E3DED;
	Mon,  1 Dec 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624957; cv=none; b=g3JyTBSfPrCCSI3frbjxPDjVLEkXcRIvMhWcXkl1B/9xEEwumHJP4acxDm2KuzSrhErO749lMkYPjioHW1AIQ15DYt6YaSzSUkKdaVPQYQxqDE7IrIFT8yuhflWqnL5okiRV+/6a7qeZLdFZX5U9DGvJmYysqt19vQLn41XMm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624957; c=relaxed/simple;
	bh=GdjaPXWV3ue/nmxT7gBPKUaIdb7nZYUxca2XfeKI1hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8TJ9JtLvi3X/TN5YQ5AHR+ovKyiQhqmQ3yg9gWs+7A9W4sGP3tVf66CfvAlEsLhPrWil1RWEE1Q9ktPCJW8rivjaCgs6adOeHfMo8YDXzulpsNsnNaQ6LMcfDmF16KxBu4uWBnvyMJrcOPpqMnuGfeGSXmPGu3FxdD6BZm0Mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=C0rKoo9Y; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id EE4FDE7D;
	Mon,  1 Dec 2025 22:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764624951;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=VHi2Hr4GrF1rqu59ax7ERJ3TpoC4BxHIGd0SiRUEKvM=;
	b=C0rKoo9Yt2TNzr93AQwpsx0NeDcu63Zc2RSYtM1DHESisEJ4Hi6Y236UHkn52Ok6
	tQ/ZzFrksrDmdvY1dV4Ie8Rsxqt/i8Nn+2DlWCEscCRp04qk1ALJa8xyh6drFWz5Fjg
	75vbRwJZkvTGeZK/lWxCWNT8/lova2lr4fnQMNcM=
Received: by smtp.mailfence.com with ESMTPSA ; Mon, 1 Dec 2025 22:35:48 +0100 (CET)
Date: Mon, 1 Dec 2025 22:35:46 +0100
From: Clara Engler <cve@cve.cx>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <aS4KMnhel3KKSbw5@8ce485d24aa0f711>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
 <20251127181743.2bdf214b@kernel.org>
 <aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
 <20251128104712.28f8fa7c@kernel.org>
 <aS3kX7DApnSfJtT9@3f40c99ffb840b3b>
 <20251201114025.1e6aa795@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201114025.1e6aa795@kernel.org>
X-ContactOffice-Account: com:620022785

On Mon, Dec 01, 2025 at 11:40:25AM -0800, Jakub Kicinski wrote:
> I see. Sounds legit, we can adjust the error msg per you suggestion.
> Unfortunately, we just entered a merge window and then there will be 
> an end-of-year shutdown period so you'll need to post v2 in around a
> month :(

Alright, will come back to it at the start of next year!

