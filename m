Return-Path: <netdev+bounces-30456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BC9787672
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 19:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC04C28162D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D21428F;
	Thu, 24 Aug 2023 17:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B514A82
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 17:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3475FC433C7;
	Thu, 24 Aug 2023 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692897408;
	bh=UulZEWglMRPoeuRzmNm1VVsIcGoEPxngUS2/IJ9FdHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loVk2sZZ/EBAK2Q48rT1nWmOe0iBCJHJetDxQ96YLMkWHj9QjrF5bpJznQ2GOKSX+
	 eXgB708ZZ8B/Jf46TT3uXYDjQXgddCS3WpHOcM8Y0uVgW3Z6Av+mEmKK5dKI0uRfZM
	 waOJvBzFwjDiE7ywptFyjUyydBD3tOKEolFZ331wwHHx4zyNbMgqrtXz8mGUeidsqY
	 yGiFNDfgKU9mJImx9T3SLZsgJBoRdZZGIQ42Vah3Ls83y7eXDGtuwdhg7Ck5Uk/VtS
	 DDtRk8MELf9CT3ynndyyupB5VgEhuvkLi+8mQV8N8JJ4dRUcfv6scmSMDm+qBIamtv
	 nrpFmO3eqwsfQ==
Received: (nullmailer pid 1060950 invoked by uid 1000);
	Thu, 24 Aug 2023 17:16:45 -0000
Date: Thu, 24 Aug 2023 12:16:45 -0500
From: Rob Herring <robh@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-omap@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, Eric Dumazet <edumazet@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, nm@ti.com, linux-arm-kernel@lists.infradead.org, srk@ti.com, Simon Horman <simon.horman@corigine.com>, Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v7 2/5] dt-bindings: net: Add IEP property in ICSSG
Message-ID: <169289740438.1060890.15375299458670602935.robh@kernel.org>
References: <20230824114618.877730-1-danishanwar@ti.com>
 <20230824114618.877730-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824114618.877730-3-danishanwar@ti.com>


On Thu, 24 Aug 2023 17:16:15 +0530, MD Danish Anwar wrote:
> Add IEP property in ICSSG hardware DT binding document.
> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
> of ethernet packets, PTP and PPS.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,icssg-prueth.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


