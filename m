Return-Path: <netdev+bounces-138030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2109AB9DD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51121B21A64
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D91CDFDC;
	Tue, 22 Oct 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbuuya35"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A48174EFC;
	Tue, 22 Oct 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638630; cv=none; b=OA6EPy+lJ/TUOO2lb5JKLPh9Y/zSCMZRosrxI1ezUI/c6JqyB/kqbpBJhzhOkdDD9qpEZ4A+7PJ2I0/ZucUkfQuUecYJaVsWE/Umpq96SMaN9PW/8E684F+GJHfvHCjpaka0P7dSY7HLSnarBKs69w6EmMECXD7X/sxY1N+Lm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638630; c=relaxed/simple;
	bh=oIY+Jejd6DvtwoQcBrHvHivyMxddJJ/0ErQ5Nt9+1Cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aYZ9BSITdMa+UK2PumurlGEV863faHL1pKuoz580hMQD+qt1TlBWFqQGwepYcvi5qp4hxisYvslHgA0o6sf4I0s3oqsQwHeVkIQVRfRmpSPhHI1yZoPHaLDJZK/4hkjrx0h5KFf8Zat13wPVOsebejGtizWgQT82CDYsMUa3JYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbuuya35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E964BC4CEC3;
	Tue, 22 Oct 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638630;
	bh=oIY+Jejd6DvtwoQcBrHvHivyMxddJJ/0ErQ5Nt9+1Cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hbuuya35Eze7JoArtWtg4fNliHbkr3mHe3PTrAGpANa+xfw8mlxLUCbwl2pcOPFl5
	 mVC6yRJhn4+0sN4uRKkTasJfHebAsRU9+TFp6eS9bTZStGyxpb+hZSl3p7bL7VqRe4
	 cW2JKdprPIkfaoJgDbTAcWsIYpeOVynOd7soot1c6q4vJGjCaLr3EaaruSHHme4h+O
	 PiNmn8pr0bn4JCnAGRlql+ANBuXwxToldYzu20UKXCWCWVqZrrcT5Ob2N2xDMXXDRP
	 v2ay+fzybc02Tg7jxoG1vPQCzRmr0/lN466MKAWAL4aMORr5mgLjU3DtlyAFXPzX3i
	 11ZBw9TARW+6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2D3822D22;
	Tue, 22 Oct 2024 23:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172963863599.1106081.17720892184473562602.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 23:10:35 +0000
References: <20241017185116.32491-1-kdipendra88@gmail.com>
In-Reply-To: <20241017185116.32491-1-kdipendra88@gmail.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 18:51:15 +0000 you wrote:
> This patch series improves error handling in the Marvell OcteonTX2
> NIC driver. Specifically, it adds error pointer checks after
> otx2_mbox_get_rsp() to ensure the driver handles error cases more
> gracefully.
> 
> Changes in v4:
> - Patch series thrading fixed.
> - Error handling changed in otx2_flows.c.
> - Used correct To: and CC:
> 
> [...]

Here is the summary with links:
  - [v4,1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
    https://git.kernel.org/netdev/net-next/c/0fbc7a5027c6
  - [v4,2/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
    https://git.kernel.org/netdev/net-next/c/e26f8eac6bb2
  - [v4,3/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
    https://git.kernel.org/netdev/net-next/c/bd3110bc102a
  - [v4,4/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
    https://git.kernel.org/netdev/net-next/c/ac9183023b6a
  - [v4,5/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
    https://git.kernel.org/netdev/net-next/c/f5b942e6c54b
  - [v4,6/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
    https://git.kernel.org/netdev/net-next/c/69297b0d3369

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



