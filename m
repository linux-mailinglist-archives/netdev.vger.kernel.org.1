Return-Path: <netdev+bounces-29102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD37819E0
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CD7281ADC
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88F6AB5;
	Sat, 19 Aug 2023 14:07:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7F46BC
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F1EC433C8;
	Sat, 19 Aug 2023 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692454021;
	bh=mG9AJibpgTEw4OQFJfsT86K1aQai2EUC1eO9zBsc5Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+IjgaLFnzffHx/6mkHzAwqdpQKH2GRibcrBq83u62Eng5RRc/n0fPIMbzWrpHdKv
	 Ox/HvAErvXFlhf9o5jKeHZ+JZy7ZD5SJmNlJO6BMRSNL7k9mdhkRoGzOVaWFScMxV5
	 tmHIpoAntWP2pfif/7IX2q1cppMWYeh4w0IST7T4DWRooDwon7urOHzYu4sEYXBVCb
	 2LeravRGm/B7xWdyTDllG5ijH1eF9ylzwcu0iNzm3fcfjZRyDbWsnUUTcfbXgjBqED
	 qufLxSyxamZM9GWKQYwigqM03AjHlmLqswuX2X5FvN7VA6qVrwVZjYpufETNZxcyeN
	 jawUF0YeS8MJw==
Date: Sat, 19 Aug 2023 16:06:56 +0200
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: xgene: remove useless
 xgene_mdio_status
Message-ID: <ZODMgEoKKhtlqYv0@vergenet.net>
References: <E1qWxjI-0056nx-CU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qWxjI-0056nx-CU@rmk-PC.armlinux.org.uk>

On Fri, Aug 18, 2023 at 12:33:24PM +0100, Russell King (Oracle) wrote:
> xgene_mdio_status is declared static, and is only written once by the
> driver. It appears to have been this way since the driver was first
> added to the kernel tree. No other users can be found, so let's remove
> it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


