Return-Path: <netdev+bounces-155197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D31A01700
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214223A37D6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82313AD03;
	Sat,  4 Jan 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hYyrzUIY"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D44409;
	Sat,  4 Jan 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736027807; cv=none; b=OhkDSZMiFeBHelyoc1EcA+xThWTa5b+vgJhjIAB/KxLhfg/SMRSLT72EL2YHVlsttqukvG+Dgq5NTw/CtKRW0aCxdWPKNrDzVYekYxwrVz81O4jcQ5NwOBNPBWcEqLYjhQNF+X/V9hcXe2c9IC1smV+H8EPG7SnQKTCrcl44Ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736027807; c=relaxed/simple;
	bh=AaIwfy/YHQ4jZPDt4lYq2AVr6IHr1ugA5GnIUvJ3pQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnqpw+9ztoGy5683Yxfw66XSLLyHyIy4z9330o2qzNt5n4Wl+xzcradUwl4Ke9vMFx4mw9ylk4ap1D8PckK3fuD+ROkPM2RWWSfbTRFAWyj+TNPbrJ4fDe03/nKrOgdqA48JPAVwhWjgUfradx8oFUnordnIkvyeANBy3P5Fi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hYyrzUIY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=rDyIGCWm381fnRVI8R/a4TzePA5+Ap7RWyjo5NA3noY=; b=hYyrzUIYbVjDL+Wj
	qSio0oVT9miCAs/URlnQ/VJ3ykY5RSXd+r45kwZBPDGyvwZRQns9ea5ax/O5QarPfv7AIJTA567kM
	xUoWdj6odJTr9gCWjA6I6hqUyqKgAXQ33AlhwmllP5lkAudt64rGFhEd8kL+VgIXZkT7Wdmia9hi7
	GNkisLlE1VhN49Nn8J6cVOnKj94/YLHK7CfJOHtx94lZFHL3c6MQkNEHIEu+t1SSUG3nE1yfEIXLR
	mnNiBXl9+wWLfT1OwoDHHmqSptX2J4hvBsa23e7f8j+s/1V5a6vCe5zOb0STZdGCUnTvMcLTE2Um2
	JpUIfmzSROi6pYBu/A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tUC89-008BP9-08;
	Sat, 04 Jan 2025 21:56:25 +0000
Date: Sat, 4 Jan 2025 21:56:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <Z3muiBPv30Dsp8m5@gallifrey>
References: <20250102174002.200538-1-linux@treblig.org>
 <20250104081532.3af26fa1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250104081532.3af26fa1@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:53:58 up 241 days,  9:08,  1 user,  load average: 0.00, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu,  2 Jan 2025 17:40:02 +0000 linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> > commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> > 
> > but has remained unused.
> > 
> > The functions it references are still referenced elsewhere.
> > 
> > Remove it.
> 

Hi Jakub,

> This one doesn't apply, reportedly.

Hmm, do you have a link to that report, or to which tree I should try
applying it to.

Dave

> -- 
> pw-bot: cr
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

