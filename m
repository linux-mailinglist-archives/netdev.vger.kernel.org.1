Return-Path: <netdev+bounces-199217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3AADF74A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E14A38DF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1F219E8D;
	Wed, 18 Jun 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkx4JIXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731631E0B91;
	Wed, 18 Jun 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276505; cv=none; b=D2BdpQf3Qoy4+5Ib/Xo6M1Q0fTlWZ6JHaeSeP49Eq4AdFuowL6F1UOfbyvUKjLLBzEILDi4uFWQYZoMzRd3MaeXus1aQZWPA7XlbhQ+/HyDEH6DFOEubkdsLrdsnGCiZ7XWyFSAz0xkxnbvQ/BYZVerIxHb0i2oiMnQ2AvXWRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276505; c=relaxed/simple;
	bh=1RlycySOdSP3ZEPT62sfSnVE+tSXDy0OAIIpXyF3AKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUdoyTH+7+zPdqq3b7wlQuMzrCRptxm/0xMjtgQpUSLhK6bmqkc873ZxMXgzEq4mv7px729tbWTWhUAlG1G4XxrUjpX8CmWdStHOH7FKWaGLToiR1sqhgHZKm70jXLUlJlxinQipffvVrtTxzW+nQobgOWCHb3YbkimGxLDKDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkx4JIXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025DAC4CEE7;
	Wed, 18 Jun 2025 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750276505;
	bh=1RlycySOdSP3ZEPT62sfSnVE+tSXDy0OAIIpXyF3AKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mkx4JIXwXrnHLEBQvsqdW8RQuZ9ro4sF496hW+Nz2EUz3hGoyOssK8CDgRrj7zfq6
	 kHx9kNAJRe4tiFbn5CxjXby7pDGgWrN6ncNZru50wpgIlHpSjgLh8IVgKBYBWb5u3a
	 ScvcmA9JYKhPljZwKKvfMVfxnt4XtYzzsNRQH1qa8Gi1WIL8TNmt3ZbNg6tdbAXv6y
	 QOQ1JweU/4wPFO884GFGJ+tVHUzeCeMq6Oim6N8Fz4/NvnH+Mok+/FAbV2FsfXiSeC
	 yPZsTaEpj9jr3mDfRvhNUrtgR/ngH68Z7eKvMjC4gf18xp0631bOiPFXsc9V5vYz0z
	 DRK5GxK8gExdg==
Date: Wed, 18 Jun 2025 21:54:57 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, Marco Elver
 <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v6 01/15] docs: conf.py: properly handle include and
 exclude patterns
Message-ID: <20250618215457.72b93b8d@foz.lan>
In-Reply-To: <aFLee2PdbK+6SiA8@gmail.com>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
	<737b08e891765dc10bd944d4d42f8b1e37b80275.1750246291.git.mchehab+huawei@kernel.org>
	<aFLee2PdbK+6SiA8@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 18 Jun 2025 08:42:51 -0700
Breno Leitao <leitao@debian.org> escreveu:

> On Wed, Jun 18, 2025 at 01:46:28PM +0200, Mauro Carvalho Chehab wrote:
> > When one does:
> > 	make SPHINXDIRS="foo" htmldocs
> > 
> > All patterns would be relative to Documentation/foo, which
> > causes the include/exclude patterns like:
> > 
> > 	include_patterns = [
> > 		...
> > 		f'foo/*.{ext}',
> > 	]
> > 
> > to break. This is not what it is expected. Address it by
> > adding a logic to dynamically adjust the pattern when
> > SPHINXDIRS is used.
> > 
> > That allows adding parsers for other file types.
> > 
> > It should be noticed that include_patterns was added on
> > Sphinx 5.1:
> > 	https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-include_patterns
> > 
> > So, a backward-compatible code is needed when we start
> > using it for real.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> > ---
> >  Documentation/conf.py | 67 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 63 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 12de52a2b17e..4ba4ee45e599 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -17,6 +17,66 @@ import os
> >  import sphinx
> >  import shutil
> >  
> > +# Get Sphinx version
> > +major, minor, patch = sphinx.version_info[:3]
> > +
> > +# Include_patterns were added on Sphinx 5.1
> > +if (major < 5) or (major == 5 and minor < 1):
> > +    has_include_patterns = False
> > +else:
> > +    has_include_patterns = True
> > +    # Include patterns that don't contain directory names, in glob format
> > +    include_patterns = ['**.rst']
> > +
> > +# Location of Documentation/ directory
> > +doctree = os.path.abspath('.')
> > +
> > +# Exclude of patterns that don't contain directory names, in glob format.
> > +exclude_patterns = []
> > +
> > +# List of patterns that contain directory names in glob format.
> > +dyn_include_patterns = []
> > +dyn_exclude_patterns = ['output']
> > +
> > +# Properly handle include/exclude patterns
> > +# ----------------------------------------
> > +
> > +def update_patterns(app):
> > +  
> 
> PEP-257 says we don't want a line before docstring:
> 
> https://peps.python.org/pep-0257/#multi-line-docstrings

