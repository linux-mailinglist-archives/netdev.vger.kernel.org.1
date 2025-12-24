Return-Path: <netdev+bounces-245961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20164CDC0BD
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55828300CD82
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051B631961A;
	Wed, 24 Dec 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OD5YfJUZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4B30FC1A;
	Wed, 24 Dec 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766573536; cv=none; b=csvOtyxkBRJ3QzVItovmmyYB+8skUrJQXHJiAKhhd5eV2mSzsAel8HnoVhmAzCKWAffpmdEmyQzzJsNhLUA3Fu5Kh4ga/t6wLzKYw6OZLs4e/HJTQ7THKnlQ+wLgPrhM8rWsY2yhpC7N4aSkDBpiiArU8EeGib69aN6JkHYbsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766573536; c=relaxed/simple;
	bh=gHojVJsDKlTNfROP44dvoRhxXBvx+CnSxsHx7SynUug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNxgCqdc9sfyzerlObbhony4FjjX9f8a4EZ58sD5MlVg6fjfSf3+RHDZ5beDILRqPeJT5WkQymlAEebGOJ1fH0yS3Kdm6Dp67l4S6xZayz3igPzewnH+Tc1kChv370/baHlRNN5GAxjEH1clCUs2Ao6mPskQWMTQMFvEDjZWDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OD5YfJUZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aDkZBs9qrc+0P0Gz0aNutHgvFNAC3PxwJGXABfFbG0A=; b=OD
	5YfJUZWSgjmkFGcY/SKvG499SMfdCcG0Qr9pt6VvA8aUrOv0f21dZ8tx0Vp5hJDgd+IdoDb0Lay/a
	qqqT+gHEMpdpfpJ38H+NnH5RW7P0g4OOpcKrjqUsi7G1OPJ6xGAFeNoD5UOTQzYCu8WLlrsB9eaPA
	w83zs10CGhPeL6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYMTU-000PAL-VW; Wed, 24 Dec 2025 11:52:12 +0100
Date: Wed, 24 Dec 2025 11:52:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 15/15] net/nebula-matrix: add kernel/user
 coexist mode support
Message-ID: <5d49395a-fad2-4471-b66e-93d951bcffeb@lunn.ch>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
 <20251223035113.31122-16-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223035113.31122-16-illusion.wang@nebula-matrix.com>

On Tue, Dec 23, 2025 at 11:50:38AM +0800, illusion.wang wrote:
> 1. Coexistence Function Implementation
> Create a virtual dev and wrap it with a VFIO group and VFIO mediated device (mdev) framework,
> or use the traditional cdev approach.
> 2. Mode Switching During DPDK Startup/Shutdown in Coexistence Scenarios
> The function nbl_userdev_switch_network handles mode transitions when starting/stopping DPDK
> in coexistence environments.
> 3. User-Space Driver Scenarios: Coexistence vs. Non-Coexistence (UIO/VFIO)
> Leonis PF0 is designated as the management Physical Function (PF).
> If PF1 operates in kernel mode and DPDK is launched:
> Coexistence mode:
> Commands are issued via ioctl to the PF1 driver's kernel layer (nbl_userdev_channel_ioctl).
> DPDK blocks on the ioctl call in kernel space.
> PF1 intercepts and modifies the request, then forwards it via mailbox to PF0 for processing.
> DPDK remains blocked, waiting for an ACK response from the mailbox.
> Non-Coexistence mode:
> Direct mailbox communication is used between PF1 and PF0 without kernel intervention.
> 4. Event Notification Mechanism
> For PF0 to proactively send mailbox messages (e.g., link status updates) to other VFs/PFs:
> A software ring buffer and eventfd are implemented for shared memory between kernel and user space.
> The kernel copies subscribed messages into the ring buffer and triggers an eventfd wake-up to notify 
> DPDK's interrupt thread.

I would suggest dropping this patch from the initial series. You are
going to need to split up some of the other patches, and you already
have 15 patches.

     Andrew

