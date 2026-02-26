Return-Path: <netdev+bounces-261515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCWeETKNoGkNkwQAu9opvQ
	(envelope-from <netdev+bounces-261515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:13:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB561AD60C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC8FE3007239
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D544355F21;
	Thu, 26 Feb 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwugQ86/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461613290D3;
	Thu, 26 Feb 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127554; cv=none; b=a/n0sXJooMqTyN6QCfu75trfUmGXiPt6bp8h/nO+/aV2o6WQKfvzEIqN0v1KkWzqleXJ2waw4zUoERVCn5++llDv6ccti+8dBFtkScmm4EiJbebmGirHdrU2sRhHfLTz+KZ8geOzI/jX2Y1FOt+09MUSurkqJxxmVFbtz9hCyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127554; c=relaxed/simple;
	bh=nThCQLbabJ0yq+l47grbVRbkwAW8YTIAhiJzvLJHKX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLOaX5SSzwdUHZopKCYxseLYu2Pl7DjDptxhskAIiXStna2agefS3zvEI0K4B3v+utNPMJthciyO6TupUC50izexmTPjeAgOvZy83r/2kYaZxLQmhyijU+4hH4ih4MpZcGETia9ZONJuuSFuUHXJqigHrYPqYqtnT7R/HYQ9Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwugQ86/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD9C116C6;
	Thu, 26 Feb 2026 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772127553;
	bh=nThCQLbabJ0yq+l47grbVRbkwAW8YTIAhiJzvLJHKX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwugQ86/npjsesdwAJsYp2Ax+O2Pngm5aol5NZ55QZJ7T1ahJAkwWQQ2B2OMAFQNt
	 vvdRAwhJN/5OBlwYrJcnz3QuG41dimSLOXm3zd42wyBClcB6Jzuawao30M0A6fJoSl
	 feYmXZR44DaBYDiMJlCAwNdAB0WBYOYuDVDA7TYOYWvjFwrphLsqglbNvIypSPNKRw
	 ZYdurlezM0nrCHqs2jwIg4uTT6CeqXx9YFGZc4ttk8y3B8bMsJY2EOu2jr/VPq5g/M
	 8LDwDHr2kc2FsYyb6DGCJqN48VEKdUyIhPPYvEeWDR+m2tg7IgZbSCfM9N8iAIKG2N
	 8WNUpBR13S4Ng==
Date: Thu, 26 Feb 2026 17:39:09 +0000
From: Simon Horman <horms@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, opensource@vdorst.com
Subject: Re: [net-next,v2] r8152: Add 2500baseT EEE status/configuration
 support
Message-ID: <aaCFPZ2JYur6hdha@horms.kernel.org>
References: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
 <20260225194848.188081-2-horms@kernel.org>
 <875598e7-5fa1-49b0-be14-181b18ae97fe@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875598e7-5fa1-49b0-be14-181b18ae97fe@birger-koblitz.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EB561AD60C
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:02:17PM +0100, Birger Koblitz wrote:
> Hi Simon,
> 
> Thanks for the thorough analysis!
> 
> On 25/02/2026 8:48 pm, Simon Horman wrote:
> 
> > 
> > > @@ -8922,7 +8924,8 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > > 
> > >   static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
> > >   {
> > > -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> > > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> > > +	u16 speed = rtl8152_get_speed(tp);
> > >   	u16 val;
> > > 
> > >   	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> > 
> > This isn't a bug, but the variable declarations are not in reverse
> > Christmas tree order. Simon Horman's AI review raised this in v1, you
> > acknowledged it and said it would be fixed in v2, but the ordering issue
> > remains. The longest line should come first, followed by shorter lines.
> > Should be:
> > 
> > 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> > 	u16 speed = rtl8152_get_speed(tp);
> > 	u16 val;
> > 
> I do not understand what the AI is complaining about, here. The lines in the
> v2 patch are in exactly the order you requested:
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> +	u16 speed = rtl8152_get_speed(tp);
>  	u16 val;
> gives
> 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> 	u16 speed = rtl8152_get_speed(tp);
>  	u16 val;

Sorry, there was supposed to be some commentary from me included in
my previous email. But somehow it got lost.

I agree the AI is wrong here.

> 
> > (Reference: https://lore.kernel.org/all/20260224170206.146491-3-horms@kernel.org/)
> > 
> > [ ... ]
> > 
> > > @@ -8956,7 +8968,8 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
> > > 
> > >   static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
> > >   {
> > > -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> > > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> > > +	u16 speed = rtl8152_get_speed(tp);
> > >   	u16 val;
> > > 
> > >   	val = ocp_reg_read(tp, OCP_EEE_ABLE);
> > 
> > Same reverse Christmas tree order issue here. The same pattern should be
> > applied as in r8152_get_eee().
> Same argument as above.

Agreed.

> > [ ... ]
> > 
> > > @@ -8968,10 +8981,29 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
> > >   	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
> > >   	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
> > > 
> > > +	if (tp->support_2500full) {
> > > +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
> > > +
> > > +		val = ocp_reg_read(tp, OCP_EEE_ADV2);
> > > +		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
> > > +
> > > +		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
> > > +		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
> > > +
> > > +		if (speed & _2500bps)
> > > +			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
> > > +	}
> > > +
> > >   	eee->eee_enabled = tp->eee_en;
> > > 
> > > -	linkmode_and(common, eee->advertised, eee->lp_advertised);
> > > -	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
> > > +	if (speed & _1000bps)
> > > +		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, common);
> > > +	if (speed & _100bps)
> > > +		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
> > > +
> > > +	linkmode_and(common, common, eee->advertised);
> > > +	linkmode_and(common, common, eee->lp_advertised);
> > > +	eee->eee_active = !linkmode_empty(common);
> > > 
> > >   	return 0;
> > >   }
> > 
> > The eee_active determination logic is now duplicated between
> > r8152_get_eee() and r8153_get_eee(). Both functions convert speed
> > register bits to linkmode bits, AND with advertised and lp_advertised,
> > and test emptiness in the same way. Would it make sense to factor this
> > into a shared helper to reduce maintenance burden?
> This could make sense, but I tried to make this as minimally intrusive as
> possible and was already at a doubt whether I should even fix the RTL8152
> version of get_eee() to correctly depend on the actual, not the desired
> speed. Then I decided for fixing this incorrect behavior and have
> consistency. The style of the existing code has plenty of duplicate code for
> the different chip-versions and is already difficult to follow to this point
> depending on the chip version. Personally, I find the readability improved
> if the few lines of code are repeated instead of separating this out into
> yet another nested function, and readability also helps code maintenance.
> Plus, it is quite likely that these functions further diverge with e.g.
> support for the RTL8157 (5GBit/s).

Understood. I did think this point was worth raising.
And I appreciate your feedback. We can let this one go for now.

> 
> > 
> > > @@ -9512,6 +9544,7 @@ static int rtl_ops_init(struct r8152 *tp)
> > >   	case RTL_VER_11:
> > >   		tp->eee_en		= true;
> > >   		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> > > +		tp->eee_adv2		= MDIO_EEE_2_5GT;
> > >   		fallthrough;
> > >   	case RTL_VER_10:
> > >   		ops->init		= r8156_init;
> > 
> > [ ... ]
> > 
> > > @@ -9537,6 +9570,7 @@ static int rtl_ops_init(struct r8152 *tp)
> > >   	case RTL_VER_15:
> > >   		tp->eee_en		= true;
> > >   		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
> > > +		tp->eee_adv2		= MDIO_EEE_2_5GT;
> > >   		ops->init		= r8156b_init;
> > >   		ops->enable		= rtl8156b_enable;
> > >   		ops->disable		= rtl8153_disable;
> > 
> > Does RTL_VER_15 support 2.5G links? Looking at the code, only RTL_VER_12
> > and RTL_VER_13 set tp->support_2500full before falling through, but
> > RTL_VER_15 does not. With this change, tp->eee_adv2 = MDIO_EEE_2_5GT is
> > set for VER_15.
> VER 15 supports 2.5GBit links. The existing code enabled 2.5GBit EEE
> unconditionally in rtl_eee_enable():
> 	case RTL_VER_10:
> 	case RTL_VER_11:
> 	case RTL_VER_12:
> 	case RTL_VER_13:
> 	case RTL_VER_15:
> 		if (enable) {
> 			r8156_eee_en(tp, true);
> 			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
> 		} else {
> 			r8156_eee_en(tp, false);
> 			ocp_reg_write(tp, OCP_EEE_ADV, 0);
> 		}
> 		break;
> Note that previously r8156_eee_en() did not conditionally enable the 2.5GBit
> advertisement depending on tp->eee_adv2, but always enabled it, also for VER
> 15.

Sorry, I missed that when reviewing the AI generated feedback.

> > When r8156_eee_en() is called for a VER_15 device with EEE enabled:
> > 
> > static void r8156_eee_en(struct r8152 *tp, bool enable)
> > {
> > 	u16 config;
> > 
> > 	config = ocp_reg_read(tp, OCP_EEE_ADV2);
> > 
> > 	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
> > 		config |= MDIO_EEE_2_5GT;
> > 
> > The condition (tp->eee_adv2 & MDIO_EEE_2_5GT) will be true, causing
> > MDIO_EEE_2_5GT to be written into the OCP_EEE_ADV2 hardware register.
> > This would advertise 2.5G EEE capability to the link partner on a device
> > that does not support 2.5Gbit links.
> > 
> > Should the eee_adv2 initialization be moved into the RTL_VER_12/13 block
> > (before the fallthrough), or should RTL_VER_15 be given eee_adv2 = 0 to
> > remain consistent with its lack of support_2500full?
> No, see above.

Ack.

It looks like the AI was all false positives this time.
And I'll mark it accordingly in the system. Thanks for looking over it.

