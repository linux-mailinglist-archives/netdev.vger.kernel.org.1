Return-Path: <netdev+bounces-148618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F529E29D1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CF1613F7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752FD207A1D;
	Tue,  3 Dec 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3TZ/pbq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F7207A14
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247909; cv=none; b=ITh+qFRkfdBb3y0XVOJF+Q+786XhpU5YAXb1l1rNjUKURTRSMwcIY7MfxXPxg6i1+IWodwDyAlGdvBg3QoJPnySsUO4fZUp3IwvsKZR2/OMrzzwd2ApKoy1ArmJGPGraE0I8ggEa4bA0Cd+oIV4OLjFU6rsAWwBvP9CvOWUUtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247909; c=relaxed/simple;
	bh=PzwPQEket5lnIFOfRGvASagjpaO+CuzyPPv4IipKYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpFCzUEfvCtyeWSTbszkgOSCalv6NDkTQ2VFmGI5GJx2RGbgFbpm4zvVcFbgk7/jkO0ooG4EIK4h+uQH1keaBzAZu40FN+2oGzhCqWBY4XEaPCJU13lHnJjI1GKBbGLnU44mX63MeRi2ZbXdGuWZ5LuJPqrBaiAINsjf36C4AJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3TZ/pbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17120C4CECF;
	Tue,  3 Dec 2024 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733247908;
	bh=PzwPQEket5lnIFOfRGvASagjpaO+CuzyPPv4IipKYTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3TZ/pbqIPACScwxpJuxQYoCW0bxaBRgzoVF0wU2YISvQLJwKiC7A3UEVyCYILndI
	 u6ZKp8/ZYSO0D2IJzVPTemzLTwJRpwXTdLodXv2zw74E11gePQKq2LPF6GqmnwkdhN
	 mBu9m6g9a0PehoMywPejWQXDR/7n+x8uOoAy2RphNFRm68ERXBIbkyJ6vvyuEKTHCy
	 BaQGCMTd9PKLZIfYVCMhXVc3WrQj7gLBWrQEx/GaAlRHagUk+x4/luWFcI0sy8hhe1
	 tg7qsBqWMZw8Av2ANlq7is4oyDLMOAHcKrzFW0nH0LUWc0+AsNH8U+4rX3gBP1xQYZ
	 8nfqUEWgW3B/g==
Date: Tue, 3 Dec 2024 17:44:04 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove support for chip version 11
Message-ID: <20241203174404.GA2321@kernel.org>
References: <b689ab6d-20b5-4b64-bd7e-531a0a972ba3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b689ab6d-20b5-4b64-bd7e-531a0a972ba3@gmail.com>

On Mon, Dec 02, 2024 at 09:20:02PM +0100, Heiner Kallweit wrote:
> This is a follow-up to 982300c115d2 ("r8169: remove detection of chip
> version 11 (early RTL8168b)"). Nobody complained yet, so remove
> support for this chip version.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


