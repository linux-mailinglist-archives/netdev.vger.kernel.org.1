Return-Path: <netdev+bounces-281868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLlRIS608GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:20:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11473485B82
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A865E31EE809
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A545BD57;
	Tue, 28 Apr 2026 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA4iHdav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5E843CEFE;
	Tue, 28 Apr 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381702; cv=none; b=X2nUo0cn8jDo2maxOSfGtqqKMBJPuKzbCyie7kJS+MUTKJDYOWxIm/C1unk66vY7LCz+kpaWjuvp2O79SjcY0JcQyT0YwUdqYQV4/HTDWZfUAQINa7nwi5JYCUT8ZyF5GIFXw988r2f5mUD79bYLl8ZjRuA6OqAiq2GcB+nfNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381702; c=relaxed/simple;
	bh=jpOXQufcupA4uE9wKdhbKHPuGn3B1C20pVPsts9K+V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzEKOOcFlvH9wnSRWtahnkH9X24csvjv8/uxU3ICQqRsV0QcBuZeH4Y9OBMtj66pEfqL/lxtAkpqO1U/jquTGzJlg2pevhRWLPQoVe9NY84ka7zAv3LNkgbC0a3nWXh1N9EMyP65CpJlBQHnYcMaIm5l2ksL1UBmTeoDSLSQcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA4iHdav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969E9C2BCB5;
	Tue, 28 Apr 2026 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381701;
	bh=jpOXQufcupA4uE9wKdhbKHPuGn3B1C20pVPsts9K+V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bA4iHdavRPZiaUe3alv+zF8MhfkXLozTo5vUTQt35/s6Hv+Z2HK8dqmjQB8SxbVOD
	 HUOvLAgNQWvqW7Bt9FK7yY/om1pt9dnWEIJr3c++k4f3jOrNlx6JIkrj8EEKgwetex
	 SJTAIlFygf9JHts7tpNhwpvM2uKWZmgn0PgL1mm+Lh915U43+U6tG39reF3i6i1AUw
	 jUvVTV96QnbUEKl9Jz3KbNUAF6/fqBeA7mqrI4xNMRxKkFpLd6LFdIl0YBLhhFU3MX
	 qDqk1ph8MzGJhIwKxYfvRQTL+9mbHyqSRqP078Rj6JjHSTg1lva2HgplSMDpBe9KCk
	 TDltv09WpG77g==
Date: Tue, 28 Apr 2026 14:08:14 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] sfc: fix error code in
 efx_devlink_info_running_versions()
Message-ID: <20260428130814.GS900403@horms.kernel.org>
References: <aeyEzO6C-v6J1VHH@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeyEzO6C-v6J1VHH@stanley.mountain>
X-Rspamd-Queue-Id: 11473485B82
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281868-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,vger.kernel.org];
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
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, Apr 25, 2026 at 12:09:32PM +0300, Dan Carpenter wrote:
> Return -EINVAL if efx_mcdi_rpc() doesn't return enough space.
> 
> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


