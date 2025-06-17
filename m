Return-Path: <netdev+bounces-198545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B975ADCA32
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB96C165BEB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5C2E06C6;
	Tue, 17 Jun 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOJ7mniZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2802DF3C1;
	Tue, 17 Jun 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161574; cv=none; b=frlTGN06OBd9DZ9q0+JPXBu59HGp83bPhnBU3oFS2f1UziYj/I39M+D02BGtjEYQgggIaGvmUoMGS0qCHYAxXTTJoIItCjU8xEN6DAMSSLsy3PUJvgMbwNNUFJXY2BqkgVxUkowLBtbNy52PXc64g1IwR9xf4pikxa3hAz6GrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161574; c=relaxed/simple;
	bh=gBH+kampHpHmy4DMMyqIZcw5DfcfBCFtwdQpcTObOnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxiu2gmOM6qILoyWXRu1PY49P7m+1KBQ0M1o5vLDXPI90APIQg6jJr+zKVxFXrV0zDO4lLW3SgC9CseNH3DIB94vZhJSqOIxYcmLhG/hhHqNgn0Bdfq5rO+Tc04iv1gNQerp0vLLoihx2twFCDwOUhdOWzIqb/DcGWtJ+r+9b5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOJ7mniZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E66C4CEE3;
	Tue, 17 Jun 2025 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161573;
	bh=gBH+kampHpHmy4DMMyqIZcw5DfcfBCFtwdQpcTObOnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOJ7mniZUaKYc8b10FgbwNkGP+WmfJy6/Cay8PK7jWoKyH+/6ChmwaKJ6HS41DRTr
	 HND8IQ7bC60xAK1fXRbiggUgwr4vPCjEtMTtcmb420hiYv6Po76PVPhscp5cyYFXvM
	 KdNd0MNogDZf0IMV7vHAGfvR8jc9sCiqib7SCfMYJM4HWs+UoWObi1/MuFLdNTMevH
	 BZuRkd+OBfilTEp5inIP5dkhNKQnE7RCYH/zaZuo/pcgJt+L1gEd8LtjvmVfYx47Il
	 NBu7f8TNuN41V5FD7P+8nv654J+b8cq7RfhzFxBeC6+7uzhTPwGWNQBxJMPMjq3UH3
	 MuPXKMMjI5AnQ==
Date: Tue, 17 Jun 2025 12:59:27 +0100
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
Message-ID: <20250617115927.GK5000@horms.kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd8b28bfe159677b8a8b1228b04ba2919c8aee8.1750146719.git.mchehab+huawei@kernel.org>

On Tue, Jun 17, 2025 at 10:02:02AM +0200, Mauro Carvalho Chehab wrote:
> It is not a good practice to store build-generated files
> inside $(srctree), as one may be using O=<BUILDDIR> and even
> have the Kernel on a read-only directory.
> 
> Change the YAML generation for netlink files to allow it
> to parse data based on the source or on the object tree.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
> index 7bfb8ceeeefc..b1e5acafb998 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_rst.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
> @@ -365,6 +365,7 @@ def parse_arguments() -> argparse.Namespace:
>  
>      parser.add_argument("-v", "--verbose", action="store_true")
>      parser.add_argument("-o", "--output", help="Output file name")
> +    parser.add_argument("-d", "--input_dir", help="YAML input directory")
>  
>      # Index and input are mutually exclusive
>      group = parser.add_mutually_exclusive_group()
> @@ -405,11 +406,14 @@ def write_to_rstfile(content: str, filename: str) -> None:
>      """Write the generated content into an RST file"""
>      logging.debug("Saving RST file to %s", filename)
>  
> +    dir = os.path.dirname(filename)
> +    os.makedirs(dir, exist_ok=True)
> +
>      with open(filename, "w", encoding="utf-8") as rst_file:
>          rst_file.write(content)

Hi Mauro,

With this patch applied I see the following, which did not happen before.

$ make -C tools/net/ynl
...
Traceback (most recent call last):
  File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 464, in <module>
    main()
    ~~~~^^
  File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 456, in main
    write_to_rstfile(content, args.output)
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
  File ".../tools/net/ynl/generated/../pyynl/ynl_gen_rst.py", line 410, in write_to_rstfile
    os.makedirs(dir, exist_ok=True)
    ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^
  File "<frozen os>", line 227, in makedirs
FileNotFoundError: [Errno 2] No such file or directory: ''
make[1]: *** [Makefile:55: conntrack.rst] Error 1

-- 
pw-bot: cr

