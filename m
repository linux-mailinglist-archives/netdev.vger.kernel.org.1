Return-Path: <netdev+bounces-185960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D22A9C546
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE121887275
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79F238D5A;
	Fri, 25 Apr 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UaXUgZEk"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3DE220689;
	Fri, 25 Apr 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576572; cv=none; b=AGKVEEQIomzw2nvVBgUQFg+LBkvbyodmCSXZp+wxMk+ib7viKtTQyBvwi5EzIlWtCKS3sHV8dvTBHuFLBSuFMLzfnnuaiz/pdc04vtDXcpc6e+EjjXo7JYn96UHdxhElsZ+hQ+H+f01viTnfvYmKGws2+CZ+nVvNWT1UqwcTgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576572; c=relaxed/simple;
	bh=gpGRDHdicL5qCU2QfYfFeHbvEPIf7EPY6QQp9J9+Q30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYxoZ+7G5DL66EOetq4ikiwYPU0TZdI8EmBhGbz1CBco90dzmjUCIq4uVn/VPnuhgD5Sn2CUR35hUAOeAzJKOeu9UHR2ByVn/5iHcpOw26k7YAugnfPRaHVUH5FTxwfmxZHHPoMzy+SBGESiF3qfvDkjZHrbqFHBuGc/BDdUH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UaXUgZEk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5w/n2hhCwZkNSqAYh0Yx8uPPUzbk+9gJJIu48qyqz8M=;
	t=1745576570; x=1746786170; b=UaXUgZEkRciDlr+cD4gRvynalA67arPOzbIW6g06NyfasCG
	E0zn8YyZptH2mh3qQk031piE9oB7dhdzVuXsG+o8wmllNlODnk2dpj8wScoCneAMxx9Y7R+8QvGa0
	xiq5iPX5PN+K9LZs/m5uOFCWFTWbUdunt0/Hu95kKmEArsoXo/kbDjRff/zZCtDOE+C4J6vWeEBbt
	9QFR7x5y1uPWh9eObEb13ykeigUXaYN6C5NE8PDKmvDFzbxXbNF/TIVV5L7bcemtn7VAhn+5wN7rY
	sBbLDvc3H+xGzOuHEEhcWSq8mzuYcpUe0MzbEnBbyjxuaOUf7B5GNG0FGQY3KrWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8GCl-00000001N3X-2DsJ;
	Fri, 25 Apr 2025 12:22:47 +0200
Message-ID: <da41cb80e0acb08fd25c38876a29156b69322249.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: annotate RCU release
 in attach()
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matthias Brugger
	 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 25 Apr 2025 12:22:46 +0200
In-Reply-To: <20250425102050.GO3042781@horms.kernel.org>
References: <20250423150811.456205-2-johannes@sipsolutions.net>
	 <20250425102050.GO3042781@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-04-25 at 11:20 +0100, Simon Horman wrote:
> On Wed, Apr 23, 2025 at 05:08:08PM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > There are some sparse warnings in wifi, and it seems that
> > it's actually possible to annotate a function pointer with
> > __releases(), making the sparse warnings go away. In a way
> > that also serves as documentation that rcu_read_unlock()
> > must be called in the attach method, so add that annotation.
> >=20
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks :) Looks like Jakub already applied it, FWIW.

> Thinking out loud:
>=20
> * Without this patch I see the following, but with this patch I do not.
>=20
>   .../mt7915/mmio.c:636:5: warning: context imbalance in 'mt7915_mmio_wed=
_init' - wrong count at exit
>   .../mt7996/mmio.c:302:5: warning: context imbalance in 'mt7996_mmio_wed=
_init' - wrong count at exit

Right, that's what I was trying to get rid of.

> * The only implementation of this callback I found is mtk_wed_attach
>   which is already annotated as __releases(RCU);

Indeed, but sparse doesn't check that for function pointer
compatibility.

> * The only caller of this callback I could find is mtk_wed_device_attach(=
)
>   which takes rcu_read_unlock(). And the the callback needs to release it
>   to avoid imbalance.
>=20

Right, pretty sure that's all intentional (though I don't understand
it), hence this change to document it a bit better and get rid of the
warnings.

johannes

