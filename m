Return-Path: <netdev+bounces-124307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D30C968E9C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B0EB222DA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9419CC38;
	Mon,  2 Sep 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U6IQ6i2Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E91A3AAE;
	Mon,  2 Sep 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307229; cv=none; b=iDq0+DFgbIMg0HuFLZFXj7DwyuHBvFumYzNzSrrSPe4I/4iJcOadTaXcXmTHMNuZRjjEdesKkptG0phw+/7hvfAiUnseSqFA/Rhkjd6rkql3+Bv6kdEVPZDGGXCmzuggB2HG2bDO1nrO/kGSq5HPQIM99BK6ZsQFFwHUpH6nCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307229; c=relaxed/simple;
	bh=rSudGR9lv25NDaf0WRV0seG13Tv04mw9rm7wsU59mNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozhL/X1LAm9Kt1SeDZoE0+cqzugfTSVWzwgpjtAALxDBpDlmZ8SPqJH1xztzs17pXga3dU/fieUKV5QHdMLqBX68aWE7N3DON9lsnpfxY3G5fYZF4ovyM9hdSksIJaqg5u0QJ+ZElRGBsKqe4pKBSv4iRyUt2DrONO6el2/DbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U6IQ6i2Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8yMR5uT2W+YAXhRky6NcWc6wa3fJmhxzXFaGoWII4Ms=; b=U6IQ6i2QNltTkpl5ggwrV1nO//
	6vbLGuic/NbFtnP9rFnPMBWxIbvX0Tn/uKXo9aOK5yIQeR7T635cuPfM5gwb6OK4KnV8fEc8rctXZ
	bGgurlB6DA7GnDti25zuLVZ+amKiIT28GSu1sh+sreIbGRZNiS6O+61GSoqkFClnLqRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slDDl-006KsK-IP; Mon, 02 Sep 2024 22:00:17 +0200
Date: Mon, 2 Sep 2024 22:00:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCH net-next 0/6] net: ibm: emac: some cleanups and devm
Message-ID: <b149c9cd-a76b-4fb8-b3ff-430afa8fdd77@lunn.ch>
References: <20240902181530.6852-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>

On Mon, Sep 02, 2024 at 11:15:09AM -0700, Rosen Penev wrote:
> It's a very old driver with a lot of potential for cleaning up code to
> modern standards. This was a simple one dealing with mostly the probe
> function and adding some devm to it.
> 
> All patches were tested on a Cisco Meraki MX60W. Boot and
> Shutdown/Reboot showed no warnings.

This is a 12 year old PowerPC system. Cool you found one. Looks like
OpenWRT still supports it.

	Andrwq

