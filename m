Return-Path: <netdev+bounces-140030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BF9B512F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E691F2198E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E290197A77;
	Tue, 29 Oct 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH+OUyb0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEBBE49;
	Tue, 29 Oct 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223796; cv=none; b=juZwktExjA0QjS6LV6Zrs6DD/kVGwggGQs7vxRnRt564DxAhGjwJeQt9H2F85EMv46QlEgsL+RWHh/Rr3908vQRtQanFlFBbf/UgparmZhZQgfNKtJdpuwml+Zk0ikv0otBC0IJ3u9/Hq/n8CujCGCW+dNZK9tYdbKZUQPy1dIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223796; c=relaxed/simple;
	bh=MEWueq953fw1zDzFBUMOVC49e5stRv6Mz3wEG9Gq52s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMk9guupqZp3n3o/QoXzQ4gfHq1o/5K7Yg+fzQ0KXczqrz+t+CMuIakHJs2R5qAgC7meqMAqDh4ObdbcQPN0p73A1Ep7FnwDDOVOrkgFwLZRtVuNzK70NdF87hgmtS06KbCvmSNFvz/7ddVbFP1oaxy4iSLDW44pe/CPF44O+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH+OUyb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37CBC4CEE4;
	Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730223795;
	bh=MEWueq953fw1zDzFBUMOVC49e5stRv6Mz3wEG9Gq52s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CH+OUyb0qnKd1xh+UBSd4baG2vqOazVdpicyFokB5/yyErlFGs6Lwge2RBX5etLoU
	 B6muPEsILjUGd0Oo8VSt4u5PwFHwJEb+TNxBf8MkGMLEz7ILEok5r1pJfpe5TWrYAg
	 eU0wiOXceV2wk397T6ESTzTYpoii4RsuvDD/DbbXLKGbM7M2wLJF9f/w9edCtyTNr3
	 FHczFW7Awlqiuom9dW0WvCSUxkNV8huc83m+gDNN8HbUnRhYiumhQmp7WPoih/6c1c
	 q7y4NL/trInpkc657uCJdcSIAXhv5UjwlY+oowWvkZ002XBSk0ZKFp2rLcul0ZMUvp
	 Jwp13FYEM0aIA==
Date: Tue, 29 Oct 2024 10:43:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ronnie.Kunin@microchip.com, Fabi.Benschuh@fau.de,
 Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Add LAN78XX OTP_ACCESS flag support
Message-ID: <20241029104313.6d15fd08@kernel.org>
In-Reply-To: <a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
References: <20241025230550.25536-1-Fabi.Benschuh@fau.de>
	<c4503364-78c7-4bd5-9a77-0d98ae1786bf@lunn.ch>
	<PH8PR11MB796575D608575FAA5233DBD4954A2@PH8PR11MB7965.namprd11.prod.outlook.com>
	<a0d6ef0c-5615-40fd-964d-11844389dc29@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 20:19:04 +0100 Andrew Lunn wrote:
> > This is pretty much the same implementation that is already in place
> > for the Linux driver of the LAN743x PCIe device.  
> 
> That is good, it gives some degree of consistency. But i wounder if we
> should go further. I doubt these are the only two devices which
> support both EEPROM and OTP. It would be nicer to extend ethtool:
> 
>        ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N] [otp] [eeprom]

After a cursory look at the conversation I wonder if it wouldn't 
be easier to register devlink regions for eeprom and otp?

