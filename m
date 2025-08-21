Return-Path: <netdev+bounces-215467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B9B2EB64
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A56722A10
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD652241136;
	Thu, 21 Aug 2025 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNE33v+U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8467228C9D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744244; cv=none; b=C/g2BX7MUscBz3DG4Tb67KMZf/iH9tpVtI2rF+maGetvb/D7y8W9dVpUfQ+Ygkx3Fwtff/Esw62GXJZ3jtJlS0MlvLbWWCisPib1yM767MZeo7MfcCIrH4ypL2hAz+gVzBXEpEIU9lycktA7LgC2WLSo70qckp++ZSmZiJLJr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744244; c=relaxed/simple;
	bh=cb1NVHJH0g9Efs9aDyZXSxOKMrioCoMVrli4BNonX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCe37l+OOJocLMUxSHQhIVLdaLFXla+ACcfO/Rmwv/zkfyBKKWnT/gUAYJTOzH7ezSBdG4patjlo7NBNVdn3rqvUbkv3EGQ4pYgcrL4bAje4Lvw8NZeDqcSbPh+VvL/66kF/8Oo7YCgpuhCbMFoq28GG6HlTSdRpNXPP5QCh6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNE33v+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E18C4CEE7;
	Thu, 21 Aug 2025 02:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744244;
	bh=cb1NVHJH0g9Efs9aDyZXSxOKMrioCoMVrli4BNonX8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DNE33v+U+6ZlO1x5JnhH8cf33g2MAzIKP2XdLi1/ZQVMOp0VfFee6A7xW+eFXHaBK
	 rUArSMR21sXsWwSSGbmiowPcCtXcUh+Ugt7wqY0Yh8xLzad/VtekoI+il/GjowH6Dr
	 CNTB5Bj64X89mLQAxZNS4634DIR3+mW4DLIWHIh6arufo+S54gOhI/zdm5qBNjjgba
	 4qPFaDY5QKQX4l2HZmqKRos4i0v9FhFZgtzD/lYBOcq7IYNt332CmNHwUjHYZTJ4Pa
	 7StWWKbNOtdTv//ojLcuBccVIQQVzJ045ep3zV2cYipShJrGboCIXxUGfiA9OG4gS7
	 Y+vSBLg52gmrA==
Date: Wed, 20 Aug 2025 19:44:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] iou-zcrx: update documentation
Message-ID: <20250820194403.259c48b6@kernel.org>
In-Reply-To: <20250819205632.1368993-1-dw@davidwei.uk>
References: <20250819205632.1368993-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 13:56:32 -0700 David Wei wrote:
> +Zero copy Rx currently support two NIC families:
> +
> +* Broadcom Thor (BCM95750x) family
> +  * Minimum FW is 232
> +* Mellanox ConnectX-7 (MT2910) family
> +  * Minimum FW is 28.42

The sub-bullets don't get rendered correctly it seems. HTML output
looks like this:

 * Broadcom Thor (BCM95750x) family * Minimum FW is 232
 ^                                  ^
  real bullet point                  just a * character

In general looks useful, I think we have a similar list of XDP features
somewhere. When you repost - could you CC the respective driver
maintainers? I suspect Micheal may tell us that Thor2 is also covered..
Also I think we should say "nVidia" now?
-- 
pw-bot: cr

