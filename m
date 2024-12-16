Return-Path: <netdev+bounces-152316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732459F36AF
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FA1168075
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E972063F2;
	Mon, 16 Dec 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dYpx4nsS"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD952063DD;
	Mon, 16 Dec 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367739; cv=none; b=sOesCBJoSy1pvcaPeEsmHrarCzkrkeu8kkuLSstDjl9N2Cay7pOjnhccmbQYWryMj+KCONRvnqLhOzV5nFe9UpLuBsO7EQdUGxP/gQ4Vi1UxVrwnTfNSoOYRSjbJRJ//orTkic0StjZ0LMi1eQkht3eFE114vi8dOU3rm3MJW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367739; c=relaxed/simple;
	bh=JuLN6r70JiEFAqbOYMC6cXE9GSddTbtWFdm/gA6bkXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Kq976FW2Gc7oEEOlvNbcXNGi1B4YZuiZ8MdkAfdEccHnfXrGAIQT/a+KWYki6cQSYrVp6WWZY05+4OdospVOTLMQ+9PHE7p/slV6lrDn9sde5aV/yDm6CBMZeVrcU00QVX5fSOpMm+2AN/Uft6UrUWrezF+qpE3dZhNer9PNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dYpx4nsS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=bSCpO2J76JpQcMi6ZUQidX2mD5O4Q7+CsZhw9kcFsOw=; b=dYpx4nsS/DcXIfU7
	hWBIW0F1crt6qsIcnU6LstHcOKJwEEAbD0ohqo9MQ7HtXnfZDNIuEWnM/aLBLLRmgrUFwm4P/ikzF
	1m8jfqlhXGkyrIDaT3LBrL+S6GjEDoMOfKbmsdWOYKB/xesABuyCRnajRNs+o3OkckIAQpgAkww2u
	f/1+tRwbhgpQgnCXy8HePWq0gTfMFAxE9fEHBfKHmjnHzdYVJELV8aYCRfoM6gowOCpC/sx2kd5dO
	na72ZXa926LcNfEM6IytjCRZBaUsYrh5mUAy8aMBPoi2sndMLDV/nv7v7wo1h/VSdyTxUJy4JGazI
	RrBZ5KwAeZHjYGubMg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tNEGz-005fBa-1v;
	Mon, 16 Dec 2024 16:48:45 +0000
Date: Mon, 16 Dec 2024 16:48:45 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hippi@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Message-ID: <Z2BZ7d1ojV5Gbdu1@gallifrey>
References: <20241215022618.181756-1-linux@treblig.org>
 <20241216161206.GF780307@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241216161206.GF780307@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:44:11 up 222 days,  3:58,  1 user,  load average: 0.04, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Simon Horman (horms@kernel.org) wrote:
> On Sun, Dec 15, 2024 at 02:26:18AM +0000, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > hippi_neigh_setup_dev() has been unused since
> > commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS")
> > 
> > Remove it.
> > 
> > (I'm a little suspicious it's the only setup call removed
> > by that previous commit?)
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Hi David,
> 
> There is a dangling comment referring to hippi_neigh_setup_dev
> in hippi_setup().
> 
> 	/*
> 	 * HIPPI doesn't support broadcast+multicast and we only use
> 	 * static ARP tables. ARP is disabled by hippi_neigh_setup_dev.
> 	 */
> 
> Could you fix that up too?

I saw that, and it raised the suspicion that I mentioned in the
commit message; is that code relying on the uncalled, removed
function to disable ARPs?

Dave

> pw-bot: changes-requested
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

