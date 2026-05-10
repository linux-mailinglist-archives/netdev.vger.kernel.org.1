Return-Path: <netdev+bounces-286287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE+dMcp7AGrJJQEAu9opvQ
	(envelope-from <netdev+bounces-286287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:36:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BB503F95
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F522301B4EB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B03859DF;
	Sun, 10 May 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtVCMTfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF022382F0C;
	Sun, 10 May 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416328; cv=none; b=mQrpFuUBqH1b2iXimHqDKKCAO0uEqKwhmEPxcZ5miRAMYKszI/CksdBCmLNMirNZFRPOm/kQ7WoT7tHAaPIzyZHjMQHwyCOYxK5pHdhnc7jb/3FPYGZjQuF5t5hS6Du4bU1uH5gpYEf2YqfoE4vRBLVuxmj9ZUY67j3STjRlbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416328; c=relaxed/simple;
	bh=izt8it5D4y3pXmKUYmwcPMlqBztENkqUPjfkjXTGWMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jLKsHSYD7QW9FiGhxIQ9FlS66Bo5G5Fa5qXCMUDbmoWXZGMdfMtryBoeDeKegrVcnx/CY18lTaJ0DVRe+PjQ912POIZkAzBuNORphCeAht5jTEkRfb7qmm43ke+sFMg13WECX73y/GoikI0Vbm+88r3DLChj9XMzCqdfmc2ix+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtVCMTfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC66C2BCB8;
	Sun, 10 May 2026 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416328;
	bh=izt8it5D4y3pXmKUYmwcPMlqBztENkqUPjfkjXTGWMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JtVCMTfX7EF0bGNTdKQGkGYORLGXktpIWKOqgfyWxsdEd0G9sNqG0ciMAdFAIPVe7
	 SF6YaMx7x5goYq39YXNWWT7wTZu9ezUZ1htQJfE0Mrwao93K8EK64arFPj+HoZyi8f
	 KTUICXCKiQLU+WW6Ho8k3VJEOf7TLzy/ooDXRCENz838sSDzznyvkKR3JMFW3Gj/o3
	 AK742Pu0CeYhnVimBbNudn1qNDAdzMkb2Nfsp1i0R3BbUr5G8SFHAeiNrPM8knzsY3
	 2izUv3o2Lw41BizCgxDYQIv3VIFbCFPqDRyNgHJJlHcP9k1E+ib2/XmWVuiMaXTJpy
	 bHEZLD6bHPp2A==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
References: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH phy-next 0/3] Lynx 28G: better init(), exit(),
 power_on(), power_off()
Message-Id: <177841632580.434434.2698335011092735066.b4-ty@kernel.org>
Date: Sun, 10 May 2026 18:02:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 981BB503F95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Sat, 21 Mar 2026 03:14:48 +0200, Vladimir Oltean wrote:
> This is a set of 3 improvements to the 28G Lynx SerDes driver as found
> on NXP Layerscape:
> - avoid kernel hangs if lane resets/halts fail due to other bugs
> - actually have phy_power_down() cut power from lanes, not just halt them
> - allow consumers to call phy_exit(), to balance the phy->init_count
> 
> Especially change 3 will allow further development of the dpaa2-eth
> consumer. To permit phy_exit() and other patches in net-next to be
> submitted in this development cycle without functionally breaking
> networking, please apply this change on top of v7.0-rc1 and provide
> it as a stable tag to be pulled in netdev.
> 
> [...]

Applied, thanks!

[1/3] phy: lynx-28g: use timeouts when waiting for lane halt and reset
      commit: 905780855a320ab3dcf0e4eaebf544cb3e7b55f8
[2/3] phy: lynx-28g: truly power the lanes up or down
      commit: 5d38f693f16a0e9470fda530e01994f35fed8644
[3/3] phy: lynx-28g: implement phy_exit() operation
      commit: 0ee5cc59c0ee679e1a3a749cfc47834041763494

Best regards,
-- 
~Vinod



