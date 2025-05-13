Return-Path: <netdev+bounces-189926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE3AB485E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B334645A1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD0179A3;
	Tue, 13 May 2025 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0tqahRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC1EEA6
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095707; cv=none; b=XFHX7z9Y7fAY2iYDRjcJTMauY/dBXXjIniuuM5ok+zBi1sMAvAucXJL5OGESy38o9cSpSZoA7X/+m1JbiIIYEVv0gE5cNB/ge77wZXYlV6H1nSN4vB6xtiU3xSlwYRyrlkzOry8Pry+0OgXCeWOsNQumj5e7NXSxdYVbW/KJVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095707; c=relaxed/simple;
	bh=K59e99dyJlhqi6GdqdXyTHH+CUfx1BiXFdixg96IZrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO1jD+L6DfYInjmrDCvFIsVYL1v99ehpnMWenOTiaFiH24A38JmhEtjmI1FEWZgqHwap6jWzq8MaoMwe/BXjR8TPdASgwRyEFRhirkbP91XoMt+0d1ohIZ3oGUAqGiDpJLP8jcC6ox6uoayx92qOinq9efjwviyLqYecvcBXgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0tqahRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C730FC4CEE7;
	Tue, 13 May 2025 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747095706;
	bh=K59e99dyJlhqi6GdqdXyTHH+CUfx1BiXFdixg96IZrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G0tqahRBA1FxoqHpUf3M0zHmra7VGLbI0aoBFKV31uLHL3PajXW3xc7YT0k4FmwjQ
	 3Za8KtI8udEzQ1oRXuX5Huy1kC7WxwSr3wf7m886cI/HTDX/6t/3oMrx90T888c+dp
	 ScyqTVC8+spAY537Ug2cw2Cw62r1T1DGwCKzgo/q7oPUy+3t+AmRt/1eCG7WLtHPMN
	 YSK8zuOHjhxQwHzdQcsDQ/eXk/4Yb8n9U1MA61KI2rv3bpraSergmjHfMLoVcYv6nH
	 6laiJDBmX/jLZTXbu5nGqVT+7WgMbXvIMWAKZdXiX6ZhYfbjL94kJEQIxxmCk8Lvzq
	 /PDQSoL4l4O8w==
Date: Mon, 12 May 2025 17:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 0/2] Add link_down_events counters to ixgbe
 and ice drivers
Message-ID: <20250512172146.2f06e09f@kernel.org>
In-Reply-To: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 11:05:14 +0200 Martyna Szapar-Mudlaw wrote:
> This series introduces link_down_events counters to the ixgbe and ice drivers.
> The counters are incremented each time the link transitions from up to down,
> allowing better diagnosis of link stability issues such as port flapping or
> unexpected link drops.

To confirm, will the counter increment:
 - when link is held up by BMC / NC-SI or some other agent 
   and user does down/up on the host?
 - when user reconfigures channels, attaches XDP etc?

Would be good to document that in the cover letter.

