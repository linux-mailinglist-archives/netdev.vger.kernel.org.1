Return-Path: <netdev+bounces-56324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81C80E87D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7201C20A34
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971359168;
	Tue, 12 Dec 2023 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPz4BfaB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06175914D
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1C6C433C8;
	Tue, 12 Dec 2023 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375304;
	bh=B+5T+s4PK5i1mJ0rTjs0h4mORh1VsN0iffa+WjrSqB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPz4BfaBbLa4e3su/aPgC6VkI/bt02KQ5FkakG1gxwWir+3rfjIo8IQ/vVFpQSRAA
	 nQYbAGXs0reTFq8IwAnD0Ks3Rk3yoqos8S3b/pyZlBzoQPYmPXVQYE3EsSFwOozeeH
	 SrMnBlq7Cr5R3Yq77t1XRqR5EAAA+LQgQtY2czmdPP1jKMcECXfw0uhZxi2iIw3ONQ
	 +EK2UIHT77JcMuTN0GbKUlMaRLmEtSTgFbwQoNLYH/xET9rjGAhZIgd/HmzGK9teuO
	 DZ3avsu66QOSF/7VyTxS2hp7dK4L02OgPSIXOfm2DYdWA+Q2dG+HTJpcpvRt47T+RL
	 yJKD+LiS1JV1g==
Date: Tue, 12 Dec 2023 10:01:41 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH iwl-next v1 2/3] ice:  Add helper function
 ice_is_generic_mac
Message-ID: <20231212100141.GV5817@kernel.org>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206192919.3826128-3-grzegorz.nitka@intel.com>

On Wed, Dec 06, 2023 at 08:29:18PM +0100, Grzegorz Nitka wrote:
> E800 series devices have a couple of quirks:
> 1. Sideband control queues are not supported
> 2. The registers that the driver needs to program for the "Precision
>    Time Protocol (PTP)" feature are different for E800 series devices
>    compared to other devices supported by this driver.
> 
> Both these require conditional logic based on the underlying device we
> are dealing with.
> 
> The function ice_is_sbq_supported added by commit 8f5ee3c477a8
> ("ice: add support for sideband messages") addresses (1).
> The same function can be used to address (2) as well
> but this just looks weird readability wise in cases that have nothing
> to do with sideband control queues:
> 
> 	if (ice_is_sbq_supported(hw))
> 		/* program register A */
> 	else
> 		/* program register B */
> 
> For these cases, the function ice_is_generic_mac introduced by this
> patch communicates the idea/intention better. Also rework
> ice_is_sbq_supported to use this new function.
> As side-band queue is supported for E825C devices, it's mac_type is
> considered as generic mac_type.
> 
> Co-developed-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


