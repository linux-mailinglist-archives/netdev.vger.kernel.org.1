Return-Path: <netdev+bounces-156320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A89A060DB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A983ABA60
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D1200114;
	Wed,  8 Jan 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbIejiuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F820010A
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351569; cv=none; b=SnDtugg0AKq9JyVwkDhrLKEGSCi+03141fPz7e7HZod34TgP5kxdn4SlUJADDZhZ2v3O+2bDjr79RhV63uh0dW7OBS5W5UjrBhG+2P5c2uF54cxPxxWpx5gZ5yWjMsI2nk1cDgUWHN0BQtbng4KsXWDlJuiPEe8C/eBDwtoLnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351569; c=relaxed/simple;
	bh=QhhUPBgHzohxOWhZCZsm8P5KRGnYEDFOluIN2grKBAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBPZ13BOq87Tdynx8plzYUuYRkOSON/0eLUVnERDjSiEaL47qZNFJmeyNpFqGd04U6UhwrZfdhmYb+eQaDPpgl5EthseD93N04dN1tqDzdSg9i0vV2355fL3OPLkWitJBZz6U/nJ2XNj9Dcr4KWfPNZUSpcBxoS/VaCsJ59F+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbIejiuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A132DC4CEE6;
	Wed,  8 Jan 2025 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351568;
	bh=QhhUPBgHzohxOWhZCZsm8P5KRGnYEDFOluIN2grKBAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbIejiuVeKuxjLRgFN8BishQctTAgC2BLYTsVTnI+tmwb5Y8p7X4Vrnr0nZWwn0zV
	 WjXvtR9OH+FLWt9IrhpB1hijrhTbkEcDMqfIPeEHjQkqNAatRrBzjHOoK2RQ/bP0Xv
	 HbkNPKl/HBG3qR+2Q0nJZ9/7gOiQCAkIdGTzOarEpmx+g+l2OxNDIbmqj/dwnMtR0W
	 O+fhXTywzbuvQuOXmV1r9uHn9bGNddZvJtHDATmgHTNrX+pZ+nCMhdGQu1h7eXInW2
	 LSjq8YhV+pCz1s7wGUDkXEUd8tlNlKn2bhB3uCk3g7VGp4lIuKDoPbd461FWwZqzdv
	 75xAKjMw8djEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	shayagr@amazon.com,
	darinzon@amazon.com
Subject: [PATCH net v2 7/8] MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
Date: Wed,  8 Jan 2025 07:52:41 -0800
Message-ID: <20250108155242.2575530-8-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Noam Dagan was added to ENA reviewers in 2021, we have not seen
a single email from this person to any list, ever (according to lore).
Git history mentions the name in 2 SoB tags from 2020.

Acked-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shayagr@amazon.com
CC: darinzon@amazon.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c01db3666861..694a29027b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -949,7 +949,6 @@ AMAZON ETHERNET DRIVERS
 M:	Shay Agroskin <shayagr@amazon.com>
 M:	Arthur Kiyanovski <akiyano@amazon.com>
 R:	David Arinzon <darinzon@amazon.com>
-R:	Noam Dagan <ndagan@amazon.com>
 R:	Saeed Bishara <saeedb@amazon.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.47.1


