Return-Path: <netdev+bounces-154364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9029FD6DF
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C9918813A2
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C691F8699;
	Fri, 27 Dec 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNfW+dR5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548B1F7087
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323568; cv=none; b=nHEVJ3jJDBVxShYjdeIKzrdHfB2X3YdJG2OGuXc3XfXSRhEcrzYreolG3LJox3mpXnK/Wle2rleENpSCXcvMb1qkh7tZqVyzYKtBbkNYNaUud7lyvetO4p8ACkbQSjbC+fGuxZVCZROM5SDm64XCrzdF3dwWLBqhr5efoScz84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323568; c=relaxed/simple;
	bh=GSCeC0PZFzssyUn7faQeGdWZcGDJLNR9dwUOHB+f3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmnOeRq4rYJNwW6RQASN8adN1I9kEXF9+bRs/rp05+BzyKGBqUMEf3q0DcGJnilTNtcsE5akcuJT1Pya4GuTmqQ2arjXDnLj3+7rjODTRM2sx2mv7olt6JChFRcAWRGelim8Unqy1ivookAq5mRd5pFpmhbmyUPpxGYF8NVYcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNfW+dR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D952C4CED0;
	Fri, 27 Dec 2024 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735323565;
	bh=GSCeC0PZFzssyUn7faQeGdWZcGDJLNR9dwUOHB+f3uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNfW+dR5K9fzVgC8cMTaNr1sfN9eXXqXU+2ltkueG4lRXYJ6rF4rQRkmWETo7ai2F
	 ovHbIPna3ICb3DLuzHQe9l4w4m/k1F6eDKeTIGgcQ4oQt5g7FHDvqgYGz/++NsiiNX
	 v0VXZUXWH0DM5E3l6RyC92f+E6H4Klx8D2GpD2+GHnp4gd7tW2w9Z2yt+qYaO9JbdD
	 zeu+lcCncs0g4pVJmUHfMwGtrGIp+GmBi92HN1uNSCsEPjb4Xf3JS/H/T00HbgTdNh
	 7wOw8PIOBnReHVQNsJU2q7U2DI1Ynin49U1DRel27rgk8xl7Q9hD+rkY0qA3TE+FF2
	 Ct680Kkev4h8Q==
Date: Fri, 27 Dec 2024 10:19:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Shay Drori
 <shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Improve the port attributes
 description
Message-ID: <20241227101924.48a12733@kernel.org>
In-Reply-To: <PH8PR12MB72088C3633116EA320A55B5FDC032@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20241219150158.906064-1-parav@nvidia.com>
	<20241223100955.54ceca21@kernel.org>
	<PH8PR12MB72088C3633116EA320A55B5FDC032@PH8PR12MB7208.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 03:40:34 +0000 Parav Pandit wrote:
> > On Thu, 19 Dec 2024 17:01:58 +0200 Parav Pandit wrote:  
> > > Improve the description of devlink port attributes PF, VF and SF
> > > numbers.  
> > 
> > Please provide more context. It's not obvious why you remove PF from
> > descriptions but not VF or SF.  
> 
> 'PF number' was vague and source of confusion. Some started thinking that it is some kind of index like how VF number is an index.
> So 'PF number' is rewritten to bring the clarity that it's the function number of the PCI device which is very will described in the PCI spec.

Just to make sure I understand - you're trying to emphasize that 
the PF number is just an arbitrary ID of the PCIe PF within the chip, 
not necessarily related to any BDF numbering sequence?

If that's the case I think the motivation makes sense. But IMHO
the execution is not ideal, I offer the fact we're having this
exchange as a proof of the point not getting across :(

May be better to explain this in a couple of sentences somewhere
(actually I get the feeling we already have such an explanation
but I can't find it. Perhaps it was just talked about on the list)
and then just point to that longer explanation in the attr kdocs?

> For VF number, the description is added describing it's an index starting from 0 (unlike pci spec where vf number starts from 1).
> SF number is user supplied number so nothing to remove there.

nit: -EOUTLOOK.. please wrap the lines in your replies at 80 chars.

