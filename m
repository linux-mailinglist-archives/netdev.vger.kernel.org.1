Return-Path: <netdev+bounces-155043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E34A00C71
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330033A417E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64931FBCB6;
	Fri,  3 Jan 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPEHieJG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848DBE4F;
	Fri,  3 Jan 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923353; cv=none; b=hMWR2D+cAei+wowH12pbH0Jo7p+HPEsR/Xg1caCpB/Kgx/ZycAqif9GROrzlvtEbYidjCKQb4YGKFgnPQfdOOQd6f0y5KKwVZGrU+NMbZBTIlp7yxgv2zDSjA+Q8TqnXRclYyW06PF510T6zNemgWHt4ndvlOwfJx/lR7E6RfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923353; c=relaxed/simple;
	bh=UATO23qcVHHPiRn6kDJDY1d+aEUGAULwRtnzqvBFyqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScWpukJdo53R4FLj1xYFqTvHmbhP+fSsPyclVCjRg3DsDaq432ApfsPGg5wQLlj1vnJPLuTt1vbJbEW4dTFaxRhunqYhtTmKc7DqZe3SZTQadhRaP+BjMKxUDIl+qPl2MPxAWI7Vg5KKz/ClGQ76VbZ9RqV6hKkVmuI8IDHt0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPEHieJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21A3C4CED6;
	Fri,  3 Jan 2025 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735923352;
	bh=UATO23qcVHHPiRn6kDJDY1d+aEUGAULwRtnzqvBFyqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPEHieJGdOEaNX3/Kp2mxHAlEEktfnj+x+ZdjGzUex7p4YLkQ8xbNklRG8FapebDT
	 m9Fo3FfoXXE7hcWKwedvwVLxRh3jrHSO2jdPalbLsXnrJKBWDVwQAACQF1YIMWJGmw
	 k7UcOatr9Nj9OAxJLm9+EK1QPYQ0X8PDPj3QvGxVi5yO5ZZTqscr9xmUwVaescqHqc
	 6LEIwV/Nzo9DjyAHtNad/w4Flvtp2FOzdJFzVwLbf7gE+KnFGVEsAk2tA6qiyratCc
	 ax4Di4ycV3nrsNgNnpS/7RBAX9NS9jWvooEBTO9aWve7B9a/Wver/FjhbzSR9zueuW
	 8bhIOkDVA3G9g==
Date: Fri, 3 Jan 2025 10:55:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: edumazet@google.com, peppe.cavallaro@st.com, andrew+netdev@lunn.ch,
	joabreu@synopsys.com, netdev@vger.kernel.org, schung@nuvoton.com,
	linux-stm32@st-md-mailman.stormreply.com, kuba@kernel.org,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
	richardcochran@gmail.com, ychuang3@nuvoton.com, krzk+dt@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, yclu4@nuvoton.com,
	conor+dt@kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: nuvoton: Add schema
 for Nuvoton MA35 family GMAC
Message-ID: <173592330334.2414402.4730979254460270593.robh@kernel.org>
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250103063241.2306312-2-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103063241.2306312-2-a0987203069@gmail.com>


On Fri, 03 Jan 2025 14:32:39 +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




