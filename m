Return-Path: <netdev+bounces-219593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E9B422E3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61DD584FDE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE230F552;
	Wed,  3 Sep 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zZtl8LDO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7B3115AF
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908037; cv=none; b=l2Pa3eAAm8Yu26ySj269Pw+jM1WLcabI1xAurmIBEW7UVaMgIMAdlCvp4apXFsFO6TCfnjn7Ffl1pzVJUmPhr0nfcCCjQdmODquERd+/KEUtAwvCSghzPKH+oH31jkzI++mVRUk2UyCyTRpPGrhJcaJFlEH4yIOognnhv2hYTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908037; c=relaxed/simple;
	bh=zHc8uPno3ggcg+aQz0NW5+RGzEjnUrbNUtzIRbT+Gv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dh77yl5ZHjH2YDHEb2Pl/g0wFPkFi4CdkrOs3XjcD7QIq0BYirEHW6QWfk/mM5KD8o76FoUeGnnb7biN7pBhr9SDffN1Le1+dWD3sgamlBdgmlQgDXOPWfj5JDGmXKDBhm4o1m3n6D19iJTKnuCG4VleLeIsxVEorHKPVKMBbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zZtl8LDO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PZxPMEjPTKCPQuV5Vdll2zGdxDT5RzAvIigUnlJowmg=; b=zZtl8LDOWyf58VMvu585aBJR/d
	VIR5p/ovbKNLwNroL6S9fJBtlMxJhfGIEI2uVNVwdN7MjPX7W2IKNlVsytMjmopBwhndH9RaG2duX
	BCdVq3MiX5gsXa/PbQW1I3ABt26OQm5BAE6R3MQtyDYZ+AANiARddOCnBJm0p9srzJShLq3tPkzL1
	vIAEVlF2byC5srNZr95WIq3qwr3Rv9B8F4KNgSimXPEiR15EObk7wSaasOkihcK0IYBEvZCtN+SC9
	f7IT5GgvrxR5kduuY8Rh8mvn1/5yry/RYALtCrZSbSUWgHhj65YEunExZw7vGtROADkMNEeesLk0k
	hhDm2Lug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48416)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uto29-000000000bj-2vxv;
	Wed, 03 Sep 2025 15:00:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uto24-000000000ag-2hTt;
	Wed, 03 Sep 2025 15:00:16 +0100
Date: Wed, 3 Sep 2025 15:00:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: correctly populate
 ptp_clock_ops.getcrosststamp
Message-ID: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

While reviewing code in the stmmac PTP driver, I noticed that the
getcrosststamp() method is always populated, irrespective of whether
it is implemented or not by the stmmac platform specific glue layer.

Where a platform specific glue layer does not implement it, the core
stmmac driver code returns -EOPNOTSUPP. However, the PTP clock core
code uses the presence of the method in ptp_clock_ops to determine
whether this facility should be advertised to userspace (see
ptp_clock_getcaps()).

Moreover, the only platform glue that implements this method is the
Intel glue, and for it not to return -EOPNOTSUPP, the CPU has to
support X86_FEATURE_ART.

This series updates the core stmmac code to only provide the
getcrosststamp() method in ptp_clock_ops when the platform glue code
provides an implementation, and then updates the Intel glue code to
only provide its implementation when the CPU has the necessary
X86_FEATURE_ART feature.

As I do not have an Intel card to test with, these changes are
untested, so if anyone has such a card, please test. Thanks.

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |  7 +++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 10 ++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

