Return-Path: <netdev+bounces-138709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F19AE9A1
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999911C2212C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E51EBFF5;
	Thu, 24 Oct 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYl8TmET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95C1E6316;
	Thu, 24 Oct 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782135; cv=none; b=RovzMeVe66yPXSjLXAYnPXArd/3xtunfh8pnFiYp9z5FdooOuUX034w2ZPgh4LBFsx9ZGLVd1s5VjyZ8Nfl1B3Ltwbnkq5SAJcaqEiafb1iUyzh7eXrwEq7bIeIQAaavG4OYoIP1QgfF08lgtK/uRiKot5kPIR2Gndgs3F5p2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782135; c=relaxed/simple;
	bh=cBL8Au+6V//ZHoXqTr7nCwZ29yQs0tQtBBrMMzezo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCxM0TCiPI1KLvY0Ug38CqvnxqqYzaw2EqcfhgjsffUNhBgIp0f+U3gpOzfm3dmcTXeYZC8Lh+GIRRW/eMDpYWT4IJV10QsBYEiA8T6k42ptHn8QiacCjBcNU69Te7WAV5jGmUufP50rud99reBm5DwbsgySYzW5l/ARKdhb0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYl8TmET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDFCC4CEC7;
	Thu, 24 Oct 2024 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782134;
	bh=cBL8Au+6V//ZHoXqTr7nCwZ29yQs0tQtBBrMMzezo2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYl8TmETmburoT1PJ2NtL2nar9ZKdFnneRH2E5WyOPaAFHY1YOEWVn9txbaDxpek7
	 KoWus7TqeGSBVRoei3IlAVAq263GbM8n1kMEhENZ4wHGf9nEqhbup5QbLaiDr79Ypj
	 HZjtl/nPD2yj1Jc2EgRaYS6vHqhiFkpuxVpf5MlcvsWlxIbLmie5hhhnXU4XVqswXv
	 INzRNpEKe7XXETQCwgG6uY78b5g63kWRJ4GCHlokPb7owDTSr7gmPE3Py4jdMSRoto
	 iyp/zqBYuL/cOQxoV9IX2GiBMJ6yj+PU+4lbXfN8lq1Ft1Pln9pQLDQ2bxONV+nW4m
	 E+yqq6U+9VZhA==
Date: Thu, 24 Oct 2024 16:02:10 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
	edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v4 2/4] octeontx2-pf: Add new APIs for queue
 memory alloc/free.
Message-ID: <20241024150210.GU1202098@kernel.org>
References: <20241023161843.15543-1-gakula@marvell.com>
 <20241023161843.15543-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161843.15543-3-gakula@marvell.com>

On Wed, Oct 23, 2024 at 09:48:41PM +0530, Geetha sowjanya wrote:
> Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


