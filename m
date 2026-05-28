Return-Path: <netdev+bounces-292701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOz5Gl9MGGomiwgAu9opvQ
	(envelope-from <netdev+bounces-292701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F15F3640
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A274305900C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293CA276028;
	Thu, 28 May 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eqGqDaLW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B96278156
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976567; cv=none; b=igTYYaISesTE8BPyCdJmb4MVI6deTj+aiBaAxdLMxEO2JWAXq5u8XT0ZOdX0QacmFFm/deGoq7JB6hu8rFXAE+T/CxLqmE1G6fm3YKM7GyXpwcg26Ju0nYHuUfXUemrbH+yB85VHlVkw9906WcsoF+v1ZTI30qA9EBppF4CbOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976567; c=relaxed/simple;
	bh=sCSQ5HbhCn8i/fFMjt3uOy73ZrhyU4DAkaXE5rS7JaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOxyorjtB12efLWr+tNVMxvKrhjdZOEv6mSOX8awxbJkCvoFc+AcVVnTgrIMQUWHmIjmMjq/A1mRHiyAcuG3mHj4+2uf8ZOEflFpEDmiMbkV4Z3bPcz1aa1Mr3N8rkGIwXI8BGZBAFeVVODGnjfk38qrlN0Sltj29BOIUnwEavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eqGqDaLW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=52gB7Eae4dUX0sy0L8AsYJIyqGuI1ysRBUwMs+7FmYo=; b=eqGqDaLW3CQR9Gb7eXx2+G4Yr5
	wbjSpf3XF1+pAV6Cj8WST1HEZmM05BKet/SYeDiPmL6jFTbu+FXzerTkHgli4vS2Rev5501yc881d
	Mast3Ln24lt9mKcU4h6VrPKBp9/T/F4c1yhXpdNiuLvTAyGXKyCnqt9dKW5J8LslTIrM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSbDM-004uIr-Hx; Thu, 28 May 2026 15:56:00 +0200
Date: Thu, 28 May 2026 15:56:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: phylink and an unusual PHY/SFP setup
Message-ID: <a0a33a64-411f-4612-bd9e-1ee8c705ec1a@lunn.ch>
References: <DITB8QZ1OEQF.327XUI9E0SXQ3@kernel.org>
 <061815ee-e95e-4723-aa2a-d84bc3ad6233@lunn.ch>
 <DIU79B74YFW6.1NBOTHFQQ65A5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIU79B74YFW6.1NBOTHFQQ65A5@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-292701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 734F15F3640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Thanks for the pointer. It looks like this can be used to support
> both the Base-T port and the SerDes port of this PHY.
> 
> But I'm still trying to wrap my head around the SerDes links and
> it's configuration. Basically, phylink tries to match both ends of
> the link and will configure the PCS and the PHY accordingly. But in
> my case, the link between the MAC/PCS and the PHY is always SGMII
> (at least that's what the Marvell datasheet says). The line side of
> the PHY is then either Base-T if using the copper port or 1000Base-X,
> 100Base-FX or SGMII on the fiber port.
>
> If I add these modes to the possible_interfaces property, the PCS
> might be configured wrong, that is, in 1000Base-X mode for example.
> But it really should only be ever in SGMII mode.

You have something like rate adaptation for the PCS-PHY link.

This is something you sometimes see for multigigi PHYs, where the
MAC-PHY can uses a fixed mode, e.g. 10GBaseR, independent of what the
media does. Pause frames are then used to slow down the MAC to the
media speed. So it might be you can abuse rate adaptation to do what
you need.

What could play a role here is, if the media is running at 100Mbps
does the MAC need to know to use SGMII at 100Mbps? This is different
to rate adaptation, where the MAC is fixed. Also, if it is using
100Base-FX, does it want the SGMII to run a 100Mbps?

So rate adaptation might not help. But the phylink code around rate
adaption might give you some ideas how you can handle this.

   Andrew


