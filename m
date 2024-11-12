Return-Path: <netdev+bounces-144090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B902A9C58CE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9BE281511
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727C7080D;
	Tue, 12 Nov 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gN3A9uMR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71663B1A1;
	Tue, 12 Nov 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417587; cv=none; b=Gqj/UzrukHByNXD76PuKYUyfd5iqeLNTTtBEgkA7z3NKv8xr6M3a1adTlMBTdsVJQCwFHA/Q/4UMW9BeFK0r7b8xYULq7d7bjjUPS+Wo3m4c61jlvPdFuZjZPsVvYFkXEinfk2mUeHv4DGe5lhcagKfZS9lWxQk870/6QuvgLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417587; c=relaxed/simple;
	bh=8/SAMxxG5FgHC5INwSofebZmqGzBhOHbZ+E+uGNjocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV/MmMxElM5o+okqsOB5QyaFWaVktUUfGMHRC2GQCvNmOA73y/3DBpG281fO9Z9snCSHFhe75LDMLp7faGwhNNyt/MfphBBzMqY1czx2oM4QTHGD6U3EQxK4+r7UIBGWtRTBAO2fWKGMJG864FsR+0rMbLnNstVPK1zq17ysLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gN3A9uMR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=soeUJsHotqJA7podSvcsboGSvyN6vI5yBusRzjZPZXo=; b=gN3A9uMRFN0/eV/8SkCOaI9j25
	pNwOgn+TMD+GtRw4K9zL64dc4ROj3yhxFTJlkwbUUrwkWGbDTYseoI2OTobzVL15bLUgDjaDdsNE/
	HUNgrKTyPUyjGK6P2HP2/ppk0uUER+QoVgZ8uAKoUBU+R62YwTMV0jx3Hc620VW7fVT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAqnz-00D1sh-Ko; Tue, 12 Nov 2024 14:19:39 +0100
Date: Tue, 12 Nov 2024 14:19:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dlink: add support for reporting stats
 via `ethtool -S`
Message-ID: <7f998ce9-4cfe-40f4-a9af-3e86c7c948df@lunn.ch>
References: <20241112100328.134730-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112100328.134730-1-yyyynoom@gmail.com>

On Tue, Nov 12, 2024 at 07:03:28PM +0900, Moon Yeounsu wrote:
> This patch consolidates previously unused statistics and
> adds support reporting them through `ethtool -S`.

Author requested change request.

    Andrew

---
pw-bot: cr

