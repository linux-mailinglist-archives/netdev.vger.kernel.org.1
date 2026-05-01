Return-Path: <netdev+bounces-283309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEZPIzs69Wl8JgIAu9opvQ
	(envelope-from <netdev+bounces-283309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:41:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F44B0586
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0346301690E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1C37E2FA;
	Fri,  1 May 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCRg68/u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64876FC5
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678903; cv=none; b=BVTgvXgJ5iVSF2CWtnm3MP5ZQN1EvHKJ1C4bo8xJeeCMALMjni7q1uiIRtB6mkAmDCoUI2JcLcGuraCCOD9s9I4zFVunWmIaay5Fg8vHkSFZDZK1RHtBXx8acmN8ONjsPV32ekT1cTFLWtVICS+kPqEkC43yaXB5GHzG7zlmxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678903; c=relaxed/simple;
	bh=lhpeol+0ulG+Ef1czwz3jozMm0LyTrPVVBHkFeQSGrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlSuM4ewWGifW6CU0LF8QWbom2lDramFL/c71ZC+kQRPxWKticPgXaG/o9g4L9n0H4V524V2uHolG48Sp8S7f8BQC5X4JwILHIhtTQWtN4ZVa87fzU56MecNYhxNpWUldg6x5K7RZxxlIcLeNpfTRtjo9lMDCkPFTFF+mZkAZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCRg68/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B892C2BCB8;
	Fri,  1 May 2026 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678903;
	bh=lhpeol+0ulG+Ef1czwz3jozMm0LyTrPVVBHkFeQSGrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCRg68/upk468E2gh5yQVI1nCflGF0F/fV9fTB+yCKPZaF20fXKzxhnO7aTc7JIh3
	 jKxUOmZNIRD+xc3F6XjUtL7PkTLpMAdqqgLNS7ZnwgqqSweEemttaUiwPP7fx8SONL
	 2sRUqy/DpFo+0CzG1Cv5J+N3qdlCjz5dv5vl9d5+JtIZUNuddgiE5cpqtVRSnFmMQZ
	 4vpweih0Ow8nswPbWK13gQWecBTi7ry7gY2OMeosY2Zj7rhKYQ91J3XAbtuVczwCtD
	 6+CQ4An6ah1WiJTJWEva+SYzbApVGmxE4pyldJcs+J+s3yUAUdWlOEoyFde2/zobIa
	 ebJRpIkTEWmOw==
Date: Fri, 1 May 2026 16:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
Message-ID: <20260501164142.77cb73e7@kernel.org>
In-Reply-To: <20260501031555.43259-6-eric.joyner@amd.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
	<20260501031555.43259-6-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 373F44B0586
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
	TAGGED_FROM(0.00)[bounces-283309-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 20:15:55 -0700 Eric Joyner wrote:
> Several FEC error statistics being collected can be reported in a
> dedicated ethtool callback for FEC errors, so implement the handler that
> does so. This includes 802.3ck FEC histogram data that some newer
> hardware collects.

sparse says:

drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37: warning: incorrect type in assignment (different base types)
drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37:    expected unsigned long long [usertype] sum
drivers/net/ethernet/pensando/ionic/ionic_ethtool.c:449:37:    got restricted __le64 const

