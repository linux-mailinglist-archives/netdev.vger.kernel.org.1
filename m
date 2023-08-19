Return-Path: <netdev+bounces-29010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243078166B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBFE281DF2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25793645;
	Sat, 19 Aug 2023 01:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C7634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA794C433C8;
	Sat, 19 Aug 2023 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692408795;
	bh=eQsDnVRcEoBkIR035KXsBsK1ZgEoecLvJBhlfQqPdvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oo2h163uvr5HkeY9eXN8I13GpuAxwj82iwdkWJRNvXGueeQjJzVI1wg2ww2kootiX
	 BOVZEjnlMwvuagtOGJGXD+ULBRIQfFEwLJPBtTSvvhRmE2lvfkSgfJMGiWTWNUBl2d
	 eTyxlrW/En3wvKguy8EPt/fnSJdJvAT24dS3aYurZN44OggxY2hzJ707984EvwAS9W
	 BFzf8J57P3niIwJ14Kk309Z80y3ivkjKHJT83nrDEmttwQPFzuE1uXjenECTkDwWiX
	 qBtqnSltRcmeOJJKhc4AEcTtN4nZlF/7ash+D3wKJZDjrrLQUnvknu8PrWTyiPErSx
	 WVyc4zzWA3NJQ==
Date: Fri, 18 Aug 2023 18:33:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sujuan Chen
 <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix NULL pointer on hw
 reset
Message-ID: <20230818183313.52f9b9f3@kernel.org>
In-Reply-To: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
References: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 13:01:11 +0100 Daniel Golle wrote:
> Initialize the hw_list will 0s and break out of both functions in case
> a hw_list entry is 0.

Static variables are always initialized to 0, I don't think that part
is need.
-- 
pw-bot: cr

