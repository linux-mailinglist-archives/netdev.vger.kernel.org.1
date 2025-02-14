Return-Path: <netdev+bounces-166567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C2A36777
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283557A2416
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA001DDA33;
	Fri, 14 Feb 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORTHHNG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E41DB127
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568297; cv=none; b=snkpYuLGZMZnx63MuMOiAt8Or7dW9rNamwfBlDNJgiiY38dcY3cUHTLjzOpL+6zlizfVS31m5BdxzQwRn8i98j6I0E6LIHud9GXtDrK5SEc77g+LNfX2xoHffOjb1hA4N0ylft1TKNzL2+sROUsxeXVh2neY2y/9WMyod/QfBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568297; c=relaxed/simple;
	bh=qs82Wq7l496cGn6clZ/br9XhR7P1uqTG5/oeZMsA9/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9IsNWrflz7f2AKtszx1JWNsuMlHrU1RyuueVIej5E5M39MZbL0m2U9X8kp/x94poHuc4SYc4k4vpoIVPg+2aQQ8oZmvx1myQYBB8yTsr670ExRi1KfG0K6gE6YpFKxUSm58MsOP6ecdsENB6QEK33dR4/TjS6tO6mj+Axjq8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORTHHNG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BE6C4CED1;
	Fri, 14 Feb 2025 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568297;
	bh=qs82Wq7l496cGn6clZ/br9XhR7P1uqTG5/oeZMsA9/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORTHHNG7sPCR891mGOuMt9FBQKBlH2TjNWnAOMZO8qBFqDwvHkUH19d76nmhCcQhc
	 +NSSAy99jsuQ9iFajiLHWIm4NFs3DavV5YaLUhZzCaWdxRbLTc5Yg4ZKAK5ZMEB5rK
	 73BE+12HFTCkCHbm+M9s5U6uridiC9vG/0/jy2eZtUBjra82CO0n8TIGpxyfyv59Hf
	 8xw+NMs3+UWSMP1EaunTkYIyPSXtlC4MzA9exLKg1NiBC3AQQR/dhVtT1ETQsbcvkq
	 OdNTTdmEiBC23lRtoHEiiyhpFsKne75kXDaXUhXsC5syUjKTkTFe28WJvlRexMeiuq
	 kO4VFRL28Triw==
Date: Fri, 14 Feb 2025 13:24:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Message-ID: <20250214132456.5209d8b5@kernel.org>
In-Reply-To: <ec28ce6c-24fc-42f5-be68-4968bc78196b@birger-koblitz.de>
References: <ec28ce6c-24fc-42f5-be68-4968bc78196b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 16:13:44 +0100 Birger Koblitz wrote:
> The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
> 2500Base-X. However, in their EEPROM they incorrectly specify:
> Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
> BR, Nominal         : 2500MBd
> 
> Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
> Run-tested on BananaPi R3.

Still white space damaged :(
Could you try sending with git send-email or b4 ?
-- 
pw-bot: cr

