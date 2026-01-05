Return-Path: <netdev+bounces-247077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC662CF42BD
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F1C3082E93
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B833B969;
	Mon,  5 Jan 2026 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CXWd5ZYo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FD33A9F1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623005; cv=none; b=XaNQ79WzHU1ZgqyH49SdnAVjMdhJZaKtCl0YiCsG31bjCLVDxu29xxWyHG3g3iwmyDARwNhfZNwaaaFoKzMaBZl8T6Pb1fPTk/7Th/spb8hLITsPB2SSimZ7vzydbJEjhh6lxXcxb1Y4m+wbJ1YhQ3QhacouIUnLDHpZf464pnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623005; c=relaxed/simple;
	bh=veyBrntj38HNVD7QVHZB1AjbYtIfFLk03jpBchEn6sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu+JbfAyFdKellIlSHyulJhqqsVInP4k+bnZPiSrpPG5l/qnguJf2SBbZRxgS2QYCJJCOi1oIZ3CNchC/EL6SmnneVIzMQaU6dKVdA0wgfFb+9ae/E8qGOk11Wv8Kfr07+KU+ZeHxSCu3inCNf1OalypB07of9DfBRX9bva1OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CXWd5ZYo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HgYNBTvWy9ETfc5fR2TBZ4q3OtTvqTlIUr8bryzNcgo=; b=CXWd5ZYoESGmzTUhOfCPoRFr9f
	nUdD+6xYeQtzUqDRt51Crf0kBPR/Rz8mtduq07p+epW/jGqxtGFM+8rWADrVsE7ILqP+KAHNvFzGx
	+aMG3ezx4R5E1knKiRK1PkWWXGdZh2lYny0Ph2NM6JidXgM49Oen2aP1Zc/uhVp2J+fU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vclUG-001Uj2-Fu; Mon, 05 Jan 2026 15:23:12 +0100
Date: Mon, 5 Jan 2026 15:23:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5] net: dsa: realtek: rtl8365mb: remove ifOutDiscards
 from rx_packets
Message-ID: <aa8f4142-3747-49bc-a54e-5e71b02d8c08@lunn.ch>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
 <20260104073101.2b3a0baa@kernel.org>
 <1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
 <20260104090132.5b1e676e@kernel.org>
 <09c19b60-a795-4640-90b8-656b3bb3c161@yahoo.com>
 <20260104095242.3b82b332@kernel.org>
 <03bd5bdb-0885-4871-a307-8a926b1bd484@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bd5bdb-0885-4871-a307-8a926b1bd484@yahoo.com>

On Mon, Jan 05, 2026 at 09:35:23AM +0100, Mieczyslaw Nalewaj wrote:
> The fix doesn't add any new lines, it just removes the erroneous one.

Please don't top post.

If you did not top post, and actually looked at the context Jakub
included:

> > Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> >
> > Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
>
> - no empty lines between tags
> - don't send patches in reply to existing threads
> - don't send new versions less than 24h after previous version

You will see an empty line. This is one of the reasons we say not to
top post. The context is important, it gives you.... context.

    Andrew

