Return-Path: <netdev+bounces-160153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D8A18890
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6011889422
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CC1F8AC9;
	Tue, 21 Jan 2025 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A6QEpfly"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4B1F1515;
	Tue, 21 Jan 2025 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737503455; cv=none; b=CDEogJ9fNOZMIaj+Ln9SzwUPKSjvvESFdwBtirekYrgQhAxUN5iYW+bvCzjhYlTXyR4NOxYCyKWH9qYIW90xCWcG1fg5BA/Vv1tk6ywxFNc4qq1PY8JP7ujpneLvUtk4RmH+6LUFugVzRBLU/Nj/tEnIUEXo3d5DkILzShsVrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737503455; c=relaxed/simple;
	bh=XhSAkCL5H02hPfBMMHqZZv0jWYikM0asV+g6+OZbxys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeHAqRVX9vdtCmb2H+7tkglwoVr5TJxYaD4rtsznrxXZkF9EfEx6mVJmNb/4eHQWTBMDePhgUpCgB5LnhMXVhvufYNTmr97h2vGD6ssiVQYujuH89qbZoVlhUsCNNFU6AGhnRiwdjepMKSKBfbnap8JHvE5gQr6S8XBZcR6r4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A6QEpfly; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AuYhx4ivzz0E1AuPp+VdpQD15ncC9/RM8+DNV9taH/M=; b=A6QEpfly++bM7NYGmP3SnrNw46
	tzmrW4bt3urzf1A4m8tC0jM+IPQbXwCo6UjGQnaXpgaSxnQwj7NTl3gMT250EkSz8azZGdC6FTKkH
	mAQZcJBLjsXeUD+EdhuPJGZtujaBkPOe/s9/hh4QEdd4cm5G6OWOqq+jSIct6tfDA4Qg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1taO0v-006mUm-5p; Wed, 22 Jan 2025 00:50:33 +0100
Date: Wed, 22 Jan 2025 00:50:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Joe Damato <jdamato@fastly.com>, sr@denx.de
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <6359f0e9-6f13-4b87-993a-313a378742d5@lunn.ch>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
 <TYCPR01MB8437EC132CBC033368FC40A998102@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB8437EC132CBC033368FC40A998102@TYCPR01MB8437.jpnprd01.prod.outlook.com>

On Mon, Jan 06, 2025 at 10:28:46PM +0800, Shengyu Qu wrote:
> Hello,
> 
> Sorry to bother, but what happened to this patch? Is it given up or
> something?

There appear to be open questions about it. Those questions need
answering. Also, the net-next is closed at the moment for the merge
window. So a new version will need to be submitted once net-next
reopens in two weeks time.


    Andrew

---
pw-bot: cr

