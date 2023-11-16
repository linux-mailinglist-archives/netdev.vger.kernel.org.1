Return-Path: <netdev+bounces-48488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D64D7EE8EC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB732280ECE
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB1F48CDC;
	Thu, 16 Nov 2023 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wG6aTQmo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852311F
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=h2KjIhMS/J0OK9KkeZPYsqLnxLOcQsBXR16G71ypXvI=; b=wG
	6aTQmo0yM8xRgYmuQovZVZphjvBxB6VQz9XPbj/3fSGow/vFNkY1dRBaalpoFMzqGuyMOFTvzt7n/
	2unDdIDaDktONnqO4D1NDmBQ9cMTvzPTdEU8O15TgiPJ6lakBqA1wxerhbAtO5h9tPqc5CAa5r1cc
	nBRoQaqyERQ3keY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3kDJ-000OHz-U9; Thu, 16 Nov 2023 22:47:53 +0100
Date: Thu, 16 Nov 2023 22:47:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Message-ID: <05c3bdf2-dec6-448b-87e9-1a865ede318a@lunn.ch>
References: <20231116123033.26035-1-oneukum@suse.com>
 <87ttplg9cw.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttplg9cw.fsf@miraculix.mork.no>

On Thu, Nov 16, 2023 at 01:39:59PM +0100, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> 
> > A module parameter to go back to the old behavior
> > is included.
> 
> Is this really required?  If we add it now then we can never get rid of
> it.  Why not try without, and add this back if/when somebody complains
> about the new behaviour?
> 
> I believe there's a fair chance no one will notice or complain.  And we
> have much cleaner code and one module param less.

As Stephen pointed out, module parameters are not really liked in
netdev. I suggest not having it. Post this patch for net-next, and
don't make the commit message sound like it is a fix, otherwise it
might get back ported by the Machine Learning fix spotting bot, which
we probably don't want.

    Andrew

---
pw-bot: cr

