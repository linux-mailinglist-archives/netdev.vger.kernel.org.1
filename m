Return-Path: <netdev+bounces-108013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F71C91D8C7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA391F21AA0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAA7D08D;
	Mon,  1 Jul 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVNZO45Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD235464A
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818220; cv=none; b=AsWrLlRsoCehcQwXAsPkSBemK5P/iOacKzw8WVkxvxb4sHAJJl3A2MQhxYe8PNgbkIY9E1+Qb+CIO8BicyY0oYd9M2ar1oIaNPXPHhwC7jp8nzAesJcvZYXlmBKMDWha84XxoglBdTz0dYFwnwfUP4aHQnSU6pdQXF+zYdgbQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818220; c=relaxed/simple;
	bh=9cDqavuTSkImX+ZtaQXd+6KkjQZ9VbqXdBMopZkDkBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNtQ8oqox7gYL6c4CEK0kGMvVGKzOX9CwJoWsivI6DFE4dqkLl/5d7FpLbReQfaGsmMymtaLXldqiKEvQIXSVYXldp2Vujb4/9oMHhT2OHccr7tYfevlYLeBKpmc0ixDVW26xInB2fUQwWAQt8jaseldi68SIzRikJill3IPHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVNZO45Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E0FC32781;
	Mon,  1 Jul 2024 07:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719818220;
	bh=9cDqavuTSkImX+ZtaQXd+6KkjQZ9VbqXdBMopZkDkBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVNZO45Q7dKbdSeH6ynUrvs01H08z4Fg40rLA3Ial7XXpClLTp/CrBU2pFtfPbiY1
	 s86cvhHEOleOqr33FWEvbBNGSGtVJKhfSlMeO8IDPaqJgYbt0HWXV0J6Q4z3HyVT3K
	 2j1dz+cqvonxjLxYOiAGm37Ibth2CkuXIy2l2T+YZbVIvT5qP+qdHAQbw2FI2KKMbB
	 jCU/35MegUS4FoAfwQc3Da0YoY5Snz5anbL4VKY3wsGnx9JzwECDf8MpPSK2TGEWEF
	 KHh+yhlv2AllqKxGCwG2wucA6niRw86kHCyUDwi1CrIgbLKIhH+v3AYfSL63+9Dhhb
	 SdDic4f7a4xHQ==
Date: Mon, 1 Jul 2024 08:16:57 +0100
From: Simon Horman <horms@kernel.org>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 1/4] ice: Introduce ice_get_phy_model()
 wrapper
Message-ID: <20240701071657.GG17134@kernel.org>
References: <20240626125456.27667-1-sergey.temerkhanov@intel.com>
 <20240626125456.27667-2-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626125456.27667-2-sergey.temerkhanov@intel.com>

On Wed, Jun 26, 2024 at 02:54:53PM +0200, Sergey Temerkhanov wrote:
> Introduce ice_get_phy_model() to improve code readability
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


