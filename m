Return-Path: <netdev+bounces-211217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3249B17310
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DF11C20652
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1C86347;
	Thu, 31 Jul 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrTzn8Fl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F472F24
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971541; cv=none; b=qJlPwc845TP5UFKmJkmvGoN0wzZ/HyO/Nm/+D+0bZFRVTAfKZUX/VIAev2vsMz1JZved9tQRUrkatDYtoDmFOwk+Yu+N9phne9cA82C8h2uzgtOF/MfifJjbmb7c8+OzbSp757lBwjG3ZGGVjBaQb0q/ZA2u6FrAsPda04bL6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971541; c=relaxed/simple;
	bh=ia7xCQuqzR2uTmkXAtZ6VY321GSUkL/+6nHVpv9O7n0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiKuXu7LGljPnDc6s+uV5EFp1QItOyG3mT6A8sQIzwsE0UxWZ9zuX0tlnQSSVU3ECjS9WH9QeWUACakbYLxVMqBEEVRn9GqirQavhLL65QpPy7QZE2Ksmn+wpTNG0drCl6N3RMicdttgTxXHCAxPr+bNtsQsrt5+ALeUjepBAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrTzn8Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D536FC4CEEF;
	Thu, 31 Jul 2025 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753971541;
	bh=ia7xCQuqzR2uTmkXAtZ6VY321GSUkL/+6nHVpv9O7n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RrTzn8Fl+hh+ihGienyc1SIPawUM2+QwTsTO6MTGRnnItNswTzphzbnZXjWTXWBnV
	 Fd9Xe3oo41qWtcUTL1do1utp6k2x+VDy72YYSZTWza7c5+5nRLvRXRl1jNk2w2OlE5
	 bCYIpfMZwr881mHSOCtSUQ9tN7fC21AwAuRC61wkYVI5lfyD3nRCRuEqaG0NwMusl4
	 /aa+Rcc4p3tUzxd0zeQZ1EpZU7jDlR8Kh5trz6+GqiqJw/Yhz+V4sRGF2Ps50qbgC6
	 85DCWY5F5JaGkUUyoJpcmynLfEnrWE5/piX+p+KZ98O/+gq94bYlaIwWmQ7m+4ge78
	 0ZodLKEYDpoTQ==
Date: Thu, 31 Jul 2025 07:19:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, "Lifshits, Vitaly"
 <vitaly.lifshits@intel.com>, Simon Horman <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Message-ID: <20250731071900.5513e432@kernel.org>
In-Reply-To: <e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
	<20250714165505.GR721198@horms.kernel.org>
	<CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
	<b7265975-d28c-4081-811c-bf7316954192@intel.com>
	<f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
	<20250730152848.GJ1877762@horms.kernel.org>
	<20250730134213.36f1f625@kernel.org>
	<55570ac6-8cd7-4a00-804e-7164f374f8ae@intel.com>
	<20250730170641.208bbce5@kernel.org>
	<e04d3835-6870-4b82-a9a5-cb2e0b8342f5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 10:00:44 +0300 Ruinskiy, Dima wrote:
> My concern here is not as much as how to set the private flag 
> automatically at each boot (I leave this to the system administrator).
> 
> The concern is whether it can be set early enough during probe() to be 
> effective. There is a good deal of HW access that happens during 
> probe(). If it takes place before the flag is set, the HW can enter a 
> bad state and changing K1 behavior later on does not always recover it.
> 
> With the module parameter, adapter->flags2 |= FLAG2_DISABLE_K1 gets set 
> inside e1000e_check_options(), which is before any HW access takes 
> place. If the private flag method can give similar guarantees, then it 
> would be sufficient.

Presumably you are going to detect all the bad SKUs in the driver to
the best of your ability. So we're talking about a workaround that lets
the user tweak things until a relevant patch reaches stable..

