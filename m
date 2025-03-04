Return-Path: <netdev+bounces-171838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDFA4F039
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE2171AB3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91A266B77;
	Tue,  4 Mar 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X+ZDZ1jY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5972780EE;
	Tue,  4 Mar 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127064; cv=none; b=Qz+TaCZ6SB9tO8yIMepS1J0zEB44a047oPmk/aWtl9piFRiXx7MQksepAZX3IzVtIwfdxiBLG4USiJfE/j4eQ2xqChqldOXYxlqE7IuqShla50VVAowVyZdDUclXWM++abpBGUTHbp4gpuRCbBCNJnPpkZi8HJlWyQTgVo7+nNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127064; c=relaxed/simple;
	bh=7QvuPnWT0EW53TvuPMg7Nv80uhxx7F8g12MYgUeNZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbqX48aCJjeMHda/04FnrIVI7e5yEkcBGjdWGyYWcNU9WlM3NRGBxVOeiTYFXKvnVGG4jDqe3xKmLb+CXr/OFQE/Igpn7pSNvApk2/BSM6JLTWAg7WT3im4oirlXn982boy3PQkVUd2OsThg8GhspNH+5WzopsOUXY6+tQtLeao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X+ZDZ1jY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NQspby4G75DaS/LBNhOnxLMcEKKmp/qYjXqhxLpgpJc=; b=X+ZDZ1jYxcz5VBtDKzP8p0t8nn
	qrHqeqVx76GM2mwLBEeMYc/M3s47hIw8qlQaamEt68PbvmCnU+TTqvWHVrPLd7LNwyvKTA5Q1kD+y
	nvE8RJm7JyFXpAZmDheUn+8K8V6cusfhtGtoDXrHt6mw/VqpPdbWWragyPXDZYvh+V/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpagH-002Hg7-7E; Tue, 04 Mar 2025 23:24:05 +0100
Date: Tue, 4 Mar 2025 23:24:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option
 for false IRP events
Message-ID: <eb5b93b5-ca90-4287-b6b5-17825d79e6ea@lunn.ch>
References: <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
 <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>
 <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
 <24740a7d-cc50-44af-99e2-21cb838e17e5@app.fastmail.com>
 <316a020a-aa49-700e-3735-f5f810adaaed@intel.com>
 <a2bd6964-1ec0-4bd6-ad68-7210ac3fe38b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2bd6964-1ec0-4bd6-ad68-7210ac3fe38b@app.fastmail.com>

> > I suggest to try replacing the register read for a short delay or 
> > reading the PHY STATUS register instead.
> >
> 
> Ack - we'll try that, and collect some other debug registers in the process.
> Will update with findings - this may take a while :)

Please be careful with which register you choice. Because the link
status bit in BMSR is latching, you should not be reading it and
discarding the result.

Reading register 2 or 3 should be totally safe.

Another thing to keep in mind, you cannot unconditionally read a paged
register in this particular PHY, because the e1000e is used with a
number of different PHYs. That register does not exist in other PHYs,
and the action of selecting the page performs a register write, which
for some other PHY could be destructive. So i would suggest you keep
to registers defined in 802.3 C22.

	Andrew

