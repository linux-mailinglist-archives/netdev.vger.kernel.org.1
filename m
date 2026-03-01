Return-Path: <netdev+bounces-262401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBNfM+hIpGmMcgUAu9opvQ
	(envelope-from <netdev+bounces-262401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:10:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA71D0243
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECDC8300C5B7
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BA309F08;
	Sun,  1 Mar 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhPF3pR/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE62C187
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374246; cv=none; b=KmXarqsz6F+4r84o9dAUXM6F4zUePetpGF844niknMkwdX3fEszj+ZpqNuu8/4pnlYv+M1MRFSNkZW41+nR46IsGd0kK18OolBb5gXM/kCVAP16pFzjX5g1STIxoakQCvZ4A7bnR/nHp/uM0G6Ycxtyg0fdJtOSAEuiRbqfsJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374246; c=relaxed/simple;
	bh=OjOk8RraPxUBfWoZKGHeITFedK8/5Hi/f7N8V+do3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZUpD88zVpH14P0DC1RG8MTQTcpEISqW4rIvOTNTyCiuZPlre7e0k0uPBQNg6HjEp9FcnFxjSKXFx9My1QcL4tWQS1za/YBp6kZVXxn6KYeQ4UDPmIN0G5skJTLc+YUQSpvqcRwELbZQiWJC1qcYqekCf/uzXZ2SFiuQEbZ8jyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhPF3pR/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso7079135e9.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772374243; x=1772979043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVGLTQN8MHuJLb/cmqvoQTI+Y7O1OTfTNxTJJccPmrI=;
        b=GhPF3pR/NcmE3cJd9K/y2ac6w4QpRXD8mhradSoYq7nBXn4q/XKRpcZorOtyrOXH2F
         PrRvYI5K6sGbPouZ6xSmqFxnuTaqtpTcJ1GSlnjvZZN3pPAqXuMJryytmBUcfF22j+rb
         oqO3tEwpyRRcrUC7LFuirbarnK8tdE7lJOl3+9bEAlpeJbJ2vL7KlH8rCJgnz7lZlJyK
         eDs810NRcFgmVay/SGVWJl+dhm3SDk6Pwnkqc5ZpL/PwvPuo4I/1JGhGfwie5zj6lI7l
         VMvmIIWkSpPlq9ilA6m8glRDWR/UIFBiUHP0AfjWKKmShU7xo410Nei4v+tMMKb6nNZz
         5VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772374243; x=1772979043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVGLTQN8MHuJLb/cmqvoQTI+Y7O1OTfTNxTJJccPmrI=;
        b=uVuTGq37ENTd8PQffWNpecRznRemeckMF6xvarSRPx6AMsoVw6AqbrZqli9H7SFJ/b
         dcnd1cmce2wVjqR9RouxeILVxMChIW0ZtLLuHsVwiT+ZxyT9mR95HZg+HA7aypHxMAvO
         Z2jc2KEKpVTVpJU/+aPPeX2yQdKowRcpg6KIjvZdIOzb2A+DZW4F9PKcSLYWVs1W77vm
         fB3HNtC3pXQvOafRgC+zu5U5QssyFrTGmiKck7etp00LN0psMHTgf5PMQhY0LJe95v2B
         Bvd6RdMPW1wZFkt3nw1Na0TY+wUCXhyQ2aOXRB4Iwe2Vq/fDu5Efsb6RhLVknevsApWJ
         yXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE7iN/lV1FINTu4C0YCVsWmpWLb0h4AmBEHbHVxbJ6bAIjsuOHrXcHSCmuT6/qf3j9ussggZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYKZNhZ4+xDBmvt3uboYjkKVCKHl9LKSzyB9FqmFbndJyQNSj
	KC7RYwNdAz37oeVZeBDykDUnKPX876AHGpVLBVCaqmltEoEWEWBUaPvy
X-Gm-Gg: ATEYQzwzJJ6rjIc5bMS4u65bYcLWJwT7/86/QFablzMlH+C0VjVd6fNEDqvVyT3V4RB
	pz4ZKMiapFzLTVlLnrwKK1jaIUfMhRjtsDLvdlK9XtTmbiRVX0r/TcqGa25tpTFnbdlKfSdhhMm
	ak86WMP4WOnyS+b631TYorHivxf95SWzvld5Wli0kMkUTBfmxtjV0boDHwuhC28/GgjF58AoEMd
	eicHxvBZWAc8nBWixYr2d6HmJfU9ECGaCVV3yHt9DSbqvMBi3S8j6mIDdfn40W93VZPeR6BZzQX
	2NVqPMpAoLPzcL+haGWzZg5vl0ytOPeT/C50Pxg1mPPlwPbQ/Xn9mIKBGU/xWC1Z31AVSahjnpT
	tHcWJ1rYhGR9P47VlGB4iOpKSZR7kOKjD7+o1z/KfR8i+qMjY3ZCcDjV1UtHemgEyxmdGuoeP2J
	0hHv20saZCkCmdyNVT5KY=
X-Received: by 2002:a05:600c:4e8a:b0:483:887:6e32 with SMTP id 5b1f17b1804b1-483c9bd9eaemr93243805e9.8.1772374243073;
        Sun, 01 Mar 2026 06:10:43 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:8f4c:42a4:aebb:ef65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77abdsm107413555e9.2.2026.03.01.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:10:42 -0800 (PST)
Date: Sun, 1 Mar 2026 16:10:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RESEND2 net-next 0/8] net: stmmac: qcom-ethqos: further
 serdes reorganisation
