Return-Path: <netdev+bounces-114787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC294416A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908A5B20D86
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842D36130;
	Thu,  1 Aug 2024 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+z6Mvv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292A1C695
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478466; cv=none; b=H3HkcE2Ff/Q4sXvtrmQHYLvXsKnMza+elqjayL1u1j9kcAw8dImysKAzub7bJYztWW0rLBaelvoKfOmdaEo+Vn50TTaqVLVw037LAGiV6f4WboCSTWgiWe9PNI7jWtYabvcge2xXF7s48UswiKAJxvpKiTBBQnI5ZenjE7BNmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478466; c=relaxed/simple;
	bh=hYD9sSurRHtOdfGlewQJZ4Vg3FYD/ERRL0VtIAy3WV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbW+Oe2GAPhIgM19zbRMQS9xxgD66xWsJGS5SlCCwOSuSjdsogDO7Aa/i4zFGLfFXdbhmbLTvpDYFYIOqnfsmvIuN4LbkMShdqficuxGQyQtOhoNdjeZ+ekPTIe5zDjiLP5SoHJt+nlo43suMtBCfWS3qoAKsckMMLaU0+0uZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+z6Mvv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2FC116B1;
	Thu,  1 Aug 2024 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722478465;
	bh=hYD9sSurRHtOdfGlewQJZ4Vg3FYD/ERRL0VtIAy3WV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g+z6Mvv4UXi8Oh1iFw61QuDE4zhmu7T+ZuG+PF9MPEry9MmQ0yk4EzDrapALwW/dC
	 xglrKimvomxoZDfPFYd91AhLncfqvSQ8legagWql8GSK1qh2Jyay/kkkisVOtAJsEw
	 hkCu6dhZRC4vYjksqX9haiQtxlFLZxxKKMdNxKCo+Ri9sYuPaGjN8o0Iwf7rBGy4fd
	 QdJyncbOCsvcnW/jyVZ1+2ktKLFGOMPIXJQY6PSg+F4Mg1cKKDAcWDe2g15Scfu/YJ
	 TnrUKXfE1fdLnzOx6zqrRGFBTUl7EoXqXdXp9x49ug7iUScoE1xnz1T9F/rHbZ4OY/
	 fnAqIllQjwC0g==
Date: Wed, 31 Jul 2024 19:14:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 angelogioacchino.delregno@collabora.com, benjamin.larsson@genexis.eu,
 rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
 horms@kernel.org
Subject: Re: [PATCH net-next 6/9] net: airoha: Allow mapping IO region for
 multiple qdma controllers
Message-ID: <20240731191424.5f255515@kernel.org>
In-Reply-To: <6a56e76fa49b85b633cdb104e42ccf3bd6e7e3f8.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
	<6a56e76fa49b85b633cdb104e42ccf3bd6e7e3f8.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 18:22:45 +0200 Lorenzo Bianconi wrote:
> +	qdma->regs = devm_platform_ioremap_resource_byname(pdev, res);
> +	if (IS_ERR(eth->qdma[id].regs))

qdma->regs vs eth->qdma[id].regs

