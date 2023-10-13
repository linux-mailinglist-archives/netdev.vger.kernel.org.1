Return-Path: <netdev+bounces-40735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05117C88AA
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC061C20B2A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DB1B290;
	Fri, 13 Oct 2023 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtZ7HgeJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F111A266
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD3C433C8;
	Fri, 13 Oct 2023 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697210949;
	bh=YtIXXuRf4Lngx6rJrU6npwrdprczxA5ErBSuQkN9z/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtZ7HgeJ9AIA+lJcUXvlNAilfyLw0+TojW7zslHmLBOiYRL99jhyvQz9RQU4Dx6KG
	 4ZShTnAHwZerbiynGbpOsk1uEn5HT3owuo6/RFZsx537AA64nShjMzAxrR57HH9j6u
	 llnVYcmavGWTVnT/lTVfr5yDpXvuZXqi911TOn6nUxksuKCPAVLFt+Co5GyLj+VFq4
	 5IElbJA/RYZeKFdyiQt6K+5kJ/2j1vDioJtefwzyWn0Xqpzh33ILKaDV2q3u+aoYkQ
	 adiHOmvh5tBMWdHgpg8L+AfRpKwFWPxz8erfmtbzZFFTWylh7J5T1kHI5vlxqKTg1x
	 VYalMBe4XyT3w==
Date: Fri, 13 Oct 2023 17:29:04 +0200
From: Simon Horman <horms@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, richardcochran@gmail.com, lcherian@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: Enable hardware timestamping for
 VFs
Message-ID: <20231013152904.GM29570@kernel.org>
References: <20231011121551.1205211-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011121551.1205211-1-saikrishnag@marvell.com>

On Wed, Oct 11, 2023 at 05:45:51PM +0530, Sai Krishna wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>

