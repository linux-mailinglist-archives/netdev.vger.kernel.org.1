Return-Path: <netdev+bounces-298746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CpYSGj89LGrGOAQAu9opvQ
	(envelope-from <netdev+bounces-298746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA567B37F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:09:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SxqB5cRL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298746-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E8213004D14
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226C404882;
	Fri, 12 Jun 2026 17:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90B403B16
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:09:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284145; cv=none; b=Jb41xDTdzRAjJavxBwg9zouku2SsDxDcI3DSihvD1Eco2+ZD4+H37D1Yu3r6p3KrnOb89WhYzj/JZ9o/94ItxDlIONbifQn+ejoBjW2z8W4mURwVCoqJegRQmVMI+hOLqwa8xSoVHoxdCrUBkMTjwT+KqaTX4pUoHOnp/JH7WLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284145; c=relaxed/simple;
	bh=m13FKH8QLbpEQyWJDYDcEI2m1m7u61lt3xKVuTPNHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khvj5BXIGCXRHfp+KHdWHd2DxLxC9OCJPEFGvPpyYSvAmy0iXsnMDLgb0mB/W3fkwb0elF7w+cOBEE8kbaXP6h3Mqie3fFUdHZx8DX9IraFaDq9SPMgVFnbk+SiSzGzZ3cEqUXckw3uGjZFwBuYhgMrh02cG8A8EuIc/zqTyTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxqB5cRL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA65B1F000E9;
	Fri, 12 Jun 2026 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781284143;
	bh=mXHehhzB4/pCnHpMmxg30pmzTBOAo5i3f5cizkPGk2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SxqB5cRLYHsqodxhM9r7MVPqGGUkg8EdMYMdy0jHQD4jV+AghgDrxcTTdSVwQ224r
	 tMS4MA/AWJGsoCyBKQzKMmbFCphPn5fjtKCtDltoxEvHkiYhUQRmLJD5ytS1RdPGM3
	 pir0p7p4yJNBq4navfhhaVRBzN/albmg9vUDMwSo+E++g9pnetCjyhZDTcdUlXrlSl
	 tUjV0Z8p126g/HpkqZGVd0ZOvnQqtwykxsuWt31xqJXqLmYAFuInOVKsIbF/GCOuu8
	 ry1cSeQlscHRaaI08xZcK3vTJymSJpNmAhc4pB+GtepcZyjstIqDLeIPeQldU+tIxb
	 Gls0cCBKkryzQ==
Date: Fri, 12 Jun 2026 18:08:59 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next] net: airoha: better handle MIBs for GDM ports
 with multiple devs attached
Message-ID: <20260612170859.GJ671640@horms.kernel.org>
References: <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-airoha-eth-multi-serdes-stats-v1-1-42442ae42064@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:ansuelsmth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58FA567B37F

On Thu, Jun 11, 2026 at 12:43:00PM +0200, Lorenzo Bianconi wrote:
> In the context of a GDM port that can have multiple net_devices attached
> (GDM3 and GDM4), the HW counters (MIBs) are global for the GDM port.
> This cause duplicated stats reported to the kernel for the related
> net_device.
> The SoC supports a split MIB feature where each counter is tracked based
> on the relevant HW channel (NBQ) to account for this scenario and
> provide a way to select the related counter on accessing the MIB
> registers.
> Enable this feature for GDM3 and GDM4 and configure the relevant HW
> channel before updating the HW stats to report correct HW counter to the
> kernel for the related interface.
> Move the stats struct from port to dev since HW counter are now specific
> to the network device instead of the GDM port. Refactor
> airoha_update_hw_stats() to take airoha_eth and airoha_gdm_port
> parameters since the function operates on the entire port.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


