Return-Path: <netdev+bounces-161404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1F8A20FC8
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC0167169
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB141DE4CE;
	Tue, 28 Jan 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lUCUbRqo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC164315F
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086698; cv=none; b=NhhbieLPMvvUqlW9TbYO5VMj84IHfmDDBYLGcHVc7iRNALZ09py/74vP+pRt9uwVmOLlX0AiPwz/YogLOEsvaaYCpNfNaAk9KVI7NKKK9X1PdtWNaVxmicW3qIH7fEbY+10rcr2Xi0JdtH0Oai4hY7B7nLPqetL9kpkMXA1RSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086698; c=relaxed/simple;
	bh=VYOJ1609pEaBWzxHMrJRO9aw+cnAa7DIk4/qcrDQCgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJxnk4X1AopTo1YXZTq+755zIbWoCnZrzsdqsKfXdigHWEqyClrmRv6Q10ZPOngtndCF8K9zNXFV+tYnws2NSvTV5f31WzzVGkAcIDBTEJaaHwE9aPFPBtvhfBkQYhGpUsMceW3GaJdaN3Mw1g25q2V1UbRZam8ZGczzPLavjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lUCUbRqo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oQUQFBZH2rC9woqlkhGaGRCCoRFd+WALfrDwiw10izc=; b=lUCUbRqo7U/ecIAVOV/Pl83H4i
	rkW3pb9mGTxu8F5tTu7FoVp/3saxzmKHRvVVWPsnpNFcQIjiKJUKG/p/UKHc4oDCnlXeuf/XqxDCF
	DhF2+jhGF80TRybYU0V8ol5j0oZZUEetzmbV9U0xz7FHTxCzeDRIoVJV3mIbCmf2nqZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tcpkM-008uen-7q; Tue, 28 Jan 2025 18:51:34 +0100
Date: Tue, 28 Jan 2025 18:51:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>

On Tue, Jan 28, 2025 at 05:14:46PM +0100, Frieder Schrempf wrote:
> Hi,
> 
> I'm trying out HSR support on KSZ9477 with v6.12. My setup looks like this:
> 
> +-------------+         +-------------+
> |             |         |             |
> |   Node A    |         |   Node D    |
> |             |         |             |
> |             |         |             |
> | LAN1   LAN2 |         | LAN1   LAN2 |
> +--+-------+--+         +--+------+---+
>    |       |               |      |
>    |       +---------------+      |
>    |                              |
>    |       +---------------+      |
>    |       |               |      |
> +--+-------+--+         +--+------+---+
> | LAN1   LAN2 |         | LAN1   LAN2 |
> |             |         |             |
> |             |         |             |
> |   Node B    |         |   Node C    |
> |             |         |             |
> +-------------+         +-------------+
> 
> On each device the LAN1 and LAN2 are added as HSR slaves. Then I try to
> do ping tests between each of the HSR interfaces.
> 
> The result is that I can reach the neighboring nodes just fine, but I
> can't reach the remote node that needs packages to be forwarded through
> the other nodes. For example I can't ping from node A to C.
> 
> I've tried to disable HW offloading in the driver and then everything
> starts working.
> 
> Is this a problem with HW offloading in the KSZ driver, or am I missing
> something essential?

How are IP addresses configured? I assume you have a bridge, LAN1 and
LAN2 are members of the bridge, and the IP address is on the bridge
interface?

	Andrew

