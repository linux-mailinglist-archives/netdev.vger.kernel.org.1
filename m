Return-Path: <netdev+bounces-205016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F7AFCDF4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD68A17D869
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB12E03F4;
	Tue,  8 Jul 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gdj9+Tuu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191822DFF3F;
	Tue,  8 Jul 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985639; cv=none; b=JEhmjaw0x1j47wPjXnWs8eoX7JMMjdda1Bmm8mfDWaBGqeLiGzUtHqFEMwYs7WHE+HLOlx/jTJ14hmmFKPU6zi34q4eQ7jfblkUGVQMph3gd4ZTU1vf1Lhn6v8UteHGPtJRQC5JdQ2oYue2vdsZpjiDbuMgkPJht51AlMXUyOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985639; c=relaxed/simple;
	bh=ici+d7X96ldZgmo8gOK9/ovem9QEybTlAcmkuCV3VRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWSnwjImyWjRZEBgEfEJLYRpTFtGX4DlGjPAlarCKJ5gTzNgqshf+qN6zqxSi06C9ijCFUA7Ln61lFLbtbRIU/wnwOzEJGcvuRtCKkARF4tSt/usm4Ralt/CNrPKAG8YyHTwdPm0TqySB0TFjrtNfSCZFRaUjEnma1UqrS1DUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gdj9+Tuu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dgT+lxY1s69iozAyvWoICFQiXCuSbWbkU6hDrPGJuVI=; b=gdj9+TuuZ5gxf9tmpGmrK5TU/d
	cktB/cltikxtVzYmfGkHdWsepGnd3j9d/DFZ/QQDunamYK4H8pca06RnOAOKLWj1B6hq+zrYIZxm8
	NKyo/kIUHfuqxOZcalR6RWPFWf34R0GNbpTGRFdrfVDr06rYkz9b3wmsHL7B2HCTCmjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ9Uj-000paE-Mg; Tue, 08 Jul 2025 16:40:29 +0200
Date: Tue, 8 Jul 2025 16:40:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/11] net: hns3: use seq_file for files in fd/
 in debugfs
Message-ID: <7826b514-823c-4211-863a-8bed402f51ef@lunn.ch>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
 <20250708130029.1310872-9-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708130029.1310872-9-shaojijie@huawei.com>

On Tue, Jul 08, 2025 at 09:00:26PM +0800, Jijie Shao wrote:
> This patch use seq_file for the following nodes:
> fd_tcam/fd_counter
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

