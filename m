Return-Path: <netdev+bounces-155270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55681A01962
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 13:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B992F18835DB
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A413D244;
	Sun,  5 Jan 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RT38Wv/+"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8D35959;
	Sun,  5 Jan 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736080189; cv=none; b=u8vWsFQ8lNLHuakGbLFxZ6n9CzOW6iQj/nC8Tr9TpZbmGkmpIbX1xskYmvx8b6av+SkjsHubrjTyuSZSzPvPWpchawk6fl6CBLJ9USPq5cih4xElZbriDzMqlDEo3dt9RXweQDRupFPzNmjUepsUiC8KxQRHHD9bJg1srB0Ernk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736080189; c=relaxed/simple;
	bh=TAjQfCdZ/FJT3DXIKIhAVl0OxkdP6KSsOcc7vBHPTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbcdPWbCYuLO+2GYNdtaOGYjTbJ6mpyP+iaSpShp8lNmC8i1angL7NeIHcAYOjOZMeRWAh1R75vlvV7WJRGPSqEaFIy938+Ev3PIz95QDo/X9dWTwalDjzcmyoxqZYqbVRmMZ3hxuutWVQ++GyiHm2vLP4QRFs2+xhsD4Q4lEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RT38Wv/+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=hJaegaA4URsS9dJNooiDBvKtyhjiY7wAcR6BnE5DN4Y=; b=RT38Wv/+pIhkwVsh
	TztEav7fSMMaGGEapV+WZLY09llb2RyHeaauQtQXaJO3Iqvt0LC70sb0LbGaljMuNaP0KGOllUqQx
	ItI+7jZIhybussrp3Yvo2Nc8OLrptPA/3eaDp/UmBxJiF+hgaJFdVigEsCN0aQ6aa2E30aKFgOBEz
	fLSTQXk6c6QPzRt+7zgVPvxh5c2IzgpRdwLIozzC3BSNt1vAmUxGl/V8SMPn6zSj87aYyZOzXbeDQ
	FifaaTMmkdZ8PDhsxAvq0EYdHoSpSdgkmHqp1J9X7vovFl2DTV+5yoQLljAelYLklaAJ9+XpsbngU
	O247T9IS7ScYGFO+LA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tUPlE-008DUi-0O;
	Sun, 05 Jan 2025 12:29:40 +0000
Date: Sun, 5 Jan 2025 12:29:40 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <Z3p7NDKTrMpm0Y_-@gallifrey>
References: <20250102174002.200538-1-linux@treblig.org>
 <20250104081532.3af26fa1@kernel.org>
 <Z3muiBPv30Dsp8m5@gallifrey>
 <20250104165440.080a9c7b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250104165440.080a9c7b@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:29:05 up 241 days, 23:43,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jakub Kicinski (kuba@kernel.org) wrote:
> On Sat, 4 Jan 2025 21:56:24 +0000 Dr. David Alan Gilbert wrote:
> > > This one doesn't apply, reportedly.  
> > 
> > Hmm, do you have a link to that report, or to which tree I should try
> > applying it to.
> 
> net-next, the tree in the subject prefix:
> 
> $ git checkout net-next/main
> $ wget 'https://lore.kernel.org/all/20250102174002.200538-1-linux@treblig.org/raw'
> Saving 'raw'
> $ git am raw
> Applying: ixgbevf: Remove unused ixgbevf_hv_mbx_ops
> error: patch failed: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h:439
> error: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h: patch does not apply
> Patch failed at 0001 ixgbevf: Remove unused ixgbevf_hv_mbx_ops

Just sent:
Subject: [PATCH net-next v2] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <20250105122847.27341-1-linux@treblig.org>

on top of a few hour old net-next.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

