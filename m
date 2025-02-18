Return-Path: <netdev+bounces-167139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD66A39015
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482533B2DC7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB4182BD;
	Tue, 18 Feb 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/z1+Mtw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D1FC8
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739840409; cv=none; b=Vu3D0NWKJmc5jkC1qBPr2Alf6SRXf/hHfqy3W/nei3DBbB5SqJFjpZKovnlO7XelbT+KtuHmC6ODLNBQG9v6FQS7N9a2dNNUXafWlOh7wPDO8aN9DkoZMbjhn0g618I0xV1ZlxgcwZy9YLbwFBAuLO7fjSbDoIQ5R2CmlRZLr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739840409; c=relaxed/simple;
	bh=3qhUEoGS5t2QpJiBlNQB2GUjVFY+33g+tgBbzW2LEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf7Y5B3R1zwHZSmzzj0DgzQ92eHLFMhq9PJ/dnGzLJcXx63Ixm2ZEh0KN/vvennhXurhp3BmWOpd9NE1qSzKHZLopx10+UHa7gsYzSm+HjA/VlL2NApcTABsjD/rLGkQA44PPgsyfeZa2jqtKiKW4f2meForOgYOl3u1wbNwsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/z1+Mtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F398C4CED1;
	Tue, 18 Feb 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739840408;
	bh=3qhUEoGS5t2QpJiBlNQB2GUjVFY+33g+tgBbzW2LEdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/z1+MtwKk5PEUwcWPjHcqCpfXNf2yGtq2O3GSmcINhL6p0imJXWtw2HMUKpRP1SI
	 RQ57IAnR9qg3pp0Ngf8rYgqMqJeCmgB5JaaJ0LutnsA6AQOMtIDN/foANt2u2+wJuC
	 e7tS/quxELfFdHnBwRvnp64BHMoqwwWG3z9ktAIspeqqA4vV0Bf6AWbTDk8RWb2dTk
	 AnM+HZwzLEHz6UokPZSD4JlZHU9OF96nsDJwD2iUQyGHb1EYEcBIq/oAJJovH2AuAa
	 Md+KOrwNsBQUW631+r/VM37yK+08vROlot+Eg2K4TZHhsMoZ4bt/1XrVjyzfeb0WPH
	 5nc71aeF3sxtg==
Date: Mon, 17 Feb 2025 17:00:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Message-ID: <20250217170007.5ab408d1@kernel.org>
In-Reply-To: <20250215-lkmsub-v1-1-1ffd6ae97229@birger-koblitz.de>
References: <20250215-lkmsub-v1-1-1ffd6ae97229@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 07:29:44 +0100 Birger Koblitz wrote:
> The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
> 2500Base-X. However, in their EEPROM they incorrectly specify:
> Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
> BR, Nominal         : 2500MBd
> 
> Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
> Tested on BananaPi R3.

better, the patch looks correct now :)

our checkers flagged that the maintainers were not CCed:

 Missing CC:
   andrew@lunn.ch 
   linux@armlinux.org.uk 
   edumazet@google.com 
   hkallweit1@gmail.com 
   pabeni@redhat.com 

Could you repost one more time, and make sure these addresses are CCed
(per scripts/get_maintainer.pl) ?
-- 
pw-bot: cr

