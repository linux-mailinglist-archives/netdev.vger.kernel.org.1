Return-Path: <netdev+bounces-97159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0AA8C99B0
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00D81C20D04
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0351CD31;
	Mon, 20 May 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDByjCIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13A1CD20;
	Mon, 20 May 2024 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193029; cv=none; b=I6K2NsE8mF9BIEjvvWz8S7yAzzenVmjINe+yH0/rJhnRUPrl+wjKwby5qAKVzX5So6Ex0xz58lsc3NGsBWq2WQqQfcbo+u/OCMegu7sAvn1//RBb0LsjKzhBByoA1FOsoHWe2DGnsPk2gjuxaBnij6o0E3XMpsqHMOXDU2mHgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193029; c=relaxed/simple;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aryjOQ9Yu/HlCGderBXeaIVLPLc7Zub0ZuSDedYrwEN3M+8Y/02g007lZvCQ8uWS3qgUCe+RJd2MPnWGPgkq5D657uEgKCzDR1OkN6ng0Fgyy6NpHAsdL40N4ra0sWt/jTAGgWoT+pCLhES7+q9d195hdvE8kCV/bTI7Tvfvr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDByjCIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E1C32789;
	Mon, 20 May 2024 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716193028;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qDByjCIUbE3VQPYSTLOsc5/m81cIewKVi/BdaSB/onZnBL76JIXXH2/91oKu6agDe
	 YQe0QyAhVGLp4L4ko+ztAfGznFthHRycvo5CYvL6oslP77DfAXn35kycD7di1gQrbo
	 jx/gyxY56bi/TbBMfLMKRZeDGvMXUpgp7qPSBVwP+ulj+Vh5JqjfEs5Ko5KUaiPe00
	 Ge5JqphKOmZZH/KUoARRqr65sDrMmLSKId6Uhs/Yntc4Ox1o3/E0+II/PhTWCPzuhr
	 ktEdkqxGgSTDak4McedKpX+3DodVtIDXzdTnIm0YS7cLWm42pnj0/sfsb8eDu8t8Xe
	 rZ0hJO0J0zEHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 May 2024 10:16:40 +0200
Subject: [PATCH net 1/3] doc: mptcp: add missing 'available_schedulers'
 entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-upstream-net-20240520-mptcp-doc-v1-1-e3ad294382cb@kernel.org>
References: <20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org>
In-Reply-To: <20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmSwb+NBJUXiInrG2pnMi0PXYho+FsHl1vTXe0U
 lglvYxs5iCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZksG/gAKCRD2t4JPQmmg
 c29ZD/0egHdO5nzQbogETrEz70f9W4t6nMXYznkP3a4mWjjnuKQqJ6wc3pOS2JEYa3Qbkc0PQRa
 Ps3Lg++2gHP8NSkIilMwH4OszC+cJjKkCcMfG4jAVorInSlaoG0L+TP+hXgNp8egiCzcJgWT8uC
 xRdkSzFsw11F1FTtotPqnc3dCT5J9lkJKFjfB0rKFCNjs6rvzzINRYjKtErwHBOR4P+SObisn02
 /yCRxpYMeG2NmlKFwf/B1gKCMo0eibL2/X77ySRekPgcfnjfS+kTLom5tTsPO2HATHXbuOlUCfD
 eJ8PID+G8hKFUanZ6+9v+DbcSgP7TRxZTrwpE9qbh+ZEhEtVuopnE6NxezAOeYXVHD2y6bZWSwt
 PHdvTJL9V4ki4P/M1XqJNTwvO7oKjcAJpm3zZ+J6Aco4xiYFdE+KDTux+xdCqClt0MERam5uIZe
 vjQmMCcgD4Xwo7J2J/lbRZvCcORMl7RBjlPuhCbzp5XFVfjpoLWviHz7h4l9ZNxaJ97pcUiCWTC
 ifPSfCrdUbMcjOh5zLE1Fmo89UGzHQmdDzI013oPZDvCHcJ+XgXx+LKm7YGhdjGQD62w594jLHk
 Q4Oiuah6sjj3TrXLFOSV4kMnGmd0Vx5G52DCxykBn985agcFHYYOhJKNOo0R3ZxpXeGoFxnGsxf
 QiJNyQr2cLpNSkQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl knob has been added recently, but the documentation has not
been updated.

This knob is used to show the available schedulers choices that are
registered, similar to 'net.ipv4.tcp_available_congestion_control'.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 69975ce25a02..102a45e7bfa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -93,3 +93,7 @@ scheduler - STRING
 	sysctl.
 
 	Default: "default"
+
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.

-- 
2.43.0


