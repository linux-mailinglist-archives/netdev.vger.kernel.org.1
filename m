Return-Path: <netdev+bounces-80318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB687E552
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D711C215AE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283528DC8;
	Mon, 18 Mar 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="FFD4Y80K"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535D28DC0
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752351; cv=none; b=oeQBkDZWQLxBF+NtVObIq90vVGUuuUNtiwvgwcDOg2hilBNdZ+WIHsg2c/SP+N//wMfAgaL1wIXbOoGbzDZtVQ+RFjekxyt65UbCQCS9Vbt+P9kjoUA7kujWzX5A2Dh5ux3UCnFfU5KWi9GhV8U8lFWOtpWrQrWo5cH72hWnn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752351; c=relaxed/simple;
	bh=gUPtHNaTjjrgzhJSAO13RvvjHPsrVucDphivXeW1Loo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7bJcHGGIUCGf63Bi3jMG+fS7BJvh6v1JL0SZ/K+FyyqkkGKt+yyopxyYI5JsLTl79YzkoAarl9wUK4R5amgYLPQ5cBeAsUXy92XSin3VchpmuwIueZMDiFIFZlJVewdSkBwmVvxYN9FRwp5owxZ1RVaey3PzARmiDAtMJFsAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=FFD4Y80K; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 8B350602BD;
	Mon, 18 Mar 2024 09:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710752346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QirQLJx2d+KteBd6/8Nubx7x3MW7CchJFXgEugvdZ7E=;
	b=FFD4Y80K0nZQEaPowfV2khFKB0ty95DiTiwUCh+I+Yy60mmtZsh2t1T++WNCFCuEuYs/Sl
	br3j3n73Lq3WppYkPubmaoM0TM+5w0OCm01AW1g9mcJPdxaO4CHuGiEC0+s6M6FT7GOLAk
	f99l52Xme7axcjIYMXazzPQeZ+juMDa5ecGyxHMCVowRXdpik5aVY7T/a1YCzyoT0N1DCs
	UYFUImNUL94JQqmfYmf+DJ202bij9KTLAcxSh8rNec/T07I+BPiTha6vjgPqzUc0NgckVu
	3QrkibEPktDXIlnGa8xzqXaBpiRbGUGZleViZc+Xym3N6Q8EjUlwolre0S3cLA==
Date: Mon, 18 Mar 2024 09:59:16 +0100
From: Max Gautier <mg@max.gautier.name>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create
 /var/lib/arpd on first use
Message-ID: <ZfgCZNjlYrj5-rJz@framework>
References: <20240316091026.11164-1-mg@max.gautier.name>
 <20240317090134.4219-1-mg@max.gautier.name>
 <20240318025613.GA1312561@maili.marvell.com>
 <Zff9ReznTN4h-Jrh@framework>
 <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1918B6880C90E045C219B9ADD32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>

On Mon, Mar 18, 2024 at 08:51:40AM +0000, Ratheesh Kannoth wrote:
> > From: Max Gautier <mg@max.gautier.name>
> > Sent: Monday, March 18, 2024 2:07 PM
> > To: Ratheesh Kannoth <rkannoth@marvell.com>
> > Cc: netdev@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH iproute2-next v2] arpd: create /var/lib/arpd
> > on first use
> 
> > > > +	if (strcmp(default_dbname, dbname) == 0
> > > > +			&& mkdir(ARPDDIR, 0755) != 0
> > > > +			&& errno != EEXIST
> > > why do you need errno != EEXIST case ? mkdir() will return error in this case
> > as well.
> > 
> > EEXIST is not an error in this case: if the default location already exist, all is
> > good. mkdir would still return -1 in this case, so we need to exclude it
> > manually.
> 
> ACK. IMO, it would make a more readable code if you consider splitting the "if" loop. 

Something like this ? I tend to pack conditions unless branching is
necessary, but no problem if this form is preferred.

if (strcmp(default_dbname, dbname) == 0) {
    if (mkdir(ARPDDIR, 0755) != 0 && errno != EEXIST) {
   ...
   }
}

> 
> 
>   
> > 
> > > > +			) {
> > > > +		perror("create_db_dir");
> > > > +		exit(-1);
> > > > +	}
> > > > +
> > > >  	dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH,
> > NULL);
> > > >  	if (dbase == NULL) {
> > > >  		perror("db_open");
> > > > --
> > > > 2.44.0
> > > >
> > 
> > --
> > Max Gautier

-- 
Max Gautier

