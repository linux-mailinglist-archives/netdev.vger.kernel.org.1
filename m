Return-Path: <netdev+bounces-53218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B630801A61
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217971F20B53
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB778833;
	Sat,  2 Dec 2023 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnVUOaga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EED399
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 04:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA8C433C9;
	Sat,  2 Dec 2023 04:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701489915;
	bh=uxQmETHLPfyNkyGcnpM4hPLPgPAseia2ALvVF4tnZmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WnVUOagaPsS9/3e9u6mSYKFsxVn3H3/NnhE6AFcnTzFeUsEB5H37QKUf8GCBnFcLe
	 4EgXs1vmtdxMbL+O0I814nF2Kibhr5OAifSx5q6kWt1PSjIhngN8SlgFMTS6CqFSWu
	 5gYv6/nRH2rAEEy/6cgT3DOUG4JOuR+AtFsNhV0ceBo+Pc6mGgDr6FW82rUCOalRHl
	 lVwpXARQ0pdQcIboo7fG5IHRvgvOezgvK8UfovLx7lX0AG4yQWx+x2ns5FZV4y++gE
	 ofznDi8fMgLDR7XdaeXXlrZ/tiPIc1jyOPX14+y2ioMQOu51hevJRMaVHUMPjKKeCT
	 vtA0QLW0uQO/w==
Date: Fri, 1 Dec 2023 20:05:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Reichinger <thomas.reichinger@sohard.de>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: restoring support for multiple Sohard Arcnet
 cards
Message-ID: <20231201200514.1b0b55a1@kernel.org>
In-Reply-To: <20231130113503.6812-1-thomas.reichinger@sohard.de>
References: <20231130113503.6812-1-thomas.reichinger@sohard.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 12:35:03 +0100 Thomas Reichinger wrote:
> commit 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")

Fixes: 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")

right?

