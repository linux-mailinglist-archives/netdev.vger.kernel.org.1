Return-Path: <netdev+bounces-35403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3527A9511
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94081C20A47
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDFB676;
	Thu, 21 Sep 2023 14:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8091B641
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 14:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63CC4E752;
	Thu, 21 Sep 2023 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695305437;
	bh=8DU895BVITKTTvymEWRzE9Sk1uN+QLlJTB0x6HTf/VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8E1MnvB3YYqlO4zctA/yPpB7HqtuhDkokA/y2B7rIrdWklp2mJJ4Al7isgvuuEGh
	 czxP5Mm9G+nf3dUk529m5qXcFz7vBCPbdGuhQaR8D8FERL5meV8wZlTfFXbJtnAiwC
	 zmZlstf/6HvMJsmzXezjbnY8HR9dj7RPS9eIWG0z47lPFOOMs+G0iGDt0gXOX0YKt3
	 gyy9aax9HME8cahkQkhOohXz4qVR/rRdmw5TVWdyTZjOEPokFdasDSoMRFh1q3bRh9
	 D/uiuyKSpASrH3xzJEcfrnkG7Lw+VhTyvRUJ/Kmz5i2SSHlK8h8QcEKh6MepwNMnxD
	 gLO2mmOesFSXA==
Date: Thu, 21 Sep 2023 15:10:25 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net-net Patchv2] octeontx2-pf: Tc flower offload support for
 MPLS
Message-ID: <20230921141025.GN224399@kernel.org>
References: <20230919141832.5931-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919141832.5931-1-hkelam@marvell.com>

On Tue, Sep 19, 2023 at 07:48:32PM +0530, Hariprasad Kelam wrote:
> This patch extends flower offload support for MPLS protocol.
> Due to hardware limitation, currently driver supports lse
> depth up to 4.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
> v2 * instead of magic number 0xffffff00 use appropriate mask OTX2_FLOWER_MASK_MPLS_NON_TTL

Assuming this is for net-next, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

