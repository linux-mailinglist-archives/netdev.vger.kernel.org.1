Return-Path: <netdev+bounces-218903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD41B3EFC4
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8930F2055A1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE826F2AF;
	Mon,  1 Sep 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDIa+XYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AF1EF0B0
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759164; cv=none; b=qt476SvNvAZpOC+JCw8NknrqDTc4w6Y4o6qryTaUNeJ4RYDHu3VA8F5037GiawSFQm1PKUmI2oNxmN7Zznu0YoOkBtoHoUnxtgl18KTW7nDdF4u03Z6D4rOdhe5iJk/ai679xgXIiLv17IDnf/QBi5v9jquE6z8TMuE8RE73zWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759164; c=relaxed/simple;
	bh=kyPttvyb+3E4rj7S99pOS+EBRH7mAuYA3d/9s8TmZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrcSBXnzQRwJJ/fpD9siyP/37GgFZLjyS3pKfEZqsoe/Wsq8lP7hw9ISS1uNc31vDA+uPn7dUsdh9DnnUa3ff6+fTbK09wnljoZ37XHY5BAY+2JtweMhPqs50r1t/ghaWWu81gDi26dl7Qt17/tI7LsB+VvsTdcHQce9RHQmskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDIa+XYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14516C4CEF0;
	Mon,  1 Sep 2025 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756759164;
	bh=kyPttvyb+3E4rj7S99pOS+EBRH7mAuYA3d/9s8TmZe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RDIa+XYt1/fM2GzjX4Q7/CaU3T6ZsOVuvRb4utLjO1RModJ2SdEisjYBHGl/Exc4g
	 SFvv1tFUgFjoT1B3i0XyvAGl4e+VFhgMF+DmOBiX0ZcWwxKwd/AQc62YdbkCWXH0YJ
	 GcYuo0YWhk9+Cu2Oiw+2w+xLLxV9TqI+qXiGM/hB9nrPyCJUtZr7DcHVQDaeGIdpWM
	 i2h5VDGIV4WkXNploSfz18rfv0ofshb01Aa+BKRG9PG2SWnBBBNnmFb2R+xRMM+1F0
	 dAnyPaX98Ffijhu2h8iw0PUUFdzr2Nxkofvkvps+g++hlTk/vsasjeRx94SSvwCf7n
	 8cd+c1oGR6lcQ==
Date: Mon, 1 Sep 2025 13:39:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net 0/1] pull request: batman-adv 2025-09-01
Message-ID: <20250901133923.5a06d3bb@kernel.org>
In-Reply-To: <20250901161546.1463690-1-sw@simonwunderlich.de>
References: <20250901161546.1463690-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 18:15:45 +0200 Simon Wunderlich wrote:
>   git+ssh://git@open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250901

For the future PRs please prefer http(s) urls

