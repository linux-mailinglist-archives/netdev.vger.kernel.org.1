Return-Path: <netdev+bounces-154264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B499FC633
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9521881BC8
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0295F12C499;
	Wed, 25 Dec 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FkrMXA/h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF99C133
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735149189; cv=none; b=Z3cFExUi+ybAfpaKkBDAmKIyS8yv7JcsWa/HaChux5koXbDR8W8hB/2CNpSkqhyO8bpTlaEYai+Q5OKbogw+Da1VojajPRoUegougo24YwKD6K8kBOMvFb0dDbwPg5a8sVqflGqYwesEJN5bIac9Kyz5l7SC1tMXT47P9Cqomkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735149189; c=relaxed/simple;
	bh=JGaEtHAkFKbnYFHAlENjjiYKxBIdJOlKYnzRLPpy0jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRxKMOuK402oHgr27y0t8JTbq+MEto4eOnsrl32+VB61FBOCS2tJ3zgQnt19ajHnaPXwJQH3sIXU6VVNKRJY7MFqtDzy5/NG6FuXnLWCkJz/jjwH6jEEVLpAdkDNlVFGar4hgOvfd10h+GK/GRp6dc6IcPUQG06NoJLSx1s8MIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FkrMXA/h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4Pj9gMa6ICN7xJkTvEpvpy3InrjyJVr+bZ/N7lw5OUs=; b=FkrMXA/hADlsNlmcI0UXBZthiL
	wGXDVDDNReQVYGy7HOgHw34wp6VfCvgbtG63x1iuwcpatgwCqGgMKDlSjTTU2wZm5mGAqK6B9IEAs
	G4iTEtVgb+Qou7VJyuuVEdW2rvEfxK7g2GAeA5DKAJpb/CnVTPEmnAEBsWBNerJD9LtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tQVZC-00GA7D-Id; Wed, 25 Dec 2024 18:53:06 +0100
Date: Wed, 25 Dec 2024 18:53:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: sai kumar <skmr537@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
Message-ID: <25d02ea3-02f3-4699-99eb-ac49aef917e6@lunn.ch>
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>

On Tue, Dec 24, 2024 at 03:00:17PM +0530, sai kumar wrote:
> Hi Team,
> 
> This could be basic question related to DSA, if possible please help
> to share your feedback,. Thanks.
> 
> 
> External CPU eth1 ---RGMII---- Switch Port 0 (cpu port)

How do you have your RGMII delays configured?

    Andrew

