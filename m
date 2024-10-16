Return-Path: <netdev+bounces-136185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A79A0D74
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F74B278F1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18805208D9A;
	Wed, 16 Oct 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbybtT4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF854720;
	Wed, 16 Oct 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090577; cv=none; b=nrlLrU6ZyqL2CStFs2ZL91J1UUcLkDIDVkWh6YiqU2Uca6eCGtXj7+QmW8fIgfJGTIfktN5KKQ/TJTr32IKc47W7FahGgR+qvFMWZelhb1PU60N+DeQYseyp13xY/LdbzwbiNg5vosj0pi+B4iZPKM5EtrnfgmYWIDn2os66cP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090577; c=relaxed/simple;
	bh=/Txg4GO9QuIPp32B0hN8VEiUxRPsJxN+oMvyvV8BJDs=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ly0Ox9sqLKsswdqrL+CjuvOlBkQka/0AQ2ocCzpzkRfGWHuBgVKcORTYX0jIw8ISjLLUNH6KYeavqUfBsdWvEyBgWupVoRUWA2+dEIAbycfU7zh4ep/dhyTF375OEyvjCnQ2u8+MQCN5t7mfsd6UI43A1sm88G2zBtAL2+zkarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbybtT4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259AC4CEC5;
	Wed, 16 Oct 2024 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090576;
	bh=/Txg4GO9QuIPp32B0hN8VEiUxRPsJxN+oMvyvV8BJDs=;
	h=Subject:From:To:Cc:Date:From;
	b=EbybtT4HCNzqZtq8L0iZK5f14OY6oUdDqeZ89iq2ZS2uAkV/9T1ssG8nixs/BsVRQ
	 7RFX4nyffuEdpoNIjPAr0DAFzRdSCGkR/s/S+YDz9e0gby3agMT09aDGz4US6dW94H
	 GD5K1Bd0v4voaPZe5bP0JvlfHyMMyB84GxVAZVqxJataUIwfdHe1zqhZq35T+a+dux
	 K5dSpAFL0u5DGBbEPQGicwOxY3hVFmIj5edvkmkh+mpeIGGHG88VMpCIaCZZxiYbaG
	 vZ6kMLnW/b0vJjU3njbHn2+e9YOZe7l/robikh82I55utYMvYlIadJfpoSqpWvHBxe
	 WZY0ipYMxv1Gg==
Subject: [PATCH net-next] mailmap: update entry for Jesper Dangaard Brouer
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2024 16:56:13 +0200
Message-ID: <172909057364.2452383.8019986488234344607.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Mapping all my previously used emails to my kernel.org email.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 .mailmap |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3faaa5f400c6..8f0eccda7e41 100644
--- a/.mailmap
+++ b/.mailmap
@@ -301,6 +301,11 @@ Jens Axboe <axboe@kernel.dk> <axboe@fb.com>
 Jens Axboe <axboe@kernel.dk> <axboe@meta.com>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
+Jesper Dangaard Brouer <hawk@kernel.org> <brouer@redhat.com>
+Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
+Jesper Dangaard Brouer <hawk@kernel.org> <jbrouer@redhat.com>
+Jesper Dangaard Brouer <hawk@kernel.org> <jdb@comx.dk>
+Jesper Dangaard Brouer <hawk@kernel.org> <netoptimizer@brouer.com>
 Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
 Jilai Wang <quic_jilaiw@quicinc.com> <jilaiw@codeaurora.org>
 Jiri Kosina <jikos@kernel.org> <jikos@jikos.cz>



