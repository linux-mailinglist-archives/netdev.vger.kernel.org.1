Return-Path: <netdev+bounces-43163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C837D19DE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD7B21305
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2462F364;
	Sat, 21 Oct 2023 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUzv6kl8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4A362
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042E5C433C8;
	Sat, 21 Oct 2023 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697847702;
	bh=JLVCFPS9n2+33q7bJ21lPZev0WogxM0z1ufKw+/bbgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUzv6kl8RuaD6IsYol/bRb7WqlHaJzdRft7iXYjLlVHPgY2W0lt7tDek+fSceK4Pb
	 LmSIbvb/r+yRWvdifgAHzTMrP5QNs4dagHauTRoGiOVXtOMcRM/ecdUAPmQngSl+f4
	 Bs7fQEHYvKUpntZz3LwwQEBS/dJjnpUeqKzmT1SEBL3W+x2clk998+28Pd/4qNa5uj
	 950IH/xcUnZN5reojytbMSrkpNDOuYD/SJgHggV9ydQrvdaQq8MVjtehEhwxZqdjjb
	 CmIg0pwJmH87axy8QtYE4zLEg3f7lhk6h9xBX6igOslR9WSnUpxsseWMFrUc5doVJA
	 QuqKoSBqneE4A==
Date: Fri, 20 Oct 2023 17:21:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Rob Herring <robh@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support)
Subject: Re: [PATCH net-next v6 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231020172141.0efaeb20@kernel.org>
In-Reply-To: <20231018175820.455893-2-florian.fainelli@broadcom.com>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
	<20231018175820.455893-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 10:58:19 -0700 Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

This got marked as Changes Requested, I think it no longer applies :S

