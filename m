Return-Path: <netdev+bounces-244924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD625CC2B43
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7EE53007A84
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388D342CA2;
	Tue, 16 Dec 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpPzb7L5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062283370FF;
	Tue, 16 Dec 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887207; cv=none; b=pKpVJQ/xRcte5/76qHnpHRSOgJDRJQk3QDpzP+rvBVnwicl6u01myE6mnk9MRUa1M8p7Gmi0C7ktXOGWXJP+Z/deFaO9AsFWj+/SOCDpqv0p3r/dfQjC6aBw9EfnCQawocyUa6CWyrbdzu2em3/sC/J0cjb+NWX1wQV3b4DV70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887207; c=relaxed/simple;
	bh=OSmZIBvCZzNp4tFldURHG3E5ldWXHq9jPwLbg+FB2r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEsOlLpPVp86wMBfXBJ1fZrs8mLkFFMCCVhW09fpVJ1XsWBhAJvJ3ptJ+ekieT481Xhw0Tvjx4hUeq0c2/+sK7jVE/Oabtxeu/J3nWOIcccfmKGq7OkeYy7GsVPGG/Yy9Kf+wDqIBfjuk5jLik9xFa2UvmWTTtx5vAVlV9+TOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpPzb7L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D3C4CEF5;
	Tue, 16 Dec 2025 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887206;
	bh=OSmZIBvCZzNp4tFldURHG3E5ldWXHq9jPwLbg+FB2r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpPzb7L5LUaopYsVpTdkKOxoAxVMGy26NDjHvpwPOdKwXlLfma9G4BVyFYCBBKxPt
	 LTNokEE7Gt3+sy5dx6/lcNtqRO8WNsJ4RJO3RreLCYGjNU2C0a4TNZN1ArBEkwwDYl
	 sxnfIxtS1qAAMPlzjhEbcfUS0ZepR8/kh9CCKfhBf9nevxxOkCdMiUAFhA4dyFX0k/
	 F71rlncq/vXsGozexg+5BBF4CcLil5Gi5m+pkTiMUgvmoT9BaKLWUReJbQxRjWzQjS
	 pirRVBfmAeqAKNoNgjBjIudhcANR6go76SR6l8ALgoqVHoZZcBLkUj7boMrHKXzWK+
	 nQYOWIbt8esfA==
Date: Tue, 16 Dec 2025 12:13:22 +0000
From: Simon Horman <horms@kernel.org>
To: Abdullah Alomani <the.omania@outlook.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: docs: fix grammar in CAIF stack description
Message-ID: <aUFM4sGfZglVPp00@horms.kernel.org>
References: <SEYPR06MB6523AA8FFC17D23FD3539A658EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB6523AA8FFC17D23FD3539A658EAAA@SEYPR06MB6523.apcprd06.prod.outlook.com>

On Tue, Dec 16, 2025 at 10:20:07AM +0000, Abdullah Alomani wrote:
> >From dca59dfe5e73f39885d1c65b01d8da115a7a2c22 Mon Sep 17 00:00:00 2001
> From: Abdullah Alomani <the.omania@outlook.com>
> Date: Tue, 16 Dec 2025 12:20:36 +0300
> Subject: [PATCH] net: docs: fix grammar in CAIF stack description
> 
> Corrected "handled as by the rest of the layers" to "handled like the rest of the layers"
> to clearly indicate that the transmit and receive behavior of this layer
> follows the same pattern as other layers in the CAIF stack.
> 
> This makes it explicit that no additional layer-specific handling occurs,
> improving clarity for readers and developers implementing or maintaining
> CAIF layers.
> 
> Signed-off-by: Abdullah Alomani <the.omania@outlook.com>

Hi Abdullah,

Maybe I need more coffee or something long those lines,
but the current wording looks fine to me.

