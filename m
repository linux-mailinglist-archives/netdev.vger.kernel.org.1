Return-Path: <netdev+bounces-184271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C39A94089
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 02:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7617819E3A64
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FE38B;
	Sat, 19 Apr 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJS0vHLN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3617E
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745021284; cv=none; b=ZM/K5D+LqHtslAQLttexYqY3fo+UBBemlJCIKg8BC7TeHiCQEwhN9cIARfnmHoG+7NJUsvmdTI2SGYEmaJrBOvZYoBjBvmx3QVD3hnkD++DlUuXFaAXSpOg6Ce17LG+gBulJkV7aD33DgheZALECrF2e67y0vtNIQKYJm9ng60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745021284; c=relaxed/simple;
	bh=UP1tbg4EQIrvUrTfQsAGM30LhZuQ11w4VpCelkO5VPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcQbPx1iDRGRf5wvs+8BOqVqNoNitISxBLpj9xQMpaVDGL575GzBbPKimrBVenazc96DYFhfthyw9w4GceexXTHzQgnEAgLZweHRz5uWeFxaT5GGj6mKhNKTzfpwNwmikF6m1V9GPJe5gLMEhUsIJXqBk9dj8pEUmhIRkV0kIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJS0vHLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F83C4CEE2;
	Sat, 19 Apr 2025 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745021284;
	bh=UP1tbg4EQIrvUrTfQsAGM30LhZuQ11w4VpCelkO5VPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJS0vHLNcRr1GFu3aFQtJoStbqq1I5qtT/f9tVzRrJnXdVragTCTJaLSyB1Zx/MuC
	 aWCxRe/I4EJ7PRsPPTE22Cdgd+PF0LbuqiagaYR3mV1tNxLrYdgpaV33/DKzU19tIO
	 wJoQ08oQR8rFx/tDR+XL4DRxm8ow+YTsOon9H652v2Pd9AFpc/ijkfcAW45EBb4M4W
	 u8xs//EEtIhar70i2oWU2vlbtCfjbZQuJGHC1P/5nM/QI2Oq5Ix2RwO2injXNQbvqr
	 +Lk4Mzh0XRI0oP7DbiELo0Oc64MR5shxWQ4huwLPcwxmPdKJsS8vjsjUencLzxo9e6
	 Jd2egvZMZeusQ==
Date: Fri, 18 Apr 2025 17:08:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types
 of dynamic attributes
Message-ID: <20250418170803.5afa2ddf@kernel.org>
In-Reply-To: <bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
References: <20250414195959.1375031-1-saeed@kernel.org>
	<20250414195959.1375031-2-saeed@kernel.org>
	<20250416180826.6d536702@kernel.org>
	<bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 12:26:50 +0200 Jiri Pirko wrote:
> Thu, Apr 17, 2025 at 03:08:26AM +0200, kuba@kernel.org wrote:
> >On Mon, 14 Apr 2025 12:59:46 -0700 Saeed Mahameed wrote:  
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Devlink param and health reporter fmsg use attributes with dynamic type
> >> which is determined according to a different type. Currently used values
> >> are NLA_*. The problem is, they are not part of UAPI. They may change
> >> which would cause a break.
> >> 
> >> To make this future safe, introduce a enum that shadows NLA_* values in
> >> it and is part of UAPI.
> >> 
> >> Also, this allows to possibly carry types that are unrelated to NLA_*
> >> values.  
> >
> >I don't think you need to expose this in C. I had to solve this
> >problem for rtnl because we nested dpll attrs in link info. Please see:
> >
> >https://github.com/kuba-moo/linux/commit/6faf7a638d0a5ded688a22a1337f56470dca85a3
> >
> >and look at the change for dpll here (sorry IDK how to link to a line :S)
> >
> >https://github.com/kuba-moo/linux/commit/00c8764ebb12f925b6f1daedd5e08e6fac478bfd
> >
> >With that you can add the decode info to the YAML spec for Python et al.
> >but there's no need do duplicate the values. Right now this patch
> >generates a bunch of "missing kdoc" warnings.
> >
> >Ima start sending those changes after the net -> net-next merge,
> >some of the prep had to go to net :(  
> 
> I may be missing something, I don't see how your work is related to
> mine. The problem I'm trying to solve is that kernel sends NLA_* values
> to userspace, without NLA_* being part of UAPI. At any time (even unlikely),
> NLA_* values in kernel may change and that would break the userspace
> suddenly getting different values.
> 
> Therefore, I introduce an enum for this. This is how it should have been
> done from day 1, it's a bug in certain sense. Possibility to carry
> non-NLA_* type in this enum is a plus we benefit from later in this
> patchset.

Ugh, I thought enum netlink_attribute_type matches the values :|
And user space uses MNL_ types.

Please don't invent _DYN_ATTR at least. Why not PARAM_TYPE ?

