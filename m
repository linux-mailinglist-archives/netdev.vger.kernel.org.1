Return-Path: <netdev+bounces-209679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14EAB1056D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331F51790B3
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3727EFFD;
	Thu, 24 Jul 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb/l33ed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A427EC78
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348446; cv=none; b=VF0ctgxoVvpzibPdGo7a+e9+O8vahIuvqomaNZ9pOr5i2yF6SPtqTKMzqHgQmQRljPzjpfuhplIjfx5dbq8UfHFAUMUdRwR7kL/ObNklRML/l7A5xVNxTPQNfP5UTDI2NpFk90VYu9VSlcVdMEiLSy1nkA+G+bgBjmQUcGXryZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348446; c=relaxed/simple;
	bh=0aWfHkSFO138/lUy44VYtrGkDTHvcLii7yoLMp/1Mpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUebhtqqLO/LMYj8LkirYAe3F01jYtRzhyN/TC9niSt/4yG3BSffugVMUpwvY0SYAMRlMyO2sEHDqT+ChZMGWEIECXO5AXmYqEWRvjm9TMnTAhwV9d0/00P3Qxfqb4ZOJd7CtaO/2euHuiUmUoe1CUMQB7mbmA10Yjah29g3n4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb/l33ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23DCC4CEED;
	Thu, 24 Jul 2025 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348445;
	bh=0aWfHkSFO138/lUy44VYtrGkDTHvcLii7yoLMp/1Mpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sb/l33edbGZHf7SoDHDnCerGz9oL4N0UxC6dV4kIbmXikrYDrXrJoDBDK4gTPcSmu
	 ypOMKRRn02j5vi3CQU5kUEKiS6209K7sJBxVT/13bQkaq1ykZPdYpkp7RjMlzWYKON
	 BHkbgU024SbvqE38oDkR07b57hhfUweh+JYXSwCjNMEkapLQfR4FBp2bpGy+5oGNEs
	 TPjnpDZ+3xytU98hTZGH80TQFJN9cq3UXqvmv+vyDlzz9bNn+bOoLvBi76ECXK0dbN
	 UCIWYj0ct3J2jdBc0tvZfmj/is8Em+dtmMtLaw1jlytZtd/vw8+EBlr9eZardelr0A
	 QQAzJc8TvsI3Q==
Date: Thu, 24 Jul 2025 10:14:02 +0100
From: Simon Horman <horms@kernel.org>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net v2 0/6] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
Message-ID: <20250724091402.GH1150792@horms.kernel.org>
References: <20250718002150.2724409-1-joshua.a.hay@intel.com>
 <20250723150835.GF1036606@horms.kernel.org>
 <DM4PR11MB6502F4622507B81F56DFFC65D45EA@DM4PR11MB6502.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB6502F4622507B81F56DFFC65D45EA@DM4PR11MB6502.namprd11.prod.outlook.com>

On Thu, Jul 24, 2025 at 12:03:33AM +0000, Hay, Joshua A wrote:
> > On Thu, Jul 17, 2025 at 05:21:44PM -0700, Joshua Hay wrote:
> > > This series fixes a stability issue in the flow scheduling Tx send/clean
> > > path that results in a Tx timeout.
> > >
> > > The existing guardrails in the Tx path were not sufficient to prevent
> > > the driver from reusing completion tags that were still in flight (held
> > > by the HW).  This collision would cause the driver to erroneously clean
> > > the wrong packet thus leaving the descriptor ring in a bad state.
> > >
> > > The main point of this refactor is to replace the flow scheduling buffer
> > > ring with a large pool/array of buffers.  The completion tag then simply
> > > is the index into this array.  The driver tracks the free tags and pulls
> > > the next free one from a refillq.  The cleaning routines simply use the
> > > completion tag from the completion descriptor to index into the array to
> > > quickly find the buffers to clean.
> > >
> > > All of the code to support the refactor is added first to ensure traffic
> > > still passes with each patch.  The final patch then removes all of the
> > > obsolete stashing code.
> > >
> > > ---
> > > v2:
> > > - Add a new patch "idpf: simplify and fix splitq Tx packet rollback
> > >   error path" that fixes a bug in the error path. It also sets up
> > >   changes in patch 4 that are necessary to prevent a crash when a packet
> > >   rollback occurs using the buffer pool.
> > >
> > > v1:
> > > https://lore.kernel.org/intel-wired-lan/c6444d15-bc20-41a8-9230-
> > 9bb266cb2ac6@molgen.mpg.de/T/#maf9f464c598951ee860e5dd24ef8a45
> > 1a488c5a0
> > >
> > > Joshua Hay (6):
> > >   idpf: add support for Tx refillqs in flow scheduling mode
> > >   idpf: improve when to set RE bit logic
> > >   idpf: simplify and fix splitq Tx packet rollback error path
> > >   idpf: replace flow scheduling buffer ring with buffer pool
> > >   idpf: stop Tx if there are insufficient buffer resources
> > >   idpf: remove obsolete stashing code
> > >
> > >  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  61 +-
> > >  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 723 +++++++-----------
> > >  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  87 +--
> > >  3 files changed, 356 insertions(+), 515 deletions(-)
> > 
> > Hi Joshua, all,
> > 
> > Perhaps it is not followed much anymore, but at least according to [1]
> > patches for stable should not be more than 100 lines, with context.
> > 
> > This patch-set is an order of magnitude larger.
> > Can something be done to create a more minimal fix?
> > 
> > [1] https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-
> > rules
> 
> Hi Simon,
> 
> It will be quite difficult to make this series smaller without any negative side effects. Here's a summary of why certain patches are necessary or where deferrals are possible (and the side effects):
> 
> "idpf: add support for Tx refillqs in flow scheduling mode" is required to keep the Tx path lockless. Otherwise, we would have to use locking in hot path to pass the tags freed in the cleaning thread back to whatever data struct the sending thread pulls the tags from.
> 
> Without "idpf: improve when to set RE bit logic", the driver will be much more susceptible to Tx timeouts when sending large packets.
> 
> "idpf: simplify and fix splitq Tx packet rollback error path" is a must to setup for the new buffer chaining. The previous implementation rolled back based on ring indexing, which will crash the system if a dma_mapping_error occurs or we run out of tags (more on that below). The buffer tags (indexes) pulled for a packet are not guaranteed to be contiguous, especially as out-of-order completions are processed. 
> 
> "idpf: stop Tx if there are insufficient buffer resources" could possibly be deferred, but that makes the rollback change above even more critical as we lose an extra layer of protection from running out of tags. It's also one of the smaller patches and won't make a significant difference in terms of size.
> 
> "idpf: remove obsolete stashing code" could also potentially be deferred but is 95% removing obsolete code, which leaves a lot of dead code.

Thanks Joshua,

if there is justification, which is indeed the case,
then I withdraw my suggestion to create a smaller fix.

