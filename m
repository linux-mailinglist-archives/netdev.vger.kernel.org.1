Return-Path: <netdev+bounces-212055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D380EB1D91F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7723E4E3BB2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755325CC64;
	Thu,  7 Aug 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3jqsIFK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D023C50C
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573548; cv=none; b=J2Vqdgavm8M9c/V/l+UTw43CMQ3aOfYDkWiqXIplDEjxLdrbe2O9bTrTcrDaSjj/vGBBN9rC8CpqXKeIhxIw5s97LFARgmLRR4UvrAMmcdW0cB11XEvsdt++M9Xy3zjHN4hSCPXMyhV8ZAVxoYd9ANITd+vt74P4+Ig+rDcoahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573548; c=relaxed/simple;
	bh=bDExwaOS4BDx+6CjfwKchHO+x9Hz/Th5eoPJruT3t98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC4nVcRK4UcOKMXu6skrQevWU7QcPe4342uzbxnI+Yw9byjL3DfFCLW1LD1nwc9FXeR5KXolpnWSLF3pXLnvuWbbYJRnzh235vDMnOFet4wGBluzw9nq9c6XjvkAM8X2WMzY+FqoT6wkgr3gZnagmEVquWZTOYRJzK1SWVaL5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3jqsIFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D494C4CEEB;
	Thu,  7 Aug 2025 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754573548;
	bh=bDExwaOS4BDx+6CjfwKchHO+x9Hz/Th5eoPJruT3t98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3jqsIFKWyAUgtVXV8KdCMCx5dIEWiG346oJsqh3H65u3KDrS5Lwie8ItV8kIOSDv
	 VYl2CNZFtM/uSDtIK8unFe8NyT5GbXWetxkWLHfExqO96xVK2XaXaVDz6wKJiAy2EK
	 KLEzciQVNBc3BIVONlSI9JKE9jmU+Z9efGEjfMd8h2gS+3qPNKW1KD8ejqbJYxexc0
	 pttTgfJ6++15R82TqClr6EHamxJ3JoeErjOJlPoxks9fxlhE9IzYGmi4FOI0WjZtXN
	 cUS40TS+DwtFuv1wJHFRXv1H2+a0KfwVBGlOTtFIe6AgOQuGqqNcw00hNKBSbyHgx1
	 GHCAgDRj6mn4A==
Date: Thu, 7 Aug 2025 14:32:22 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jianliu@redhat.com, mschmidt@redhat.com,
	decot@google.com, willemb@google.com
Subject: Re: [PATCH iwl-net] idpf: set mac type when adding and removing MAC
 filters
Message-ID: <20250807133222.GK61519@horms.kernel.org>
References: <20250806192130.3197-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806192130.3197-1-emil.s.tantilov@intel.com>

On Wed, Aug 06, 2025 at 12:21:30PM -0700, Emil Tantilov wrote:
> On control planes that allow changing the MAC address of the interface,
> the driver must provide a MAC type to avoid errors such as:
> 
> idpf 0000:0a:00.0: Transaction failed (op 535)
> idpf 0000:0a:00.0: Received invalid MAC filter payload (op 535) (len 0)
> 
> These errors occur during driver load or when changing the MAC via:
> ip link set <iface> address <mac>
> 
> Add logic to set the MAC type before performing ADD/DEL operations.
> Since only one primary MAC is supported per vport, the driver only needs
> to perform ADD in idpf_set_mac().
> 
> Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
> Reported-by: Jian Liu <jianliu@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


