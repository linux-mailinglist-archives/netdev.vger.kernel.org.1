Return-Path: <netdev+bounces-198844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A796FADE03D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F7D3B9694
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000242049;
	Wed, 18 Jun 2025 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXtJaDtS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B229A5;
	Wed, 18 Jun 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208196; cv=none; b=OR/ZNmFoGYo+n5XToL90OXxXcFeKgZQIZTwjfzxjv8+XW9os0LXGcVmeQQzKIf+TQtpIyrb0zFEzkxrIpi6Z/lHagdrqFoKiOyh2W8k03CY4LXh9n8Ih1dNtXI3JYUm7dfuSSyyTUoO9e4T135+LfoWX9R9kxBrkNQnJdQv3qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208196; c=relaxed/simple;
	bh=jf0PfUJI2wJjcwG+5ifpaB1FC4hkqfOWN/t2FhiaSW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meGkjFIsa3/pk8NxnDJJxoYAkSLaEbC7Ov2kJRW+a5k9Hit4LU6wFjguvMfcXk6j9hSj5y/KrlQd1TccXkJTdKAzyMo43u+PHA2xkcXrsxkSj6/OMC/5ndTo03HFt0FjIwkVxiiqQpf9Ey9pyogj5gdBiI+KbBYWHeaweWs+BzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXtJaDtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B779C4CEEE;
	Wed, 18 Jun 2025 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750208195;
	bh=jf0PfUJI2wJjcwG+5ifpaB1FC4hkqfOWN/t2FhiaSW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VXtJaDtSao0XAs3sY0reVQeBGgmLFDQncc3RAtkxD1JfR7lI9jpLk1hWD88War5dy
	 GDEhR0p/kxBnspAGDW0u7hxhMHqK8ClMwaB6xrKayQpGWAynC8GCYgM869Q4OK7/sY
	 9CnFvhb2hW+fuhZtjo9vM+xhYbcofh6jl4x5ynL3j33hLWrz+Z44F8FGaShWp+FfEb
	 vRGhHd0r+LNoFFDdNYtxc76+AoNAafNIw6C3/40IYhciUugFATdzXa+1FXRjsJfleH
	 0abLaA+OSduu92co2HVjl+Un5PRv0G5KPE624MV/gvbNmwD28xa/e6Hqbt7fg1y8GD
	 7bS89z/pFaaCg==
Date: Tue, 17 Jun 2025 17:56:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [PATCH net-next v4 00/14] net: dsa: b53: fix BCM5325 support
Message-ID: <20250617175634.73ce12c9@kernel.org>
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Jun 2025 09:59:46 +0200 =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> These patches get the BCM5325 switch working with b53.
>=20
> The existing brcm legacy tag only works with BCM63xx switches.
> We need to add a new legacy tag for BCM5325 and BCM5365 switches, which
> require including the FCS and length.
>=20
> I'm not really sure that everything here is correct since I don't work for
> Broadcom and all this is based on the public datasheet available for the
> BCM5325 and my own experiments with a Huawei HG556a (BCM6358).
>=20
> Both sets of patches have been merged due to the change requested by Jonas
> about BRCM_HDR register access depending on legacy tags.

=46rom the commit messages sounds like the support for these switches
never really worked properly. So I'll drop the Fixes tag when applying.
No objection if you'd like to argue with stable folks for stable
inclusion once these reach Linus, given what lands in stable these days.
But I don't want to implicitly support that by applying with the Fixes
tags.

