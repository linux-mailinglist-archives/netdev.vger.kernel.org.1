Return-Path: <netdev+bounces-100501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE028FAEC1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09281F23B3E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9A143724;
	Tue,  4 Jun 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuULkdlD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201F4823BC
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493333; cv=none; b=kac8SvqqhrlRt6/H/pjjoaaN2c+zMMqahAjDuydk5wKD6JC9q0d/ny7X79OT74IojZZDFn7W5VnH6dhrbLNY26N339IMFam8mcCGkfm/g6ZWX+B5QEcmki7mAaGsqVhwe12TG/atPE74FYFB7VYp6Kd4eIlnWEVXm7lgPQrrqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493333; c=relaxed/simple;
	bh=sgqip+PQIPw/49W9BLsHLBly53TzEuBcT6+IZxpV4Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFRlTuKWQw7Wwwf647ZJieOb+r/DZBWtI7H6w8A3EB+h/LTkRbGAkisKA6wgPzz08vYwhSNFmPAQC2Vcg46Qj4LP8+DY5N2At64eJddh16Ipl5hpBvXGx1uS7A4gKtUtl1ziwU+r9FaqN1woTelP0du9JK8Plhcjk92hqhiFXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuULkdlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A025C2BBFC;
	Tue,  4 Jun 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493332;
	bh=sgqip+PQIPw/49W9BLsHLBly53TzEuBcT6+IZxpV4Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuULkdlDZIYhk5xKGVlxkMvLutnbtwsgBNZY4BJXYklJIa/mSzBaQiHLdjk9bj/Kg
	 8pRxPeN4F5qb2zARQ1krXfAQndmvKf5gDfzaRE6t0Nik42KMfKMJXiwxKsCgxjG2rQ
	 vkJq5O+zgaSrdd3a2/W3U6fPQxBMBPCQlA8UI7/YzRledIhEUR67kTRGeINd1w35c8
	 QAATMlEzA6yEjwBnFMWDKlm8uw3ynkGJb4cQDBckYtWSn3wiK2EBtz588cmkfx+vS1
	 pr5NV1H4Uq41ZI2HN3flDzURfd6/fwOOIcnYnrjhiKee2UQv6bHcsLN8nqjH/vWieh
	 VOdwdV264iSSQ==
Date: Tue, 4 Jun 2024 10:28:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH next 07/11] ice: Introduce ETH56G PHY model for E825C
 products
Message-ID: <20240604092847.GO491852@kernel.org>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
 <20240528-next-2024-05-28-ptp-refactors-v1-7-c082739bb6f6@intel.com>
 <20240601103519.GC491852@kernel.org>
 <10ffa7ab-0121-48b7-9605-c45364d5d9d4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ffa7ab-0121-48b7-9605-c45364d5d9d4@intel.com>

On Mon, Jun 03, 2024 at 12:47:42PM -0700, Jacob Keller wrote:
> 
> 
> On 6/1/2024 3:35 AM, Simon Horman wrote:
> > On Tue, May 28, 2024 at 04:03:57PM -0700, Jacob Keller wrote:
> >> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> >>
> >> E825C products feature a new PHY model - ETH56G.
> >>
> >> Introduces all necessary PHY definitions, functions etc. for ETH56G PHY,
> >> analogous to E82X and E810 ones with addition of a few HW-specific
> >> functionalities for ETH56G like one-step timestamping.
> >>
> >> It ensures correct PTP initialization and operation for E825C products.
> >>
> >> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
> >> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> >> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> >> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> >> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> >> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Hi Jacob,
> > 
> > This isn't a proper review, but I noticed that your signed-off
> > appears twice above.
> > 
> 
> Yes it does. I developed some of the original code which Sergey used
> here (hence my Co-developed-by and Signed-off-by). But I am also
> covering for Tony and submitting the patch so I added my sign-off-by to
> the end of the sequence since I'm the one who submitted the full series
> to netdev.
> 
> I'm not entirely sure how to handle this, since its a bit awkward. I
> guess there are a couple of other ways we could have done this, from
> dropping my co-developed-by tag, to moving it to the end..

Thanks Jacob,

I understand the problem you face.

Perhaps you could move yourself to the bottom of the list of Co-developers,
below Tested-by.  But perhaps that is worse.

No big deal on my side if you stick with what you have,
although possibly it will be flagged again (by someone else).

