Return-Path: <netdev+bounces-137088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CC9A457B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EA31C220FA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4686B204958;
	Fri, 18 Oct 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="508mtUqx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C07204937;
	Fri, 18 Oct 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274989; cv=none; b=bYeBpU5zmxYXZTf/2zdRpmrFTj5EL3pSQwGvJwa4yVTY9GHXLVrkcWDsJ8f5+7dBVW/FSnjo7HBW3nV9sKbrmq63WVP6L4lDYC6eILps8Sv9teCo0IwKQzMO5sYQP1T1bX+GNocxw3cl9LNCq3KlXOYR8OWp8ofgkdVzWQRPvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274989; c=relaxed/simple;
	bh=8hMl4ZPYJjCYmTIwgtnqElSKLiJi5OAtzolHC+7W92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFfuy5bIlh/uiYoLDYrnNUcUzXzyamVCEVsHwV1KoU+mxiIvzScaO76jumNkxGQuvd58vCCCzExjO7sZ1I5mD4DEZow4fiC/RnBSQvgxoa9db7n3Jzr1X8sYW7uFfoV6kiCQHMc40+h77D2Vx5KGzeqWVTgdKmpaVyseExM7j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=508mtUqx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TfvndAJgwqpoY5mhzmpO42+/ZaHQQgS6HPco1tDyyAE=; b=508mtUqxMTCuonr3G53dR7oNey
	8qeW9b3nfhdGNYSsk5tzfajwfeU5J/z/aNaO1wn37JtLbaCmAaV5PPqGBGvwLmHDs5ABTmtPxi6UK
	uvRmPmRREtDpi/sH7QPrhV/ih1jFsO6ZcU2o6LVwY+aKAgnnU4pR3nIBm07j8b4oEAvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1rPr-00AYWl-91; Fri, 18 Oct 2024 20:09:35 +0200
Date: Fri, 18 Oct 2024 20:09:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@baylibre.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v2] net: ftgmac100: correct the phy interface of NC-SI
 mode
Message-ID: <aaa6e8f8-3c39-4f10-9c5a-f91ab5761dfc@lunn.ch>
References: <20241018053331.1900100-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018053331.1900100-1-jacky_chou@aspeedtech.com>

On Fri, Oct 18, 2024 at 01:33:31PM +0800, Jacky Chou wrote:
> In NC-SI specification, NC-SI is using RMII, not MII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

