Return-Path: <netdev+bounces-253244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BKh5HDyadmmqSwEAu9opvQ
	(envelope-from <netdev+bounces-253244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:33:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0482B26
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06C5F3000FDC
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B92D1F4E;
	Sun, 25 Jan 2026 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5IXZcRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9A38D;
	Sun, 25 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380408; cv=none; b=nv0LV6CgN4P5qhtm8n/T7MPENrea2++aK9OsbC9Zchc7l6MMotP/w9lQnPB5cHP8xVlk4VEeWam6QOoejTzv7kylz7EVTxMe/VgaP1FyUGth/nGdwCyLZ2sXe4I6Uo8KghcGwO75cYfl6ZvTE8SCuPLhNQaI34n2qgyalunY/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380408; c=relaxed/simple;
	bh=3aFSKyowsH8yAAkt2XHhnJHi37vdESYTcI1H33sVQZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I24skfVFcjAje/xg/jwuBSxJXZ8T2Tx4J/ZQOOuGrLa6m7v5SkKOeb4Ih7ZRG3qvkb+1gGmouIUiZlIdZQU/5sOZEUgyaTM8GVaGCQdpCZQx5K20HnIdUe5vss+v+faDnT8h5CH7ACrYyWvT76y2QmJWtGgVQILITMjWTHNusrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5IXZcRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27654C4CEF1;
	Sun, 25 Jan 2026 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769380407;
	bh=3aFSKyowsH8yAAkt2XHhnJHi37vdESYTcI1H33sVQZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5IXZcRFy3Sv7GfNQaqgJ3uQjKmqkT6aa02ViDWbMwE8ujweEdzckho043GwMc76x
	 nwWUGfPFbi3he8csTNm+GDCbyScOzS3SC0NfMDzZxGOK+K/C/huNoue6xaWEONkEU1
	 ywOfXNg2qZZe9ULyrsDiL8F5zHQC3QhBMg5pEPl8y8NwWfivhry6VvbdSX12KXxueS
	 haP/a+c/9kTlwPblC4DHyS7UCkJg8TjzMa/sNo5jFj9XKpfB5nz9i11u6bbYb/5Pwg
	 6tgPCy8fZJ3cZOVLtpIW/oAScGJyaJJKHLL2FSddorgT6zdav23kZoer1N3AHExAOR
	 BnBmHhWLG+0kQ==
Date: Sun, 25 Jan 2026 14:33:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/3] net: phy: as21xxx: add support for DBG
 command
Message-ID: <20260125143326.35d1a2d8@kernel.org>
In-Reply-To: <20260123120117.10883-3-ansuelsmth@gmail.com>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
	<20260123120117.10883-3-ansuelsmth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253244-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEC0482B26
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 13:00:30 +0100 Christian Marangi wrote:
> Rework the msg send logic to support sending DBG command.
> 
> These DBG command use a special way to send and receive data and use
> data in u8 size and are used to tweak advanced (and later introduced)
> feature of the PHY.

Unfortunately we can't have unused static functions, even transiently:

drivers/net/phy/as21xxx.c:631:12: warning: unused function 'aeon_ipc_poll' [-Wunused-function]
  631 | static int aeon_ipc_poll(struct phy_device *phydev)
      |            ^~~~~~~~~~~~~
drivers/net/phy/as21xxx.c:653:12: warning: unused function 'aeon_ipc_dbg_cmd' [-Wunused-function]
  653 | static int aeon_ipc_dbg_cmd(struct phy_device *phydev, u16 dbg_sec,
      |            ^~~~~~~~~~~~~~~~
drivers/net/phy/as21xxx.c:666:12: warning: unused function 'aeon_ipc_dbg_read_buf' [-Wunused-function]
  666 | static int aeon_ipc_dbg_read_buf(struct phy_device *phydev, u16 *buf)
      |            ^~~~~~~~~~~~~~~~~~~~~
drivers/net/phy/as21xxx.c:689:12: warning: unused function 'aeon_ipc_dbg_write_buf' [-Wunused-function]
  689 | static int aeon_ipc_dbg_write_buf(struct phy_device *phydev, u8 *data,
      |            ^~~~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

