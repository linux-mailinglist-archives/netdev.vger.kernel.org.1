Return-Path: <netdev+bounces-138710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838B99AE9AB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8EF1F23EB8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3D1E1A39;
	Thu, 24 Oct 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1osD5Yo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20E1D5165;
	Thu, 24 Oct 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782221; cv=none; b=gsCJTVpTZ+UZ4Lg0co0v2dVKfq4y2R9RuHiH/vfiVnl7Xe0KBDdp0Fa0XKX/poE0ja/zZEQ0L78S89mZpKj2q5EQbPLa/iImuSV4JUzQilzqUcSJMynTHFK2FTpomoT9GRyldQxNvJfFkoFQheP9gimjh8811CegjGOBIoB8Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782221; c=relaxed/simple;
	bh=lHL6taeDeci1sxOVwt1bswF/sQOxNbqbJMRA71q7IXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifp0IO4nOzEGCC0uHZsA4WRZqLcQQewbLmP0qQPxNXOTJqQl0k6HAWlzGrwFjWtx+apuUlP5BWX1VsxBlsY8i5NViJxvtlxPnBhbTmjz/HbIDCJ7zebsBIOTBtJxdLoLmLpqIftUGBsZSsXcUDyCHHLsnTl4BtqdH15kQzJsiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1osD5Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E98C4CEC7;
	Thu, 24 Oct 2024 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782221;
	bh=lHL6taeDeci1sxOVwt1bswF/sQOxNbqbJMRA71q7IXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1osD5Yo/FhFp4ihLvdsPJcIPU02lkwZp76RHe+6uT86KYgoSieijl2zjiO0LCwEe
	 4FSsSB6wRrpuB+j9DOe6hJuMSdchm29Q0aLQTbPhtMRC0GSwpDWDOlidgW0zNAv8Ld
	 Jz+9cKSqq45n4ONj1X+fX0430SpVkCyyoZGa98WMjl9/EQn9Yp35aw/Tu3iVcfjhQ+
	 CshT/HzA0leZEqGBd6RtARVqSJ/IIKe4+PXbR5pAB6QxbalLeHMz0/VCd9q7HjlQ7T
	 M5wE+T3SH0Yc4XGyJYG7LY4uYxoY8nz1YjTIIz0scEupgDrhgenORcEsc0QTZAnIkX
	 mSK+Wir8a9x7w==
Date: Thu, 24 Oct 2024 16:03:36 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
	edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v4 1/4] octeontx2-pf: Define common API for HW
 resources configuration
Message-ID: <20241024150336.GV1202098@kernel.org>
References: <20241023161843.15543-1-gakula@marvell.com>
 <20241023161843.15543-2-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161843.15543-2-gakula@marvell.com>

On Wed, Oct 23, 2024 at 09:48:40PM +0530, Geetha sowjanya wrote:
> Define new API "otx2_init_rsrc" and move the HW blocks
> NIX/NPA resources configuration code under this API. So, that
> it can be used by the RVU representor driver that has similar
> resources of RVU NIC.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Jiri Pirko <jiri@resnulli.us>

Reviewed-by: Simon Horman <horms@kernel.org>


