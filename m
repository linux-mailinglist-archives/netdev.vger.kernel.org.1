Return-Path: <netdev+bounces-198900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DEADE413
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEA1189A59F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E672580ED;
	Wed, 18 Jun 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvLvDGTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA80257AC2;
	Wed, 18 Jun 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229863; cv=none; b=LFb8Nj5hq9iiH0rxbc2eh6wHAmFzAfvHqUy9HgqWMoMHWqnmkgNBiQCTSuZshSbM9RMJS7tXoG6BO9cGtoSugPVsXIb1pzgC3466iYwG+PJZ/6WRfLhk5+pL3ralU543xB54iibXkBfoc/VKIvB5Ejt1OjHT7iHRyt+7+9uX4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229863; c=relaxed/simple;
	bh=RFQtspKngvjxdT3mkmOe3FrXsaTZvezQsEA/vCFJOSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAO9l/DlT7ue7MjCCJzoPCe97tsaluHrpPWZd4GAz12WsZmWzTBf13tvnCzBMhiFspeXPmdvM7RXDMx474ist49pztNCzIGXI5Np0R9rUIpwy1coZD+yaPvcYletYlOX03lHU8k6UL73PKbopSOIHBSwiXS8AkdKpjZpSOgKCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvLvDGTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25104C4CEED;
	Wed, 18 Jun 2025 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750229862;
	bh=RFQtspKngvjxdT3mkmOe3FrXsaTZvezQsEA/vCFJOSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pvLvDGTFYOWl3fc6P3KuOrtwdTiOuGl6+DvxBg0GsdS8wmwav5EBVT67CPl1IzQ8v
	 N988iKSa2lXRm7aA8OMF9nuKVcuNHDRz4/TRHg/tYLneDDdP/53A96EV3k/z7/RADQ
	 YC+4NbycT40fGbDxSYmS8+2ijRBYxGB0UzmCh22CHyzULWpfWYw5WMYydCpH2Ml86M
	 z7SqWtLuvwHhNvsSbOugVYLLe4ZJowKDOGaXSuLd2iA3GwoyCDAoN3/UOFKuuJ+97o
	 KZoSRqmOHg2FwrqHFE+R9jWnEjc436segDd5QKyu+BG2yCOucbbQkW3RYKORUGtfvR
	 0reNTsB2M81qQ==
Date: Wed, 18 Jun 2025 08:57:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, Breno Leitao
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>,
 Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v5 05/15] tools: ynl_gen_rst.py: make the index parser
 more generic
Message-ID: <20250618085735.7f9aa5a6@foz.lan>
In-Reply-To: <20250617115927.GK5000@horms.kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
	<20250617115927.GK5000@horms.kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 17 Jun 2025 12:59:27 +0100
Simon Horman <horms@kernel.org> escreveu:

> On Tue, Jun 17, 2025 at 10:02:02AM +0200, Mauro Carvalho Chehab wrote:
> > It is not a good practice to store build-generated files
> > inside $(srctree), as one may be using O=<BUILDDIR> and even
> > have the Kernel on a read-only directory.
> > 
> > Change the YAML generation for netlink files to allow it
> > to parse data based on the source or on the object tree.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> > index 7bfb8ceeeefc..b1e5acafb998 100755
> > --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> > +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> > @@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
> >  
> >      parser.add_argument("-v", "--verbose", action="store_true")
> >      parser.add_argument("-o", "--output", help="Output file name")
> > +    parser.add_argument("-d", "--input_dir", help="YAML input directory")
> >  
> >      # Index and input are mutually exclusive
> >      group = parser.add_mutually_exclusive_group()
> > @@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
> >      """Write the generated content into an RST file"""
> >      logging.debug("Saving RST file to %s", filename)
> >  
> > +    dir = os.path.dirname(filename)
> > +    os.makedirs(dir, exist_ok=True)
> > +
> >      with open(filename, "w", encoding="utf-8") as rst_file:
> >          rst_file.write(content)  
> 
> Hi Mauro,
> 
> With this patch applied I see the following, which did not happen before.

Thanks! this was an intermediate step. I'll just drop this patch and
fix conflicts at the next version.

> 
> $ make -C tools/net/ynl
> ...
> Traceback (most recent call last):
>   File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 464, in <module>
>     main()
>     ~~~~^^
>   File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 456, in main
>     write_to_rstfile(content, args.output)
>     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
>   File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 410, in write_to_rstfile
>     os.makedirs(dir, exist_ok=True)
>     ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
>   File "<frozen os>", line 227, in makedirs
> FileNotFoundError: [Errno 2] No such file or directory: ''
> make[1]: *** [Makefile:55: conntrack.rst] Error 1
> 



Thanks,
Mauro

