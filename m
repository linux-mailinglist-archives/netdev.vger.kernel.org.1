Return-Path: <netdev+bounces-114679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5045F9436E2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC951F21339
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893E9154C14;
	Wed, 31 Jul 2024 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsuJyxHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A22381AD;
	Wed, 31 Jul 2024 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456643; cv=none; b=knXtQ3wrYfBNVQnWkxlj1MVxir6IwmPRrQm8sPlTwII9cuqb3k5+q/4OumciKCsJsu/DkRl3hin2BIcvjvsSWhZcmjuvrw2NgXyIsYG/g3QxQ6kChPjLknHqCYjkYWKXwP1UfRunKGBmtsMkB4KubAoEegeAHsrgB0vDg34yyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456643; c=relaxed/simple;
	bh=pqrXLePcqScmQ+5G42RA/IZo2oSMz4qVDmXGP/r+5lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knyeNEyH/QfD64GB0OoQVmeNhxBbueqtYa9mkSAMZUSYlGzpslCcUJYaFJfYXvE1oeD7GRq8+oTEU96lOlTNqE2ztvXYxsmnWc1Q1zGZJKt768oMtz6NHnc1NyVmSLPgGWBjndVEH4DH/GN6Mv4B6BtkwlmEzzanjAsrrqD3cWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsuJyxHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449E1C116B1;
	Wed, 31 Jul 2024 20:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456642;
	bh=pqrXLePcqScmQ+5G42RA/IZo2oSMz4qVDmXGP/r+5lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsuJyxHLxShd7MGhJKhtWBjt0PMjX2DDyca0RCGWYVY+bK0NUQkbDPL+OMtadEVPk
	 ptkgfNOYg4EQv+sQHpYoUbBI+Mhtl4w2qWQGzSxcR5OPB3+2XvP6re6VNe128qW4dN
	 5X7zpxdpg60ibWqcqS7X7s7/Bs6bekj9gW0i4bhZ4q26/TyIoIQbK5HVQnpnVfaGq+
	 kcs8ojl6zu7tDLyEKIGpV069s5xQib6SGY8ioWtR/7B/NnGQCW2JHZ/nDHluiREX4g
	 FyWaSFIAnKid4MTRsCmHTgKYdmNAMRMFvxQwK0Ez/destkUu67rhQzbHI2kH+2dYzs
	 jDkUMHjT537tA==
Date: Wed, 31 Jul 2024 21:10:38 +0100
From: Simon Horman <horms@kernel.org>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: microchip: move KSZ9477 WoL
 functions to ksz_common
Message-ID: <20240731201038.GT1967603@kernel.org>
References: <20240731103403.407818-1-vtpieter@gmail.com>
 <20240731103403.407818-3-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731103403.407818-3-vtpieter@gmail.com>

On Wed, Jul 31, 2024 at 12:34:00PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Move KSZ9477 WoL functions to ksz_common, in preparation for adding
> KSZ87xx family support.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Hi Pieter,

This is not a full review, and I suggest waiting for feedback from others.

However, I think this patch-set needs to be re-arranged a little,
perhaps by bringing forward some of the header file changes
in the following patch forward, either into this patch
or a new patch before it.

In any case, the driver does not compile with this patch applied,
f.e. W=1 build using allmodconfig on x86_64. While it does
compile just fine when the following patch is applied.

-- 
pw-bot: changes-requested

