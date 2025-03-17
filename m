Return-Path: <netdev+bounces-175397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299AAA65AB2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A41891ABC
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F619995B;
	Mon, 17 Mar 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMvqPTAW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B3186E2D;
	Mon, 17 Mar 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232314; cv=none; b=RSyTGQvQ+ra1BtJFoeCEBbWfwbX+c468Jz9GWk0nqXM7g8u6YQTKEF5ps8JjRE/akM+KVg0YTd5GAh47wgb7pnoVghsbZs6M7FmdhWs0fgHHGSY2rDt0mQH0Qh9MWPFIwi4luj3gJiALUO+6iuWlurdv2AwyrdDAcH9vXE5fs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232314; c=relaxed/simple;
	bh=momHyGXw+AovseM4wvJIW2+gQCMWVLHanY3SYEvfQ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO8coMQX6DQEQht6Tiot95SS5Km8JnFT6BeuG7TV4UMeRPByW/sNB9ZzRDiDV1M+X/MwoRtyF2YQOn4xGT+S8ZofkLnppyXMjDvQ1zSvrPBDkC7/2Qke8DbLFrgYAY/DikYQLy2Xr9vPI8exdoG3EhZpmlRXC2Um9icJ3dQAIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMvqPTAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C5DC4CEEF;
	Mon, 17 Mar 2025 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232314;
	bh=momHyGXw+AovseM4wvJIW2+gQCMWVLHanY3SYEvfQ8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMvqPTAWX6/bdN4s35mnfMNzXCT0nS4WZFkNB/KnTGQO3iHR34AsnbMNLi7/i0K8d
	 h3FRtqIhwBUs2gLMCpo8OSH9B9lRDfelaS77Mkb2PbJcb+HmQWeisE3AT5ra1Ub5R2
	 qSxKZUrEbVKxvOSMgrWdzW66AMR1t9vih69ZLSPuqYJ2wgfu6CT4hPLaQyAeeEy5ov
	 kg2ngncAiDEvGNBOYrNnkK9e7M61+HM1+YEAAOhnlQlOPU+cb85htlJYXZLo/iKiiD
	 0b9pevrbpOh7e32Z1XETr/EZfu6OJ5xJGfrrICUSgIE+SqA63j8ch0MUdUJ0JO9ndS
	 XZ+lvmzmjylfA==
Date: Mon, 17 Mar 2025 17:25:09 +0000
From: Simon Horman <horms@kernel.org>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] stmmac: intel: Fix warning message for
 return value in intel_tsn_lane_is_available()
Message-ID: <20250317172509.GH688833@kernel.org>
References: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310050835.808870-1-yong.liang.choong@linux.intel.com>

On Mon, Mar 10, 2025 at 01:08:35PM +0800, Choong Yong Liang wrote:
> Fix the warning "warn: missing error code? 'ret'" in the
> intel_tsn_lane_is_available() function.
> 
> The function now returns 0 to indicate that a TSN lane was found and
> returns -EINVAL when it is not found.
> 
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


