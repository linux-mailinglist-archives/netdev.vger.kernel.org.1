Return-Path: <netdev+bounces-155642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E68A03406
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24C118855BF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A3481A3;
	Tue,  7 Jan 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpl6zwgd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A913FB1B;
	Tue,  7 Jan 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209856; cv=none; b=fZt6pDefjalWFD9E5Oeb8uSHpv/xLG25LhuS0dLkI0A50JeueecNvPfAnR2eopbB2bwtDVHDxM6gw0zZw3CjH9c4FQZWs+CkPBmS96x6oBSDt8bSsIBBRme7XexJ11RAyNk636B7OxFvXECT3//bckO6II4Gvpc+p1y9/kdhuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209856; c=relaxed/simple;
	bh=wDhSYOfboak3qK+hy1jYjiF2LpSH+HGBwrcDHRKoB60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIq43qEUIieFsQQf+Y4WXTsdB+r3SsD0UVhGJgNFl5mOFeLm3lDHguIjVCbyk764nvuLexiEvLeWNC35gssDETu0JMnre5nvgknJvwtDRvge+QAjd5OUBJQTx6flfzs9V37wqABU4zf3GfN11sBzLJAwKOn+Pkf/zLbtKVIvy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpl6zwgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BFC4CED2;
	Tue,  7 Jan 2025 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736209856;
	bh=wDhSYOfboak3qK+hy1jYjiF2LpSH+HGBwrcDHRKoB60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hpl6zwgdR4rZ4/LVHS2TAzt0LK+XL1glv0sqbDQZP5vA/yFhfcJUM/eZMo6mBhJG5
	 XyzVwBNReTSIVRdlVitJ1NShl44sdJ0tzFaKhuvroIL1z4OEWZ6V5iR9Qu0HlW7kNg
	 6ymMwWmMG8LsBL81AQsCNwYMqgv9UXNZMC6TTPeSVj0YYaO61EtJEwaQk1aLAD9pa+
	 7pEmZ69BMmznRpGThBIONnF1Y7/r40mDlKWDJJv/TMQiD8ons7ehNGNdLqmj44+dKj
	 7upTyLTWkJ5nTVSqIm8ITzVHXzrR+oKncduJjAlNMaVm3wCqB72QGwqf0IodKWQjlS
	 nFn5woCVD5o0w==
Date: Mon, 6 Jan 2025 16:30:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v6 0/3] Add support for Nuvoton MA35D1 GMAC
Message-ID: <20250106163054.79cdd533@kernel.org>
In-Reply-To: <20250103063241.2306312-1-a0987203069@gmail.com>
References: <20250103063241.2306312-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 14:32:38 +0800 Joey Lu wrote:
> This patch series is submitted to add GMAC support for Nuvoton MA35D1
> SoC platform. This work involves implementing a GMAC driver glue layer
> based on Synopsys DWMAC driver framework to leverage MA35D1's dual GMAC
> interface capabilities.

Would be good if you could reply to Christophe's question.

Then please rebase on top of net-next/main and repost.
The first patch doesn't currently apply cleanly.
Please leave out the second patch, it has to go via
the appropriate platform tree, rather than the networking
tree.
-- 
pw-bot: cr

