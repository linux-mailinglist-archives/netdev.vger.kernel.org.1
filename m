Return-Path: <netdev+bounces-197160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B761AAD7B5F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735103A1E58
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89782D1936;
	Thu, 12 Jun 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek4eknsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2481F5858;
	Thu, 12 Jun 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757727; cv=none; b=OAK93m62kUOXsOCUZJLwB14+gwN2ZiqubNZkUF+giGv2/RvWm4zASMXdr5NHNUqVlgxMKw81R/fYPW5VT/mR+cuG8mjbzD6SdxGtTQ7AO/gvKuyaxymp8nNwdFCxscD5CGJ4gRD7o5EKuxElIjLWG8fj3u7Bb0Uq1sRNmkaE8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757727; c=relaxed/simple;
	bh=FZwUSXLAo2c41SQ4E24OXwo5V+/zLDwYkLwhcEhxn18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgF8Siw4iIupmP0147Pir/fKSNDYuFNrDZMfmnyo4QV47oYxvG8M9uzN/YhSEthnRDgCyXwWI3FnyDW3Ncu5ujYAjhnvdMEExalQ1DuhF4uRY/K5+Mec1Z8E6LOE4+DOApQtL2N2dxWTvkWLzpkM7pUBH7ZNHr0N/fuIZXmLk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek4eknsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3362C4CEEA;
	Thu, 12 Jun 2025 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749757727;
	bh=FZwUSXLAo2c41SQ4E24OXwo5V+/zLDwYkLwhcEhxn18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ek4eknsPBoQjHCfWjURLJ0dgzqIc1/Gff4I8sm5qxO01qmkkMKb5yUCLFzXZV4F5m
	 FA0CH1G5KAZ/LIV5kBuDkPjZoR8ZnD7N765gxklr5uNoWb5c6p2QgJnsGUvt+xNdx9
	 KUFpz46myBFwUwjzToS4764jV7BQNmDohCGDXHZb/cCrPuWFylYs5aKotz40Op9+5o
	 xKouHooofKgn9THRn/+4JGOWuCC5fhZMyV6wdGngJRJnb/5X3/TBfV60tnhbBhrXFl
	 GuplgGHwa+jqtPyodxt+OoGYDFt4K3SIAVeuVKGuTtwGamEopr4UTLtFJE/DR2CBH0
	 yAyiEtBLSlbaw==
Date: Thu, 12 Jun 2025 12:48:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v02 1/1] hinic3: management interfaces
Message-ID: <20250612124845.4f3cedd2@kernel.org>
In-Reply-To: <11e6ee6effb60aa2c5fd79e7e3d59b03632a93f8.1749718348.git.zhuyikai1@h-partners.com>
References: <cover.1749718348.git.zhuyikai1@h-partners.com>
	<11e6ee6effb60aa2c5fd79e7e3d59b03632a93f8.1749718348.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 17:28:29 +0800 Fan Gong wrote:
> +	if (!atomic_dec_and_test(&cmd_buf->ref_cnt))
> +		return;

you should use refcount.h for object reference counting

> +	cmdqs = hwdev->cmdqs;
> +
> +	dma_pool_free(cmdqs->cmd_buf_pool, cmd_buf->buf, cmd_buf->dma_addr);
> +	kfree(cmd_buf);
-- 
pw-bot: cr

