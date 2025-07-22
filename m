Return-Path: <netdev+bounces-209021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8326B0E00A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694026C5127
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B61F153A;
	Tue, 22 Jul 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QNm8suxf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3018BC3B;
	Tue, 22 Jul 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196861; cv=none; b=n+gS/WNgA9HRponDvoZL113QOfaBgkDEm6me3q+C97XC6Z6/oKNEqUdbZN6UdjVjRjFxcpVSkh3Ov/aB/9FAxh7hEN2qyM7kZYNBeqXhdvhX7w5+q6/DDYvS6vHVm+vjOc4riWd03jZEq9KKM3MjR0SnKVdyjioVIuWAAowJaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196861; c=relaxed/simple;
	bh=8uletU6LYWGSmx9FfxVTzj17H4trkwN9NHFMg8QNDJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1ehbxJoaEJgjkrFZKTbAMaQZjzEfTaGDlAfMfuSKaDrvQGmlWaIaDlua71XyHAPwthdF77uYyT7Lf8sPY1pkPErLb7GxTn6gAX7UNZX4ZQzy4jfY8at5ZwS5HUXcKZqhNYbUl6CCSkUVQ74tDrOFBEPwnrJ8EMLq+TnogQIZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QNm8suxf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a30OY54RhDy+eNHYc9k7rXnMBY+w4uQVNrz6JaAp1a0=; b=QNm8suxfQFpbWhHPAsyHbJsjmq
	yhT0s89L/2DbN7K5tgZ1JWoD+ty4ueQJNNtu3vDe5ziK9TZmS6uI2mwWqpLVZt8zcNnfcvnQKOGCU
	sCW5uH7S3HrCU4fl6TJ8oerddadJpI09fC5LRpryeA9A8wFn/NdMuHxr7W8JTY9att7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueEaC-002Tpy-CJ; Tue, 22 Jul 2025 17:07:08 +0200
Date: Tue, 22 Jul 2025 17:07:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
Message-ID: <b51950c8-ce79-4b0b-af5c-bb788af33620@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <5bce6424-51f9-4cc1-9289-93a2c15aa0c1@ti.com>
 <49D59FF93211A147+20250722113541.GA126730@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D59FF93211A147+20250722113541.GA126730@nic-Precision-5820-Tower>

> A series patches can be accepted without achieving the basic tx/rx
> functions for a network card? If so, I can split this.

Think about the very minimum to make it useful. Maybe only support
PF. Throw out all VF support. You don't need statistics, ethtool,
devlink etc. They can all be added later.

	Andrew

