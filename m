Return-Path: <netdev+bounces-37263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3787B4767
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7168B281B11
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604CE17738;
	Sun,  1 Oct 2023 12:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D717728
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D041C433C7;
	Sun,  1 Oct 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696163091;
	bh=60Jvv/Pm2PQ/Yz/ve2h3Ch8pPQyPw2+hMP/ocOFmqxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LU/VU39MeIZafsdLU1IGGQOSAP1F4b2/uUhGtdrafCRP27AbfZ+wYnWgjGressAuk
	 ZxszmyylMKtxWOYoD82cfsq3hg7g/sO4eyBF+4DIiocOH0T2NpTf05++AA+Nll2K9g
	 486xbmG81EFLJUFX4+6oL/1kUBwueeG3X9TvoiZZu424PX4ZsxaL/+USQflUXQ7bvM
	 XY5o/qz+N9O/x8oONtzmVFi4OlYb1DcD+IubgWbGNn81uqbMv+Wf8V5BCBip8OT4As
	 ESPUI6LZKh82yDPR8a002qHif70K023W846IggV/eKKqVWclFWTNMZf0S9iQX0olkB
	 iamK58LXFAWFw==
Date: Sun, 1 Oct 2023 14:24:47 +0200
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 07/14] can: m_can: Add tx coalescing ethtool support
Message-ID: <20231001122447.GO92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-8-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-8-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:57PM +0200, Markus Schneider-Pargmann wrote:
> Add TX support to get/set functions for ethtool coalescing.
> tx-frames-irq and tx-usecs-irq can only be set/unset together.
> tx-frames-irq needs to be less than TXE and TXB.
> 
> As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
> enabled/disabled individually but they need to have the same value if
> enabled.
> 
> Polling is excluded from TX irq coalescing.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


