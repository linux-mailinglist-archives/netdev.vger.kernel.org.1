Return-Path: <netdev+bounces-185578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E305CA9AF95
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85951886EE2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1E1624EA;
	Thu, 24 Apr 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMpzzj3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774F182BD;
	Thu, 24 Apr 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502286; cv=none; b=im2r319D140Sse18C061b0zKU8cm6d+nCHE6CDD0dXQed0Fe/UlCuuRAKMfP2h9q0rUqQq2YSjEa1kKjvIQHn1J1DasIR7iCeih2bwZf024PXg42RXlIKYLvQfZsJV8lxZWGyEOGyTXArUGlZ/oSkCFimm8b8tnI9d0igewFTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502286; c=relaxed/simple;
	bh=PShkp7fTP5LFbT7+Oj0pLtbEx4SuRIIBbJwc1SPDBJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STdZsI++dlnE0E3j8JJhXT5Wk6shldDLSCTtgiOQhV2ppof/3j91ju87zlTfeo9NhAotHUyW/mI2Nq62LNnGGNxE1IVLClgpukFp2WUqY4gsHyCRyiXTcm2ZjjEuu4e5jCSL7y7UIDYaRnGPS9R+ITUnDIXptrxlhT0tNo5hfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMpzzj3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259D2C4CEE3;
	Thu, 24 Apr 2025 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745502285;
	bh=PShkp7fTP5LFbT7+Oj0pLtbEx4SuRIIBbJwc1SPDBJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMpzzj3XJ4J4Ejqg30OmPoXNFlYXNh0vUxXzfR1/8XrkssyLHaB6hYbSntF/lqKdc
	 1z0iijfeiSFmB76HsVP3sGZ3H7DFxgq7CS9On9eIJkovIv0Y3wX+OF+gPSrSPhf6ep
	 t6C6yr+46TT2sbvBfK+rB4ZpjPDHe1ViYNn6UA34=
Date: Thu, 24 Apr 2025 15:44:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org
Subject: Re: CVE-2024-49995: tipc: guard against string buffer overrun
Message-ID: <2025042434-stoic-growl-a7ec@gregkh>
References: <2024102138-CVE-2024-49995-ec59@gregkh>
 <1eb55d16-071a-4e86-9038-31c9bb3f23ed@oracle.com>
 <1cc70ad0-4fa7-422f-ade4-b19a19ce3b61@stanley.mountain>
 <8781b7c9-65e4-47c1-8f1a-5cbc7a975128@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8781b7c9-65e4-47c1-8f1a-5cbc7a975128@oracle.com>

On Thu, Apr 24, 2025 at 02:15:43PM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> 
> On 24/04/25 13:47, Dan Carpenter wrote:
> > On Thu, Apr 24, 2025 at 11:41:01AM +0530, Harshit Mogalapalli wrote:
> ...
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6555a2a9212be6983d2319d65276484f7c5f431a&context=30
> > > 
> > > 
> > >   	/* validate component parts of bearer name */
> > >   	if ((media_len <= 1) || (media_len > TIPC_MAX_MEDIA_NAME) ||
> > >   	    (if_len <= 1) || (if_len > TIPC_MAX_IF_NAME))
> > >   		return 0;
> > > 
> > >   	/* return bearer name components, if necessary */
> > >   	if (name_parts) {
> > > -		strcpy(name_parts->media_name, media_name);
> > > -		strcpy(name_parts->if_name, if_name);
> > > +		if (strscpy(name_parts->media_name, media_name,
> > > +			    TIPC_MAX_MEDIA_NAME) < 0)
> > > +			return 0;
> > > +		if (strscpy(name_parts->if_name, if_name,
> > > +			    TIPC_MAX_IF_NAME) < 0)
> > > +			return 0;
> > >   	}
> > >   	return 1;
> > > 
> > > 
> > > 
> > > both media_len and if_len have validation checks above the if(name_parts)
> > > check. So I think this patch just silences the static checker warnings.
> > > 
> > > Simon/Dan , could you please help confirming that ?
> > 
> > Correct.  The "validate component parts of bearer name" checks are
> > sufficient.  This will not affect runtime.
> > 
> 
> Thanks a lot Dan and Simon for confirming this.
> 
> Greg: Should we get this CVE-2024-49995 revoked ?

Yup, now rejected, thanks for the review!

greg k-h

