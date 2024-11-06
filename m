Return-Path: <netdev+bounces-142219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19109BDDC1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 04:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719E7B234A1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F0190493;
	Wed,  6 Nov 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eFjlg1jU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7895190468;
	Wed,  6 Nov 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864643; cv=none; b=eN7+Age21KU/Dmg7aLVm+3oo/Ln73ZG13Ojc3v9ji23xH+BE81jioSSew/5SPda1FT0UgqOvUsp4/n6lOxzevoz97C3X8iN9FON/hSeIwCDkOJUXefg6cujBdQrnhPQ/wt4O997YrAiPulCIeldFr74iWSWTsr75ZgNDQABmCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864643; c=relaxed/simple;
	bh=ZncZUTSm22c5m24Ui4mJNMu57aMs6v/CYQsluLVrFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZmdJRI7FXjitjmtCeoVycWu/Z3Qr/8pCk5/Rzm1f0KBRd34TkIEWlEgKykmLZZH5tNy5qpaTjqGCy93grS2Ntu0avGJ/AojYHbeSuEBf/R/fxATXW/gYL1xg1p9sKhxmevH7/N2N1enpDIi+FmZSQf8PqBouh8f+HnMXmB4oTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eFjlg1jU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=62ogp206Pt4nsQOJ/YCTzDbyZHE4u3VhsCNVD+OXsko=; b=eFjlg1jUgGFnIu6M17ETvJbH10
	0UlXroM4BfY4a7JmOvPtV8NKwcf/Q9HJvl61tpwrsEi74go5PZ75k8UcK34eePWr9JjsvkV/YxsG/
	OxkC1afjkZTVE+UTrhTCeTfLABPYwd4P7km5r/z+xWphQ75C7HWK7LJCEhR1j3y0eKjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8WxL-00CHsW-Mw; Wed, 06 Nov 2024 04:43:43 +0100
Date: Wed, 6 Nov 2024 04:43:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com, quic_linchen@quicinc.com,
	quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org,
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com,
	john@phrozen.org
Subject: Re: [PATCH net-next 3/5] net: pcs: qcom-ipq: Add PCS create and
 phylink operations for IPQ9574
Message-ID: <a0826aa8-703c-448d-8849-47808f847774@lunn.ch>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-3-fdef575620cf@quicinc.com>
 <d7782a5e-2f67-4f62-a594-0f52144a368f@lunn.ch>
 <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3a4f00-59f2-48d1-8916-c7d7d65df063@quicinc.com>

On Wed, Nov 06, 2024 at 11:16:37AM +0800, Lei Wei wrote:
> 
> 
> On 11/1/2024 9:21 PM, Andrew Lunn wrote:
> > > +static int ipq_pcs_config_mode(struct ipq_pcs *qpcs,
> > > +			       phy_interface_t interface)
> > > +{
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	/* Configure PCS interface mode */
> > > +	switch (interface) {
> > > +	case PHY_INTERFACE_MODE_SGMII:
> > > +		/* Select Qualcomm SGMII AN mode */
> > > +		ret = regmap_update_bits(qpcs->regmap, PCS_MODE_CTRL,
> > > +					 PCS_MODE_SEL_MASK | PCS_MODE_AN_MODE,
> > > +					 PCS_MODE_SGMII);
> > 
> > How does Qualcomm SGMII AN mode differ from Cisco SGMII AN mode?
> > 
> 
> Qualcomm SGMII AN mode extends Cisco SGMII spec Revision 1.8 by adding pause
> bit support in the SGMII word format. It re-uses two of the reserved bits
> 1..9 for this purpose. The PCS supports both Qualcomm SGMII AN and Cisco
> SGMII AN modes.

Is Qualcomm SGMII AN actually needed? I assume it only works against a
Qualcomm PHY? What interoperability testing have you do against
non-Qualcomm PHYs?

> > > +struct phylink_pcs *ipq_pcs_create(struct device_node *np)
> > > +{
> > > +	struct platform_device *pdev;
> > > +	struct ipq_pcs_mii *qpcs_mii;
> > > +	struct device_node *pcs_np;
> > > +	struct ipq_pcs *qpcs;
> > > +	int i, ret;
> > > +	u32 index;
> > > +
> > > +	if (!of_device_is_available(np))
> > > +		return ERR_PTR(-ENODEV);
> > > +
> > > +	if (of_property_read_u32(np, "reg", &index))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (index >= PCS_MAX_MII_NRS)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	pcs_np = of_get_parent(np);
> > > +	if (!pcs_np)
> > > +		return ERR_PTR(-ENODEV);
> > > +
> > > +	if (!of_device_is_available(pcs_np)) {
> > > +		of_node_put(pcs_np);
> > > +		return ERR_PTR(-ENODEV);
> > > +	}
> > 
> > How have you got this far if the parent is not available?
> > 
> 
> This check can fail only if the parent node is disabled in the board DTS. I
> think this error situation may not be caught earlier than this point.
> However I agree, the above check is redundant, since this check is
> immediately followed by a validity check on the 'pdev' of the parent node,
> which should be able cover any such errors as well.

This was also because the driver does not work as i expected. I was
expecting the PCS driver to walk its own DT and instantiate the PCS
devices listed. If the parent is disabled, it is clearly not going to
start its own children.  But it is in fact some other device which
walks the PCS DT blob, and as a result the child/parent relationship
is broken, a child could exist without its parent.

> > > +	for (i = 0; i < PCS_MII_CLK_MAX; i++) {
> > > +		qpcs_mii->clk[i] = of_clk_get_by_name(np, pcs_mii_clk_name[i]);
> > > +		if (IS_ERR(qpcs_mii->clk[i])) {
> > > +			dev_err(qpcs->dev,
> > > +				"Failed to get MII %d interface clock %s\n",
> > > +				index, pcs_mii_clk_name[i]);
> > > +			goto err_clk_get;
> > > +		}
> > > +
> > > +		ret = clk_prepare_enable(qpcs_mii->clk[i]);
> > > +		if (ret) {
> > > +			dev_err(qpcs->dev,
> > > +				"Failed to enable MII %d interface clock %s\n",
> > > +				index, pcs_mii_clk_name[i]);
> > > +			goto err_clk_en;
> > > +		}
> > > +	}
> > 
> > Maybe devm_clk_bulk_get() etc will help you here? I've never actually
> > used them, so i don't know for sure.
> > 
> 
> We don't have a 'device' associated with the 'np', so we could not consider
> using the "devm_clk_bulk_get()" API.

Another artefact of not have a child-parent relationship. I wounder if
it makes sense to change the architecture. Have the PCS driver
instantiate the PCS devices as its children. They then have a device
structure for calls like clk_bulk_get(), and a more normal
consumer/provider setup.

	Andrew

