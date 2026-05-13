Return-Path: <netdev+bounces-287386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B1rAIDWA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C852C05D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74FE930054D7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA253655CC;
	Wed, 13 May 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx0Mi+nN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23733E35C;
	Wed, 13 May 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636399; cv=none; b=G5OelfTO+mCfU0t0xY4KGVi29ZEY7HE5UFAXGBpPR+Fux8rAMnrzo+1qYthAB4HzBsGr9utlPgxJ9Aies7/yhgLvKrCtjNV16TfWfrTEp/rZTPpo5Dh8jk2q6wRsQb+se5SUmEfYm7EW052FzQYkuLAcZ2OdxN25loBFSo5YNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636399; c=relaxed/simple;
	bh=Om/nu+DudSaWnEOS/4Y5hn2Fyi83VVOB54iRa7yKpEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twr6W3uQ5nIuVMLUOZkxFBcJa79ifBz6JSzhCdb4jLXdF5b4uFbHK9SPDtuIUJ6dOMCvbJm8XUpPvx3ZiGiy4ozFploUKkiSfmsYDOOYxTw81xEqypioLSqqYQ6cwZOV2Vki4AjRTQx5J+q1GZJY0myZK0TthjU44tzNjqHxmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx0Mi+nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C24FC2BCB0;
	Wed, 13 May 2026 01:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636398;
	bh=Om/nu+DudSaWnEOS/4Y5hn2Fyi83VVOB54iRa7yKpEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tx0Mi+nNp+G1WWEs69Id7fqnfC4ry0aHFUsUg6an4Oj9qZOsATBvTXDMFxlZW6MPE
	 Vc/cqghJp+ewDHtLVOJIsRhmeZ+wNNoSgx7P+SHKuy4U7vSLaDOo+cWFHU2ZHOznjb
	 gdmkQLKZmB9swvV4A8oFQ6v2dcKPo1SZNNnxl1pBn50NYg9FwMiQFP2Y14mu0z2K7K
	 uOXz7tbQgcMUBdf4/JTH+/XrpFdDA+NQ7XxumnUmYnvkJtBSyHzjn8XQBg9t9YcdT7
	 qnDuwnNRVHiki3rky02bGadPdqULpj4K9e/lAQGtXPKUKAPEaBK0nHqtFCyG/PxIx+
	 O+/NFiOrJ0QEw==
Date: Tue, 12 May 2026 18:39:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minghuan Lian <minghuan.lian@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH net-next 0/4] net: dsa: Add NXP i.MX RT1180 NETC switch
 support
Message-ID: <20260512183957.0f56158b@kernel.org>
In-Reply-To: <20260509090632.2959553-1-minghuan.lian@nxp.com>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 944C852C05D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-287386-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,i.mx:url]
X-Rspamd-Action: no action

On Sat,  9 May 2026 18:06:28 +0900 Minghuan Lian wrote:
> This series adds DSA support for the NXP i.MX RT1180 NETC Ethernet
> switch using the Heterogeneous Multi-SoC (HMS) architecture.
> 
> In HMS systems, the i.MX RT1180 MCU runs firmware that manages the
> NETC switch hardware, while a host SoC (e.g. i.MX93/i.MX94) runs
> Linux and exposes the switch ports through DSA. The host communicates
> with the RT1180 over SPI to configure the switch and exchange control
> traffic.
> 
> The series includes:
> - DT binding for the switch
> - HMS tag protocol using tag_8021q for data and meta frames for control
> - DSA driver with SPI transport, phylink, FDB, VLAN and bridge support
> - ethtool statistics support

Lots of basic issues in these patches. Please get them reviewed by
someone within NXP with upstream (netdev) experience before posting v2.

There's also a build warning:

drivers/net/dsa/hms/hms_main.c:900:23: warning: symbol 'hms_info' was not declared. Should it be static?
-- 
pw-bot: cr

