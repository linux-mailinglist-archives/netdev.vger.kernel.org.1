Return-Path: <netdev+bounces-245558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DFCD1BCE
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2B33058469
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7792FD69D;
	Fri, 19 Dec 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWSrEy8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A32D6E67;
	Fri, 19 Dec 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175856; cv=none; b=HNqC125jEhbQ+UiduOSqZgp3EkGz1z6eMSYsOeDX5im4PDDXoOFF3adnh1vIH9YDg6THi0Ot0QmJxQ4ekel9q4S+vOX80lS/hrsDVvUo20u88o+MX2CLBRgMgaStQnq3CRptnsGd0qW4HaLJTNb2FZ3VH9XJjqw5kC0hnMESBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175856; c=relaxed/simple;
	bh=tjw5omJgmncSGdDGAhBBAQ35dB1nl7kl9X0vKueltY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWqQ/CwdlmJ1CPDjdDSv5rKuQ/6/l8DPK231fvcUHtVO9z9h6g+x8KQIinBAjNpooEv7p0/bdb/Z64u8zncIEut9gWS6wmOWpzccB1aq7mIkqfTXI95KMaLuZwy/8Ic+41pB3uNLYxrkEjF4+19+svBxSjm5f/1/bZx1WSbfcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWSrEy8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0081AC116B1;
	Fri, 19 Dec 2025 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175856;
	bh=tjw5omJgmncSGdDGAhBBAQ35dB1nl7kl9X0vKueltY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWSrEy8PuCSL1pDxehzh2AuVS4vJlemyNgHpYFfOzHXb42Dj51LG1JIhskyqWRFHu
	 Ekd+WUko5IDeaphAFK1mGgDyD/oEV7sVPg9tckSpTZZj0ZR9h4Q+Sh1OWX5yoNGrIA
	 s6CwnmsDdWJ3zl9QMz++zLpoccHNWI9ZGPfs8pyvpL/t/4+e7yHonGvFXNV+nq51m/
	 RV9Z/D+51JS5e7yENJLCQNsR4gO+tPbVXQMVFyOPQa5if3fWtKdMnZGy/ou6CYao01
	 AGzaWXmLdF5XxrZ6P5mq+AvMxb85nGTkPwvZJjQ6EaIYK4trntMyyIb3oG+YrlgC2t
	 13CS7aSPtfbVg==
Date: Fri, 19 Dec 2025 14:24:14 -0600
From: Rob Herring <robh@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: brcm,amac: Allow "dma-coherent"
 property
Message-ID: <20251219202414.GA3873318-robh@kernel.org>
References: <20251215212709.3320889-1-robh@kernel.org>
 <982376c5-ad72-4923-9653-7f01c1e608a2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982376c5-ad72-4923-9653-7f01c1e608a2@redhat.com>

On Fri, Dec 19, 2025 at 10:14:36AM +0100, Paolo Abeni wrote:
> Hi Rob,
> 
> On 12/15/25 10:27 PM, Rob Herring (Arm) wrote:
> > The Broadcom AMAC controller is DMA coherent on some platforms, so allow
> > the dma-coherent property.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> I assume you are targeting net-next here? 

Well, yes. I remember to add "net-next" about 50% of the time. Sigh.

> If so, please be aware that
> net-next is currently closed due to the winter break up to Jan 2.
> Otherwise feel free to take it via the device tree.

Okay, I'll just take it.

Rob

