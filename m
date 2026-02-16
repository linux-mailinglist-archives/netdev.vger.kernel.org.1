Return-Path: <netdev+bounces-258870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIUyBc0Uk2nD1QEAu9opvQ
	(envelope-from <netdev+bounces-258870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:59:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67436143821
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021D43005D2A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854B285CB9;
	Mon, 16 Feb 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdBAn+GZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6C21FF47
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246794; cv=none; b=bcOVumfSHdPTgw720tnjNkZZcPpvDB1BW2uEihCGX0TOSY2usFNBDa8LgYY8ZMhh7tlEUPSx8hrgbvbdyeFpQRsx40UhAJa/fGyOh5ufSAX3ZROip1xgCvl7Rkn/FpFR8o2PLI7HCtdhGDJO3yoLJv3sG0ILYaYJt7r66aqT8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246794; c=relaxed/simple;
	bh=XTSXpUaNT8kV0Iio9lfnvsZxSIMODYj1r/F/mFweMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyxmNGfshRQZMl614PAm65SvfuD/xI2WqYYvg8rgLeYQP7BfJVY2Uu4/IyM+134+YyRHToMYCdlZuOjdbxlOsuw7l+IGcBVoYHvAmom+cQvHZ0y1b+dw5Z5b6hVIFSeQ2qgD7DF0zFCftbaDHp/t2o7+qvzyJle+jQkTkH2u45w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdBAn+GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C3C116C6;
	Mon, 16 Feb 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771246793;
	bh=XTSXpUaNT8kV0Iio9lfnvsZxSIMODYj1r/F/mFweMmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdBAn+GZoY86y/uvjobTk+xIte0YerJYNxBIMWj72xs+aSzxuuXURECuDRCtlCLIj
	 +/4g9xBt5+BvrMy3TT8naaCfuObta6L936pWT4Y4yaXJFJ0m5oNuJpj4Ms7ggUJpZZ
	 T6w67EjQSPpEUJhypwVqYBXTNd0ubjUCw0zw5lofFhU08G5repaePND1ywypweHLQF
	 SBnmY0YKArO9BzbzWG9XZ8xzXUmd4SUDKIODhHqT0ovp1m8OB9RBu8rfJEr8KQRD3P
	 cfehWdg0m+U3iMIXO6AMlL0xxHFn0RWgmJAS0ma929oXCVbVTgyo0+HLeFJf1I+L7e
	 nsTLOEXTSRUnQ==
Date: Mon, 16 Feb 2026 12:59:49 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Neftin <sasha.neftin@intel.com>, kohei.enju@gmail.com
Subject: Re: [PATCH v1 iwl-net] igc: fix missing update of skb->tail in
 igc_xmit_frame()
Message-ID: <aZMUxeIqb2wxVLdL@horms.kernel.org>
References: <20260214194636.295647-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214194636.295647-1-kohei@enjuk.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258870-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67436143821
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 07:46:32PM +0000, Kohei Enju wrote:
> igc_xmit_frame() misses updating skb->tail when the packet size is
> shorter than the minimum one.
> Use skb_put_padto() in alignment with other Intel Ethernet drivers.
> 
> Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>


