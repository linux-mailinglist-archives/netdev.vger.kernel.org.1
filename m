Return-Path: <netdev+bounces-237420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A23C4B35D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB113B5F5A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD34347FF8;
	Tue, 11 Nov 2025 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs5pmNMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF7347FEE;
	Tue, 11 Nov 2025 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828034; cv=none; b=VsOsvSxNOiSbG9JX5VbRr+to1JpmrcYSKpDEZcTgUw/oZllf/l+XQUdNW22cm2QPTFJAMhgZtnsIUuGC4ZQkZwyU7NH7QQ0hTp36S+N7DaAdJsSjXM58yKNSyTOhfEKbhGUbNiIsy7aHrw3Z7pHy08+iBdhBXLzDM8mXSnidn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828034; c=relaxed/simple;
	bh=EXEPUIrCk23PzLW6+OrAcmyL7ffWgKY5kAQbaMJeAf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nig+K9GrFmCdvG0bd9t5iuPS9Y+PnSe7EHJrd81zabrkiZ1ATvQEsQ8FPKgCc0BYIILktrmfjrxTYixylxjcxPB5tnUyTyuKNdM2WbVTVBR2HxT6ksOiradAjJPhWG8nZWOpXA8b6V0NItaxZi7obXM2Sf+lhSfQHU3u/Yt94Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs5pmNMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0637C4CEFB;
	Tue, 11 Nov 2025 02:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828034;
	bh=EXEPUIrCk23PzLW6+OrAcmyL7ffWgKY5kAQbaMJeAf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rs5pmNMkPq7/dtA/2HnBx0/Md/GwkbU7r2mCYg8MhfBLR8KJw9BUNS1KKPe/SloNZ
	 4iaBSrrO1W9oCbj7bLOvQXVsh5/SIWCFq4lyjvJ7FNEyHZadhmwFmXVpT3HaN7+ZJd
	 WRjhPEe0x1J8pJhWuhbigU4L/RHAdglJNMHlessgaMeORynGM91/ObOsNeX1YCN/MN
	 4wWjHWKvvOdgZNKcx5KSWnjQlTdn4PUvBSkSkuOVBdNjSU8JQrP0Bt2HQyCd3dwwQi
	 ykyGUx58b8rlZIXP9CGDPYJ989O+1lox39VUFd9hyAzu0Jnh8PbUdq8B/KoIjaU38G
	 2j8zT0iyxVaSw==
Date: Mon, 10 Nov 2025 18:27:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Arun
 Ramadoss <arun.ramadoss@microchip.com>, Pascal Eberhard
 <pascal.eberhard@se.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Message-ID: <20251110182713.221a058d@kernel.org>
In-Reply-To: <20251106-ksz-fix-v2-1-07188f608873@bootlin.com>
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
	<20251106-ksz-fix-v2-1-07188f608873@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Nov 2025 13:53:08 +0100 Bastien Curutchet (Schneider
Electric) wrote:
> Fixes: ff319a644829 ("net: dsa: microchip: move interrupt handling logic from lan937x to ksz_common")

This commit just moves the buggy code around, the fixes tag should
point at the commit which introduced the buggy code (first commit
in which the bug could be reproduced). I think other commits suffer
from a similar issue. Please look a little deeper into the history.
-- 
pw-bot:  cr

