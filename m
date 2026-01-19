Return-Path: <netdev+bounces-251295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93239D3B853
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 277233008F36
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764F2EB5AF;
	Mon, 19 Jan 2026 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j4Wpo5m6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1427E05F;
	Mon, 19 Jan 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854564; cv=none; b=BSivv1yTNQG3GQJzI46q4+HUeqbEyeJ1pbgp1kwxQNnhDDR7tChRlai8yA5VNcJXbiAH65C3Uga1+2hD0ex9hJPOaqLX4XigapWEwFQ2gsD21ZE0OdYtpxe3LBD8rnCqgK9bFWf3E552NJOCN4pxEhPyo+VZRo9B6r1UkVOZqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854564; c=relaxed/simple;
	bh=DM7npjMEdkqhiIaEgymR3MXjPogOvz7xd2opGt0BeEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgybyhL7fui1ZUrKVtAJLkIXu39s9WDU5FpbKSo7Vq5MpERGl4J/bm3PQBJJP23b9fztTavElZLIhNv2JY7IB53pTAGZTZ13OPsmf0u29Yzu3/ZD4JkgshRTG7w5HLmW+4vVh4WKHxm3q8Zbaf5ZrHEFFS+PaeGkLUvLtJJG+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j4Wpo5m6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KdLUv90Yj4SfljUabA6T05v2y+dukg4xbcWK9twXbTg=; b=j4Wpo5m6oYwy3U25GY6effkpZg
	hcJkTTUQgzzpOZW77TqWL9IWtDh+QeDTlI/leYR0PeBrq4pK3VliXVLgM3HrK9JkN8/nBDr+DQcB+
	YnxSzAnQ8aiIJOaGBcI2hTpke0n5RkhlT82uN5VO2sjlNtdinlF+Zr11U59Q9ZCPb4+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhvsC-003Yxl-DS; Mon, 19 Jan 2026 21:29:16 +0100
Date: Mon, 19 Jan 2026 21:29:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <2b716edf-23c6-427d-beb5-16127b8bf429@lunn.ch>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
 <20260119-airoha-npu-firmware-name-v3-2-cba88eed96cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-airoha-npu-firmware-name-v3-2-cba88eed96cc@kernel.org>

On Mon, Jan 19, 2026 at 04:32:41PM +0100, Lorenzo Bianconi wrote:
> Introduce the capability to read the firmware binary names from device-tree
> using the firmware-name property if available.
> This patch is needed because NPU firmware binaries are board specific since
> they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
> MT7992) and the WiFi chip version info is not available in the NPU driver.
> This is a preliminary patch to enable MT76 NPU offloading if the Airoha SoC
> is equipped with MT7996 (Eagle) WiFi chipset.

I _think_ you need to add the firmware file names to the end of the
file using MODULE_FIRMWARE(). That gives dracul, or whatever is
building in initramfs, the information it needs to include them.

	 Andrew

