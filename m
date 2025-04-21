Return-Path: <netdev+bounces-184394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A344A95318
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C831895718
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDEC149DE8;
	Mon, 21 Apr 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAxEsE+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CD73176;
	Mon, 21 Apr 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247079; cv=none; b=Bum1LuEba9UdNbzaLduuZNV5rXxEjdEpYm4oLvCciDGbr7zkHtY5sIEJdnwuWKzp3uTaeZcJrzcChCNX25yjyIgkgB+CKCAvsoJYq8GxsAWUa0Ppgg+diBq/wCAzdjk+tS2fHB8S/FAex+Kel1nggiUNI3ntlCMPj/Gt0XDhI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247079; c=relaxed/simple;
	bh=qlidngtCJMEboR/bt+eBIMGXwEXRZ5PKwOOVfEB3Mvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro/COJzWat5Ex90HbAJPOrxYTz+ADGFbTcDhHw493uqZ5LlDae7I1svYNLBQaLLT3PRL90rX7eHq4Pwop+onfHF72OTZfryyiCYxuqX1OhaU+x9JlvsIsh7q7/08acCICJ8vZ1xl2NobCWpylURLZ90rvoN3niqyRkUfYGXTuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAxEsE+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D6C4CEE4;
	Mon, 21 Apr 2025 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247074;
	bh=qlidngtCJMEboR/bt+eBIMGXwEXRZ5PKwOOVfEB3Mvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAxEsE+GqdrcNZpWf47aMrDzX5z8R58ATSFOX07TNQzf6oHaCYGiicV8swOLymBz6
	 sFapcp+CR6aK/uG5w/jRuDMfSidfXt045z07BaAHTzIBBSPiENaBsNFnclIW1UQBlx
	 1gxsKX+0wQyp33jS0llRYOcpUIJBV1f8o9akFAOKBt1pRSCRtFvbv7nF+BMQBSEwfp
	 6IU0FH0smoNQ2XgNS2eaHwEIRDXQcm43wuuHPnym8VQmkirIc0mmxN0pkznS5govNb
	 HxVAEsn6yh6k1KVBVYmieaMc/dM+Uw8f+TuOU+ByALhU5tIzKvFij5BpypCOfVMgFS
	 HCS1BhAqBbyGw==
Date: Mon, 21 Apr 2025 15:51:10 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] emulex/benet: Annotate flash_cookie as nonstring
Message-ID: <20250421145110.GO2789685@horms.kernel.org>
References: <20250416221028.work.967-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416221028.work.967-kees@kernel.org>

On Wed, Apr 16, 2025 at 03:10:29PM -0700, Kees Cook wrote:
> GCC 15's new -Wunterminated-string-initialization notices that the 32
> character "flash_cookie" (which is not used as a C-String)
> needs to be marked as "nonstring":
> 
> drivers/net/ethernet/emulex/benet/be_cmds.c:2618:51: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (17 chars into 16 available) [-Wunterminated-string-initialization]
>  2618 | static char flash_cookie[2][16] = {"*** SE FLAS", "H DIRECTORY *** "};
>       |                                                   ^~~~~~~~~~~~~~~~~~
> 
> Add this annotation, avoid using a multidimensional array, but keep the
> string split (with a comment about why). Additionally mark it const
> and annotate the "cookie" member that is being memcmp()ed against as
> nonstring too.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

I am assuming this is for net-next.

Reviewed-by: Simon Horman <horms@kernel.org>


