Return-Path: <netdev+bounces-34271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542B7A2F7C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50B9282178
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A9134AE;
	Sat, 16 Sep 2023 11:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C4134AF
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 11:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6E82C433C7;
	Sat, 16 Sep 2023 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694862626;
	bh=dKBVwTAnR8pm3oQ3VFPCXZvzxDLCh5pdvRqPBtO8CJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VDEobGWDrko9Qh3KswPUaKhDob8aFp5KymF3j3r8sm5Bg7rn45pFg/v64gJryyK7q
	 1YhQw+SdmPsNtZNMBKMiVbyNao4ImoT2JWRVGp6XT7j30m7a8cR9VCez/h+CV5CfFX
	 ZB2xrABOJi4pIL2sNxBic9XD18oWBcs4VoO/be6S/lwxo0RLyVfVaJAJzi8SogCjOR
	 9renmZfW331+kgi7Ws4WrwWDgAMb5L9kq3T2HKbm0oLqzYsr/+PD2BX81ZVR9P9D4d
	 CD75QMmgWSXOaqXR5TjyUD255fJQGOjQI7pTcwTU/RDah450NNwPWyNSrmWxyoEavm
	 uVFfhqJKTqbhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 862D5E26882;
	Sat, 16 Sep 2023 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/15][pull request] Introduce Intel IDPF driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486262654.12966.15566528016633695728.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 11:10:26 +0000
References: <20230913222735.2196138-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230913222735.2196138-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, pavan.kumar.linga@intel.com,
 emil.s.tantilov@intel.com, jesse.brandeburg@intel.com,
 sridhar.samudrala@intel.com, shiraz.saleem@intel.com,
 sindhu.devale@intel.com, willemb@google.com, decot@google.com,
 andrew@lunn.ch, leon@kernel.org, mst@redhat.com, simon.horman@corigine.com,
 shannon.nelson@amd.com, stephen@networkplumber.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 13 Sep 2023 15:27:20 -0700 you wrote:
> Pavan Kumar Linga says:
> 
> This patch series introduces the Intel Infrastructure Data Path Function
> (IDPF) driver. It is used for both physical and virtual functions. Except
> for some of the device operations the rest of the functionality is the
> same for both PF and VF. IDPF uses virtchnl version2 opcodes and
> structures defined in the virtchnl2 header file which helps the driver
> to learn the capabilities and register offsets from the device
> Control Plane (CP) instead of assuming the default values.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/15] virtchnl: add virtchnl version 2 ops
    https://git.kernel.org/netdev/net-next/c/0d7502a9b4a7
  - [net-next,v7,02/15] idpf: add module register and probe functionality
    https://git.kernel.org/netdev/net-next/c/e850efed5e15
  - [net-next,v7,03/15] idpf: add controlq init and reset checks
    https://git.kernel.org/netdev/net-next/c/8077c727561a
  - [net-next,v7,04/15] idpf: add core init and interrupt request
    https://git.kernel.org/netdev/net-next/c/4930fbf419a7
  - [net-next,v7,05/15] idpf: add create vport and netdev configuration
    https://git.kernel.org/netdev/net-next/c/0fe45467a104
  - [net-next,v7,06/15] idpf: add ptypes and MAC filter support
    https://git.kernel.org/netdev/net-next/c/ce1b75d0635c
  - [net-next,v7,07/15] idpf: configure resources for TX queues
    https://git.kernel.org/netdev/net-next/c/1c325aac10a8
  - [net-next,v7,08/15] idpf: configure resources for RX queues
    https://git.kernel.org/netdev/net-next/c/95af467d9a4e
  - [net-next,v7,09/15] idpf: initialize interrupts and enable vport
    https://git.kernel.org/netdev/net-next/c/d4d558718266
  - [net-next,v7,10/15] idpf: add splitq start_xmit
    https://git.kernel.org/netdev/net-next/c/6818c4d5b3c2
  - [net-next,v7,11/15] idpf: add TX splitq napi poll support
    https://git.kernel.org/netdev/net-next/c/c2d548cad150
  - [net-next,v7,12/15] idpf: add RX splitq napi poll support
    https://git.kernel.org/netdev/net-next/c/3a8845af66ed
  - [net-next,v7,13/15] idpf: add singleq start_xmit and napi poll
    https://git.kernel.org/netdev/net-next/c/a5ab9ee0df0b
  - [net-next,v7,14/15] idpf: add ethtool callbacks
    https://git.kernel.org/netdev/net-next/c/02cbfba1add5
  - [net-next,v7,15/15] idpf: add SRIOV support and other ndo_ops
    https://git.kernel.org/netdev/net-next/c/a251eee62133

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



