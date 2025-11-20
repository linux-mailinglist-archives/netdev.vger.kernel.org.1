Return-Path: <netdev+bounces-240283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468EC721E0
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6AE34E2C66
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93012264DC;
	Thu, 20 Nov 2025 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th4fDLF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0107156236;
	Thu, 20 Nov 2025 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610667; cv=none; b=j3jQrNDaSYyrIkzBZyM7iS2P0d9g/QCopcqdm/bcDRS2ngAogv4N/mAORKJgwkqcjbm8rCIWNVfAFswwomhpnZF5CAkU4oLShL1sBf8iOmKsYfh7kiL57EudS3fPgF+/jMT+XMxjyfDw8vVpS9CWZ0yOxAAkq7e2xMoVXXctyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610667; c=relaxed/simple;
	bh=dHc9HntalMe2URGDm9ebsAQ4PjrLKAYPH6h5gCa81gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChxKBmlAniM7i0XSLjtCTWQDWep0O6rasnE8ENiUfF316eiRCFD30Adldwi/qkJTXwWepN8237xLN2vuUtbwAGlXCBHeka409nUf5z2sN3aRnLrMCc+hb1u/ju7JGi4tXJXkD8P5yAaI5CO4fa8YP6IelMsoK6NJdCjsOQqHs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th4fDLF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5FDC4CEF1;
	Thu, 20 Nov 2025 03:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763610667;
	bh=dHc9HntalMe2URGDm9ebsAQ4PjrLKAYPH6h5gCa81gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Th4fDLF4eXS0+sEvMJvMCQYoKPof8iQ+MhUuwnMuSGeg+706x2NjyYVm+OSstA0fv
	 v2TZsJVWSutkXhdSwqAzSJVXDjqfm3L47Xdn3LfBMlrojCbp3wZ/I6MohHFthE+3d+
	 9Nb026KZ0UpNvHFZ6EXF8lsmb4KclA1bnv7pk5t/67MvbMAmmEMyJ9GGNtz3UtbyvZ
	 EB3ZGHBHaXaTOMwn8AjiElIX0WzvaVVW9A7Q2axTTwh2MBmM/POwg9zpHnDd9SPm+e
	 uIdJbEca9LmHaGtn4vL54wWtpx+nfAs1yJdF2VTLabNz5Lz900aKblfO9gdPd3lXs5
	 4YzH9HEkQrm8g==
Date: Wed, 19 Nov 2025 19:51:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] r8169: add support for RTL9151A
Message-ID: <20251119195105.002df505@kernel.org>
In-Reply-To: <20251119023216.3467-1-javen_xu@realsil.com.cn>
References: <20251119023216.3467-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 10:32:16 +0800 javen wrote:
> This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
> basd on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: javen <javen_xu@realsil.com.cn>

Presumably your fuller name is javen xu? Please include all the parts.

The patch does not apply, please rebase on net-next.
-- 
pw-bot: c

