Return-Path: <netdev+bounces-105304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC891064A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24C61F20DD4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4131AD3F5;
	Thu, 20 Jun 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmnrO+w9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939E1A4F12;
	Thu, 20 Jun 2024 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890535; cv=none; b=aZQoBYZsngEfmuaEla49O6ThInikrsvghcwGkyLdG3DtEvzmD3rp0DTHs8t0EtwvN3vYObicZ6kqgu807rkd6JvDPxnu039lmUd7EzSi/p0gzEzHjZN7dZ5SD2GLHlfowzyQN81GXAoNEOFr4+7+GIciUeR5PiUU+2xelMSJGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890535; c=relaxed/simple;
	bh=pXD+1wumnzzaj/twp2ToskCRO7a6a4cPyX6yENfOZgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj+pMpkLzoHGcONnSqMZGbSl+luVMIeHTGQ4qJ6DIlRrIiaa+Izz9h8X4uao6iGcbt+xH3SPcb2JHnl8m0+yCgHhtrQSl8ubJLNnfAZadWjLH810MKXv+7ttN9vckIPW7Htgsli1mIWvnlWPNNs61IMrOkC5+RI5xfBEt05kULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmnrO+w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD162C2BD10;
	Thu, 20 Jun 2024 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718890534;
	bh=pXD+1wumnzzaj/twp2ToskCRO7a6a4cPyX6yENfOZgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OmnrO+w9cmEXEGqCBkrRm3XbMtkuJJ2W8DQbxGpMBG5FvFXZj/Kfzs0wzPHZlYpgG
	 2GrWP5FRxJARDHEIf62OjYf/IWJJOEZ3QRPYmvdm2KpBlE74BoPRvGQl6sgb2GdYyu
	 uIP52JAkex5J9KnkphaREuAB36DJOnvpiVXXE1OZjMziVbl3a5RMPFwRBlRvxHF3vJ
	 6WCOq8CWPJkOkeGYbAFoV6vAKHARWrO8cOqMjLW3ZXZu73SigQtXBIuhhucQENVdzT
	 gBSoj9cp8KSaIKDeZp/sOTQ3xfIDv/Rhlm5WBGbZ+KjTSbWB/d7wX2FelPeg4T37uY
	 2azmqrMJfAsvQ==
Date: Thu, 20 Jun 2024 06:35:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Kamil =?UTF-8?B?SG9yw6Fr?= - 2N
 <kamilh@axis.com>, Conor Dooley <conor@kernel.org>,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <20240620063532.653227a1@kernel.org>
In-Reply-To: <9f8628dd-e11c-4c91-ad46-c1e01f17be1e@lunn.ch>
References: <20240619150359.311459-1-kamilh@axis.com>
	<20240619150359.311459-4-kamilh@axis.com>
	<20240619-plow-audacity-8ee9d98a005e@spud>
	<20240619163803.6ba73ec5@kernel.org>
	<20240620-eskimo-banana-7b90cddfd9c3@wendy>
	<9f8628dd-e11c-4c91-ad46-c1e01f17be1e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 14:59:53 +0200 Andrew Lunn wrote:
> > BTW Jakub, am I able to interact with the pw-bot, or is that limited to
> > maintainers/senior netdev reviewers? Been curious about that for a
> > while..  
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

One thing that may not be immediately obvious is that this is our local
netdev thing, so it will only work on netdev@ and bpf@.
We could try to convince Konstantin to run it for all pw instances, we
never tried.

