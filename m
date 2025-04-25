Return-Path: <netdev+bounces-185988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37237A9C9BA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A0188A1D0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC524C66A;
	Fri, 25 Apr 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kbnARoCl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D72522B6
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586014; cv=none; b=PDcwmJunE1TD425m87+UHyiS/OSyt5BAtC6cGwAOqGyAjG+QzFsANCUDTVzVr9+DMUA+8EvP7VvJIadkjuDuiPDp3QeZ1imnT/UQD/sK1yjrfyvKbsTrucbB0KZ3tO0Y2Q0zPWDvGCTNrb7/ltEFjSlhyA/DRlNqdc+nt8+nacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586014; c=relaxed/simple;
	bh=yRKSAoXhJJQSXxKtJsdKElXUEaN0nboNsicKabV92gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FElR8Wg5Jl1TT5BM2BrMfTuJkJ3ED8vIxV1yHFZR8KBm8DdXcnBDLlOndR4I4k/DovAUm079/NqO4LY+9v4RujJ8I3arqwwPnBqxIY2196Ithk4I/bFix89HCJIowY8GBOeOfgtqPgiODGrjUa+WpKqUTJk3Y3mQQv08MchR9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kbnARoCl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mmMyfgmspY1l+DqWItxoQsViAOQ5tNE7IRVIrm7QTAM=; b=kbnARoCl0CcJHkvUNCqcCCK1dH
	ZbrzfRtmIcSegbjdbRnRpH/S5GEoCZDvhcG6eAt7nmJ4AThPOpGHY+Bd0SnQOMIAYUKSPWdmh/Ms+
	adDOgW6qars+bNYGYlq3REZXyZe9D2K3dWsI7+dAxkw4Ok9/IbItQnZMgkFPyniRuxzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8If3-00AZri-5Y; Fri, 25 Apr 2025 15:00:09 +0200
Date: Fri, 25 Apr 2025 15:00:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: bnxt_en: Invalid data read from SFP EEPROM
Message-ID: <d3c730cf-e629-48c0-a12e-19e1c7ea392e@lunn.ch>
References: <ED8A7112-D31F-4C4F-94AB-0F0D0DD5DDE6@avride.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED8A7112-D31F-4C4F-94AB-0F0D0DD5DDE6@avride.ai>

> Is there someone who can help me to find out where is the issue? The
> only bug that I find in code is that
> bnxt_read_sfp_module_eeprom_info do not fill bank_number field of
> the struct hwrm_port_phy_i2c_read_input, but it is not relevant for
> my case.

It could also be the SFP, or the cage. SFPs are notoriously buggy. I2C
needs a pull up resistors on the bus. If the SFP is contributing to
that resistance, it could be the overall resistance is too great in
this setup. Or the driving current is too low.

I've not looked at this driver. It is possible to influence the clock?
If you can slow it down and that makes it work, it points at the
hardware combination. The clock should be ticking at 100KHz, so try
50, 25, 10...

	Andrew


