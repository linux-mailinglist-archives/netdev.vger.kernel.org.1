Return-Path: <netdev+bounces-114788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18222944105
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2031C24017
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996F1DA22;
	Thu,  1 Aug 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEdKHBMm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D4634
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478488; cv=none; b=Sobf/V9ezINjNigCiGwDeQRL2xdUVs/FdZpLGborvysk9mWfg4vroh995BneGAt7iiOt1HU0Z838zxR8sTjaV/gThWq6/7K8WocoOsoFU8RNT7ZUkmbThaXO7Z5SNBkrIjZdwJVRWE6iZH1k40Y0GdvhT5sHXarZ4/1YocIZQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478488; c=relaxed/simple;
	bh=Y+HouflKLnWu4d+zOW0Uqd8d+zGq/v3kDr3y2GVAMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjGPRofj52cL8DzPjiHxjI6yJnCRDG2TEgZ016sbhmWjd5sBABasP6w5qLXlNxfCUGPCj8UsQu/bRcGh9ihllpL8sfaVNsW4ZiKuyP7VSiiY5olu4iv3sgRiM9pp36r8XYjg2iuMkfaEH/ddLPSafPrqgEjgbPlJkAQLmGthgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEdKHBMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85F2C116B1;
	Thu,  1 Aug 2024 02:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722478488;
	bh=Y+HouflKLnWu4d+zOW0Uqd8d+zGq/v3kDr3y2GVAMHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEdKHBMmuhL+HJ/Ue6tf1YVwmyUsxccwJTXx0xkt2wufmImbGbSB/a8Dk04CkREXJ
	 EhvdA7JczfUVYw7/x9AGTEgzCnqJ+VM7Yvfns0/NJf7ercilMoZtWWz9IcLcB01Scg
	 MmURYPfkXRIFJQgAns4sCxMqDwkbnHh/1pRqf44Gc0rwm9gqv11dPFyx/5/aaeozWL
	 11acMcv4IlBteeSFGguTLfF3utJF6kaN6+QoVyrb2HI2EkYBuvQKudAcSbikkZMV5e
	 isPCalxr54N8ELpxEtzcp+SNJVQVLdk3LQ3pZxc7Q9uUqF+e5oHQfP2rkYzwp7rbcD
	 rjQYf9Wsv7rYQ==
Date: Wed, 31 Jul 2024 19:14:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 angelogioacchino.delregno@collabora.com, benjamin.larsson@genexis.eu,
 rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
 horms@kernel.org
Subject: Re: [PATCH net-next 7/9] net: airoha: Clean-up all qdma controllers
 running airoha_hw_cleanup()
Message-ID: <20240731191446.64954a6e@kernel.org>
In-Reply-To: <fc10753d211fe7782c8173f27cfb7b8586adf583.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
	<fc10753d211fe7782c8173f27cfb7b8586adf583.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 18:22:46 +0200 Lorenzo Bianconi wrote:
> Run airoha_hw_cleanup routine for both QDMA controllers available on
> EN7581 SoC removing airoha_eth module or in airoha_probe error path.
> This is a preliminary patch to support multi-QDMA controllers.

Doesn't this have to be squashed with the previous patch?

