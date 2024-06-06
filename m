Return-Path: <netdev+bounces-101483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4258FF0A4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D201C249A8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3D196457;
	Thu,  6 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9YYwlQq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99C195FE0;
	Thu,  6 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687604; cv=none; b=fkgpCM8S8D6ODVSfyXLzV8E8sbncTTteKTfsKdYnJUcT7GC11WcGtN1jrrvuQSeQBulRm0oLyGeBRWfhN5BPmF5fTA6fjZhQ7wZc1mIx8FKGw77deBtk0xMUy9MRVqUAQx6JmNGutao5Pa63rnC8PjhyzNtYI8St+S6C0e/hlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687604; c=relaxed/simple;
	bh=g9DU+5xnLtEMAIzCRN/FCtyy6ez/NLtJEwNFQWO4WeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZ/68UjvnzQ7AowcjSNp2H19tV3qXBXzNreVjJbx7qpvtAZyHKrQIGRIfHmRT8OSdV4Mkbu8cxWZmmkIKwlE04GzpxXzn6xrt6a3gy0Su5WIItXF2pAwSKSQFHjCA/VeVgBoRT9ADFU+g5VN4MYusCLnbIJ+RglSW8q9nifqewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9YYwlQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876D4C32781;
	Thu,  6 Jun 2024 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717687604;
	bh=g9DU+5xnLtEMAIzCRN/FCtyy6ez/NLtJEwNFQWO4WeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9YYwlQqi8SfeLRIhucMQqvCL6MADLMFzkhp4D8C64U83lkJpHMBY37hgmjOP8g2u
	 PbB1bOkRo7ATQhklm+X/pB4T1W5TrkY+UO/qEFmXSBLN0Zo4jqd0mC2sC0/JVpGOO0
	 /3PNRJ8Id42EncZ/nkr9/Ue9MLgd1Yx558CAvMQRrGSkv+GVhfIJGC82tdJjOfVDBw
	 TpxpgHNYaEB/Y2szEPhbaNeEgUOIKoDMVjg+Jcc7V8PhWKisjFiTvdqQY7Y1fqR1XR
	 A/ljObxNcUa6mEUqJ0AikEPWNu7IipRamnOIiM0qMzOlHowrF1r4emJGKJZKcuHfJY
	 tM9V/P3wHarxw==
Date: Thu, 6 Jun 2024 08:26:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5] net: ethernet: mtk_eth_soc: ppe: add
 support for multiple PPEs
Message-ID: <20240606082642.397c0dc0@kernel.org>
In-Reply-To: <CA+SN3soxVEUUWZHMFX7OeMj56wEw7p9Q=eXXNJwiYz6Bh=pb7Q@mail.gmail.com>
References: <20240602173247.12651-1-eladwf@gmail.com>
	<20240605194305.194286d8@kernel.org>
	<CA+SN3soxVEUUWZHMFX7OeMj56wEw7p9Q=eXXNJwiYz6Bh=pb7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 08:56:49 +0300 Elad Yifee wrote:
> > I thought Daniel's suggestion was to remove this field.
> > I don't see your rebuke to that point or how it's addressed in the code.
> > Also it would be good if you CCed Daniel, always CC people who gave you
> > feedback.  
> I talked to Daniel in private, I should have done that publicly.
> Relying solely on ifindex%ppe_num could potentially lead to more than
> one GMAC assigned to the same PPE.
> Since the ingress device could be a non mtk type, I added that sanity check.
> I think the additional field is a small price to keep things clear and simple.

Got it, could you include the justification for sticking to the current
method in the commit message, maybe?

