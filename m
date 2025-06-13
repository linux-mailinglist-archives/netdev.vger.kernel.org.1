Return-Path: <netdev+bounces-197487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EDEAD8C45
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAF33B4D8E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E74C92;
	Fri, 13 Jun 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK6jGYiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0934A1E;
	Fri, 13 Jun 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818421; cv=none; b=i4VQmkriYMS1pmnsd/Kro+xy83g9TYMk3YIKp+JInyJBj6pPJ8QBdq7j7cXFvgOCoSwug3Focp+yAFSGh1A9dSq4qSs0d0qFL4DgK5rHCRbvhlyfEwMr5179msCifGfPbztHj8ySO16zLjJG+WW4TeoSiTGU1Z4IbYgxPXLN5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818421; c=relaxed/simple;
	bh=n8uww8W98ephJQVBitTMkEpar+EJEaBk8t8Zr/77i8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klyYXU7tIYBh8Xhcm08F/zIW5v8ntxqV7IHXZPkChiDjqMwPHO8yiwHNY51Et4ApGCnCmIrSRBf1x7in3YqbppvdNmXjIxwgpHZl/0YVGL9RnhJY0VdyEBHC5P/fVJO9/pwCE0fkjqa1akrR51dWNg0zatmYuklv5/Hyfk572o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK6jGYiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F9C4CEE3;
	Fri, 13 Jun 2025 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818421;
	bh=n8uww8W98ephJQVBitTMkEpar+EJEaBk8t8Zr/77i8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uK6jGYiFnRly4K4X48Oi04xh14YvBbkf7irMkqzx1nR9HVAM7ubnr970iwwaIScRU
	 D+7M9+lyIZm0QyW8Dc+m/NmMDRXwrYRCaSS/O9B13hlpK5C9eeZm6bGAmwQwZzuf44
	 mWrF5BjbxHhp5LgCrqaenA2lJNtJbg5ySW+15BwZ6iBBZDfz3s1Zlr5sMzsnRvrEW6
	 Yq3UwBPCeIQw1qBM1J7LL8ga4PmkegKh5ncehT18chKIfQ9BD+7dJq7BSQuOrAOaNT
	 EDeTcb/WMmRGqm6ts0aZqu4KO8696yEWrg8aOBS5DPqzB0uiTPNFaGFYCdAHM+NE1s
	 pH3UHMZfbBPSw==
Date: Fri, 13 Jun 2025 14:40:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben Wauters"
 <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 06/12] scripts: lib: netlink_yml_parser.py: use
 classes
Message-ID: <20250613144014.5ae14ae0@foz.lan>
In-Reply-To: <m2y0tvnb0e.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<08ac4b3457b99037c7ec91d7a2589d4c820fd63a.1749723671.git.mchehab+huawei@kernel.org>
	<m2y0tvnb0e.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 12:20:33 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > As we'll be importing netlink parser into a Sphinx extension,
> > move all functions and global variables inside two classes:
> >
> > - RstFormatters, containing ReST formatter logic, which are
> >   YAML independent;
> > - NetlinkYamlParser: contains the actual parser classes. That's
> >   the only class that needs to be imported by the script or by
> >   a Sphinx extension.  
> 
> I suggest a third class for the doc generator that is separate from the
> yaml parsing.

Do you mean moving those two (or three? [*]) methods to a new class?

    def parse_yaml(self, obj: Dict[str, Any]) -> str:
    def parse_yaml_file(self, filename: str) -> str:
    def generate_main_index_rst(self, output: str, index_dir: str) -> None:

Also, how should I name it to avoid confusion with NetlinkYamlParser? 
Maybe YnlParser?

[*] generate_main_index_rst is probably deprecated. eventually
    we may drop it or keep it just at the command line stript.

> The yaml parsing should really be refactored to reuse
> tools/net/ynl/pyynl/lib/nlspec.py at some point.

Makes sense, but such change is out of the scope of this series.

> > With that, we won't pollute Sphinx namespace, avoiding any
> > potential clashes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  

Thanks,
Mauro

