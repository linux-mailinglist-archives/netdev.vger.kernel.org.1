Return-Path: <netdev+bounces-224494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA89B8586A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4593A57D3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D830CD8D;
	Thu, 18 Sep 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuUhUofM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FB30CB5F;
	Thu, 18 Sep 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208511; cv=none; b=qKblBrm8QbBG6+44JRZz/C/cvDqr6jlB+oVsU0mZVX/gR/cgvIaUDq6wgS/rfU9RvmUZwgRkZlh1EGrkmpeLh7YBhZFr3mGHUGnIPCmnJWwBFH7ByCnqNls1i5lXBNfWYkgv22MZ01lguPZRRA0LwurFNWaqTu14pY57lTbQiio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208511; c=relaxed/simple;
	bh=8JwclengLTvMgBdFHuzKmj+p7e6D4OWHLbYoSRMS1/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upd9DFRUWmFga+QueDmwEOWomDhG8GQfRQVNyF1nszqe3BIddSjfdbvHDmGePAtK3rU3zM/jXsJXrhNQc+KXxYKpVOZ1C/3rf+NuUVON1eQk6iJKH9Sn05QsB3TgrWrwz9/eMqEh/VlAjJUoZQKYelckcFIc+XUpd3D39Rr6hMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuUhUofM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ACAC4CEEB;
	Thu, 18 Sep 2025 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208510;
	bh=8JwclengLTvMgBdFHuzKmj+p7e6D4OWHLbYoSRMS1/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IuUhUofMJ9th+V1Q+UdSl79TW3eCpmpANbZzMKMRxq85b+2FFll5NYAF6pDe7m1H2
	 kKAmfmR5+sLxAbYe08Xeo9bPnC3HaFPMl+fI9dh8LrD35QfIFjkpqNoPHz6Xqjq6pc
	 ruOYLMpWBCN097QZZ6+DaHooSxLycWkH+9CK3Ouqf+Y+ztSSRDHUX17/ChHp0E3Lbe
	 OeRjDWMXJfoCkokiWLGxE905+9rXV4SoX4Q/CLNvLUIYxdtKOONvxJt2kohoUsyDA8
	 XgD/ajndt3FhJROD3DCZkndZY7gOxB3LzmC0Qm/NBm1IP76PNFsC0LwoeJwWhQZ2Ap
	 39zibW6cZo8oA==
Date: Thu, 18 Sep 2025 08:15:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
 <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
 <andrew@lunn.ch>, <srasheed@marvell.com>
Subject: Re: [net-next PATCH v1 0/2] Add support to retrieve hardware
 channel information
Message-ID: <20250918081509.39c066e3@kernel.org>
In-Reply-To: <20250918144858.29960-1-sedara@marvell.com>
References: <20250918144858.29960-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 07:48:56 -0700 Sathesh B Edara wrote:
> This patch series introduces support for retrieving hardware channel
> configuration through the ethtool interface for both PF and VF.

Please read the doc I sent you and repost in a couple of days.
-- 
pw-bot: defer

