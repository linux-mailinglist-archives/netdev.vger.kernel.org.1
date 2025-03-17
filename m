Return-Path: <netdev+bounces-175209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE1A645FB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947903B00CA
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ECA2206AA;
	Mon, 17 Mar 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oc0JjkT8"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58621D3F6;
	Mon, 17 Mar 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201000; cv=none; b=ununAPVbvt+gteK5+QNw2gqC7+qDJOmkYcJ586t6Rge6YNggQM4WYEnEwTOcI/fgmCU9RRITIfN2BSdkQcUUFZuSVupVriGfFx1fQPULgcrJhar8itskxQPT478Y4oBoqbKFiyHFkBMHFT/YmsskRPVj0gjV0JXpEIkiDuhqi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201000; c=relaxed/simple;
	bh=+C8Il4En+ijPI/k2ogMmSmf5jgTySetUwkY21buzw9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pcFFnwS3NJllB5QS8JhXn012vntN6YA7hGeVkgEg3tk70TIwgwieT+BCQuGBDHUrXQOP2B2SYW1k+Iu+4N0NAPbdx+L8G3NXPzc7uS/o4eQxwBS3pmxD79c/AqJ9EDDKJdrnTqGVaGpFwKnBd9orRZ+AOacVJzUeatT71VPh7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oc0JjkT8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H8ghkqF225779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742200963; bh=+C8Il4En+ijPI/k2ogMmSmf5jgTySetUwkY21buzw9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=oc0JjkT8kWglWobJKheN04h8kW/xXHCoe/b7LxRRCaX+fLl5tVSjyLgGrsGhJt+zg
	 LCIFa8YLSvbEDmRU2NhfcsZTLviD1nriIoyF86EA+Sym2+3CRY6N+exJwQftvzH0+f
	 w9LWpcaK7xB6gUqYLSyAA4q+K4RfmzOMhWu6cyJ6++rR7QVEf7fVH68zhFh97KXi+m
	 bkihC9XwBTO9X4XsbnpN7uUoYP3MhSNLX9rTeZmpVfYiiATlE2RRqsre1gUoT30mQ/
	 D8CL5t42K7Eb0ZMvSb2D2orc58YZyMn1zhKN+tz3DOQEI3dT1Re8uwlTnwVx6HX5Ax
	 hJNgtWadTE9fA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H8ghkqF225779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Mar 2025 16:42:43 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 17 Mar 2025 16:42:43 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Mar 2025 16:42:43 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v2 0/2] r8169: enable more devices ASPM support
Date: Mon, 17 Mar 2025 16:42:34 +0800
Message-ID: <20250317084236.4499-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series of patches will enable more devices ASPM support.
It also fix a RTL8126 cannot enter L1 substate issue when ASPM is
enabled.


V1 -> V2: Add name for pcie extended config space 0x890 and bit 0.

ChunHao Lin (2):
  r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
  r8169: disable RTL8126 ZRX-DC timeout

 drivers/net/ethernet/realtek/r8169_main.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--
2.43.0


