Return-Path: <netdev+bounces-219596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B91B4230F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6804C1BA565F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531B305051;
	Wed,  3 Sep 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PKC7mlYt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E7286892;
	Wed,  3 Sep 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908431; cv=none; b=gdxX1FcRnWzxYJ8tLlx4bwl9TAXswxGxMZhCCRd/a+qS49uDKW1EtIz++HVBYEPMxRace+6faaH0dSUAJGkrT9ua1YSqDaTJHpQnM9mJASFCtQSemerErNnNwDilYSUe4bpr3sLHt9xPMtQrhxHS/uSyjd+kxMURxTUhZz7gOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908431; c=relaxed/simple;
	bh=1Wb/6rFMh/8bTMs0N9gKDqFG6XZTLORKxkLUXcHhYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+NhJEPTaRHqVaLL8MiuWkfzxokGban/csOr+03qeR+OvdvHOXEq1Y86UW02Q003IVDZ06LIp0kkQsjwomJjefvrO3QcgopMl+ySSZXCsoz5+SvbV/CanxiA7eMJmf1wS0zoN+SlJrR/CagZWrUH4hc9qknC89agfwbOLcfpKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PKC7mlYt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IKFS3y5daOqWaKHPU+LGGnIxAUZ7p5yYYNJ7KEL39IE=; b=PKC7mlYtwmdrYmC9dO0eS6a/1v
	PnXfB4PUclYOsME0dz80pvRIdvUM0urIXWfGBQSbQIQzjczgiDnrkhBvigxhm7SEKwENJis2+wpNp
	eZOiMa3C0pyuvMvz0nVBaAawfzkfQom27j8rZtAF+mksOE4PLxCJa/OUlt/RsI7j3GrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uto88-0071kq-AO; Wed, 03 Sep 2025 16:06:32 +0200
Date: Wed, 3 Sep 2025 16:06:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Xin Guo <guoxin09@huawei.com>, Lei Wei <quic_leiwei@quicinc.com>,
	Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
	Fan Gong <gongfan1@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Suman Anna <s-anna@ti.com>, Tero Kristo <kristo@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
Message-ID: <6e56f36f-70fd-4635-b83f-a221780237ba@lunn.ch>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-3-danishanwar@ti.com>
 <20250903-peculiar-hot-monkey-4e7c36@kuoka>
 <d994594f-7055-47c8-842f-938cf862ffb0@ti.com>
 <f2550076-57b5-46f2-a90a-414e5f2cb8d7@kernel.org>
 <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>

> >>  	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
> >>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> >>  			<&main_r5fss0_core0_memory_region>;
> >> +	rpmsg-eth-region = <&main_r5fss0_core0_memory_region_shm>;
> > 
> > You already have here memory-region, so use that one.
> > 
> 
> There is a problem with using memory-region. If I add
> `main_r5fss0_core0_memory_region_shm` to memory region, to get this
> phandle from driver I would have to use
> 	
> 	of_parse_phandle(np, "memory-region", 2)
> 
> Where 2 is the index for this region. But the problem is how would the
> driver know this index. This index can vary for different vendors and
> their rproc device.
> 
> If some other vendor tries to use this driver but their memory-region
> has 3 existing entries. so this this entry will be the 4th one.

Just adding to this, there is nothing really TI specific in this
system. We want the design so that any vendor can use it, just by
adding the needed nodes to their rpmsg node, indicating there is a
compatible implementation on the other end, and an indication of where
the shared memory is.

Logically, it is a different shared memory. memory-region above is for
the rpmsg mechanism itself. A second shared memory is used for the
Ethernet drivers where it can place Ethernet frames. The Ethernet
frames themselves are not transported over rpmsg. The rpmsg is just
used for the control path, not the data path.

	Andrew

