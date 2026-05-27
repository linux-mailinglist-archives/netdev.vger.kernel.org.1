Return-Path: <netdev+bounces-292375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNdeGdMbF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:29:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5675E7C3D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C9530160F6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A642EEB6;
	Wed, 27 May 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1gEPvDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95842EED9;
	Wed, 27 May 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899340; cv=none; b=J1ThBsoD5n06/JgnzI3blXrgIzlkkRyQa2nvZr+CxKRObQEQ3/NvKqg2UpA3IAwx0YwZ9RvTAW79LG2JQ/Baw0eZjCXzIWkHcvR8l7A4pzGRiuQ6hX1kDR3DloXfzmOZG6sUAgdF8MbPeZ/lZdphDROBX4OPupYJgYL/JJZjidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899340; c=relaxed/simple;
	bh=j6Qi8RJirgt6HV90UspX/padkb98DsmtXE9Yl4eElY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh8WMzf2oHJvgXPLGB3KdsiisQ72xizfW6+Jn+UFrtqWNZMML5kul8XhrtTOujptw36jUbTHj4FFdBXmrJnTcwfUfZmxG93WZi+q874rqwmzuwN50lRHA9p8XGw+w9Qxmg7Phnp4nZQ62pjYOD07V1CDqOgRCno7Y5Y4ZaYxqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1gEPvDa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87981F000E9;
	Wed, 27 May 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779899332;
	bh=PNpYzInmKsvKeoIGvFdlPsMH8iJ4KB96xES+eyOmuy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y1gEPvDaPsgxSqj07YccbrM3D7EQ9pb9VD8l7tTtDMhRM5H4pI/TE10CqQVYtAR9K
	 Aiqsz779DFlSCyFOm6VXkZX/aLqddqK0jnSt5HrTVg42v3+Hm2zcnx9eFWLVqH9hw5
	 tHhrCLAoau6+NNFMERiAGRMQ7XdKXdqaIqV1S3bXbAoaRDuFInsPAVVltq1U6/RP/z
	 kPBvb4A735+t7INyUzwvNqs1Ce0wPKZggjWRuROF4ifjgh/VcW1zAZFUK0YmoLswYV
	 MgsZGRWqOB0d5pTq1FS2N6l9UqH1ovOPljofL1u6ut4A/yokL+ccld7JsHEGoQEQ3L
	 ecNhuNu2CP3TQ==
Date: Wed, 27 May 2026 09:28:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v06 3/6] hinic3: Add ethtool coalesce ops
Message-ID: <20260527092850.0c30c375@kernel.org>
In-Reply-To: <4bead457b595de335c10878bc09af9b86cea65d0.1779867397.git.zhuyikai1@h-partners.com>
References: <cover.1779867397.git.zhuyikai1@h-partners.com>
	<4bead457b595de335c10878bc09af9b86cea65d0.1779867397.git.zhuyikai1@h-partners.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[h-partners.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,nxp.com,gmail.com,huawei.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,h-partners.com:email]
X-Rspamd-Queue-Id: 2A5675E7C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 15:55:58 +0800 Fan Gong wrote:
>   Implement following ethtool callback function:
> .get_coalesce
> .set_coalesce
> 
>   These callbacks allow users to utilize ethtool for detailed
> RX coalesce configuration and monitoring.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

The NIPA CI coccicheck test is failing on the hinic3 ethtool series
(coalesce ops and/or rss ops patches).  Four new Coccinelle warnings
were introduced in drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c:

  hinic3_ethtool.c:1021:11-45: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD
  hinic3_ethtool.c:1055:12-37: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD
  hinic3_ethtool.c:1078:11-62: WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD
  hinic3_ethtool.c:1215:29-58: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

The NL_SET_ERR_MSG_MOD() and NL_SET_ERR_MSG_FMT_MOD() macros must not
be given a message string that ends with '\n'.  The netlink error-message
infrastructure handles message termination itself; a trailing newline
results in malformed extack messages visible to user space.

Please remove the trailing '\n' from all four call sites, e.g.:

  - NL_SET_ERR_MSG_FMT_MOD(extack, "some message\n");
  + NL_SET_ERR_MSG_FMT_MOD(extack, "some message");

The same rule applies to NL_SET_ERR_MSG_MOD() and the other
NL_SET_ERR_MSG* family of macros throughout the driver.

