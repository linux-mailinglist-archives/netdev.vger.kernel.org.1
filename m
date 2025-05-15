Return-Path: <netdev+bounces-190600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E3AB7BCF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517A88C74D1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2849213E8E;
	Thu, 15 May 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRmOm7HT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F7E4B1E64;
	Thu, 15 May 2025 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747277837; cv=none; b=bIl7TVfCPeCNbHcB2pOWfVmu2Pri52LLnN/mtHItA90ytLEEwY0S6TWhkH6NQ446iXunuI0LnJeUX50BOB+7obVGUdkCQ3mbN7YxACqXXqMJC+WyN1rfbHsiw4TxtnOjw4FxW+g91cUJEpHjHL6UQRm2SB5YSMZoqEQlt1O5MeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747277837; c=relaxed/simple;
	bh=IKxa+/dqwM9Ni4gdttJKV7TnstQDA8nGaIgMMKx1tD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C87oxR3p6rtzK4i7j9xmU8cnMhVU3eeB69JkZQNwOoP0Rfxfc6D1a+aNzvhelmLdbZZdhRj3StGBrSDKLJ+9bIOhPHJ6cEErDdJW358GN/7qH1H2LUoS9uttyTArMHWv/hRpq3FDylEDvENzSxmwTlHKePhM37GPRMKRBDjk9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRmOm7HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99CEC4CEE3;
	Thu, 15 May 2025 02:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747277837;
	bh=IKxa+/dqwM9Ni4gdttJKV7TnstQDA8nGaIgMMKx1tD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRmOm7HT8OCbQ24tZYIIgFV9qG5Al8potvi4ydeSuqpcj1xfpPOvFIpjvnB/PIT02
	 0Ut9lXCxFhT2dxxSO9iF1W1Z+4nrFb/G9aRQdVLrdIynpgFvOJOIAGtFupTi6cCKKz
	 2toD5m4ZvnpxmxpYjHbjEbT+y32Blh9c/f9dBAMh4gZaqCZzOHzziNPflQNgJSNlF/
	 Lbp3iSQuVKtOZ+pxML8qRdf/WjmrgL/iP/jPaGV9stjIg3Z/XC7IVSOAoCMRb5A1Ti
	 py8h9QtSCu1RlLKmh3f6C6LTt1DQlgv5QKZ+7iWEVt8XVw1Gp1VYLmiGpxhUkoP+yU
	 IUjw/YhzODMUQ==
Date: Wed, 14 May 2025 19:57:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 upstream@airoha.com, Kory Maincent <kory.maincent@bootlin.com>, Simon
 Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [net-next PATCH v4 06/11] net: phy: Export some functions
Message-ID: <20250514195716.5ec9d927@kernel.org>
In-Reply-To: <20250512161013.731955-7-sean.anderson@linux.dev>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
	<20250512161013.731955-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 12:10:08 -0400 Sean Anderson wrote:
> Export a few functions so they can be used outside the phy subsystem:
> 
> get_phy_c22_id is useful when probing MDIO devices which present a
> phy-like interface despite not using the Linux ethernet phy subsystem.
> 
> mdio_device_bus_match is useful when creating MDIO devices manually
> (e.g. on non-devicetree platforms).
> 
> At the moment the only (future) user of these functions selects PHYLIB,
> so we do not need fallbacks for when CONFIG_PHYLIB=n.

This one does not apply cleanly.
-- 
pw-bot: cr

