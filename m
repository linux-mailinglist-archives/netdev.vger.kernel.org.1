Return-Path: <netdev+bounces-116290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B6949DBE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CE1B21FB3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189AB15D5BB;
	Wed,  7 Aug 2024 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfvbSR00"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668F2F43
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997595; cv=none; b=eIzTeMKPD4GZ1kc3F9WFKL+Err1o2qyH9mRvCF97PYTGEMrSlltplq/RPGQFieiid3zDWUJM6UDwI3uEMyz6JlYmjepYwMnKOcQzwocLJhtnoUqiYF3vnCPAF0KyplDNrri4LPVHWjMShDMP2/BR4pZwNSOW5ejVFQMU/lLrWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997595; c=relaxed/simple;
	bh=lBk499P1NLzQ1wvRQBB75+tDSN2CA1HrhxLkiHzCz18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bkv69l96UC3/U8q5C0y3+o498ivFJ1G6INxOoAP54tLe7gKvBFV8UK5PH085xOgthTBA+Wy2wFY9ohY+Va8lzen5nnMVZoeQI/wb1by1PcaX6c0i2TudCt8JJSHrNDZAkxhiYxHdDSKrz/OqrlMCv25XSB0xV8gyShpYRCHcpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfvbSR00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B0C32786;
	Wed,  7 Aug 2024 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722997594;
	bh=lBk499P1NLzQ1wvRQBB75+tDSN2CA1HrhxLkiHzCz18=;
	h=From:To:Cc:Subject:Date:From;
	b=hfvbSR00eLdheUU53aKw0Nu1OdErbFw7VebdkP9CZPet73XSVOymfV+em4TU6HJ76
	 NQ47mVvIhh2MqSAxtUec53ndeNBIO4q+ZDPVq6JSeoWzlnfNM/QUIlgaMagfru9awe
	 5AlNSmZZe5gIWt0b599UlvDo7RjGuEKWd9NkDEX2danvU34yfkuqKdUMjq5HUIBD9c
	 KbW89UUjpubaeRurc1FCFjgYHmu3Gk3Ry6J/mh//DbYgCxewKW5k0SiQqdGsfdtZwg
	 wsJhr9ro7W7wssal6aDj1oys4RwdfTfmCGsIx6fNf5M7iVEoeQTFzB841ScN42UJ/H
	 DH/be92Ubbhyw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] eth: fbnic: add basic stats
Date: Tue,  6 Aug 2024 19:26:29 -0700
Message-ID: <20240807022631.1664327-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic interface stats to fbnic.

Jakub Kicinski (1):
  eth: fbnic: add basic rtnl stats

Stanislav Fomichev (1):
  eth: fbnic: add support for basic qstats

 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 136 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  56 +++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  10 ++
 4 files changed, 204 insertions(+), 1 deletion(-)

-- 
2.45.2


