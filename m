Return-Path: <netdev+bounces-101072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A608FD229
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A59284AFD
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8050148FF8;
	Wed,  5 Jun 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETz7sn3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFD4776A;
	Wed,  5 Jun 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603022; cv=none; b=uHTQ3BVmDu935qvqtwyN48dwXN7RYbyRCzrBfOw0R60qvbRv8rpGmVJKWkoLKj/H9gQecXVEw87r9YcAdecoT5cEAOsRMkzmVcruQ9BdgnOra56saGevvHQNeXKJJPa0qvCai1xyTe06o7DcXGY6Au2Cj9eo9amwYsnowYUWdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603022; c=relaxed/simple;
	bh=TJBQFbquQu5uvJHiZ9IjxLrT98QIERfiUKcWcuRj8Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkFbDNmUqqfVzJozOXzxCfauQjCedelw5/eSUx+IiCgRmZW+CGfXugCHiLMX3XtcxfzARvk9yRM6tf8GgVKDs9dCk+2fRXLeGeDaczHHI7yQCpQcY1lu1uLaaFFj7DW028mkHB24IOVYkSK6dOgZ4Idv0f5E65ZQCmZ+RoSyGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETz7sn3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EEFC3277B;
	Wed,  5 Jun 2024 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717603022;
	bh=TJBQFbquQu5uvJHiZ9IjxLrT98QIERfiUKcWcuRj8Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETz7sn3Cng+vS2he2d3/2IMwQ7zgONHBjSbB7wT5DJkGtBE/GlhcBkUuS62PKrSSP
	 Y7sQKnsBtaJpnZcETKEBiDdsFKrWW8GD2TrEDJcNIbX87D4ukKq6TKe2eEElwL8T+F
	 TkozbxjadGc8iLDgq3dVCwkzyC4z1+UYEweDgNlR8tokX3w18jS7IV4sPmC1ZgZKwE
	 JnTKUWgCLL1Q3TeAfERaJGxajYtIggMEBLZjSWJAxbK5PBb/kRO/aJeI1ecHR/CVvy
	 H/PljK0k6m12XmaQjJxaewAsEVM9/AxNLJdNYkBL0z/bcARCbrChwdVUQeKgOp0+fg
	 I/RTkTG1zBtFw==
Date: Wed, 5 Jun 2024 09:56:59 -0600
From: Rob Herring <robh@kernel.org>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, tglx@linutronix.de, tpiepho@impinj.com,
	w.egorov@phytec.de, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kip Broadhurst <kbroadhurst@ti.com>
Subject: Re: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240605155659.GA3213669-robh@kernel.org>
References: <20240531165725.1815176-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531165725.1815176-1-u-kumar1@ti.com>

On Fri, May 31, 2024 at 10:27:25PM +0530, Udit Kumar wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for TI specific phy header files. This allows for Linux
> kernel files to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
> 
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
> 
> While at this, update the TI copyright year to sync with current year
> to indicate license change.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>

You don't need Thomas's ack for what was just boilerplate license text 
to SPDX tag.

> Cc: Trent Piepho <tpiepho@impinj.com>

IANAL, but 1 define doesn't make for copyrightable work.

> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: Kip Broadhurst <kbroadhurst@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changelog:
> Changes in v2:
> - Updated Copyright information as per review comments of v1
> - Added all authors[0] in CC list of patch
> - Extended patch to LAKML list
> v1 link: https://lore.kernel.org/all/20240517104226.3395480-1-u-kumar1@ti.com/
> 
> [0] Patch cc list is based upon (I am representing @ti.com for this patch)
> git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"
> 
> Requesting Acked-by, from the CC list of patch at the earliest
> 
> 
>  include/dt-bindings/net/ti-dp83867.h | 4 ++--
>  include/dt-bindings/net/ti-dp83869.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

