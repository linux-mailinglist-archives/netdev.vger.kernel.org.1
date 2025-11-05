Return-Path: <netdev+bounces-235796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DEC35CE2
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67CE24E76D4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326631CA7E;
	Wed,  5 Nov 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ncdGqJhk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456531D362;
	Wed,  5 Nov 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348872; cv=none; b=KUjyMcJYr1a4X4qGQDUsNbjXsD2aBUQdcGNu2mZCIaXB3x7RDPzO4lcJNrTRIRy4Qo/qYmCcwtVvfg3ULfG4exkvarKGfbX7iikqEkUUcZAUUPH/5IqCTYaquJEkKTAzJ07nbhAO7uDxAf1LPEhKmG8vdbFtHo7S2EBjay0i/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348872; c=relaxed/simple;
	bh=o5m/BgT+CLLta6IIQi0NDjRSxYzIHuFhf9FXQjKJqsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+T5J0m2KdffKwUXuwvb7rXdpFGgSdfabYtd/DAwsgrCXH9li6IMxoq1Wb+wj0bQBu8C41JMD86Gjd+3p6/5aDlFu7P6rA8PGNUeKV0Nk/RT2HkzXigwCwEJxl4p0p1SJuORkFIuKrmrNW6wPtKjUorjmVOFUkTcIG70t+nPfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ncdGqJhk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n2ftvDFaNKu3PV0gvMROlDobM/rsO8FfbTNJXo4q7oU=; b=ncdGqJhkUD86UBjzI66zO+L3UO
	Ejf4lR5budRHvMhoQxAnpyMOTnjxReJxs0ILoouTU2WOY7Ry2YtlQc8WYina+ZNifSw7pAGZhlKZP
	9vEELqULrcoRuXkB0WzeKVfzlNML2z1DUxwoRNtVccRJ1uR1zGCpJn/Zu0eW6Pp4mjGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGdRU-00D040-6l; Wed, 05 Nov 2025 14:20:52 +0100
Date: Wed, 5 Nov 2025 14:20:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chang Junzheng <guagua210311@qq.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: broadcom: bgmac: add SPDX license
 identifier
Message-ID: <eb006531-4c4a-4dce-a3ba-aeffddf8fcad@lunn.ch>
References: <tencent_DCA505773DEBA2EC5F3B04526C606AD6A608@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DCA505773DEBA2EC5F3B04526C606AD6A608@qq.com>

On Wed, Nov 05, 2025 at 07:28:20PM +0800, Chang Junzheng wrote:
> Add missing SPDX-License-Identifier tag to bgmac-bcma.c.
> 
> The license is GPL-2.0 as indicated by the existing license text
> in the file.

It is normal to remove such license text when adding an SPDX header.

Please also read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

