Return-Path: <netdev+bounces-107470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F417091B1E8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE17284FB3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA01A2FC8;
	Thu, 27 Jun 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggioOR6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DF1A2FC5;
	Thu, 27 Jun 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525634; cv=none; b=mEKP4enoLgHdnQb9kWLq7PjlWKMqwOnWHZMQV2s/WMNUOxNHkAlwM3SMZYpI4RP+liMvWRPHSmPVV/VHz5gahSrHXtenl8u11N+kWk5T5kSJfHSRf9cxZ3NSUekzuS8HZxSkl/VVfYn5VVKhwwpcXvo7I0Nq/YvJNP7VBgzRuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525634; c=relaxed/simple;
	bh=HyDAybxDassbOUInE5iWl69jAslSz8hAgZ+lH92GS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsxlFEb1ejCMeZeVo00uxyY/4V0pB2UpnealERSxJ8NeG1FbR4E1qcLLmMz5GO9rk5c2eFYlGMGk4oQha8wuURh9pDsnDlp6KEu7AkS6XF9jFezrU+Kdkb73d+bVJhaC8dYShk7RJnwBglcgjV95rfPRkNoh4fGXhs8iaKbcFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggioOR6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A4FC4AF07;
	Thu, 27 Jun 2024 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525633;
	bh=HyDAybxDassbOUInE5iWl69jAslSz8hAgZ+lH92GS3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ggioOR6ZQ+QGr+Uzh+1yak/9bFMPLOJE5yIylqEXQY6J772vAd6TQpygzJJmgxmm7
	 peJL8WCxQtpjJjH7Pm8eV7IZnmBWMcKcSAGdpJcHLNusTOBbAGbGASRQbNw9HMM3+J
	 1X8AmiFdKNQMEVUgnUfpo/HaP1NIGP1EHL/2gmgHCZHGsBYpeD/5blqsUvcZvzv+lP
	 g7GdIJHR5QrvfoVZQb9rHcbql5zd1m3yAQugBtwtxmxydVYhqTUCqaF+efIQaHpWXO
	 Omi52FxrJ6X2kXkps7hUTvD92u8RPrdeM5A/RC4PosJXEHvJ+CrxZ2Sx24dCkXEVBS
	 hqEof0No5cOuQ==
Date: Thu, 27 Jun 2024 15:00:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, UNGLinuxDriver@microchip.com,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: add regmap_range
 for KSZ9563 chip
Message-ID: <20240627150032.7b97fc84@kernel.org>
In-Reply-To: <Zn1eeYwYgU2ocWHz@pengutronix.de>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
	<Zn1eeYwYgU2ocWHz@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 14:43:37 +0200 Oleksij Rempel wrote:
> Please ignore this patch, it was send by accident.

It fooled patchwork tho :(
-- 
pw-bot: cr

