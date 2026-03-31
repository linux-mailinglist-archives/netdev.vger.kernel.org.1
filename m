Return-Path: <netdev+bounces-273404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF1pDfAUy2k1DwYAu9opvQ
	(envelope-from <netdev+bounces-273404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6F362A54
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A973046E99
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0B242D84;
	Tue, 31 Mar 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjvFfMIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815C1D86DC
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916658; cv=pass; b=EIpYybBjMvHzAptYg2thZri3skrNNibNY1dJgLvfy8Id9CeZCmMIoabyB3GlEhJxDxw3pSsHTbmWDC7iAqenUXTFeFtsRxMzlXHq9UvsngwOFu8HBjKs5aaJ/fruLuJudz3Bos2Ppw9950I7nN0Dq3boso5BjDSqMuzobd09xWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916658; c=relaxed/simple;
	bh=UEdDM+1yMLjSbL0Qt8pLlHl/Kp06G4E8R1a/LT8SqOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4TvqSK5kAkPVvbYxfJL15D84zw9TjBEymAPt+aKykmMvLeFK1mvh85IiVeLiYEkyamH7wO+4wVBmHU5MlHiNoZEz5xbtLHkFKb1AC9DNGLEIOn78Gvpec379n9JgqgClzQLcGmxOYkDs8EHWH8tBYDRD7h221CSbNcUeSR9t04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjvFfMIq; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66b941ebe79so3781156a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774916655; cv=none;
        d=google.com; s=arc-20240605;
        b=L7XFCAluNK5l9y0NPxRCYytmIb8X/UB0R4ZzsPyG+gj7zWK6QadV71DB1jZ8/UAc4o
         R3Bs2nYcNDeb2a30MnaDmw1Iyz9QdvzyVs/rOgx5oFtiKYVPdX1cZ3vctzizA9VgM+S1
         +IAKzS4ruZ002Ys+7vgqkblq+SR70yigks5Ntz09vOLY77kz1gGAEg7XJSk09CF/1fNV
         TCmP7Uiv6IMJKLePk7mmmqs/TC43GR7VUEs2j0u/4XiFxLmvt/b4LbFMxnlNV+ka0xMe
         SFlQWgNuXzBvP0ZcjbBVYqXQezqinOtTl3MFM66yRRT4S38JjI9wIvyhfB2fZ0CWA+zx
         Qj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        fh=28Pa4g5P5vEAjBgowuDIdKo74MISrqQ5H5N4tubyjYM=;
        b=O4eRAOLb2Loy2V7j0SuG99pjc10gBVFlcQ5J+XG9sdBqSiUT0mZFdFEBTaQgjrHIYl
         wSx0hzA3M6fKYuz0Ciip27XhjfAYl49QYxg7NmUDuAypTFEjfjy+dIUMn/PIQJQioMb6
         ktvPn734AzzQHsah39qEGuPHfe4KOrSaJc6PxDCJlUVZU+qHyZAAS/5O028WNFA88hXQ
         yEaqaqQm7zX2gvwuQIpqRf3mC/luqLeBTlHgyN8pZaY9p7zWM793uQ/1Ha3CCII/ImJQ
         nCqj3EFMqe8CB31o3RKeDdqGqes5HhLmYX/JpWav+VW1YUg1MO57M3hIe1S0sPPiyDg+
         +Utg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774916655; x=1775521455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        b=YjvFfMIqhI2DKlu3h9P19Qmy/ezz1HNWRHKpyf7wCp2VWxr6l0OmIon6pOYdXDXeGL
         EhLE/IHXMFeq4j3RxdRr64yOJc1xuQD7DJx9+19/7PAP2x1JgpoBTI5CTA9btYaymnve
         EJNeXF7fb2UZ9C+WJZQo95fkFNpEem3Ybdk/0+VgSlOYJaQ12uqsxVOghdYcL1IVq/lx
         6U/p9CfKs264btaTpNyZY+0oNITlfgTY8Z7z6pKquUkEVG4aMO/wFvjR7p7sOxvsXNgi
         68h2kkG9Olgrswu7GxG68rMruqACNMmtljP5xoyWSZdcxu+LaXBm3I31M1y1yVu5vNsj
         zsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916655; x=1775521455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        b=Y4Dim++JMtvwc2SxvYt3LfvGu4/wlzy1aQ2cD97hsYzd9yhAmyhQVBug8FJafygOoN
         TXG41PWKUZpNtShtmMNcmUw74igXW0Tc6rSWBSyiNVhE2QgGlf/lwyZtc4T3GAXIHLBV
         GfRhNiTLHivGnkkaoD6C6SqTOeDr8CdjFYbdZ0fiaHCoLJdQis1Uj5DB5ORCzSnKBG5m
         fzVJezPDp5PFsCRYs5V54ooWWyVnFCPPgdNI6f9fOblyexEufiDMkCtESP4o7v7jnLqD
         nm9exDuIS/fyI6J5HRA0eOYaRA55R77RWXWLDAeqQeusXCOsbJx5fvlzQeNJpP2xHgkq
         KywA==
X-Forwarded-Encrypted: i=1; AJvYcCURDxtEXIMm7gtTiTmek8FWNC+i9YMEavGHa1y2B98ioyB32Mgk1N1+f8QrkhkZ8cCBaX6LSwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7BNZvNu8I7bKh1oONR5cJLbRNKqW5PmL4O+4KoIEq4uACW9d
	aYaqaGK4U8mjE6rViowb2LMWwmvUuuphuOz1Mupc8Z4opr5Bcunp/WirKkZQh3yP43ZWXMk2X/J
	oHvzV9L2QKOjR76GVOHhNU24Ywqxwk0U=
X-Gm-Gg: ATEYQzzsf2+4EbDvETGL7Y2FfiV/l3m2X0gd0vseGoy4nAqSDr2riH/4ECA2j3pKmxJ
	09RZvb+WEV5YJx25SEd0ow2ViCtDH8smsPS1BGieRWzhYHB7MJ1NRHEZSJWQLztJBNBspPp5BGs
	3Z/ughahwnUxceVaUie28ZOi0gXcC0pQ3i4jsZGpKCMu+CpCVjqy1UqHpTaigib9LmbPfpiage/
	FdSuU+df7rkAn/tdqIl+k72uuuicAEp1zG+h36JZc+f5uT7ohUvNGXLEA6+XF9/qltM4WTwiVda
	ztCW
X-Received: by 2002:a05:6402:6c3:b0:66b:3cb7:f638 with SMTP id
 4fb4d7f45d1cf-66b3cb7fbf3mr5656481a12.10.1774916655304; Mon, 30 Mar 2026
 17:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-2-teknoraver@meta.com>
 <acp5jaFFI57ilC3y@boxer>
In-Reply-To: <acp5jaFFI57ilC3y@boxer>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 31 Mar 2026 02:23:38 +0200
X-Gm-Features: AQROBzCByBvhb9AnuqDoT1x2BkYJrGyhggrmURO-zajvyC8YBUAFOoejzi-xIwA
Message-ID: <CAFnufp0w1qsLAANh5g2KuHYHTQ_-jAB21u2nhOja=4TBMB2gdg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] e1000e: add basic XDP support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273404-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3C6F362A54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno lun 30 mar 2026 alle ore 15:24 Maciej Fijalkowski
<maciej.fijalkowski@intel.com> ha scritto:
>
> On Mon, Mar 23, 2026 at 07:28:22PM +0100, Matteo Croce wrote:
> > Add XDP support to the e1000e driver covering the actions defined by
> > NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
> >
> > Infrastructure:
> > - e1000_xdp_setup() / e1000_xdp() for program attach/detach with
> >   MTU validation and close/open cycle
> > - ndo_bpf support in net_device_ops
> > - xdp_rxq_info registration in setup/free_rx_resources
> >
> > Receive path:
> > - e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
> >   with XDP_PACKET_HEADROOM
> > - e1000_clean_rx_irq_xdp() as the XDP receive handler
>
> Hi Matteo,
>
> Since you started to look onto this driver, I think we should have a
> single routine for cleaning buffers on rx. So I would ask for getting rid
> of adapter->clean_rx (or at least convince reviewers it is not possible
> for some reason) and then implement XDP support with approach as XDP being
> a first class citizen.
>

We already have e1000_clean_rx_irq, e1000_clean_jumbo_rx_irq and
e1000_clean_rx_irq_ps.
Do you mean unifying them all or just merging e1000_clean_rx_irq and
e1000_clean_rx_irq_xdp?

> Furthermore I believe all new implementations of XDP require to include
> multi-buffer support.
>

Note taken

> Last but not least, this lives in intel directory so I assume
> primitives/helpers from libie/libeth should be used for this work.
>

Only for the new XDP code or also for the existing one?
If covering also the existing code that will go into a separate
prerequisite patch.

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

