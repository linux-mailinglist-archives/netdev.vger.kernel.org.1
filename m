Return-Path: <netdev+bounces-267365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DQQEtPes2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:54:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77C280E84
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1195307B647
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFF3890FE;
	Fri, 13 Mar 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NGItC00l"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A793890FA;
	Fri, 13 Mar 2026 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395416; cv=none; b=XPgyUvaepB4HGKy5QehaUPF8CvZxPB+qA5Z9GqAu3RLAwSdrDmalb9HO3i1TBvMG0AgtWvS0ODo7a9LyrqExk3wVfXXKeaS1DThFg2JWyxw6EEYMiCtNcKKFtVvRZB2/geKmbf/abxLrRcVhKy82Hw4H89Ohk0awzdPVP0HIS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395416; c=relaxed/simple;
	bh=/6Wb9VDy1MsXWWkJAuR51K2/pdJP6P2DmpaN43oH2Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PZ/YYquwykx+Aod9JBwwelIsvnhIB761mabq2HjF/kQyxVBSoTMCxy0+C1Z0uJahNFB5cp5dvsynRLqMBl2AaSdMeC/QWMnzaYdbiA2WnWI+m+itBf89RDfcB4AsrieM6gwwT0+0OOjz6E2k6exy/wuISPGsMjlnvF5rnMrp77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NGItC00l; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i3gBEvfmyQV+9uH5i4FmpSfnmRtgPTkWMoZkpfNCYRg=; b=NGItC00l6+gJk9x21ROBzaYDvn
	WDz2Ey3tXX4u6ERSR3F0jaS/OCIKaQ2CHlLrcytk5TXO5JigVsKhtCg+9r0NVY7ptbZcsVQCqmbEw
	G+Vk2iaTBnktzw+qJ/E5TcfiA7wjR0412rqNEDS1munnv1Ctvm364t2zymjEUMHRefPkMZsyLdMcK
	EDK0SNpvOu8m/7Ej1PBlVVTPN6Al7c0DMHh1Kq+5B/gHUPRRObyGWgDRraaeWBSFxmNX12fbp0aq5
	JokDO9hJ9wgB4kdeCKtTj94xkinQOD5jBBknMcTgV3gIobOKi9EEqJPewOYzR+fJmlgfxwHZz52NF
	dAPPtwPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37432)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0z9m-000000000bp-3IC3;
	Fri, 13 Mar 2026 09:50:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0z9j-0000000087c-2qla;
	Fri, 13 Mar 2026 09:50:07 +0000
Date: Fri, 13 Mar 2026 09:50:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 00/15] net: stmmac: clean up descriptor handling
 part 1
Message-ID: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.890];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: AF77C280E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Part 1 of cleaning up the stmmac descriptor handling. Rearrange the
struct stmmac_tx_info to pack better, and introduce helpers for
duplicated code handing the transmit and receive descriptors. Remove
unnecessary struct members that are only transitorily used.

 drivers/net/ethernet/stmicro/stmmac/descs.h        |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 458 +++++++++------------
 4 files changed, 197 insertions(+), 273 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

