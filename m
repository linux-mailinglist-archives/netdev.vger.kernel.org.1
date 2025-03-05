Return-Path: <netdev+bounces-172090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04546A502BF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AD9189D743
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED0248885;
	Wed,  5 Mar 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JI3/kzz3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CB1624D2
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186023; cv=none; b=kkb8QU16F55qXOwLWHRfjuowjj2Jx238BGM2A0uCYJRyex9BPV1lkl4IxHXqHCDqMMnBeR97z7cQnzkeQzZD4HcjQqsl3ksXPNJvvhMayD7KdAnpx5OebFPKKRxpNHboXiupVdBeiLC+qOfqd94kcIxQvBP6aFqAM7JfJf1OwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186023; c=relaxed/simple;
	bh=epsd4cXMLRwO9rUjPzodleeEUXkpvTkYuamqUPwi+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoxsG6Nvzl7EXFD7VXQO2UNovUftMhGe547qzsgS3bu18Dvr8J4svaD8ctj/yLdmP0CXvbsaSJoQrgiNVb6rJ+rq3ScHpsbUWYmTVRbRvrofeIV4+iRwhPebaRDwjhtGDnUzk+G0ovB7QM+W88LAYs8DHMDw9c9FnqMeitTOgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JI3/kzz3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HVFa3HmBvfV9pVok2mofz5qtao+bDlbgiVJG9KIzeAQ=; b=JI3/kzz3uAW8qHaLnbd0ewqxXs
	S6+6lOw95qmXWeX55K1ewoo9oADJ1iCdRkZtnHfa2jBkk4hmjuGCjcOqtIpNUf4O1vakTQnSHqQG6
	8KSBFPEdAGRdw9+ckPkDH5IzQqERL+Z74dPQdx/0oJqn7RLXWCOYYKVdZK10O7WnwMZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpq1Q-002VRw-JM; Wed, 05 Mar 2025 15:46:56 +0100
Date: Wed, 5 Mar 2025 15:46:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: dp83869: fix status reporting for link
 downshift
Message-ID: <514dc263-1e88-463a-b8ee-7abb2d27b161@lunn.ch>
References: <20250305094053.893577-1-viktar.palstsiuk@dewesoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305094053.893577-1-viktar.palstsiuk@dewesoft.com>

On Wed, Mar 05, 2025 at 10:40:53AM +0100, Viktar Palstsiuk wrote:
> Speed optimization, also known as link downshift, is enabled for the PHY,
> but unlike the DP83867, the DP83869 driver does not take
> the PHY status register into account.
> 
> Update link speed and duplex settings based on the DP83869 PHY status
> register, which is necessary when link downshift occurs.
> 
> Signed-off-by: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

