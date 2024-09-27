Return-Path: <netdev+bounces-130075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEECB9880A6
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1621C20B6C
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EBE189502;
	Fri, 27 Sep 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="QDHiue0g"
X-Original-To: netdev@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BA165EF1;
	Fri, 27 Sep 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426803; cv=none; b=KhXyHX+zw39PN9zGkVCHm7y7Ti2jHrIPnUjO5Xw5G9EqXHHWPVyGHOTa1vnj7nO9I7UBceZg4FOkoNPctzdSqCdKhSOZWAtX0Pz1F2jgtqwY4Fqa05GK4iyZJWapa3vGzGYk3X/sqYXI2DR5Hmm2mbTG2xreZclUOqsLcsYDGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426803; c=relaxed/simple;
	bh=4OPjX/kdKUOVqD6oVThe0OHydn0WXXzoTRk9UZBbSkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeI0BwYIA9CaUy2kGQ/ENRA8n5AE+PTXLqbJJMlM7uxzD6rI0wx7G9lY9rYQ/Z/bq+uAF68TAZy3H3QVripMzshHDNzfMJyd+YwDfTzTcglcg5kTZzyJFyaAcPMdIgVT6oWNeuIh4V2LQy5OUDAwtWffx5j2oW5xNZHg2AoY+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=QDHiue0g; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1727426797; bh=etbm3SKCTk/HqOaeskrRrwt6iupRvzfmQjVxZJpzWaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDHiue0gwyE3iWlXautgEwmuPl18feKYnykZm74uWAY4SgM3PvP9fM4xmXMq/qFsV
	 cf7M+5h6WylgeWJie5uwYlXwy/eFIP6pGvJ3GBaNCQo6dewq+3BTiD5LIuV7uKScT+
	 SeTU/+PUkBwq2nRDcQ891s6ZhQQ3XhDzN9INMJOI=
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, aliceryhl@google.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v3] net: phy: qt2025: Fix warning: unused import
 DeviceId
Date: Fri, 27 Sep 2024 10:46:34 +0200
Message-ID: <D0E9079F-5872-4A37-AF88-799EC318FE0D@kloenk.dev>
In-Reply-To: <20240926121404.242092-1-fujita.tomonori@gmail.com>
References: <20240926121404.242092-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 26 Sep 2024, at 14:14, FUJITA Tomonori wrote:

> Fix the following warning when the driver is compiled as built-in:
>
>       warning: unused import: `DeviceId`
>       --> drivers/net/phy/qt2025.rs:18:5
>       |
>    18 |     DeviceId, Driver,
>       |     ^^^^^^^^
>       |
>       =3D note: `#[warn(unused_imports)]` on by default
>
> device_table in module_phy_driver macro is defined only when the
> driver is built as a module. Use phy::DeviceId in the macro instead of
> importing `DeviceId` since `phy` is always used.
>
> Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp=
@intel.com/
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Reviewed-by: Fiona Behrens <me@kloenk.dev>

