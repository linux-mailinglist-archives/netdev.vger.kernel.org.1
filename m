Return-Path: <netdev+bounces-74976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B68679F2
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0229F24A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3212F363;
	Mon, 26 Feb 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YgBszIjO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818C12AADA;
	Mon, 26 Feb 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960419; cv=none; b=alVkQHtglMC0cR6I6/i2883X8+8z9ncR5CZSjQDnAHhfbYEZXqkfRDYAPWGkYHy2Bet+ntzViV9eePofxtDARoJHdtO1VOFNcdqOy8Ggt2AQq14fWWm1YgH6hovrePQgoYAZxh0NI1cpe6KAB7TV9L28Lui2NkNMQQkcTJFvaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960419; c=relaxed/simple;
	bh=3K5Q+uUQ3Nix87plZgBtdiamDN+V1OA8pvKevYiMOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah9Vo893EWt7XteM1YVKv6DfZRev3sgjlJf8JADECa8kpfa7xEPezHto095QLA7I+J0OuWR8ngaFyjS5HPWIHie5P4ceiLWtVlnmFUIz4Rg15BWuwOBnjZveoyMApGqhTOOhS5S0exvxthmU949M0eV2IDThxnvOpAor7zm7ifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YgBszIjO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4mImZSK+nWI+wjJkO50Cew7O8xH1ti6eRINL7vztxBQ=; b=YgBszIjOtxEkvEuhbgEs4yvRCG
	Gm/4GxjQWuJaJlSNYXgVNfw105v6/O6/9zgLdptu9tAnh4LyaiD3maMNYiVj7VHCfALlQ4bQ+ato/
	1a0Bcq/a32TcCEm/yTc5G4hnqLjZpSZUwVzfiqKvU+rmntO5jOYx8AnMIH/cpueGqRD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1recfh-008jbJ-RK; Mon, 26 Feb 2024 16:13:37 +0100
Date: Mon, 26 Feb 2024 16:13:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/7] dt-bindings: net:
 hisilicon,hisi-femac-mdio: remove clocks
Message-ID: <e566de39-dd54-494c-8a13-78250467e923@lunn.ch>
References: <20240223-net-v5-0-43b22d39c013@outlook.com>
 <20240223-net-v5-2-43b22d39c013@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-net-v5-2-43b22d39c013@outlook.com>

On Fri, Feb 23, 2024 at 09:28:17PM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> This integrated MDIO bus does have a dedicated clock. Remove it. The old

I think you are missing a 'not' in that sentence.

  Andrew

