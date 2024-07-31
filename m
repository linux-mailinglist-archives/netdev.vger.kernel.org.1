Return-Path: <netdev+bounces-114543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F9942DBA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE331F2471E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7341AE843;
	Wed, 31 Jul 2024 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="297NJZde"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62171AD416;
	Wed, 31 Jul 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427595; cv=none; b=u2uzu4JJYoeS7LTCIqwWW4JjKgSIgfteVgniuvOf5khUa8dqBfMXB38zZDXzDNP+qxs75CYzwLM5OgS3kFXPQ1ZCtRQc56D7f+fzHj072S53PEnJhhEdsiqLqMH8zbft3Dfmc3M2lZkEIJxSC0RWRwjjyJHl/cYgnz2oEcppBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427595; c=relaxed/simple;
	bh=xQ5uFdveBYSrZZtYB25LvEIRd4lVKGB/h6NBGVynsAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQNHt0OcvtJSC/E5+wBkBfixqWabJEVizGoi/2/BRImP/GHdI8JM/om5U71FkDkF5f019YFqYGsZnjLGgCvgDIy3aj8vEAQ7RJJ0/62swNkSZEh0bzq0tnPBmbi5RSjSYPx3zIo6W95RlHz4Pru2w7R/a+sOka7YnmKPIIiTWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=297NJZde; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Lp1GA2p+njuqBP0rkVADaxa0iAs1ALcPIoI3TenDyA=; b=297NJZdesXFWqfqgcPKsGKIaXn
	Xdzoh0GLtMkrWqtdK7gOwLC64kNPkvpMTx69xhOZlQLmVTTX7pjSDB5Cp4uwXstPINW+SuXD1Jfd6
	gHjkeAEQhq/ghGtYKDIU0Moza4bRDh+wRfhuQ7oiD7fXWMD6AieyLECcBaTMEX4yUEW8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ865-003faz-W7; Wed, 31 Jul 2024 14:06:26 +0200
Date: Wed, 31 Jul 2024 14:06:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next v2 3/4] net: axienet: remove unnecessary
 ftrace-like logging
Message-ID: <ac4c3f0e-1d1e-464e-9243-efa08e4b047b@lunn.ch>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1722417367-4113948-4-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722417367-4113948-4-git-send-email-radhey.shyam.pandey@amd.com>

On Wed, Jul 31, 2024 at 02:46:06PM +0530, Radhey Shyam Pandey wrote:
> remove unnecessary ftrace-like logging. Also fixes below
> checkpatch WARNING.
> 
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> +       dev_dbg(&ndev->dev, "%s\n", __func__);
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

