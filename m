Return-Path: <netdev+bounces-29137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD7781ACD
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3688528168A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B0219BD9;
	Sat, 19 Aug 2023 19:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3119BC7
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 19:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07162C433C8;
	Sat, 19 Aug 2023 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692471932;
	bh=8miKaykA75x24NaSRyqIaqGKzXJRW5c2nmekvjMFLlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv507lkUHGjxxZcBPFH6xdHTS4EARgIxo500tWeh8ybN/r3e7FN/b7hPVbH/879DX
	 ZXlsNdR3sQOuu/Qf0w4viY5JhGfoJmg7auTi3SlFkjuJf2E91VXH+V7/zsCLxpfsK7
	 69Ggi5B1QxnocJ4enm+/pxJYDaiusyQuAI3p5OipwvLHE8TYgLSE5gQTlrwk+1cRb6
	 ofLnYG3AmIUtz1TXCynxjlqg4jna0/ajD65FYnaOAOz7UPareKmJFlV2GZZFGZJSTS
	 qVRfmkrVrd1AvVdTA1wEd7RS4QELUxcGbSCTtX8XJOHKPu5944qkxlAYaZ8/SWNJce
	 WdwV0SGF+PKEA==
Date: Sat, 19 Aug 2023 21:05:24 +0200
From: Simon Horman <horms@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <ZOESdApO8NN8kDQc@vergenet.net>
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-4-keguang.zhang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816111310.1656224-4-keguang.zhang@gmail.com>

On Wed, Aug 16, 2023 at 07:13:09PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partialy based on the previous work by Serge Semin.

Hi Keguang Zhang,

as it looks like there will be a v3 for other reasons,
a minor nit from my side: Partialy -> Partially

...

