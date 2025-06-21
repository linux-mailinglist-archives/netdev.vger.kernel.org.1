Return-Path: <netdev+bounces-199947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D99AE27C7
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E185B189D05F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C81A3165;
	Sat, 21 Jun 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="102dXKJk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC914A23;
	Sat, 21 Jun 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750491278; cv=none; b=S9PWtYsDtRMdkI9kvKlp0x42kUuXUJkIwAtRacVDYUs1IJsysTjaZJ2NLUKeH+DZX2cnRvWLJ/Oc/hRjarM3prRfph+AiKU0bHyuWlxQRxfwJ91oVd72tUp7eURbOnuQGydiRiekiOeo+qa2Lx8MgW0DnwqANSUXb8infPhrUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750491278; c=relaxed/simple;
	bh=LvKmwdyxs8aDqiVxaatPX/4yLcfgBQ0ErpcBjkzC7NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVseVjQCtR5E1roMcXX+wyo+3QiPAEsZZptxzbjPt7EKIs9qyLhrFS1YY0kVBNz1tQHHe9Z8VepmyECqqTWWQn+Ake1ZwaKifRD/Les3fDeMyRgs7y6quEei9xUP/zwhQS3bdjLt4RbfRwdOGsswUuquatT/WRMbrLDDtVGzbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=102dXKJk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WgSYZQzNAF3gNCEhJqZFPXyDOnbRYcAkLczX5OxFQGE=; b=102dXKJkBy4z7RaUtl73mxmCy0
	E3rPh/buGMz2ZK77SY4aNSQazJ1zphNfFyr8WClP+Z8Yvp6My8RNRDe0GOdwBebyQUkeZNOWyjtMS
	/P5PoWbkOfbWCjBmCclAJVITwkh/5ZSynXtpzpDw2QqwOX5AeX31Q6kb2yrWNrQxacLE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uSsk8-00GZDN-21; Sat, 21 Jun 2025 09:34:28 +0200
Date: Sat, 21 Jun 2025 09:34:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shannon Nelson <sln@onemain.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] CREDITS: Add entry for Shannon Nelson
Message-ID: <c84ed394-40c3-42e3-8a14-ac383e718fae@lunn.ch>
References: <20250619211607.1244217-1-sln@onemain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619211607.1244217-1-sln@onemain.com>

On Thu, Jun 19, 2025 at 02:16:07PM -0700, Shannon Nelson wrote:
> I'm retiring and have already had my name removed from MAINTAINERS.
> A couple of folks kindly suggested I should have an entry here.
> 
> Signed-off-by: Shannon Nelson <sln@onemain.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

