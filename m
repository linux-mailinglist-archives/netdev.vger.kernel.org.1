Return-Path: <netdev+bounces-191744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E077DABD054
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C83C18901A1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C4F25CC69;
	Tue, 20 May 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZTTTUCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393525C711
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725711; cv=none; b=Se+vZXMKB0Em254QQ8LhmdSM6bFtuEMJPxkLHZuKcIxOGtIV+mDDkpmFx9y6X9YmaV41RWazhG57E/r7AD+udMTF31XyaCTpg9lDlGIPUaP1cqiekGvy0z3V5BK5QdvKX6iczlF8c0MYta3TxChkS0rx7NRzStT6ls0xE8uVhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725711; c=relaxed/simple;
	bh=32yihOs93uERc4/SwYo6nfy6Cjmf0T9s2YGGY6GWtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffm7e3szSTiPaSKG0sKSbrRMxEBaHxGSRhUbE0Xw/0DORDlZB6tEz75+ng4co/X0x0A4Yo0r9keIQbBcZ4/51ZfOCKWP6Fd/ig4XBF+wqFwW5cjtjZP5q1HkndN2wm1t8PYVEgM5hiadJK5UYqZuWbKY+Vzlp7B/wQwiGq9NqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZTTTUCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9483CC4CEE9;
	Tue, 20 May 2025 07:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747725711;
	bh=32yihOs93uERc4/SwYo6nfy6Cjmf0T9s2YGGY6GWtik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZTTTUCTVfYdcu7s8dNm4brZ7C6jkJgbVDi/UtI9E/+U15FnVCUN36MSvTlZnxDhL
	 SUbigVquJ7S6idfOJSx4BUzvniPVpmhjH6fZgvSUuvMLffhPHfgX+viPx15TEZCkB9
	 YPdGfEXO8gIVDumLEQKeWhqtdkpGbFMqgkaqqsvp1qGoDlCABX8VLdsprTFD+uZ9xd
	 400EoewFnT/xHqQXkFWqgWoK2k1ktoLygW4tk3VlvAAnAz2ZPKqBAyrOrV/WmTIe/l
	 JQHyjJYIAYP8Lv8CMG2XwzE5w9npbzPFphsU4UgDimlSUZ0B6Y7Mz5FMbCCn4sDiml
	 c6fUhzyhx6PGw==
Date: Tue, 20 May 2025 08:21:47 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: phy: fixed_phy: constify status
 argument where possible
Message-ID: <20250520072147.GP365796@horms.kernel.org>
References: <4d4c468e-300d-42c7-92a1-eabbdb6be748@gmail.com>
 <d1764b62-8538-408b-a4e3-b63715481a38@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1764b62-8538-408b-a4e3-b63715481a38@gmail.com>

On Sat, May 17, 2025 at 10:37:29PM +0200, Heiner Kallweit wrote:
> Constify the passed struct fixed_phy_status *status where possible.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


