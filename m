Return-Path: <netdev+bounces-29348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E2782C68
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807691C2093B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365B7498;
	Mon, 21 Aug 2023 14:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086A6FAA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:46:28 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B678E3;
	Mon, 21 Aug 2023 07:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692629174; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fGmYcQKb4RbsJGmPiTBzWmqOuu5srfCpltURbWSUMl1pyz9F9C+Wuojr/Pv9+LaeAu
    0cmZ1bdDX66XJgne2LxdMCQZjBHh/I3D1jqiYctRHWOUByY5djbaJX254KhrqTJki61O
    PwAaNwUcwHsDuHrXE84R34VAHD3kIaTNODy/qECmtxjdTjigPjqGeJDU5Jv/8EMu6ApE
    M+O9Id4g3MY/NI1578RGNaaWQUm0y1wfAQQzGtzPKtU8CgGMaH2fpgV3l8Pqhcgg+RPR
    47UPU3SizHpgV+Z7uOEo82c7iCVaklcsITSrEyZoYSl8kZfHKytfW+SEl8lvNaDu2pbA
    3yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aBaIKmwJTF4jLVIooEMshQT5OkT6CSN6oFXV5NEgw60=;
    b=DGiZL0LJoPh0kn6Dg/JKM30BMAYEM1sY37KZyEgqvHJfgSrxDrv0IEHAKrKjrIXvpp
    BPsZjLJfJratqJPqKe78ZXdt/4jxHCLZ8egRvP/GIQaz6751Fc+wzppmWocKcXb+YmiQ
    zQAYAI8og9iFpotGsB8mZE7LD9QYphh9Bg4PpYHPeMD7XStmfsVj+XYUfTwGJkRjqhJw
    g6XhEjMymj8OG6oxOCggk4Rwgf7mSEeJUcd/U7jeFiR4JecxciscI4FJdApiaRmrAxC7
    q+eTsZEEuZ3f0VAKHLEOa+Zzt6d4Kt1zlCR3E21JwYUKbcQavvFNRzchP3j0DUmuLQAQ
    PB5Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aBaIKmwJTF4jLVIooEMshQT5OkT6CSN6oFXV5NEgw60=;
    b=JwpxzAaTk2XaXH/ocO8Uk8ULSMJ0ZFVmBn9jnSwUj28ZvKZ5q7hXNUOIKvGf+YyY2Y
    JqsKOi6vYPki60dfEMGscvcAveYJL7d0AIIaauCxmHLKAXp6QAlRWhEDSRtCWa8vH/jX
    FV1WuaGMfN9T+8F0W3mj/o4GTtE0FuCggoaPjDX3PYSU14a0kGOcooG/tQS+/2WIJ7UR
    mazdranwUmcvnQAMV6CTmQJFD0t/HuE/avkUmB11ekdLZHnpjCraAX48uQel1a37d/Oi
    tLEJlbbxZlTTb0+MS3O+hP8FaBgyRIWBjiH1k2KijmE7/vUX98INWbcbXTbosoSXoFKT
    fVag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692629174;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aBaIKmwJTF4jLVIooEMshQT5OkT6CSN6oFXV5NEgw60=;
    b=dA16Ybh9UnZ16kMVwJmDVORO+T1Bn9IrIYH5wSYZ2FANS54lpSh5OMakRU79IHgO7M
    lRVCi4LE6FwIZS/tFsBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3cmcZPR3l4"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7LEkE0hM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 21 Aug 2023 16:46:14 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	mkl@pengutronix.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [NET 0/2] CAN fixes for 6.5-rc7
Date: Mon, 21 Aug 2023 16:45:45 +0200
Message-Id: <20230821144547.6658-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Jakub,

as Marc is probably on vacation I send these two fixes directly to the netdev
mailing list to hopefully get them into the current 6.5 cycle.

The isotp fix removes an unnecessary check which leads to delays and/or a wrong
error notification.

The fix for the CAN_RAW socket solves the last issue that has been introduced
with commit ee8b94c8510c ("can: raw: fix receiver memory leak") in this
upstream cycle (detected by Eric Dumazet).

Best regards,
Oliver

Oliver Hartkopp (2):
  can: isotp: fix support for transmission of SF without flow control
  can: raw: add missing refcount for memory leak fix

 net/can/isotp.c | 22 +++++++---------------
 net/can/raw.c   | 35 ++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.39.2


