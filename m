Return-Path: <netdev+bounces-116890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF494BFCF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E53B21801
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99518E76D;
	Thu,  8 Aug 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dgNW01Jh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AA18E760
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128153; cv=none; b=SJ769eOE7wOXrFkqZmzQ4ooLx6TSCY/X1TEsHcSa2CiQQOSuZ/jNlnU1zegnjm1Gvxr2QAXy5usoSd8DHcL5PqvVeHMFR1DWIsENzppuG1te43nI2+xX4pF6QNcDJD4qc0QTP7hA0yB0Aa2hE6ANhjrYU+gU3ix3RlkHgCCOrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128153; c=relaxed/simple;
	bh=syHVPRfuZdcs3cy73uGtH8KLpXMrNXPViGmPgkq5aZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr/RfyFq0a39/pDFfIq9wuUJ73Pop+FKbz8UwMby62HLc5kfuBAEnBV1rf1xhPpaPBy0a8SNlOzddGq4SDWbnZjfkKlKgf5hUwvkKQUhR047L3nUV4T5DHZaYfDf/O1reAt4PrvMuhavSsJsUTUGt0WSjwCJGD3Q3HB2FhK4Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dgNW01Jh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hfKdaWet0TdUP4fdYxfnu0fv2VNp6qhQ19ZYmHg5nwE=; b=dgNW01JhNkeW7Yu/uqOp7pl9Z7
	S9FbLz6ds2PnGlTo/w2DAZxBBwWJXIeKytIpvL9s+XwaC4kPJEk/CNIwloVpwm6fTmi+bm3spQGk0
	FHw6oHJy7C/tWW9q+LxumBRyIDNCpEB5Zcd+g13usEKB36ufH5jy5dD/E+h9+wOaik5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sc4LU-004IS3-U2; Thu, 08 Aug 2024 16:42:28 +0200
Date: Thu, 8 Aug 2024 16:42:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ag71xx: use phylink_mii_ioctl
Message-ID: <929bc185-16ec-416d-a934-64b148a02a09@lunn.ch>
References: <20240807215834.33980-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807215834.33980-1-rosenp@gmail.com>

On Wed, Aug 07, 2024 at 02:58:27PM -0700, Rosen Penev wrote:
> f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
> ndo_eth_ioctl and used the standard phy_do_ioctl which calls
> phy_mii_ioctl. However since then, this driver was ported to phylink
> where it makes more sense to call phylink_mii_ioctl.
> 
> Bring back custom function that calls phylink_mii_ioctl.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

