Return-Path: <netdev+bounces-242606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6EC929C5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BE93A4C14
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C25289811;
	Fri, 28 Nov 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="bB0Gp4wc"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEA285CA7;
	Fri, 28 Nov 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348473; cv=none; b=IuvZ6Y/noTzDW4MVrtVywFr23s/NEVDqQchwZIoEr1lSc7LpvFoLLaq2yswqrYdhC8yOc4iteyLnbXwnekucBKxczAlvBDwZrRg7BK2GMX4sz3MwPSUHQcIT/8sCyX7cFbg2l5CG7sqciLxRMqYYlyDEOiFJhMCcTxohXFjsI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348473; c=relaxed/simple;
	bh=DhFo6RHse4QCjOY7NsIph+5IO1xM6CyFK0qTymdOBes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrHSqo0qtxViQn9HfcrSeSS9ZNfrJHXtvTVvG2U36ZT4WLIN/utVlh86nPSQBbPYatOef7rJSymBJBySzbKnPJvFATJV0p3MLQR6kfCvF6QOLLYpQIgq74OXxXFGwMXPeA7aFVuMPwBIdJBmHtJI/PR2HT0dIzu/hFcMYDuQTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=bB0Gp4wc; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 23A3D353B;
	Fri, 28 Nov 2025 17:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764348459;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=3wijgMUBQt+Iu07mWrZH24BuZXPNbu4Ww8QXhPSWFxo=;
	b=bB0Gp4wceqqWhbrjQfV67oWwcOF/eO8gNA6qpx69HE50Yhhp2uXb7zi+PUHGxlfv
	nLQtDX4RtFUdW0fi4t42o2aYc2qQCJweofgnqTZZh2BINefjvyKoQr25hRGfPtJBEmH
	ih466WpLxJH/ESSf/09Hsht8vUpWOGW9ugWPtSMs=
Received: by smtp.mailfence.com with ESMTPSA ; Fri, 28 Nov 2025 17:47:35 +0100 (CET)
Date: Fri, 28 Nov 2025 17:47:33 +0100
From: Clara Engler <cve@cve.cx>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
 <20251127181743.2bdf214b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127181743.2bdf214b@kernel.org>
X-ContactOffice-Account: com:620022785

On Thu, Nov 27, 2025 at 06:17:43PM -0800, Jakub Kicinski wrote:
> imagine there was another comma in this print:
> 
> 	martian source, %pI4 from %pI4, on dev %s
> 
> we should leave it as is, I think.

Yes, this comma indeed makes it more helpful.

Personally, my preference would lie in a format such as the following:

    martian source (src={SRC}, dst={DST}, dev={DEV}

with a respective similar change to the martian destination.

> People may be grepping logs for this exact format..

I agree with you partially.  For such a trivial change, it is probably
not worth to pursue this any further, but I don't think "log stability"
is something to aim for/guarantee.

Thank You
Clara

