Return-Path: <netdev+bounces-196890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8EFAD6D7D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCF918837BC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F922DFE8;
	Thu, 12 Jun 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWBCFIlN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3E1FBCB0;
	Thu, 12 Jun 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723737; cv=none; b=Z5QdhXp2UBU7x0FAFH+Lo66n6W+2SoJpik1ZX1U0OLTJW07nDbCG6tZer//GpO+0VEOCPa+MvA3tkR4Liyo9pL4/xDlz4o0H56bEhiBjN98t6NbettD6wRv6tnV2gmkZXWnxOVsZstffzggLifEkX1DZ4e1zG0BwZdX1YWQwyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723737; c=relaxed/simple;
	bh=WBpdmufKnBDk9rZeG5lCMO14K4uhYDEUZ+4wHENjVl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVE7rI7JmQrEYq+Oj5WdVoMgOOsv3gzeqUFBIONPc0V/p7GiK4YR7ZIqwe5qTjcgqwuheDF5Phwimjj9/nyZgtkWzq8yJPRn3c4HU+dzpDDF4tj73DKeMu+srrrzv6V2oshX7zeb4Uo5bqEy2MjQV/VIqeyOTUQ1dQRhjmEC4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWBCFIlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48742C4CEEA;
	Thu, 12 Jun 2025 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749723737;
	bh=WBpdmufKnBDk9rZeG5lCMO14K4uhYDEUZ+4wHENjVl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWBCFIlNQKFj9pJ/kPjaY9tZO8jJmFM+ZX6ThsGDetlfFRkeHA3FrhJFzU1rTCRY8
	 4cQxZcOitkCnOSjpb5S1kunsxV1TLClbQv541MxAqzFB3lS7fQSt3y93DXNVoCVKXv
	 ueiZQVx6Dny8cfx25W18Zu4g2a2CzWYdAqlb7J+pVYJUeopfv2GbmQF2flW7mlc66+
	 Xn8pHpJDuDDSBDDPkInZbxNj4Y0BxfFkq77wVlomIe1kuZae81quNV5Ue8vhrWe8oQ
	 bc6RTB2q8ymJsRMLmIHxGo5wrPhulE3FJ7Ld7AJTVLuw+PiEh5z9CZNBiyxrBd76g/
	 Y1YvMi0T7sOzQ==
Date: Thu, 12 Jun 2025 12:22:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco
 Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald
 Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250612122209.0f48fbda@foz.lan>
In-Reply-To: <aEmm4bHxn3+l0vDO@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<aEhSu56ePZ/QPHUW@gmail.com>
	<20250611174518.5b24bdad@sal.lan>
	<aEmm4bHxn3+l0vDO@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Breno,

Em Wed, 11 Jun 2025 08:55:13 -0700
Breno Leitao <leitao@debian.org> escreveu:

> Hello Mauro,
> 
> On Wed, Jun 11, 2025 at 05:45:18PM +0200, Mauro Carvalho Chehab wrote:
> > Em Tue, 10 Jun 2025 08:43:55 -0700
> > Breno Leitao <leitao@debian.org> escreveu:
> >   
> > > Hello Mauro,
> > > 
> > > On Tue, Jun 10, 2025 at 12:46:07PM +0200, Mauro Carvalho Chehab wrote:  
> > > > A better long term solution is to have an extension at
> > > > Documentation/sphinx that parses *.yaml files for netlink files,
> > > > which could internally be calling ynl_gen_rst.py. Yet, some care
> > > > needs to be taken, as yaml extensions are also used inside device
> > > > tree.    
> > > 
> > > In fact, This is very similar to what I did initially in v1. And I was
> > > creating a sphinx extension to handle the generation, have a look here:
> > > 
> > > https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/
> > > 
> > > During the review, we agree to move out of the sphinx extension.
> > > the reasons are the stubs/templates that needs to be created and you are
> > > creating here.
> > > 
> > > So, if we decide to come back to sphinx extension, we can leverage that
> > > code from v1 ?!
> > >   
> > > > -def generate_main_index_rst(output: str) -> None:
> > > > +def generate_main_index_rst(output: str, index_dir: str, ) -> None:    
> > > 
> > > You probably don't need the last , before ).
> > > 
> > > Other than that, LGTM.
> > > 
> > > The question is, are we OK with the templates that need to be created
> > > for netlink specs?! 
> > > 
> > > Thanks for looking at it,
> > > --breno  
> > 
> > Hi Breno,
> > 
> > I did here a test creating a completely new repository using
> > sphinx-quickstart, adding yaml to conf.py with:
> > 
> > 	source_suffix = ['.rst', '.yaml']
> > 
> > There, I imported your v1 patch from:
> > 	https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/
> > 
> > While your extension seems to require some work, as it has issues
> > processing the current patch, it *is* creating one html file per each
> > yaml, without needing any template. All it is needed there is to place
> > an yaml file somewhere under source/ directory:  
> 
> Thanks for the tests. It appears that the sphinx extension can function
> without requiring stubs and templates, right?
> 
> Given you have your hands dirty with it, and probably more experience
> than I have with sphinx extensions, would you be willing to take
> ownership of this extension and submit it? I'd be more than happy
> to review it.

Sure. I wrote an extension that will do what it is expected. Yet,
I opted to have a static index.rst file. I tried to do auto-generation,
but, at least when using SPHINXDIRS, it didn't work.

I'm sending the patch series in a few.
 
Thanks,
Mauro

