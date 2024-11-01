Return-Path: <netdev+bounces-140891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297B9B88F3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC47B227EE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DC74BF5;
	Fri,  1 Nov 2024 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCO6O/wp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7191A28C;
	Fri,  1 Nov 2024 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426184; cv=none; b=H4dqUEXgu/WRe7fHdKCBdtlh7eCicT18zdve9xc3A/mIdruw13/+7/qUmXMc/WRXVyLzU3hnvnQknoo7D7PHuJQX4dSz6Ai6KxawBJTZlPViq8/KRO2E9fozRacypzRkiIk4UJLTD0NPdOs2hp/MAfHxvvc9Nbe4VlrNLtcabyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426184; c=relaxed/simple;
	bh=1kiMuQxr3n9QmCXX2YITR76GMso9rWUXpaj5mZuRoy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHs7dUu0cRrtT3xc22IrAzTSIQsMIpICcmi9CsRUpGu4sdJ7TqCI2Qhn2xv3Zf7i4WV1IvQ2vl7fLu7/RdhWkX6cMd6WUSouTv1rGbWxZnVbxIpYIpZQnGEkuAAmNQlNKHUtd5691JZ85L9QjNE4xs1N5kx2QQ/JEiQbyM1spqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCO6O/wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B06C4CED0;
	Fri,  1 Nov 2024 01:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730426183;
	bh=1kiMuQxr3n9QmCXX2YITR76GMso9rWUXpaj5mZuRoy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCO6O/wprCToHUBrz08uXOfKx6RLZbe2pwT7xDha3G+jLLQPQWDr/+2d/Tl/soshA
	 8V6wqjTSlNeuzsOjiJEJAONp+qQE0sStWHiQzE9fAru6eE4JiU0QReS+IEsbsxufct
	 +a5vd3gS0YSyuMM/oxZRgwDfNtbGK0vhFoJcL7aQRaIJQ6Uy8/wF9xt6u6JqnuxDkW
	 +LMWodnsxaCC5SSPkIsegNssBAk4N3f+bf5qPcJLEyC9co4X5c5fxMgeeH8Fqahklg
	 vqvxfNVsdy54227ZGroAlmv/RQz5kjCGy512kmEXGYfLa6HAPg5Xe0fRPP5ZqtyCLn
	 y9mTbN1RtsTkg==
Date: Thu, 31 Oct 2024 18:56:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp_pch: Replace deprecated PCI functions
Message-ID: <20241031185622.75536bed@kernel.org>
In-Reply-To: <20241028095943.20498-2-pstanner@redhat.com>
References: <20241028095943.20498-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:59:44 +0100 Philipp Stanner wrote:
> Additionally, pass KBUILD_MODNAME to that function, since the 'name'
> parameter should indicate who (i.e., which driver) has requested the
> resource.

Not sure if anyone cares but in theory this could break something.
Let's find out..

