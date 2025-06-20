Return-Path: <netdev+bounces-199711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2992AE18A3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F451BC7428
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC32836AF;
	Fri, 20 Jun 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjA05+o9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EC1FBEB9;
	Fri, 20 Jun 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414497; cv=none; b=oXZjlHf+FCk4Y+GwPUeogV2R3HNgK5LuAB6nePpESM1NDDLO+H5cQriw3KZXZO9nnRRt4cboH3aPVJn9q3YhG3Hl9LX2F5+hPLOMJuTrFUQaLi+v91Fv4ARp4abu9uMaASkSrRqEVVuUNZLGWwggDuRsCLpkl3cl/tKS3mD2xqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414497; c=relaxed/simple;
	bh=gmYnWUgVbpVz71xZgezEBy5kzOlS3gfZl+tiLY5ZUEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuG0qFL3I3gXz7JFlttMEidecfvtgwj55/xjoE+KfYIo5AoSqLGPzejfawz+M7Oux9Omkwl+dVjM3bALvKa2ZlvUc98DTL5Zih9TtASV5u+szV2sMbVwEAbzgl/YZ86KttwLh81Ajb0R1xjm82AwfBD9wMtUcDXCh9DrHIcbbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjA05+o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC81C4CEE3;
	Fri, 20 Jun 2025 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750414496;
	bh=gmYnWUgVbpVz71xZgezEBy5kzOlS3gfZl+tiLY5ZUEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjA05+o9aVPlz0mihZQGcFmqCrQNFA5/9trIybvBNzEUaSPELT6dl9tjDAFu+UG38
	 yjbceUiiBQVDtVq9NhqZxZUDxHOfCyprKmuw/CdEN7FDawNwRx43cmmrQhjdBNz/q4
	 aU3wGpCAmz628B0L8f+3Gwa4TQywTxUOuktrB9NnfJkZiMI88PDDLEDU3xlg2TeXwY
	 LR3W95HVKmiftR2yoEz1mflRLjRBCjCDJxOHwpQRZqHJWrcQGqnJDCmLBw8atrNBT3
	 0Vb2dhgRBchc7NcT3JsA+hewmgl8Wa0uHQCIJIrbxZ1pAaXmmCoxc+qfNF8sdGjHs5
	 v1w99bSVGxiDQ==
Date: Fri, 20 Jun 2025 11:14:52 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>, thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ethtool: pse-pd: Add missing linux/export.h
 include
Message-ID: <20250620101452.GE194429@horms.kernel.org>
References: <20250619162547.1989468-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619162547.1989468-1-kory.maincent@bootlin.com>

On Thu, Jun 19, 2025 at 06:25:47PM +0200, Kory Maincent wrote:
> Fix missing linux/export.h header include in net/ethtool/pse-pd.c to resolve
> build warning reported by the kernel test robot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506200024.T3O0FWeR-lkp@intel.com/
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory, all,

The change that introduced this warning introduced a log of such warnings.
Including a lot in the Networking subsystem. (I did not count them.)

So I agree with the point from Sean Christopherson [*] is that if the patch
that introduced the warnings isn't reverted then a more comprehensive
approach is needed to address these warnings.

[*] Re: [PATCH 3/6] KVM: x86: hyper-v: Fix warnings for missing export.h header inclusion
    https://lore.kernel.org/netdev/aEl9kO81-kp0hhw0@google.com/

