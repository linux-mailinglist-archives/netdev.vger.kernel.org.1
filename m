Return-Path: <netdev+bounces-57998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCB814C2B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A96B21427
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500373A8C0;
	Fri, 15 Dec 2023 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wJwWbat3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1653DBA7;
	Fri, 15 Dec 2023 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7nYzH22LO4fzfP6gupLWbgtIdjUBvIX9s3qRIeMw4F0=; b=wJwWbat3dR2/W78qjQCGwYElTM
	VT6buch+Z5O6X8T0/Ng5Z1JSQ9dCYjkMl6d3iCeUy5GEovRao+5z77sSJTnQf2EkEqFgdns9hI7LA
	gr5DIMK2eWA75sRSr3ZGFK0qy4OHsktDQdM7uuTnP9W+UdCfxIHIK2tnXBCtpNhEYMH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEAV6-0032R3-Q1; Fri, 15 Dec 2023 16:53:20 +0100
Date: Fri, 15 Dec 2023 16:53:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop
 "reg" sizes schema
Message-ID: <520366db-88f3-4485-87f9-68e11cd15e22@lunn.ch>
References: <20231213232455.2248056-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213232455.2248056-1-robh@kernel.org>

On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> Defining the size of register regions is not really in scope of what
> bindings need to cover. The schema for this is also not completely correct
> as a reg entry can be variable number of cells for the address and size,
> but the schema assumes 1 cell.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