Message-ID: <20260301141039.muzcrt6cynilvpei@skbuf>
References: <aaDSJAc-x2-klvHJ@shell.armlinux.org.uk>
 <aaIysVxy-WxbiJz9@shell.armlinux.org.uk>
 <20260227165556.5cf9e844@kernel.org>
 <20260228083111.5df8550c@kernel.org>
 <20260301001453.lpd2rawy7bqxyivp@skbuf>
 <aaRCN7zbX6FjUtQ_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaRCN7zbX6FjUtQ_@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262401-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37AA71D0243
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 01:42:15PM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 01, 2026 at 02:14:53AM +0200, Vladimir Oltean wrote:
> > On Sat, Feb 28, 2026 at 08:31:11AM -0800, Jakub Kicinski wrote:
> > > On Fri, 27 Feb 2026 16:55:56 -0800 Jakub Kicinski wrote:
> > > > On Sat, 28 Feb 2026 00:11:29 +0000 Russell King (Oracle) wrote:
> > > > > The AI review for patch 7 says:
> > > > > 
> > > > >   This commit fixes a bug but lacks a Fixes: tag. The commit modifies
> > > > >   behavior introduced in 360000820ae2 ("phy: qcom-sgmii-eth: add
> > > > >   .set_mode() and .validate() methods") by making phy_power_on() call
> > > > >   qcom_dwmac_sgmii_phy_calibrate() to restore the previous setup, and by
> > > > >   making qcom_dwmac_sgmii_phy_set_mode() check if the PHY is powered on
> > > > >   before attempting calibration.
> > > > > 
> > > > >   Should this commit include:
> > > > > 
> > > > >   Fixes: 360000820ae2 ("phy: qcom-sgmii-eth: add .set_mode() and .validate() methods")
> > > > > 
> > > > > which is _wrong_, this isn't a bug fix.  
> > > > 
> > > > Yes, that's what I thought but then I saw the other thread..
> > > 
> > > Trying to apply this now but stmmac parts don't apply on Linus's tree,
> > > and Vinod wants a tag :( What do we do? 
> > > 
> > > Could you, perhaps, send us a PR with this on top of Linus's tree 
> > > (a resolution of the inevitable conflict with net-next would be helpful
> > > too).
> > > 
> > > Or do we give up on the tag?
> > 
> > Actually, I think it's mainly me who wants a stable tag. I'm working on
> > a series for phy-next which will conflict with this hunk from Russell's
> > patch 1:
> 
> Is this because of the issues I raised with the quality of generic PHY
> API implementation by drivers?

I don't think the issue you are referring to is so much a "quality" one
as it is a "lack of requirements" one, but to answer - not necessarily.
Eventually I'll get to Ethernet Generic PHY interop too, but I saw as
first actionable step to clearly delineate what is PHY provider API from
what is PHY consumer API, in an attempt to stop PHY consumers from
poking inside struct phy.

To improve the interop situation, apart from patching drivers, I plan to
introduce a new CONFIG_GENERIC_PHY_EXPERIMENTAL (meaning: enable for
development, don't enable for production, but drivers required to work
with EXPERIMENTAL turned on) which would make a few changes:
- make the .validate() function pointer be a required dependency for
  .set_mode().
- call .validate() before calling .set_mode(), and reject the call if
  the mode and submode don't pass validation
- swap the power state before calling .set_mode(), and restore it
  afterwards

Some of these changes do need that consumer/provider API separation I
was talking about. For example, consumers should not look at the power
count of the PHY (some of them currently do; not to mention they do this
without proper locking). They should only concern themselves with
whether *they* powered the PHY up themselves.

