Return-Path: <netdev+bounces-47091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BD7E7BEB
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A12810F5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591E118648;
	Fri, 10 Nov 2023 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC1774A
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:45:12 +0000 (UTC)
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45894311A9
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:45:12 -0800 (PST)
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id EFDE37D06C;
	Fri, 10 Nov 2023 11:38:34 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: [RFC ipsec-next] Add IP-TFS mode to xfrm
Date: Fri, 10 Nov 2023 06:37:11 -0500
Message-ID: <20231110113719.3055788-1-chopps@chopps.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
(AggFrag encapsulation) has been standardized in RFC9347.

Link: https://www.rfc-editor.org/rfc/rfc9347.txt

In order to allow loading this fucntionality as a module a set of callbacks
xfrm_mode_cbs has been added to xfrm as well.

