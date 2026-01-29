Return-Path: <netdev+bounces-254789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEytNmZae2mvEAIAu9opvQ
	(envelope-from <netdev+bounces-254789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:02:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156DB03A5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147AF3012EB8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2838885D;
	Thu, 29 Jan 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iippdaG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BE3803E2
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691745; cv=pass; b=gH88A/H1gNffSgIPyhnGwzrlwgCb3+NwdjuVBQuLT0GCBSqZuNvcijI3xUzRIPVtds6X4SwAMIVgHBKXDR4dsFvnbIjhj8N/mHqdoMlJa8x/u/m5Sud1fNwFzsCA4HuBez8I1XBouyeKov/H5sJOp9ncbcbkrWARhDe9se9shJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691745; c=relaxed/simple;
	bh=zWi6BdjEruZKfQY5kJrDlYRRB/tcW9tTziCrmlMA5Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSZTHPiWA2Ugv4IiYgoWc437SyoB1LGtQ3T22LVtEBOE1w8Qvv+GRSQ9yFxFF9buqVMhhhlE6g0nUemKccszB4yaM69ofWZAqX/gHOl7PWVjcSzeRsy0ZfwLUnjBIjmSYeTIejsDBkczWlXOGrsf9PKAnMg5tYFc8+hNY/EBoho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iippdaG1; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so1510430a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769691742; cv=none;
        d=google.com; s=arc-20240605;
        b=XdaWDmd0C7JgT7XRJylMLrs1pWVnZF3RnMX5/X+hAnWms61U/e7Ff9ONTpvUEdKmsb
         wLacUpaiixt4lEgrv6GdHD1Hs0TCij79xYBjg9fSu06BZPcTGspE8qE3OUEvC/v7DwAH
         EMuEsieBkRQRKpWrXA5OdFmcKY4CyqU0IRoVafQZwZFJgTfwET+7lVVSjAIqGeNYJ6sc
         l3reEezSy3bkkRL0sFprcdTBxWzDr/6xApVQOFl0MpR4cfYjrsbYhLpKh6N34L8lJ6Nr
         mD9Tgt1LDF4sv4U1zd5/Dkf30VgtW2CeKGZIEnyFmPy5XjwkL4POceS8w09S/28LN1Or
         pgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o5jH8Rxdp+tEZoB9l9fTv6AucC1v6C8I9T+8Tw0hHlg=;
        fh=adour+Nv3Mj5l53aS3vOqEVx/BrIpgXgh+49/lVYWss=;
        b=in/iWG27hyR1821k750W82b1Gf746iwePOYtnCHQC01qYlnA9gC+1BdcVxAaafcsGE
         wRzQ9qwZ6EGQYWmIem9nP3GhPulOpWixRcXTvBY7H0xR7sPc7a70bV3qHe6LE6y6ncWf
         XjTlYqYQbJhD8GcYCw5K4qdvqLE3LoZsdgF1sqytTBcc1P1MSxTkjRAwsKrSlu6koBAk
         IVXmsZU1Iw2ib2/b4MP9BC1pUlZbdsKB1N4j//NTr6TEhHuquSvATcZo9jERDtcn7yAQ
         QGkxBW4jeBKBQkFVp6D0l697vN2/gdJnZ/A8KvfNnmbHia4wa8YdWkqVnYby/EK+3awS
         J7sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769691742; x=1770296542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5jH8Rxdp+tEZoB9l9fTv6AucC1v6C8I9T+8Tw0hHlg=;
        b=iippdaG1iImj0qxZcZ88l2Ln2PUC89WfsMOXtiEiyw0D0ILD6J+pzaqPlXZ5SivEY0
         kLibW2T2Nfr0cgTl0Asn+jLN8S9fzrIEGq6V0wZo6+qr4Z2yGjQZKOebOHs4icgqdtq+
         m1UCXDSEZDSZMnqtL4jfwoLIkCr1/7GfXq3r+vMfOWakLfZ5jNXJMg/Z0v4H1jCuABrM
         JkfMGAnefl8I5xJOpAkGTwPisOS7cj0PqrADfCne/cKvcNDEm/KM37Ttv0wBH7KpRKug
         OIjBrhnsC3JvVzgL0tncZ8MHRH8rtuYetzjFceX17xCrQ+P1IrsM2WLCb7Dt//GeOmcB
         8xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769691742; x=1770296542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5jH8Rxdp+tEZoB9l9fTv6AucC1v6C8I9T+8Tw0hHlg=;
        b=Mraw++xIJh9/HrI6KHe3r+micoljPixaLLDDFtp1xY2pZmjFzB7m01DjY/Q5EQWOQY
         5wuipWg8ABuUozEnTSYroIYmLo4yX6HW+ipbrHVE1hGwZbaI4J44TXxpyJ92eMJFO4kn
         A0pg4LWXb3Ac9PW92cGhhvvTxmiMLed1hvfJXYJyZxRqXKWFy34RIxOIDfjzSdYrV+I7
         PesXzCxNH8NVsX95/HlUdjkceFZof8TwVkKSqoa81MJcrk0IzFgRqu4qW+imiNABxiKa
         EyPNjJYW8DR1bdxTZnNX2Q/e8Mb/Lr/PehGiFYf3vnciZTYhkGzIc2i9JmEJkiBmuYdQ
         +Iqw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDWsoDpqO4pRzzVPUmPo6cZ0VErQAq5VjFbFt06/6wqswBW/CUQFAk96YDh5hFhQubLlh/9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkB3a8yDD1vT5qp53j9zTv3f7Jawba6vQkJgf8+22b/3oQ4lb9
	zHWoom0HP1SbbfYX2/A2m9h2dvhbUf1EQ7yEQeE+IB8X695B5nBVFuYLYot3zYcX2/xLn7gPTYs
	0PB21PhOVP6FhhDCmDf4a3z70a0ClBsAVkCI+TYLscw==
X-Gm-Gg: AZuq6aK1LLeAfazerwvDySP9XfugmpdkfLZKFecMw9kj6IIYIgJLzITFk4xw9arq4oz
	odWFksl5z+kgglIfo3mQxCPVeRXqTqtn07UqoAMkM/GwfunuyoXJTz3Buxm0INXxasjC7FKu5Yb
	j0mgBaPJamUmiUEgIOmqa5o3Rw9cnENmfuHPi8aBcryG4exgvaAVsC3f8FNnYll1rRzfzc5YvRH
	C0Ltb6xFiahuTPt8H+C6tbd7EC3+Kyfj34X8aDV2vZ5XILqFjJjBU9nPHLTQZiUHKoBVP+ilTgv
	3sxjJ9/fKEv19MuUSPpedaNZ
X-Received: by 2002:a05:6402:40d6:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-658a5f8cfdamr6437778a12.0.1769691742347; Thu, 29 Jan 2026
 05:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org> <aXtB0QcVOkE_hhny@shell.armlinux.org.uk>
In-Reply-To: <aXtB0QcVOkE_hhny@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:02:09 +0100
X-Gm-Features: AZwV_QgTBsEbqAq2XkLUgo22OQOD7HpGZIhc6Tp00c8M0BIdl_pPusc1NHtuBUU
Message-ID: <CAKfTPtAg201wXU_LuO-Y0M8k6ew8-vhKsjoHzJ1sxqp3Pn=wVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, Ionut.Vicovan@nxp.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254789-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,mail.gmail.com:mid,armlinux.org.uk:url,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3156DB03A5
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 12:17, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 26, 2026 at 10:21:57AM +0100, Vincent Guittot wrote:
> > +/*
> > + * Until now, there is no generic way to describe and set PCIe clock mode.
> > + * PCIe controller uses the default CRNS = 0 mode.
> > + */
> > +enum pcie_phy_mode {
> > +     CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
> > +     CRSS = 1, /* Common Reference Clock, Spread Spectrum */
> > +     SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
> > +     SRIS = 3  /* Separate Reference Clock, Spread Spectrum */
> > +};
>
> So this is a PCIe thing. If it's part of the driver's API, then it
> should be common and not driver-private.
>
> > +static inline bool is_pcie_phy_mode_valid(int mode)
> > +{
> > +     switch (mode) {
> > +     case CRNS:
> > +     case CRSS:
> > +     case SRNS:
> > +     case SRIS:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
>
> This checks that the submode is one of the PCIe private modes that this
> driver wants to see.
>
> > +
> > +static int s32g_serdes_phy_set_mode_ext(struct phy *p,
> > +                                     enum phy_mode mode, int submode)
> > +{
> > +     struct s32g_serdes *serdes = phy_get_drvdata(p);
> > +
> > +     if (mode == PHY_MODE_PCIE)
> > +             return -EINVAL;
> > +
> > +     if (!is_pcie_phy_mode_valid(submode))
> > +             return -EINVAL;
>
> This checks for the PCIe submode, but notice the test immediately
> above. PCIE mode is being rejected. So, this driver supports
> everything else but PCIe.
>
> That doesn't seem right.

It's a mistake

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

