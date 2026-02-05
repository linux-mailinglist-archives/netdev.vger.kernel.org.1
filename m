Return-Path: <netdev+bounces-256919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONk+CkUAhGnYwgMAu9opvQ
	(envelope-from <netdev+bounces-256919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:28:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDDEDF7E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D697E300B451
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37CD29D268;
	Thu,  5 Feb 2026 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaJBaWuL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180F299A82
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258479; cv=none; b=b9IMnUS1K+L8ylFUn24HrQ8GulhtMPfgzmC1PdtUfOQkvYKSpSLjbVdU88Eflgo9JNcA64DpI1o8+tC+LE7sj8lm74tpq8PMldvdqNkPSKbR7kCp75GHKFJdcwth0At8EhFxXeuaGSnifWtulUuBNn3GZG73ssSHvQDWN/0TUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258479; c=relaxed/simple;
	bh=8RQFU63Untu7iD5Aw0yaVzta2YjEmi1wgLKCZeXdKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQSb7vCv+hdL7yHlnkLwdFx7k+hX3O5IyDpQ0N40mIPYykrx26YKNGhfvDdwF/mj37ULJVDdK6JNQvoZct/RG1hyOUD3whnwhI+fG10PU4bfi5a4xfuqRQUBhMR2vCzCCa9DFELmeTH0hbGNDxq7yM0Cjr+NA9Y2wrnPDQAEu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaJBaWuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157C6C4CEF7;
	Thu,  5 Feb 2026 02:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258479;
	bh=8RQFU63Untu7iD5Aw0yaVzta2YjEmi1wgLKCZeXdKM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VaJBaWuLF/Y+VPwQYxB3lGhZMPgtp9hhJADbdIQcSB6TxR7OXntSuLQyDnpJd7h8O
	 jKnCcnInLKu5kE/JK1kOB8CNPiOLWI5dw1mJzyMv7tupuRi59fk8ZghvNZYz/VfU21
	 XzC2UK2kqnuRDu9vPSv494yPIcuQ7QSKOjzrkC9HACVNqgclQQCNAqsADrcl/k8wYS
	 hubbFF0UHIVdud+a0PMCwGknslfrC7AI/VhW7eAknwrnh3cUKdRNxarQu8Ovz6QNvQ
	 NkHXvnhB9rlLALlPs0tiUG6sLJJ89BaxFsw6hRhGNLRiGDfQfe+I1rtfNuGPSJjBuN
	 cbKD7Rr5YNZyQ==
Date: Wed, 4 Feb 2026 18:27:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Nachman <enachman@marvell.com>, Alok Tiwari
 <alok.a.tiwari@oracle.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, "Taras Chornyi [C]"
 <tchornyi@marvell.com>, "Volodymyr Mytnyk [C]" <vmytnyk@marvell.com>,
 Yevhen Orlov <yevhen.orlov@plvision.eu>, "Vadym Kochan [C]"
 <vkochan@marvell.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "alok.a.tiwarilinux@gmail.com"
 <alok.a.tiwarilinux@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next] net: marvell: prestera: fix FEC
 error message for SFP ports
Message-ID: <20260204182758.7ba3fd43@kernel.org>
In-Reply-To: <BL1PR18MB4248EFE8E7D182A5601927E1DB98A@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20260202052816.28191-1-alok.a.tiwari@oracle.com>
	<795c3351-d65b-4a9a-83dc-b530177b9d28@gmail.com>
	<20260203191517.024dab80@kernel.org>
	<BL1PR18MB4248EFE8E7D182A5601927E1DB98A@BL1PR18MB4248.namprd18.prod.outlook.com>
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
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,plvision.eu,redhat.com,google.com,davemloft.net,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256919-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75BDDEDF7E
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 13:13:31 +0000 Elad Nachman wrote:
> > > I'm pretty sure that the condition here is wrong, not the error message.
> > >
> > > AFAIK it doesn't make sense to configure FEC on ethernet/copper ports,
> > > but for SFP ports, it may be required depending on the transceiver or
> > > cable used, especially for fiber modules.
> > >
> > > I may be wrong though.
> > >
> > > This check was introduced with bb5dbf2cc64d ("net: marvell: prestera:
> > > add firmware v4.0 support"), but that commit does not offer any
> > > explanation for it in the commit message.  
> > 
> > Elad, could you clarify this? A bit hard to tell whether CR is included
> > in "SFP" from glancing at the code.  
> 
> Basically, the supported devices have FEC on 10G-BASE-KR and upwards
> (CR: from 40G-BASE-CR), and for USXGMII SERDES, which drives multiple
> copper PHYs.
> 
> Judging based on all of the above,
> I think it is best to remove this check (plus said error message)
> altogether and let the firmware return an error if the mode/speed/FEC
> combination is invalid.

SG, thanks for explaining

Alok, pls respin as suggested.
-- 
pw-bot: cr

