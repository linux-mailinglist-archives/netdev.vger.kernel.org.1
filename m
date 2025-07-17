Return-Path: <netdev+bounces-208009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC812B0954C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215C25A3F01
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED52222CB;
	Thu, 17 Jul 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+ZlB07c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7642194A60
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782339; cv=none; b=E8cOozaW50CW6DDxp/myiqdR7L1O/EaGXOgQ7WNPTvc33cZSp6JHTcJVq7DSRN3ILELXi1adZD+ULMP3O4DyqW9h3cCclhHfGud+bj7t90PvuwISMCfZcbe1T2D6XxiKPNlBkih2LP3qtZQHTleUePOsOtv6gnxcvOh656T5rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782339; c=relaxed/simple;
	bh=NPvLY40KSOwHC3Gm5hv3HF3r82He+IC5jLXZ5te0CR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4KSCSo08Tg+eDPaNz5Slq8fSfs/KJAgIyEi6p4R30DYLI+cpPpfYuoc3vDZDpGZiKDUKVmBlIvgoDp6fzANJaA/QO6vYjJfeYOVJ1PQKwHFMyPxhmVjIbjVXeqr7Q4WZWdqHcYejwvdTLq0APdwlUvrqY2IB41Hk4b2RpbcyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+ZlB07c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF1C4CEE3;
	Thu, 17 Jul 2025 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752782339;
	bh=NPvLY40KSOwHC3Gm5hv3HF3r82He+IC5jLXZ5te0CR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+ZlB07c1oAN6fxG2U1wX2PxI/+rK8hjnA3MBCqp7NEPudZHSblNeSU9fVnQ5W1gY
	 7S0hFpkaqPnrYB0HI/+ekbk64rW3VS//Zgw+rYiVuDbkNdyWQVbU0ibcsixRyt+4OJ
	 YADQH6Dhaua/+0Dsa51JDHiUpCH8ZHhkKHR2/X0YZJkbeG5CFdoPIt+tNzmladGQOw
	 Xq/QT1hGn/5GWweqzA4p+BawcUv33Sy8PU7up3Hw+MEAvWzfpkcHU+QSKwp3ZcCNlz
	 1saHhwBFMhJtOPet3sj7z8mOj+EeKqyzXg3bsSFP0SAxReaiTuAsxwwNcnGM8cSrD8
	 tUvQvnkorCk0w==
Date: Thu, 17 Jul 2025 12:58:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net/mlx5: misc changes 2025-07-17
Message-ID: <20250717125857.33e66065@kernel.org>
In-Reply-To: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
References: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 20:03:09 +0300 Tariq Toukan wrote:
> This series contains misc enhancements to the mlx5 driver.

According to patchwork you have 17 patches targeting net-next
and pending review.
-- 
pw-bot: defer

