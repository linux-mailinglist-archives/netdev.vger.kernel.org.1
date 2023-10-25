Return-Path: <netdev+bounces-44297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B87D77B1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B921C209C0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF09374C4;
	Wed, 25 Oct 2023 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWmVxAWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F915AE5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62861C433C8;
	Wed, 25 Oct 2023 22:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698272315;
	bh=7wceXJu0kfijNOlBso72VednjzjibjvHan7ExujoI/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWmVxAWREBOhru7p4LdfDFUEzEY6ZYaeaV757ksoVIEBozJ+Kv1pg8R+b1CwIlnux
	 jaLSj+BcoG5IN4SeI0Yj/YrIjgFAD6I/XkPirB2C98pNbPcGD3yQHmGNDgxEp/iRuJ
	 3TKCiJeAf8hwCPlNLrhZ2rXSc4LzaFFlqRzIjTpalm8V2YbjNFGBQV0wK0BNaqiNZU
	 XOy9gnDK7HGyUDDyCYELCOT9/Ie3shC8KjdVwSaXyJGvW+mHkqFO4R8Rnbwl+g6eds
	 /iuUbmRTNosvWBL1FjQpWBwKRb7OBrnebv7zl08/Eyu/wpM3CDhnPuz6QW+sEneCxq
	 6IrG4B45UCHyA==
Date: Wed, 25 Oct 2023 15:18:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
Message-ID: <20231025151834.7e114208@kernel.org>
In-Reply-To: <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
	<5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 19:21:24 +0300 Radu Pirea (OSS) wrote:
> The state of this patch series was set to "Changes Requested", but no 
> change was requested in V8 and I addressed the changes requested in V7. 
> Am I missing something or is it a mistake?

Another series got silently discarded because of a conflict.
This one IDK. Everything looks fine. So let me bring it back, sorry.
-- 
pw-bot: under-review

