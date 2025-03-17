Return-Path: <netdev+bounces-175435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA83A65EB2
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2E174396
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A51F4621;
	Mon, 17 Mar 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="n5SBTKZz";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="6rWg7KFq"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6C61D5CE5;
	Mon, 17 Mar 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241947; cv=pass; b=NfslX9whlYKxezS9dSFVbyYfkESgxiKkOhq1MkmgIRD2OEX+MGhoJvdHzIbPHRUUTwH2fAtsqGPfRi/xHCwBonSkapwTeXUgz3/dpGyG9673DvHFByUiyMrP069edaoB8n/U0KnwadKyCBja+TdZwPL68h/2Wf5j82lmvCUp4ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241947; c=relaxed/simple;
	bh=kWnsbvdBa1QiTDTl5f5tSn5Hen9rak4a8F1Es32iXKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EXvY+jCAncWtybOX1pkcJbRq0vrXkOnjab87jAVsgWasUkQ6QqoaB/e0+uqxh8HCUhjNLfbP6QrJKEksTKC0iBY8R0Leg6mIHiIuRYxGkL4MM84/uQM0MrQRNXSvdmHQiR2VS7i8HtriAlz1iRCWE4VJ52De0dihz4DPEsLxt/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=n5SBTKZz; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=6rWg7KFq; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742241936; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DJyNRy+Ha87P72L/+zvko/JhitZly6cMqGlYqFSeQWGc53URBXtenOYbvivV/u+1Eu
    U4CHdrf4w8wi350+o4f9306ViKClaDzt1r6BB7O4ROrzyeyiU+7XXj9NanFT9rrqg/7B
    bCIcR1clEa/IJzu2rDsl5nhDKJNectGFpBnjynxN2ZXOJwdTqSJFD5xYtVEWutpmFcP0
    t4ADA8r3wrAr342nS774yqEKgRAeuBkIJPGzW85CppFER55vH+UaF9Gfgi/Hup5FH0nj
    ssba7oyozT68gSu3WOEtv0B1E4VBFFcreN2E8l5iQ94gB9XapzqXncTLm55dY3hAC8Wk
    iDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241936;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1rh8G0o8+9wQhTxg3fMPSxvHb/ZwpyMay8h4dcx3diw=;
    b=E6MLBZAg2mxwd6E48Q/OfbU+VX6De7EXm9ThFPMKH8PuH8KDiX1WIuh25X9XsHjDpp
    EGt78WHPoNPS3mQ8JpKQfkImCkC6oWZjQH9tMIx+3Gz2gP62G2gu5eBQnx+Ia2SKfGbx
    BCFznX5upNR2u3bRTpZ5F7OME5MtAAW2sD46Urk7WKurOjNUfGOEkp9GLQxinkEe0Jg7
    jDL+DGIM4FweI7SIh9PrruktVzMUYufs+tx+qiSG4UySXzgsMD1/p8UiksjJnhp2mAXO
    m1r68rsPzC6UIDLaRFvnVhP1BWVTN2oBJpRIylFBDISolGXNXbKh/HaDQOEPkUykyOf9
    uLNg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742241936;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1rh8G0o8+9wQhTxg3fMPSxvHb/ZwpyMay8h4dcx3diw=;
    b=n5SBTKZzXtxbt+Qe8CctpfF6oCtX4GdNrPPJXo1zfAVQ4HflDUI/je+LRORGEDTcfD
    xclUgZAbHxN8gFe5qcgWfso9BM8koQgO/t/nGjEh7knxVJZZ4SETkht/qGX7Uh48TrsM
    K38a1BVwBf85IEYH4u4EBkvEkf3vz1WSG4uxwrIW2Rj46dM7FA7TqQVXx1JfNiFW5yjN
    FLCGBWRFTxmgp0YQgMumJSS0ECPCYmR1fdTm+VR7GWO1U6LCzKFdY0GPAx07MT+W8KDa
    /uy0cu2ensHVvKRflwJT1kjiEbV6LvhANH3cOh6RTYwyOpABacld0+73hCQk20I/fbQA
    s2pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742241936;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1rh8G0o8+9wQhTxg3fMPSxvHb/ZwpyMay8h4dcx3diw=;
    b=6rWg7KFqe7kyp+x+qcfH7oo0kkq2JQAGCNY//1dRQOQPq0zLSBHFieRDZx60EkXyue
    wAD89RJBsqQRvxxAdVDw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512HK5ZFzy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 21:05:35 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tuGiM-00084z-06;
	Mon, 17 Mar 2025 21:05:34 +0100
Received: (nullmailer pid 93651 invoked by uid 502);
	Mon, 17 Mar 2025 20:05:33 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v4 0/3] net: phy: realtek: Add support for PHY LEDs on
Date: Mon, 17 Mar 2025 21:05:29 +0100
Message-Id: <20250317200532.93620-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes in V4:
- Change (!ret) to (ret == 0)
- Replace set_bit() by __set_bit()

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines

Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (3):
  net: phy: realtek: Clean up RTL8211E ExtPage access
  net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 184 ++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 33 deletions(-)

-- 
2.39.5


