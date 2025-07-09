Return-Path: <netdev+bounces-205473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5553AFEDF6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9FB5603D7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5132E8E02;
	Wed,  9 Jul 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekenn0eo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692A2D3EC5;
	Wed,  9 Jul 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075893; cv=none; b=Km9ULW1huugwvepvobANsDqK9ymU0G95i6VFk8SbHIvSoZ5NUIjG442eLXMjKDU2tR8Q97Ztad4EZh8XkHZ3B8E7BSuzcb5Ku4zKyY0YXbou7RQsg/+HPucwrkqSrpyz1oKtTqxoaC2PoRnMJ6Rihl9hV0hf9HSPGi6GTw5IY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075893; c=relaxed/simple;
	bh=faK0ZcZx9HxOdB6jQlzbXh6mkQSJ4VnVDjYLsm75zDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JS6nhMiAVS6MANCpom+wx6KiVY1AbHZIDiqn6aUR3JdwsqpROXU0kbv6YfePJJaYx4pJrIrBavf6bkJi3+CU4wvJvFMpN0yN1s+QOQmkOEpIX6R44f4RtYMHsTgRF800ceKGiUD0FlAFTPWmT+l9A20mYQniUw1WHlXtUMj4STU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekenn0eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31445C4CEF9;
	Wed,  9 Jul 2025 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075892;
	bh=faK0ZcZx9HxOdB6jQlzbXh6mkQSJ4VnVDjYLsm75zDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ekenn0eonP+8DTcaA8V08ebMOrVY2uW/sSO1IseARj9uplvipipWkzvW/FH6Dtw8h
	 k3dNwLLDxBTZKRyvTrUlB5RkxG84teQsL8uDwXcgG3N/OfehygX77fThw8lbdrh62I
	 SnTRGvFdeU9OfWHoxerAv+f3RWRueXD5Q5QmqDGIgzCF/tXC5EtGyiISGQo9y+sBmX
	 7i9jQmmhDAGAQtDR2FypDRPfvs30wNXQO95GCDg+yU52DceFBwQF7mqJ1paQ5Ue66c
	 ZfzAUpc76vUE7eflBYX0GOgOfKvAAENXvcBz0cbwchEvdlMgcAUo0+URPWImK3SRJq
	 dodYpEazrY0qg==
Date: Wed, 9 Jul 2025 17:44:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Ruben Wauters" <rubenru09@aol.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v8 11/13] tools: netlink_yml_parser.py: add line numbers
 to parsed data
Message-ID: <20250709174440.39b0f49e@sal.lan>
In-Reply-To: <m2bjq98n10.fsf@gmail.com>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
	<549be41405b5ddb6b78ead71f26c33fd6ce8e190.1750925410.git.mchehab+huawei@kernel.org>
	<m2bjq98n10.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 27 Jun 2025 12:03:07 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > When something goes wrong, we want Sphinx error to point to the
> > right line number from the original source, not from the
> > processed ReST data.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/net/ynl/pyynl/lib/doc_generator.py | 34 ++++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
> > index 866551726723..a9d8ab6f2639 100644
> > --- a/tools/net/ynl/pyynl/lib/doc_generator.py
> > +++ b/tools/net/ynl/pyynl/lib/doc_generator.py
> > @@ -20,6 +20,16 @@
> >  from typing import Any, Dict, List
> >  import yaml
> >  
> > +LINE_STR = '__lineno__'
> > +
> > +class NumberedSafeLoader(yaml.SafeLoader):
> > +    """Override the SafeLoader class to add line number to parsed data"""
> > +
> > +    def construct_mapping(self, node):
> > +        mapping = super().construct_mapping(node)
> > +        mapping[LINE_STR] = node.start_mark.line
> > +
> > +        return mapping  
> 
> pylint gives these 2 warnings:
> 
> tools/net/ynl/pyynl/lib/doc_generator.py:25:0: R0901: Too many ancestors (9/7) (too-many-ancestors)

I'm yet to find any pylint Rxxx warning that I didn't have to
disable ;-)

This particular one is useless for us, as it basically tells that PyYAML
has a big class hierarchy.

> tools/net/ynl/pyynl/lib/doc_generator.py:28:4: W0221: Number of parameters was 3 in 'SafeConstructor.construct_mapping' and is now 2 in overriding 'NumberedSafeLoader.construct_mapping' method (arguments-differ)

I'll fix this one to prevent potential future issues.

Changing the code to:
 
-class NumberedSafeLoader(yaml.SafeLoader):
+class NumberedSafeLoader(yaml.SafeLoader):              # pylint: disable=R0901
     """Override the SafeLoader class to add line number to parsed data"""
 
-    def construct_mapping(self, node):
-        mapping = super().construct_mapping(node)
+    def construct_mapping(self, node, *args, **kwargs):
+        mapping = super().construct_mapping(node, *args, **kwargs)
         mapping[LINE_STR] = node.start_mark.line
 
         return mapping

This should hopefully be future-proof.

Regards,
Mauro



