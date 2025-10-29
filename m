Return-Path: <netdev+bounces-234179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A742C1D9E4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27A063454B4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD122DF148;
	Wed, 29 Oct 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWxyrc1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54538239573;
	Wed, 29 Oct 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778244; cv=none; b=qJX+5ai5wgIEIq6rC29J5GLJUqeU2J3jxA8aYX5XIIp2J2fcocAW0ROBsYK8rxNU0E+jK0sv4ujjbv8/90dbygHSzug+eL08Dh90jovKAvjKnrzNh7ITz7v1p6Qu3feXt87BtQC+TMly/2WUVtmq7O8Mh/pjY1KgKci/dlaKFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778244; c=relaxed/simple;
	bh=mTQHrDxKx7IV8KOA3AyIUBpcpmWdEWskPrlRI2H7uIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeA+JKHCSWCSysS+5WX+MwVKYxkTND8MmytMgCyASQsj0VikHon1/5ALk8VdE8EDCX+ngrbE8VQYuupv+P+4qxFq2wRwIL2iB78fwkZRERK8fQmOT4UO3WW4y32VIFzVhlf5TFYUrt6Mhx32KFA0fz0a59R7rVARgJSCd8abFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWxyrc1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6B3C4CEF7;
	Wed, 29 Oct 2025 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761778243;
	bh=mTQHrDxKx7IV8KOA3AyIUBpcpmWdEWskPrlRI2H7uIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BWxyrc1rNIVq3ghKKjMEPb+CHpbOQR4VH/HpURcGL3WkMqxVbgR5EA97L8sMLsTIo
	 fUcumSh7i0QaKI057eCuOl6khpjKC1dPpmPPaWiBvHP9fJFVl9TbFCcCsgJMYZ2jzb
	 70Eo7KdNpH+h5MNmGi6RnzTy+U/khF4kKQGf6J/wU847J1HdF5vZBwioqyRRRJYfM5
	 BfigAmwxQ4Y5Ox8N+vasb29xMlsf7fpNqgTNL5uTOBY4WUfY7x/IfsJPcXP8Kl0MHH
	 75dDEw9a0k5u0lPqlFK/y9E1bU05HR1EHGI6iadBlyqv9vHI3U5DL9KiQ5I4fAOorB
	 DsCiy3Qkc042Q==
Date: Wed, 29 Oct 2025 15:50:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Add a devlink attribute to
 control timestamping mode
Message-ID: <20251029155042.208ecff4@kernel.org>
In-Reply-To: <71310577-7cea-42ce-8442-49e09e0b958a@bootlin.com>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
	<20251024070720.71174-3-maxime.chevallier@bootlin.com>
	<20251028151925.12784dca@kernel.org>
	<71310577-7cea-42ce-8442-49e09e0b958a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 07:59:10 +0100 Maxime Chevallier wrote:
> The patch was applied, should we revert or add another patch to rename
> that parameter ?

I think an incremental patch is best here. You're using the register
naming in the driver code so I suppose you won't even have to make many
changes there.

