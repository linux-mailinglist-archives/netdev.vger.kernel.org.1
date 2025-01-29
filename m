Return-Path: <netdev+bounces-161509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D7A21DD6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B876618865CB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6F55887;
	Wed, 29 Jan 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ixsy6HXu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDD224EA
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157201; cv=none; b=Ta0EGPfVjdemoZ7jGjoHVm5Xi5UEVkG2SVjGPl9WFCdt9k5/3E0cTlSInFpQ+TYh+1ePRl2F/R0aLLcPhJtv/NZt+QvG8nFbUm4WNl3+MohnZ/pIyLtq8keLaCLNukp0P28gnz7PPfTxXSHU1NIo89TGVAREwkq9OANtdAA2OHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157201; c=relaxed/simple;
	bh=4JKcBGNqI2sy5MwuPxJJMVpBQze95dzhaAxlLeaVMow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF3Rh4cLwnOQsvQyeh/VOdso6qtrv8vAvzWzt7WdKJvOEN45SUWd2CRt49xj9g3TshRfuKfBgCSXhVzOHCu8W9xy3K8bR9RRyTL6b5MNOCRM3kKYVqb5TdK85dO+/CURlhWFoQyJCTq7MchehEuObdrFx+C1dlAapIJIW+Blm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ixsy6HXu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zxdYojs6H4/OI8EobA5gXcNdW7DYKmLdr7xDmLRiUwc=; b=Ixsy6HXuM+31mRZnPdfTjxXcjc
	wwib6OcCZJxuvv7Y7JvvgiijEve4EgKPjAYoftVe2eSNb5DWothI46ZU4NUqqEPFVk71+9WRmeyyn
	IjwQAEp6GY3d5ZqyGb6qudzXwfALp3YKV3igRx2UwwJgouUjD7/FSFJqSbTMwFW7LoEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1td85P-0098VE-0H; Wed, 29 Jan 2025 14:26:31 +0100
Date: Wed, 29 Jan 2025 14:26:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Lukasz Majewski <lukma@denx.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: KSZ9477 HSR Offloading
Message-ID: <5e757e5c-b426-4532-93bd-0f4c9f6a1069@lunn.ch>
References: <05a6e63e-96c1-4d78-91b9-b00deed044b5@kontron.de>
 <6d0e1f47-874e-42bf-9bc7-34856c1168d1@lunn.ch>
 <1c140c92-3be6-4917-b600-fa5d1ef96404@kontron.de>
 <6400e73a-b165-41a8-9fc9-e2226060a68c@kontron.de>
 <20250129121733.1e99f29c@wsk>
 <0383e3d9-b229-4218-a931-73185d393177@kontron.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0383e3d9-b229-4218-a931-73185d393177@kontron.de>

> Anyway, do you have any suggestions for debugging this?

Could you dump the fdb tables. `bridge fdb show`. Has the local device
learned the MAC addresses of the other devices? I'm making a big
assumption here, that HSR makes use of the FDB to decide the egress
interface. If there is no entry in the table, the hardware could be
dropping the frame. Rather than drop, it should probably forward to
the CPU, and then software HSR will determine the egrees
interface. Once the peer has replied, the FDB should get populated,
and then hardware should be able to do all the work without Linux?

	Andrew

