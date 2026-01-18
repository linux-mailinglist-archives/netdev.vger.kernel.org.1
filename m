Return-Path: <netdev+bounces-250764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B7D391EC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 774E5300D48F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6731A23B1;
	Sun, 18 Jan 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXUMrdZu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BF1A0BD6;
	Sun, 18 Jan 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696800; cv=none; b=Q3EowuR7dN0AbOP+KKB/ekd69nTkP+oxDo+wcUkQtYSmT6LGbiDj34jHYsx87sFG26Qrn14a5PmwI2t5OzS40nHipVLoaKBMn2hWmvWLy2TNAJlSxDVTOAK0vMgCxntgZb9PYxZlB7P2wYBZvF9wTqkmznu0gOlAV7+0emqbdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696800; c=relaxed/simple;
	bh=JOMzlbjEYAu3IpvWobSaz3SfzdMIkWCD5XGyMAZi0hg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBeQ3suvtzA+2vr/2JoFfvPrfdFoYAnyJnXsotg8GsVmqbRoonvs6fEZYJPge6v+Prqvlf0MRRAxQRw0fyluM2DRICYp2Lw9W7eVCtce7d6e8rwAqtjNL4sihOKYmlOzEhrNPOBaDxD63dyf1HK2li886wH2ktCF734opB8Ag4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXUMrdZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F9C4CEF7;
	Sun, 18 Jan 2026 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696800;
	bh=JOMzlbjEYAu3IpvWobSaz3SfzdMIkWCD5XGyMAZi0hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hXUMrdZuMguYz5S2ut+k96flzMQlpH51K540P84jivio/Ona2GVWNuJP3DieL6AUT
	 IRyr76PmYZKt31AjB7WvD0Zc8gQePM2z1O078Geyj/U2cMVs7ZeJ26tU3713UTlMRZ
	 +mG9pzlNYs/ljLXpi2copIYlmE+JKm3KAo0b+yK8K7C0jVV27AquMDry/p67q3Q+UO
	 MYRk7qmoh5skQcnwiyUCg6gkzVg0tK9Fo7e7017ts5oYAGLezgqzNeFUk4iKcanDaK
	 09wMZ2+X/Gvu+EMFnzCM+hofVC30LMSnMVffkuSa22137oWUoFgInhZexWlS/VffH+
	 Jcj/CAJRHGnTQ==
Date: Sat, 17 Jan 2026 16:39:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v4 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <20260117163959.5e949a25@kernel.org>
In-Reply-To: <20260113101658.4144610-2-rkannoth@marvell.com>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
	<20260113101658.4144610-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 15:46:46 +0530 Ratheesh Kannoth wrote:
> +static void npc_subbank_srch_order_dbgfs_usage(struct rvu *rvu)
> +{
> +	dev_err(rvu->dev,
> +		"Usage: echo \"[0]=[8],[1]=7,[2]=30,...[31]=0\" > <debugfs>/subbank_srch_order\n");
> +}

I'll release the AI code review results, but as mentioned on Wednesday
- please try to finish up the devlink array config thing instead.
debugfs is for debug.

