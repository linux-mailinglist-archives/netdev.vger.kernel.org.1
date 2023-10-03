Return-Path: <netdev+bounces-37838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717947B74D1
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 80BB51C2048C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D253FB36;
	Tue,  3 Oct 2023 23:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C323C9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:25:31 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE76B0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:25:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id EC23E5C03D2;
	Tue,  3 Oct 2023 19:25:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 19:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skym.fi; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1696375529; x=1696461929; bh=oM
	6U6gMaV7UCPCFtR8zAHE/UJ2iRKBWMiyAlX2N9yBM=; b=PvhZofSmI+jXB+D076
	DEdzL2gzlq2RORBZVUBHs23Fea4OQfrDfO/TN3af60pKQEu4PgccwqSNOBcPCtvj
	i+GxGk1WQV/Ds94kORLEKDdKCU3aK2t2i9ESure/JPVeNHk+Jpt+CqSi7FiXWB5E
	vxN5Cw1JcdNFVQ/NocZQqDW/mPqQ1D0pmaJcuwuZCcU4Ya+KM1TzHDTBnwEhtNXp
	fWNzeAjbEPrlGK3SPGXuVpGsbWu2Cs48uNUn2RdvnlhVN6IZ/Y85uhemQ5OTSjaF
	oSe9RjAvUvZFIv1udFsQ1COdC8c3Tfzx3xTkiCCQazE4DfB0sFMAyDV9uzCsO2o+
	liRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1696375529; x=1696461929; bh=o
	M6U6gMaV7UCPCFtR8zAHE/UJ2iRKBWMiyAlX2N9yBM=; b=n/NYqMuQ3/Gh2TKDH
	NiTNblp77tUbd9Js63PVGO6eXclJ6XZVurTlU812qkqhx9EI4OFFNNsGZKTSkJVR
	1u3EAEZD7I3hG2KUpaZCygS9fh3H2GrDD6PPVDw7zAF59diMn4GVzcxh4WvsVyaJ
	aagq4OXjvVtdq+/1JXombXEK/dhhLQXI5dnu0EHVYYWOlph49UORWTIDjTtZAjN7
	6/5bxWHQmOEfTtrmPU4HtVZZfECVfHkq5CGIzrV2LjxtKNshM/MfDzzKJNVd0L0O
	iBuOUe9N4/pz5ZPoZQ7/oTobpb7GeL87XcPFb/pjo4qD/hY58nqCWORRX8xN8Tvl
	HXXDw==
X-ME-Sender: <xms:6aIcZfBzWctnAPA2yTGQBe1QCulvmjiUW7CTURet0z2h3zpMYhYbwA>
    <xme:6aIcZVgZdjx0QkJCTzWmI5EkwGIp0s5KWdgrzNnLbtJBaAvomHfaQX7Qqmwe4xY6s
    7ohjpWKP4b8aSsDWv4>
X-ME-Received: <xmr:6aIcZakyjn0RVfJboq7A5042w1GbUti0Z9dq2i6M8JtjXAgsims8RZbFy1xibkxv3U1P5J8COBkoKRw0aoEr5zaGt1DkxPCmvbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeekgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvfevhffutgfgsehtkeertd
    dtfeejnecuhfhrohhmpefukhihlhgvrhcuofomnhhthihsrggrrhhiuceoshhmodhlihhs
    thhssehskhihmhdrfhhiqeenucggtffrrghtthgvrhhnpeffkeetvdfhjeeitdejvdeive
    ekvdffheefuefhheejveefhedvudevvdffieeiueenucffohhmrghinhepvhihohhsrdhi
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsmh
    dolhhishhtshesshhkhihmrdhfih
X-ME-Proxy: <xmx:6aIcZRzUvr0CffIcGYFwB4LdQEwYXkqDq4fDaiLN5Pr-lNySSIkvVg>
    <xmx:6aIcZUQ85UogpruNyRqMpJJd2H1rN0C6-6viYL9goqnyDxe4wmfCGA>
    <xmx:6aIcZUZdVt8vrAWL1hj87z6DcXSVke9RbaEt8iauOTZF3E0WSJWFAg>
    <xmx:6aIcZd6bhfJztTis7cpci2udxkeIheda0e2KgM7YYjkHrVNBVts1mw>
Feedback-ID: i1cc947c0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 19:25:29 -0400 (EDT)
Message-ID: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
Date: Wed, 4 Oct 2023 02:25:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
From: =?UTF-8?Q?Skyler_M=c3=a4ntysaari?= <sm+lists@skym.fi>
Subject: The difference between linux kernel driver and FreeBSD's with Intel
 X533
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi there,

It seems that for reasons unknown to me, my Intel X533 based 10G SFP+ 
doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 but it 
does in OPNsense which is based on FreeBSD 13.2.

How would I go about debugging this properly? Both sides see light, but 
no link unless I'm using FreeBSD.

For reference the thread on VyOS forums regarding this: 
https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253

P.S Sorry for the double posting, but now it should go to the Intel list 
too properly.

Best regards,
Skyler Mäntysaari


