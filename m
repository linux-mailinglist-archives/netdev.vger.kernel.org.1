Return-Path: <netdev+bounces-196651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A335AD5B35
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB217A626
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE211E1E13;
	Wed, 11 Jun 2025 15:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83917597;
	Wed, 11 Jun 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657320; cv=none; b=kkDJJ8MknlDaQzI3Yp5o3DfkaylFafJDld/MV/vsrTXX8CEMOUaDURVwyHle2sXtDOUSdCbEN1bxAwzEuBkvgy92XOUDQBFRFYVWkKO82/db5M2/ftfR65pxUpySzQ9wS0ItVgF5HYPioAtOAppBmhgo/cvZ6nbVtUe7wq/LDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657320; c=relaxed/simple;
	bh=RuH+17plmVtHYvKUZVvFokwqhJyYZSSTBslAfWYSSes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKNXhAzBDPtypYOwrNHbtTGLFHLGX8Ltnb3Gf9dr6IW07Jd/dOMh5YF12XcAKx2HHUmVF/6LDs7giVwWVQxUtOS60vazdMlkBAI0CdfaND9YF9/LmB1OuVK3+Pzc5O/nqtbh/C8rGhJr3LCK2YLHFbtv9AbJSbvPNOyytejXNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad93ff9f714so1223837566b.2;
        Wed, 11 Jun 2025 08:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657317; x=1750262117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dwG9EoMZ9ZKiC4ZdlNpo301IGTXAAOKclnpBssAG0E=;
        b=FA7/sRcVAemOU48Zh9EKWjtmGH62gpWk7Gcd4frf3kWGlhE7B26p602oAtoYNTUpoK
         dyvwKx/O5Qwr5p9hg5dIjnelQvit0nLoWJm/3697yt826IBh31Dib3rDHGDEZw9Cg2NY
         bV6hc9uJDSo0H/pK8ru1KK2l/KsQgqIVRfkkgZqcxT+7GE7i9Lachk2KsncmYW3hJEZa
         VJcfbT/oFt/ZprsC3Wdk993adNRSs3+1VAtbCqnyOqgPiKMAGF9J11XJNpla7YkWDfIO
         xIGqBe6EYrocA0y/FAb86/3250UvQhhTXSwjE+2UsRhbLzlACEovawQsSByg7deSegI/
         jNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQTEIm6zwarTD2p1cKOFT45CLe/QQYyHQABUFXYusfpN0mi5JdlXHK79AzdXCGh3xiL8GJ6E4/dIwbqQ=@vger.kernel.org, AJvYcCWTOeqOD4A9HAJ9Z6oFDd/MwRkzAWsSRnT0xMM0fZkaKrZ5INLfMB4ncocc7adVqhTHp9c5Vl1h@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc4hQzLKfqi3a+CCYEiJ1niWZnOOgjVnRN63K2K8GCrovd88X
	7BlkmI4ayfQ1IjSWxS/GzW+QCqUvEysNilbc+VoskSdU6pBpiHNjDRkV
X-Gm-Gg: ASbGncu2AU7aeAUmIg3qcjGzLSc/U+NnDYrZV9RgtqxqJF/Bvjp7uiVymoEpAFoAVM2
	QaE0ofnDSbQgj79TYQ+AEHRXsuVEHp38fya+YmgzZPB0B7lDOSwOQ0yuiVzYt3CDlYxmidUmETK
	RMnyS0F2/SPXGDer3QtiPYqU9876oT1ZUbkAV+TzJn9koSF30j2AudRaT+YinLRrLG5DwD46oj0
	Z72W6tZJs3/61yNhaTnaYoz0x67scjCj6w5/G3dNrM4AW/iUeQVBoFtFH5tpu9a8ByXtifnWlr8
	AZFrKv77XwP55+zAEH3D4PPPnXAii8JbfxlsiKSlL0/eT492RfNGAQ==
X-Google-Smtp-Source: AGHT+IEsIs1LfkvlptHxbiWYOk1v3wDTy5QTNB0kKe4Qx9gAubVMpbktdWpOaQty3ez3oGX+LfxDTQ==
X-Received: by 2002:a17:907:7210:b0:ad8:8689:2cc9 with SMTP id a640c23a62f3a-adea378cd5bmr12817366b.56.1749657316839;
        Wed, 11 Jun 2025 08:55:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db57610sm919089666b.52.2025.06.11.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:55:16 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:55:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <aEmm4bHxn3+l0vDO@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
 <5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
 <aEhSu56ePZ/QPHUW@gmail.com>
 <20250611174518.5b24bdad@sal.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611174518.5b24bdad@sal.lan>

Hello Mauro,

On Wed, Jun 11, 2025 at 05:45:18PM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 10 Jun 2025 08:43:55 -0700
> Breno Leitao <leitao@debian.org> escreveu:
> 
> > Hello Mauro,
> > 
> > On Tue, Jun 10, 2025 at 12:46:07PM +0200, Mauro Carvalho Chehab wrote:
> > > A better long term solution is to have an extension at
> > > Documentation/sphinx that parses *.yaml files for netlink files,
> > > which could internally be calling ynl_gen_rst.py. Yet, some care
> > > needs to be taken, as yaml extensions are also used inside device
> > > tree.  
> > 
> > In fact, This is very similar to what I did initially in v1. And I was
> > creating a sphinx extension to handle the generation, have a look here:
> > 
> > https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/
> > 
> > During the review, we agree to move out of the sphinx extension.
> > the reasons are the stubs/templates that needs to be created and you are
> > creating here.
> > 
> > So, if we decide to come back to sphinx extension, we can leverage that
> > code from v1 ?!
> > 
> > > -def generate_main_index_rst(output: str) -> None:
> > > +def generate_main_index_rst(output: str, index_dir: str, ) -> None:  
> > 
> > You probably don't need the last , before ).
> > 
> > Other than that, LGTM.
> > 
> > The question is, are we OK with the templates that need to be created
> > for netlink specs?! 
> > 
> > Thanks for looking at it,
> > --breno
> 
> Hi Breno,
> 
> I did here a test creating a completely new repository using
> sphinx-quickstart, adding yaml to conf.py with:
> 
> 	source_suffix = ['.rst', '.yaml']
> 
> There, I imported your v1 patch from:
> 	https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/
> 
> While your extension seems to require some work, as it has issues
> processing the current patch, it *is* creating one html file per each
> yaml, without needing any template. All it is needed there is to place
> an yaml file somewhere under source/ directory:

Thanks for the tests. It appears that the sphinx extension can function
without requiring stubs and templates, right?

Given you have your hands dirty with it, and probably more experience
than I have with sphinx extensions, would you be willing to take
ownership of this extension and submit it? I'd be more than happy
to review it.

--breno

