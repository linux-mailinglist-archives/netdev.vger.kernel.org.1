Return-Path: <netdev+bounces-36774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B017B1BC9
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 50C9D281FC8
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6A38BAF;
	Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1D328AD
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21915C433C9;
	Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695903024;
	bh=cVOcf7Wupqr8J1dsGsFLOc3bos3BO3TBtGp9C9LDHpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZyX1r7Pjp69JEbO1pa5UDhFga1vMMKml3FPRDh5wueS/NZNKVpmZZ/EcVAWJcPWS
	 1fLq5P5QRxFq39mZbeipxppfYZK8xRvJcATd80BqKwLxdZ6nvx1qZ7XLfPSstPyZPd
	 aJ4caxIrfY/d7sESNNMJdg6bE4EUXzWCaHGmPxrDKGdulyGhwOxN5yNq9GU7vBcdSv
	 I+7bN7S8n0HwAIoYsojZhO5KGVJQ6AKOc83bxdFcEWPPHgiUdB32ZVlnr769F819kH
	 h4J/zmEHdMLSbawq8CIPF3zM8FOa47iliKxvZHcvLBE3CcnaRwYUSn11YFK7sBVgh6
	 yh68Joj+uoW9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 082FBE29B00;
	Thu, 28 Sep 2023 12:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: always add legacy 32byte RXDID in supported_rxdids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169590302402.1991.14030271738897322227.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 12:10:24 +0000
References: <20230920115439.61172-1-mschmidt@redhat.com>
In-Reply-To: <20230920115439.61172-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 leyi.rong@intel.com, michalx.jaron@intel.com, mateusz.palczewski@intel.com,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Sep 2023 13:54:38 +0200 you wrote:
> When the PF and VF drivers both support flexible rx descriptors and have
> negotiated the VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC capability, the VF driver
> queries the PF for the list of supported descriptor formats
> (VIRTCHNL_OP_GET_SUPPORTED_RXDIDS). The PF driver is supposed to set the
> supported_rxdids bits that correspond to the descriptor formats the
> firmware implements. The legacy 32-byte rx desc format is always
> supported, even though it is not expressed in GLFLXP_RXDID_FLAGS.
> 
> [...]

Here is the summary with links:
  - [net] ice: always add legacy 32byte RXDID in supported_rxdids
    https://git.kernel.org/netdev/net/c/c070e51db5e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



