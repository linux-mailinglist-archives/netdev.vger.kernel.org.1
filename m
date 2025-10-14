Return-Path: <netdev+bounces-229122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D98DBD860D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF20419232D8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71923F294;
	Tue, 14 Oct 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="FI4c+NkK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhRG93at"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80218A6AD
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433468; cv=none; b=Bpmw4Nrd9CxnLAV49bosGtSztkJtQjQiwitDffuoyHLX3UP+jEVQXkaYa0iBKNM+s5V8aor6fN7dJxxLikgpjFpT8DG7NKxSrBSa1/wP3v3N43X9JobfdJ2JzZ9hJEtIpODiI0UEImuVCnTL7IUAy64WVfNIFc1V+/VSSy8e1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433468; c=relaxed/simple;
	bh=xVt2KhMxkaUlBnmeC282awEVKhiozCUy/8oazMpuzgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxaUPQ7RB+uqloLL5qU3aHZv9Kz8wUC/HkKP5VUOin4o0P0SA+5ULY7vzT2FddAa1qLWJ+Qlsfu+ryaerL3O6bpA94tCQXwT7PG+LjApth5xllUKTr2zZrfMniX3lVD7qRdsMxob/CwDfuWEVEj6DZYCGcSBaIMnMFxhxHGYUEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=FI4c+NkK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhRG93at; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 48D55EC0235;
	Tue, 14 Oct 2025 05:17:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 05:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1760433464; x=1760519864; bh=62isxslHQy
	oOt9jOlfr68WvoD6r2j2MzXP3zmd6RWDo=; b=FI4c+NkKW8mp11VHJ+5OYgJYAj
	JatltGhAFrvKPKqMeI8veybq3H/ml7q8j6rI7x29NFAayBw1k9UaJm65kWuh11Ds
	pzVnbQiQgxXBQL+I8GkPEepkwWC+zczh/89W/TEcJVEnAjtYBj/zhvOnt2CNDD4J
	Q6M/Z5f4tEEmScoFdOQdJoj6bOKh3pw3TZsIVeGXI6ByS6G4qFKp35wFyCGSqK5d
	m+rIvGnthjU8yR8B5Tji7CST2TzLl9kuVv+1M5043UzG8QRMehkg9ASqErYnhZ/a
	+ebQSl3t+Kyt5NmnKRQCdi3exQiw6D1bqO2QCTekwe+hXZCst26qCX1Q8ccg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760433464; x=1760519864; bh=62isxslHQyoOt9jOlfr68WvoD6r2j2MzXP3
	zmd6RWDo=; b=WhRG93atYy+OsBOrvfARCEuY9xD4UJiL3bRjAAiSRUa2bN0/ijX
	gQQQJ88THZNKe+xp8IcJfYRgN9y+eMqyZLsZKK80rxHysM+4MocZMRxknITjcMQ5
	/NSwQLyXUjEpLZNRjvCxym+osu0VI3YotW/tnUVsRxIWqFcdDx4hb78E7cW0csMI
	INHEEOcnu7gYbjfUZRedFofQ1IgInWPLUfUyq9BArquDpwN/Fw3iLJRm3fOOuc2L
	M/kafJPWym0eHKtNoRHaPCWF3dlrGhY4O3+ZS8hbZbop7pwm+NWSFvLHkjRvDw5O
	U6GzGf9kwT96MiggmCb6+SzElu9guC+75lw==
X-ME-Sender: <xms:NxXuaIW8N59h9SwKrHPwCHFEqSEcxKT31wjzBqvMNLpj4n20BN4CYQ>
    <xme:NxXuaDep4xm2-j5RIDbSziHARQVIq15BkgmHTDIzNitUq-ARg8zE204rWn3QrSD3u
    DPhl9GWtxMtAAuxho6Wcx3_sTzW8Igqq9_W5bykoQzpq8gMkF7W-eY>
X-ME-Received: <xmr:NxXuaEsJveMKjoJWhDX9w61oBvyyw3G8TpZWuilivtU4sCDtveAMzD8s6Oo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihs
    nhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejtdeugfffkeejfeehkeeiiedvje
    ehvdduffevfeetueffheegteetvdfhffevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshi
    hsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NxXuaC-Bm-4SI7Jn4q0goBvZ9ZWFeRrt0m_gUoaNJBn2xgdzYGMpIQ>
    <xmx:NxXuaP33r1yaeopHN0She4yl69L8muvcSTjD-ScS26nU4JXLgZvfpw>
    <xmx:NxXuaHA-8pYoJNBplJAH_VB4mVWbwNZwgNsH1PrqWeLKHgp7D_pw6w>
    <xmx:NxXuaLd9tu4CBHcuLeX5agi-fn5MtKunwYr1edNGi60H88oWunXhWw>
    <xmx:OBXuaEYP_g_E9eKJGKFF_MokO8Kowi6GzaYl_o7_g5uNJbH7T-CJPkG7>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:17:42 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 0/7] tls: misc bugfixes
Date: Tue, 14 Oct 2025 11:16:55 +0200
Message-ID: <cover.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jann Horn reported multiple bugs in kTLS. This series addresses them,
and adds some corresponding selftests for those that are reproducible
(and without failure injection).

Sabrina Dubroca (7):
  tls: trim encrypted message to match the plaintext on short splice
  tls: wait for async encrypt in case of error during latter iterations
    of sendmsg
  tls: always set record_type in tls_process_cmsg
  tls: wait for pending async decryptions if tls_strp_msg_hold fails
  tls: don't rely on tx_work during send()
  selftests: net: tls: add tests for cmsg vs MSG_MORE
  selftests: tls: add test for short splice due to full skmsg

 net/tls/tls_main.c                |  7 +---
 net/tls/tls_sw.c                  | 31 ++++++++++++---
 tools/testing/selftests/net/tls.c | 65 +++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 11 deletions(-)

-- 
2.51.0


