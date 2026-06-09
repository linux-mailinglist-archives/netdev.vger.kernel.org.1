Return-Path: <netdev+bounces-297138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OjJgJCg4KGqEAQMAu9opvQ
	(envelope-from <netdev+bounces-297138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:58:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D1662128
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JCWNXEBs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297138-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297138-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33AC931452E4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59B49250B;
	Tue,  9 Jun 2026 15:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5E1EB9F2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:35:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019335; cv=pass; b=AK/PW0+MFtxMxgdkghMtUp1gWvDCSzj6HwT0Kr6LpJaMTbMKztm0BQVdV1cLeCSNPFdRmW26AgsXerIz0sB0k+hFIbZ/pBaQjZV+KLpJ7pBphCnKhCX2NUKNqeWpMch3xjbDrzNLr5lve+CuQlEICbq0M1yyiJ43RhbBMceWI0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019335; c=relaxed/simple;
	bh=jEhv3A4XgoR5E1m4WOk5qJNIAYwzLvIQCdMGUYZ3aeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phK9DBjjJio0VXzuv6l5aMwrRgiSsVafyOoa6x24D124leRJ3V+ZSk+yGihwfgGFBdWKmmibMVw8EOwB22Y1pzTO98WZ4cfeqPuQokyge+rbfbq/SJPSizo46DuwOXogsxAYoiVVJupLfRmo+RN5q/QJ1cDfdsq70q+83r+2dHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCWNXEBs; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176bbb9384so57235421cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019332; cv=none;
        d=google.com; s=arc-20240605;
        b=XYFw6fmnG1KJnTPzjSUHg2xdSdm8Vht2ahSn+/Y3ioanUZReBXZfWjXtlc7H3XUAWA
         W/pNPWuCpBFYP7EiuuHirRL2j6aVTdtopCS1AaiVU5vKfoJslINDNyXDsY6KtUHd9xyk
         MZxTDk7ym3NuUuuy9xW5Y82uWGgNpxhSc82jOjg2sHMxyr7ZLWGFVox3gCCryUamAXri
         5JTrX5a7dT+vULaVma4hhNMFubikaYo+5sxVjMT+4ENz5YSL8vKtSj2tyr7fHdn1WgKs
         q3dhwELrEIf/P+qgI2//fL0khXjXd8hu2FNGCrZ14cCxpdHo7Yx1O5XN73u2CAXN6gwA
         4eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZcUyMhLosI1gkW5rf0mHFs4ShRdokcu/9hZUN0yW3c=;
        fh=iCCfES5oSa7yd0vRoYnD/lhuePxYyh/prZjMZQA3iOc=;
        b=lupm3YdBQxmguojFo55mUb9+yPLdpsWi0WCfbjLXwvmQIT2lyVYsROSrcwtX3nJjXY
         Uvb00wyGEsD81lRS5FPljdsA7j2896jsrEmKQK5Q4L260VAgGtlJVqlrT8MmGx4LaL12
         W1nx9susga202U6/C500vrZi/SXFA8qCnve0ewfaPPWM6ZR21hGhPByqj/QcpHSVqJmk
         whkHvRoXPnwN0mv3nboxECpE8eoh7gB6Eyvz0KxobZ0C+molYJeH3I1Zw1+fI9W4DPSv
         hOiI/x2rTCU16tsV0OYhUAFd6LMVJgDY8Mb4I9R1Qba3pSKWm19XKFq25UwEk/AtFBDF
         +U5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019332; x=1781624132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZcUyMhLosI1gkW5rf0mHFs4ShRdokcu/9hZUN0yW3c=;
        b=JCWNXEBsNc+NWAZAGu7fK5mcG4IiNstEaDSTbHycG2bvVoxNCDkgW/KopCpICN5e78
         f2S2BEnjYt7SeA3rACYHkxyrKME3VcSCdy2thX/2PCgU1bS5rPdkW0esjDo/kU050pXo
         woTp6jCkKItIBWtfvgO3gQV+4n7li/43tYyDTKfKPShVqYT60rnts7SWUj0XeFL54cOp
         9qh3Mz4SF34XZfo3srWhARasmfBNMHSZDo08RNw8wCpzeTtbuOtfrDrcuqy8COhlRA2T
         PoCfVfkWS/KMx2nSoE1tRBhtCCVoBh991l59tkNbGdnMlxs2/t35ekBGmqgZuimylAdC
         dXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019332; x=1781624132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZcUyMhLosI1gkW5rf0mHFs4ShRdokcu/9hZUN0yW3c=;
        b=RzrqRzO4SDvfNvbKU4aLlTEubl+GNDG2GGDm36B4Dk+W0BBCp00qgnV1g9PVR2A2BU
         3VTq+HyUhrz5vcl6jqHoN9ZyWku50kULn6VtD3sckp8mdsHg/fpST6TMZ+R5ilpKvTW/
         V8oIzL85+ex2+m/iIw/tfxj26iBidoSdWf3eDRznISAJ/UUBh2sqJgP54+d838Q6yKMN
         JPK/coj3+2XWMAfa6whPPhH8CrC7AI7F7ydIEywf3YzUdHgwnBDQmEBTqEIueGKG5xXD
         WwejZLaMr7T0N1ceW5HzRQwxks9cGnSKtXBfKCC32mOx9SyA42gKzNhQghf2qHt0Xw1d
         KPGw==
X-Forwarded-Encrypted: i=1; AFNElJ+d2iXWdRWD5ervH+/WfM7E8vIu7kynew7s0uovAzJqkJQU5BeLrzi6ruLD4k2jWpM+NT7HZrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2p7hnex6j/Pr65ZQfkLU/Yz0SqxLM+bswVmdyULfxNKQgs/Fk
	DY81J4Uc/v1vXyWhsDEXu+xqAMfoFMOkC6pM2sS2GEn0qZN7cMKT1rtHwLoEb0ie7Pyv1/wgg3y
	Ke/F5VJ0WqX5z3AO04O2uSJnFY8WdFCLcR3u3sGng
X-Gm-Gg: Acq92OHZPfMxxfg4iiG4O/LDn5tvrgyYd0DYGr7PX7PvYTnfZL0ewVUs3z3d7hbwnsg
	lWteHSuyL+U83QhhWw77iqXU2QGh/WPZkxpe6kv2A5fNVKdF6mG0P2T6qXj+E8+bxqWk8Fq6o/C
	TWTG95mz1lWTDR9GWuANu4BPFMWRJz6jkqt5WaZ8pK+8p86jc42XjrTucywxhneUYoEW7T0ai8/
	i0yd6IAbBEg6dtA7wCIXllaQwgZ7qlcqE5aCKzWf/z4CWt7NlozXVTXMODn03yQInVadr47IPir
	MzI5D6hCIyz7Xe5T6WjgTWt5Obr6ulRUMJym5f8Kj86DzS/seP+y+iJlXj2/K1xsQy1gpNXZ0pU
	DldkkyKsR+0OrFjJyQ4bdpnQtOf7YCA==
X-Received: by 2002:ac8:5fce:0:b0:516:e10f:b1ec with SMTP id
 d75a77b69052e-51795b06c90mr300061241cf.11.1781019331144; Tue, 09 Jun 2026
 08:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-4-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:35:19 -0700
X-Gm-Features: AVVi8CdAnVV_OyKNqTHYX26kqUhoZXEA-ST3IJPV5vMjVkuMiZAp3VklMmMK0AQ
Message-ID: <CANn89iJ3onhdKV4sC3FYrtnUXAWm1NQv__EpQhXKPB6mL7WE-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/12] net: ethtool: make dev->hwprov ops-protected
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091D1662128

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> dev->hwprov tracks the active hwtstamp provider for the device.
> Make it ops protected (instance lock if the netdev driver opts
> into holding instance lock around callbacks, otherwise rtnl_lock).
>
> hwprov is written and read in:
>  - drivers/net/phy/phy_device.c
>     phydev and ops protection don't currently mix, add a comment
>  - net/ethtool/
>     as of now holds both rtnl lock and ops lock, this one will
>     soon only hold one lock or the other
>
> read in:
>  - net/core/dev_ioctl.c
>     holds both rtnl lock and ops lock
>  - net/core/timestamping.c
>     RCU reader
>
> The new netdev_ops_lock_dereference() helper does not have
> "compat" in the name. The name would be quite long and I think
> in this case it should be obvious that we need _a_ lock.
> netdev_lock_dereference() already exists and means dev->lock
> is always expected.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

