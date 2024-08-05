Return-Path: <netdev+bounces-115793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32F7947CC2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302E41C212B0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D1F13AA36;
	Mon,  5 Aug 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSeLSBcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B213A41F
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867778; cv=none; b=CEujONwvb1WrBj1SExwNJLNrv4+YeAl2BgyMceSQzfe+lWkg2yzm7kTYliaV2oa6FOG/3f/pFYOoOEGFbu3IO7oWSqnQbXMYE5Px9OlrexQd6X6vZu2CvHq5Md3oHv0kqW688e68SJ47u3w7hHEliqKiLKPSX7uCVCYw5MaVURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867778; c=relaxed/simple;
	bh=vrme+DDYW+JVoon2DTR7Lx5t1PPF+THwkLbEK6+S3hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQfnAqRGk33dnk2CfkI7nHZr3Oi8fsYP8sLIPggqoe3Dd2XyBUJQ82jbrBodtV22bpY/aXvhF2jrYtnNkIHIIENHWPMWoJEbgeF4uue2jSzOrC5iyRjaMrlSy4AEslcyoT0aVv7cP3zaBTloVw6y3mIeRapEst0lWbwfmSbDkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSeLSBcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7787C32782;
	Mon,  5 Aug 2024 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722867777;
	bh=vrme+DDYW+JVoon2DTR7Lx5t1PPF+THwkLbEK6+S3hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSeLSBcfXjkMqngV8sdT3s0/95OyOlWqXjNONXWW7Vb57+mHFTlNuQgT+jT8jtKh/
	 BqGhdZPDn2+TBFnfqkRVuN5jsUWig5oZISnYs7QUuXj6kvWhzmb3aAlWBt7upiRBIS
	 dZGIuVh/a6HeLO5kMjNGcFCZ7+32pfvVIiPXVAO0kBICaN/edP9c0kinZ4jxzIaYy7
	 FGKIN3fl1NVEpNNvoY8/b1acX6n/X8stCrIVmHtDUfiIalXiXbTWQTZZ/AAdib53vm
	 syGMG5aP/n4VmpwDravrIq2TSOpcn6qF5d+GA4zlTZaqTVi67FHke4MpUo144RQ3vf
	 YqqUrzIy+6OAw==
Date: Mon, 5 Aug 2024 15:22:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240805142253.GG2636630@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731185511.672d15ae@kernel.org>

On Wed, Jul 31, 2024 at 06:55:11PM -0700, Jakub Kicinski wrote:
> On Wed, 31 Jul 2024 09:52:38 +0200 Paolo Abeni wrote:
> > On 7/30/24 22:39, Paolo Abeni wrote:
> > > Leverage a basic/dummy netdevsim implementation to do functional
> > > coverage for NL interface.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>  
> > 
> > FTR, it looks like the CI build went wild around this patch, but the 
> > failures look unrelated to the actual changes here. i.e.:
> > 
> > https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr
> 
> Could you dig deeper?
> 
> The scripts are doing incremental builds, and changes to Kconfig
> confuse them. You should be able to run the build script as a normal
> bash script, directly, it only needs a small handful of exported
> env variables.
> 
> I have been trying to massage this for a while, my last change is:
> https://github.com/linux-netdev/nipa/commit/5bcb890cbfecd3c1727cec2f026360646a4afc62
> 

Thanks Jakub,

I am looking into this.
So far I believe it relate to a Kconfig change activating new code.
But reproducing the problem is proving a little tricky.

