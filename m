Return-Path: <netdev+bounces-189767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20775AB39C9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7216FF8D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B981DDA15;
	Mon, 12 May 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1SESp5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28FD1DACB1;
	Mon, 12 May 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058197; cv=none; b=gUGA4tiNZGnGcLnsuMxtZii1GCXDA9ufvvBLZmCHHBDwcJzIB9u8eVqQqxVXyzapBaeV1v9pIv60LpOpRpbPmjSqvl+5QJHDEZ4qkDH4InNRp38hE5/cMS74a6/oht9XRFPJDcciaE/h3xBnF9TuUhzGtF04vRKbN87TcZtV6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058197; c=relaxed/simple;
	bh=MQnWZXOt3VeagkzKa+scnEm38B2pwWGNm5LGMTXihfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtlkrvIpsUrBsK34RblaWWvYaSYQNeq/mUm/BkrM1srXYD9DlGQwUlpB0yk5l8GdUYb2Y0CNbP8xCaLmmbADqtmzBKSAjOnpB6V5yXl0p2jcYHt85uI93QaEwLhZkkSoj4wb/LUBnv92oBRVtb97tUf2xDLNBf9DNgfDZag51Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1SESp5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC03C4CEE7;
	Mon, 12 May 2025 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747058196;
	bh=MQnWZXOt3VeagkzKa+scnEm38B2pwWGNm5LGMTXihfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1SESp5AmA97ixpKr6f7eVuYjLLfaSXnXHjUUVCaRJ23hXLazF+ESVZdiW2zV2f/V
	 UxuZIrSVrmoF+lPZ+Q1j66HS2shJR18jPtG8gkBr3ewPE4EyxSDQwD8u0IJbVAq2eo
	 G2bI2HOEwTn2FxoTXbITmN9KBNsPXYhOKVGtE2qbAn33ToRd2e6TSjp1r1gDH+J9m3
	 L08WHB17D+iaDCzwuVLMROYVLGe4q037FmO02RngTBRaLB+DHNyQt9j+TKxy6chNMP
	 wIHHoZp5r8I8dF/8Na1KIDIBcvDgjV3dKntSdGYhD8v2ODuTQUWZ2ekUE3VzKe72u7
	 G+eqIGTOjMmCA==
Date: Mon, 12 May 2025 14:56:32 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH net-next v3 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <20250512135632.GF3339421@horms.kernel.org>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
 <20250509155325.720499-4-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155325.720499-4-Raju.Rangoju@amd.com>

On Fri, May 09, 2025 at 09:23:23PM +0530, Raju Rangoju wrote:
> Add the necessary support to enable Renoir ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Renoir, use
> the smn functions.
> 
> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
> line (between the ports). In such cases, link inconsistencies are
> noticed during the heavy traffic and during reboot stress tests. Using
> smn calls helps avoid such race conditions.
> 
> Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


