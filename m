Return-Path: <netdev+bounces-180441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D841CA81533
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740F84A1CEA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B24230BCD;
	Tue,  8 Apr 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxI+86hH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E60217704
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138650; cv=none; b=WsCsD7gm0PpknlrSpuVNqS3H2BW0sFgtYe/cUzyHbaIXH096AKIwfVLGlq3IxZnSgHewzagu7hvqjrhxJgPxzf9sUeEV50lESwvzKu9tWTKjLXp0tG5MtURYhHUBiXLi2CLiFN6Mq1upRKz6Zbbu+OTOcPbIBPsWnuxnAYPk8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138650; c=relaxed/simple;
	bh=Zq46Qr2znB6f0M/kcECH5HtNBXx3KTiGDsDx+biqMDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGPVoRgPgG0V5jP4oriqfjdc0NtoLZl7T+gaCNRLRX/p+mklOFYlUctCJB2fOV9BqFnL8NK0EUORPTon03kIzNeVQ6zdhwY0u4hbMfUoILw+v+FXMBVkTxHjF9ffsyBz7Ds0lGwqQdCcUwqW5EJCW7SGdnoKsEZBEbHOfN1ssgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxI+86hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6491BC4CEEA;
	Tue,  8 Apr 2025 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138649;
	bh=Zq46Qr2znB6f0M/kcECH5HtNBXx3KTiGDsDx+biqMDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GxI+86hHJtfLXQhDGT5iJDwd1kK9NkNKGbdjoKj+gBEg8cwlt1HRH0bOs2wjsFSL6
	 vyflJKROprk1sJBReSSPx1sPx1PUz8vCbXU9+/c1r+CymLUnnLnXOuyfyNCH81xGU4
	 HfcEsOy3e54nmGckI2o8/amiEWhEGoQ6jKZlOfRN9D/jjVA1jk9cwSsqe36CaUsUMh
	 3vRb4GuIXAMzor4aQsl9GFvJDYxV/8Yq7sYt5ItfIqQutsAdcWqtoQ51+rkghqQv/a
	 y98nL9s5PkHlrseLMkIafN7+xIBpz/z+XDTXYEvYgnvxNlGLfrnN0Ff49rrFg6WMbo
	 L+yKsHus4UpWw==
Date: Tue, 8 Apr 2025 11:57:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Michal Kubiak <michal.kubiak@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: airoha: Add l2_flows rhashtable
Message-ID: <20250408115727.6b7468b3@kernel.org>
In-Reply-To: <Z_VTpBhntxXPncsv@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
	<20250407-airoha-flowtable-l2b-v1-1-18777778e568@kernel.org>
	<Z/VCYwQS5hWqe/y0@localhost.localdomain>
	<Z_VTpBhntxXPncsv@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 18:49:40 +0200 Lorenzo Bianconi wrote:
> > I didn't find any usage of L4 flow type in the series.
> > Is that reserved for future series? Shouldn't it be added together with
> > its usage then?  
> 
> FLOW_TYPE_L4 is equal to 0 so it is the default value for
> airoha_flow_table_entry type when not set explicitly.
> It is done this way to reduce code changes.

That seems quite unintuitive. Could you init explicitly for the
benefit of people reading this code?

