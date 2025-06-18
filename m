Return-Path: <netdev+bounces-199067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CDDADECDA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE14C3B0DF6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76070286D64;
	Wed, 18 Jun 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T35oes2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09B258CD0;
	Wed, 18 Jun 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250425; cv=none; b=GVqFqoHQUjzgtDHsHu8go2u6ZZ71z0/DoK32NZsyjv3H4KK0yxcan12qet+cWbbL3VrMAaMDylMmbiwsLd8/KXPFD9SmsXjVEQh+qUv5q1qzOj9eCXH2eKcurSoMFXDjsqlFix7y6U2TeqF6/7cAV+qalhiKKPGEATcKuOL4Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250425; c=relaxed/simple;
	bh=lKJkRX5S1J6VtzITZ5xzBjEBLhnqYUnVxruczGLyT08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpBrawzBhEZTLwy7FJuYvlWdZA4Sdd8eL8og4KKA1BkRsAWXdfD2vfggr5jcGigNrTAMNApIHMGyEOMljSVllZ+8ROXro+lDyVJZi9GPIDOXzJu/OM52qxDoNaT+X9vaUdJo+x7XbsxDUjI/2zdLYetVU4hqmlXsTxcKexiP5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T35oes2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6CDC4CEE7;
	Wed, 18 Jun 2025 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250424;
	bh=lKJkRX5S1J6VtzITZ5xzBjEBLhnqYUnVxruczGLyT08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T35oes2Fkomfh40d6u66VAQWgiTTkCCDSuXaUmP9wZj+ZvbxEJppK5DeCdXziOEhg
	 3HEpnVRqlDeTIAfAtsfh8HKcdGHc7Uqpj6S6eN2INZPxSjVIwS2jXPoJjuaciRncRy
	 Xxm82+PegCaah7+5vTiKGWtGcO+DjQzVo+ZUt7AqelZLpBZY33KdEBNwB5Uaq1WxK2
	 eOMNofrX6l+G0WeTImkNi69icQxs5GeLX0ZqZP3QGnVRWs1KH+cTaMtewy/RNj2FaO
	 2cqyu3Mxebizp7QLsFdK6B8Fb+28XA5K2+Ds9lwEFxz13m0Kvrv1ACzaUaSh3pE8vU
	 lxd9Pi9CUntEQ==
Date: Wed, 18 Jun 2025 13:40:19 +0100
From: Simon Horman <horms@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v5 05/15] tools: ynl_gen_rst.py: make the index parser
 more generic
Message-ID: <20250618124019.GQ1699@horms.kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
 <20250617115927.GK5000@horms.kernel.org>
 <20250618085735.7f9aa5a6@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618085735.7f9aa5a6@foz.lan>

On Wed, Jun 18, 2025 at 08:57:35AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 17 Jun 2025 12:59:27 +0100
> Simon Horman <horms@kernel.org> escreveu:
> 
> > On Tue, Jun 17, 2025 at 10:02:02AM +0200, Mauro Carvalho Chehab wrote:
> > > It is not a good practice to store build-generated files
> > > inside $(srctree), as one may be using O=<BUILDDIR> and even
> > > have the Kernel on a read-only directory.
> > > 
> > > Change the YAML generation for netlink files to allow it
> > > to parse data based on the source or on the object tree.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> > > index 7bfb8ceeeefc..b1e5acafb998 100755
> > > --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> > > +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> > > @@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
> > >  
> > >      parser.add_argument("-v", "--verbose", action="store_true")
> > >      parser.add_argument("-o", "--output", help="Output file name")
> > > +    parser.add_argument("-d", "--input_dir", help="YAML input directory")
> > >  
> > >      # Index and input are mutually exclusive
> > >      group = parser.add_mutually_exclusive_group()
> > > @@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
> > >      """Write the generated content into an RST file"""
> > >      logging.debug("Saving RST file to %s", filename)
> > >  
> > > +    dir = os.path.dirname(filename)
> > > +    os.makedirs(dir, exist_ok=True)
> > > +
> > >      with open(filename, "w", encoding="utf-8") as rst_file:
> > >          rst_file.write(content)  
> > 
> > Hi Mauro,
> > 
> > With this patch applied I see the following, which did not happen before.
> 
> Thanks! this was an intermediate step. I'll just drop this patch and
> fix conflicts at the next version.

Likewise, thanks.

