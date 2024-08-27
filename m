Return-Path: <netdev+bounces-122393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD456960F08
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465A4B2621A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E71C6F4F;
	Tue, 27 Aug 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/i7s+Rx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E51A0B13
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770448; cv=none; b=gF+lO1UVQ7iKw11OUIIkv5a+UaMXEEnWT+BxzcPAJSL+odw6oIx+3BSA3aPqqNxNx/pzsbh6mos+DIGPbgHjdQKymFTNxp0/iGIOTIevqq/KCSlSreS5vIvjVs1aBE60nfjh0RgUrnneG5RaXaUo64RIcSbYl3YrYffcGP7qN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770448; c=relaxed/simple;
	bh=NzkbXCQ6oRZ5brETtZBp+dmKmn5D5WKybr9JpU3Z5Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evPahPrwcMYFdwA/+x537Sc8S6TpoctEBPwAqzwvsNsu+6iDPqXouaRmWAvVbQg/jfQri+diB5amVSt1kbdnlTbE/HRAo8LE0XhlCKgzw0vSh7IYljfgdr8SMYQylKCqTUVpPFYbc0uCfGmFv/jLT0VaI2MZ46w0Yhg4kItHcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/i7s+Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0213C6106F;
	Tue, 27 Aug 2024 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770448;
	bh=NzkbXCQ6oRZ5brETtZBp+dmKmn5D5WKybr9JpU3Z5Cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i/i7s+RxsHzmqYS96bIudi0gAOX/+YgeSEflaEh6v9LAvO1m1AWCmEbIn/gj9jlKd
	 UoyJARP/xiPta+VtytlgrsIbTtZoNoihtmSFz1ijDL7zVKKC+m57LvHG3Q82MoyvoX
	 bfRcgwKXMLRGWqCU2N7pKYP3aT1ZHKHdhI6pl/TpzRO+l3yebqFN92ZRhvhftGGMpe
	 kbYnkqcNAZ7Ti7mzkH7bGDQAvrgAdMqjsOqnPh0yOUqTI2ByKTOCC2DdXgdpQr08VR
	 AJ3RQJAV3K1Na7HSQ1R+I9s/Xyu9/4bltjJNdSATS723C7h8uVJw5obtxEs4lr+51F
	 VZHXt1iAzI5TA==
Date: Tue, 27 Aug 2024 07:54:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240827075406.34050de2@kernel.org>
In-Reply-To: <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
	<47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
	<Zsco7hs_XWTb3htS@nanopsycho.orion>
	<20240822074112.709f769e@kernel.org>
	<cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
	<20240822155608.3034af6c@kernel.org>
	<Zsh3ecwUICabLyHV@nanopsycho.orion>
	<c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
	<ZsiQSfTNr5G0MA58@nanopsycho.orion>
	<a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
	<ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
	<432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 16:37:38 +0200 Paolo Abeni wrote:
> > What's stopping anyone from diverging these 2-n sets? I mean, the whole
> > purpose it unification and finding common ground. Once you have ops
> > duplicated, sooner then later someone does change in A but ignore B.
> > Having the  "preamble" in every callback seems like very good tradeoff
> > to prevent this scenario.  
> 
> The main fact is that we do not agree on the above point - unify the 
> shaper_ops between struct net_device and struct devlink.
> 
> I think a 3rd party opinion could help moving forward.
> @Jakub could you please share your view here?

I don't mind Jiri's suggestion. Driver can declare its own helper:

static struct drv_port *
drv_shaper_binding_to_prot(const struct net_shaper_binding *binding)
{
	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
		return /* netdev_priv() ? */;
	if (binding->type == NET_SHAPER_BINDING_TYPE_DEVLINK_PORT)
		return /* container_of() ? */;
	WARN_ONCE();
	return NULL;
}

And call that instead of netdev_priv()? 

