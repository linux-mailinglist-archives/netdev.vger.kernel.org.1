Return-Path: <netdev+bounces-79302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87434878AC1
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2534F1F21DF7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18D54736;
	Mon, 11 Mar 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="zb+vy165"
X-Original-To: netdev@vger.kernel.org
Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A52125CE
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196239; cv=none; b=kRr2d0H96Kg+IUdWwN5ifMll2Vp8elc5yexAuwwFgsFc5yUlUdJmUJcNt6Mc3nzoebmIxEkfVveiCTm2H81K6DCDlBXb+BDyxvN7I49jTbHrT/lFeGnLRecIYEk5r+tF5kX+8HB0UKFNgSUrXrj4II41+wuVCRQzhl83YAfOSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196239; c=relaxed/simple;
	bh=1mRfN5k5UQO5um5QUdO3+MzyJKPm0w+3onfS79A/tgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gm1NEaULobeb82AULPX12DG1Pk+FXBcyrj2ndC1xfK+FXXV6CXrbwL00Zjg4VFXwaJDtvukDF8tEqoQXj4A2E6nGpBs6L/k1UUdB2EQfalv2QZ70u4Zhgd35uQriFeEvt7WNcbwDbpDe83p43mp6PiHlmRw+gWqfCNcPUhR34Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=zb+vy165; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 2CAAA60260;
	Mon, 11 Mar 2024 23:30:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710196234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nR6ZuzHevSLrrSe9pqAjXycStXW5X84qRUQjm2nTePU=;
	b=zb+vy165QOQyiW1DGyo+lV3KgcYKH9Gv9Xo4X88hXL4aeMI0NZ2tnDbLUNgNq1QQa9AVbE
	KYqf7sRTim4c/eyxechAZxv8mI7+TeqEEruYCtQuZvPoxpEW0jn6Z5+jkcg6oMVpRz3mCt
	JG76no2bYHf+A5GmPAPf4G2wXGclToAe5PnaH637qJNe2s6nsdKFXe4DOs5MTR+I0lULwM
	5n7KE2ijdxqkAd5wkrTomRbCZxRg2lUrMXD4rSRNfjABznVDw9kWrEGEobEEsl51L5+TsM
	qFMOlWrchmoNCl8RDEXmNEBB6cbiFuAAuWacQVZFJXCKJupj3LNNK6UZgr4x4w==
Date: Mon, 11 Mar 2024 23:28:31 +0100
From: Max Gautier <mg@max.gautier.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <Ze-Fj2RwYnM0WgWi@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
 <20240311124003.583053a6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311124003.583053a6@hermes.local>

On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:
> On Mon, 11 Mar 2024 17:57:27 +0100
> Max Gautier <mg@max.gautier.name> wrote:
> 
> > Only apply on systemd systems (detected in the configure script).
> > The motivation is to build distributions packages without /var to go
> > towards stateless systems, see link below (TL;DR: provisionning anything
> > outside of /usr on boot).
> > 
> > The feature flag can be overridden on make invocation:
> > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > 
> > Links: https://0pointer.net/blog/projects/stateless.html
> 
> Why does arpd need such hand holding, it is rarely used, maybe should just not be built.

The commit introducing the install of that directory is quite old

> commit e48f73d6a5e90d2f883e15ccedf4f53d26bb6e74
> Author: Olaf Rempel <razzor@kopf-tisch.de>
> Date:   Wed Nov 9 15:25:40 2005 +0100
> 
>     iproute2-2.6.14-051107: missing arpd directory
>     
>     arpd requires a directory (/var/lib/arpd/) to run.
>     see attached patch, which lets iproute create this directroy during install.

For the why, arpd.c, L.671:

dbase = dbopen(dbname, O_CREAT|O_RDWR, 0644, DB_HASH, NULL);
if (dbase == NULL) {
    perror("db_open");
    exit(-1);
}

You think arpd should create its directory itself if it does not exists
?

-- 
Max Gautier

