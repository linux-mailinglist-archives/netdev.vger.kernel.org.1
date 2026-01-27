Return-Path: <netdev+bounces-253971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIZVIYv/eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C398D04
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B899300F16B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE33254B1;
	Tue, 27 Jan 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqN2tpCr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83432549A;
	Tue, 27 Jan 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537413; cv=none; b=jOjAWWqPGty19HpMz+UHCWliKwzr/h8Ryd0rqTg8HcbghkOHMmv1gsfIPUj/xAFSrPPoPhA6TauNjhxkAfxkp6wYVP3WLZHXHYp1fqdhVlPcOJRuaQkwnBRIpWxsZvV9tBaFTBSm4LhJ5M44/Gk/EjtovQ1HB5T2KywK166sK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537413; c=relaxed/simple;
	bh=uaGy/PMXILp04xeHbp2/bIsnxLo/m86eQ5dk0yuruaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH9yVr9rJ7CLWIxOY0XjTJOoVvRt83M74z4OT4lgGXo+9DM4BQdkai8/vlvoH3PtWm91+nEzBjVEonJf+iKbcQNHnfMW/PdkgdHiWu7QAKtqjDd8q3fTIUXu4ddotd6/TN2tqiE/ESDXWlfVpNbImAWZZ/hxFIdTTI9bvm7gtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqN2tpCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1FAC19422;
	Tue, 27 Jan 2026 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769537413;
	bh=uaGy/PMXILp04xeHbp2/bIsnxLo/m86eQ5dk0yuruaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqN2tpCrRB7XzHsOrDw5936/VpiLiTYpglqpS+194Efei7mmGSbkE79h3t5LBzXlq
	 oSDSStPQypwJu8pupQOR0HhwlvJcaC5IV4NE7n+7QGRMfekYE6MsCxtNizoBYy2rZo
	 NbvFlBajLO1sCk5DQaSuJqNLi67lpmgI2RDKQn7EpUTPmh02dEwzR3tbhE1bDZlwRm
	 4SVPAJ7b4BHqWWAewLRAEasIA3/+M591zl0tGDjbMyaEa2iyoejP9bWvtQfLK2pa7V
	 xWibo6IQ9u/X4Efhy7Q91tjSZ+/56IE7+xqECP3VZyqMOKhdZyEwKq/MffBV1RTYD6
	 Z+JpJf66Tosww==
Date: Tue, 27 Jan 2026 18:10:07 +0000
From: Simon Horman <horms@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
	hawk@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	sdf@fomichev.me, daniel@iogearbox.net, john.fastabend@gmail.com,
	edumazet@google.com, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 01/15] net/nebula-matrix: add minimum nbl
 build framework
Message-ID: <aXj_f3hsMmvKxC26@horms.kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123011804.31263-2-illusion.wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F36C398D04
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:17:38AM +0800, illusion.wang wrote:

...

> diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
> new file mode 100644
> index 000000000000..c763042ce3ee
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================================================
> +Linux Base Driver for Nebula-matrix M18100-NIC family
> +============================================================
> +

This file should be added to Documentation/networking/device_drivers/ethernet/index.rst

Flagged by make htmldocs

...

