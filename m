Return-Path: <netdev+bounces-302276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9USMDaP8PmrvNwkAu9opvQ
	(envelope-from <netdev+bounces-302276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:26:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5C6D06D6
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:26:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iEDiDreC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BDF13013BBE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA203C09F4;
	Fri, 26 Jun 2026 22:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E43AFD01
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 22:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512799; cv=none; b=G9QsBR6rghv8IVWkVWXhiojVWCcMlkQJpSS9MTqjlZzaLKMfXYf2ozj0npWSK24GJILTcI11mVBELaT8JPZ/dcYCrpv+Kn8YHv4AdQwcjVk44TrY+vDlX039X1JMtuT/FGiev0blIqbTHoLDRizEIAFAzipUrVvcrH7yJ4kNjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512799; c=relaxed/simple;
	bh=CWCqQUnxD0a0B4Bx8Z/YDCg6rx7K/g76ORzf3S1qgp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caAcI78Oeid4UCnqIl8QhVxwP2lo9YhWXiUrQOb8Pd/oUW987slxwRbjOKEaJdApazhnjAfG56vTpIGJeh30xetATb9kFMPhP+P0hckFM4HTb9Stl9xcv8ctUlcqns3M8XLAdQrnp+aiYjk0iX4ncYMGPsPgNW3CHsP+ubkho9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEDiDreC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CED1F000E9;
	Fri, 26 Jun 2026 22:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782512797;
	bh=QHQe461p4IkD5U+veVeVXVjqS7KLHZKNF4AB25rlJAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iEDiDreC+JwYdSWT5JQyhazkoQEli4wbfGan4SzJiGK33qqLdADgFQFSLHBX886Kl
	 R+Co/QJaQiDovSEx832olVkq7acq0rgTvwMtXpejKa9Grc2qn883nR2rIoJ7650S/3
	 880WsP0CBiiWGWZBi9YrKV/up91Pk3MCvXcl30I163LhNPykD/qtzox6mRlRJvwn3T
	 0L8HOxcMgrPsvu6w8AKvAuRHopQuU3rqdwBVNLCNSmM04BDdIPLxNns3447PyCWfpP
	 nhLV3e+7YrYGuwNCXGowR2RKrFBEiDMwj1ve2WttaGLyOlSvtVPOZ93i4KH9Pk1L+1
	 N7yOjs2J/PDdQ==
Date: Fri, 26 Jun 2026 15:26:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
 configuration
Message-ID: <20260626152636.1e48330f@kernel.org>
In-Reply-To: <20260626054730.1126969-3-aleksandr.loktionov@intel.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
	<20260626054730.1126969-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302276-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,ntuple.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0E5C6D06D6

On Fri, 26 Jun 2026 07:47:30 +0200 Aleksandr Loktionov wrote:
> -	/* Update the VSI's hash function */
> -	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> -		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> +	/* Handle RSS symmetric hash transformation */
> +	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE) {
> +		u8 new_hfunc;

I think this is the very bad part. Please extract it out and send it as
a fix to net. Looks like any changes to RSS confing on ice randomly
enable xfrm sym. I isolated it to the ntuple.py test which just changes
the indir table, and the driver says:

  ice 0000:e1:00.0 ens1f0np0: Hash function set to: Symmetric Toeplitz

Which we never asked for. I drafted this before seeing your reply:

--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3692,10 +3692,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
             struct netlink_ext_ack *extack)
 {
        struct ice_netdev_priv *np = netdev_priv(netdev);
-       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
        struct ice_vsi *vsi = np->vsi;
        struct ice_pf *pf = vsi->back;
        struct device *dev;
+       u8 hfunc;
        int err;
 
        dev = ice_pf_to_dev(pf);
@@ -3714,9 +3714,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
                return -EOPNOTSUPP;
        }
 
-       /* Update the VSI's hash function */
-       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+               hfunc = vsi->rss_hfunc;
+       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
                hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+       else /* input_xfrm == 0; core rejects any other value */
+               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 
        err = ice_set_rss_hfunc(vsi, hfunc);

