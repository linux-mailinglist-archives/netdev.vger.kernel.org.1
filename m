Return-Path: <netdev+bounces-168654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0AA40044
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741E41630D1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCC1FF602;
	Fri, 21 Feb 2025 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzvWwm1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49786342;
	Fri, 21 Feb 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168095; cv=none; b=pITqGnlLA6mdylV+Hqd4RcSAqM/HT2lnMj5zaTJLkbvpSeBVAqgkiBUL8QTOuaeQaBaJZtzR7yttv/2G+Cb0o1Mxvek8bOC9F9laB8kd3d4NZ3hfIc7dhXjVaOrhBGzWjosZ9YfOsDVVS8xORh1TfSPIfafq6T7CIQ7//n0vJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168095; c=relaxed/simple;
	bh=cf5LqsnpN6VFTpwOXNTW1APfLfH4q6dmpNXL477VNDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kRIr9bLpbDk1DjYpyqxd86E0H/l5JQo3wIo2yGOzTbJh9rtS1Z60niV8aGC/2drmh6tV2VkvK7/sTteBDhuKIIFC4YxQRamNvFBcJBjO4y9J/Z7PeCim+O4h3fQAkUsBRFSfTcqJ5bDezuOc19rg9ObAgGlUFc1PuMdAJiDxl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzvWwm1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C435C4CED6;
	Fri, 21 Feb 2025 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740168094;
	bh=cf5LqsnpN6VFTpwOXNTW1APfLfH4q6dmpNXL477VNDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VzvWwm1K1/ko0FQDAmCea8tXIr71Dw1XUzYA8Vzs7RvTSzgvDA9f59I5/onwkoKrD
	 sOZZz2JbdZaOYeGM9qOBTY7fgf23zm/6I+iuQPxO420j1lgZe95cJlWZ3yibqP4BSu
	 Kf9POy0m2/2HCiRjMoDdc+YwpUQKWtfrzxD0/KjYuFKgxo2XBNHP2A/kX1YB1uzVSB
	 HhTl48rzQyX1pICHf6qrcT28zdMq2ZhnkCyLwq1XsRj3YQQEz4OhM9b745+mDmuCY3
	 HBphwu0EsgnUQsKIuQEvNlGAMVF+KzMCkug0rUx0uYxxvTySdZhU6mJWp4cvq81xHk
	 RLqBPLfv3z0Og==
Date: Fri, 21 Feb 2025 14:01:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
Message-ID: <20250221200132.GA357821@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221071828.12323-442-nic_swsd@realtek.com>

On Fri, Feb 21, 2025 at 03:18:28PM +0800, ChunHao Lin wrote:
> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
> device will exit L1 substate every 100ms. Disable it for saving more power
> in L1 substate.

s/dose/does/

Is ZRX-DC a PCIe spec?  A Google search suggests that it might not be
completely Realtek-specific?

> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	u8 val;
> +
> +	if (pdev->cfg_size > 0x0890 &&
> +	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
> +	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)

Is this a standard PCIe extended capability?  If so, it would be nice
to search for it with pci_find_ext_capability() and use standard
#defines.

Bjorn

