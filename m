Return-Path: <netdev+bounces-225470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD23B93E7D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4083518A3CFF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAA26D4E6;
	Tue, 23 Sep 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fpQqUijT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBB26A08C;
	Tue, 23 Sep 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592249; cv=none; b=fYk80SEiXEnOwOqwglCFN4yb3tEwydLUDV+QbPGzMvojGww6aXTdKCVHoXiC43iRJAxO5Vfl9zD0KEqqJDPCfH65dQtVP+7Vy/3RZEg4aVf+2WnPXZpvPOK6ZRg0B+PrN7w8bCqIeFJXUyRx3KUvj8sUqSigHhKZynHOu+Qp7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592249; c=relaxed/simple;
	bh=k3Igvg3SGWynTH4R6SLXvhsuP2f6N/OFp6btUx+XMjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV59jN0BrmxxHBFFH5iHHt+qDMm30xcEygGbPqxyBtQsmJP/F1HVRk60udjXAxVxpPyQg8OFEwERVUwIDMhJ77e0Oea5oOElmZlBaEnuDAgEJLEmRBocxtMCbphNq5Zj0azvDLxw5jym/QNQA0jB4x9ethrVAx6a4un4T045LHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fpQqUijT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=NYmJtsN1O6NBKmLlOMTwtQSX9LYaEORajDDSQ0exefo=; b=fp
	QqUijTGU58T+muyePTBNg5hsFd9Wudd5VH5J31W3Wp5UXgHBSgC5fcS3NzX2ON8IeBCR19iLNuytR
	y8Yp44eTJV5cryWOFcC272Bl5LVZH3iSCAeepa1YPhg94ESprGPVB11u/hdxbkJ1cZvkwi4cHzeSe
	UYQ7jPVpPXpycbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v0sAk-009DVF-6H; Tue, 23 Sep 2025 03:50:26 +0200
Date: Tue, 23 Sep 2025 03:50:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: j.ne@posteo.net
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ethernet-controller: Fix grammar in
 comment
Message-ID: <dc595d5e-9759-49e7-a535-3aa5acaa6591@lunn.ch>
References: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>

On Tue, Sep 23, 2025 at 01:10:01AM +0200, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> "difference" is a noun, so "sufficient" is an adjective without "ly".
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

