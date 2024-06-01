Return-Path: <netdev+bounces-99951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B98D72AC
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B842813C2
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3539FEB;
	Sat,  1 Jun 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaXCDTOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB822F1E
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283433; cv=none; b=GCl9pNbqP3MHiLzWZXlAiQKVXkiBZWwmbUhG9EEkrSnt7wD7lt8Um5Sxk/xf6S03GJDRSf4ltQKNc6jrp76p4/c4KcSo6xBaKRRx/2d4zk0C9ZtUXOkp/87Z2hOpDY8sKwyQOGAn6fjQ7esTNh6qABwM9ADFBEu+FQ2a+CffQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283433; c=relaxed/simple;
	bh=xc5D6iinK+ZdTIWBCQ93YABmH3bdBh266+L6Y+YFahM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EN/1mObHZIaSJvUn6Lvsi+O3PhinIDeXv58+KglItUd5o8R34pqmuKpLXo02y6UjVNQ1k2Q/lQwyiDJBSLxENMj9d1YWWqVZOFP0oFY5lMKw28jMq2+iGE8Qvwe/1kZNNAs7vvCbpjSYMUjx7vmSM/ey5HfOLVFoLf1bXc1dm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaXCDTOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78560C32786;
	Sat,  1 Jun 2024 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717283432;
	bh=xc5D6iinK+ZdTIWBCQ93YABmH3bdBh266+L6Y+YFahM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaXCDTOb7bsWL6z9vUXgjBwPt9K7QB+/JJ/tBzmXxhEPG7fhuEE6shHgPJ+OE3sRt
	 rDbpEsuRVTjoCtSPbVLwfVxRLzM3ou6RJPEjAp/tXthBZLgYmLqSJnfJwS8LXePk4l
	 5N9U947bQ8082fY6eKQz+QFhAq24ml6SIATR6NycKlWhUUDECU2PkdQ5oneFRCP7Fa
	 MMqn75lWkB61CdH/MXUk0c1zQajixMAtzGs81h3Bkfzcrpvd0wI64BaQAxGDecEOiS
	 QFpX1nshdQodSPVjh6sXaMuWJ1uBs9xCeToa3ZESqDySw+5pJOMEiAqgP9NVukqxWl
	 nDiIOgshhpznw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65EEADEA711;
	Sat,  1 Jun 2024 23:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next 00/11] ice: Introduce ETH56G PHY model for E825C
 products
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728343241.8366.1128871642096497353.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:10:32 +0000
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
To: Keller@codeaurora.org, Jacob E <jacob.e.keller@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 jiri@resnulli.us, karol.kolacinski@intel.com, przemyslaw.kitszel@intel.com,
 arkadiusz.kubalewski@intel.com, himasekharx.reddy.pucha@intel.com,
 sergey.temerkhanov@intel.com, michal.michalik@intel.com,
 grzegorz.nitka@intel.com, prathisna.padmasanan@intel.com,
 pawel.kaminski@intel.com, mateusz.polchlopek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 16:03:50 -0700 you wrote:
> E825C products have a different PHY model than E822, E823 and E810 products.
> This PHY is ETH56G and its support is necessary to have functional PTP stack
> for E825C products.
> 
> This series refactors the ice driver to add support for the new PHY model.
> 
> Karol introduces the ice_ptp_hw structure. This is used to replace some
> hard-coded values relating to the PHY quad and port numbers, as well as to
> hold the phy_model type.
> 
> [...]

Here is the summary with links:
  - [next,01/11] ice: Introduce ice_ptp_hw struct
    https://git.kernel.org/netdev/net-next/c/d551d075b043
  - [next,02/11] ice: Introduce helper to get tmr_cmd_reg values
    (no matching commit)
  - [next,03/11] ice: Implement Tx interrupt enablement functions
    (no matching commit)
  - [next,04/11] ice: Add PHY OFFSET_READY register clearing
    https://git.kernel.org/netdev/net-next/c/c199b31a043c
  - [next,05/11] ice: Move CGU block
    (no matching commit)
  - [next,06/11] ice: Introduce ice_get_base_incval() helper
    https://git.kernel.org/netdev/net-next/c/1f374d57c393
  - [next,07/11] ice: Introduce ETH56G PHY model for E825C products
    https://git.kernel.org/netdev/net-next/c/7cab44f1c35f
  - [next,08/11] ice: Change CGU regs struct to anonymous
    https://git.kernel.org/netdev/net-next/c/b390ecc2e375
  - [next,09/11] ice: Add support for E825-C TS PLL handling
    https://git.kernel.org/netdev/net-next/c/713dcad2a8c7
  - [next,10/11] ice: Add NAC Topology device capability parser
    https://git.kernel.org/netdev/net-next/c/5f847eede638
  - [next,11/11] ice: Adjust PTP init for 2x50G E825C devices
    https://git.kernel.org/netdev/net-next/c/4409ea1726cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



