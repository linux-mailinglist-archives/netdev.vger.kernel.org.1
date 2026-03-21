Return-Path: <netdev+bounces-270192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHGkANhivmnDOAMAu9opvQ
	(envelope-from <netdev+bounces-270192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:20:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0BD2E45A2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E923019812
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4153033E8;
	Sat, 21 Mar 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhFhsbxD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4227FB25;
	Sat, 21 Mar 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084819; cv=none; b=sORGB6SvylM0o+Ot3LVRw3/7to0D6C6PdplVYFgkP2p4gCIdpLn5MAG1UAvpzoa53hQE/KxvZqAs/vq7njlBGwzatJ5VqS/2ry/CnDnwWDUiv2mIblZTAryKnb6gAyrX22tg37Lrvnco3QGZ/Yk0cC23vRXc57AUQfnZ5dAJXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084819; c=relaxed/simple;
	bh=1suF2noxHcqWslPQuTsIbduyMZBlyXksW1NsLnOwWC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gux4leNy++bBoGUtkEdsze7QTGDKeLKgDusVbyu/Mq2apqXHJO7uuYOf5h6tRQTLYkKzXphb5SfgOZLFkokK3WKl0FClIOctsPHYwaLCr8v3h9xNzIZskqs4PWOc2WHZ+l3PPv9S/ITIqc3ZB84ns0cfFkcdLg31wMFIwWHcpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhFhsbxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192DFC19421;
	Sat, 21 Mar 2026 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084819;
	bh=1suF2noxHcqWslPQuTsIbduyMZBlyXksW1NsLnOwWC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhFhsbxDuIXfv4D2vr/e56u7tY0TRl5+JGbKbULY7ynKGXDruf1ZyzTT04qsEmpnX
	 nUK4r+flSwXNn4yoi+DHFugW+ac/A6dyvStfc3Q5sTVAUCmrPb0moquh2TTfBjGuIU
	 0t9mRVbIauejWw6DZdwkhn/q/yentVmnKYj+qWe1i9OCZ3jEc412fEedEeK7j99oxC
	 GrY0iL6wiKOicc+Qg3U3eeOitG8aCV/xroOaCOybcmY3Rbe39ZsAkPyFUc71sbez6y
	 HXigg6X+A4vRf99ScQQV6lPNh+Mim29rZvatctc8qOuT70F009QTRyz1cvdTIbCakt
	 Cr63Ho7/wFjdw==
Date: Sat, 21 Mar 2026 09:20:14 +0000
From: Simon Horman <horms@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, robh@kernel.org, kuba@kernel.org,
	maxime.chevallier@bootlin.com, pabeni@redhat.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	davem@davemloft.net, hkallweit1@gmail.com
Subject: Re: [PATCH net-next v9 2/4] net: phy: realtek: add RTL8224 pair
 order support
Message-ID: <20260321092014.GV74886@horms.kernel.org>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
 <20260318215502.106528-3-dam.dejean@gmail.com>
 <20260320082156.GX1753385@horms.kernel.org>
 <46FAC4A6-9462-45BC-B17C-B7F5F19F0ADB@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46FAC4A6-9462-45BC-B17C-B7F5F19F0ADB@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270192-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,bootlin.com,redhat.com,vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 9F0BD2E45A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:17:56PM +0100, Damien Dejean wrote:
> 
> > Le 20 mars 2026 à 09:21, Simon Horman <horms@kernel.org> a écrit :
> > 
> > Checkpatch warns that ENOSYS only means 'invalid syscall nr'.
> > 
> > Looking over the implementation of of_property_read_u32() it seems to me
> > that -EINVAL is sufficient to detect that a property is not present. Which
> > may be appropriate here.
> 
> I added the check on -ENOSYS because in v8 Jakub commented [1] on the fact
> that if the kernel is built with CONFIG_OF=n, of_property_read_u32() will
> return ENOSYS. If ENOSYS is not handled there, then the call will return an
> error while it shouldn’t.

Ahh, I see. I missed that in my analysis.
Sorry about that.

> 
> Damien
> 
> [1] https://lkml.org/lkml/2026/3/17/2464

...

