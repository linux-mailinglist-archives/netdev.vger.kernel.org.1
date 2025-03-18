Return-Path: <netdev+bounces-175851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D1A67AF4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3091682B6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D3211494;
	Tue, 18 Mar 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1bQo90u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64C20C486
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318916; cv=none; b=SxrgurTjhAH8RAZVVlwwRu9fp0jQMC6mjHteYP2xUDyfASbwODuW0olMPycCQBlgIJLLm4WDj2UA4YC6FYPhfTt64emGnwWsz/qJtqQo6nPHeemWy4nCPYlGaO0aPUhliKNBuQiJ6QwPxnotw3fwoZaqc+G/fn1vh9APPPVRDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318916; c=relaxed/simple;
	bh=oiC9s/9JVzZzDZptevEjbjx3C+zLhqEE861H8SmuBUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsH2qaHgDTUDkbw00D576uPjlcJiw/svys2zhKM3zaQ29d9KMgwV9hfg4BYkfqD+RkswYfsV0kRx8bs/hYwiOLtGoCENqN6jdj/wfHSBtdE+dBRCmcXjA0I4QRHQkP+gpNGZi7Bu9u0joqqPAy0pi5ZX4IpMyHRETTYMY+WNWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1bQo90u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDA5C4CEDD;
	Tue, 18 Mar 2025 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742318915;
	bh=oiC9s/9JVzZzDZptevEjbjx3C+zLhqEE861H8SmuBUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z1bQo90u+DfRM3mzgmOjFp7Xj7E9ePWyR2wjhFYOBVF3bwa8vMi/hpNOU10KQpYTC
	 oM4HTZRuV4t8yvbUizgeP6WdnMRMJVeQwOeCxvdbRiczKza4vonhQJ3cK6y76v8v2b
	 hRucukbwiIG2FKQnS7CRFqJmMYFOT/98JTfapk+E=
Date: Tue, 18 Mar 2025 18:27:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	dakr@kernel.org, rafael@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, cratiu@nvidia.com,
	jacob.e.keller@intel.com, konrad.knitter@intel.com,
	cjubran@nvidia.com
Subject: Re: [PATCH net-next RFC 1/3] faux: extend the creation function for
 module namespace
Message-ID: <2025031817-stench-astound-7181@gregkh>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031848-atrocious-defy-d7f8@gregkh>
 <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>
 <2025031817-charter-respect-1483@gregkh>
 <paftiyrmjuiirv7j26eenezpqlszva55w2lmsutflmt2tfwufp@za2pg2q7t43n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <paftiyrmjuiirv7j26eenezpqlszva55w2lmsutflmt2tfwufp@za2pg2q7t43n>

On Tue, Mar 18, 2025 at 05:51:34PM +0100, Jiri Pirko wrote:
> Tue, Mar 18, 2025 at 05:04:37PM +0100, gregkh@linuxfoundation.org wrote:
> >On Tue, Mar 18, 2025 at 04:26:05PM +0100, Jiri Pirko wrote:
> >> Tue, Mar 18, 2025 at 03:36:34PM +0100, gregkh@linuxfoundation.org wrote:
> >> >On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> It is hard for the faux user to avoid potential name conflicts, as it is
> >> >> only in control of faux devices it creates. Therefore extend the faux
> >> >> device creation function by module parameter, embed the module name into
> >> >> the device name in format "modulename_permodulename" and allow module to
> >> >> control it's namespace.
> >> >
> >> >Do you have an example of how this will change the current names we have
> >> >in the system to this new way?  What is going to break if those names
> >> >change?
> >> 
> >> I was under impression, that since there are no in-tree users of faux
> >> yet (at least I don't see them in net-next tree), there is no breakage.
> >
> >Look at linux-next please.
> 
> Sure, but it's still next. Next might break (uapi) as long it's next,
> right?

The point is that these conversions are thinking that their name is
stable.  This change is going to mean that those patches that have been
accepted into different trees are going to change.

> >> Perhaps "const char *name" could be formatted as well for
> >> faux_device_create()/faux_device_create_with_groups(). My laziness
> >> wanted to avoid that :) Would that make sense to you?
> >
> >I wouldn't object to that, making it a vararg?  How would the rust
> >binding handle that?
> 
> Why should I care about rust? I got the impression the deal is that
> rust bindings are taken care of by rust people. Did that change and
> we need to keep rust in mind for all internal API? That sounds scarry
> to me :(

I was just asking if you knew, that's all.

thanks,

greg k-h

