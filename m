Return-Path: <netdev+bounces-136152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD679A0903
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BA91C220D5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AB207A00;
	Wed, 16 Oct 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zeXNAsO5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C0206059
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080447; cv=none; b=Mq9wBT2BDaT4W+ygaEbSBWnYBVmepmBQC0X8aukuV0HhjEobwapxLooOh+DlmQgK6kPhg2310EL8HzFzBmJsU3KunnY4K2LM4m7mA8j7vs2XaaWC213qc/AV7tHsK4v7yiK/buBqOPdWujALyBMgGUkQebNRBJpIUQKwJuy6IbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080447; c=relaxed/simple;
	bh=CNA+rrqvHnJ+3+hFopPrzg/XLoYHKe3OuRa/GkHwpd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/wkOkE1rKLntMnCAj8WnbgkNavNO2tdTeSX6pGKaipYk6E9VT3E3RIlUJ0wsEu1UbhwppdP+YhfheNeL3usYRS+tU6dLl37rWX/8rcIR30EcVSjOXmYFtp5OMu4bA9ojlb25hMYh5E7enU6GHrFLrjTEd1oWCgRkt8NAXoLQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zeXNAsO5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AyrRTXlpXztqsRkc5xugOet+IiGicHEz75aWLE+zJvw=; b=ze
	XNAsO53PBH80Lj5jYkrYV5wsFpH4x80fWHRXTNl5wO/x63OTmpDwngVSW67UL5vDWG3+JU1LmsHqq
	Svp+h22gLTu3laEqCvxAwtJMf5rLU31WJ8RcZgDFq4AclwCySuzfD0aFHYbExB6VbO/z++LVdO4EG
	eDHexA9Pje4hayU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t12oB-00A9J1-Oc; Wed, 16 Oct 2024 14:07:19 +0200
Date: Wed, 16 Oct 2024 14:07:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, idosch@nvidia.com,
	danieller@nvidia.com
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
Message-ID: <3201b332-ce52-41c5-8743-a2122ae2a8f7@lunn.ch>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
 <816b36d3-7e12-4b58-8b99-4e477e76372c@lunn.ch>
 <51205a15-762c-43b6-8df1-0cbfe2380108@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51205a15-762c-43b6-8df1-0cbfe2380108@gmail.com>

On Tue, Oct 15, 2024 at 08:42:29PM -0400, Daniel Zahka wrote:
> 
> On 10/15/24 7:16 PM, Andrew Lunn wrote:
> > > Vendor PN                                 : QDD-400G-XDR4
> > >      "vendor_name" : [65, 114, 105, 115, 116, 97, 32, 78, 101, 116, 119, 111,
> > > 114, 107, 115, 32],
> > >      "vendor_pn" : [81, 68, 68, 45, 52, 48, 48, 71, 45, 88, 68, 82, 52],
> > >      "vendor_sn" : [88, 75, 84, 50, 52, 50, 50, 49, 49, 52, 56, 49],
> > Why use byte arrays? String, maybe UTF-8, would be more natural.
> > 
> > 	Andrew
> 
> Ah, I mistakenly thought that the "-" characters in the vendor pn were put
> there by ethtool in place of non-printable characters, but I see now that
> those are just regular ASCII hyphens. The CMIS spec says that the four
> vendor_* fields all contain ASCII characters, but can possibly be all null
> characters.

It would be best to assume vendors ignore the CMIS spec and put in
characters outside of the ASCII range. I imaging GPON and cheap fibre
modules mess this up. So it seems safer to assume it is UTF-8. The
JSON format should handle that.

	Andrew

