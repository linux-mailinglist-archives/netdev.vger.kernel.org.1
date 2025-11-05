Return-Path: <netdev+bounces-235763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C38C35109
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220115636F2
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006F11BE871;
	Wed,  5 Nov 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFyWDEqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06017C220;
	Wed,  5 Nov 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337657; cv=none; b=JoWDHWZO8P4Fh8eg0otY15CAFn94xClmDd+nxYwJ9FLTnrMzTHm01SGM2nhtf/12rC2usSoU0hqFe6FJJvQmnt35kU0gO2txrMW3cmLHi2hu0G1WuIOHfo1dJ6pD8sqrTyouKHPFP9ZjEEuR821cleBMbqKcDqf6wdYcvf2pmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337657; c=relaxed/simple;
	bh=Okbe7o8+me/nPHM9MBYNTFsR959vwaadU/clvuSJ3Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iarlZ/8W9eFhGqCWiWlftKgykuT6YlTW10dTw3TVjmdunOPkCKOAr/e94e4PICHaDVNjvdxXHETkDU7w6DO/8NmA0wfo7zK4+VY2jPtT5/UfKS2oC2c2TdQiPN+/lGJDwGLHetWX0GdW3lvYrZDJ0O0G//KAataZLrz11oVN3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFyWDEqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F4FC4CEFB;
	Wed,  5 Nov 2025 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337657;
	bh=Okbe7o8+me/nPHM9MBYNTFsR959vwaadU/clvuSJ3Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFyWDEqKrRI+sa/wNzDR0UcsEfiY3Pz9GBl6hFu7iBVTL6Sf33fIK7EBGOmVRxg+D
	 35XW2yjb1su+VuodnvjAJTjmJSEVhvRxvfgKZB29G/bL9WpkImlAasSStMM5OAZ800
	 2kYh3U/VDj/gZx1NTjWhb1DdwdJURaulYDq1VnEt0MosRMGynhPc8Pgh6yll4vOUwF
	 21cwFGG1/0mWdOU+2lTe8y1QWpoPiAfHQ8zvxkaT52xoQ2VxLQgRgsisXvH+O4Ir8o
	 FqVJiNDkOAwx/Gwh2C5wI9lVWEs60rz/chgJWBcJQotwgdzMqts9orR3hWLx92pa5e
	 SMXbxaf4znOLw==
Date: Wed, 5 Nov 2025 10:14:12 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: h-mittal1@ti.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix fdb hash size
 configuration
Message-ID: <aQsjdAClmmKPLHWM@horms.kernel.org>
References: <20251104104415.3110537-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104104415.3110537-1-m-malladi@ti.com>

On Tue, Nov 04, 2025 at 04:14:15PM +0530, Meghana Malladi wrote:
> The ICSSG driver does the initial FDB configuration which
> includes setting the control registers. Other run time
> management like learning is managed by the PRU's. The default
> FDB hash size used by the firmware is 512 slots, which is
> currently missing in the current driver. Update the driver
> FDB config to include FDB hash size as well.
> 
> Please refer trm [1] 6.4.14.12.17 section on how the FDB config
> register gets configured. From the table 6-1404, there is a reset
> field for FDB_HAS_SIZE which is 4, meaning 1024 slots. Currently
> the driver is not updating this reset value from 4(1024 slots) to
> 3(512 slots). This patch fixes this by updating the reset value
> to 512 slots.
> 
> [1]: https://www.ti.com/lit/pdf/spruim2
> Fixes: abd5576b9c57f ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> v2-v1:
> - Update the commit message and give more context w.r.t hardware
>   for the fix as suggested by Simon Horman <horms@kernel.org>
> 
> v1: https://lore.kernel.org/all/20251013085925.1391999-1-m-malladi@ti.com/

Thanks for the updated commit message, this seems much clearer to me.

Sorry for not responding to your reply to my review of v1. For some
reason I missed it until I checked the link above a few moments ago.

Reviewed-by: Simon Horman <horms@kernel.org>

