Return-Path: <netdev+bounces-35061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6B7A6BC4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514CE1C20AAF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AC347A5;
	Tue, 19 Sep 2023 19:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312E30F9F;
	Tue, 19 Sep 2023 19:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E3C433C9;
	Tue, 19 Sep 2023 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695152961;
	bh=78m0JWMacYhDaUEQ9po0CBZVx698qpbQhPU45abh+aA=;
	h=Subject:From:To:Cc:Date:From;
	b=A2DGxMicyZ2zE5qK04PvCsaLHEELgaIc98Ogmox2ugcnJPUsCj4Dv9lDhMYdiI1Rs
	 /pZXz/ihoakOYS2cX3S9NOjxrYVSu5WwUm/Uydf2E8jpJShGpaRYXF3NKOs3B7D+s1
	 iXGwugyI2gWF0647TG66U88A3zqRGT7ZNCBsE7YMbs3OKUxmMqORA5xKN/h6IrzwqG
	 8k69G9rNkv26WRZTDitt5A5vdTuH2y2BEVWPXZIlNIPZ8hXLudiX/1RfOeL52Lhx9f
	 GnUGjllLXmkKbfSR9vqUe52h+X0CLyNwWtzKNNCWZfLo0RMx+bieeP2epd9L4/Hgha
	 U2eRAYxe8lzVQ==
Subject: [PATCH v1 0/2] Fix implicit sign conversions in handshake upcall
From: Chuck Lever <cel@kernel.org>
To: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 19 Sep 2023 15:49:09 -0400
Message-ID: 
 <169515283988.5349.4586265020008671093.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

An internal static analysis tool noticed some implicit sign
conversions for some of the arguments in the handshake upcall
protocol.

---

Chuck Lever (2):
      handshake: Fix sign of socket file descriptor fields
      handshake: Fix sign of key_serial_t fields


 Documentation/netlink/specs/handshake.yaml |  8 ++++----
 net/handshake/genl.c                       |  2 +-
 net/handshake/netlink.c                    |  2 +-
 net/handshake/tlshd.c                      |  6 +++---
 tools/net/ynl/generated/handshake-user.h   | 10 +++++-----
 5 files changed, 14 insertions(+), 14 deletions(-)

--
Chuck Lever


