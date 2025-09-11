Return-Path: <netdev+bounces-222181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97075B535D9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FB557BE947
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1034164F;
	Thu, 11 Sep 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgrnyOqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1D2BAF4;
	Thu, 11 Sep 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601540; cv=none; b=iZ6Djpa7TumjhtCooUWibFJMng99+k34ajDtqLgg2/18cl2WeI5vsFl/BF1xGB541U8f+C9VebPB1NxNwpFOYX8SGHlKnF275/iuwWSDgjlYPR19dLwM9mLU1EQNkitN+xBp6678nzIhCONjZNPFcAZUqWj4RWsb38xX/HUD/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601540; c=relaxed/simple;
	bh=7EjvNHZ/cEJUuJWOwLqGxCMAq6Gi16TojiEv2meKV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDKAcspE+2o0HfRqiw5xShv+8HTJyhMliEDAOr+5hns/g+PrOHedhecC6l/qowxlOB9iXkjFl3jze1/erbDGViO6ZRZawx5XuniqK5CZhW9/2XfCRe0hHmDAagR2+BzPX12G6a/jpWqW7D9UrqP5E/meuvGtb4r65wOCg5z5Ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgrnyOqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F441C4CEF0;
	Thu, 11 Sep 2025 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601539;
	bh=7EjvNHZ/cEJUuJWOwLqGxCMAq6Gi16TojiEv2meKV7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EgrnyOqtc2UITYnUNhdWGceDB/CaRaH/VwKSpcG5HmfdS4JTDPSWUXVWqAt5rgtNZ
	 Thv2PxOl9cE8nNn9ITSA7bF8DA0nzRd4fRcUATq6aIGeOmDrX/9A06Ce5ytmj5iNNj
	 Kw1SYwmyA6jZqJV47lp8Bnt4RAsu4zXiXHWEsq1np7s5qck+aqa4VAJix6rKt3KfyO
	 Ci4CFJSr0ynPwTh0TWSujtu4g2rE8KqPi7jRRtIlXwJ4ZTW0CV8nfCZFBxGj+Ii8L0
	 hqrL3Orpzob2FHQ2ndESXFW9DkWLgCH4lfqlcvWdwjY39KWEaP9pAoZzZSbYkZaQRN
	 OWcn+GTQh9Yfg==
Date: Thu, 11 Sep 2025 07:38:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, linux-usb@vger.kernel.org, Marek
 Szyprowski <m.szyprowski@samsung.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>
Subject: Re: [PATCH net] Revert "net: usb: asix: ax88772: drop phylink use
 in PM to avoid MDIO runtime PM wakeups"
Message-ID: <20250911073858.0cf4bd1b@kernel.org>
In-Reply-To: <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
References: <2945b9dbadb8ee1fee058b19554a5cb14f1763c1.1757601118.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 16:33:31 +0200 Paolo Abeni wrote:
> This reverts commit 5537a4679403 ("net: usb: asix: ax88772: drop
> phylink use in PM to avoid MDIO runtime PM wakeups"), it breaks
> operation of asix ethernet usb dongle after system suspend-resume
> cycle.
> 
> Link: https://lore.kernel.org/all/b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com/
> Fixes: 5537a4679403 ("net: usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM wakeups")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

