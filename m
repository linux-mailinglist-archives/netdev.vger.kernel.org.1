Return-Path: <netdev+bounces-141355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D569BA874
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036B21C20BB5
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31E18B473;
	Sun,  3 Nov 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA6z1/0g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447EF9E4;
	Sun,  3 Nov 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671589; cv=none; b=tZ3tPKCYyovGVlI1FMm27prytUI4a9cO0rW5cklCdNTYZ02MeF8CUsDiVp978Y1TGVMW2PboC0sr6EWEFM7jJtSlqEcpat3goIs5prQcCYlgTlncAiPZs3C/8ngLpYYN0ZEy25oABbw/Q+CcBFZoUxXYuSJAuoZYR2kiAiWwAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671589; c=relaxed/simple;
	bh=rlqoMFq10ZGh40ITSHFrZ5Wqc9lntsbV8HG9t+GV74s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlByQjijSsWsrwHuTfV85pHDSaDFbvUEB3sP1tNRP7s25jmfYwKAM2wNaj3z/b5HQULnX63AT58zVYnEY3CJTrjMazrVUDgJC0f4SDM8fQofn5kZ8XkVVO9zdjqzwJOp1NvNRKIKs9XxpmIIP0OOeJ+8tQvHBD1dLggZBJ4yhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA6z1/0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C58C4CECD;
	Sun,  3 Nov 2024 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730671587;
	bh=rlqoMFq10ZGh40ITSHFrZ5Wqc9lntsbV8HG9t+GV74s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uA6z1/0gaLTnd3+XQ8i4mXGCwSOzkAfqsAowHY9kvcTDFQiiex9DxOkYcX/2oZvLW
	 65AfdWoEbTgQYHRIiGYMuPQLNWhJHZCOo2IZII0oc0v40KzICSVKduZ6WZ1sv0xbcv
	 nvCy1Iq3no/u+1/BTiCSGkBkWBOc1lD3ARjwsEv2K1EfgfzI9vp2TnL6FhcbZP3qMk
	 mI/FpXaZ9ZqYomTXzet1Ga/78YvbisXZ40rKyRDT40hVQyajg+QsXbxfAnaZpYBu+R
	 ep/TmF/uGOcA37EyPiuS8rj2Brd+ZCQ9wN+Ytq454ZQ3W/V2DCa8wBnGGRyieptew7
	 9pOXET6h9KnnA==
Date: Sun, 3 Nov 2024 14:06:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: patchwork-bot+netdevbpf@kernel.org, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, olteanv@gmail.com,
 akpm@linux-foundation.org, krzysztof.kozlowski@linaro.org, arnd@arndb.de,
 bhelgaas@google.com, bagasdotme@gmail.com, mpe@ellerman.id.au,
 yosryahmed@google.com, vbabka@suse.cz, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
Message-ID: <20241103140626.62d46216@kernel.org>
In-Reply-To: <769445b8-e9e3-4e18-93dd-983240ba0bf9@lunn.ch>
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
	<173066763074.3253460.18226765088399170074.git-patchwork-notify@kernel.org>
	<769445b8-e9e3-4e18-93dd-983240ba0bf9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 22:12:32 +0100 Andrew Lunn wrote:
> > On Thu, 31 Oct 2024 10:33:29 -0700 you wrote:  
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > > Changes in v2:
> > > 
> > > - add self to CREDITS
> > > 
> > >  CREDITS     | 4 ++++
> > >  MAINTAINERS | 1 -
> > >  2 files changed, 4 insertions(+), 1 deletion(-)  
> 
> Hi Jakub
> 
> I could be wrong, but i thought Andrew Morten already applied this?

Thanks for the heads up, I don't see the list getting CCed on any
notification.

Andrew, please drop this from your tree.

