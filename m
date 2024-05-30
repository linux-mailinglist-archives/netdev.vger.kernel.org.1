Return-Path: <netdev+bounces-99576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754458D55D9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3276B28436A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66793182D36;
	Thu, 30 May 2024 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Vaz8YzkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9C17545
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109932; cv=none; b=cC6gWC+jfxuZTE2gxgBZTp+ATvBvIFvkuKmfCy6sh5gKDflFCSUiVlB2n3rHO5uZ3xXnKkJMW1Ce/xFfLccb1v2yFUgBkE7Riowo2sdB5MdOPloZIZ1ehOmqiodcEHFdWMqECwMx+fvc4n819kxOSLOS1whgGQ+iFDlnczT/lFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109932; c=relaxed/simple;
	bh=Jq6r0q8ZF/ZpTHVKE8X8G8KYD6MdvpqkZGQylyd1SSI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gZ2FVvjNpDDgd1BHgmPgp34jPkFEhXmZJynRVeoUsq0OyYAIHvYfRVw1vMexP74t/cLyH+bp5qmSK/0731TbOdXGa5Y73tbchqUi6WrykACe/YUfurGmfNxemE7J4bOtWQXDPX3C6d0CzORQrHNK14ruKi+mHUJz9I5I+pkp8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Vaz8YzkH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717109928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvcusO4PQAUlo0+E0P48o87ivsX2wyt2vqYbIdN9VTM=;
	b=Vaz8YzkHP7gCgStNdwxRYeCtu3TnOMyecF6R8MPxYGADjH28AzUF81KuLS98s1GwN9FR0d
	1Zt++TtlWW5e8bjjyL/RW3/B0NX9OAcfD6bK2d4B6MqKeCqk8RvZ3bHF+XQWU5ORB+Wbwe
	oOapgBItSJ+c59AeQ1u/TqmUpc07KCHiDKs55qvvXV9VtKXbrv2r4W3is0Y9mUkExZEYpl
	StTUdJiafs+lbEW4Dz84yBkfX8xALHieYVpMZfqRySvRhZl/WB7AbHHAW2LUZXH1K5rJAk
	5tWxGiB5buZ7jHQAbWA88X8tUqLpW830VttUelLGug9sX0tzopOnvQWZmhIGcQ==
Date: Fri, 31 May 2024 00:58:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] iproute2: color: default to dark background
In-Reply-To: <27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
 <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
 <27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
Message-ID: <c879a566846187e3313f8448f1c21548@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-29 18:36, Gedalya wrote:
> On 5/30/24 12:23 AM, David Ahern wrote:
> 
>> On 5/22/24 12:43 PM, Gedalya Nie wrote:
>>> Since the COLORFGBG environment variable isn't always there, and
>>> anyway it seems that terminals and consoles more commonly default
>>> to dark backgrounds, make that assumption here.
>> Huge assumption. For example, I have one setup that defaults to dark
>> mode and another that defaults to light mode.
> 
> The code currently assumes light mode and it's generating complaints.
> It seems like we need to figure out a way to find some support for
> whatever is the best assumption.

I think it would be best to modify the logic to require the presence
of COLORFGBG in the environment to enable colored output, if requested
by the user, or if built to be enabled by default.

>>> Currently the iproute2 tools produce output that is hard to read
>>> when color is enabled and the background is dark.
>> I agree with that statement, but the tools need to figure out the dark
>> vs light and adjust. We can't play games and guess what the right
>> default is.
>> 
> That's not possible.
> 
> COLORFGBG won't be allowed through by SSH servers.
> 
> If you try to write \e]11;?\a to the PTY you need to establish a
> timeout. There won't always be a response.
> I'm not aware of any good way to do this, though I'm certainly not an
> expert. But I don't think that tools "figuring out dark vs light and
> adjusting" is a thing. If you just so happen to be happy with your
> results then so was I until Debian changed the way they build iproute2
> and I never even used color overrides -- now I do. Tools just throw
> colors in your face and no, there is no really good and universally
> working way to be smart about it.
> The fact remains that the code currently makes an assumption and I
> don't see why it is better than the other way around.
> We need some kind of (possibly crude) way to assess what is more
> common, light or dark. But as I have pointed out already, as long as
> graphical terminal emulators are concerned, the reality out there is
> that people use themes and such and the ANSI color codes don't dictate
> the actual color displayed. But on a linux vt it is easier to say that
> the background will be dark, and it's neither simple to change the
> background nor to override the way ANSI colors are displayed.

