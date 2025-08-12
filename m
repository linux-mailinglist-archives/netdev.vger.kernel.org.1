Return-Path: <netdev+bounces-213051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F375B22FFA
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC02684CBF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773B2FDC55;
	Tue, 12 Aug 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKP10U2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7B2F7477;
	Tue, 12 Aug 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020723; cv=none; b=QP6SR8Y2QRiMqKDp7trqWDSJKjD2Fe1s8ZmB3WmMTZf95vakiHDv0rvd07Hmzwvahly8x+pQxtqnSfBKo+hEt/HFA3oPnvDfaFFT5Dr12JgS0cNxKJ9d139TXe2LD8PCiTA+adidu/obG0jbj8BcSwJo7QXEA/ILqoJJZEiDCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020723; c=relaxed/simple;
	bh=d4efG2JRLWbONsXvpjKG6CoHDWqxvYY1curoa8uXQUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDRE2IhGCsFeOE9TqZAExRuVhJYy0kZC1grwrKJ0sDBHNn3Tirqy5eLTShESqaogKEriUA4WF24MwKGkCtaOVOXcZGFtjG2T+4oSujeZ6h+9400c2DTZ+ZYntWFxuckHxUzEUgdHOnjkSgfyEUSC/UO8fZRds+feDlvhFIyI79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKP10U2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77792C4CEF0;
	Tue, 12 Aug 2025 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755020721;
	bh=d4efG2JRLWbONsXvpjKG6CoHDWqxvYY1curoa8uXQUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YKP10U2zHy/HpbQlRsRHL7EJInwGkfVaY6+IVXT4F01OsGzHyochdk0Zo84yGmH5h
	 zTFQoakX+2ftmw4XXGP4oHawPqthvofL7L/1N9R05eKBBmwmITEaOSbUZyYGncSWj3
	 ONQg9rqkX2MlpeI7mrblt96VJdzFZ+D0IEQCkjcQoR4dPAavvrN3vh0DcRwgRZujL9
	 K2zN509UESRF0FJE8IXimRiYn+HQ3/R2mNKQHa/DnxHjHWQN5P3C28Cygg8hSLq0II
	 9g/wcZU2bqP68mpyfz63eq8n4nOCROAPlZAS+Dh79RZ57I8uyLERcNW7iSz+MlFoQG
	 uONs0wCxqM8LA==
Date: Tue, 12 Aug 2025 10:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Daniel Golle
 <daniel@makrotopia.org>
Cc: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org, Sean
 Anderson <sean.anderson@linux.dev>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [ANN] netdev call - Aug 12th
Message-ID: <20250812104520.33883938@kernel.org>
In-Reply-To: <aJt2mg4vxRHSvDTi@shell.armlinux.org.uk>
References: <20250812075510.3eacb700@kernel.org>
	<aJtvp27gAVz-QSuq@shell.armlinux.org.uk>
	<aJtycOgN-QL7ffUC@pidgin.makrotopia.org>
	<aJt2mg4vxRHSvDTi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 18:15:06 +0100 Russell King (Oracle) wrote:
> > > Only just seen this. Apparently, this is 4:30pm UK time, which was over
> > > an hour ago.  
> > 
> > I was also confused by the date in the subject (August 12th) and the mail
> > body saying "tomorrow" which is the 13th...
> > So tomorrow (13th of August) it is?  

Ugh, I need to automate these emails. It was today.

> Hmm, if it's tomorrow, I can only spare the first 30 minutes up to 5pm
> BST.

But I'm more than happy to open the room for you whenever you decide to
meet.

