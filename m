Return-Path: <netdev+bounces-147164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ABE9D7B5A
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 06:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0327D281C16
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062417335C;
	Mon, 25 Nov 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Oap6IElE"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEE433AB
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513970; cv=none; b=UnWr4paTpw0FO28oTSoMWC1rxU4C9fYU3snjZwA29JoathwgSd2dlNQFGpTEmLPJvKP2bQQgeefPRi5xAIVGuiROp5p12hqG23XTNgYWef7sklMT3ev3T4uER6EA2z8+9NGteuX94fuNU2uDPDZoqlkCZqFlSco3vXI/rVIGghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513970; c=relaxed/simple;
	bh=4WG/X1FIuYtuTvCFDqTCDfVFdy1iEDmw3eMBNK7YSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpZTVWPk8K7VTRh2YF9XMqYU7D4hRMaopYbC//oEVIrk2ID+97jtq0Rtfnk2pCv7PRXFrl+oEAnBxtdT55fW7cbY0MHisNFxBPu7K02S+IZ/b6dydrmwwKEXVmUb//UmnOiNzgv2RvCQKSk2k8H+dGZOtfC6k5iwtPy2Gq+cu40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Oap6IElE; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GFCQYlKNBAqG/z7wUqvu2tKEMrJ75/oVjVnsc6Z6BxY=; b=Oap6IElEHi92Mvp46tBwR71ZBe
	qVcRBZVjss0y+BtH8Tvx7UuekFTFSJPGCq6h6p7HhrwX1RLAGQi685TPA2oajJWmcCzipzZEsSvvK
	3XW9CJ2mrTHxRHM4swUOLnSd82aQhOwig1rhX+pBZrq2gXS0t/BL+9GCKzIta5PrvCLKy8yYtPLL+
	d20Dw0JOrGfZATV9l7qQSeaCxiaKJIaxXFBXXxiG1tkP6U4seNtPSKRPXeYUdIRPT+dAIIppKJ4WE
	Rx60YcEdV4dN/x5209FNSaGZR8xozM80cj4W8yrz2WbbmhzieP4H6HnRv1WKjrkLq8jmR/7+fa7jw
	2xp5Y50Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFS1M-001TGm-1K;
	Mon, 25 Nov 2024 13:52:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Nov 2024 13:52:28 +0800
Date: Mon, 25 Nov 2024 13:52:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
References: <>
 <Z0O02AvPs664hJAa@gondor.apana.org.au>
 <173249179605.1734440.169960974865430595@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173249179605.1734440.169960974865430595@noble.neil.brown.name>

On Mon, Nov 25, 2024 at 10:43:16AM +1100, NeilBrown wrote:
>
> So please turn it into a WARN_ON_ONCE and don't allow the code to return
> it.

You still have to handle ENOMEM, right?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

