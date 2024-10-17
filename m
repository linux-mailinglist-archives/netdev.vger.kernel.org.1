Return-Path: <netdev+bounces-136556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7519A20FE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5477C1F234EE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D191D5178;
	Thu, 17 Oct 2024 11:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3B134A8
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164815; cv=none; b=Hu+IzcocmqcZ8HX6813wZurnIJu52XGHgm02o8Y4NaxAb0N9uMf6Eb+5UWGS9qIK0m4xOTArmQCmUoPQZeeOAXwGraJrNHq1FVEZpZvkah5B6oLo+mXx6RneZGR/TuHd7loTXhVOK0yy1Trf5DPaJMVJH1WuZwDIJiyMVlJvxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164815; c=relaxed/simple;
	bh=3OcphTi4R1QPpUY4U70U0Ew+7wnin/go6nGv4WaAO+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBCAWdsk6Guz6CM+t3bmT9d/zXLAns5vPkXr62ggJ+Fom7UtBXUnoBlApz5DUANpfM5szf96FqlUeTMnpDMUg4s3PB9KU7WsueelyT3WSsa9eGdPz0lkdU65kzgIHKkwPgRsxVmdMl65ZHrr9X98hUo4X/kwkizofh6vLkqbK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1Ol0-0003WR-OX; Thu, 17 Oct 2024 13:33:30 +0200
Date: Thu, 17 Oct 2024 13:33:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Nathan Harold <nharold@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Yan Yan <evitayan@google.com>
Subject: Re: [PATCH ipsec] xfrm: migrate: work around 0 if_id on migrate
Message-ID: <20241017113330.GB12005@breakpoint.cc>
References: <20241017094315.6948-1-fw@strlen.de>
 <CANP3RGeeR9vso0MyjRhFuTmx5K7ttt0bisHucce0ONeJotXOZw@mail.gmail.com>
 <20241017105251.GA12005@breakpoint.cc>
 <CANP3RGcWhTKOgNsCEb8bMNhktgdzXH+00s5zTKU3=iVocT5rqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGcWhTKOgNsCEb8bMNhktgdzXH+00s5zTKU3=iVocT5rqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Maciej Żenczykowski <maze@google.com> wrote:
> > If you think a Kconfig knob makes sense for Android sake I can respin
> > with such a knob, but I think I'd have to make it default-y.
> 
> I'll trust your judgment.  I thought we could maybe eventually
> deprecate and delete this, but it sounds like that isn't going to be
> the case...

We could also say 'android fixed it in userspace' and not fix it
in kernel for now until someone else complains.

Or modify the pr_warn to also say something like
"deprecated and scheduled to be removed in 2026"?

I'm not thrilled with this patch :-)

