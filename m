Return-Path: <netdev+bounces-256085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KxfDXxYgWkFFwMAu9opvQ
	(envelope-from <netdev+bounces-256085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:07:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C001ED39EB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6853630265A8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9212F12D9;
	Tue,  3 Feb 2026 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7hI13tb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC992ED84C;
	Tue,  3 Feb 2026 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084292; cv=none; b=jCXFyDcOu4Nx6x3A1IpJgknU80BRKYDw3Yboa+qa2goJQAFSRSsUw4BgUZ/Dwpk9yxMRP1R+o4G4INgxtYscgMsTKP96pbb+fBmjafIP1tAvd/LwcjS3dEU1pSYfgjBYex/UqX1nM3+LtGnPD5+JUffeXsu1/rYFL1ZmuwSlNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084292; c=relaxed/simple;
	bh=GXqI0GKE6mOSs1onlHmKwgT/CaBzON9G+Vp94Jaa/9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLHXegl72mJgYTuQpQOWq9LNlv3K2yVnyEbkQFgC6ZK3GX+jyc8MnKAFBxU+aI8m8sEJ6OpY2MX4aGfC+3g8w4q8Tu3tb4EFLL3i+Wy7utgfZCZq7CQl4UinDOxksq8jwoegt7Hn7OPbPDIr2W7vcskaO8GveBrN0eHJEY17yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7hI13tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F368BC116C6;
	Tue,  3 Feb 2026 02:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084292;
	bh=GXqI0GKE6mOSs1onlHmKwgT/CaBzON9G+Vp94Jaa/9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7hI13tbz7Cc353cnWMOzm9A0Yrnkui5H5Z7ds2qJoiqTlyx19XlE7E5naOOT7tts
	 Rit5WvZG4f+kAYifyFbo7LEJCYGsYCbpAI9lIE8y7dcwHzqHiIz0T42/V54OAGxGEI
	 Pr5Uv9rW+VSoSfoDcVZSUAEnXQaVkXSfhGI+DepPHCCnqNb6hCoVFpM1KGoWn3WLIg
	 r2Zc/w4nzbNf0dnhvoc4SYKH8qbdkRQddLdiCK7rpt18W0Ar/ER8yGHwyplGy97E3l
	 S440DcL4f3oyjJv3UZEAmJ8Pveu7NsvSnQ/to59I0RUUx5VsJbgq7sIC9o9570NsLJ
	 RSU395R5j4jww==
Date: Mon, 2 Feb 2026 18:04:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Satananda
 Burla <sburla@marvell.com>, "Abhijit Ayarekar" <aayarekar@marvell.com>
Subject: Re: [PATCH RESEND net v3 1/3] octeon_ep: disable per ring
 interrupts
Message-ID: <20260202180450.372b216e@kernel.org>
In-Reply-To: <20260130141549.827020-2-vimleshk@marvell.com>
References: <20260130141549.827020-1-vimleshk@marvell.com>
	<20260130141549.827020-2-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256085-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C001ED39EB
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 14:15:45 +0000 Vimlesh Kumar wrote:
> +	for (i = 0; i < num_rings; i++) {
> +		intr_mask |= (BIT_ULL(srn + i));

Please remove all the pointless brackets..

> +		reg_val = octep_read_csr64(oct,
> +					   CN93_SDP_R_IN_INT_LEVELS(srn + i));
> +		reg_val &= (~CN93_INT_ENA_BIT);

.. like this ..

> +		octep_write_csr64(oct,
> +				  CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
> +
> +		reg_val = octep_read_csr64(oct,
> +					   CN93_SDP_R_OUT_INT_LEVELS(srn + i));
> +		reg_val &= (~CN93_INT_ENA_BIT);
> +		octep_write_csr64(oct,
> +				  CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> index ca473502d7a0..42cb199bd085 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
> @@ -386,5 +386,6 @@
>  #define CN93_PEM_BAR4_INDEX            7
>  #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
>  #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
> +#define CN93_INT_ENA_BIT	(BIT_ULL(62))

.. and this.


