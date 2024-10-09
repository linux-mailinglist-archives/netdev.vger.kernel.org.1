Return-Path: <netdev+bounces-133385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3065D995C6A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB0528670E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D135B79EA;
	Wed,  9 Oct 2024 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/KW0Sns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35717736;
	Wed,  9 Oct 2024 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434632; cv=none; b=AaODUqqorBCtKn/YRMy6BFHV9VEEtHzOI6z7nrTj2+k9CG4psnj+bkZ8mEeXoGqSPX1VC+zLkekTY8dM9ymz+H7PuFz25/WWKrRnXZ8gPOBpV1XHOQZ+0RVvUDrxkXnMXcopx2d1rZ9PBYPP4SIQpDnZvsATI9og31/6bTAZm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434632; c=relaxed/simple;
	bh=+KtawNoVqw4hPRzxMqpCWUA1p0+Zssu2Ey9oH/NftTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNLSUR96OPPHXvA0caeYWt36tY35jgoXIB3Q1UtyVsHujRg64wlXo7J54+MfHj96AurpfWYuJ2V0iejNl8fT1bUPXeZrw0uJ8T8vr/q9dUABg70J76qnTgvP3UmNw/m720inO94a2u292nkQ6DIF+vyUeg3ncM6fcQVNjAskelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/KW0Sns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B3C4CECC;
	Wed,  9 Oct 2024 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728434632;
	bh=+KtawNoVqw4hPRzxMqpCWUA1p0+Zssu2Ey9oH/NftTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/KW0SnsCBF90EYh7IG4qfqbHGOk68XsQh6rL99S+j0hTxb1rj6o4pIfGDuQm8jIi
	 hWd9uTbp/S+a9thYBnfuAxCOvUGKF6sEdP4ekqwDtjieaypcWbrXfcO9vOlCWl3ph5
	 Rb0Gr1CFEO3VVKqpeugYwdELo6Uvsf8c6ifAbGCMadYV4q7cNyUeDt++za8m4ORonu
	 e1jBToRv7LA55v3jftH4hugV+VF1zFh+JtEfDYQ4iYKXZ2qisu/l8RLibbasTRt+4U
	 +iNjBxtdmjAp8Ac6vEVuyCGjT3bbpO3q4Y4V9aVgXW3r3cYoWBVDLBs7lyUiHNeNRc
	 IXQjiowtJ+S2Q==
Date: Tue, 8 Oct 2024 17:43:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v20 14/14] mm: page_frag: add an entry in
 MAINTAINERS for page_frag
Message-ID: <20241008174350.7b0d3184@kernel.org>
In-Reply-To: <20241008112049.2279307-15-linyunsheng@huawei.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
	<20241008112049.2279307-15-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 19:20:48 +0800 Yunsheng Lin wrote:
> +M:	Yunsheng Lin <linyunsheng@huawei.com>

The bar for maintaining core code is very high, if you'd 
like to be a maintainer please start small.

