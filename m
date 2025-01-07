Return-Path: <netdev+bounces-155652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D2A03444
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BCD3A4AA0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B63208D0;
	Tue,  7 Jan 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLJ2Zf6P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17B259493
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211612; cv=none; b=ZaRo+33yIE+OMcRci7khTyzANXubkO//bElt9QrK25odsqmat6BO/jde9xxouigJEMnNB3WnLPEXn46OpwvtxU1PXjgn1LKV0ZgaB4QThA2cGqqy850oFsZQr+J7lvFd9O+k68eYtfDeN5YCqEgTHnLkh8dG2VFvJwFq+4XvYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211612; c=relaxed/simple;
	bh=xmKlQmBlHNqRxKmQtizFJPIajpP0YupqSqxBKW2uPjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h7uQvmPP8PgWhnuJmRlV4BsZJM3O1GNR7/Z6Kr1xHRTaOUtKWv+FqdztmDIKOv317QdMkZw4Owz31oE+MyMiNRjMogmq4GjAr8i+LfbgdF6ryXOF/CZsYaX2YaIh+hZzNgkEZc+vhMy23oeDEsxK4yCrfaGrtPnAnd0iZL0KdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLJ2Zf6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BCCC4CED2;
	Tue,  7 Jan 2025 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211612;
	bh=xmKlQmBlHNqRxKmQtizFJPIajpP0YupqSqxBKW2uPjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLJ2Zf6PnwwBY3E4TF94jl7XGWyDUlczyaiIX/ApQQtobEE25Ifcm9oVEoenmqmkg
	 m5tqdSfufMYfhEFvzBPv7RA5FGZQtl7lqkoc9nBwVTxrGD10VROvE6qPzNASdjXC3C
	 jyGqzrDlpybgkfyOm6gsbumqLrOOu/49lSKKu3qRrUMPDH18AsQMRTTfu0N6yEA01f
	 9tc+YctZUfnqM91Vtz/lVLCnMKoUGwe0vnlDj4rSfORX1mVXVqfTfTylUL+MU2t3WH
	 AppVojGI8hyYVnEJnYxoPhT7eNGDjSu7vEv7pPPZmKpSbyXDsFDo3qIBjMaLjDOwOe
	 XvVxKQnhuGyfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71884380A97E;
	Tue,  7 Jan 2025 01:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] cxgb4: Avoid removal of uninserted tid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621163327.3665137.9056342043851583267.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 01:00:33 +0000
References: <20250103092327.1011925-1-anumula@chelsio.com>
In-Reply-To: <20250103092327.1011925-1-anumula@chelsio.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 14:53:27 +0530 you wrote:
> During ARP failure, tid is not inserted but _c4iw_free_ep()
> attempts to remove tid which results in error.
> This patch fixes the issue by avoiding removal of uninserted tid.
> 
> Fixes: 59437d78f088 ("cxgb4/chtls: fix ULD connection failures due to wrong TID base")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] cxgb4: Avoid removal of uninserted tid
    https://git.kernel.org/netdev/net/c/4c1224501e9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



