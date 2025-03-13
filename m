Return-Path: <netdev+bounces-174687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7CA5FE74
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2E916E524
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEBD1D63E4;
	Thu, 13 Mar 2025 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asp5+VaO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458E198A2F;
	Thu, 13 Mar 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887854; cv=none; b=XxTxsfcw77uNBPLBKzqjBHtWpWHiskkCHThzuS3wPNuFRRIVwrCOpM7p+3tZllRYlgSoZ0KZ0/dgCi8R+Y7HRKPM/jaOMWO9Q/urzwdLTnDRURh2iNZroW575hJcQh58HWtWDtXgq/Pq3pZTqgNfN5kcOLuPNRr3SQX0s6zYBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887854; c=relaxed/simple;
	bh=pyDIdF9kslBG/jp6RjL+B04x11Cp2dTPBKYm0qXD7/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJogxv3ZmWKbDvldAmcG9p9TS8OHo8+g7LJTOhP9be9D3oHzQVvIfUcdboeDhq8NW6PwQoQD8uuKrF1iS7s9qQq+xySF/Q3NHmXg80lPS6CuF5eQfHJISbOgCN+eD1o6yfZZEt50Wi8Clg/1CHG18SB2x/RL/2nUQEJ4C2qb26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asp5+VaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852FBC4CEDD;
	Thu, 13 Mar 2025 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741887853;
	bh=pyDIdF9kslBG/jp6RjL+B04x11Cp2dTPBKYm0qXD7/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Asp5+VaOwgihAZkcelnEPfRe2BpdslUnWn4TotCm95fuxoM1ohZH4aI1X/ZuX0tl2
	 GMzlEpv1TYbd9NPEzLjpG/rVTxyhezqCFFrIcNaH59wWQuahgffBaS3Kq1MJHQ8NNm
	 cc1vHvAXIr2M9dtjqYlpKBpGV+Cf3YM2PN906dMd+NONSF8qTlBpNjiB5KdoFbcXHL
	 j5RCsNI31WBOgY0ZwtA7uLRCLhp49fNCKhlmCky/b9Ydd2vsFUC86RSrCxKxSa7U/0
	 5mqd+DAgq+9uOT3Rb+ZbrfUYMICRjNDVaYQTZWhKIEKyZ1qKH0dnGEr64R5WCPpsoj
	 +wugrW8mUIq0w==
Date: Thu, 13 Mar 2025 10:44:09 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] net: macb: Add __nonstring annotations for
 unterminated strings
Message-ID: <202503131042.F6C9F4CA06@keescook>
References: <20250312200700.make.521-kees@kernel.org>
 <634dbbef-d7c0-41ec-8614-efee824142a9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634dbbef-d7c0-41ec-8614-efee824142a9@lunn.ch>

On Thu, Mar 13, 2025 at 02:25:09PM +0100, Andrew Lunn wrote:
> >  struct gem_statistic {
> > -	char stat_string[ETH_GSTRING_LEN];
> > +	char stat_string[ETH_GSTRING_LEN] __nonstring;
> 
> This general pattern of a char foo[ETH_GSTRING_LEN]' will appear
> throughout drivers/net/ethernet. Maybe Coccinelle can find them all
> and add the __nonstring ?

I had that same thought but then rediscovered ethtool_puts() and
ethtool_sprintf(), which operate on C Strings and write out C Strings...
so _some_ ethtool stats are being constructed in a way that we can't
just universally apply __nonstring to all ETH_GSTRING_LEN strings. :(

-- 
Kees Cook

