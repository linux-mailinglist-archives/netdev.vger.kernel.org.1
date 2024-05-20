Return-Path: <netdev+bounces-97233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFD8CA32F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1161C210F4
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E66136988;
	Mon, 20 May 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7VD5wz+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE536A2D;
	Mon, 20 May 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236289; cv=none; b=mpYs3VveP2BrZ1kuZFj6LOXSNcKbUqvM7yde9WplhPbGOBLjbdE/RzgDR9hVEE9oFK0VUK6GNQ0ZjCPa2a1QsEtnkv396R+p/Zu2uR1Kaoc2DSeTaXCgE5xx1p3jtu4O7GP2A4oNu8pima90rxJgiFkBwyfCyhwm5GDozT+8mcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236289; c=relaxed/simple;
	bh=LcKby/XxbtDN9O7Z30k0Ah2AUXHNqqqz9xCEDpiWHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2xEpEzMPHYqkdi4b8GGWRSxa+XGdBXdi15+OBUWlh09KeNXv7BdZA7JEuiZ4gLZEdw/dAlIhk1+Z3Anze7/lzoHv4uhQ2r8HEbv0EIjiPViBnZVP8CQ2scdEmISnPT3Ia+jYbP8h118U8QF6uBIYXWropFmdr7x/4hBGCrpgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7VD5wz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5FEC2BD10;
	Mon, 20 May 2024 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716236288;
	bh=LcKby/XxbtDN9O7Z30k0Ah2AUXHNqqqz9xCEDpiWHdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7VD5wz+D67o/zSiHS9pLgUjHtdcUFeR+MoeScDi8mcuPr1aQFtCySAHB4axmvtNO
	 Yoq16cjAnhSDsZR//gUc3lPrhdZrfTPpux4gxc7lgBnHSK37H2l1zZAIhpaRyRc+wM
	 h9gNGsbfmCxTYmtiXbdrQXpS4hsYXx8p7Gxhz+ruL7Ph5Epkj+1A1BikxAIJGEVug+
	 kIMYiSUeQVWqf70N9yxSAZZE4z7f9K0gw5ShQpt47vJmE319UnO/VrxCieyD8rllXG
	 M9byGZTyriphKf9Ks2aVCH5wlVZZ6klcba3bRLqYM5BB9Jf9iMGVZzrwFSUgC/36D4
	 btsPK/+vIYUxA==
Date: Mon, 20 May 2024 15:18:07 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kip Broadhurst <kbroadhurst@ti.com>,
	w.egorov@phytec.de
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240520201807.GA1410789-robh@kernel.org>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
 <20240520-discard-fanatic-f8e686a4faad@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-discard-fanatic-f8e686a4faad@spud>

On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
> On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> > Hi Conor
> > 
> > On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > > > > license for TI specific phy header files. This allows for Linux
> > > > > kernel files to be used in other Operating System ecosystems
> > > > > such as Zephyr or FreeBSD.
> > > > What's wrong with BSD-2-Clause, why not use that?
> > > I cut myself off, I meant to say:
> > > What's wrong with BSD-2-Clause, the standard dual license for
> > > bindings, why not use that?
> > 
> > want to be inline with License of top level DTS, which is including this
> > header file
> 
> Unless there's a specific reason to use MIT (like your legal won't even
> allow you to use BSD-2-Clause) then please just use the normal license
> for bindings here.

Aligning with the DTS files is enough reason for me as that's where 
these files are used. If you need to pick a permissive license for both, 
then yes, use BSD-2-Clause. Better yet, ask your lawyer.

Rob

