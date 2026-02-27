Return-Path: <netdev+bounces-261647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPPAJMLroGkpoAQAu9opvQ
	(envelope-from <netdev+bounces-261647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:56:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E31B15A3
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCE93023063
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7728428C5B1;
	Fri, 27 Feb 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXO+7qK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471026CE32
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153791; cv=none; b=EVHvwAWRKAIF3D4TQ8j7BvL51xg6zDyQ5Z3m+GWCQ3imBitkOtIgB0OYU3PBXipOVA6AfbkE4lkQH1D54AtjVeRytNLomAzhk3iOD5Wp2+QvwmDk9VfUGH4NVc7nRuGWV5A9NQpvYtkhSufC3f16OIDZU/rtISJCn96N2SD13qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153791; c=relaxed/simple;
	bh=GMft4ayMMjoLbSVsL8eBkL6F21s1DTIGhoHvngOhGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW/Jgc9m3JaKiqsz1lXimjVsUHUfe/hc3uOKfm6TnCJTMV03fXNF20IxcNWBm+hcnBxGrsTSHOUsNfqKB9s0y/wfoJG3bxQHQ/zlHruszHVGtD5n13yoHOyAddTtoZOb0icZDJGe563O36A2VhepUtXHLRdbJWv34qzDxXbQjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXO+7qK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9609AC116C6;
	Fri, 27 Feb 2026 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772153791;
	bh=GMft4ayMMjoLbSVsL8eBkL6F21s1DTIGhoHvngOhGBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RXO+7qK4A+Mjlm3Lc0EA3BFEp+7UrE/Xmkmz98t7xmlw/jaogFIqip8HF7tkgo5qL
	 xYBVHaCvddSf2Bpd4kx+j4UvWBMW9K//Clw4moh2PWZYNb9iEAM2Sd03Zj/hg3lU+/
	 o8I4UV5fOH2s/u+r04pqdsTJXvZguwXLTOiOdHgOMBZ9+TIvsEsPpM19WzcDL35CNS
	 R1wu8z/7x2/4k+UsGqRWtNG339UUGJe5O4e26EZlaM7Sw1veLElE1PJrUX+blWB7U6
	 yhiihijCAGplVu/zFJGkhjaQlM8NhmIHmgnD7VNWWwoZMDC4XK2spIkX6rBK1Iz77a
	 yK4P7Znkhohpw==
Date: Thu, 26 Feb 2026 16:56:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc
 warnings
Message-ID: <20260226165629.377fd10d@kernel.org>
In-Reply-To: <20260226221054.1041044-1-rdunlap@infradead.org>
References: <20260226221054.1041044-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261647-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D1E31B15A3
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 14:10:54 -0800 Randy Dunlap wrote:
> +	/* private: */
>  	OVS_DP_ATTR_UNSPEC,
> +	/* public: */

Hm, can't quickly grep the relevant guidance but I always thought that
the comment is supposed to pretend to be a label. IOW not be indented:

 enum ovs_datapath_attr {
 /* private: */
 	OVS_DP_ATTR_UNSPEC,
 /* public: */
 	OVS_DP_ATTR_NAME,		/* name of dp_ifindex netdev */

I find that easier to read, but no strong preference.

