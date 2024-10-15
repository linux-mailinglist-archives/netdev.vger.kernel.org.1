Return-Path: <netdev+bounces-135741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0399F08D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F491F27289
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3B1C4A28;
	Tue, 15 Oct 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7JrLKfx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01C1B3954
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004470; cv=none; b=YfXTjP+u+mBZjWZvZt0nt81+0LGil//MG1tVlWC6zL+KaGvo6noMxUjdJ1lvJr8qSU7OpDkWYmzXFTY5BcpH/2tD+wiqe3s8mPEyqduccMjxpjCF5kBbZ/sLil8FcFYOP/lp8MDotgWTUgukbkxaCF7MZQPwF0cToh4ZvbXY8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004470; c=relaxed/simple;
	bh=fTw2vjQcf+Qw9b6O2V1GoF1QdrAlTlJNrpAcqaxiuFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqk5gPx80GPx7Z4SfBLzW7USsNqVghaAkxOGyPxJMq3VqQRjqsL7yOeaI56h7kmPbaxuttTmQAOKVHGIVPxkDVu12FKnxw04g6rezvZzJZcUxRhC7P5Fdy9G74ikHhhczqxb7PU1nuMXHUrKrZB+26NEZBH0GECscAKz9KO1EXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7JrLKfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED5C4CEC6;
	Tue, 15 Oct 2024 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729004469;
	bh=fTw2vjQcf+Qw9b6O2V1GoF1QdrAlTlJNrpAcqaxiuFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7JrLKfx23LUy7lHGQp6IDq3E9CE2rlGfNsjnzkt+7FIcb/WUcqZ/MqifN+ory1ba
	 Q0ulw0VPCwmV5AJZOD3WiquQS4FAdVWj9LDvG5IGZf43V/JQvmZQf/lB8V5vd4k9J+
	 e0H24I8davd9BiIU7QriBdjpBmTv4HWh/yMNckRoyIWzJVfz4F+011yPGOhmnJNMhV
	 1bawDYwBAg3h2peM7/6f/5PZGlekCnhcb0ECLyZI53bFXr/tjc1mIsUx0kYV4k7GBO
	 mx7Dla+ZNSKu2NsHOtVHHZ8hBLHEFY0Nr1yzyRwppN6rxouHxeL6SoKNhjzAFfbnU4
	 K9uqGO2BudjhA==
Date: Tue, 15 Oct 2024 08:01:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <20241015080108.7ea119a6@kernel.org>
In-Reply-To: <Zw5-fNY2_vqWFSJp@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
	<20241014081133.15366-2-jiri@resnulli.us>
	<20241015072638.764fb0da@kernel.org>
	<Zw5-fNY2_vqWFSJp@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 16:38:52 +0200 Jiri Pirko wrote:
> Tue, Oct 15, 2024 at 04:26:38PM CEST, kuba@kernel.org wrote:
> >On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:  
> >> +    type: enum
> >> +    name: clock-quality-level
> >> +    doc: |
> >> +      level of quality of a clock device. This mainly applies when
> >> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
> >> +      The current list is defined according to the table 11-7 contained
> >> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
> >> +      by other ITU-T defined clock qualities, or different ones defined
> >> +      by another standardization body (for those, please use
> >> +      different prefix).  
> >
> >uAPI extensibility aside - doesn't this belong to clock info?
> >I'm slightly worried we're stuffing this attr into DPLL because
> >we have netlink for DPLL but no good way to extend clock info.  
> 
> Not sure what do you mean by "clock info". Dpll device and clock is kind
> of the same thing. The dpll device is identified by clock-id. I see no
> other attributes on the way this direction to more extend dpll attr
> namespace.

I'm not an expert but I think the standard definition of a DPLL
does not include a built-in oscillator, if that's what you mean.

> >> +    entries:
> >> +      -
> >> +        name: itu-opt1-prc
> >> +        value: 1
> >> +      -
> >> +        name: itu-opt1-ssu-a
> >> +      -
> >> +        name: itu-opt1-ssu-b
> >> +      -
> >> +        name: itu-opt1-eec1
> >> +      -
> >> +        name: itu-opt1-prtc
> >> +      -
> >> +        name: itu-opt1-eprtc
> >> +      -
> >> +        name: itu-opt1-eeec
> >> +      -
> >> +        name: itu-opt1-eprc
> >> +    render-max: true  
> >
> >Why render max? Just to align with other unnecessary max defines in
> >the file?  
> 
> Yeah, why not?

If it wasn't pointless it would be the default for our code gen.
Please remove it unless you can point at some code that will likely
need it. We can always add it later, we can't remove it.

