Return-Path: <netdev+bounces-201770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B1AEAF27
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DF6561195
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F920D4F2;
	Fri, 27 Jun 2025 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t08uwEq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A0323E;
	Fri, 27 Jun 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751006902; cv=none; b=F5HRPYZvxle5+6bt7wHDG31FHZiF1RF0B28vQnCVQzPGGdIys1HySglN1uXjOiAsy9p+kWA3ZyiCwGI3Di/6tb9mPPIEcqqZS4QlHt/v6FftLO5V88glnaJhDrrBdqnSx7c22svo+7vhPY76ckeisvCJ11M/GvjJFLvYDadl9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751006902; c=relaxed/simple;
	bh=Gk61ujEoSEVxxkZaVv4tUnsHFqXUUAQCjXVa3r0CnDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJDAxz53z/hB8cWdppDX9hZ9m8bXYAhN5oodHNiWam6dOljwaUnlKD93S3sV/jsLlJmmPUTJDc9+rBFur5+e42HHxAiJMMpK4AxAHo7Ny7d+WfYstWoZX5wsjd9O4oclwUxRd4BOer2Mr/5SjDfIh25KxycowlVNibvy8TpONhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t08uwEq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8465FC4CEE3;
	Fri, 27 Jun 2025 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751006901;
	bh=Gk61ujEoSEVxxkZaVv4tUnsHFqXUUAQCjXVa3r0CnDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t08uwEq64ptQhfSGo4H8UuSvXroAFX2X+2ikEziO04jWE0rsW4zd0KIOUK/5v7Qcs
	 LZsFAvWLC0LKJJ5VcE4xawcYpe+OC8GLHHfkJZxdA2Z3TYw+Qhh/DsvDR8g9yKaMnx
	 wzyD0GvJ0uYsEYYqLvKiP5QEhL/1Te++/hiGz391m4zorOEaf2SWmPjjwX2uJF5i34
	 MR+DnD1Fnnt1bUSpq5MbG0qsy2jRmBXK5VthA2n9737ulzhiIKW7sXqwkokWI2hJ9m
	 5t+EPRor34f1aW4Xw/xdPqyddGr+RyPrTtZ/34rRU4fmjb++BBCGwG95wLbuDf7RHt
	 MuWbbjAF61ZcA==
Date: Fri, 27 Jun 2025 08:48:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, Marco Elver
 <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
 <rdunlap@infradead.org>, Ruben Wauters <rubenru09@aol.com>, Shuah Khan
 <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v8 13/13] docs: parser_yaml.py: fix backward
 compatibility with old docutils
Message-ID: <20250627084814.7f4a43d4@foz.lan>
In-Reply-To: <ebdb0f12-0573-4023-bb7f-c51a94dedb27@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<d00a73776167e486a1804cf87746fa342294c943.1750925410.git.mchehab+huawei@kernel.org>
	<ebdb0f12-0573-4023-bb7f-c51a94dedb27@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Akira,

Em Fri, 27 Jun 2025 08:59:16 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> On Thu, 26 Jun 2025 10:13:09 +0200, Mauro Carvalho Chehab wrote:
> > As reported by Akira, older docutils versions are not compatible
> > with the way some Sphinx versions send tab_width. Add a code to
> > address it.
> >   
> 
> Tested OK against debian:11's and almalinux:9's Sphinx 3.4.3, both of
> which have docutils 0.16 bundled.
> 
> opensuse/leap:15.6's Sphinx 4.2.0 has docutils 0.16 with it, but it is
> python 3.6 base and it does't work with the ynl integration.
> As opensuse/leap:15.6 provides Sphinx 7.2.6 (on top of python 3.11) as
> an alternative, obsoleting it should be acceptable.  

Thank you for the tests! At changes.rst we updated the minimum
python requirement to:

	Python (optional)      3.9.x            python3 --version

So, I guess we can keep this way. 

The 3.9 requirement reflects the needs of most scripts. Still, for doc build, 
the min requirement was to support f-string, so Python 3.6.

In this specific case, it is likely some minor incompatibility, as vermin 
tool thinks that 3.6 would be enough: 

	$ vermin --no-tips --hidden --pessimistic -v tools/net/ynl/pyynl/ynl_gen_rst.py Documentation/sphinx/parser_yaml.py tools/net/ynl/pyynl/lib/*.py
	Detecting python files..
	Analyzing 6 files using 24 processes..
	2.3, 3.0     /new_devel/v4l/docs/Documentation/sphinx/parser_yaml.py
	~2, ~3       /new_devel/v4l/docs/tools/net/ynl/pyynl/lib/__init__.py
	!2, 3.6      /new_devel/v4l/docs/tools/net/ynl/pyynl/lib/doc_generator.py
	!2, 3.6      /new_devel/v4l/docs/tools/net/ynl/pyynl/lib/nlspec.py
	!2, 3.6      /new_devel/v4l/docs/tools/net/ynl/pyynl/lib/ynl.py
	!2, 3.4      /new_devel/v4l/docs/tools/net/ynl/pyynl/ynl_gen_rst.py
	Minimum required versions: 3.6
	Incompatible versions:     2

If the change is minimal, I don't mind having it fixed.

Anyway, IMO we need to add a checker at scripts/sphinx-pre-install to
warn against too old Python versions.

> 
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> > Closes: https://lore.kernel.org/linux-doc/598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com/
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Tested-by: Akira Yokosawa <akiyks@gmail.com>
> 
>         Thanks, Akira
> 
> > ---
> >  Documentation/sphinx/parser_yaml.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
> > index 8288e2ff7c7c..1602b31f448e 100755
> > --- a/Documentation/sphinx/parser_yaml.py
> > +++ b/Documentation/sphinx/parser_yaml.py
> > @@ -77,6 +77,10 @@ class YamlParser(Parser):
> >  
> >                  result.append(line, document.current_source, lineoffset)
> >  
> > +            # Fix backward compatibility with docutils < 0.17.1
> > +            if "tab_width" not in vars(document.settings):
> > +                document.settings.tab_width = 8
> > +
> >              rst_parser = RSTParser()
> >              rst_parser.parse('\n'.join(result), document)
> >    
> 



Thanks,
Mauro

