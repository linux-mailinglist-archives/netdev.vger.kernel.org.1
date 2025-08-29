Return-Path: <netdev+bounces-218169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAEB3B678
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35429163B01
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAC261B7F;
	Fri, 29 Aug 2025 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ODniFYy0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yjqt+mTU"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB3481B1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457665; cv=none; b=r47Ic387XMo79sUtnopTs1/NLXoUcrOPg97FWGehYJg+LkOJOhPwnoe+1ujaTkymShLOUvIaUEV0vlgwSy6GsLm+sdgA9lSZtzVIKktQC9BzJ6erZ3FXLmbovNXLfYhAKT2qePUcTl19fX4TZrLbxTkjnCT4E0xurTCl6RwxkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457665; c=relaxed/simple;
	bh=cqOwbgAuXb1EOsmLS936CP2X0rouiYYncs8Ww/vvBoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n03WJNlLQRi7kzs6A6ymJvROJMGAyzUonUjN/YoMf762hTG7S2LmjUNI8XyWynRpqyJJ/uBRXx7Q5BkhC5O5vyD9kv/dZfEG3HfSLEvRkAkVHoGQ/aTWS63uK47aAIUqhAAd/2U2XPelkjPlYoRHSSwQEi/TAGRmEkw0MfC46CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ODniFYy0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yjqt+mTU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ECFC5EC03FC;
	Fri, 29 Aug 2025 04:54:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 29 Aug 2025 04:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1756457659; x=1756544059; bh=TSeUSyP2U1
	Et//0EvYsrVE8ycBGP9Bzla05xuoKdpOY=; b=ODniFYy0GubyVgH6CYU8zEtJYb
	wScgLiDxVWmljL+aTjnDtXv4cA6/7SjGZ826rN30lPqojr0cYgDtnwnjkKxxWSfx
	Psv1WS/S7qCJkapKAKHKhPdaTgavh3QQpgObIDcjh0k9uMLaTgBXqa8B+9r9hE7e
	xVXjBCXWEB/wJYgy66VFE3S4UZn8zlpOZJNswE8cNmCX/Z2b/2qHgVwb7CPxLItJ
	drE9KiKK98pV/Ad0+Kf3w+e1sxiS2S96Sv98tQy+V6PCzPSfmaPE5dmTWzb10E/X
	ceVSNlqxsun+uQIFaIJsrJAowEn7Br+7x/fu7MReCGU0PYjtzCaBiU4RMMIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756457659; x=1756544059; bh=TSeUSyP2U1Et//0EvYsrVE8ycBGP9Bzla05
	xuoKdpOY=; b=Yjqt+mTUFfea8imuHbYFOyPWezICtStLvok9sbL3c3xkWtRHb5S
	wxYyTEhOgNl0c7y1FkQKNhkw84wfNKye+ffALK47VlBGvGYwnlttR05UVDldxvTG
	FQUxKTrJt/89Yo6/FUR+jb+UxZQQr5veSmXrdEPkvu4q11JyIoiQxl8693gUc9H2
	vee9dLfVA8gN72UE50R/sJXrTHDQgn47Z1OfMvCy2bxPhsSnZi7MMsS6j9CHdkOr
	7C7nzAgof4Rf4Up75YQ4TmTW6pfHVOFwvrwLyYYLoEgwqPvK8yhGmQS0X8miAJE6
	G9Hgovgno8alngG9XYpFYzGkbmH3aH/PESQ==
X-ME-Sender: <xms:umqxaLcXcUieVqgLVvTpScEDQfI24CA4ZuURd1w4uqzX8cknJgu_gA>
    <xme:umqxaOxebe1w-30cq7F9rlMub9scrJeVbt6FbGruiOpXx8jS4szVLu_Zz6U5A6PEp
    lqi8Wqrq5aUclw9mkk>
X-ME-Received: <xmr:umqxaK_gGBOjjIVt9KQipLOyQiA8kmLr4GWiRLlcotw6TidJd0O_7nT4TKAn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnheptefhieejudeileehvefhjefhudduheekleelvedvkeffieevjedvgfeljefh
    udefnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgv
    rghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehsrggrkh
    grshhhkhhumhgrrhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgvfhhfvghn
    rdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrh
    htsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepshihiigsohht
    odgrvdehvggvleguvddtugefudgvgeekfegsrgejsgesshihiihkrghllhgvrhdrrghpph
    hsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:umqxaOi4fabDJCP2bmBBVNjnQsIx_AAfzljXMNLpl-I20KLKK2cV_g>
    <xmx:umqxaJGK1c9-GTrMirUAGw7eAjHHzmrcTHRz-EHFbM_Y67pOEcS4zQ>
    <xmx:umqxaF-h8EfXpU6bmIVc2YP0OTI77xXUf5Qnpv6YzoHflP1JT_9QKA>
    <xmx:umqxaIwKbYaDFqFv8Br_UFZ5cEFM6tkHKVRnwZjbyMd9jjZ-hvnFkA>
    <xmx:u2qxaHFWCgePXJ6w09ouzMDYvL1gWAuCsT_vDQHZ_RyO-LuPZjXlLaai>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 04:54:17 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Aakash Kumar S <saakashkumar@marvell.com>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Subject: [PATCH ipsec] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
Date: Fri, 29 Aug 2025 10:54:15 +0200
Message-ID: <b7a2832406b97f48fbfdffc93f00b7a3fd83fee1.1756457310.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x->id.spi == 0 means "no SPI assigned", but since commit
94f39804d891 ("xfrm: Duplicate SPI Handling"), we now create states
and add them to the byspi list with this value.

__xfrm_state_delete doesn't remove those states from the byspi list,
since they shouldn't be there, and this shows up as a UAF the next
time we go through the byspi list.

Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 78fcbb89cf32..d213ca3653a8 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2583,6 +2583,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	for (h = 0; h < range; h++) {
 		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		if (spi == 0)
+			goto next;
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2598,6 +2600,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+next:
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			goto unlock;
-- 
2.51.0


