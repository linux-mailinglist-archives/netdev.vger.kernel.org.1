Return-Path: <netdev+bounces-132305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852F99130A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016DF28345A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C81547C4;
	Fri,  4 Oct 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZLGb1no"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147615359A;
	Fri,  4 Oct 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084666; cv=none; b=q6BePRby6GpykawgiNoyRTcNYB7xl3e2wii7i84ZqVLikP1AbOQLdPM+OPe38oBDM4VmHWDuHdyQQzjnz9ED/3WdbyrsPtm67Q7hANdXUWEmXzcTnlOQgUvQGCzFu6Jn/sJRTY3ZuFuKUwBk/H0yynYFFKbxGuevW5wlHO7SF5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084666; c=relaxed/simple;
	bh=BxBXiV1VMU/q5xF8He+DUOQEsDPYfqucGKtcmUwC2BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7RY1OwxJAXbUYilvUsu0MquYuFOaOKzR0mpADR4G85RFiLbTN2al0nlkGs7gTtQOSNs3Vgf3+cQFQ7VCWhyZ1E2AyOtVGsN9wT20seS8uIrQ9z3OHZ2qxMxmwFd4kS6TFEfd1Ryv+8wFVappe/RtWf4pam0PZ0g3S8R0E1aRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZLGb1no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D2C4CEC6;
	Fri,  4 Oct 2024 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084665;
	bh=BxBXiV1VMU/q5xF8He+DUOQEsDPYfqucGKtcmUwC2BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZLGb1noCd6E/H+Iqmyvyo5DTUntA0l1eekWeliaKTtAq1e6f2qTKgEPOb6qtYGUl
	 p1AirLKZRAzbdE7XJzGgvtHJMNRKdY2DvMBHn1Rj+2SOw9EWEd7yi7v5qk5kbeIiLx
	 B7peY14B0NFISYBj3pEqiHGM82nBllSQmR5lZiWz5xUcBVFLUKXsWMmIyXN4qbiQGE
	 96W/8fTONn638lhZWquv0jiI5YyFYhwAkUSe/b0AtTous37PYA+xyJM5ga9mTY/mp4
	 2WOj4yc33JGfTmoh5pIfdKOBRCDpMPtgnBcIsAemuazjWD146ZM0POYjdBe5Mgg9vX
	 Vfw5qB1lAnpsg==
Date: Fri, 4 Oct 2024 16:31:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 02/17] net: ibm: emac: remove custom
 init/exit functions
Message-ID: <20241004163104.089542bd@kernel.org>
In-Reply-To: <20241003021135.1952928-3-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:20 -0700 Rosen Penev wrote:
> Now that we're using EPROBE_DEFER, we don't have to do custom
> initialization and we can let the core handle this for us.

Could you add a reference for this "now"? Which commit changes things?

