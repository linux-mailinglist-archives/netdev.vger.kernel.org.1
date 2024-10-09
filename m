Return-Path: <netdev+bounces-133706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C5996BD5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9BC281D8F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3251990CF;
	Wed,  9 Oct 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYrVwBK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1571917E7
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480514; cv=none; b=nX8Vm04VH2h5NUtxUElD5oKo4MNych7pCAjllfhWCf+xS2hbSaInUy1BtFFvChskZ/wyLaZLwyhZKcRJB3KMXmnwT44Z06XfJGcZiktVfqhTPLG/O1bS7qvYVJjQMWt14YYTF7n0Qog0u+uXQtTD1ISJVmh8ig0nph9mHtr5CzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480514; c=relaxed/simple;
	bh=zuTNloecuz4Aml5QxqPlnKQzhdF4g8PBn34VarakOWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ0DvjohAX6fjaNm6H7l6s68tkUCUuEzXWVSmqoXYWyd7eHSuYmd60y4sq/bDChPwsGlXSXKpI8/UHAHFuBqu9vvEeeRXT5ZvD8AkFTUXr1ounha6uz7k8uUn+qX9UwHLRGdmdqfzE2xL+ckxLw9GkgJIH2BJl/6ko7t6wqO9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYrVwBK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8EDC4CECD;
	Wed,  9 Oct 2024 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728480513;
	bh=zuTNloecuz4Aml5QxqPlnKQzhdF4g8PBn34VarakOWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYrVwBK+gJ/X6Y/1CRmIB97c2pMua2YcJnRmouRexAroAbxHIvEeNRA2mha7vlehh
	 +dZqQ3dko55SAn3imPf8QjIG4lW1Qbdwb7h4VFU3c+2w93o+3pn6OW6+r/r38W6fQk
	 X0X1YWQ4L3iUU33eBesbRP00EXyUy21ZgfQsofnLbW0l0v9fCNzGIqNTRxc05RTXKn
	 5yamYhFWxXmnNaHjvv9eAbum29sAP0oXOtdrDyBnVRa2mL37r+FeKsSzRs18Fk7YqT
	 sxq3/Wza7f59OWtls0iXtWTr13KwxUV00u83ytMz4Jqen1lnJu6tMrLvbpAt8TwbJ/
	 2s7WSaJ+XimUA==
Date: Wed, 9 Oct 2024 14:28:28 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v2] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
Message-ID: <20241009132828.GZ99782@kernel.org>
References: <20241009-airoha-fixes-v2-1-18af63ec19bf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-airoha-fixes-v2-1-18af63ec19bf@kernel.org>

On Wed, Oct 09, 2024 at 12:21:47AM +0200, Lorenzo Bianconi wrote:
> Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus in not
> introducing any user visible problem since, even if we are setting
> EGRESS_RATE_METER_EN_MASK bit in REG_EGRESS_RATE_METER_CFG register,
> egress QoS metering is not supported yet since we are missing some other
> hw configurations (e.g token bucket rate, token bucket size).
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
> for EN7581 SoC")
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - improve commit log
> - Link to v1: https://lore.kernel.org/r/20241004-airoha-fixes-v1-1-2b7a01efc727@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


