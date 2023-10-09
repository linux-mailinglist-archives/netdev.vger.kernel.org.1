Return-Path: <netdev+bounces-39290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5A7BEB25
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E3D280E3A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160143D3A6;
	Mon,  9 Oct 2023 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jcline.org header.i=@jcline.org header.b="mfumQgKC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlZ2nr6c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319D3B7A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:01:04 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBDB94;
	Mon,  9 Oct 2023 13:01:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 67DF65C032E;
	Mon,  9 Oct 2023 16:00:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Oct 2023 16:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1696881659; x=
	1696968059; bh=KFJlfLmUur1TF6+IynsFY6BXUkOLslkI1mlBrnqgyjA=; b=m
	fumQgKCR+oxJg/K2hWo1Dy5kKTXmalj5XZ2hMDLUEIjjASlqc1xvOvgm0e9n83fI
	kQw4FV2jid8N9TfrbN41ry0i8P20hWeBwIS21gwfYBu/xyeFBbVyyTrCibzB/6Xk
	S2Oz/IwZh9s2TUEtyWk/RaqZ9wz9/7PRK4zuWO5dj0KTFp1uWb3XA99c+9jQ3lz7
	fs2Sl/AVlZAaLmA+FdAITgPKPapc5VwEVvfIBB3ivHFUpU0Y835A5tTJcu3V3sh7
	7YKC9xTE9mEsewjc5T32nQmHHulp2qJHvhJ496qBlNePIlh62dnlH8qP2b2Cad0x
	uxLP60wP52VbAx/pNyh4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696881659; x=
	1696968059; bh=KFJlfLmUur1TF6+IynsFY6BXUkOLslkI1mlBrnqgyjA=; b=J
	lZ2nr6c2vc2qNb1TkWyfTzUluHlH4j8pfh63WBXulVmmiKyNrw/ZILmjzFgvel37
	IEnomApgmIFE7XA/Hdj2YQ+574vLvzHQJv4VkK7XRkk5tTkoNyLsuWUKepk7rcB5
	pHAU4dxo6YAKPUUlv93QSk9PZRDiKw7AWthXZ3Ssau2qmsCLQ+NXbGcNunU2YIVD
	U6BzfFrfRU56sW5kXT3bwuDQv+xUixobTThoyQ3aFExVmM4g7yI7w2/F0/3vqFKx
	6PFrTr7HR8CE3uKz03oZArxPXBNrAkQO8KQbMc4L6zt5xqMG2r7tVyKR5SiO0KIv
	IJH8+OJAh1p32MTs5VxcA==
X-ME-Sender: <xms:-lskZRKfpKBNHkwLGAXRkm6NLZk-O6zl4urEqURtgU8Fp3ulNNLtcw>
    <xme:-lskZdICkNUR1Lgqcu3E9FOQyJwmBBa5YT43OBySakdy65K4dFnzIbsnZwjfFmHD4
    Gl1pKv6a3bY-9vW0pg>
X-ME-Received: <xmr:-lskZZs30v2jYbN3AKginJzMtbToNItl-SOHb4CB8qi-DUpvyncc8-N9tN725cKLdevthMfcvbRVgoY56pNN7sLVIEadTJJkUp7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfgvrhgv
    mhihucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrth
    htvghrnhepheevffeftedvfeeuffetjeevkeefheefjeegheffveekgeeujeehgfevvdfg
    udeknecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhih
    sehjtghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:-lskZSZbPuIcvi7WkQdNbRM666eIkOktEq-vZaKWG7gnQb8aKHCwBw>
    <xmx:-lskZYa3vJF73TX5GFmCnPIgvSFShfC7WMb2hwCc5l0uzMa-4GhMXg>
    <xmx:-lskZWAkq376C7FATJM8eu11VRN0RZFf3hnSkgvfzXv2nk5i8aq2Bw>
    <xmx:-1skZUS0vtjYZoGM9L0LJHFW1Vh4UFQc_3-DM_pK9Zv9AoBxB5TOLw>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 16:00:57 -0400 (EDT)
From: Jeremy Cline <jeremy@jcline.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Lin Ma <linma@zju.edu.cn>,
	Ilan Elias <ilane@ti.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jeremy Cline <jeremy@jcline.org>,
	syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: [PATCH v2 net] nfc: nci: assert requested protocol is valid
Date: Mon,  9 Oct 2023 16:00:54 -0400
Message-ID: <20231009200054.82557-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906233347.823171-1-jeremy@jcline.org>
References: <20230906233347.823171-1-jeremy@jcline.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The protocol is used in a bit mask to determine if the protocol is
supported. Assert the provided protocol is less than the maximum
defined so it doesn't potentially perform a shift-out-of-bounds and
provide a clearer error for undefined protocols vs unsupported ones.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
Changes from v1:
    - Target the correct tree (net)

 net/nfc/nci/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fff755dde30d..6c9592d05120 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
-- 
2.41.0


