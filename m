Return-Path: <netdev+bounces-53984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB6805842
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B44F1C20CC4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690D67E61;
	Tue,  5 Dec 2023 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WyVChPPB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42EA9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mp7we2fg4dWZXf60fWKP7UIGf7x7Wmm2sw9OmWok630=; b=WyVChPPBE+uiFBPHY3TpTYcTIr
	V1Eeb1ExFpowFqPUTYBRQVDYBcx7pKm28dG7bvy6xF7K9hUbJA0s454coqkO3uOvpyx9cAJAQ7AAy
	S3SYR+IoOZGNi+PdXgz+B/vhtS1jbSe5rRf5zHFGekQFMFvOI4cQFr4FUU8MsfLZXWbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAX3M-0026hC-J0; Tue, 05 Dec 2023 16:09:40 +0100
Date: Tue, 5 Dec 2023 16:09:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/3] arm64: dts: marvell: cp11x: Provide
 clock names for MDIO controllers
Message-ID: <072fead9-dd1c-4879-9235-d3d9c56e6ad4@lunn.ch>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
 <20231204100811.2708884-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100811.2708884-2-tobias@waldekranz.com>

On Mon, Dec 04, 2023 at 11:08:09AM +0100, Tobias Waldekranz wrote:
> This will let the driver figure out the rate of the core clk, such
> that custom MDC frequencies can be supported.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

