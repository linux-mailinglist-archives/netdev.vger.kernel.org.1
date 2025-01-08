Return-Path: <netdev+bounces-156388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1593A06404
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A6F1639C2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C341F37C1;
	Wed,  8 Jan 2025 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPw4I25x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9F201009;
	Wed,  8 Jan 2025 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359747; cv=none; b=AnuwtveHB0v0fE3XNjxba0E+fJxIyd4+6lfdSo0JAQenmdttXjQ44c/3HDyPL3SbUdMjJ9cZgSZ503zm6PJEQ3BDvJ8utgDGyY1WcIHdQ3RLzTF9Ihve3EleH72F+HpiLTZkg/HkbVCE3lalEYnAdCKkxrMjkfW85mSnjstB/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359747; c=relaxed/simple;
	bh=dc5tX6iGuqp4ia40hT7GsjfCAEU6nCYDAzvIlbM/3qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P25Bo89qHEx5ZUByq2K8GWepLcnkDgNKNWhSjvgUugmNHm+N0UzS5G1Z9eCs9P3brdoRYJNVG9xWVtGadsIEjXsyUIRRXNNn8bkyAWVwk5eEwfgGf6dgFSyUCLgj1jRxG31hGt55VuWEMBPTAqd0mw32uej/sstiDKj2V/ZQ7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPw4I25x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A788AC4CED3;
	Wed,  8 Jan 2025 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736359746;
	bh=dc5tX6iGuqp4ia40hT7GsjfCAEU6nCYDAzvIlbM/3qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPw4I25xSFz1baYxHhmzXDDq+77rD8HtKuA6ojRoh0+ADYwcZNojfAMhp5wd9XLVN
	 MOdwTlrrt60SZa8l8CyFdbMYw2qyu3rK3rtmdautUCpwxI3+6p+mfuLAWiXeZqKgN2
	 gDFrALvxdMK4iTeRZBMTN53adBXqtkgE2G5Zopx9h3qhuLgz/1TCFEA68h0rRl0KEn
	 rk1ZF3+Srpi91a2URzka1CPp4e3i243r9d/G7sp6HfBOPWTd9d0eT+oJWg4Diin80s
	 Vp6eIp+uMu6oxdcJbB+VfPuAd5QvGycZ6hRtsa1dtMoU0FV4UgNpSFm8xOn1jtun/S
	 Gnyftr8jXxt8w==
Date: Wed, 8 Jan 2025 10:09:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wellslutw@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Message-ID: <20250108100905.799e6112@kernel.org>
In-Reply-To: <tencent_DCCF5160376D4BCFA435D41FF333627BDF06@qq.com>
References: <tencent_DCCF5160376D4BCFA435D41FF333627BDF06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  8 Jan 2025 14:12:38 +0000 Yeking@Red54.com wrote:
> From: =E8=B0=A2=E8=87=B4=E9=82=A6 (XIE Zhibang) <Yeking@Red54.com>
>=20
> ndo_do_ioctl is no longer called by the device ioctl handler,
> so use ndo_eth_ioctl instead.

I presume this used to work and now it doesn't?
If so a Fixes tag pointing to the commit that broke it would=20
be in order.

Please also mention how you tested this. Is this something you actually
run into on real HW? Or just found by code inspection and only compile
tested?
--=20
pw-bot: cr