True, but:

$ pylint Documentation/conf.py 
************* Module conf
Documentation/conf.py:357:0: W0311: Bad indentation. Found 16 spaces, expected 12 (bad-indentation)
Documentation/conf.py:587:0: W0311: Bad indentation. Found 1 spaces, expected 4 (bad-indentation)
Documentation/conf.py:567:1: W0511: FIXME: Do not add the index file here; the result will be too big. Adding (fixme)
Documentation/conf.py:1:0: C0114: Missing module docstring (missing-module-docstring)
Documentation/conf.py:229:0: W0622: Redefining built-in 'copyright' (redefined-builtin)
Documentation/conf.py:21:22: I1101: Module 'sphinx' has no 'version_info' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)
Documentation/conf.py:25:4: C0103: Constant name "has_include_patterns" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:27:4: C0103: Constant name "has_include_patterns" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:65:4: W0612: Unused variable 'sourcedir' (unused-variable)
Documentation/conf.py:66:4: W0612: Unused variable 'builddir' (unused-variable)
Documentation/conf.py:104:0: E0401: Unable to import 'load_config' (import-error)
Documentation/conf.py:104:0: C0413: Import "from load_config import loadConfig" should be placed at the top of the module (wrong-import-position)
Documentation/conf.py:109:0: C0103: Constant name "needs_sphinx" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:186:0: C0103: Constant name "autosectionlabel_prefix_document" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:187:0: C0103: Constant name "autosectionlabel_maxdepth" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:200:8: C0103: Constant name "load_imgmath" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:202:8: C0103: Constant name "load_imgmath" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:204:25: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
Documentation/conf.py:208:4: C0103: Constant name "math_renderer" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:210:4: C0103: Constant name "math_renderer" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:225:0: C0103: Constant name "master_doc" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:228:0: C0103: Constant name "project" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:229:0: C0103: Constant name "copyright" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:230:0: C0103: Constant name "author" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:253:0: W0702: No exception type(s) specified (bare-except)
Documentation/conf.py:243:4: C0103: Constant name "makefile_version" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:244:4: C0103: Constant name "makefile_patchlevel" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:245:16: R1732: Consider using 'with' for resource-allocating operations (consider-using-with)
Documentation/conf.py:245:16: W1514: Using open without explicitly specifying an encoding (unspecified-encoding)
Documentation/conf.py:259:8: C0103: Constant name "version" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:259:18: C0103: Constant name "release" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:266:0: C0116: Missing function or method docstring (missing-function-docstring)
Documentation/conf.py:284:0: C0103: Constant name "language" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:308:0: C0103: Constant name "pygments_style" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:317:0: C0103: Constant name "todo_include_todos" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:319:0: C0103: Constant name "primary_domain" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:320:0: C0103: Constant name "highlight_language" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:328:0: C0103: Constant name "html_theme" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:334:3: R1714: Consider merging these comparisons with 'in' by using 'html_theme in ('sphinx_rtd_theme', 'sphinx_rtd_dark_mode')'. Use a set instead if elements are hashable. (consider-using-in)
Documentation/conf.py:353:16: W0104: Statement seems to have no effect (pointless-statement)
Documentation/conf.py:364:8: C0103: Constant name "html_theme" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:382:17: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
Documentation/conf.py:392:0: C0103: Constant name "smartquotes_action" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:404:0: C0103: Constant name "html_logo" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:407:0: C0103: Constant name "htmlhelp_basename" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:487:8: C0103: Constant name "has" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:490:16: C0103: Constant name "has" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:494:36: C0209: Formatting a regular string which could be an f-string (consider-using-f-string)
Documentation/conf.py:551:0: C0103: Constant name "epub_title" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:552:0: C0103: Constant name "epub_author" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:553:0: C0103: Constant name "epub_publisher" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:554:0: C0103: Constant name "epub_copyright" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:571:29: W1406: The u prefix for strings is no longer necessary in Python >=3.0 (redundant-u-string-prefix)
Documentation/conf.py:571:40: W1406: The u prefix for strings is no longer necessary in Python >=3.0 (redundant-u-string-prefix)
Documentation/conf.py:571:51: W1406: The u prefix for strings is no longer necessary in Python >=3.0 (redundant-u-string-prefix)
Documentation/conf.py:577:0: C0103: Constant name "kerneldoc_bin" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:578:0: C0103: Constant name "kerneldoc_srctree" doesn't conform to UPPER_CASE naming style (invalid-name)
Documentation/conf.py:586:0: C0116: Missing function or method docstring (missing-function-docstring)
Documentation/conf.py:18:0: C0411: standard import "shutil" should be placed before third party import "sphinx" (wrong-import-order)
Documentation/conf.py:350:16: W0611: Unused import sphinx_rtd_dark_mode (unused-import)

This file needs a major cleanup, as it is currently not following
any Python code style, and still has some Phython 2.x legacy
coding styles.

Perhaps it is time to take some care of it and on other
sphinx/*.py files that aren't compliant ;-)

Thanks,
Mauro

