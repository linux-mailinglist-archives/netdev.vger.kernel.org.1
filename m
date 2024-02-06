Return-Path: <netdev+bounces-69539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97084B9A9
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA271C21972
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308F13248D;
	Tue,  6 Feb 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5WPFqqWG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CC13340B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233620; cv=none; b=OH+wwEI4bWYdwdHN/VPdtIaJRoUtqhFNQ+Zztp8rTiQevDjdejWdqN1pZpp6ycOW8+t+/G1/6oBoFGnzAs0TbSdIorY7tUDAW48I9+S8rGcfCETlWI/AtnLhA3k20eJNq3Huw4MAD6YhDphX8e6K6ABGVF63SRkmQGhy3rVQpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233620; c=relaxed/simple;
	bh=fnpO7jOpohF4M5GPG5r0YDXt0toDDrdPOjuh94lZ/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaAy/TZcIwIKTCNo6qsitTOA6TBNOLHhm7lFT2q7tLFVvYANsV/zgE4K26Pg3jGvp3TIQ3yh/nMbvzpFt9O9UW6ssr7zeJO2T9Jw1c8D4tNhTTNTLIjZ5r80KAZVDsSGg0k5o2AhMcpxfLLFBggc959vNNA3WnkjWvzHjayt8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5WPFqqWG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ek8JkZWZM0DgJRdUWlmAo9C7yEeuUX4VfC1IEXpI9E4=; b=5WPFqqWG1lRLTWKfmvZ6rMBN7M
	58BYtZqd+z5QutS2Qb+U44x7gatzzDv8U0api9WQrzlLdd/3fnwVzFLNp6SJ3GSd4wGsL1BJITVi8
	/jEsjG0gikRP+BoiImrZ/TZpJaOQg7uDL11rWvVAgBPpKqhQPXLkRQtIdL+km7Wul4lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXNS4-0079Ml-J2; Tue, 06 Feb 2024 16:33:36 +0100
Date: Tue, 6 Feb 2024 16:33:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mahendra <mahendra.sp1812@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: USGV6 test v6LC.2.2.23: Processing Router Advertisement failure
 on version 5.10
Message-ID: <ec033a36-c352-43c9-b769-41252ff18521@lunn.ch>
References: <CAF6A85__pPB_K1iuzVSrKXd+AWXkO4NDYBWbeDfGJEphvvuzzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6A85__pPB_K1iuzVSrKXd+AWXkO4NDYBWbeDfGJEphvvuzzQ@mail.gmail.com>

On Tue, Feb 06, 2024 at 02:06:17PM +0530, mahendra wrote:
> Hi Everyone,
> 
> We are executing IPv6 Ready Core Protocols Test Specification for
> Linux kernel 5.10.201 for USGv6 certification.

Do you see the same problem with 6.8-rc3, or net-next? Your first step
should be to determine if the problem has already been fixed and the
fix just needs back porting.

     Andrew

