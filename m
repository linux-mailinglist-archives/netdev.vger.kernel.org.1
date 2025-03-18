Return-Path: <netdev+bounces-175760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C3A67697
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3D4189DE81
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090720E331;
	Tue, 18 Mar 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G412xa69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6520E016
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308673; cv=none; b=Zti0k/dr3jzuEAe1sy3HObv6etYHaCFBpPet2CP9pqJQ0z3pNwt2tQHg3O/3ds+YAQ1hE/Db1g3Po/oviwtrWxhai787NsIbENzaWLX9t44Teob5XnTaz+29dbM0mHKGE62ydUP4EnB/OjfNueqqC/Femh2uRoQD3a3ZlB7Usjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308673; c=relaxed/simple;
	bh=zl09RxUHK79RbAgkS5LPxdFkQciDfP5HRJeXpwwbRdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBucPxQN9QSJ0MCb23Oz0CRgR1wJe2lhuCwDT0gOplIicKD00KblAnnvsYIs6J6J0Amw+fcK9lDhaeibkEysQn4Jdoi+1U/LlJPBf5PnSoV9xsch51pm2e/ZIE/k6ltNmIy/XvgDkkg98cro+oPEgJQ/ZFAwE013jWOgG45waYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G412xa69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1569C4CEDD;
	Tue, 18 Mar 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742308672;
	bh=zl09RxUHK79RbAgkS5LPxdFkQciDfP5HRJeXpwwbRdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G412xa695cOeqCYz7kgw6vlSX7FgBz/hZ1exT/UTy6ENkwnsxjLaoEAdGfPo6rYpn
	 gYMLrIpXJMAP8HbQW3JibI9Ey9FqgcC6xnVRZX6yf0F6FMYOAsiWajtvHahF1h7C9/
	 fD0A/tkHVu6cARB+FL6eDBjD61MAhM99paaL3uec=
Date: Tue, 18 Mar 2025 15:36:34 +0100
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
Message-ID: <2025031848-atrocious-defy-d7f8@gregkh>
References: <20250318124706.94156-1-jiri@resnulli.us>
 <20250318124706.94156-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318124706.94156-2-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 01:47:04PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> It is hard for the faux user to avoid potential name conflicts, as it is
> only in control of faux devices it creates. Therefore extend the faux
> device creation function by module parameter, embed the module name into
> the device name in format "modulename_permodulename" and allow module to
> control it's namespace.

Do you have an example of how this will change the current names we have
in the system to this new way?  What is going to break if those names
change?

I say this as the perf devices seem to have "issues" with their names
and locations in sysfs as userspace tools use them today, and in a
straight port to faux it is ok, but if the device name changes, that is
going to have problems.

Why can't you handle this "namespace" issue yourself in the caller to
the api?  Why must the faux code handle it for you?  We don't do this
for platform devices, why is this any different?

thanks,

greg k-h

