Return-Path: <netdev+bounces-228763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5CBD3C27
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA493E1059
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44526E179;
	Mon, 13 Oct 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DYMaXNjl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1210942
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366856; cv=none; b=ZLSz0rDHsM9MhZNskC/Eq5hRJW4HOwfaxIig5ze1ZHHelErtbsw5o9QH3PYO99yfO2t/Ns0qggTdRxT94CBFoJYwBqNPatT8lGkuoMCMWBP97fgYyF568U/cfv7AkQCyvKaQYw9PL41FvZHyw7KSkDUF3Sa7M3lwW/nF9gfMS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366856; c=relaxed/simple;
	bh=LyUBVirt/YTKs/gXRPUM/IQLsqpXNpUfFHNSwzZQhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrz/8hg+ZDOUGP7HKg4JdEHxS+AaDyWPfDM7JCSmkK+dTuCxim+Jg1zOPN3Ic0g2XQozRx8fpOMuqFjkz8HKv0lqhzyHjTyUJM6X1A9kSyuZX6XhwMwf/90czccg5Qd2uxAGQq7tCGOGBZ3sO1H+QAY6tcWm806oHdOe4AZD9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DYMaXNjl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h/0I4Gz31qHQ3E4TALYeDQRCDADMqJRa6g6F6Sm8prs=; b=DYMaXNjlsbANWTv0AE3/heGvlF
	rGXQ8kVxIbg7/0mh53pcGzAFidCW0DW3NOU1h+vJh8yCWpKDfW1TCEOgjF22yw+gWvlUHxIuYuKRz
	9svkkzJmRxCtpC6NNhl7lKYvNjIDXlhuLryE2vulm7nqbndRY/KLstzV21Gcup9Ua4fA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Jpe-00AnRB-S6; Mon, 13 Oct 2025 16:47:26 +0200
Date: Mon, 13 Oct 2025 16:47:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Add get_link ethtool callback
Message-ID: <79e75adf-6cbd-4ec6-9473-591fbdf4248c@lunn.ch>
References: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
 <20251013-airoha-ethtool-improvements-v1-2-fdd1c6fc9be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-airoha-ethtool-improvements-v1-2-fdd1c6fc9be1@kernel.org>

On Mon, Oct 13, 2025 at 04:29:42PM +0200, Lorenzo Bianconi wrote:
> Set get_link ethtool callback to ethtool_op_get_link routine.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

