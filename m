Return-Path: <netdev+bounces-153522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB13F9F87E6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B421898655
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC601C5F30;
	Thu, 19 Dec 2024 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5PkR9hQp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11B1BDABE
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647569; cv=none; b=p9HoZ32M49VKBrXkTSVyxbSD0Tjhm5ql4tI+DCAn1B3QVnja+F04FpmzfP1SXEmmOFKRvMnrni7mvIx3ZlriehO+9KrphjGG60ZT0XDVOd31uZTDEylh1BHuGFLyqWoYhT3N6rzJMapAbFjDYlLPOB5d1/EGW5CcrxHJSEgQb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647569; c=relaxed/simple;
	bh=KerXWWshCR+Jgvvpj6V4Fj/9DHRA+7IXWE8FjbOCdlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXHJRd5KDslFkIPxwmvMMfHMtJLPPhRN1zek6SAVhW7swLZLoCPiQlc83a0wdjrUWeb0UgSsBwONR9pf/N/q0q8N+KPJp/oG6QYnZLL+syVhh04M2FWS8eXswiOSMOq0WUxOdfkRtK1nM+toADSVhPTsCQw41R5//tcrj0jIkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5PkR9hQp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Aqv2p2QDVXA6x+5jJGOvu5Usc1awCXk0UhAR9dJFtq4=; b=5PkR9hQpwoOYwCMYZyIvK0swHz
	qWJc1crngACn8LVMTiA929jwgwEWpHdiXYSYzYXwZWxLLV8rrfgoXY/RO6NnAixXMQUJoxkHBbKI/
	EedmbS92TpNdKFqoJMHEiRgNIuyUpHruda66AX/Tdq8b+bZtdfKs39Eh+5X0UONsWNwU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOP4V-001mRY-IW; Thu, 19 Dec 2024 23:32:43 +0100
Date: Thu, 19 Dec 2024 23:32:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API
 for Homa
Message-ID: <781ea004-6422-470e-a7b5-9a25d602f9f9@lunn.ch>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
 <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>

> > --
> > pw-bot: cr
> 
> I'm not sure what "pw-bot: cr" means; I assume this is related to the
> "#ifdef __cplusplus" discussion above?

It is documented here:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

although the documentation spells it out in full, but the patchworks
bot understands a few abbreviations like cr for change-request.

Marking a patchset as changes-requested will drop it out of the list
of patches waiting to be merged, so included it at the end of a review
comment can save the Maintainers some time.

	Andrew

