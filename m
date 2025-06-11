Return-Path: <netdev+bounces-196662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D995AD5C76
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CA3A40F6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D61F8EFF;
	Wed, 11 Jun 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BXeNDlcB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5BB1F5846
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659945; cv=none; b=uCdhyP6Yx2kbqt20UwOvHraBvISxPS58iIWNebYnFi7b6zMWGOXHlISxeNm50Gk/DtN0leXMfplmWGXAvm9LcpYxEeHEbN/z+7fDglfQ8urNTRX74x5/AnoXpOKqT9PyAGK35xoUoylSqTgNSTbURAf+6kxesXzmua0k8pzV204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659945; c=relaxed/simple;
	bh=vGbqFm3NRPxr6eG1H5VRzXIrsdCE5sdOKiQgUCGNPys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvH8dPJoBOpr8wfMaSswnK2h66H5f1mSvr/xwYXBYyho7qX6YlIgpUAJF4TIA6cpXOjqW83PF5weq+4mGXO/iHo3GUPSNpwziRmgMMSfallbfK5pIUqVZlcp7h8OevBhxM+YLXAQe5io98lD+zIrMPElSjF2kt6ouIExNkXeNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BXeNDlcB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4uDHSKKkJPErGs0m/th6Q5+CwwWkeTLPAHn4+TjzoMk=; b=BXeNDlcBYR6bll7NfoIECM9ODt
	izTiFlZKr+f2PR0u6hqkVtqcGB7vOOTLHNrInnGyUAPYvLXeKmBqbvqME4IyvWt78GgADdyFAhgc3
	wkBF+HG7dkSqUGw6USbbc7UGWiz/ifh6pkyNP8zMMXHattsDJJef3VmibTLXgI6i09tw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPOTZ-00FQV8-W7; Wed, 11 Jun 2025 18:38:57 +0200
Date: Wed, 11 Jun 2025 18:38:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Khalid Mughal <khalid.mughal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [PATCH] net: Add new iccnet driver
Message-ID: <83e44167-43eb-4abd-b536-c2e290ab4382@lunn.ch>
References: <20250611155402.1260634-1-khalid.mughal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611155402.1260634-1-khalid.mughal@intel.com>

On Wed, Jun 11, 2025 at 08:54:02AM -0700, Khalid Mughal wrote:
> Intel(R) IPU ICCNET (Inter-Complex Communication Network) Driver:
> 
> The iccnet (Inter-Core Communication Network) driver enables sideband
> channel communication between the Management-Complex and the
> Compute-Complex, both powered by ARMv8 CPUs, on the Intel IPU
> (Infrastructure Processing Unit). The driver establishes descriptor
> rings for transmission and reception using a shared memory region
> accessible to both CPU complexes. The TX ring of one CPU maps
> directly to the RX ring of the other CPU.

https://www.spinics.net/lists/netdev/msg1000950.html

I suspect the developer was a student on a placement at TI for a
while, so it had the typical student code problems, and he had
problems thinking about the big picture, a generic solution rather
than a solution specific to TIs use case.

Please could you read through the comments i made to various versions
of that patchset and see what applies to what you are doing. Two
similar systems within a year suggests we need a generic shared memory
solution, or at least a shared core library which can then be wrapped
for individual use cases.

> v2:
> - Fixed issues highlighted by Marcin Szycik
> v3:
> - Fixed internal-kbuild-all build warning
> v4:
> - Changed iccnet header padding

As far as i know, these never made it to the list, so don't exist. It
is good it had internal review, but please don't pollute the commit
with stuff nobody else can see.

     Andrew

