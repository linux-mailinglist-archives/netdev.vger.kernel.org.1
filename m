Return-Path: <netdev+bounces-19342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639475A529
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AC31C212D3
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2B17F4;
	Thu, 20 Jul 2023 04:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018E1385;
	Thu, 20 Jul 2023 04:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80CC433C8;
	Thu, 20 Jul 2023 04:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689827850;
	bh=wtXXdLVLfi99i9vNuFnHhlk19NvlcTjhBzB3ICdAvko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oR77DCAfnIF9ROq994H/Xxvg6BqQ/PtjhVzf+zqKANe+7KHHpQeBCXRhkn2gEIApa
	 4AEtuJvpN/O2Pq0MQUp2W3fVWVr5ZpIt2dOpJA1v2CMAIj6rZbaOvwP7MJSOP5rHpl
	 eN3abGN/HXKPbVB6+uP2nGODF333tccSEw3RJFHu+A8YgWydSjSHMBQc4b2EmqEBB8
	 j9sNLkytr2JIA2K+dgRuw3tAL5v5VPEiY5vLjEaUbrB8Ry909OMyx1XSwlowZEeqwN
	 NncHiCRCejDM5uu7qVfuMCeVjiOLbue/PQC9KOthxIiGJfyGXSOV/InTxkfImD/5xX
	 lDqVrn8LUChMw==
Date: Wed, 19 Jul 2023 21:37:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc: mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
 manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
 quic_krichai@quicinc.com, quic_skananth@quicinc.com, andersson@kernel.org,
 simon.horman@corigine.com, dnlplm@gmail.com, linux-arm-msm@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH V3] net: mhi : Add support to enable ethernet interface
Message-ID: <20230719213728.65118446@kernel.org>
In-Reply-To: <1689762055-12570-1-git-send-email-quic_vpernami@quicinc.com>
References: <1689762055-12570-1-git-send-email-quic_vpernami@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jul 2023 15:50:54 +0530 Vivek Pernamitta wrote:
> Add support to enable ethernet network device for MHI NET driver
> currenlty we have support only NET driver.

There discussion on v2 doesn't seem to have ended.
-- 
pw-bot: cr

