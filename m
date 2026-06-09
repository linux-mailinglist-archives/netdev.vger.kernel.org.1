Return-Path: <netdev+bounces-297193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CASbIsdNKGqSBwMAu9opvQ
	(envelope-from <netdev+bounces-297193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934F662F88
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=f80mV7Zz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297193-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F64C300F443
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F44C956B;
	Tue,  9 Jun 2026 17:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78674C9018;
	Tue,  9 Jun 2026 17:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026244; cv=none; b=aynNKNVwi54uQduFS7DspHfax8EkRQYiAX2XNAut6r3++g5NW+gZ5bvgGq486EquHo2pD95PCzkLs3gui7RvfN/0n+EkxtGZkWQYoEj/tdwc0HoEMxjGvpOsQvfaUEflUM8cjQS3Nbjn4bFwX1HhcVLWcxGzXR4JcZn++33stV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026244; c=relaxed/simple;
	bh=lsNI5t4DFupB4uZ3G+IlWIsw4OAkLvSUnELsVp8rGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sS7QoLMbLokelUHkW6vezdXmdXxby4FY8diHqrhLgNPTkVALEE3BRUd7GZfw2Sfj/x3XrINTeLpaSZGhMxi2Be+VMfaXG8QHCMFj9RPgZqdKZdIU/NLUTp3J6uR6/5/pUXoC9oto5KMa3KiWNm58D1DpIx5d+Xjk1HsqD5SRYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=f80mV7Zz; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+QzueJHs7ptBOVfOjfdGM1g5GBDEPjK/ze1Pz2lJifA=; b=f80mV7Zzsew9zKMqKxBya7xb1z
	/uVGEe4qW9zwpw/3GgRvuub1VI8M56RxvhrkkQCyh/iZrX+QoG5bRGdI+LXdp/XeIwEUSLCMm+aI+
	WMLO6Hin0WOw6/LVVZg0oDBPV3sED9ibymfGoGeF4l1ZxrpdHfzkJO9lEkjgZEjOpIIlrCAgPrzYl
	A7R0eN2bOYIETH59CVNkrMPXB76yxiNpLbakcnkp7oHpOZF5WIEYAiQVGti5kfwYnN40BYSZvz9XM
	dNUYSDqQtnOZdsZfMpuRXBRQpB6DRxrN5isGG0oN6fNyO1zCgg25YhNCYyjHX6qYs+oZAquBXu7W1
	XXRjNvmg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wX0HW-008Z1w-2E;
	Tue, 09 Jun 2026 17:30:30 +0000
Date: Tue, 9 Jun 2026 10:30:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH net-next v8 01/10] enic: verify firmware supports V2
 SR-IOV at probe time
Message-ID: <aihNYOiYUc3p1Y6_@gmail.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
 <20260609-enic-sriov-v2-admin-channel-v2-v8-1-8ad8babbb826@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-1-8ad8babbb826@cisco.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:satishkh@cisco.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cisco.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2934F662F88

On Tue, Jun 09, 2026 at 09:32:27AM -0700, Satish Kharat wrote:
> During PF probe, query the firmware get-supported-feature interface
> to verify that the running firmware supports V2 SR-IOV. Firmware
> version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
> CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
> feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
> admin knows a firmware upgrade is needed.
> 
> VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
> firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
> a comment rather than a placeholder enum entry, since PTP is not
> used by the upstream driver.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c   | 21 ++++++++++++++++++++-
>  drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index e7125b818087..53d68272d06a 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
>  static void enic_sriov_detect_vf_type(struct enic *enic)
>  {
>  	struct pci_dev *pdev = enic->pdev;
> -	int pos;
> +	u64 supported_versions, a1 = 0;
>  	u16 vf_dev_id;
> +	int pos;
> +	int err;
>  
>  	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
>  		return;
> @@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
>  		enic->vf_type = ENIC_VF_TYPE_NONE;
>  		break;
>  	}
> +
> +	if (enic->vf_type != ENIC_VF_TYPE_V2)

Can we get here with SR-IOV enabled? Then we want to disable it on
failure.

