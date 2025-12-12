Return-Path: <netdev+bounces-244444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C239CB774B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 01:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B93AB3010FF3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BE33985;
	Fri, 12 Dec 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="J81DDSCd"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446D4A01
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499742; cv=none; b=ovMo17hW+rzkgPK/K8OCkbzPTSr/N2ky3zQhUeYK872WRoM0o41WBsiyZKCXHWAFq/4EAOJuvqoQjMhuiQP3vHIzEB/B3d5LvrG5r3GminsnGecjgVeriafqtB79CzS3HTgfnU1Lpj8LnSbFh+2oFDISFHz3eoaNxNAlI2RZt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499742; c=relaxed/simple;
	bh=bJH0q2IkZX3gXz1xQsPYoTUsbjB6YMyhIXpf6Vvxux0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J13zhvRLykV4c60cjgPrASfz6MdrtD8p1eOq/eW6dReY7+GWEa8EDhH2eEmyCM3/l0GHxUa0Gu25a8xeu80/Le9rIs8eip4xgvC1RKoVLzRHBaTgvPSbXaLju8yVtbuBAm5g0WXNGGxUCLet6ze3GFpm/4M5fzEKT2B5ta6OzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=J81DDSCd; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 5BC0Z3Ew766561;
	Fri, 12 Dec 2025 01:35:03 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 5BC0Z3Ew766561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1765499703;
	bh=qOQ2uak3bO9mHYkvqXsyu/6OPefkfHnPLpaA17OuQXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J81DDSCdiKy/mTZQhqrSZ1QKr7jY6+Gmq9gBDmsV8qyr0FsuKF7E3DtWS+J4gr/Y2
	 bA6pnvdqTW1EabcadevC1BeQzT0nFT/t584g/ANf2ZbjRyUu8vXedQWDjPWnXBv10v
	 uWtZ9HfJ14N2wxFE7IhmEGCEPDCBgdbp/k5hS2BM=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 5BC0Z3Ra766560;
	Fri, 12 Dec 2025 01:35:03 +0100
Date: Fri, 12 Dec 2025 01:35:02 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Simon Horman <horms@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] epic100: remove module version and switch to
 module_pci_driver
Message-ID: <20251212003502.GA766557@electric-eye.fr.zoreil.com>
References: <20251211074922.154268-1-enelsonmoore@gmail.com>
 <aTqewtoOZ5s84vEV@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTqewtoOZ5s84vEV@horms.kernel.org>
X-Organisation: Land of Sunshine Inc.

Simon Horman <horms@kernel.org> :
[...]
> I note that author information is remains present in a comment at the top
> of this file.  And I agree that not having this kind of information is
> current best practice (and has been for quite some time AFAIK).  So I think
> this patch is a good way to go.

The part below may still be relevant:

        This driver is for the SMC83c170/175 "EPIC" series, as used on the
        SMC EtherPower II 9432 PCI adapter, and several CardBus cards.

Anything else at the top of the file was a tribute to Donald Becker's work
before he stopped contributing to mainline drivers, more than 20 years ago,
in a pre-NAPI era. NAPI support for this driver was coined together in 2004
and Donald Becker was already silent on netdev for quite some time IIRC.

Go for it.

Acked-by: Francois Romieu <romieu@fr.zoreil.com>

