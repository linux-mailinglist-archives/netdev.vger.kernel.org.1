Return-Path: <netdev+bounces-33782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC77A01C9
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D56C1F22E9E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537ACA42;
	Thu, 14 Sep 2023 10:35:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217E28EC;
	Thu, 14 Sep 2023 10:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372D4C433C8;
	Thu, 14 Sep 2023 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694687737;
	bh=knnE7bRmUUq3+cRp/uC22ElRLHv6Q5lav+3jkPfNLbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFlHVhwSEQctSqlNHXDef5E4hBblsjZOc4hy3+QvWTpC1ZyhqEpSjCv0E9lHKWiNo
	 r2x5tuBd9gixGcXweL4HXXl1UXlxyICKOS+mEAf68fnzxMifS8psH/9GGxiTu542dc
	 yNwikW7NekcIDiyJrQMaK0TzSY8StW9To+TJfMGVhwmMz/Kj4HG4UlD905kDSH6QNo
	 vQW8RY7aqAXoNEweHJ8Nt6ls1uJSekDM6jBj9QmTJ0sQISjLhMPpGNwsKxOmj/WUCn
	 hN8ijmUS6kyp+F/0neky8jX11ziGA+/Noe2/KVijf7JYdLoUM7xPUSVvcNTtADuNvI
	 vp96TGJG8qVHA==
Date: Thu, 14 Sep 2023 12:35:26 +0200
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <20230914103526.GX401982@kernel.org>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911060200.2164771-2-danishanwar@ti.com>

On Mon, Sep 11, 2023 at 11:31:59AM +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can

nit: connected

...

