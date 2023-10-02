Return-Path: <netdev+bounces-37541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF07B5DC7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9156A1C203FF
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8AB208D0;
	Mon,  2 Oct 2023 23:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F81E521
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:40:07 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA47B7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1696290004; x=1696549204;
	bh=6DHdQbMvIWC+d7DLpgr//TLkTz6cWUQ8snqb9evmiZk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y+TqzzD5G/+tu+YT+M5KZPXY0Jl900r1zX14HHdruI6VzYTerMctm6oL2w/e3jdmM
	 nqo6J8DI2R0p0T6Ksj+bU30N4hDRUlbH7An5e+URedItk/07fyI00qTL9yD4bSK9bB
	 hx2I54A20wPLEF5FiBVek26Wjwz6bI5YknDPE385VcsjV9b8nyCc+aq5OM9HtOK0bB
	 j/ejWpx3aKBPkDmfJ/bJCko1BZ/5+ZUYHP328kIXiRYQkXS2sBfnuAova/qgiVRzbI
	 3RX99tcKAWkpI69XilgFqf5PwY/ma9IQzdzTFdWZBlVMAe8yfB7L+aRSuBW/tcrLMj
	 F1iq1hTuzU5uQ==
Date: Mon, 02 Oct 2023 23:39:55 +0000
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Michael Pratt <mcpratt@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rafal Milecki <zajec5@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v1 0/2] mac_pton: support more MAC address formats
Message-ID: <20231002233946.16703-1-mcpratt@protonmail.com>
Feedback-ID: 27397386:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, mac_pton() strictly requires the standard ASCII MAC address form=
at
with colons as the delimiter, however,
some hardware vendors don't store the address like that.

If there is no delimiter, one could use strtoul()
but that would leave out important checks to make sure
that each character in the string is hexadecimal.

This series adds support for other delimiters
and lack of any delimiter to the mac_pton() function.

Tested with Openwrt on a MIPS system (ar9344).




