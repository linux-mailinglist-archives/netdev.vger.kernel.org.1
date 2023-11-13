Return-Path: <netdev+bounces-47365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57017E9D18
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43641C204D6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A520200C5;
	Mon, 13 Nov 2023 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hS4D5b1r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86D200BE
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 13:26:48 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791B1727;
	Mon, 13 Nov 2023 05:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pfcW8qeJCMHcAwIRFFYN+wW+7MhhjdY7x1I2HeySpfE=; b=hS4D5b1rTc1TsL5ilOe/HB+Za3
	K4PhXsAP9aWq+wxvqVBr+OhL/yWLUrN1yY7ZMpCYx4RHJkq/emCLRdc9oeyQxJaPWeDk8k2MdPDSD
	8viocR/HkiiteMt1K0t3Twu6ZTaLNDOHF4bVe0qnvecaRrDpiv/r5YwIxiMIWGaknuFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2WxX-00043q-UO; Mon, 13 Nov 2023 14:26:35 +0100
Date: Mon, 13 Nov 2023 14:26:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
	r-gunasekaran@ti.com, srk@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX
 channels to maximum
Message-ID: <2f0264d3-e15b-4405-9424-03ff21900316@lunn.ch>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-3-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-3-rogerq@kernel.org>

On Mon, Nov 13, 2023 at 01:07:07PM +0200, Roger Quadros wrote:
> am65-cpsw supports 8 TX hardware queues. Set this as default.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

