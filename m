Return-Path: <netdev+bounces-247850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E674CFF2D0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6175E300EDD6
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDC3502BE;
	Wed,  7 Jan 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Is4g6+8N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838A344026
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807888; cv=none; b=T3g4i2kIs4c8++G46QRDYSxj9rPcOnipnLv7+3rrf+KCr5jvyhev/OxDqe70qDGYJ2u/OuhQpTedRDUWVZpkKwLmtHgrXGdqk8BoxAyu6G/2St14LLAKQNY+//CZw+TE7yK9wcjK7wUuaCQj9auSsjTs2yladNLyrqbpt4r6jcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807888; c=relaxed/simple;
	bh=00mbrnvH2ExbEnCuy+wJWyUAVG1hBUwXZj+iMTp5RNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1P0Q7e3zOOMJaf8AqJ3AcRNns41ezeZFI3xlF9krNr7jVRAutWSUZvrasILOxRYMDtQMSAMJNvJ+vFSQp8vQgOYmtS+vNoOULKj+PeU4UUjDAdqUNT80vws5ojXeaF9Z823PQ1YSJ7aLY3osszs8n+Z6AJsLvjrolxhoJfFByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Is4g6+8N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fFnNhSVaySYikeApYkBhR9vweG6WA4VVlXBy8tMX2qY=; b=Is4g6+8NTLbgZOks0b8aR9vbUw
	sexIwZfSw1BXQypL2bBtssslfQZo97EtRziY1ZDENla/UFpkvmDOeUe07IaECB81nkILTX1k4PAzV
	ZK8N03xxkrmQmlNmawrADWaJSJEQAwRbBPCEPH/YTo3xDSOmMQEMMxj8QXMGacy4EXiA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdXaI-001pz7-35; Wed, 07 Jan 2026 18:44:38 +0100
Date: Wed, 7 Jan 2026 18:44:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] epic100: remove module version and switch to
 module_pci_driver
Message-ID: <5f20621f-3b91-4782-a4d1-4031cc7ecbf5@lunn.ch>
References: <20260107071015.29914-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107071015.29914-1-enelsonmoore@gmail.com>

On Tue, Jan 06, 2026 at 11:10:13PM -0800, Ethan Nelson-Moore wrote:
> The module version is useless, and the only thing the epic_init routine
> did besides pci_register_driver was to print the version.

You also failed to run ./scripts/get_maintainers.py, so you have lots
of missing Cc:.

    Andrew

---
pw-bot: cr

