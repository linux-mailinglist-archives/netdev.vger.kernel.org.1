Return-Path: <netdev+bounces-242866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B367C9594C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080C44E0298
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33411156230;
	Mon,  1 Dec 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KkvQpx+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEB13E02A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556136; cv=none; b=dhLMhRco+hOXcxFl3IToXRT6v3lhRQmaoD6B5XN6VPR8Gyv29yVkURvAKQELURYnS8UIli4f77XsafDOwjwS8o2Cucai8L0tlOFy7lnh0qeFjMwQ+4uY3UyyaNQawvMIsqxZl/flaeLt0zyAVJRd5Y0G56Apcx8hb3OTI3N23yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556136; c=relaxed/simple;
	bh=FZyQhs5GiPMbtl8RRpLipm4lWJZUyDB1L12Us1b/4r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DF8PmPNEtNvq4/+yDNl1vK8v4AFZgNeR3dXYNo/qX+rK9T0LuYj7/q22sU7ThsPfoOSDG/Eq3YSwVZsGPIdIv1G9URjPpapZ5ZsBJdjbisgsMqlRO0kZYyc/ZO30I5w+nJKWPVrFga8L4OO+VCHDWlC1e7Wna9fggiNs78CdjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KkvQpx+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD269C4CEFB;
	Mon,  1 Dec 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KkvQpx+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R3ud4046NB1VcEvQ+Xmq1Vks+tTFRItPyegH8J4W33c=;
	b=KkvQpx+4kRt5irF3aemiMVcKH6//B9YbCtq1WouIBtkL+jVJXGG12rKVYqhSQzUWzzYvcl
	OzvZwBniVBp8bDPk4GNGh1Tk9DxKxiL3V0vr8Cfg67ljTiwBDqOIPfJcOqpj1WL9+QxTTM
	MeqJMFkwi5zUiX/Et0wWI5JeTnGUYvc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21ca5519 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:28:52 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 00/11] wireguard updates for 6.19
Date: Mon,  1 Dec 2025 03:28:38 +0100
Message-ID: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

Please find here Asbjørn's yml series. This has been sitting in my
testing for the last week or so, since he sent out the latest series,
and I haven't found any issues so far. Please pull!

Regards,
Jason

Asbjørn Sloth Tønnesen (11):
  wireguard: netlink: enable strict genetlink validation
  wireguard: netlink: validate nested arrays in policy
  wireguard: netlink: use WG_KEY_LEN in policies
  wireguard: netlink: convert to split ops
  wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
  netlink: specs: add specification for wireguard
  wireguard: uapi: move enum wg_cmd
  wireguard: uapi: move flag enums
  wireguard: uapi: generate header with ynl-gen
  tools: ynl: add sample for wireguard
  wireguard: netlink: generate netlink code

 Documentation/netlink/specs/wireguard.yaml | 298 +++++++++++++++++++++
 MAINTAINERS                                |   2 +
 drivers/net/wireguard/Makefile             |   2 +-
 drivers/net/wireguard/generated/netlink.c  |  73 +++++
 drivers/net/wireguard/generated/netlink.h  |  30 +++
 drivers/net/wireguard/netlink.c            |  68 +----
 include/uapi/linux/wireguard.h             | 191 +++----------
 tools/net/ynl/Makefile.deps                |   2 +
 tools/net/ynl/samples/.gitignore           |   1 +
 tools/net/ynl/samples/wireguard.c          | 104 +++++++
 10 files changed, 556 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 drivers/net/wireguard/generated/netlink.c
 create mode 100644 drivers/net/wireguard/generated/netlink.h
 create mode 100644 tools/net/ynl/samples/wireguard.c

-- 
2.52.0


