Return-Path: <netdev+bounces-243238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7FC9C0B8
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEA02348FA3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574093242B8;
	Tue,  2 Dec 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="NGsxeFqR"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895F3242B9
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691018; cv=none; b=iK2U7k6PbNfI3xAaCtOosIOg2bgcP8dTtdiGq64pg6LbmiXHlp/uiIh9y1o3hDzaqOKLs+aMRqeTmSMduWXffgm24PEgSpHh6iNNeDPPg/pDnaXE4BSAHnz9acL6YUCT4FyBDaOT5GDBfoh2FVz07Y4NBQyR22zQZKo2RTxdrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691018; c=relaxed/simple;
	bh=CTg0kSiI7eiHXgl3yB4RxRaUwWR7KYxXJIGI8kmBcus=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pbWnEAg9yQ32lgumXMh1TBpFVxPBRljAvpqbfm/dr7SjcLZ1ctPIowSn2E6ZX4u4rWMUsM0G5bG/6u72ZZ5k/+WN/Q7BSmR3l9ohfqx6Gu64LCgqoRL5Ik3qI0AIA3bAsPvoC2YV4SUgxtBIu/GCtRAbbHOp9zGQF0p36VYG23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=NGsxeFqR; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zjGGLXpllZILcS9+GWsomnOtXOrskgChf7iDkhoJJms=; b=NGsxeFqRma9BSMEB2bocT4LZ6n
	cNeQ3wD2p+wvkcJpwRjKSPKgAT5W7mhQyxMAT4lB+u7aOkztxxmE2fZLZFZTxfQ8826+GdMI4OAc+
	/i5dtXjW9zLMG/YqOwLQVf5yq8gl7yru7qIm/1zdFQPSVaXVsZPY1xOWROHPsMh8cW/AOBiZW/eT+
	R1NkukTsnOaGebPabu9IoMRzueWSb4LuYPr1FOPGWeAKQrPJNeRYF1wutnCWSpbZRM7nRYdekjxJb
	rJtSXRIzGRXN44YRX2oVaNguSCSFfDdKpj7hlDzOmW8xLOgm6UZwgzTqOpJRQr4fRjcaYniM6BEWT
	I3RlU5Aw==;
Date: Tue, 02 Dec 2025 16:56:54 +0100 (CET)
Message-Id: <20251202.165654.1809368281930091194.rene@exactco.de>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <2d6a68c7-cad7-4a0d-9c73-03d3c217bfce@lunn.ch>
References: <679e6016-64f7-4a50-8497-936db038467e@gmail.com>
	<89595AAE-8A92-4D8B-A40C-E5437B750B42@exactco.de>
	<2d6a68c7-cad7-4a0d-9c73-03d3c217bfce@lunn.ch>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 16:52:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> > Well, the argument is for wakeup to “just work”. There also
> > should be some consistency in Linux. Either all drivers should
> > enable it or disable it by default. That is why I have thrown in
> > the idea of a new kconfig options for downstream distros to
> > make a conscious global choice. E.g. we would ship it it
> > enabled.
> 
> You might need to separate out, what is Linux doing, and what is the
> bootloader doing before Linux takes over the machine.

By Grub2 boot loader is not enabling WoL.

> Linux drivers sometimes don't reset WoL back to nothing enabled. They
> just take over how the hardware was configured. So if the bootloader
> has enabled Magic packet, Linux might inherit that.
> 
> I _think_ Linux enabling Magic packet by default does not
> happen. Which is why it would be good if you give links to 5 to 10
> drivers, from the over 200 in the kernel, which do enable WoL by
> default.

I'm sure supporting WoL requires active code in each driver. The next
time I have free time I'll go compile a list with grep for you.

Best,

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

