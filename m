Return-Path: <netdev+bounces-218843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D5B3ECE0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5647A279D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6D2DF13C;
	Mon,  1 Sep 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sshll6/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374032F777;
	Mon,  1 Sep 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746239; cv=none; b=LdwZ4SFNonIWl01Ae/3nPxNk7irAl36un0T1fynTjmoZiHAU+uHdnJjgaA0v9RmG5Farw3RmHVOsI0jFBT3R4F2Jx7UwdHKXmkdZ8Ly8em6gBa908/kiQ8483tpvPGHQ4BIDRvKWJc4P1gTCOb3Z/cxQvLhrYI1ELktBFk5dSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746239; c=relaxed/simple;
	bh=7vw7aKVwQgQZE75ooS+4W12By7oKTKW2QfDfvc/Gkqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N/zTImhabMyqrF+9oBgBk+PUaYcjbOWqE+2Qe4ofJD+C1J1qJ5BuFOqYVLpWD2g84vLkH2ELkofssH8H4WCt4zwzc1qM3mZhBuR31+HbtAiliUOBgHHzNxzmNKQ6+NO6Zrwg7hQGt+qbW0Wz8fyZHBNwd83gtCIuIb4O45NPUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sshll6/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF61DC4CEF1;
	Mon,  1 Sep 2025 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746239;
	bh=7vw7aKVwQgQZE75ooS+4W12By7oKTKW2QfDfvc/Gkqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sshll6/zmnjzbzUim4kpGfSgkHwtQlOkFj8OZQZy0LyTJz9ILhAqeKvJJkrnb+jCk
	 QgHSGHnzlTHrf8jaIUfBVty2hCMqm3mRdWOCD8zw10tjjYTclV0H6htcWuHfQCGB5q
	 utea7N54QDxbVXZbRs9sxOjXJ0AXgQzF8WIXW4vBLIH4f57CAzaEaOFDi/1saFtkB6
	 IxwkHWkVYf65d/Jsg2+hamOdQDFFU1VNCIgxZCA876FSLa6lG1gyz7TNFlupYyCPUI
	 8TgjRWPXo0IqNZHqYLc17zc6ekF3SQHI3HUnknS7BHR7dlGt6iArJdrFB/2waOgqMU
	 celef1YCYsCGA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michael Walle <mwalle@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nm@ti.com, 
 vigneshr@ti.com
In-Reply-To: <20250819065622.1019537-1-mwalle@kernel.org>
References: <20250819065622.1019537-1-mwalle@kernel.org>
Subject: Re: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID
 setting
Message-Id: <175674623530.175374.344829536743551293.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 22:33:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 19 Aug 2025 08:56:22 +0200, Michael Walle wrote:
> Some SoCs are just validated with the TX delay enabled. With commit
> ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
> RGMII TX delay"), the network driver will patch the delay setting on the
> fly assuming that the TX delay setting is fixed. In reality, the TX
> delay is configurable and just skipped in the documentation. There are
> bootloaders, which will disable the TX delay and this will lead to a
> transmit path which doesn't add any delays at all.
> Fix that by always writing the RGMII_ID setting and report an error for
> unsupported RGMII delay modes.
> 
> [...]

Applied, thanks!

[1/1] phy: ti: gmii-sel: Always write the RGMII ID setting
      commit: a22d3b0d49d411e64ed07e30c2095035ecb30ed2

Best regards,
-- 
~Vinod



