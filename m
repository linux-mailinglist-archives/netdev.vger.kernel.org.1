Return-Path: <netdev+bounces-191447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E2ABB832
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CC41891818
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710926C391;
	Mon, 19 May 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJgOGFcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FF26C38D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645615; cv=none; b=RqY1MU7D/f9G2y22Qgk9/WMfxfQwB/h+cWHMTNwM7El7bMfx38Q7T/7YJ3fhxDqiwj+84NExVi+x8cdggrjDJRIa7TjGBnaBYzyMnHA+7Qr0qEfpCi5wP3BMfP+nLTCQ1UBSXEWvMSVOFIPkM/PtoxGFLxG46HsPTZIUrmZX30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645615; c=relaxed/simple;
	bh=ck3iCsPvj/FKaeZ74qAqaYo0PAgfNPbgnOH3LG9nXnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjAwB9cZzE7D/0hUKui/J5XpLdZCZ0QcQFFfH3CV9/LJFEa4CTcog+mghRrDLTScQu9moWQJQHDEr+x7Xj07IL3Lx1zRRl5jWZ335kdiy1k3rXV1qy/XAQsVzoBGCGj05C3v+3nvpSKAKt7TypSbkK518rJIQjOwdwyrtKzphP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJgOGFcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32372C4CEE4;
	Mon, 19 May 2025 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747645615;
	bh=ck3iCsPvj/FKaeZ74qAqaYo0PAgfNPbgnOH3LG9nXnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJgOGFcN4uZ0DWBCd1yNLLsgDZawdEzCa7LXrXPETpH3NtxMKdjXyNpOzq6B/6z+W
	 bX9liUB3IlM2lQ4fTlvv7954bOQyoSr6FuOWl5ovWYhr8ytRydibKnRxmsoJsFKytO
	 sBTRnUbbpp/MNCtZCwaSdaYwUjrklA8XMheQOyGgNrtuL+y0pGJRLSCm35T1Z1L2zZ
	 1Oqb+N8k6JZb84Au3//9okXwa6nrNK3E0F1Q5YzFkVBw1sDVpiXyv12ZuIDE5VgCnp
	 rV2wLHFhX6zWx8cMn6LcfyZelk941Rbfc8MjHA49VJwBfMB1LMoYRbdp1tMIx7Ct6Z
	 gZeXIgAXaDPaA==
Date: Mon, 19 May 2025 10:06:51 +0100
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v5 1/3] ice: redesign dpll sma/u.fl pins control
Message-ID: <20250519090651.GB365796@horms.kernel.org>
References: <20250422160149.1131069-1-arkadiusz.kubalewski@intel.com>
 <20250422160149.1131069-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422160149.1131069-2-arkadiusz.kubalewski@intel.com>

On Tue, Apr 22, 2025 at 06:01:47PM +0200, Arkadiusz Kubalewski wrote:
> DPLL-enabled E810 NIC driver provides user with list of input and output
> pins. Hardware internal design impacts user control over SMA and U.FL
> pins. Currently end-user view on those dpll pins doesn't provide any layer
> of abstraction. On the hardware level SMA and U.FL pins are tied together
> due to existence of direction control logic for each pair:
> - SMA1 (bi-directional) and U.FL1 (only output)
> - SMA2 (bi-directional) and U.FL2 (only input)
> The user activity on each pin of the pair may impact the state of the
> other.
> 
> Previously all the pins were provided to the user as is, without the
> control over SMA pins direction.
> 
> Introduce a software controlled layer of abstraction over external board
> pins, instead of providing the user with access to raw pins connected to
> the dpll:
> - new software controlled SMA and U.FL pins,
> - callback operations directing user requests to corresponding hardware
>   pins according to the runtime configuration,
> - ability to control SMA pins direction.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v5:
> - stop pins unregister for not present SW pins @E810-LOM NIC.

Reviewed-by: Simon Horman <horms@kernel.org>


