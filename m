Return-Path: <netdev+bounces-65769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA583BA41
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BBCB22866
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12BC150;
	Thu, 25 Jan 2024 06:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail2.pod.cz (mail2.pod.cz [213.155.227.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E31097D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.155.227.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165274; cv=none; b=WCK43jauQpQZ784TL6LF9xnes/E9s/tQsYqA5/zS2VrbRU6mAb5KGj/0fq6zp1P0kcQM+CtV8AHsOooiPGYOhVwVhLy3QPtFVLCkuLmx3aFSdDnXUwpAYNvjJK9/5DvGgn1/72dBJ7rMs6Ufql8e00o0ah6j6Pi2UEiSLt6SyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165274; c=relaxed/simple;
	bh=4yqtt2dj3w5VJTHvhvAclLySsjYHlQvTJ9xYBH2HHFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFGR6hN3kz7HIt9rad7q6dBDlASHCnS6SFdTIGD7f0hj8jSAh/4fcoj8GjWk6fFZsG9icoEJGQcqg7VX+rAahqeA3rp0dslXnMctB5+ancsYpX5ZEJeY4TNDW1bQFDpXmYtnv1kf1v84scePiazU2BGBN1nmSZSYF8X2TlTbeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samel.cz; spf=pass smtp.mailfrom=samel.cz; arc=none smtp.client-ip=213.155.227.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samel.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samel.cz
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: dsahern@gmail.com
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: kuba@kernel.org
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-From: vitezslav@samel.cz
X-Envelope-To: heng.guo@windriver.com
Received: from pc11.op.pod.cz (pc11.op.pod.cz [IPv6:2001:718:1008:3::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384
	 client-signature ECDSA (P-384) client-digest SHA384)
	(Client CN "pc11.op.pod.cz", Issuer "Povodi Odry - mail CA" (verified OK))
	by mail.ov.pod.cz (Postfix) with ESMTPS id 4TLBGN68h3zHnWh;
	Thu, 25 Jan 2024 07:47:40 +0100 (CET)
Received: by pc11.op.pod.cz (Postfix, from userid 475)
	id 4TLBGN4l8Zz6yYZ; Thu, 25 Jan 2024 07:47:40 +0100 (CET)
Date: Thu, 25 Jan 2024 07:47:40 +0100
From: Vitezslav Samel <vitezslav@samel.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: heng guo <heng.guo@windriver.com>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: [6.6.x REGRESSION][BISECTED] dev_snmp6: broken Ip6OutOctets
 accounting for forwarded IPv6 packets
Message-ID: <ZbIEDFETblTqqCWm@pc11.op.pod.cz>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>,
	heng guo <heng.guo@windriver.com>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
 <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
 <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
 <20240124174652.670af8d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124174652.670af8d9@kernel.org>

On Wed, Jan 24, 2024 at 17:46:52 -0800, Jakub Kicinski wrote:
> On Thu, 25 Jan 2024 08:37:11 +0800 heng guo wrote:
> > >> Heng Guo, David, any thoughts on this? Revert?  
> > > Revert is best; Heng Guo can revisit the math and try again.
> > >
> > > The patch in question basically negated IPSTATS_MIB_OUTOCTETS; I see it
> > > shown in proc but never bumped in the datapath.  
> > [HG]: Yes please revert it. I verified the patch on ipv4, seems I should 
> > not touch the codes to ipv6. Sorry for it.
> 
> Would you mind sending a patch with a revert, explaining the situation,
> the right Fixes tag and a link to Vitezslav's report?

  I took a look at current master and found that there is yet another
commit since 6.6.x which touches this area: commit b4a11b2033b7 by Heng Guo
("net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams"). It went
in v6.7-rc1.

  I will test current master this afternoon and report back.

	Vita

