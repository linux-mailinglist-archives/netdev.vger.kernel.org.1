Return-Path: <netdev+bounces-241468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6FC8433C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4946E4E8A62
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A72D5932;
	Tue, 25 Nov 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C+oiZatp"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843E263F54;
	Tue, 25 Nov 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062558; cv=none; b=PJOtjAQiuJxoE2XgptoTcxS6IVrxzQp5oS8GkukEdNBEptBG8wVp+Dy7uSLbV8gNALdCUf2QrgAaEjl/ArRbewfJwMxFXlpiG+yMq/RgzETHk/pW7rdG3853l4UnwGntLfElwH8zL5UyOl4/fX5wmTkd+3NcC+RJwGaPDYbi1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062558; c=relaxed/simple;
	bh=mJe8Ol5zu15ROz1lQUNhj0gcawQLQyowBXNhlhmGTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb9M/4JGo93j346Nb5nmhhcXM5EdRmhtT/NzVYaPJdsUE+oLfwN/HwkQs8lGGwwczu4NOeeu+9taCUUhPPQKbP22T1Zcp8G5e+q4h+rM5+6IcMrJFfg5OlHhmb2JbKlydJApRIkkusApdKmxlyJncSZMNkX4AH5Bno5yaI8zSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C+oiZatp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q7H8tjTTGIlQYy6DhRbnU03Mn/CHXGlMY016rFAkQ5A=; b=C+oiZatpl9yGNxOCzw33bIBnGr
	UYgzm1d0p3reNz0/zF08nXVWdFT4/x1wxmBjPzznipxIt+bQ7zfJHjfLdUWRgXV1m/bq6vqGxHzMD
	LCFNOiwZqr05sQgDG7bzkh7uumoUyMm1MKPPNOp5YLPeV6j6yxwpZPvJH6eVn+Whs6/ujXtQJkf9g
	w6z8FpGethal/Y0S2U5PciJFzJ5GX3aj8ArzU3gQLroio4rnKKDqsqQ7/+Cb/snNmbxmtk1xPzfJB
	tHwt8f1VvhQ128DSJGAuj7e5g761bOvIVXOjeR3S4iSFM6V/ss4OUgOE3NCneH0Ki19LRvfoD9ryI
	aRVWMa2A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNpFf-003I1X-In; Tue, 25 Nov 2025 09:22:23 +0000
Date: Tue, 25 Nov 2025 01:22:18 -0800
From: Breno Leitao <leitao@debian.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>, "michal.kubiak@intel.com" <michal.kubiak@intel.com>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 4/8] idpf: extract GRXRINGS
 from .get_rxnfc
Message-ID: <2ewdkayyhcjbf45v7laudrqjw3z443amelwwmnz5bzzcz7ogo4@qs6gwysc2kvk>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
 <20251124-gxring_intel-v1-4-89be18d2a744@debian.org>
 <IA3PR11MB8986B2AF393FF9E3609C9DB0E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986B2AF393FF9E3609C9DB0E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Debian-User: leitao

Hello Alex,

On Tue, Nov 25, 2025 at 06:48:08AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Breno Leitao
> > Sent: Monday, November 24, 2025 7:19 PM
> > To: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>
> > Cc: michal.swiatkowski@linux.intel.com; michal.kubiak@intel.com;
> > Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; intel-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; kernel-team@meta.com; Breno Leitao
> > <leitao@debian.org>
> > Subject: [Intel-wired-lan] [PATCH net-next 4/8] idpf: extract GRXRINGS
> > from .get_rxnfc
> > 
> > Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> > optimize RX ring queries") added specific support for GRXRINGS
> > callback, simplifying .get_rxnfc.
> > 
> > Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the
> > new .get_rx_ring_count().
> > 
> > This simplifies the RX ring count retrieval and aligns idpf with the
> > new ethtool API for querying RX ring parameters.
> > 
> > I was not totatly convinced I needed to have the lock, but, I decided
> 
> totatly -> totally

Good catch, I will update and respin with your "Signed-off-by".

Thanks for the review,
--breno

