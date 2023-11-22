Return-Path: <netdev+bounces-49850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C81D7F3AE1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01425B2138D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF88138D;
	Wed, 22 Nov 2023 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B5EFjDuy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5724CD5C;
	Tue, 21 Nov 2023 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dj79vzUBkAUSzb4ejlUxr7fcnIOCKB5na2L/pzvm/gs=; b=B5EFjDuyOslbTC8LMn8YNqv7FW
	c1bIVKjJJVawfS3r25tjMY2JPu1x1vBxmlFbvZOJHbVJuhOiSO0YW/VNTD8Q1+woAMfTtuCLEnO5R
	nfeJpwJDAC/e4YaK0H+v95siwwDnWLe5hYfub8KAHEOBjyeA1FcPA3JguyC+RVx6Yd9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5bWB-000oPf-6c; Wed, 22 Nov 2023 01:55:03 +0100
Date: Wed, 22 Nov 2023 01:55:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: axienet: Fix check for partial TX checksum
Message-ID: <9893df1a-9c9d-4107-84ea-cb757b06c709@lunn.ch>
References: <20231122004219.3504219-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122004219.3504219-1-samuel.holland@sifive.com>

On Tue, Nov 21, 2023 at 04:42:17PM -0800, Samuel Holland wrote:
> Due to a typo, the code checked the RX checksum feature in the TX path.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

