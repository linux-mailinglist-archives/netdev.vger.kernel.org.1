Return-Path: <netdev+bounces-84733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D389834B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E42828CA5C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B67173C;
	Thu,  4 Apr 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="XKJf7Zne"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDA2134A
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219966; cv=none; b=EZwBrt4V8PUbA8OCkwTLMaPl0ReX0i1c3lk1PRxL/moMArGXYyj+d9qcI/YA+QT2etJ23u/5egnN6yO3kB+qM1FnHsGedjrSXEf1v8h85qsC0q//1QTB2p8dToRvqkLzITW5v0PKdeBLgr6xXFH76Yq2xMx/BXJykB8BAD5fC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219966; c=relaxed/simple;
	bh=eBAGlAEVzpzY7amkDpDIgHmnCq3jCeCyf1r4pBB8jVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpqH/XzGmGCVpsahXPELTGUEtoyybjYthq3RSreSa9g1aTcZeuAotEfyJbcXk3e3uZdRAwFCivP/q9jNuO8c41SFgvOEZSDXJIc26Iwg5nkQTvuYZwwioFGXiOgSSCokZS4RW5jCjEcY7yEKd5b71L5cqXy5eYVvu5YbUW9Tnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=XKJf7Zne; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 9af774a5-f25e-11ee-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9af774a5-f25e-11ee-bfb8-005056ab378f;
	Thu, 04 Apr 2024 10:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=QyhD3Ey3fKxNGb4VIQMdLEjwBMVcXNVjSMgIrdov7E0=;
	b=XKJf7ZneDCP+tebRbu7BgCynCtdwgTHHkLQc8n7j9XRIjvyB0gJkuEFVkdKt+jHbkIQht0eTC4Ie8
	 FUP9mshvfDKl2SYABft1V/eBJsAhBjwiVcXHh5TxKerMUMGTS4F5MHhIsJ1zvmQs7/9O2PQxYCzYgz
	 49ybSvNqNZfcahIY=
X-KPN-MID: 33|po0lT09CshO4sNngrtvMQrgob9mnqIygAMHJ00rx7njLc/E2tGgCU19T7kWelth
 Q8ou4JLW76OgsBzkXnD6GA/6DkB7SoM1NEL51FW2F2oc=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|qr9i59af5+jb78J9oYVq75vrjzWvFkMPXpX+qq5lRNHalX88J7WskjJ7gcoW3Yt
 QUt8IlEz8X1vnZRC7wf+HDA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ab5d41d2-f25e-11ee-a210-005056ab1411;
	Thu, 04 Apr 2024 10:38:12 +0200 (CEST)
Date: Thu, 4 Apr 2024 10:38:11 +0200
From: Antony Antony <antony@phenome.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Antony Antony <antony@phenome.org>, antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v4] xfrm: Add Direction to the SA in or out
Message-ID: <Zg5m8yQQgpORcRJJ@Antony2201.local>
References: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
 <c2b3203b-fcc7-452f-88d8-1ef826509915@6wind.com>
 <Zfdv8dLMhpwItqGL@Antony2201.local>
 <b3e0c716-fc74-4cb4-9778-c92749cd4b4b@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3e0c716-fc74-4cb4-9778-c92749cd4b4b@6wind.com>

On Fri, Mar 22, 2024 at 09:20:05AM +0100, Nicolas Dichtel wrote:
> Le 17/03/2024 à 23:34, Antony Antony a écrit :
> > Hi Nicolas,
> > 
> > On Thu, Mar 14, 2024 at 03:28:57PM +0100, Nicolas Dichtel via Devel wrote:
> >> Le 13/03/2024 à 22:04, Antony Antony via Devel a écrit :
> >>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> >>> xfrm_state, SA, enhancing usability by delineating the scope of values
> >>> based on direction. An input SA will now exclusively encompass values
> >>> pertinent to input, effectively segregating them from output-related
> >>> values. This change aims to streamline the configuration process and
> >>> improve the overall clarity of SA attributes.
> >>
> >> If I correctly understand the commit, the direction is ignored if there is no
> >> offload configured, ie an output SA could be used in input. Am I right?
> >>
> >> If yes:
> >>  1/ it would be nice to state it explicitly in the commit log.
> >>  2/ it is confusing for users not using offload.
> > 
> > 
> > I see why you're asking for clarification. This patch is designed for 
> > broader use in the future beyond its current application, specifically for 
> > the HW offload use case. Notably, the upcoming IP-TFS patch, among others, 
> > will utilize the 'direction' (dir) attribute. The absence of a 'direction' 
> > for an SA can lead to a confusing user experience. While symmetry is nice,
> Thanks for the explanation.
> 
> > configuring values that are not utilized and are direction-specific can be 
> > very confusing. For instance, many users configure a replay window 
> > (specifically without ESN) on an outbound SA, even though the replay window 
> > is only applicable to an inbound SA. With ESN, you can just leave it at 1.  
> > SAs have historically lacked a direction attribute. It has been brought up 
> > many times but never implemented.
> Maybe it would be worse to reject this new XFRMA_SA_DIR attribute when it is not
> used (for example if there is no offload configured). It will make the API 
> clearer.

there was also interst to use "dir"  for informational only.  It could be 
useful to check incoming traffic on large systems with 100s of xfrm states.
So I keep the "dir"  open for any  xfrm state. 

-antony

