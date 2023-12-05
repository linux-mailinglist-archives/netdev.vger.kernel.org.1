Return-Path: <netdev+bounces-53988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17544805853
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5222281D6C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA37768E80;
	Tue,  5 Dec 2023 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d9gt7G41"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C039A9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tuI/eiXJATNz+D4WIYLLjBZMb7w6Lxcvf2IvEhijHQ4=; b=d9gt7G41pKSNdnlPFoGC4JsIRI
	KcixSjf/e3RK+Aj55Y/HmeO6pY1XH+NtSwB05vl0pSAYby3paq/hCHSZOPtwT7ctMGzDSRU8DFcAt
	jH/Y02mWSbB0VOFMGZT0gWAHqVt1/puSmKV6ldfzSRKY586PuVVfkqyb+hq+5fAWdNz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAX7D-0026jx-Fu; Tue, 05 Dec 2023 16:13:39 +0100
Date: Tue, 5 Dec 2023 16:13:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] net: mvmdio: Support setting the MDC
 frequency on XSMI controllers
Message-ID: <e7656979-30a1-4a00-be94-db65f540e58e@lunn.ch>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
 <20231204100811.2708884-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100811.2708884-4-tobias@waldekranz.com>

On Mon, Dec 04, 2023 at 11:08:11AM +0100, Tobias Waldekranz wrote:
> Support the standard "clock-frequency" attribute to set the generated
> MDC frequency. If not specified, the driver will leave the divisor
> untouched.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

