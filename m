Return-Path: <netdev+bounces-256746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBvLIVFqg2l+mgMAu9opvQ
	(envelope-from <netdev+bounces-256746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:48:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB37E9654
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A43B3008C3B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3E41B371;
	Wed,  4 Feb 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJLn11XS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBAA41B365;
	Wed,  4 Feb 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219846; cv=none; b=Oqa4q5gfBIcure9cCT7QsA7BC6fvUltS7F+HYfdUEvYWwRCBV2iSBe1mJxDWftokbvPl9Bg1OYQUwoMTKI0YHEaVkiDNIIlMFMakjPiO7jrxCjpGOXKmyG2xqvbjpqiQwLeF3q0SQ6nR9Y4R0NiwJQrEEOhE0QddisTm7hE66B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219846; c=relaxed/simple;
	bh=gM+9C1GefTDiD72/AoT5vSGcQRcVvp7WZ+TBoqKWXi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gp1+0BSYcLFd5NnMN1UoXO9RDsm5nOEVU3MoujYuiXnC0nocppm26qoaNF+9fphybSXksQIOoScWourR9gLvIZpZxoysQIxeMH61sJbaw1mrVFkYCdOvyVAGxz6RctahNUlnv1I6q9PIZ2LlZmAkjBAh2xy358/UW9k0qXwlW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJLn11XS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D134CC4CEF7;
	Wed,  4 Feb 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219846;
	bh=gM+9C1GefTDiD72/AoT5vSGcQRcVvp7WZ+TBoqKWXi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CJLn11XSwTacFkFCF0Ytm3O7PtRPN9umWvZr122a/TRw83mrAL3v6P+mVDVUf3hbo
	 45RoVQyVbbNS+9C+AfEJn47v0nCfkc2BHIqon6UNDoII1Pez5pzQoziu1na/CWHd9n
	 zaoLQLSfHmfRYeGxJVj0xfl7ZSuNuFaqC/Mp9mk3l6VUBkwp5kdkI7kiyZxzGLYN/8
	 RK5Alj/3aCD4ynCq0s/uobmEopPVjTb/ucEZIPBa7sDSvnPBHJ458Scklqjm51fLDS
	 toJD3u43PQdzlsMu1wIgd/5+9vJMUCRblVeoKDKUNhuCVkgwEC91tLOemMc8Xyeo6+
	 EzgapKA/iUILg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, linux-kernel@vger.kernel.org, 
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
References: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH phy] phy: enter drivers/phy/Makefile even without
 CONFIG_GENERIC_PHY
Message-Id: <177021984348.133434.2174228638477842176.b4-ty@kernel.org>
Date: Wed, 04 Feb 2026 21:14:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256746-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EB37E9654
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 13:06:00 +0200, Vladimir Oltean wrote:
> Kconfig option CONFIG_PHY_COMMON_PROPS, which builds
> drivers/phy/phy-common-props.c, was intended to be selectable
> independently of CONFIG_GENERIC_PHY. Yet it lives in drivers/phy/, which
> is entered by the Makefile only if CONFIG_GENERIC_PHY is set.
> 
> Allow the Makefile to enter one level deeper, but stop at drivers/phy/
> if CONFIG_GENERIC_PHY is unselected (i.e. do not enter vendor folders).
> The other stuff from drivers/phy/Makefile except for CONFIG_PHY_COMMON_PROPS,
> like CONFIG_PHY_NXP_PTN3222, all depends on CONFIG_GENERIC_PHY.
> 
> [...]

Applied, thanks!

[1/1] phy: enter drivers/phy/Makefile even without CONFIG_GENERIC_PHY
      commit: 3ddcd24b4d8454b2b9b2d013a0d61986ae8bbbe7

Best regards,
-- 
~Vinod



