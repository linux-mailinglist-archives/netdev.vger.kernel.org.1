Return-Path: <netdev+bounces-157926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AEA0F7FE
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AB73A7E40
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA625234;
	Tue, 14 Jan 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOTFj0wR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0A1361;
	Tue, 14 Jan 2025 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813249; cv=none; b=VoI0iEz/e5tKZPKLcmzHfTgy+s+DLYc0yC3Nzf4NVqoEmbTFCmhsSDjFrMOjNkD85iB9y7rK7gl+8vx728OIzRMDFgAQW8e9+9DwlsInuayxtx3sWX7gCOY6t6OnEuVpbXYI1TkAyYuX/N+rRkTvzbwy35I3CR5grNRerWvJVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813249; c=relaxed/simple;
	bh=YFHHVZRBvQPdmgWH/zLMVMHmLYNVEI8tzbQwTlW2Ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shlGn5xXtL4FVnUVkxjtUwk2I0/5rx+xmjI3q2/S1TuxAPiedjT09y4lxDb3Nh+K0nQVgqOJQSGlLJKwt7ks12QQuBKV+pv5KH/yTvrFSzFhwcY4HKCSe2PHpCxxfHMWUohJDjELtl+p08ACD9N3UD5aVoYsEmDFl2iT4WFXeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOTFj0wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8A6C4CED6;
	Tue, 14 Jan 2025 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736813249;
	bh=YFHHVZRBvQPdmgWH/zLMVMHmLYNVEI8tzbQwTlW2Ih0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOTFj0wRO1DfGUp6+VPCpqUafTsi7L81Xr/N1PyvWv1a0wb1I4O86uruKRYFwp/yb
	 igPuym1uXdVCyaO46OsTWZUuJAeWGwjtlxxC8TFV3UYQ7vSkFlpWbKNa+ttNjOZmS8
	 DqED6du4VBtXZGo24cMncrjO+hPNftFqjQ2ivI/4lO/jbzA89ZglO+T2AL/lgVeyl+
	 ri9/TJeJp7GMU4FOlVQfq5iRNAJHTgDVY59qI3DaMhQXZ6DWnW+B3v2AiqX+EF7MvC
	 xzTniRwae/Ojf+PxOth+YwBTUMArkHFSH4ZpuPDAh+QcNg4CK4BoHzKC4ZKB/x+ki5
	 M53UnNGvTfAmQ==
Date: Mon, 13 Jan 2025 18:07:27 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com,
	andrew@codeconstruct.com.au, netdev@vger.kernel.org,
	kuba@kernel.org, joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org,
	openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, eajames@linux.ibm.com,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch, minyard@acm.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC
Message-ID: <20250114000727.GA3693942-robh@kernel.org>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <173637565834.1164228.2385240280664730132.robh@kernel.org>
 <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>

On Mon, Jan 13, 2025 at 01:52:01PM -0600, Ninad Palsule wrote:
> Hello,
> 
> On 1/8/25 16:34, Rob Herring (Arm) wrote:
> > On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
> > > Hello,
> > > 
> > > Please review the patch set.
> > > 
> > > V3:
> > > ---
> > >    - Fixed dt_binding_check warnings in ipmb-dev.yaml
> > >    - Updated title and description in ipmb-dev.yaml file.
> > >    - Updated i2c-protocol description in ipmb-dev.yaml file.
> > > 
> > > V2:
> > > ---
> > >    Fixed CHECK_DTBS errors by
> > >      - Using generic node names
> > >      - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
> > >      - Adding binding documentation for IPMB device interface
> > > 
> > > NINAD PALSULE (7):
> > >    ARM: dts: aspeed: system1: Add IPMB device
> > >    ARM: dts: aspeed: system1: Add GPIO line name
> > >    ARM: dts: aspeed: system1: Add RGMII support
> > >    ARM: dts: aspeed: system1: Reduce sgpio speed
> > >    ARM: dts: aspeed: system1: Update LED gpio name
> > >    ARM: dts: aspeed: system1: Remove VRs max8952
> > >    ARM: dts: aspeed: system1: Mark GPIO line high/low
> > > 
> > > Ninad Palsule (3):
> > >    dt-bindings: net: faraday,ftgmac100: Add phys mode
> > >    bindings: ipmi: Add binding for IPMB device intf
> > >    ARM: dts: aspeed: system1: Disable gpio pull down
> > > 
> > >   .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
> > >   .../bindings/net/faraday,ftgmac100.yaml       |   3 +
> > >   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
> > >   3 files changed, 165 insertions(+), 59 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> > > 
> > > --
> > > 2.43.0
> > > 
> > > 
> > > 
> > 
> > My bot found new DTB warnings on the .dts files added or changed in this
> > series.
> > 
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to reply
> > unless the platform maintainer has comments.
> > 
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> > 
> >    pip3 install dtschema --upgrade
> > 
> > 
> > New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:
> > 
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
> > 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> 
> This is a false positive. So ignoring it.

No, it is not. You need to define hog nodes in aspeed,ast2400-gpio.yaml. 
See other GPIO controller bindings that do this.

Rob

