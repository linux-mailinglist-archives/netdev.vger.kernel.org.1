Return-Path: <netdev+bounces-234604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3CC23ECB
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF0B84E5771
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAD3128D4;
	Fri, 31 Oct 2025 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYEKqxr2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14882310625;
	Fri, 31 Oct 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900798; cv=none; b=Di9ylg654/JVFSqnGwllK2GA/5t+OOGud3bg8ijgB5PrrmWIuWqzJc/9dQNeqjxrI+6lOZDyIM2RTh6bU9Uro+ssCvB1VcNfbli0WGXPyzuWAnJJITD2dqH2IZR8h3BJNbig+Ed9ExjGPV0r40Whd/r/SFQ8Hub6dLnTXuS/pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900798; c=relaxed/simple;
	bh=oK5nbB1LtOV7g02ZprYXgPq8GKEmIM9bcsXX+afO7Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1BgbiuW8l7yY2zOa8Oiag+rq/KeCuZASbLsTMUT0HyG40Qpm8xOBRAkOxL+VQ/o2aCjgFaCHs2TyzNR6I1HyYDvIjgnDrVdQOD5HjsnwZpgHRTbk7lPbsiNiBESM+HgXrFE0WS90lrR31s9Gth3bXZUjt3gVUeqFtaISjUkDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYEKqxr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11393C4CEF1;
	Fri, 31 Oct 2025 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900797;
	bh=oK5nbB1LtOV7g02ZprYXgPq8GKEmIM9bcsXX+afO7Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYEKqxr2pRl3d4ijIZ5ZZYCcw/en5aFTZ5TcxpfP/QJ/ZgAtoCyBwnXU3e4SfKfTW
	 WIUQWa+Y0SU4tIKw68AHY4F928BIByHXV5FqmoMmT99dz6DbRvpPJozKjMgge7YxxH
	 TjmTg8tIUZvZyr/dlja+uj+/OKCvrbuS2ANl8RXD0vOKF+goo9uuUDr52O1N6T6ciQ
	 q/glR4+532A3FeETTACxSYqblvKYGQEfoNgo89uv/UL1TmYJyBrDHns/tDyk/7cvIq
	 SqxnjErCtLd3Pf0aCARGpwKJ6mWGAVMfTes+Br3yGaakDaY4gK9hgAfh6tJ+pY1u7G
	 HqtI34pitwAOA==
Date: Fri, 31 Oct 2025 09:53:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com, 
	vladimir.oltean@nxp.com, prabhakar.mahadev-lad.rj@bp.renesas.com, jan.petrous@oss.nxp.com, 
	inochiama@gmail.com, jszhang@kernel.org, 0x1207@gmail.com, boon.khai.ng@altera.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	robh@kernel.org, linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH] dt-bindings: ethernet: eswin: fix yaml schema issues
Message-ID: <20251031-elated-radical-limpet-6a0eaf@kuoka>
References: <20251030085001.191-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030085001.191-1-weishangjuan@eswincomputing.com>

On Thu, Oct 30, 2025 at 04:50:01PM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Due to the detection of errors in the eswin mmc module
> regarding the eswin,hsp-sp-csr attributes in the
> eswin,eic7700-eth.yaml file, the link is as follows:
> https://lore.kernel.org/all/176096011380.22917.1988679321096076522.robh@kernel.org/

Drop, reported already says that.

Just say that this is one phandle with multiple arguments, so the syntax
should be in the form of:

> Therefore, the eswin,hsp-sp-csr attributes of the eic7700-eth.yaml file
> regarding eswin and hsp-sp-csr will be changed to the form of:

> items:
>   - items:
>       - description: ...
>       - description: ...
>       - description: ...
>       - description: ...
> 
> The MMC,Ethernet,and USB modules of eswin vendor have defined
> eswin,hsp-sp-csr attribute in YAML. In order to be consistent
> with the property description of MMC,USB, I have modified the
> description content of eswin,hsp-sp-csr attribute in Ethernet YAML.

That's redundant paragraph. Write concise messages describing the
problem, not some background or unrelated bindings. See also submitting
patches about preferred English form.

> 
> Fixes: 888bd0eca93c("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")

Missing space, missing checkpatch.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

With first paragraph and fixes tag corrected:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


