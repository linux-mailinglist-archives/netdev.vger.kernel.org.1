Return-Path: <netdev+bounces-111447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A93931132
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA11283B35
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FEE186E27;
	Mon, 15 Jul 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSTEDrmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C416AC0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035790; cv=none; b=DWdOWrcREASRJ3S+II84QSxpBgXH6sJTFAGUfibAQDRqDPWykD6Lqa1ggpchooYPUJM3X3f3Zrlac6nc4REoZYtfdCpuCjFMM02nie5YengEwfDROmJFzuyRGKDuVXmbI0QBNeuBenxyti2rWqCEDRVVl47eSnnBKH2yT/wtfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035790; c=relaxed/simple;
	bh=Ww+rPJ44t5fYUMKmUwPWuR29H1+gZVeon+9Bldu1rww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncGZEnRebedzeG/0KNkkiX/ZQmbrOKAyk+uufkRXzslQQZ//cnY5toSYAu/q1VWdJAyQqmAPzWq7qAZhm6GbOGH0JWdK35wffu3d5z6RMDtMIsl3mmMUmKaWB+AI0swrJbbuaB3QCZmhXfNVjSwRkAMfuao0tNOKSVQGCyY9xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSTEDrmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20533C32782;
	Mon, 15 Jul 2024 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035790;
	bh=Ww+rPJ44t5fYUMKmUwPWuR29H1+gZVeon+9Bldu1rww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSTEDrmpuhEtNzX7qJ2yGpF7sJGPOWmanrO3FB/cDxdk+krL75MbdhZJX5Zq5jdIt
	 aS6wInNbLOpG/CWenj+x8ysQG67uJwRqOE63l+5BCxPFwMs77EKvDw7lg3Z2nRABhW
	 8f6Bicl5PcOUuRzcNQXcr0+pgTz9VtQXO4XVxPQSZbg8e3VKEp1GNhezJHQ1NxF/MH
	 YCo6VLiOUxmkyeAIwNKhk8cw4l/pply0wmJf3h0KtygXsY0C+xZIAs3FJ7c6a9gafj
	 /fKhMRTIFeayX57uWMZu0vJqUz2i2LENktgnA+nynKvdfCpgajfz+sE8yREXYGNKeW
	 LmDekndd5nrHA==
Date: Mon, 15 Jul 2024 10:29:45 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH net-next 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Message-ID: <20240715092945.GH8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-6-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-6-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:35PM -0700, Michael Chan wrote:
> Now that we only support MSIX, the BNXT_FLAG_USING_MSIX is always true.
> Remove it and any if conditions checking for it.  Remove the INTX
> handler and associated logic.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



