Return-Path: <netdev+bounces-229688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D715BDFCB3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186783BA7D6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5F33A031;
	Wed, 15 Oct 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRcGM+jf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68A33A02C;
	Wed, 15 Oct 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547696; cv=none; b=GgSOui9CXCaGCI2GmJxgB524EPcI8rPlU/e/cJrTGff47RGe2Av7rJ0f/7wJMlHMatNm4OXK0UuR7JCdW0LzXsCgevzYQcniS1ujy7U/T5SAh3BjsJM9FbqAgZxv17Tw5Y0NKYRkxpIZM3NxM2QqoOBxuCzJDVDVg4QYYCXSTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547696; c=relaxed/simple;
	bh=pTf+7Y3EmYxCZvAsBOkLFh1gMXWom1x1UMWCNNYwxcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNvaLp664JGbFZONxEeE6okKtzCTsD8wPUofitu5Ht/HE5ryuzwL0we0FHR8+EaTCfb4eACBe/X/UZKaqxKyXTkIQbgn7DT7TWMBrKoU7T38oYx1+ULolkuOY2cf6hg/vg/OF9L+5MsWtisTncAOJqGId2Z5bEyUwOrKtpzMKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRcGM+jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB1C4CEF8;
	Wed, 15 Oct 2025 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547696;
	bh=pTf+7Y3EmYxCZvAsBOkLFh1gMXWom1x1UMWCNNYwxcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRcGM+jfmcX1azO+9iu+4pPmmQXNz9mWGbXzLmWCcQG+Mmd1nhY3Q3k3k/gmVtkzc
	 lBn8gI/Q+tVLMVN2khMulSnpodfiQf1qCW0qxlsTHMryviRp/dyFKuhQIYMxbucTTb
	 c38yJUjFkNnr9YcMUvhKw03ZaFoPn0LQrKWzEm2hGBtnsniV70TJ44zkrR3M+vtZ6z
	 Nhckl4CBXLuJHC/fX2FVhLBDwjypXMGRzKK8RMOlj9A00/br/itIDEUOu/zS8j0rpv
	 96J7vBOkgw5hU6j+iauIXjD7VVclIfxkzQxhjD5mjIGuW0PZ7ONTHSZrT9U8bmbhTT
	 9T5kkTuJw7sKw==
Date: Wed, 15 Oct 2025 12:01:34 -0500
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: brcm,bcm54xx: add binding
 for Broadcom Ethernet PHYs
Message-ID: <20251015170134.GA4058510-robh@kernel.org>
References: <20251013202944.14575-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013202944.14575-1-zajec5@gmail.com>

On Mon, Oct 13, 2025 at 10:29:43PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Some network devices (e.g. access points) come with BCM54210E PHY that
> requires being set into master mode to work properly.
> 
> Add binding for BCM54210E as found in Luxul AP devices (600d:84a6) and
> the "brcm,master-mode" property.

Can't this mode be implied from the compatible string (or id registers)?

> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/net/brcm,bcm54xx.yaml | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm54xx.yaml

