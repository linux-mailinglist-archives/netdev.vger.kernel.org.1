Return-Path: <netdev+bounces-127978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BFF977625
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952541C2435C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA691373;
	Fri, 13 Sep 2024 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egY8zZ+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335C322E;
	Fri, 13 Sep 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726187797; cv=none; b=dYA6er8wGCl1GJM/008zmrwGQVwZccAL0QgQMi5jwMTd5mfqtPuKGHfB9zjCeTN7sOXsPMArzfj5lG6Gsge+KojiUZ3QtJoy9pP8lfRjLeg1FjM1vQlA3LCU/j9B4GOXCMA7siy3HecXs1VamQGFq9AGpBSVC7B4v5ftcZ4/f38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726187797; c=relaxed/simple;
	bh=itNmIcvzcJJ2CWZcZWGkD6zu04p34XQ5rn4/eCc4Wik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/qBg9nUxIieGw9NnLDabB4WSo0phGNTct/nDg9YiPcm8l++VVPJR/YiWX1kAz0Zyd6hFtl8JEdPrL3ACErbSZr58E3Bw4L1dYc11m9qavgr6f4Ci4P/7v+Bbq35AgbFKbsdIO96UGR2qAYHGr2O+Z6+HZD5HLLiQMA90D3p8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egY8zZ+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB14C4CEC4;
	Fri, 13 Sep 2024 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726187796;
	bh=itNmIcvzcJJ2CWZcZWGkD6zu04p34XQ5rn4/eCc4Wik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egY8zZ+61ImtfJrh+lnE/PKLQrh/QMg4S/68YI3vGt9YMILLP/c9bGSb5KqFmHWCO
	 7Fm3H9vjr/o6XH4YIgZBozjTkNuWPfI7NXLH2mF13/oFlyUGXLmHUpxNK2nE/HdDvB
	 tFc7kscBHg/9GW2nJRlEZ7N1OAfX6upD1PuChRdpf/Xz971a+xLw1SK4buHlaMp5CX
	 ewJtYxna5Vk2sLMcdjQ6qlA2Vv5XqDcs9RlZLLUJGZBmstBmDjwfV1fjO/lyTF6lHy
	 NqEqQeFweeDtVv52J6t0thRmbTWWY/eNgg76SHbGCZR0QUhwU2tirvIyScpBI4MDRO
	 e2u/AVJkHMMHw==
Date: Thu, 12 Sep 2024 17:36:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: andrew@lunn.ch, o.rempel@pengutronix.de, rosenp@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ag71xx: remove dead code path
Message-ID: <20240912173635.20594e15@kernel.org>
In-Reply-To: <ZuMMyv9_npZ8txU8@iZbp1asjb3cy8ks0srf007Z>
References: <20240910152254.21238-1-qianqiang.liu@163.com>
	<ZuMMyv9_npZ8txU8@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 23:46:18 +0800 Qianqiang Liu wrote:
> Could you please review this patch?

My preference is to combine the removal with Oleksij's suggestion
of adding the drop/error increment at the right spot.
-- 
pw-bot: cr

