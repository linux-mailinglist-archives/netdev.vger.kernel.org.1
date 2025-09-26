Return-Path: <netdev+bounces-226800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1EBA53CA
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26743625D19
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EF27A46F;
	Fri, 26 Sep 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUeReK7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF637275AFD;
	Fri, 26 Sep 2025 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923024; cv=none; b=sdxDRQIhc47elB0+qzupqc6R7FeObg+B8IBsYFiGO7m2ZYl4GIVXks12ZbXSdXD3m24G4/Ox5NAEP0D0tbwqq6uq5erKszUgxJ4lRCLnhvQjxZsSx7a6k9Q4jCWXshMV7rIAmwOcAxgvB/bKxH8wqC5322J6mcHb59GkYDUtg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923024; c=relaxed/simple;
	bh=TsoIjGcALgbbzbjIjhlzmkUScRqP0xpTrlew6nwLHJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=al2BTGLNR+UoA1YwK/IIyHXRgpclE3wUghvN+GxsG4SetsI1TkFWZiB/R6Hcl7Tmr17FLvGxTmXrfGMRvWFkXMCJzb6+z6ZGOgESDzENyrhMdOV6VpRCTY69iaJCIwJYWS8FHIvh7cf3Or/FqxMa+0qech9WKpf69tpA+n5gLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUeReK7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6DCC4CEF4;
	Fri, 26 Sep 2025 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923024;
	bh=TsoIjGcALgbbzbjIjhlzmkUScRqP0xpTrlew6nwLHJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUeReK7cQVPweOKz+lzVaIuRy/5F7yqY0qr0TF+bw8FCoI1W7liHN9h+c3qtsDXLe
	 IrHW7wPdmUhx3lr8UgSA+PpsR4UcohIX+HAnDV59qVyFPgBeWTUFtv2qLk+anlS8AO
	 2IktQc03os4ZouTWDVoeCEbcPwWzraQc7AWxpLzGV9HI4fPKXXIk5IElzRaOdy3vc8
	 WN4/dhlxUqVylZKh+uXUeHAvfoEz6eTq428vgc48iCQF/L7RF8EiS+N8VfLM0QBMwK
	 zxKBBhwgAKmy/c5N8WE21aLKJ7N9M+M3axUPRaexAmogpqqKGA/70h1XEQoDCIbEz9
	 2Y0YjGcRCw69A==
Date: Fri, 26 Sep 2025 14:43:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2025-09-25
Message-ID: <20250926144343.5b2624f6@kernel.org>
In-Reply-To: <20250925145124.500357-1-luiz.dentz@gmail.com>
References: <20250925145124.500357-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 10:51:24 -0400 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:

I'm getting a conflict when pulling this. Looks like it's based on 
the v1 of the recent net PR rather than the reworked version?

Sorry for the delay

