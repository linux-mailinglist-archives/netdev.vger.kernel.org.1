Return-Path: <netdev+bounces-275153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IJyC3Xxz2mt1wYAu9opvQ
	(envelope-from <netdev+bounces-275153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E5396B07
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF2153004F32
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE975331A41;
	Fri,  3 Apr 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mBK8kSaD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD32DAFDF
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235441; cv=none; b=k/DBwm3IQLbucoboYwizrtu2lnapnXlheO69p4Nr6BDgynVufEPPVoQ6kfoZp2Y6AteiW2lmt46aouSBdcro46S98lLjdIZ3xXvhZkdA1aY09UQtzVKMWp5/5jP7a/QHZEPciK+JVViEyvnEHo8i+cnOZDGglu76xeFVdpUud+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235441; c=relaxed/simple;
	bh=QBZ2RnLvzX9k0sC/KLiMphM82lEOMIqMpuWiE3Dj2xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNElJ+hB1DVILJSoBTgEFgNr/nZHPxHMegC2dmF3rXyjMsOTlVWVYYPomdoI2mRxwcTbN9Yw5A3WvVGk1ub+PGGy2odf4aO3UfHZBzsCeO2kFF+OJeLycyXs4/NP5aIg/6PG200gsAyJmt8d0v15E1b57RmLZGr2eQnH2zNXwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mBK8kSaD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab46931cf1so21282895ad.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775235440; x=1775840240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zdj+x5c75FhlG1gdNDIWMuNMzhHYG3GmAfv3XQFkW0=;
        b=mBK8kSaD9nvd9qbAgoG2DQH1rDYab3BNdnJDvmJpvtMf1VA/qEiE0368u9xw3vRXx2
         YvSl7aqFKe6sB6mD4yBWY05dq7A/pTWsPWTFTNUs0KU0W0bVPIk76snWuLmHoGDwqPJK
         OciAz+r/X6ITrk3XjVH+NSV6gH5VcMMC5ocUwelfERxMC8EoOCRLEc38by7m/hHusLjN
         L6e6vKJ+gjO4wGTQnKEBJxVFDcuTLknS6qzRq/Eu0Ffseyy0zjPaC6cfeykA+DwrL0fc
         Yv56tSnnLhjZvxco2c0UavD888d3jSRxDSHxNRAgzYz8OrZdInEK3CFvy8HxixUptoH5
         Uhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775235440; x=1775840240;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zdj+x5c75FhlG1gdNDIWMuNMzhHYG3GmAfv3XQFkW0=;
        b=NTL33VLqo+yH9xzp6enJiQZ1A7Qb3zzqU3Y4yiOFg4yOWGPTJqRwpEgxK9+tvYMFlf
         00ChVFHKitsk4XeUP5BY8kW7EnLwke6MeO+JoSzbyy2vMBi0bg+hRPxTzGd2t069NfBw
         KamtyMByLHIOBZTPgpMci2v43RynRmRuhoK3Yy3v+7eWNYMwOCnsrKvKvW/G6aSfzhKg
         rs8E2+3hm1/Ht7s8JgTbhzqqPirnzXgYWmRAgWMh9a4Q4oW77lS3Rp5yBSbO62ci/8EN
         wuFZLD5ZT1wL7rg/pPyqp03T1T8llStMff1xNTHfg0Lw1TsqzA5YaDM6eSkRpPWSebrp
         dXKA==
X-Forwarded-Encrypted: i=1; AJvYcCUchaf2rx/F+C6WDLKRAjKTO2GqD1/77kdfUBm+mCCAIzIo2QSbeATE46PYXJVpzxesBxHlcPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMrE6z/0aHciaw5/Obri6o07Cz3jx/Mg+m5doIB8W1sEsboER
	rSB+T5GXhJLXGFfEcj9vEmrRBG7YghWJSPR+Bokg7lIgPLYWBxU2wRNBt936JlejbMg=
X-Gm-Gg: AeBDievCV5J/w+WSFpD7f+HDqzfsUV4yLoh+3jsdurFFyNuo39NzwOUdOw5I7+X+J8h
	OZsicDJCOmIciLGF+aPcslAGc46ViPp8EAX0zOFAa6kpe0bPkhwuqiISwhD1bDKwg7D94MtjaAP
	meRDxpQ389Kyi3bE6nJp+G8SDG26YTUyN0ttA/6G3X4+MMIN3HAwOPqUgcxxMY/rmLobgkAxcxx
	ckvf4gvt8wtcSm85RJPtOVTal+/07COq68RJIOonDwpfef/y5J3+lxzmWGhNDAFtr/CulRQfGsI
	DU0dnh0kzEBnErYPF2ikHKKnJGOZHAb6qDagSW3p0BKUs2YWwqSL9ry+oPbADDMOM/9eYqJMCNn
	KLEILrRm7Hh+9BLY5xAMdss6gjPfsSNKICXhO2phLhy0/9e3pLH5sOvXRjKQUNYayHPGl7GqJ6Z
	3cnrUd
X-Received: by 2002:a17:902:e84d:b0:2b0:5a4c:726f with SMTP id d9443c01a7336-2b277e3745cmr65000805ad.15.1775235439715;
        Fri, 03 Apr 2026 09:57:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm58314565ad.56.2026.04.03.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:57:19 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:57:18 -0700
From: Joe Damato <joe@dama.to>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
Subject: Re: [PATCH net-next] iavf: fix kernel-doc comment style in ethtool
 ops
Message-ID: <ac/xbvofVpwXHTQK@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Leszek Pepiak <leszek.pepiak@intel.com>
References: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403054321.3791392-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275153-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: AF5E5396B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 07:43:21AM +0200, Aleksandr Loktionov wrote:
> From: Leszek Pepiak <leszek.pepiak@intel.com>
> 
> iavf_get_channels() and iavf_set_channels() use the legacy `**/`
> comment terminator and embed the return description in the body text.
> Convert to proper kernel-doc style: single `*/` terminator and an
> explicit `Return:` section.
> 
> Signed-off-by: Leszek Pepiak <leszek.pepiak@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

FWIW looks like there are a few other functions in this file that use the
"**/" terminator. Not sure it's worth respinning to get them all, though, so:

Reviewed-by: Joe Damato <joe@dama.to>

