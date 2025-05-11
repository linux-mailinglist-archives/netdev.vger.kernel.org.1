Return-Path: <netdev+bounces-189602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87388AB2BE3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 00:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84CB7ABF08
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530525D559;
	Sun, 11 May 2025 22:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BE13BAF1;
	Sun, 11 May 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002143; cv=none; b=JAKlbrkXmfPycgia53QvtEw3NA/z6MEQ31tss9jQLiRyXzHU3jvpcf3jHnVObc3zAJLMqUUlIX4JpQHTl9nfBdItlFZn+t5F/9D6n41I6YFWTNo0YQsLBxaCv+2PtOqcQblfPw78BAMZJb2oebEgzI7Yd0iIP134WSpz/c7h47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002143; c=relaxed/simple;
	bh=xcGjkpBj/EnoapfIH+HcMnAV6qKAFn5NRJcOXJ7R3dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTQl+6O15d/Q4ZVgRxrtig/9EkFg/8+MBqIibTy6tmLxrzjJBtVt7mydxagUVgG0VMHJL8Y31tOW69ooeYcvLsOwuU5dZvNOSgsTOOAhEeL8KaULGhPFmT51Wqnk7e11V7i2fCCHEvv68IfsczQIA4x2dHgeyzgwjjK8PWWidrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uEEYY-000000006sM-1X1I;
	Sun, 11 May 2025 21:55:54 +0000
Date: Sun, 11 May 2025 22:55:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux@fw-web.de,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	lorenzo@kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: Re: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch
 node
Message-ID: <aCEc5tYPivxvRVDK@makrotopia.org>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-10-linux@fw-web.de>
 <bfa0c158-4205-4070-9b72-f6bde9cd9997@lunn.ch>
 <trinity-0edcdb4e-bcc9-47bb-b958-a018f5980128-1746984591926@trinity-msg-rest-gmx-gmx-live-74d694d854-ls6fz>
 <74afe286-2adb-42d3-9491-881379053e36@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74afe286-2adb-42d3-9491-881379053e36@lunn.ch>

On Sun, May 11, 2025 at 11:25:27PM +0200, Andrew Lunn wrote:
> > i will move that into the board dtsi file in v2 because "normal" bpi-r4 and 2g5 variant are same here.
> 
> Maybe you just need to expand the commit message? What does this .dtsi
> actually represent? The SoC, or what is common across a number of
> boards?

mt7988a.dtsi represents the SoC, and thus there shouldn't be any
labels assigned to the DSA ports.

In case of the BananaPi R4 there are two different boards, one with 2x
SFP+ and one with 1x SFP+ + 1x 2500Base-T (with PoE-in), hence there is
a dtsi files for all the parts shared among the two boards. I suppose
Frank meant to move the labels to that board dtsi file, and that's
correct imho as the labels of the 1G switch ports are the same on BPi-R4
and BPi-R4-PoE.

