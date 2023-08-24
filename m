Return-Path: <netdev+bounces-30361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A84787033
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42211C20E31
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE78728906;
	Thu, 24 Aug 2023 13:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFB288E8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDBBC433C7;
	Thu, 24 Aug 2023 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692883618;
	bh=ZsW3prl8w4T4P2bsAVNCnXSIvm0wiRqqLXGDRkAWsQw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NWgu4UQ0OixhAYi9nTrfuYg+8ntCaTHvz/06SAdPExjouDYmyD7PR+j61sBpwiuXV
	 iIDdlMSfAGUfiaLBB9aWDeHPG6+Nl6FFpcHatfED80RohGzc5oib/R4ZIjqR8OpylA
	 m9uP8DA44ongAZvRWekBb0WSO6Znu9IO+LI1bmDrh8WgAiFtEVAC5sLe4+y6v5LtEu
	 iBog2g8bLk1kHqsG4sYgPbttFIMgghmMNwDrmCvV4W4yxJrRUFl0Ee37hvVeZE9KkI
	 DvhSSd4THuNK7prHtNTgQexGK1DRogGt2sG1RsLOyhgbIranYaCUYOh/6NRkh/gfaC
	 Ng0GQrSRrCfZg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230824091615.191379-2-radu-nicolae.pirea@oss.nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com> <20230824091615.191379-2-radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [RFC net-next v2 1/5] net: macsec: documentation for macsec_context and macsec_ops
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
To: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>, andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk, pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net, sebastian.tobuschat@nxp.com
Date: Thu, 24 Aug 2023 15:26:54 +0200
Message-ID: <169288361453.5781.18200652512492828409@kwain>

Hello,

Quoting Radu Pirea (NXP OSS) (2023-08-24 11:16:11)
> =20
>  /**
>   * struct macsec_context - MACsec context for hardware offloading
> + * @netdev: pointer to the netdev if the SecY is offloaded to a MAC
> + * @phydev: pointer to the phydev if the SecY is offloaded to a PHY
> + * @offload: MACsec offload status

As this selects were the offload happens and how the two previous
pointers can be accessed, might be nice to be a bit more explicit in the
comments.

> + * @secy: pointer to a MACsec SecY
> + * @rx_sc: pointer to a RX SC
> + * @assoc_num: association number of the target SA
> + * @key: key of the target SA
> + * @rx_sa: pointer to an RX SA if a RX SA is added/updated/removed
> + * @tx_sa: pointer to an TX SA if a TX SA is added/updated/removed
> + * @tx_sc_stats: pointer to TX SC stats structure
> + * @tx_sa_stats: pointer to TX SA stats structure
> + * @rx_sc_stats: pointer to TX SC stats structure

s/TX/RX/

Thanks,
Antoine

