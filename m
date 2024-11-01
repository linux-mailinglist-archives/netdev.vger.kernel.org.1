Return-Path: <netdev+bounces-140889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FF9B88E7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6371F22B8A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F712FB34;
	Fri,  1 Nov 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNtlDTwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE712D758;
	Fri,  1 Nov 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425994; cv=none; b=XCQX2mqLOgFMGBWHU/s+Qfyzj2W+AbP3EFcKYOv4UNu9MvM3WRlVoEvnd3quNUjvEbAXenIIq/5MFujpHdCOjBrk+lsQVa53T8OyeWAkCmfym2CrB4zKPDSZDhBhRqVdZG5zhAskulPk828zHsrxI4b06je6xKxt1bSwWWRhsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425994; c=relaxed/simple;
	bh=kAfgBaLVneYp2OP6j9guxjjd4rVucLYNQVBy+4UBS0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udtWF7V7CwnXi0WOPkjmrOkLFAMmg8ARKZz9ZXRUP2zXXRrOouKgRFAN1/NU7PC2HyViuV1oxGpxA/XZcaDUNCU/cK/CU6V18faJF+SiuTUO9m/EaUVhsu9pe2v9BkICBNIkaHcTYB0xlf/NiWLxxOC8Mg7hNRR0zWfG54i8zSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNtlDTwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C8FC4CED0;
	Fri,  1 Nov 2024 01:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425994;
	bh=kAfgBaLVneYp2OP6j9guxjjd4rVucLYNQVBy+4UBS0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNtlDTwccG4dvIXNyfo5DbfGZV7PHgd/reGMpE69cn/mU7z3kc7ATpzg+CpXCf0+Y
	 kxsLOgh9kPhVir9g7tcp/3GIkV1yfqxW5T+kigkdcMFqpIa+DQ5uzOskSzAqS9WvND
	 IPoYAbMf/j1XdiW6BO44WpdAkeUhUFQEkzldF7d+/Rc2j/dXwoJ+ahR3P/yo3lPlWa
	 etpMiIjDm7yx+T0o7ROKfhM+G1gePOhpNbtgIZkOK1Hd7rubml6livNDO0+3ra1Iux
	 NhTo5XmUeqiqL7TiLoEQKZ7elFC07RMeaozKDhX8unHn5MOptgGL2GmnDYDHAxEu5Y
	 7Aypv8aYl0SqQ==
Date: Thu, 31 Oct 2024 18:53:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Cc: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct
 phy-mode property value
Message-ID: <20241031185312.65bc62dc@kernel.org>
In-Reply-To: <20241028091214.2078726-1-suraj.gupta2@amd.com>
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:42:14 +0530 Suraj Gupta wrote:
> Correct phy-mode property value to 1000base-x.
> 
> Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> index e95c21628281..fb02e579463c 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> @@ -61,7 +61,7 @@ properties:
>        - gmii
>        - rgmii
>        - sgmii
> -      - 1000BaseX
> +      - 1000base-x
>  
>    xlnx,phy-type:
>      description:

Can we get an ack from DT folks?

