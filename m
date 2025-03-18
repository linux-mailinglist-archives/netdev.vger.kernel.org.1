Return-Path: <netdev+bounces-175870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479ACA67D50
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F6E19C2756
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF81F09AD;
	Tue, 18 Mar 2025 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPCXjgXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3E17A30B
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327344; cv=none; b=XLje7/wY2Pn+sQkprJ6nC+Wk34h9ax2dm1kHRgEcgj9LkFT3x9IvAZVkTU4OG1k75i6Qd9B+YUHf1Vh8L0uGFmDRfxSkbi5im9VMGT1LBSM/bKvotVqEyydWWvRTE8Ln/d5sRDv1kpWjvunrsVUViU+FShOOWesLXnS+sJEz/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327344; c=relaxed/simple;
	bh=jV17abQ8YdFTApxUYj3aOFlWpaZrga/D/FQFRgxk3QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfS5KXTzoaQvr+yqy2YYCNsatpuOtS5SkUBEtwboIewuJCndd0OcmsML4rQ0XPO7MR+ae8WUL95lXBkQSbELv7bKOnCST+hhGlmfQWhDKlgUUkslAfuv/ACA/6HRIsUOIELs0h6BoNmC0aGqcLBGaBG2T+a+mzDs/8YlU+YxcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPCXjgXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5569AC4CEDD;
	Tue, 18 Mar 2025 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327344;
	bh=jV17abQ8YdFTApxUYj3aOFlWpaZrga/D/FQFRgxk3QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPCXjgXDb7cNpG0wHcMyDzRPPu/Fm4TBkTu9MeegjNOqW4weNB7PNs/qhA9EcfWGt
	 bwxwG7IAteB0PRl1xgeur9XcSc0sgYo7yC133QqOt49Wtkf275tKnS8k8VfP4imPgU
	 j00yXa7A5O54098EviGzcqOqjLC4KNyRStZEiomkz2KKpvLpSQnlZ3JAkWwzLv4hkh
	 9ZZbqqf5oyFSIfxMlYdfzstT70XxdHsOIc37jKyxLfV66MxtUV6BwVi/ogrkV7gVj8
	 An071gHUq5Kh3FIXMHFschY1jFILa/mJmxZbQdH7Gl0T+Y00IITpG/56nMepJMdIRB
	 wZoT+bnJuWTrQ==
Date: Tue, 18 Mar 2025 19:49:00 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: switch away from deprecated
 pcim_iomap_table
Message-ID: <20250318194900.GU688833@kernel.org>
References: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36b4cf3-c792-40fa-8164-5dc9d5f14dd0@gmail.com>

On Wed, Mar 12, 2025 at 08:21:42PM +0100, Heiner Kallweit wrote:
> Avoid using deprecated pcim_iomap_table by switching to
> pcim_iomap_region.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


