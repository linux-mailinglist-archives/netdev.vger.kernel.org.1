Return-Path: <netdev+bounces-78905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39A876F17
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F832821B1
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C037141;
	Sat,  9 Mar 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfR+v8pS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59768364A4
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709957677; cv=none; b=Gp2fZjgbvek6wLtH/NFDGUl3rt5nOMLNWHnjdVznly0t64P/WDnVcKUy+GDioTT7WzEpTkNQHsS4bRUD5EENWCAfo2sdckFOQvMDa08hCKaz+OZevFYp1nyF9+fXJUeD7knElKSacRFW8kQ3LBKkEaI4Q2K1DSmAdf8XKD3SAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709957677; c=relaxed/simple;
	bh=QTmmL9vvsXavi9huJF3964V9l4PmNiIdfhIBA6rmJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AA00zPEWIqFXEs5xeYstEuve2hj4ejw9sN6Nmug0V7fOkCTCc1OA/XypXYlXejXuBIAXoPFiuzib6EoAfGoIe2K2ejflECisKk1ZhBOQGQqBtu0RhYBpHsqcZiAwvY78Vkms8Q8/6W1VpU6AGKYOzja4JdqrHlgXN7VBCQ5N204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfR+v8pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20F9C43390;
	Sat,  9 Mar 2024 04:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709957676;
	bh=QTmmL9vvsXavi9huJF3964V9l4PmNiIdfhIBA6rmJ7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfR+v8pSFRCyUcYfS/GSWle8aZJlWwHG9MpLZZwh+zr5WYh6no+45HVDdEMlV0I1d
	 YDdWyzk2OMyiymc3Q/BPCyurpjHcrKPXuiXOZTuznGfT6agi1QnD1HrJV4jjqKjk33
	 Cic12wiqnNNFB6LsF54U3ZHlUGX/5WVYvqBmAlkkgnXiidthLmVweYgPxJ9vBvxQvA
	 o6te112OsEGybP+Np3U0Ad/LFzw2C9fvzUNZEU8BIejdDRumhe5b2oQLc8a2srfxNW
	 moZ/ibzQbssSRLJ604UlbJ76rhywj+AzWOJJy/p0AURfH3fvNSJcMeyPyNxBcIp4zu
	 5L6FKJ8Yzl/Cw==
Date: Fri, 8 Mar 2024 20:14:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>
Subject: Re: [PATCH net-next] Documentation: Add documentation for eswitch
 attribute
Message-ID: <20240308201435.2790b7b4@kernel.org>
In-Reply-To: <20240308000106.17605-1-witu@nvidia.com>
References: <20240308000106.17605-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 02:01:06 +0200 William Tu wrote:
> +   * - ``mode``
> +     - enum
> +     - The mode of the device. The mode can be one of the following:
> +
> +       * ``legacy`` Legacy SRIOV.
> +       * ``switchdev`` SRIOV switchdev offloads.

In my head `mode` is special because it controls on / off for
switchdev, and none of the other attrs do anything outside of
switchdev mode. But thinking about it now, I'm not sure if that's
actually the case. Let's clarify. And if other attrs indeed are
only meaningful in switchdev mode we should feature `mode` more
prominently than others. Separate section perhaps?

Please link to representors.rst and perhaps switchdev.rst ?
-- 
pw-bot: cr

