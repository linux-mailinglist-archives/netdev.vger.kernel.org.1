Return-Path: <netdev+bounces-12457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA027379BE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0071C20BE4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455817EC;
	Wed, 21 Jun 2023 03:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856315BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4C7C433C0;
	Wed, 21 Jun 2023 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318306;
	bh=w/WJ4ih3bWFbg0Sp+HP6bcoaz3TM0sRb50HscssW6MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bR88lo4oD30GmFt15WApTVHfKB8r8xfkjaRVADkJ2JAd3VOlMCk29G3bmmZI1xmv2
	 lPQSSuXGnvOTADDXMuDxnR53GTYL03AK9Qi1IeGUvq6aDe5YsuJi0Gy0c3CzvEVfuf
	 z3RHv6PHWulfVdTu6MMytJbovQ9IEoSZOLckkYLml073/3hpTgLNlLlfxbp6AMR6ET
	 n1bAgai8idE+OCjr+6Vuh6aTiQvxLLSYgYSEyU8SfxQWqQ6GMOVU9Tx1D6LfBbyw2l
	 as7BknO4rpEgboGtdj2wcKG82J2/JTFTRuoL2FiNLZm34m649hgx3ftz/oJMEvcKT9
	 v9bDUARK4hfCA==
Date: Tue, 20 Jun 2023 20:31:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP
 interrupt enablig/disabling
Message-ID: <20230620203145.2da7c958@kernel.org>
In-Reply-To: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jun 2023 16:28:51 +0300 Radu Pirea (NXP OSS) wrote:
> Subject: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP interrupt enablig/disabling

typo: enablig -> enabling

> .config_intr() handles only the link event interrupt and should
> disable/enable the PTP interrupt also.

I don't understand this sentence, TBH, could you rephrase?

> Fixes: 514def5dd339 ("phy: nxp-c45-tja11xx: add timestamping support")

For a fix we really need to commit message to say what the problem is,
in terms which will be understood by the user. User visible behavior.

> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
> 
> Where is V1?
> https://patchwork.kernel.org/project/netdevbpf/patch/20230410124856.287753-1-radu-nicolae.pirea@oss.nxp.com/
> 
> Where is V2?
> https://patchwork.kernel.org/project/netdevbpf/patch/20230616135323

This link looks cut off.

> +	/* 0x807A register is not present on SJA1110 PHYs. */

Meaning? It's safe because the operation will be ignored?
-- 
pw-bot: cr

