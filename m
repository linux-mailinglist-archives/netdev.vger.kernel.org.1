Return-Path: <netdev+bounces-80327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4787E5BE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025C4281D40
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E32C19C;
	Mon, 18 Mar 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="qEoeURrd"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C92C848
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754001; cv=none; b=OLdXTaCIRolllswl33jygZ9HomAjt/WP0R3rz5iBJRu+O5Q22Hc0GaghvJH2ROZ1KyQDbvFd1hs0F4QkaTg+l8b2N3S4H/1EghYyXQq+JH+Ghjv9YLkYrFks0HeSJ5qh4jEzJLPtpuC9L4CV9T6ADNXl3hfK5VBSnJu4km0RfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754001; c=relaxed/simple;
	bh=Z4a1RpMfDza/YkJd2F9IESbcl9JEVKFO0de2R1TjqAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHYH2PCBhJxVHRMg+b1OzoNj0QdlFQWTtijlzVYJEdXfBh6FkBsRg15IxhEkgXkr8Ao9U02dkcsLmHDHpoXK15rctn08GpNIfSHGarFB03U5/4VF7dzNsGMZZZWnx1mbkcIEaPaWhK3g6mnMR4IdrUVoA/ad4yto7XylnweC8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=qEoeURrd; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 84404602BD;
	Mon, 18 Mar 2024 10:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710753997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wYnnBG7TuTQKoZxNuOfj1wYN5EUYoP7RjJIjY9Mohs=;
	b=qEoeURrdGSVO65TYEQGcJ6UpTCUjMHO19Jbo3VsiwVjU/LCKOzJyWB2sJvYN+aQdY7pNt0
	lGNEVh10kyJEvyc+zTT+AkqdJUAWGxRa30LD6rYKB6IdHPgnm8bOSUAehnfA2JUcmejcUF
	3EXpGPS3kPB+80aAgwNxgCYZDM2VT72JOOtnzIPsLAIn1NeB57A7DAm+kSTgkCfHdyIeR7
	ValfNQlhBPUqo5Zb+gJMayo0PeuI0EJeXHCUcjH9vmMGIavgIKHhXbMkfupAg8rUrEg9Xi
	85Akno6Plg/loTiGKIRdiXK/FFYfsv89hsKotlHw6BXJxE/gDydSSz4m+agb5w==
Date: Mon, 18 Mar 2024 10:26:48 +0100
From: Max Gautier <mg@max.gautier.name>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Message-ID: <ZfgI2Aow6751-EGj@framework>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com>
 <Zff9ReznTN4h-Jrh@framework>
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <ZfgCZNjlYrj5-rJz@framework>
 <MWHPR1801MB191828A6FF7D83103C75ED6AD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB191828A6FF7D83103C75ED6AD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>

On Mon, Mar 18, 2024 at 09:18:59AM +0000, Ratheesh Kannoth wrote:
> > > > > > +	if (strcmp(default_dbname, dbname) == 0
> > > > > > +			&& mkdir(ARPDDIR, 0755) != 0
> > > > > > +			&& errno != EEXIST
> > > > > why do you need errno != EEXIST case ? mkdir() will return error
> > > > > in this case
> > > > as well.
> > > >
> > > > EEXIST is not an error in this case: if the default location already
> > > > exist, all is good. mkdir would still return -1 in this case, so we
> > > > need to exclude it manually.
> > >
> > > ACK. IMO, it would make a more readable code if you consider splitting the
> > "if" loop.
> > 
> > Something like this ? I tend to pack conditions unless branching is necessary,
> > but no problem if this form is preferred.
> > 
> > if (strcmp(default_dbname, dbname) == 0) {
> >     if (mkdir(ARPDDIR, 0755) != 0 && errno != EEXIST) {
> >    ...
> >    }
> > }
> ACK.   
> instead of errno != EXIST ,  you may consider stat() before mkdir() call. Just my way thinking(please ignore it, if you don't like). 
> My thinking is --> you need to execute mkdir () only first time, second time onwards, stat() call will return 0.

That's racy: we can stat and have a non existing folder, then have
another arpd instance (or anything else, really) create the directory,
and we would hit EEXIST anyway when we call mkdir.
Also, that needs two syscalls instead of one.

-- 
Max Gautier

