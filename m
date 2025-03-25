Return-Path: <netdev+bounces-177484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AFA704E6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79C6173FF9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4B25D529;
	Tue, 25 Mar 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ+2HZsa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F525D52F
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916061; cv=none; b=W1evdHqo/iP3Xy8L1kcMMq24wxGbCm1YsQSkUmJqhuQ6TBxvHMR1kHJ1DN/U0+0VoMDLAPDnWPCUvyiNnNBjBjaFYAj+u+zaBgzoyp9Y8JU/zgiEB/FcRuHWoOOI7OLer/nf3o5e3rD7cFeGLq5sLTej9ikzb/XvPng6jRCjALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916061; c=relaxed/simple;
	bh=jRjEZkuasdP2Y6bo3n1Ll13SMx3q8a4wDptWsbzEyNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwKGaYKwL7bkAwhReuO7xnURzkCBd8DZm5fSNOZbsdTySrKYyULMqmtoGIu09Q+x/2zV3fTJ89t/7aDsvqMLldscThfiqn7ZtLJeRRx8s2anN1NixHjUWdJlvou5PFB/tVrh7Ppi8IPOSgmp0Gd+qx1Y/geLEkXXDRokh9Vz2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ+2HZsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A637C4CEE4;
	Tue, 25 Mar 2025 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916061;
	bh=jRjEZkuasdP2Y6bo3n1Ll13SMx3q8a4wDptWsbzEyNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ+2HZsarEvfjZcuADuA+GyBUFazxpt8THVIe6F76i8v/MgqsWKlTx7DuFulmfkYW
	 5Oq2+b4nkJqXAUc06cX+EeP7AM6UsdLFC0mqaff5YSRJX833jgkmAkAK13tgMocruu
	 1+q9352vQvEcDQrI6Pw7wSsD5EtGGO/lw2PGU4vp1Ijgxj9+KZTRbuC4HIjS+e9lZe
	 PQxmVlcPIqA9QPUH+D1pjbzmG94/jn59qwg/wJ3rcM12PHYH5Zu7uE/ep17KAnapnL
	 4aMUs9txQFB8oszOcZbcHpCGlqiKmKH7xXbIn+xErq60KrMo9GqiEmD3tTHxr39olt
	 r5PBCP3ApYplw==
Date: Tue, 25 Mar 2025 15:20:57 +0000
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 5/6] net: ngbe: add sriov function
 support
Message-ID: <20250325152057.GS892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <9B4D34D65A81485C+20250324020033.36225-6-mengyuanlou@net-swift.com>
 <20250324192116.GK892515@horms.kernel.org>
 <D3FEA7AF-1990-40DF-903C-30790ED782E9@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D3FEA7AF-1990-40DF-903C-30790ED782E9@net-swift.com>

On Tue, Mar 25, 2025 at 10:36:00AM +0800, mengyuanlou@net-swift.com wrote:
> > 2025年3月25日 03:21，Simon Horman <horms@kernel.org> 写道：
> > On Mon, Mar 24, 2025 at 10:00:32AM +0800, Mengyuan Lou wrote:

...

> That’s right.
> > If so, I believe this addresses Jakub's concerns.
> > 
> > And given that we are at v9 and the last feedback of substance was the
> > above comment from Jakub, I think this looks good.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > But I would like to say that there could be some follow-up to align
> > the comment and the names of the handlers:
> > 
> > * "other" seems to be used as a synonym for "misc".
> >  Perhaps ngbe_msix_misc() ?
> > * "common" seems to only process "misc" interrupts.
> >  Perhaps __ngbe_msix_misc() ?
> > * msic seems to be a misspelling of misc.
> > 
> 
> 
> >> +static irqreturn_t ngbe_msix_misc(int __always_unused irq, void *data)
> >> +{
> >>  ...
> >> + return __ngbe_msix_misc(wx, eicr);
> >> +}
> >> +
> >> +static irqreturn_t ngbe_misc_and_queue(int __always_unused irq, void *data)
> >> +{
> >>  ...
> >> + return __ngbe_msix_misc(wx, eicr);
> 
> 
> if (wx->num_vfs == 7)
> 	err = request_irq(wx->msix_entry->vector,
> 			  ngbe_misc_and_queue, 0, netdev->name, wx);
> else
> 	err = request_irq(wx->msix_entry->vector,
> 			  ngbe_msix_misc, 0, netdev->name, wx);
> 
> It’s more appropriate.
> 
> Thanks！

Yes, thanks.

And I also think it would also be nice to rename ngbe_msix_common()
as __ngbe_msix_misc().

But please hold off with any updates or follow-up as net-next is now closed
for the merge window.

Link: https://lore.kernel.org/netdev/20250324075539.2b60eb42@kernel.org/

...

