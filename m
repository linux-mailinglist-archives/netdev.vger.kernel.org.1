Return-Path: <netdev+bounces-175811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE8A678B0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A417B183
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39320F085;
	Tue, 18 Mar 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j0cYec3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77517A2F5
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313956; cv=none; b=BCfvGI1oqZA26o5AjDaLlJtRfwCSrq7NO1zmhmpB6O2VrOUlUdrntV4UgA+jK2rtRQI7Ks9Xn+d8piZpQq44WOY6YnxcWfEdzZIKS5fZ6FZQPaUDNsYaSIgaIdZTg9j/WJMT5mpJKR/yxk1Y5mfUiz3DGGSBfZE7Ei2+md1jjhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313956; c=relaxed/simple;
	bh=ghwoD6qKE8bbStyJ0qOTqKHxurGar0N8QCFAMT6+dR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxIYnD1HnIk+Gyt9TDWK4+sszg13qn3X2QTfms/GpKQNAz00helsyeINXfFKzLp+X9wIZprXjR54ysKBt6ZH3TF1Yze1YFTYnWRJes6F5s+Jp+K3h7bzTLZDy6kgRl+u2mZiI5KNTC7uqeiCoDoS0I/ZPp4IupI2HGYDynyLYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j0cYec3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A145BC4CEEA;
	Tue, 18 Mar 2025 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742313955;
	bh=ghwoD6qKE8bbStyJ0qOTqKHxurGar0N8QCFAMT6+dR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0cYec3wWFvFVx0FUEHU0epAr40fRv9+18uzrjehIBlq709DbBEbTsM5jsQhsr0kV
	 jLvEwGmKWOk1P1cWyImWTbixPUwu4H1cmExGiuuExuh50vuZ6F9OSIUfb3pmqTqoa3
	 GI30nWoLjoHCLBDr9Bxgb4hqnsx7NivShmjTj2es=
Date: Tue, 18 Mar 2025 17:04:37 +0100
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
Message-ID: <2025031817-charter-respect-1483@gregkh>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
 <2025031848-atrocious-defy-d7f8@gregkh>
 <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6exs3p35dz6e5mydwvchw67gymewpzp5qyikftl2mvdvhp3hqf@saz6uetgya3l>

On Tue, Mar 18, 2025 at 04:26:05PM +0100, Jiri Pirko wrote:
> Tue, Mar 18, 2025 at 03:36:34PM +0100, gregkh@linuxfoundation.org wrote:
> >On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> It is hard for the faux user to avoid potential name conflicts, as it is
> >> only in control of faux devices it creates. Therefore extend the faux
> >> device creation function by module parameter, embed the module name into
> >> the device name in format "modulename_permodulename" and allow module to
> >> control it's namespace.
> >
> >Do you have an example of how this will change the current names we have
> >in the system to this new way?  What is going to break if those names
> >change?
> 
> I was under impression, that since there are no in-tree users of faux
> yet (at least I don't see them in net-next tree), there is no breakage.

Look at linux-next please.

> >Why can't you handle this "namespace" issue yourself in the caller to
> >the api?  Why must the faux code handle it for you?  We don't do this
> >for platform devices, why is this any different?
> 
> Well, I wanted to avoid alloc&printf names in driver, since
> dev_set_name() accepts vararg and faux_device_create()/faux_device_create_with_groups()
> don't.

If you want to do something complex, do it in your driver :)

> Perhaps "const char *name" could be formatted as well for
> faux_device_create()/faux_device_create_with_groups(). My laziness
> wanted to avoid that :) Would that make sense to you?

I wouldn't object to that, making it a vararg?  How would the rust
binding handle that?

thanks,

greg k-h

