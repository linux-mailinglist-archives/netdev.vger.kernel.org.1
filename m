Return-Path: <netdev+bounces-44193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6137D6EB5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B284B20E71
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318802AB2D;
	Wed, 25 Oct 2023 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSJJaTM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DA29432;
	Wed, 25 Oct 2023 14:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D6C433C8;
	Wed, 25 Oct 2023 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698244150;
	bh=Ix20120weNMmvfY4E3/6k1Qf3kxX8RqfeojT8Bmf7ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSJJaTM9HVoq8mS+Uu800KIlFmTE4Kb4qjPN7iEDMt6H5/SxaDFMfUDHcz9RTnkYM
	 qcCp5DpxC5Z4m0FA9EIrWAtrI37dqeOTFMJwRMDA38GHMwGDv0f+/yMOU0UtkhLIDq
	 KyAXdke9riD0SidUPW8WvZ/sM2tRmZzR+ACnJ/LzskQxWEuQv/yz5Ig1JjSP0vwR+G
	 asO0aSOrM2qgRppiq/YMF1vYjn8/hyBc0JIRm3UBsIkO/9GirAweHk3QU0Ipmx9WX7
	 t0BmH5N4chPjsR1Vjowji4BYqkZ3QMeOU9fnx+nIOOKsX+TJWXo0A+xytvnK5idlpX
	 t4x7lvqDfy2pg==
Date: Wed, 25 Oct 2023 07:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, patchwork-bot+netdevbpf@kernel.org, Linus Walleij
 <linus.walleij@linaro.org>, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, f.fainelli@gmail.com, edumazet@google.com,
 pabeni@redhat.com, kabel@kernel.org, ansuelsmth@gmail.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, robh@kernel.org,
 vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v7 0/7] Create a binding for the Marvell
 MV88E6xxx DSA switches
Message-ID: <20231025072908.54f71143@kernel.org>
In-Reply-To: <20231025093632.fb2qdtunzaznd73z@skbuf>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
	<169822622768.10826.14051215485905127447.git-patchwork-notify@kernel.org>
	<20231025093632.fb2qdtunzaznd73z@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 12:36:32 +0300 Vladimir Oltean wrote:
> Can you please revert this series? It breaks the boot on the Turris MOX
> board.

Done!

