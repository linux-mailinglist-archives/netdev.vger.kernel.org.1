Return-Path: <netdev+bounces-61060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F38225B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C931C21B43
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BEB17988;
	Tue,  2 Jan 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8Cmierg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7F17984
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 23:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B9DC433C7;
	Tue,  2 Jan 2024 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704239415;
	bh=RuGeG/C6MmKlTpW4SNCmLPxjBBw93qwjuWM/Fo35tC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8CmiergwiIWq9QMf+vmlA6JTHnQhu+NGQHtPtM/MYdNe6SHupBwHruomV5Ef6Lxj
	 8BTX7mItICuFcVjBhzPFIHTgQE7n6EB2Pe3pyBgY6AnqrUPS/qEB3BLxI45PC4asKr
	 lfQcM++CGm7+VXX3NHsO4CHYVZmayA0WEL9NMXb/2oQuTJfvYaru8RkyjqE2TCoM6B
	 6uTMGnqna1yV1XI7XfzP1ih8zv+3YHO4HbKmXFNmoK7QFmFNC7hNwa1/waO+xamsal
	 DrTjydJdbbNdZ0dwYTM9mIcaYSH6pgS2izyRDNsgN8eJpaWy3TrwXvRsV/ETcpWHG7
	 D3HRoaNu1pNqg==
Date: Tue, 2 Jan 2024 15:50:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: extend
 genphy_c45_read_eee_abilities() to read capability 2 register
Message-ID: <20240102155014.7e1ccc4d@kernel.org>
In-Reply-To: <20231220161258.17541-1-kabel@kernel.org>
References: <20231220161258.17541-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 17:12:58 +0100 Marek Beh=C3=BAn wrote:
> Extend the generic clause 45 PHY function reading EEE abilities to also
> read the IEEE 802.3-2018 45.2.3.11 "EEE control and capability 2"
> register.
>=20
> The new helpers mii_eee_cap2_mod_linkmode_t() and
> linkmode_to_mii_eee_cap2_t() only parse the 2500baseT and 5000baseT
> EEE bits. The standard also defines bits for 400000baseR, 200000baseR
> and 25000baseT, but we don't have ethtool link bits for those now.

Andrew, Russell? Looks good?

