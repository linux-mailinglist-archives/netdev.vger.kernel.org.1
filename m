Return-Path: <netdev+bounces-104768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9990E48B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBADE282154
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A976025;
	Wed, 19 Jun 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHgHq/CA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED5558BC
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782343; cv=none; b=Fop5E9dH6dUhd2t6+vTphyoRN0iRzDPp3bv3dM9HISWzMVWE7i8uPQRwka9VlrPIlxQLWpwOi24S7VhqcbgdmIUeMCWJeBAMQsktC8N6hpA6wfgq5q5h9JuvEbn5jLbpjSSoxTArOdAW+lOgmvTo7GJc6wVj7vKm0jV/i6N5924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782343; c=relaxed/simple;
	bh=xtIQIbQ+KGo4Vw9g5D1MEwAWD18eZLeyaWwNhV1nibg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrIvf7SeYa9ldn1nz2mkG1y87p86oeY1+nTbs9toZZhx0k2Q3470K867mwItpltcfKghHv0UVpXV4wZPe7Ri6UGSjCoJhx6xeGXM3GycfZRNv6hIbaBF+qsmlgfah4FClzgYT1x1x0CKzdRfItoqeG+azVmqA+o1j1KJRX3RhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHgHq/CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21477C2BBFC;
	Wed, 19 Jun 2024 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718782342;
	bh=xtIQIbQ+KGo4Vw9g5D1MEwAWD18eZLeyaWwNhV1nibg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHgHq/CAG25Yawuf6k7YMP4rExzbSTDJJDOXlcPb/bb0GNZbCa5eXQ4VCw0AKI3oE
	 /DOw529jYFSEZSIHKAgNZ+r2LpHl6PDPjzNmksZghdALYJgruULd6Fh79kZUFn8FfT
	 udXJDHH1K2CdIxuXd5919QKHNrGVLLM11pmJPBHqPZIr6u5gB7uXABvEuXU+SNQwir
	 Pq2b9JKR5SEotPvzfVG3pmZSN3BjIbfQG8vP1b10VaYObq7FIpbUaMcCRa00E3JxIW
	 fcKYRz+Y57kzX16W/M6EClPpvsmrOp1iJYMiN7W4e1RT2IDZNEIUKe14OwVbukPzVj
	 QToZ1F8/j62oA==
Date: Wed, 19 Jun 2024 09:32:18 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Peter Rashleigh <prashleigh@questertangent.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: dsa: mv88e6xxx maps all VLANs to the same FID
Message-ID: <20240619093218.155065ef@dellmb>
In-Reply-To: <b22a2986512849b7887943e5850fa03b@questertangent.com>
References: <b22a2986512849b7887943e5850fa03b@questertangent.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 15:24:08 -0700
Peter Rashleigh <prashleigh@questertangent.com> wrote:

> Hello all,
> 
> I've discovered what suspect to be a bug in the mv88e6xxx driver. I'm curious if anyone else has run into this behavior and might be able to suggest a way forward (or can tell me what I'm doing wrong).
> 
> I'm developing a custom networking product that has three Marvell 88E6361 switches connected via DSA to a Marvell CPU running on a custom buildroot Linux (version 6.1.53) like this:
> [CPU]---[Switch 0]---[Switch 1]---[Switch 2]
> 
> The product uses a mix of bridged and standalone ports, spread across the three switches.
> 
> The problem I'm having is that all VLANs (both for bridged and standalone ports) are using the same FID. I've found that mv88e6xxx_atu_new() always sets FID=0 even if there are already standalone ports or other VLANs using that FID. The problem seems to be with the getNext operation called from mv88e6xxx_vtu_walk().
> 
> The VTU Walk function sets VID=0xfff and then runs mv88e6xxx_g1_vtu_getnext(), but the switch does not respond as expected. Instead of returning the lowest valid VID, the register value (Global 1 reg 0x06) is 0x2fff, suggesting that the switch has reached the end of the second VTU page rather than starting from zero. This seems to conflict with what the Marvell datasheet describes, but I haven't come up with a better explanation so far.
> 
> Any suggestions are greatly appreciated.

This is known limitation of the current version of the driver.

I started working on this FID separation in order to support
multi-CPU DSA on mv88e6xxx.

Marek

