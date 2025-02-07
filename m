Return-Path: <netdev+bounces-164026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AFA2C547
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FC1676E7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86C41DE8B0;
	Fri,  7 Feb 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZKaS7n8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F27FD;
	Fri,  7 Feb 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938619; cv=none; b=LLUpj13N1TZLj/MLZm5xRsUZaDr3EU5QE6TkLPyENYFhwxKiEpqS4ekb1ucCiHsQdw+umPfdZPDDslk4a5w3DbMTfBGGBYxzK9rR6H+TxVmucUktKf9vZjBnRned/sMBYBKP+17IKx1o5VpwfnnXVG3w0Pmqox8YivjuRSP6XqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938619; c=relaxed/simple;
	bh=M7J3Wn5yGM6nJZTo99fvgpwjBivapFjDhCds22gPMd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RreMyo1mCCyju9mfcKJyFdrKJkOivlQdJOziX7ymjNSIaJO/gver8QdOx8DMUiGn1aI6gDgdz+V8lzzF6KCkKlV9/5zcq4T+VH2P13/nODno1cohna5xTHgQqSiuj/fW4NWFHchAr0r7Gvj3pkejU8QWngVvvllhVYeAEP3DvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZKaS7n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED409C4CED1;
	Fri,  7 Feb 2025 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738938619;
	bh=M7J3Wn5yGM6nJZTo99fvgpwjBivapFjDhCds22gPMd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZKaS7n8d6KrLvwnHFTArNDNh1QmX+z4KEpp98yD4uRL0EKAuFgdpGAW66fA24Sdv
	 igYKaYCTqPh+XySTyc5CGBEp4UWzwGfyfXqKMUn6I/0RUMizlEn51HgHKMOr6xdVla
	 EQkGF5YGqfJAUp4aA8W7z1SfWmwtLn4KC75lMdnzp3l7PQ1Qv5znw8woH4coIDWIDe
	 N2gqiDDT/XVFRjN0/c+kmHGncQgIpH7CbLDDDgb8Ba1mHfM+CgfdpP6WhVZIrGX0it
	 6dTa2wDnErroE5fsxUtFfqfU7sldz1dRjgYDwATtC0KXSVk2do+knEZ1e2EO0Q4kiY
	 upu35g2m8fEsA==
Date: Fri, 7 Feb 2025 08:30:17 -0600
From: Rob Herring <robh@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: dwmac: Convert socfpga dwmac to
 DT schema
Message-ID: <20250207143017.GA38694-robh@kernel.org>
References: <20250205-v6-12-topic-socfpga-agilex5-v4-0-ebf070e2075f@pengutronix.de>
 <20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de>
 <173877418502.1694868.7734639778320336620.robh@kernel.org>
 <87ikpn43dm.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikpn43dm.fsf@pengutronix.de>

On Thu, Feb 06, 2025 at 02:19:33PM +0100, Steffen Trumtrar wrote:
> 
> Hi,
> 
> On 2025-02-05 at 10:49 -06, "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
> > On Wed, 05 Feb 2025 16:32:23 +0100, Steffen Trumtrar wrote:
> > > Changes to the binding while converting:
> > > - add "snps,dwmac-3.7{0,2,4}a". They are used, but undocumented.
> > > - altr,f2h_ptp_ref_clk is not a required property but optional.
> > >
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > ---
> > >  .../bindings/net/pcs/altr,gmii-to-sgmii.yaml       |  47 ++++++++++
> > >  .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ------------
> > >  .../devicetree/bindings/net/socfpga-dwmac.yaml     | 102 +++++++++++++++++++++
> > >  3 files changed, 149 insertions(+), 57 deletions(-)
> > >
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.example.dtb:
> > phy@100000240: reg: [[1, 576], [8, 1], [512, 64]] is too short
> > 	from schema $id: http://devicetree.org/schemas/pcs/altr,gmii-to-sgmii.yaml#
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.example.dtb:
> > phy@100000240: 'clock-names', 'clocks' do not match any of the regexes:
> > 'pinctrl-[0-9]+'
> > 	from schema $id: http://devicetree.org/schemas/pcs/altr,gmii-to-sgmii.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250205-v6-12-topic-socfpga-agilex5-v4-2-ebf070e2075f@pengutronix.de
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> 
> 'pipx upgrade dtschema' says I have version 2025.2, but I still don't get theses errors.
> 
>    make O=build dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.yaml
>    make[1]: Entering directory '(...)'
>      CHKDT   (...)/Documentation/devicetree/bindings
>      LINT    (...)/Documentation/devicetree/bindings
>      DTC [C] Documentation/devicetree/bindings/net/pcs/altr,gmii-to-sgmii.example.dtb
> 
> Anything I'm missing or doing wrong?

Try:
make O=build dt_binding_check DT_SCHEMA_FILES=net/pcs/altr,gmii-to-sgmii.yaml

The full path should work, but seems there is some issue. But really, 
DT_SCHEMA_FILES is just a sub-string to match with schema $id.

'reg' should be the number of logical entries (and what they are), not 
the number of cells.

Rob

