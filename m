Return-Path: <netdev+bounces-280245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMwIC1Ta52kBBwIAu9opvQ
	(envelope-from <netdev+bounces-280245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:13:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D01943F538
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798F53010DBD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B533DCDB0;
	Tue, 21 Apr 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvezgtRZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHosas3m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4A374E7A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802042; cv=none; b=KrqcrcDDILoonRdvTLPGTkXfWfKDJbF8/xaPx5pf7XLDhD09RMT2QfJaCLy9RSEIDfst8kRplQkLIkXybPBF3abv68oey4AeAWCURq5CO5owigACWe+q2oPyFMOvLXz51LyFJis3IDplupyGtMLbPGhch1++p0aP4zguuPqfmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802042; c=relaxed/simple;
	bh=4nGXNP+FFeyOAfKIybOpKVmX6+Eo9BNgkIzpy4p7zWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3vLBysuMcYKUM2U6yLkt1pUivv/H99g00cxzZ2z5lgNkhE9LLpvUzbcLqXLao4f72T0UtmcjIrweym4vhflI7vMznWnldF/kYcb1K2K4RrSuUXwxuPvn+xj6rkB41B6QoMPI029NKB+JcAQpFP2fEc/WaF472oCy0hGRz3Gd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvezgtRZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHosas3m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776802040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1M8Wy22x3elv2D/+fnXEPtAuCSkz1UNFVYr+3jYCUkE=;
	b=QvezgtRZvjorCItDceiuYhJOxuZvfoFyvo1UmZN2XTH5d3c7q0rEKTTEfaPQDWh4S2E8Zc
	ql7I1QYK5ftMdwfeqJSlDhmdyDQhXlO4LDvU6Uef6qGt6LMJgNNJWqggzba8EOlWBSTqoA
	aZW7GTq4z+5uFzwPlq0TYnN3E26nD7s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-VUXHBUrENdywA55cOKF9WQ-1; Tue, 21 Apr 2026 16:07:19 -0400
X-MC-Unique: VUXHBUrENdywA55cOKF9WQ-1
X-Mimecast-MFC-AGG-ID: VUXHBUrENdywA55cOKF9WQ_1776802039
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a8ea3f1becso21550166d6.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776802039; x=1777406839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1M8Wy22x3elv2D/+fnXEPtAuCSkz1UNFVYr+3jYCUkE=;
        b=MHosas3mb1L69W6BUum5er65QveWeuoSi1fmAZ6Q/ey3aAb2I6m+DcCWq/VWlwBtrz
         B7mVmpqbgX0MzUad+oO7aMV5VetUeHCIwNDDBKmi3Rjhr08hqooyMxcIz1KTRslxZ3ht
         IVdcBRBS1sOhSFPSWS8i6yxSiG1l/iTnloBNiw3OIDm8jcJwqmJUKkqMl+kRiK9MnRGk
         LtbJJszUmqX5YXE8WsxtUFehC/li947xbNWapeXt0LlBxh9HPTMIv6NvbtujiYRnB0fi
         P0Qvm467GzNeHBWOAK76h0wMgcWzh4e3nbEOSKoIGhjKyxt6F6kxCqPOojnF4NyK7sTv
         bu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802039; x=1777406839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M8Wy22x3elv2D/+fnXEPtAuCSkz1UNFVYr+3jYCUkE=;
        b=HiuauUkTaf6nl7K1sZse5a/bpP7Y2IrihMjvMPiSP7DgcaODlV1ZSduN4RGov5Z1ma
         1ANOUMb95839W8S67Bd+KozlW9jyjoT51P31nOx/sZ4+nyl3UG6zfU85hcxo2DQUilRV
         TY1/7GQb7iEkMyOTbEDmvFvy1gR22IbTKoOSf2GHToSkEd4gGP7FRmjIYjRYdtl8Vf+j
         2haSbQ+9c4E9NMQt6MvR3hjXPETLziturlazGvJ3qsfBhz0tBVeuzb/ee49O3ElJF93+
         ZFYpGp2rvVxpy8Rt4/GxzfWGdPNKtGfYYWXHgP1CB4mdG8mYs0cVhSyR+E1eHgihtNAh
         6yOw==
X-Forwarded-Encrypted: i=1; AFNElJ8pYGuTDD5MTUq+SKP6tnEChFzW0oByffQ8cTBdgj/OwkKL6TUmSfMYe+rQz+MnNKPO0yJ+3uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxniJB0XtxsGmeCDRIq+inE00tPA8oMdYLASpXZYQWVlhP3fPEG
	3DpC9VfzSFryXnaPMccvb0hRv011ewD77teECVz+Ln269hsgReC78dVt0z69004TirB8W2iWRpt
	hil8vQyQObQB4gNXPC0HvTbnYytX+JjHYbN+Ccunvkh3ehhXyImH/RbLp3w==
X-Gm-Gg: AeBDietfRkokuVlIBQosBz8kPMuy8zNweKIamyGCIosln2CjrIqqK0QHuN5jpJ1g+qb
	lSF6Qv9u7RFMo3MjaRpIxsW6GtEGeoZ3QES/cJiOQRh0EkvE7Eb/RWpXES2leE7E2A8gD4Fjj7G
	YYPYqjkqbUk/ZMK0IgqHeTFn2+Imih6H3nN6UtBROjRMqfnibKcSxSN5ymmYo1NKmB5JEhz2ZP6
	maJMihs3f84yflNXaUxSpDiLBg64j32EkReE9Idz77hyhX9SioVqEnXad4rhF4nNSuFfAKIJIYf
	Na36CVnogpI1W6Rt9u57tXpq5mfGE7YRsJ2vVFm5R6QnPABY3K4WBkMSMRh7viZBobzvCDTpeRZ
	+GlLTPXAaMLSSuq0So+23/j3GU+c0KPy/GPofAlk4IA==
X-Received: by 2002:a05:6214:300c:b0:8a4:5cfe:a204 with SMTP id 6a1803df08f44-8b0280d0e78mr313218206d6.26.1776802038999;
        Tue, 21 Apr 2026 13:07:18 -0700 (PDT)
X-Received: by 2002:a05:6214:300c:b0:8a4:5cfe:a204 with SMTP id 6a1803df08f44-8b0280d0e78mr313217376d6.26.1776802038427;
        Tue, 21 Apr 2026 13:07:18 -0700 (PDT)
Received: from rh-jkangas-kernel ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm149503046d6.28.2026.04.21.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:07:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:07:13 -0700
From: Jared Kangas <jkangas@redhat.com>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	boon.khai.ng@altera.com
Subject: Re: [PATCH v11 2/4] arm64: dts: s32: set Ethernet channel irqs
Message-ID: <aefY8WGCuNr4BQG4@rh-jkangas-kernel>
References: <20260312-dwmac_multi_irq-v11-0-09621ccb040b@oss.nxp.com>
 <20260312-dwmac_multi_irq-v11-2-09621ccb040b@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-dwmac_multi_irq-v11-2-09621ccb040b@oss.nxp.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280245-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,armlinux.org.uk,altera.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D01943F538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 09:55:28AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> The GMAC Ethernet controller found on S32G2/S32G3 and S32R45
> contains up to 5 RX and 5 TX channels.
> It can operate in two interrupt modes:
> 
>   1) Sharing IRQ mode: only MAC IRQ line is used
>      for all channels.
> 
>   2) Multiple IRQ mode: every channel uses two IRQ lines,
>      one for RX and second for TX.
> 
> Specify all IRQ twins for all channels.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---

Tested the new channels on an S32G-VNP-RDB3 while testing patch 4/4.

Tested-by: Jared Kangas <jkangas@redhat.com>


