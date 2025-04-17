Return-Path: <netdev+bounces-183769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606ADA91DFE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF75166382
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6723FC55;
	Thu, 17 Apr 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LrWD0/Ln"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47C145B24;
	Thu, 17 Apr 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896479; cv=none; b=TLTS9avybp3bwaAO+NOnnwo3QM2x3babqFqGS4NhyPuzanUCFmqOHs5x5zJXLl9KcJCYNGJE2JqEoPDrbIjeRyPVKRVSBrhj2ZEP6vPIcgF8xjhvFvpo2upysPGV2ofFH9hZyOfpA+/JKaE3Cuf1F5cCdwWE/MSWT7xKqLL/794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896479; c=relaxed/simple;
	bh=l5TPKEBA5ZuQO87D/xku61a7xBIQtvTjQwvx/XVDRZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2jRFcZBXrIdw7dNFjdKr9omcJzsWg6/hSZ0may3K41EgVfJXAmSDfAxz3nPfieIwZK2CsiwFhyRb2jvCBdd7nzodBFT1CBsNuHb1Zujw2JQBeY4C0tgzbzHLmqi3r3kWUktFrinWcfpPVDJE03QzsH00zAGmv06VBos7g5gwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LrWD0/Ln; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OtjfNcK8nf/oL7Io05d9rm6yCGzKjtQGJGfg5Tphs4M=; b=LrWD0/LnUmxjKJBDEZus3atGbA
	hyccSUwWOlK4gHnMOeKVfos4Y1xRkBByNZbhTtgdMTA6XP6SoZFEpfH+imdqZEHzPFS038JWRL4CZ
	lgUTPxTh7Z9PkYSeOgPUl4px4n6RfSZMKNu/DhPhe2Mx6G6wN8/NQr9WLr7HZsmWkHu0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5PHM-009mr7-TJ; Thu, 17 Apr 2025 15:27:44 +0200
Date: Thu, 17 Apr 2025 15:27:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
 <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>

> Anyway, I have a different idea... completely abstract mailboxes from the
> caller. The mailbox content can be large and the caller is barely interested
> in all registers from the mailbox but this could be resolved this way:
> 
> The proposed API e.g for Ref mailbox:
> 
> int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index,
>                         struct zl3073x_mb_ref *mb);
> int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index,
>                          struct zl3073x_mb_ref *mb);
> 
> struct zl3073x_mb_ref {
> 	u32	flags;
> 	u16	freq_base;
> 	u16	freq_mult;
> 	u16	ratio_m;
> 	u16	ratio_n;
> 	u8	config;
> 	u64	phase_offset_compensation;
> 	u8	sync_ctrl;
> 	u32	esync_div;
> }
> 
> #define ZL3073X_MB_REF_FREQ_BASE			BIT(0)
> #define ZL3073X_MB_REF_FREQ_MULT			BIT(1)
> #define ZL3073X_MB_REF_RATIO_M				BIT(2)
> #define ZL3073X_MB_REF_RATIO_N			 	BIT(3)
> #define ZL3073X_MB_REF_CONFIG			 	BIT(4)
> #define ZL3073X_MB_REF_PHASE_OFFSET_COMPENSATION 	BIT(5)
> #define ZL3073X_MB_REF_SYNC_CTRL			BIT(6)
> #define ZL3073X_MB_REF_ESYNC_DIV			BIT(7)
> 
> Then a reader can read this way (read freq and ratio of 3rd ref):
> {
> 	struct zl3073x_mb_ref mb;
> 	...
> 	mb.flags = ZL3073X_MB_REF_FREQ_BASE |
> 		   ZL3073X_MB_REF_FREQ_MULT |
> 		   ZL3073X_MB_REF_RATIO_M |
> 		   ZL3073X_MB_REF_RATIO_N;
> 	rc = zl3073x_mb_ref_read(zldev, 3, &mb);
> 	if (rc)
> 		return rc;
> 	/* at this point mb fields requested via flags are filled */
> }
> A writer similarly (write config of 5th ref):
> {
> 	struct zl3073x_mb_ref mb;
> 	...
> 	mb.flags = ZL3073X_MB_REF_CONFIG;
> 	mb.config = FIELD_PREP(SOME_MASK, SOME_VALUE);
> 	rc = zl3073x_mb_ref_write(zldev, 5, &mb);
> 	...
> 	/* config of 5th ref was commited */
> }
> 
> The advantages:
> * no explicit locking required from the callers
> * locking is done inside mailbox API
> * each mailbox type can have different mutex so multiple calls for
>   different mailbox types (e.g ref & output) can be done in parallel
> 
> WDYT about this approach?

I would say this is actually your next layer on top of the basic
mailbox API. This makes it more friendly to your sub driver and puts
all the locking in one place where it can easily be reviewed.

One question would be, where does this code belong. Is it in the MFD,
or in the subdrivers? I guess it is in the subdrivers.

	Andrew

