Return-Path: <netdev+bounces-204355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26157AFA254
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8524B3B0B5C
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4642BFC7C;
	Sat,  5 Jul 2025 23:23:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B42BD5A0;
	Sat,  5 Jul 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751757838; cv=none; b=WsKMODXhDGuJxI8wou9lvmSUTgx5KFU43NXpANR6E2/7rNWCGCYC0TnQgsbUhmRcNwijXLsMuIj0JAJ3+HmTfi5N3RGjJpPabZh0TWVk519A+3XbekPHBkkeXPtg9lDEAamUZeumBJwtwejP2gB16cncPtJVQSCRmM1NvDA938w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751757838; c=relaxed/simple;
	bh=iXCNf1YB3NIwYuKMj7k0Kc8P1cVVFy/saHOWN7fQLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=id+PAbG90aK/PT3WYuBDbZA28p8zMQMc9loSC95SAKgIb4EqVsfiyNRv3NN6VwfkcXJA8mDOSxIBTdEDav2vtp3iLqqJyhOzgHJbdo2jVuuh872S0lCqcyt3qELiZ8i3SJiOadBYpVJwkORVNeGgX2E8cTFL+oWuMYU7MlVBqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3520D152B;
	Sat,  5 Jul 2025 16:23:42 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68AF03F66E;
	Sat,  5 Jul 2025 16:23:53 -0700 (PDT)
Date: Sun, 6 Jul 2025 00:22:23 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chen-Yu Tsai <wens@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Message-ID: <20250706002223.128ff760@minigeek.lan>
In-Reply-To: <e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
References: <20250628054438.2864220-1-wens@kernel.org>
	<20250705083600.2916bf0c@minigeek.lan>
	<CAGb2v64My=A_Jw+CBCsqno3SsSSTtBFKXOrgLv+Nyq_z5oeYBg@mail.gmail.com>
	<e9c5949d-9ac5-4b33-810d-b716ccce5fe9@lunn.ch>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Jul 2025 17:53:17 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

Hi Andrew,

> > So it's really whatever Allwinner wants to call it. I would rather have
> > the names follow the datasheet than us making some scheme up.  
> 
> Are the datasheets publicly available?

We collect them in the sunxi wiki (see the links below), but just to
make sure:
I am not disputing that GMAC is the name mentioned in the A523 manual,
and would have probably been the right name to use originally - even
though it's not very consistent, as the same IP is called EMAC in the
older SoCs' manuals. I am also not against renaming identifiers or even
(internal) DT labels. But the problem here is that the renaming affects
the DT compatible string and the pinctrl function name, both of which
are used as an interface between the devicetree and its users, which is
not only the Linux kernel, but also U-Boot and other OSes like the BSDs.

In this particular case we would probably get away with it, because
it's indeed very early in the development cycle for this SoC, but for
instance the "emac0" function name is already used in some U-Boot
patch series on the list:
https://lore.kernel.org/linux-sunxi/20250323113544.7933-18-andre.przywara@arm.com/

If we REALLY need to rename this, it wouldn't be the end of the world,
but would create some churn on the U-Boot side.

I just wanted to point out that any changes to the DT bindings have
some impact to other projects, even if they are proposed as a coherent
series on the Linux side. Hence my question if this is really necessary.

Cheers,
Andre

https://linux-sunxi.org/A64#Documentation
https://linux-sunxi.org/H616#Documentation
https://linux-sunxi.org/A523#Documentation

