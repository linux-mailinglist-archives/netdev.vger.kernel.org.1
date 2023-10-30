Return-Path: <netdev+bounces-45155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5267DB321
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 07:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD53281330
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC04EC4;
	Mon, 30 Oct 2023 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qka4v1v3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E881C13
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E8C433C7;
	Mon, 30 Oct 2023 06:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698646535;
	bh=+AjgvHo7u4AjcdW78I1WaXMZlIBlola+cFHDPGBHpLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qka4v1v3TyipegT6yuUPK+zMEbXj2mOvJPm6FMIwyhH/OUY185zUFNuhbk0WTBVLa
	 LZ4U95ZVFc7qgyY8zg+uenVqOToKnTx7NJr0uB85+lnTpCQEDgHkllI0PAmABjXPKN
	 +IwfKalWj7nbET8SqqZ8zJNaxDFb5UFgYUkgU+Yl7t6X0FQG6Hs123PLqyNwdMKY1e
	 daOP/OfRMcCks5guz5FB0ExqBk1/Oq7dfP1W7uRjoUIZthTS0MRtJjOWbkoThkmvel
	 LaiDM3fH7G4IXEfkJuh19p+oLV1WSAJNsXovyncphbkNSRLC2+NI4k8Y0e3ZF34iIQ
	 2o0kmFbl5XG3g==
Date: Sun, 29 Oct 2023 23:15:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v18 00/20] nvme-tcp receive offloads
Message-ID: <20231029231533.79dcb9ef@kernel.org>
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 12:27:35 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.
> The main change is the move of the capabilities from the netdev to the driver.

Patches 15-17 never made it to the list :(
Please note that net-next is closed for the duration of the merge
window.
-- 
pw-bot: cr

