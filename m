Return-Path: <netdev+bounces-69676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247984C250
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F311C2172C
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCA8BF0;
	Wed,  7 Feb 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0Pyx5a0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B101095C;
	Wed,  7 Feb 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272133; cv=none; b=X1eIakDgx8tXQVzUT61/DjSRdplKq/fgF+YuokTJHJ4Aqg/ozot8XfioXKqUmv/Z8NRPN5v09PEkub4CEIedBHWSzno6F6eFsd40NVq49PrlCAiiWEqyJYtJ7bU93Ky0oTcupqsvkoACr4D62P5Ibled56rLQCGPYhJ7fGMdqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272133; c=relaxed/simple;
	bh=CSGxB/cNBBAm7FVZIx2mavmDuz/5wu8SAcGEfLmC+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fydd4aAvWZi6I7zDmC2/xCAPhpeNBuWjl+MhLAH13EZ04R1KanBzzzPqOEMRJSsIdyTPuf5IP6+BiL4uk0uoES5x1N5v3hHk7M233RcSH7UUwx2ulEzE1+nCE/W5FkSA+1MPIgdQQqz7zPX95UlG+t61c9SDgA6GbV9UHtKMmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0Pyx5a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08DCC433F1;
	Wed,  7 Feb 2024 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707272133;
	bh=CSGxB/cNBBAm7FVZIx2mavmDuz/5wu8SAcGEfLmC+AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0Pyx5a0ZYEmuPDRtoIpybQ7t74VD+/8Pg3580RzAZ+BDH5tWwXgsamTD+MeM5Qor
	 C2rTVit3L8iyqSgMsNtHWZlh11iCEuYuO/xoV5014vPmNpv97tTkKweIqLuyxLVf75
	 8X+v4wk9r3GX04NenjGeeU+TSFss5RqixwU6AOwEr6L35KS2B8LvcwrTdQdxEuMZ2w
	 5k9Tb/YW4LXcf8oPnOa6JGPRJ3b/cUBv2aPMpCiFDn5i2mtoQxXrcyLaqhSIvQRROA
	 +yHBpuiCRS4WpLywSWHGs/lmIuUuhY2Grf7lu+2d3mctJyuO3LOBfWzdwGIgGNvW65
	 E9jFRnXP2888A==
Date: Tue, 6 Feb 2024 18:15:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth 2024-02-02
Message-ID: <20240206181531.412503fd@kernel.org>
In-Reply-To: <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
	<f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
	<CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 09:45:44 -0500 Luiz Augusto von Dentz wrote:
> > >  - hci_bcm4377: do not mark valid bd_addr as invalid
> > >  - hci_sync: Check the correct flag before starting a scan
> > >  - Enforce validation on max value of connection interval  
> >
> > and this one ^^^  
> 
> Ok, do you use any tools to capture these? checkpatch at least didn't
> capture anything for me.

You should use Greg's version directly:

https://raw.githubusercontent.com/gregkh/gregkh-linux/master/work/scripts/verify_fixes.sh

it has an ancestry check which should catch rebases.

