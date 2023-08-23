Return-Path: <netdev+bounces-29909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AB785281
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C1C2811FA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE983A930;
	Wed, 23 Aug 2023 08:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FE8BF6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C03C433C8;
	Wed, 23 Aug 2023 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692778548;
	bh=f7/tnL/CYJkwKNLcLrlquf8W0oqouUPAZbxzQF2xWrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K29YbCvSIvPIqrCKyzF6IAffEdlYbhbCNNjtIERAkM39WOwz/obWYbhEcPuC8WYTw
	 IRvra7Xt1BozBNGXoyiLEp4yBZFEMiH4plosQCODwPjZApgakAChJ4c9p2Hu+sI5VE
	 JP8V0gaTauWxvLnx2Ti8GdmxbTFgmQMdp8kAW7RQ=
Date: Wed, 23 Aug 2023 10:15:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>,
	Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
	rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexander.deucher@amd.com, rdunlap@infradead.org,
	quic_jjohnson@quicinc.com, horms@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023082333-unruly-explode-9ee8@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
 <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
 <2023082247-synthesis-revenge-470d@gregkh>
 <87a5uiw5x4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5uiw5x4.fsf@kernel.org>

On Wed, Aug 23, 2023 at 10:53:43AM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
> >> So I wonder if the right answer is to put it in drivers/net/wireless
> >> initially and if we come up with a need later for non wifi producers we can
> >> discuss moving it at that time.
> >
> > Please do so.
> 
> Sorry, I haven't been able to follow the discussion in detail but just a
> quick comment: if there's supposed to be code which is shared with
> different wifi drivers then drivers/net/wireless sounds wrong,
> net/wireless or net/mac80211 would be more approriate location.

That's fine with me as well, just not drivers/core/ please :)

thanks,

greg k-h

