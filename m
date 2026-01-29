Return-Path: <netdev+bounces-254790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEtkDhNbe2nXEAIAu9opvQ
	(envelope-from <netdev+bounces-254790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:05:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8859B03C4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18F030136A7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C938885D;
	Thu, 29 Jan 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZEjDksO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659934FF72
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691918; cv=pass; b=aw3LgI4zirwGsIe78/8zhcV55IBa6E2riT2xtnsw008x2OEVarriwrZi6pNPQvTZfVqIZcpQwXJXInHDAyBYY+JFA1v5rTGrKGcbEWBM4f3JbRp01SOsIPmk+WD7VxKD+GpaI001Z+6rzMvaBDcixpTfrMrRUQ1eqih4n191/gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691918; c=relaxed/simple;
	bh=QzGxG1kvMM/GBBvFO0xkrpNgT0WXpaEu6YZ2R1cThBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqeAbfh71l5sSQfPAcfMpI5ek/XPI+4VgYk970GRdCTuGgyL7yrJKDhl8LvZ/DX/l6JPTpxFZQwMZqaKp2FjW6TXxp/y5GDXsr7NNdL+f67eRwTkiTPck2zVk7rqpD+ovcKFiglFqfD19oq6MYl8dHf26rLtlHk+LL74JFGTpEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WZEjDksO; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1318971a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769691915; cv=none;
        d=google.com; s=arc-20240605;
        b=VVXrSUkV+uqJdg+34i1ZM3MEjC7IXwsgTCpViBP0Nm8wTXQ4I4GVcMnF0d08GxYRpq
         CQ+a1XsdYfSYbTFtBzgnuq10njfWDKGyczUt7k1RAXCE+af4xa8AHt8uyET/PlapVJaA
         SGyk2cnPUlQyMipzNOqarMXRZy+maijGXAOOJcbqoJgKghMbEvuE4NYEPJqjtZ3Asnhs
         /7KJxOAe05ZFvoUjlnxpfYyRsMUpVmx4L60rrz1ffvtj4sFE+9QVc7U97z+3TVjVgBhe
         mHWBUQ5luPLO7HgvmC6WRD6P869OlLmWjjqEH+gCbxEZtcPPe6jRE96MYPJDWah289+N
         tNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hV0EaAfSfWXdEAd8ez6i9+1b1e2fuFvIVn/DRhtOP0g=;
        fh=RzvmY4zL0c57+P4Ho4soz5Gnf5reATajv33FNSQdds8=;
        b=CeJwh+FA+4P0MW4JBEeXnhaHxGw61nycuJLf3Ha+Q8FeS/K8er6wPkfdx4EcJNhh8/
         bBXxYu9kvN9vZz5QF3E2+09QSOqrkxwCY9qjB+F5heJ+AO4rAvgpR3KE+6Zq6oJLMCw1
         erH5Y1D8aah94aB0PRlm6yHGE5f0nqQHn0l+DXOKg4z4eAnKJhJxOb+JlufIssJJOsXM
         415d1LNJ2U/0r7WoN5JQ/Nc9zDfaKbZTT3iWnUqnXyw2hH8hR2Uy0xyp+LKYoZFI1fUY
         WBZLC6svIvQV4NQv3LUojCFymMHwG/qjp5xaEFmhiWqGWzFHZWi8pboIlOBKJGD2BIKp
         BqjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769691915; x=1770296715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hV0EaAfSfWXdEAd8ez6i9+1b1e2fuFvIVn/DRhtOP0g=;
        b=WZEjDksOHJXwdPlX30BDiJhRpWT3zW2YJOaNYm5WoNBasrsMj6jNjHt0uD3o0YB6zd
         UGEtA6l5xNdSkkNIuiuRMqJdd/R79VqtApiF0sc80w4Zdp0wNo5HGsqcKmc4jh5eg2kW
         aMgfP/0RvtVPgjD8mM710d7OD8baj5B6q3DcFn8v/lES1MS49/YRmiJjlc2zOBtDehum
         q0r6vgcqnRqwBg5rTlDxjT7o2qXt3plxxJCHB3yf0RJmTcPimS3/emTnlscA5Lsty8ts
         3SpWivlArjPytdcQyUI6mBiLQlqLd8iEhQwXJNSbE2j3RRjppl2CNsikkBuJ8AYcLnY+
         NPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769691915; x=1770296715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV0EaAfSfWXdEAd8ez6i9+1b1e2fuFvIVn/DRhtOP0g=;
        b=L8eOO+vwSwt41hhTkca50/924ULYRRJ89IXCzn2bfTUvNyjQxyJitrrXVdLrqf2qEQ
         bGJBbqJUjRFl10qCTNEbxLN7VOTQV1DU0DVgToGnQwErd5NryGDy7KLrLtGaFSlJDwLV
         VtjwD80t4oTXs+dbqsbuuuZHU154OFst+ThQs/mFv71PoiDT/9O/eAxv8oTjcwtdz3ah
         Tkwr2Etkucc1vVmfhWMDDtO7t8p2LHXhaQ2Rwd/UhXlQVHUqvUyXyerb7KffpvFvcROs
         r4II06eDAvtDGlfesllR360sgs5VCtv6fEFUzAAqSe5+tUVMXvEZ5E2sp5jJLHFmQTOS
         V+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCURLxnVUzcSN7t0kVZ9bBfKG+daNBVWTBT/noUvXf6lCVonLscEJk66CWWMuZOHhifP5BSO6kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZKvadJfZPmiqIKX38zeWiurdkuj0aqtn4uAw8FuOwpStTLhA
	UebeDBA/+TwRZrF9wpFp9glS0ffPoGkJ+ITefnW6QnUgSK3NxharVnIcSM9mtJU++ndPvqILWce
	jkaid9zj2Cgi+1fkk55QnCY5fgnIa45hl9+zo/pQ52Q==
X-Gm-Gg: AZuq6aJKshp9O6cXi68CIKq+8z2bw1jLN9Mo1bFDth1whvyLxsDDq7gchzkbewOoeP+
	rE6u2Y5TA9NK5Pi0JXr9Ah56CzPcu7SlhKeeWvIYwqDzEGdfGkf7nhYYOY88H23nu+vvn6BMfqo
	7o8jaEnaP94SKAYj3w8aDHFes5Z/0uIbSbN/rMH0tha0/y4cTadblDCkit/JJSjPy9bsBY6EKdi
	vNoU3MDgxkcvmtieTzR6LhnkVh4u8vVJ7RyHeGSZLgQG0lnUD8eJ/A7ELu3+T2lhVa+yyNQeG02
	yRe8HZKD/hc5ERnTgcf54FxGgtIX9eXaQyQ=
X-Received: by 2002:a05:6402:5187:b0:658:cc59:161c with SMTP id
 4fb4d7f45d1cf-658cc5917c8mr1678090a12.12.1769691914958; Thu, 29 Jan 2026
 05:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-2-vincent.guittot@linaro.org> <aXtXmN1V8wg57yuE@shell.armlinux.org.uk>
In-Reply-To: <aXtXmN1V8wg57yuE@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:05:03 +0100
X-Gm-Features: AZwV_QhIdeGA_SmdiEnXscTGdrXOcfbfoiNkh_dYEPgauVTbh2-bOtUlEiHJGvM
Message-ID: <CAKfTPtANQsmWAf-u6+isXh5UHJdo2mYELBYio=-UxZj3WM6-5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: serdes: s32g: Add NXP serdes subsystem
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, 
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com, 
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254790-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,armlinux.org.uk:url,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,devicetree.org:url]
X-Rspamd-Queue-Id: D8859B03C4
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 13:50, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 26, 2026 at 10:21:56AM +0100, Vincent Guittot wrote:
> > Describe the serdes subsystem available on the S32G platforms.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  .../bindings/phy/nxp,s32g-serdes.yaml         | 154 ++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > new file mode 100644
> > index 000000000000..fad34bee2a4f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> > +
> > +maintainers:
> > +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > +
> > +description: |
> > +  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
> > +    - One PCIe PHY: Supports various PCIe operation modes
> > +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> > +
> > +  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
> > +  must be adapted accordingly. Below table describes all possible operation
> > +  modes.
> > +
> > +  Mode  PCIe XPCS0           XPCS1           PHY clock       Description
> > +                SGMII                SGMII             (MHz)
> > +  -------------------------------------------------------------------------
> > +  0  Gen3    N/A             N/A             100             Single PCIe
> > +  1  Gen2    1.25Gbps        N/A             100             PCIe/SGMII
> > +  2  Gen2    N/A             1.25Gbps        100             PCIe/SGMII
> > +  3  N/A     1.25Gbps        1.25Gbps        100,125         SGMII
> > +  4  N/A     3.125/1.25Gbps  3.125/1.25Gbps  125             SGMII
> > +  5  Gen2    N/A             3.125Gbps       100             PCIe/SGMII
>
> Shouldn't the mode be configured via phy_set_mode_ext()?

There is a phy for only pcie only. In mode 3 to 5 there is no generic
phy created

>
> This identifies whether it is operating as PCIe or for networking and
> in the case of networking, the PHY interface mode should be passed as
> the submode.
>
> Have a look at include/linux/phy/pcie.h to see the submodes that may
> be appropriate to pass to phy_set_mode_ext() - but talk to the PHY
> subsystem maintainers.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

