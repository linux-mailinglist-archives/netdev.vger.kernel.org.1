Return-Path: <netdev+bounces-234605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8DFC23EEF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC12A4E5920
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5E315D43;
	Fri, 31 Oct 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7+hjfxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB499310625;
	Fri, 31 Oct 2025 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900851; cv=none; b=TgzcqrA9zfv7pmfPnZFfxKaOXlQpm3eLTt+6CHh/eI8qJQ8lbOiC0szz9wjgPtZAOOwkn9B/RzGSPktX8my/R3W15v8J5yBCXMKfIWcvYZCUkZuQvDEK3Uf3A4nHm27qES5k711hKSgiLKdcHn1+EW93dheeoJRw/gyg6J7a/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900851; c=relaxed/simple;
	bh=Lw7yF10xMLzuOE0JXvv0x2sq04lm1fFuwSZpHCOq9mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD6K8kKw6KMUvJ8BNX5ypAZVG15CfJa6EQVtbflP5OKjr4MfNYXSCkws1V/aQawTT4uvCF5myrZKa+QRljjlVSldrU0if+VRxGAHVugi3VvwnSoACyZZwomseKkEqlgNDSRL4ZeAVmCGCu8RxuRpqJYqZGa6dKR8rFc7Rql/9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7+hjfxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ADAC4CEF1;
	Fri, 31 Oct 2025 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900850;
	bh=Lw7yF10xMLzuOE0JXvv0x2sq04lm1fFuwSZpHCOq9mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7+hjfxtbZHKoqcFjOPoLfaXzVymj6iAzO+1+my+UGN9xQzo2tbNW0nIZ2hVNb5mz
	 7oe+qGdpTg/PDFq7EJD3H5eyhEfTwTGX55+0Yt95ZIyKHPI7hN7/43Ap3OrgOPtmTO
	 n+JG7SR6NfhvVrfb7HpyQJzeFHTjfGuv3yQTKqDuVU+/U7WnzDkQyj0hyC7iZzvvrO
	 g2dUM5EqkWRGV1s8VcxVUpbTjgp3IUu60ALra2NYWkb1kQrosb2ppgEDxRV5ARZrVA
	 7SXhjjIBZK8Zyf5I6fNO0T2IUpUkN/OEDoTHbLICjWUEG9WsrJ3/K77wpMOsdjCIsX
	 5b66IiXsWzOKQ==
Date: Fri, 31 Oct 2025 09:54:08 +0100
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
Message-ID: <20251031-enthusiastic-rugged-aardwolf-a5ceb8@kuoka>
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
> Therefore, the eswin,hsp-sp-csr attributes of the eic7700-eth.yaml file
> regarding eswin and hsp-sp-csr will be changed to the form of:

Ach, and you forgot net or net-next subject prefix, depending which
branch/cycle you target. See submitting patches and this subsystem
maintainer profile document.

Best regards,
Krzysztof


