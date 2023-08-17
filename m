Return-Path: <netdev+bounces-28562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D777FD63
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52941C2129F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E3171DA;
	Thu, 17 Aug 2023 17:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA97171BF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA3C433C8;
	Thu, 17 Aug 2023 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692295172;
	bh=qzYPW5cbU+GIAmk7TVP23idJ9s55oOoU2LiTCXeHems=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjVFOl5xDKQ+Ky1cGS9FoQ5MEyeSc/qEX0AqMoEar6uzRoC2Zw/v0+ijL0QMpZl9W
	 wTCE6zzP/4AmgdXK9oLJTcX34i7upFwRpacC8zu0jB21iNpUKw/mnFNlCEYDTW8QFu
	 4p8atiAt3xy7wUhz9An5SHIlpUJGB3r+pWkewWLQ64KYlgzxxE4viDPw8XakRZ25IF
	 hwc9jm8l5e77hZbofkCga5Orn0gYwLXhWLO28bxlbx4hY+Y4AVbYo1Zd/X9Gs/C6RJ
	 3iCroqRP+/jaAoKfG/bYYqFMB/6E6cZreUfGIwwdls6yVqrDImwV2CTZkkVtuZFYiF
	 2hUmRYdOZCWzg==
Received: (nullmailer pid 1873962 invoked by uid 1000);
	Thu, 17 Aug 2023 17:59:29 -0000
Date: Thu, 17 Aug 2023 12:59:29 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Message-ID: <169229516847.1873884.10919743242203850661.robh@kernel.org>
References: <20230805135318.6102-1-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805135318.6102-1-fr0st61te@gmail.com>


On Sat, 05 Aug 2023 16:53:18 +0300, Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 102 ++++++++++++++++++
>  .../devicetree/bindings/net/ftgmac100.txt     |  67 ------------
>  2 files changed, 102 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
> 

Applied, thanks!


