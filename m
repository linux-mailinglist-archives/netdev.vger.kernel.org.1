Return-Path: <netdev+bounces-188203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC25AAB85F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B54172352
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B935FAFF;
	Tue,  6 May 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byxgfciZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AD27FB1B
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746491273; cv=none; b=qbNGGRKMnecosKLSei+LMFLb172Ny7HyXz52rartAkvDAWStm4w1dCjUizrm2I1kCLZlgUWISvwGNBipwuE76ONP7GWIpCAUZ5sprZYfTo+On/eotXlIbMRzJF8rJGXZ6GMWbrULEjAolRVNmkfnx32RDP7oZbj+9VIyAo1HtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746491273; c=relaxed/simple;
	bh=iddWnoqHwptXsz6AW0BUirbqdjrQz8LAD2GWn07NSCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W115lokhvra1+q32/Pshhg7bYUKTy+a6pSgwU+IwWe7VZ+Er1V0gxB8xT3LzjZSJAnWVF1djtKnAg1G2sJOUM1EeUE+MHJvRXOGTe/9GsTqn859tVONysrwVQK4KO5C/uezk+Y1v8qwLyGz32tmPo1dgrthPY5GvF7lFiDlsbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byxgfciZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF8EC4CEE4;
	Tue,  6 May 2025 00:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746491271;
	bh=iddWnoqHwptXsz6AW0BUirbqdjrQz8LAD2GWn07NSCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byxgfciZiiHBfKUyWomW1PlOlkvvvWNnHqS+eFWyDaPLhFEPYUBl5kz73LjukyVuJ
	 AUalFFR6aOaqw+Go8Qx7pJpWUBgj/PTBjH+3IKaPEV0Z5XYTeQ6QpGmDAlAnZTZ0iv
	 4S4poqb2KZMEhWMxXeHMxyPOmTxXcqS/V1D14UAL9opXP0UP5dl+Ke8rw/k+6BNbEZ
	 vgj2qEhuyQJKCb/AlCApViaJKRDrZ1IzoHILfeJXd5Pj8F9np2MOPojL2MQuJ1aa7N
	 1MwQ/cmUlTR02aI8Ng9b4XOyCM/Lbak492qoBB+s+M1qjHfekqh6EE49MHTniOpvJU
	 5afX0aDWNbeEg==
Date: Mon, 5 May 2025 17:27:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: split presence metadata
Message-ID: <20250505172750.2c0a8f2b@kernel.org>
In-Reply-To: <a6842c5f-032c-4003-9e7c-2705fecc2835@davidwei.uk>
References: <20250505165208.248049-1-kuba@kernel.org>
	<20250505165208.248049-3-kuba@kernel.org>
	<a6842c5f-032c-4003-9e7c-2705fecc2835@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 14:06:29 -0700 David Wei wrote:
> > @@ -282,6 +281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
> >               # Every layer below last is a nest, so we know it uses bit presence
> >               # last layer is "self" and may be a complex type
> >               if i == len(ref) - 1 and self.presence_type() != 'present':
> > +                presence = f"{var}->{'.'.join(ref[:i] + [''])}_{self.presence_type()}.{ref[i]}"  
> 
> Can this go a few lines higher and replace:
> 
>              presence = f"{var}->{'.'.join(ref[:i] + [''])}_present.{ref[i]}"
> 
> Since self.presence_type() would always return the correct string,
> including "_present"?

Hm, I don't think so. This is some of the gnarliest code the codegen
has, but it tries to generate something like:

	req->_present.options = 1;
	req->options._present.cgroup = 1;
	req->options.cgroup._count.act = n_act;

We have a nested member called "act". It's two nesting layers deep
inside the requests. We need to mark the "act" as present, but also
all parent nests as present. The nests always have presence type
of "present" (that's why its hardcoded at the start of the loop).
Last layer is the "real" presence type of the attribute, so we use
self.presence_type().

