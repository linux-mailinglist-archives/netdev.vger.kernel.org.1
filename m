Return-Path: <netdev+bounces-273388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP0CHBkNy2msDQYAu9opvQ
	(envelope-from <netdev+bounces-273388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF953362755
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7FE3018BDD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8D3BBA19;
	Mon, 30 Mar 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG8IGrcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE2378817;
	Mon, 30 Mar 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914838; cv=none; b=ITcp69B6eHrVp/DPzWvOtBNqbbL5SOxomQuPq3m+DNzs2i2KUfdD5whVTNKEykQdz0zm/YYiJugrcFIyip5t2NNcg552zkr78EbhSQNcBKG86b1ndldjFKItSn2jDfrUzBjMHh/Ado/8wQRr0feJTbaGKzF0W14HCMbp0NCMBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914838; c=relaxed/simple;
	bh=umL7+fBsNn2C9eT3rPF5u4PnqF6KuGdcmbfkKPPHtqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6xx1ZIGorwXdv/BujyIPoEFXw64TajiJspo00DIAnPmhd+1lFJ8abM9YOVeZGR0bkyahuJDvUwDwBzSHroUGtpDZ2R2GMG2niicuHGczZCUjzx+xyY4t/M7Lxqj1p6mVdEPh9OWpNFcj/gSnVMI5q2Q+t1yhy0Xw02Y+Ps1J7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG8IGrcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35CEC4CEF7;
	Mon, 30 Mar 2026 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774914838;
	bh=umL7+fBsNn2C9eT3rPF5u4PnqF6KuGdcmbfkKPPHtqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZG8IGrcRJX3lzT7AKO1mBMyr+ah8h7Y/MPR07yensSX/BatK2WbTdPwJCXfgDNbSY
	 EcF1GKNFRH2YqzvAlfsCzCUXaReDT6x2td9gW8dG2lbz9XGQjo9LnVR4WnYx1L3qCa
	 gto2Xd5RHSLasMU7ChXBEmhEQc2+s2GI/hxszGxQ7RAkS882wbtLcezuuk4I6+fHba
	 XMJRxN7UoA9VCF0WDG48/kyKVnn8QbsSBJeNDj23QjtbFhHUm+cLRgTQDeIuVjSXX5
	 IG/Q2fqgO2iidngHYzvpGMy2XmKnWcTags1XpWh5JXsMVxtE80dea2H325khswsjZo
	 TMg40VmFV4K7g==
Date: Mon, 30 Mar 2026 16:53:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 08/12] net: bnxt: Implement software USO
Message-ID: <20260330165357.31a30b68@kernel.org>
In-Reply-To: <acqqjfzDK04j2APz@devvm20253.cco0.facebook.com>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-9-joe@dama.to>
	<20260329152016.27646fab@kernel.org>
	<acqqjfzDK04j2APz@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273388-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF953362755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 09:53:33 -0700 Joe Damato wrote:
> > > +				   bp->tx_wake_thresh);  
> > 
> > Is tx_wake_thresh larger than the max USO even for smallest ring size?  
> 
> Yes, it is.
> 
> Maybe its worth adding a comment in the code somewhere to make
> this more clear? Not sure where would be an appropriate place, but maybe
> bnxt_init_tx_rings?

Hm, as long as BNXT_MIN_TX_DESC_CNT is updated I don't think we need
any bespoke comments 

