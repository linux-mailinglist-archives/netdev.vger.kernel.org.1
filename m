Return-Path: <netdev+bounces-125522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451A396D815
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95C2B2608F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35717C990;
	Thu,  5 Sep 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EJjRNT5f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731817A5BE;
	Thu,  5 Sep 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538535; cv=none; b=MAsKOiEy9epUJIcFsEhpPbMTrylE+VByU7XcmbbZEzPJqIlXmsN0u7br++4UeERuVbJs04xrYNJt2iaQSj55f9RY3vWbj/GNkHOuC3H+ancbDCJTeSM8kXm1V2K/BcoS5TF6L8bWsgNHvLce3D5uLX4pgKnjSt4fVzmQ5tW/lhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538535; c=relaxed/simple;
	bh=pC39DuleXS5eAwA8Ai7YKU41xH+Q1f5Bx+df3gm3M2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/sPN8RhluBAwTkNbpoNVk7tI4aYGjYLqvoG4Omwxpcu1/xOOD+xcnVY+g6m8gJauXj+gy3xfv1OuSRSh3ZOtkoDcsH5ba5Yc8XSsfBFjM0UmE+pQaLSuHVhB8y9zAK8GVQGrAPsIkzF+kISgERMnrgpkmrXVwf7Bdcuqu5HDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EJjRNT5f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nsDzzFVaGhdfFbiYiFsD3EV3I4ftpm5RMfAi2OZ5GCs=; b=EJjRNT5fZuU/YIB/5v/eLeU6F9
	b/a2Kc9XwqNlzbP7uwiNbivlKp8oWpJOcgwCbCyq22nKFU4olFJ/IHCI0YDlbT8Rbm4XxRz34BkYc
	qA1NOPsIfNddvanFJwNX8A7DoRKE1JxmJ5SdHp+cjVjzybndbpuKlvkFz95g3lhbgq20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smBOQ-006fmz-6k; Thu, 05 Sep 2024 14:15:18 +0200
Date: Thu, 5 Sep 2024 14:15:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Message-ID: <0ecef9f4-61b6-4bef-b9d8-ff6e2fd4c7db@lunn.ch>
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
 <20240901083526.163784-3-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901083526.163784-3-Frank.Sae@motor-comm.com>

On Sun, Sep 01, 2024 at 01:35:26AM -0700, Frank Sae wrote:
> Add a driver for the motorcomm yt8821 2.5G ethernet phy. Verified the
> driver on BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
> which is developed by Guangdong Bipai Technology Co., Ltd..
> 
> yt8821 2.5G ethernet phy works in AUTO_BX2500_SGMII or FORCE_BX2500
> interface, supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
> 
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

