Return-Path: <netdev+bounces-151122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E52AF9ECE66
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6B5165FBC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308A2AD13;
	Wed, 11 Dec 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3vbznPGc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC0624633B
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926612; cv=none; b=U2sZuXXHllmDldql6BsEr0JtWs0jK0Ux3ZzTwpnquOYPfTeRuLpESp5Ln2+/xXxWdLrJapXvYl05Kv1sbO5sTUAqHhCgH9DvWZtk2mYM3IuMlMAVYZclLpkUOkuoXCn3TBGeJ8bXfW5oNRnUdp0gfTz4R4URYQxkXB5wYbrAPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926612; c=relaxed/simple;
	bh=/VmewYdRjjBjIrkdYNIJf5gAAk1LWd6JXQfz0DV013U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGgqkEb5IxoC3gK5d7SOl4Vnbnqy4E+E3BwiRwBj11lmSRarqfYH9H9m+guHOmsGP1Lt0Hg0mdaflDbtgYKR69qIZgvbDxc3XYzZhiWceHPVEUzu3XW4FNgLx0QG1/Yahn7lRw9oXeNzcTwturSZcxJDmIsJieqI3LCBQVqq9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3vbznPGc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TNxKTIDITpGiQBM+gnXUeG0YdbWOeYS+AZgYrOtb/Pw=; b=3vbznPGcCmm1YN4mxUPIQ9KWTR
	dXk0q+4ks7toOjJHw/Do0envUl09PT+5fELPk6Qy7RmP4MtlJRoz14ioA1x/dx01mkHsqTk8Oxaea
	S/ntIeN9NOchNdqxLJaYmvPUj35UWvyA+9MLFhp03+E/lE6+pr9D0xojv7opKredBURM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLNW8-0006dw-Dt; Wed, 11 Dec 2024 15:16:44 +0100
Date: Wed, 11 Dec 2024 15:16:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
	stephen@networkplumber.org, anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [RFC 0/1] Proposal for new devlink command to enforce firmware
 security
Message-ID: <d5d1ce3d-2233-4899-875e-28d7ee2becb8@lunn.ch>
References: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
 <20241209153600.27bd07e1@kernel.org>
 <b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b23f47-96d0-4cdc-a6fd-f7dd58a5d3c6@linux.intel.com>

> The E810 Ethernet controller firmware provides a certain level of security,
> which includes a mechanism to prevent firmware downgrades (to past, less
> secure versions).

Is there anything Ethernet specific here? I assume the same API could
be used for GPU firmware, ATA controller firmware, mice firmware?

Maybe you should pull this discussion up to a higher level, covering
all drivers, not just netdev.

	Andrew

