Return-Path: <netdev+bounces-158343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0129A1170E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0C93A8877
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695F22DFA5;
	Wed, 15 Jan 2025 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAsMv2Gd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94222DF9B;
	Wed, 15 Jan 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907093; cv=none; b=NHX0bSiDCy2OJO2RTHZ5NwQh2jHsMjtFuiy3MlmR7y5sf0K84a4GEuimMUTFPBfgyZRAe9ZifkPgzC225QyjWoN06LY9YMSY8ivjIwRe9NZOcYS59zRPM3WkdRvp7hTK6vWGhqhhOmWScPyqT7mhGJm6yTDPLtYdjewJqT0jxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907093; c=relaxed/simple;
	bh=4hUXL97uFmxqITNaBBSMTE/W15OfOWN6ejVq8VWlfJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3fXvu1f9yZH+jwB49AMZHhXXJ7FaNVAEyHXEB8TBPv2Xa1FUCNSDl/XLOmelAFLsyDCc0ki5LPicbZs+nJMPjZpY0oX3XYQHpknKPhMGR2+IslgMon9epNG7zb04sCzG54CF+SnH8qag2znUWVqG+ZesDJn0fXa2oWuY5T1JUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAsMv2Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16589C4CEDF;
	Wed, 15 Jan 2025 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907092;
	bh=4hUXL97uFmxqITNaBBSMTE/W15OfOWN6ejVq8VWlfJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eAsMv2GdcvdX8YNZlPhHvahtmrv16IXLEXNt2RSSImKyWKg3tl15ymo4npFyA7DuC
	 luUvM4FSvhCKzLIfN/o8PYOHTLMRC0IfaNLmHDvaj2ldPjj2A0mB63Z+E6BMzT3u03
	 3Fwwfdx5+DGjLxAKtu5NOxJFWcTGXBdQwZzWEh+5w2XmgwxpoIQ216zgLRnmFbelKK
	 szuH6zymwZRlc34I9rOcZHu6stlxk253MHuA/Cl9w3BvPye2bLKp0ChiCgon9w7uJT
	 XgmGAnxDtSAb0X1QAdHAtezq9cF3MHoEHCEaHDZp2w/+37ah8W0g5IglYcBDVwYUK/
	 56Q85UhU18y5g==
Date: Tue, 14 Jan 2025 18:11:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: andrew+netdev@lunn.ch, arnd@arndb.de, davem@davemloft.net,
 edumazet@google.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, wellslutw@gmail.com
Subject: Re: [PATCH net v5] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Message-ID: <20250114181131.16c1072f@kernel.org>
In-Reply-To: <tencent_8CF8A72C708E96B9C7DC1AF96FEE19AF3D05@qq.com>
References: <20250110175737.7535f4e7@kernel.org>
	<tencent_8CF8A72C708E96B9C7DC1AF96FEE19AF3D05@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 09:41:56 +0000 Yeking@Red54.com wrote:
> From: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>
>=20
> The device ioctl handler no longer calls ndo_do_ioctl, but calls
> ndo_eth_ioctl to handle mii ioctls since commit a76053707dbf
> ("dev_ioctl: split out ndo_eth_ioctl"). However, sunplus still used
> ndo_do_ioctl when it was introduced. So switch to ndo_eth_ioctl. (found
> by code inspection)
>=20
> Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")

It only occurred to me now that if we're fixing the initial commit
the PHY IOCTLs simply weren't available since day 1, so this is more=20
of a new feature than a bug fix. We'll apply it for v6.14, sorry for=20
the indecisiveness.

