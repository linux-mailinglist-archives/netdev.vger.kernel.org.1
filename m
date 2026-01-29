Return-Path: <netdev+bounces-254588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM0JI978emlyAQIAu9opvQ
	(envelope-from <netdev+bounces-254588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:23:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD619AC327
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144A73014645
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CEC2D838B;
	Thu, 29 Jan 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="V72g7+a1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RW14kBYW"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34821E5B70
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667793; cv=none; b=s+QIL5MmAJUiE+OPh7vLw511d/Q49msTbIacfrni85oLuoiAmG0hGoz+7oAZMsB9BIoGCgRwBfPYhuFC/JUAFn66o0oVbV7unFp50l/hmKw4g2yeZohyaQ6Vm6TVHR0xLl78cKrTFkYdbaICo2iUmenylaMH/Mas9ujDgFajye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667793; c=relaxed/simple;
	bh=jGRDlhnLKiKWISQYI3HWc1ekleuZ/SACR4r4HbKje2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT8r4+k/6Yt6mUGaMpRiITSvuMOlsR8IAP/IaLREqSQHlydfI3K3dKfDvIB298/jCltSyarLTSP1QCCDUbC7DZ5/w/4u8+r33IvVwAT9Cd0ssxlM82rLW5R02YBK/s57L0NKnUOmJxs7Ig9PDbHvOu1E7r55SSIHA0cHm3QbtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=fail (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=V72g7+a1 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RW14kBYW reason="signature verification failed"; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=V72g7+a1Irk+SPMz3/gLuhUpCCATvJBOSVPpy+52kfUIO1xvQPOnt3RMVj9deSv0oZRm/+uJLfX7qo4ljKOjjx5Fdg9PWQvkaY+YqQ7d3uLhBmZP+/CG5Num1k4W/VY3jtnCkPEmwW9R1Z3fQFozwdb+/epPmN2Xu7YdrV1U2B693e5rTsNgrkIatZfY5htIMB08FDG7Px2BT/tFdKimBTRHXvPo03Pc9zluz+h7HPBE4MACwI+UkkPek2qaGxgp6y3D1qzbgnfUrxsXRf0gVQSwwaVKTFWIl11takInJhP/xKiRLNtBh+WCE/EjtbIsB9O8NESGzQ0R3p/Wiqrtzg==; s=purelymail2; d=tinyisr.com; v=1; bh=jGRDlhnLKiKWISQYI3HWc1ekleuZ/SACR4r4HbKje2o=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=RW14kBYWP4AEltBmvYX5wpw2QkAZukXPNUDAt7BE/eDbc0DKrnhA/VkywGK3683FL5aNyp60BgC+iN4BcSZz0X3IGFgy485pzVaTEClScqCTRldwRd0QU+k1eGcUavvZkquYN4uBVRKU0NDBc0dFUUK3r4w0y89F8T9UW8UWp0tm2XxkViLDXXiCg9OZPMvhC4y+RITUdMA9dQ5uF11U+hzx6y3AV5X4Pd8++vSIfyNAN/OlCVty5CogBQGSmIU7wQA3O0AdNcmZAipBLURVCnrrsStV8v/+usq7ow2C6HEsZGnDvmVOkH1PRbxi0nnPFu3LJ8swvLw1PbJQaW7AoA==; s=purelymail2; d=purelymail.com; v=1; bh=jGRDlhnLKiKWISQYI3HWc1ekleuZ/SACR4r4HbKje2o=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -901277609;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 29 Jan 2026 06:22:53 +0000 (UTC)
Date: Thu, 29 Jan 2026 08:22:40 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com, 
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: avoid writing to
 ESW registers on MT7628
Message-ID: <aXrvPyNSkNSFTjR7@plutus>
References: <20260122191822.1476732-1-joey@tinyisr.com>
 <20260125133606.1257ff61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125133606.1257ff61@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[tinyisr.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254588-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tinyisr.com:-,purelymail.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD619AC327
X-Rspamd-Action: no action

> > +static void rt5350_mac_config(struct phylink_config *config, unsigned int mode,
> > +				const struct phylink_link_state *state)
> > +{
> > +}
> > +
> > +static void rt5350_mac_link_down(struct phylink_config *config, unsigned int mode,
> > +				phy_interface_t interface)
> > +{
> > +}
> > +
> > +static void rt5350_mac_link_up(struct phylink_config *config,
> > +			    struct phy_device *phy,
> > +			    unsigned int mode, phy_interface_t interface,
> > +			    int speed, int duplex, bool tx_pause, bool rx_pause)
> > +{
> > +}
> 
> Is there any other driver that implements fixed link with phylink this
> way? I know regrettably little about phylink. I'd think that mac up/down
> usually would still do _something_.
> 

`net/dsa/port.c` stubs are the only other place with no-op phylink mac
ops.

On MT7628, the existing `mtk_gdm_mac_link_up()` does not actually
commit any configuration to the MAC hardware. The only potentially
observable change is `mac->speed = speed`, however leaving that as
`UNKNOWN_SPEED` appears more accurate for this SoC, though I will
recheck for side-effects of that.

`mtk_mac_link_down()` also does not touch any valid MAC registers. Both
of these functions are already effectively no-ops in terms of MAC
configuration on this SoC. They only clobber unrelated ESW registers.

While the ESW block seems to provide a way to control the CPU port speed
and link state, this is a separate IP and I don't think it's appropriate
to have the MAC driver program it.

While I'm not very familiar with phylink either, this is no different
from how the original driver handles link up/down on this SoC.

